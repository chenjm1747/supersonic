package com.tencent.supersonic.headless.chat.query.llm.wiki;

import com.tencent.supersonic.headless.chat.parser.llm.MetaEmbeddingService;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiKnowledgeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
@RequiredArgsConstructor
public class WikiRetriever {
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService entityService;
    private final MetaEmbeddingService metaEmbeddingService;

    public WikiRetrievalResult retrieve(QueryRequest request, IntentDetector.Intent intent) {
        WikiRetrievalResult result = new WikiRetrievalResult();

        try {
            // 向量检索
            float[] queryEmbedding = metaEmbeddingService.getEmbedding(request.getQueryText());
            List<WikiKnowledgeCard> cards = knowledgeService.searchByEmbedding(queryEmbedding, 10);
            result.setKnowledgeCards(cards);

            // 按类型分类
            result.setSemanticMappings(filterByType(cards, "SEMANTIC_MAPPING"));
            result.setBusinessRules(filterByTypeBusinessRule(cards));
            result.setUsagePatterns(filterByTypeUsagePattern(cards));
            result.setMetricDefinitions(filterByTypeMetricDefinition(cards));

            // 获取相关实体
            List<String> relatedEntityIds = new ArrayList<>();
            for (WikiKnowledgeCard card : cards) {
                if (!relatedEntityIds.contains(card.getEntityId())) {
                    relatedEntityIds.add(card.getEntityId());
                }
            }
            result.setRelatedEntityIds(relatedEntityIds);

            // 获取实体详情
            List<WikiEntity> entities = new ArrayList<>();
            for (String entityId : relatedEntityIds) {
                WikiEntity entity = entityService.getEntityById(entityId);
                if (entity != null) {
                    entities.add(entity);
                }
            }
            result.setEntities(entities);

        } catch (Exception e) {
            log.error("Error retrieving wiki knowledge", e);
        }

        return result;
    }

    private List<WikiRetrievalResult.SemanticMapping> filterByType(List<WikiKnowledgeCard> cards, String type) {
        List<WikiRetrievalResult.SemanticMapping> results = new ArrayList<>();
        for (WikiKnowledgeCard card : cards) {
            if (type.equals(card.getCardType())) {
                try {
                    WikiRetrievalResult.SemanticMapping mapping =
                        new WikiRetrievalResult.SemanticMapping();
                    // Parse content JSON to extract fields
                    mapping.setTerm(card.getTitle());
                    mapping.setField(card.getContent());
                    results.add(mapping);
                } catch (Exception e) {
                    log.warn("Failed to parse semantic mapping card: {}", card.getCardId());
                }
            }
        }
        return results;
    }

    private List<WikiRetrievalResult.BusinessRule> filterByTypeBusinessRule(List<WikiKnowledgeCard> cards) {
        List<WikiRetrievalResult.BusinessRule> results = new ArrayList<>();
        for (WikiKnowledgeCard card : cards) {
            if ("BUSINESS_RULE".equals(card.getCardType())) {
                try {
                    WikiRetrievalResult.BusinessRule rule = new WikiRetrievalResult.BusinessRule();
                    rule.setMeaning(card.getTitle());
                    rule.setCondition(card.getContent());
                    results.add(rule);
                } catch (Exception e) {
                    log.warn("Failed to parse business rule card: {}", card.getCardId());
                }
            }
        }
        return results;
    }

    private List<WikiRetrievalResult.UsagePattern> filterByTypeUsagePattern(List<WikiKnowledgeCard> cards) {
        List<WikiRetrievalResult.UsagePattern> results = new ArrayList<>();
        for (WikiKnowledgeCard card : cards) {
            if ("USAGE_PATTERN".equals(card.getCardType())) {
                WikiRetrievalResult.UsagePattern pattern = new WikiRetrievalResult.UsagePattern();
                pattern.setName(card.getTitle());
                pattern.setPattern(card.getContent());
                results.add(pattern);
            }
        }
        return results;
    }

    private List<WikiRetrievalResult.MetricDefinition> filterByTypeMetricDefinition(List<WikiKnowledgeCard> cards) {
        List<WikiRetrievalResult.MetricDefinition> results = new ArrayList<>();
        for (WikiKnowledgeCard card : cards) {
            if ("METRIC_DEFINITION".equals(card.getCardType())) {
                WikiRetrievalResult.MetricDefinition metric = new WikiRetrievalResult.MetricDefinition();
                metric.setMetric(card.getTitle());
                metric.setFormula(card.getContent());
                results.add(metric);
            }
        }
        return results;
    }
}
