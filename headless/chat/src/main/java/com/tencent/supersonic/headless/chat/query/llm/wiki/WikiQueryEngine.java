package com.tencent.supersonic.headless.chat.query.llm.wiki;

import com.tencent.supersonic.headless.chat.parser.llm.LLMRequestService;
import com.tencent.supersonic.headless.chat.server.executor.SqlExecutor;
import com.tencent.supersonic.headless.core.wiki.dto.ConversationContext;
import com.tencent.supersonic.headless.core.wiki.service.ConversationContextService;
import com.tencent.supersonic.headless.core.wiki.service.SelfEnhancementService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class WikiQueryEngine {
    private final IntentDetector intentDetector;
    private final WikiRetriever wikiRetriever;
    private final KnowledgeAssembler knowledgeAssembler;
    private final LLMRequestService llmRequestService;
    private final SqlExecutor sqlExecutor;
    private final SelfEnhancementService selfEnhancementService;
    private final ConversationContextService contextService;

    public QueryResult process(QueryRequest request) {
        log.info("WikiQueryEngine processing query: {}", request.getQueryText());

        // 1. 意图识别
        IntentDetector.Intent intent = intentDetector.detect(request);
        log.info("Detected intent: {}", intent.getType());

        // 2. 上下文恢复
        ConversationContext ctx = null;
        if (request.getConversationId() != null) {
            ctx = contextService.restore(request.getConversationId());
        }

        // 3. Wiki 检索
        WikiRetrievalResult retrieval = wikiRetriever.retrieve(request, intent);
        log.info("Retrieved {} knowledge cards", retrieval.getKnowledgeCards() != null
            ? retrieval.getKnowledgeCards().size() : 0);

        // 4. 上下文组装
        String wikiContext = knowledgeAssembler.assemble(retrieval, intent);

        // 5. SQL 生成
        String sql = llmRequestService.generateSql(request.getQueryText(), wikiContext, ctx);
        log.info("Generated SQL: {}", sql);

        // 6. SQL 验证
        ValidationResult validation = sqlExecutor.validate(sql);

        // 7. 自增强反馈
        if (validation.isValid()) {
            selfEnhancementService.onSqlSuccess(sql, retrieval.getRelatedEntityIds());
        } else {
            selfEnhancementService.onSqlFailure(sql, validation.getErrorMsg(),
                retrieval.getRelatedEntityIds());
        }

        // 8. 上下文持久化
        if (request.getConversationId() != null) {
            contextService.save(sql, validation, retrieval, ctx, request);
        }

        return new QueryResult(sql, validation, retrieval);
    }
}
