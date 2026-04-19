package com.tencent.supersonic.chat.server.rest;

import com.tencent.supersonic.auth.api.authentication.utils.UserHolder;
import com.tencent.supersonic.chat.api.pojo.request.ChatExecuteReq;
import com.tencent.supersonic.chat.api.pojo.request.ChatParseReq;
import com.tencent.supersonic.chat.api.pojo.request.ChatQueryDataReq;
import com.tencent.supersonic.chat.api.pojo.response.ChatParseResp;
import com.tencent.supersonic.chat.api.pojo.response.QueryResult;
import com.tencent.supersonic.chat.server.service.ChatQueryService;
import com.tencent.supersonic.common.pojo.User;
import com.tencent.supersonic.common.pojo.exception.InvalidArgumentException;
import com.tencent.supersonic.headless.api.pojo.SemanticParseInfo;
import com.tencent.supersonic.headless.api.pojo.request.DimensionValueReq;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/** query controller */
@Slf4j
@RestController
@RequestMapping({"/api/chat/query", "/openapi/chat/query"})
public class ChatQueryController {

    @Autowired
    private ChatQueryService chatQueryService;

    @PostMapping("search")
    public Object search(@RequestBody ChatParseReq chatParseReq, HttpServletRequest request,
            HttpServletResponse response) {
        log.info("[对话查询] search 开始 | queryText:{} | chatId:{}", chatParseReq.getQueryText(),
                chatParseReq.getChatId());
        Object result = chatQueryService.search(chatParseReq);
        log.info("[对话查询] search 结束 | queryText:{} | resultSize:{}", chatParseReq.getQueryText(),
                result != null ? "有结果" : "无结果");
        return result;
    }

    @PostMapping("parse")
    public Object parse(@RequestBody ChatParseReq chatParseReq, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        chatParseReq.setUser(UserHolder.findUser(request, response));
        log.info("[对话查询] parse 开始 | queryText:{} | chatId:{}", chatParseReq.getQueryText(),
                chatParseReq.getChatId());
        Object result = chatQueryService.parse(chatParseReq);
        log.info("[对话查询] parse 结束 | queryText:{} | result:{}", chatParseReq.getQueryText(),
                result != null ? "有结果" : "无结果");
        return result;
    }

    @PostMapping("execute")
    public Object execute(@RequestBody ChatExecuteReq chatExecuteReq, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        chatExecuteReq.setUser(UserHolder.findUser(request, response));
        log.info("[对话查询] execute 开始 | queryId:{} | parseId:{}", chatExecuteReq.getQueryId(),
                chatExecuteReq.getParseId());
        Object result = chatQueryService.execute(chatExecuteReq);
        log.info("[对话查询] execute 结束 | queryId:{} | result:{}", chatExecuteReq.getQueryId(),
                result != null ? "有结果" : "无结果");
        return result;
    }

    @PostMapping("getExecuteSummary")
    public Object getExecuteSummary(@RequestBody ChatExecuteReq chatExecuteReq,
            HttpServletRequest request, HttpServletResponse response) {
        log.info("[对话查询] getExecuteSummary 开始 | queryId:{}", chatExecuteReq.getQueryId());
        QueryResult res = chatQueryService.getTextSummary(chatExecuteReq);
        log.info("[对话查询] getExecuteSummary 结束 | queryId:{}", chatExecuteReq.getQueryId());
        return res;
    }

    @PostMapping("/")
    public Object query(@RequestBody ChatParseReq chatParseReq, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        User user = UserHolder.findUser(request, response);
        chatParseReq.setUser(user);
        log.info("[对话查询] query 开始 | queryText:{} | chatId:{} | user:{}",
                chatParseReq.getQueryText(), chatParseReq.getChatId(),
                user != null ? user.getName() : "null");

        ChatParseResp parseResp = chatQueryService.parse(chatParseReq);
        log.info("[对话查询] parse阶段结束 | queryText:{} | parseState:{} | selectedParsesSize:{}",
                chatParseReq.getQueryText(), parseResp != null ? parseResp.getState() : "null",
                parseResp != null ? parseResp.getSelectedParses().size() : 0);

        if (CollectionUtils.isEmpty(parseResp.getSelectedParses())) {
            log.error("[对话查询] parse失败，无可用解析结果 | queryText:{}", chatParseReq.getQueryText());
            throw new InvalidArgumentException("parser error,no selectedParses");
        }
        SemanticParseInfo semanticParseInfo = parseResp.getSelectedParses().get(0);
        String sqlLog = semanticParseInfo.getSqlInfo() != null
                ? semanticParseInfo.getSqlInfo().getCorrectedS2SQL()
                : "null";
        log.info("[对话查询] 选中解析 | parseId:{} | sql:{}", semanticParseInfo.getId(), sqlLog);

        ChatExecuteReq chatExecuteReq = ChatExecuteReq.builder().build();
        BeanUtils.copyProperties(chatParseReq, chatExecuteReq);
        chatExecuteReq.setQueryId(parseResp.getQueryId());
        chatExecuteReq.setParseId(semanticParseInfo.getId());

        log.info("[对话查询] execute阶段开始 | queryId:{} | parseId:{}", chatExecuteReq.getQueryId(),
                chatExecuteReq.getParseId());
        QueryResult result = chatQueryService.execute(chatExecuteReq);
        log.info("[对话查询] query 结束 | queryText:{} | result:{}", chatParseReq.getQueryText(),
                result != null ? "有结果" : "无结果");
        return result;
    }

    @PostMapping("queryData")
    public Object queryData(@RequestBody ChatQueryDataReq chatQueryDataReq,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        chatQueryDataReq.setUser(UserHolder.findUser(request, response));
        return chatQueryService.queryData(chatQueryDataReq, UserHolder.findUser(request, response));
    }

    @PostMapping("queryDimensionValue")
    public Object queryDimensionValue(@RequestBody @Valid DimensionValueReq dimensionValueReq,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        return chatQueryService.queryDimensionValue(dimensionValueReq,
                UserHolder.findUser(request, response));
    }
}
