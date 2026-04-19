package com.tencent.supersonic.headless.chat.parser.llm;

import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@Slf4j
public class WikiContextBuilder {

    public static final String CARD_TYPE_SEMANTIC_MAPPING = "SEMANTIC_MAPPING";
    public static final String CARD_TYPE_BUSINESS_RULE = "BUSINESS_RULE";
    public static final String CARD_TYPE_USAGE_PATTERN = "USAGE_PATTERN";
    public static final String CARD_TYPE_METRIC_DEFINITION = "METRIC_DEFINITION";

    public String buildContext(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder context = new StringBuilder();

        String semanticMappings = buildSemanticMappings(
                cards.stream().filter(c -> CARD_TYPE_SEMANTIC_MAPPING.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!semanticMappings.isEmpty()) {
            context.append("\n## Wiki 语义映射 (Semantic Mappings)\n");
            context.append("以下业务术语对应数据库字段：\n");
            context.append(semanticMappings);
        }

        String businessRules = buildBusinessRules(
                cards.stream().filter(c -> CARD_TYPE_BUSINESS_RULE.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!businessRules.isEmpty()) {
            context.append("\n## Wiki 业务规则 (Business Rules)\n");
            context.append(businessRules);
        }

        String usagePatterns = buildUsagePatterns(
                cards.stream().filter(c -> CARD_TYPE_USAGE_PATTERN.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!usagePatterns.isEmpty()) {
            context.append("\n## Wiki 使用模式 (Usage Patterns)\n");
            context.append(usagePatterns);
        }

        String metricDefinitions = buildMetricDefinitions(
                cards.stream().filter(c -> CARD_TYPE_METRIC_DEFINITION.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!metricDefinitions.isEmpty()) {
            context.append("\n## Wiki 指标定义 (Metric Definitions)\n");
            context.append(metricDefinitions);
        }

        return context.toString();
    }

    public String buildSemanticMappings(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }

    public String buildBusinessRules(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }

    public String buildUsagePatterns(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }

    public String buildMetricDefinitions(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }
}
