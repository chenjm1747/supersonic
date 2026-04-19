package com.tencent.supersonic.headless.chat.parser.llm;

import com.google.gson.JsonSyntaxException;
import com.tencent.supersonic.common.pojo.ChatModelConfig;
import com.tencent.supersonic.common.util.ContextUtils;
import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.parser.SemanticParser;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMReq;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMResp;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMSqlResp;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.MapUtils;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Objects;

/**
 * LLMSqlParser uses large language model to understand query semantics and generate S2SQL
 * statements to be executed by the semantic query engine.
 */
@Slf4j
public class LLMSqlParser implements SemanticParser {

    private static final String ERR_MSG_JSON_PARSE_FAILED = "LLM返回格式解析失败，请尝试换一种方式提问";
    private static final String ERR_MSG_LLM_TIMEOUT = "LLM服务响应超时，请稍后重试";
    private static final String ERR_MSG_LLM_UNKNOWN = "LLM服务调用失败，请稍后重试";

    @Override
    public void parse(ChatQueryContext queryCtx) {
        try {
            if (!queryCtx.getRequest().getText2SQLType().enableLLM()) {
                return;
            }
            LLMRequestService requestService = ContextUtils.getBean(LLMRequestService.class);
            Long dataSetId = requestService.getDataSetId(queryCtx);
            if (dataSetId == null) {
                return;
            }
            log.info("try generating query statement for query:{}, dataSetId:{}",
                    queryCtx.getRequest().getQueryText(), dataSetId);

            tryParse(queryCtx, dataSetId);
        } catch (Exception e) {
            log.error("failed to parse query:", e);
            setUserFriendlyErrorMsg(queryCtx, e);
        }
    }

    private void setUserFriendlyErrorMsg(ChatQueryContext queryCtx, Exception e) {
        String errMsg;
        if (e instanceof JsonSyntaxException || e.getCause() instanceof JsonSyntaxException) {
            errMsg = ERR_MSG_JSON_PARSE_FAILED;
        } else if (e.getMessage() != null && e.getMessage().contains("timeout")) {
            errMsg = ERR_MSG_LLM_TIMEOUT;
        } else {
            errMsg = ERR_MSG_LLM_UNKNOWN;
        }
        queryCtx.getParseResp().setErrorMsg(errMsg);
    }

    private void tryParse(ChatQueryContext queryCtx, Long dataSetId) {
        LLMRequestService requestService = ContextUtils.getBean(LLMRequestService.class);
        LLMResponseService responseService = ContextUtils.getBean(LLMResponseService.class);
        int maxRetries = ContextUtils.getBean(LLMParserConfig.class).getRecallMaxRetries();

        LLMReq llmReq = requestService.getLlmReq(queryCtx, dataSetId);

        int currentRetry = 1;
        Map<String, LLMSqlResp> sqlRespMap = new HashMap<>();
        ParseResult parseResult = null;
        String lastErrorMsg = null;

        while (currentRetry <= maxRetries) {
            log.info("currentRetryRound:{}, start runText2SQL", currentRetry);
            try {
                LLMResp llmResp = requestService.runText2SQL(llmReq);
                if (Objects.nonNull(llmResp)) {
                    sqlRespMap = responseService.getDeduplicationSqlResp(currentRetry, llmResp);
                    if (MapUtils.isNotEmpty(sqlRespMap)) {
                        parseResult = ParseResult.builder().dataSetId(dataSetId).llmReq(llmReq)
                                .llmResp(llmResp).build();
                        break;
                    }
                }
            } catch (Exception e) {
                log.error("currentRetryRound:{}, runText2SQL failed", currentRetry, e);
                lastErrorMsg = getFriendlyErrorMessage(e);
            }
            ChatModelConfig chatModelConfig = llmReq.getChatAppConfig()
                    .get(OnePassSCSqlGenStrategy.APP_KEY).getChatModelConfig();
            Double temperature = chatModelConfig.getTemperature();
            if (temperature == 0) {
                chatModelConfig.setTemperature(0.5);
            }
            currentRetry++;
        }
        if (MapUtils.isEmpty(sqlRespMap)) {
            if (lastErrorMsg != null) {
                queryCtx.getParseResp().setErrorMsg(lastErrorMsg);
            }
            return;
        }
        for (Entry<String, LLMSqlResp> entry : sqlRespMap.entrySet()) {
            String sql = entry.getKey();
            double sqlWeight = entry.getValue().getSqlWeight();
            responseService.addParseInfo(queryCtx, parseResult, sql, sqlWeight);
        }
    }

    private String getFriendlyErrorMessage(Exception e) {
        if (e instanceof JsonSyntaxException || e.getCause() instanceof JsonSyntaxException) {
            return ERR_MSG_JSON_PARSE_FAILED;
        } else if (e.getMessage() != null && e.getMessage().toLowerCase().contains("timeout")) {
            return ERR_MSG_LLM_TIMEOUT;
        } else {
            return ERR_MSG_LLM_UNKNOWN + "：" + e.getClass().getSimpleName();
        }
    }
}
