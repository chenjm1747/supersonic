package com.tencent.supersonic.chat.server.executor;

import com.tencent.supersonic.chat.api.pojo.enums.MemoryStatus;
import com.tencent.supersonic.chat.api.pojo.response.QueryResult;
import com.tencent.supersonic.chat.server.pojo.ChatContext;
import com.tencent.supersonic.chat.server.pojo.ChatMemory;
import com.tencent.supersonic.chat.server.pojo.ExecuteContext;
import com.tencent.supersonic.chat.server.service.ChatContextService;
import com.tencent.supersonic.chat.server.service.MemoryService;
import com.tencent.supersonic.chat.server.util.ResultFormatter;
import com.tencent.supersonic.common.pojo.Text2SQLExemplar;
import com.tencent.supersonic.common.util.ContextUtils;
import com.tencent.supersonic.common.util.JsonUtil;
import com.tencent.supersonic.headless.api.pojo.SemanticParseInfo;
import com.tencent.supersonic.headless.api.pojo.request.QuerySqlReq;
import com.tencent.supersonic.headless.api.pojo.response.QueryState;
import com.tencent.supersonic.headless.api.pojo.response.SemanticQueryResp;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMSqlQuery;
import com.tencent.supersonic.headless.server.facade.service.SemanticLayerService;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;
import java.util.Objects;

@Slf4j
public class SqlExecutor implements ChatQueryExecutor {

    private static final Logger keyPipelineLog = LoggerFactory.getLogger("keyPipeline");

    @Override
    public boolean accept(ExecuteContext executeContext) {
        return true;
    }

    @SneakyThrows
    @Override
    public QueryResult execute(ExecuteContext executeContext) {
        keyPipelineLog.info("[Execute] SqlExecutor开始 | queryId:{} | parseId:{}",
                executeContext.getRequest().getQueryId(),
                executeContext.getParseInfo() != null ? executeContext.getParseInfo().getId()
                        : "null");

        QueryResult queryResult = doExecute(executeContext);

        if (queryResult != null) {
            keyPipelineLog.info(
                    "[Execute] SQL执行完成 | queryId:{} | queryState:{} | resultCount:{} | sql:{}",
                    queryResult.getQueryId(), queryResult.getQueryState(),
                    queryResult.getQueryResults() != null ? queryResult.getQueryResults().size()
                            : 0,
                    queryResult.getQuerySql());

            String textResult = ResultFormatter.transform2TextNew(queryResult.getQueryColumns(),
                    queryResult.getQueryResults());
            queryResult.setTextResult(textResult);

            if (queryResult.getQueryState().equals(QueryState.SUCCESS)
                    && queryResult.getQueryMode().equals(LLMSqlQuery.QUERY_MODE)) {
                Text2SQLExemplar exemplar =
                        JsonUtil.toObject(
                                JsonUtil.toString(executeContext.getParseInfo().getProperties()
                                        .get(Text2SQLExemplar.PROPERTY_KEY)),
                                Text2SQLExemplar.class);

                MemoryService memoryService = ContextUtils.getBean(MemoryService.class);
                memoryService.createMemory(ChatMemory.builder().queryId(queryResult.getQueryId())
                        .agentId(executeContext.getAgent().getId()).status(MemoryStatus.PENDING)
                        .question(exemplar.getQuestion()).sideInfo(exemplar.getSideInfo())
                        .dbSchema(exemplar.getDbSchema()).s2sql(exemplar.getSql())
                        .createdBy(executeContext.getRequest().getUser().getName())
                        .updatedBy(executeContext.getRequest().getUser().getName())
                        .createdAt(new Date()).build());
            }
        } else {
            keyPipelineLog.error("[Execute] SQL执行返回null | queryId:{}",
                    executeContext.getRequest().getQueryId());
        }

        return queryResult;
    }

    @SneakyThrows
    private QueryResult doExecute(ExecuteContext executeContext) {
        keyPipelineLog.info("[Execute->SQL] 开始执行SQL查询 | queryId:{}",
                executeContext.getRequest().getQueryId());

        SemanticLayerService semanticLayer = ContextUtils.getBean(SemanticLayerService.class);
        ChatContextService chatContextService = ContextUtils.getBean(ChatContextService.class);

        ChatContext chatCtx =
                chatContextService.getOrCreateContext(executeContext.getRequest().getChatId());
        SemanticParseInfo parseInfo = executeContext.getParseInfo();
        if (Objects.isNull(parseInfo.getSqlInfo())
                || StringUtils.isBlank(parseInfo.getSqlInfo().getCorrectedS2SQL())) {
            keyPipelineLog.error("[Execute->SQL] parseInfo或sql为空 | queryId:{}",
                    executeContext.getRequest().getQueryId());
            return null;
        }

        // 使用querySQL，它已经包含了所有修正（包括物理SQL修正）
        String finalSql = StringUtils.isNotBlank(parseInfo.getSqlInfo().getQuerySQL())
                ? parseInfo.getSqlInfo().getQuerySQL()
                : parseInfo.getSqlInfo().getCorrectedS2SQL();

        keyPipelineLog.info("[Execute->SQL] 最终SQL | sql:{}", finalSql);

        QuerySqlReq sqlReq = QuerySqlReq.builder().sql(finalSql).build();
        sqlReq.setSqlInfo(parseInfo.getSqlInfo());
        sqlReq.setDataSetId(parseInfo.getDataSetId());

        long startTime = System.currentTimeMillis();
        QueryResult queryResult = new QueryResult();
        queryResult.setQueryId(executeContext.getRequest().getQueryId());
        queryResult.setChatContext(parseInfo);
        queryResult.setQueryMode(parseInfo.getQueryMode());

        keyPipelineLog.info("[Execute->SQL] 调用SemanticLayerService.queryByReq");
        SemanticQueryResp queryResp =
                semanticLayer.queryByReq(sqlReq, executeContext.getRequest().getUser());
        queryResult.setQueryTimeCost(System.currentTimeMillis() - startTime);

        if (queryResp != null) {
            keyPipelineLog.info("[Execute->SQL] 查询成功 | queryId:{} | timeCost:{}ms | resultSize:{}",
                    queryResult.getQueryId(), queryResult.getQueryTimeCost(),
                    queryResp.getResultList() != null ? queryResp.getResultList().size() : 0);

            queryResult.setQueryAuthorization(queryResp.getQueryAuthorization());
            queryResult.setQuerySql(finalSql);
            queryResult.setQueryResults(queryResp.getResultList());
            queryResult.setQueryColumns(queryResp.getColumns());
            queryResult.setQueryState(QueryState.SUCCESS);
            queryResult.setErrorMsg(queryResp.getErrorMsg());
            chatCtx.setParseInfo(parseInfo);
            chatContextService.updateContext(chatCtx);
        } else {
            keyPipelineLog.error("[Execute->SQL] 查询返回null | queryId:{}", queryResult.getQueryId());
            queryResult.setQueryState(QueryState.INVALID);
        }

        return queryResult;
    }
}
