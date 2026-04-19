package com.tencent.supersonic.headless.chat.parser.llm;

import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.parser.SemanticParser;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMReq;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.WikiLLMReq;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * WikiAwareLLMSqlParser uses large language model to understand query semantics and generate SQL
 * statements, with enhanced context from Wiki knowledge base.
 */
@Slf4j
@Component
public class WikiAwareLLMSqlParser implements SemanticParser {

    @Autowired
    private LLMRequestService requestService;

    @Autowired
    private WikiContextBuilder wikiContextBuilder;

    @Override
    public void parse(ChatQueryContext queryCtx) {
        try {
            if (!isWikiEnabled(queryCtx)) {
                log.debug("[WikiAwareLLMSqlParser] Wiki integration disabled, skipping");
                return;
            }

            WikiLLMReq wikiLlmReq = buildWikiLlmReq(queryCtx);

            String wikiContext = wikiContextBuilder.buildContext(wikiLlmReq.getKnowledgeCards());

            injectWikiContext(queryCtx, wikiContext);

            log.info("[WikiAwareLLMSqlParser] Wiki context injected, length: {}",
                    wikiContext != null ? wikiContext.length() : 0);

        } catch (Exception e) {
            log.error("[WikiAwareLLMSqlParser] Failed to process Wiki context", e);
        }
    }

    private boolean isWikiEnabled(ChatQueryContext queryCtx) {
        return queryCtx.getWikiEntities() != null && !queryCtx.getWikiEntities().isEmpty();
    }

    private WikiLLMReq buildWikiLlmReq(ChatQueryContext queryCtx) {
        WikiLLMReq.WikiLLMReqBuilder builder = WikiLLMReq.builder();

        if (queryCtx.getWikiKnowledgeCards() != null) {
            builder.knowledgeCards(queryCtx.getWikiKnowledgeCards());

            builder.businessRules(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "BUSINESS_RULE".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));

            builder.usagePatterns(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "USAGE_PATTERN".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));

            builder.metricDefinitions(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "METRIC_DEFINITION".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));

            builder.semanticMappings(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "SEMANTIC_MAPPING".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));
        }

        if (queryCtx.getWikiEntities() != null) {
            builder.relatedEntities(queryCtx.getWikiEntities());
        }

        return builder.build();
    }

    private void injectWikiContext(ChatQueryContext queryCtx, String wikiContext) {
        if (wikiContext != null && !wikiContext.isEmpty()) {
            queryCtx.setWikiContext(wikiContext);
        }
    }
}
