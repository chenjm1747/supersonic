package com.tencent.supersonic.headless.chat.query.llm.wiki;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.Data;

import java.util.List;

@Data
public class WikiRetrievalResult {
    private List<WikiEntity> entities;
    private List<WikiKnowledgeCard> knowledgeCards;
    private List<SemanticMapping> semanticMappings;
    private List<BusinessRule> businessRules;
    private List<UsagePattern> usagePatterns;
    private List<MetricDefinition> metricDefinitions;
    private List<String> relatedEntityIds;

    @Data
    public static class SemanticMapping {
        private String term;
        private String field;
        private String table;
        private String description;

        public SemanticMapping() {}

        public SemanticMapping(String term, String field, String table) {
            this.term = term;
            this.field = field;
            this.table = table;
        }
    }

    @Data
    public static class BusinessRule {
        private String condition;
        private String meaning;
        private Integer priority;

        public BusinessRule() {}

        public BusinessRule(String condition, String meaning, Integer priority) {
            this.condition = condition;
            this.meaning = meaning;
            this.priority = priority;
        }
    }

    @Data
    public static class UsagePattern {
        private String name;
        private String pattern;
        private String description;

        public UsagePattern() {}

        public UsagePattern(String name, String pattern) {
            this.name = name;
            this.pattern = pattern;
        }
    }

    @Data
    public static class MetricDefinition {
        private String metric;
        private String formula;
        private String unit;
        private String description;

        public MetricDefinition() {}

        public MetricDefinition(String metric, String formula) {
            this.metric = metric;
            this.formula = formula;
        }
    }
}
