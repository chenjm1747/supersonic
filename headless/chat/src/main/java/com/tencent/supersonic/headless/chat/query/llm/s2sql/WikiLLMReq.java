package com.tencent.supersonic.headless.chat.query.llm.s2sql;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WikiLLMReq {

    private List<WikiKnowledgeCard> businessRules;

    private List<WikiKnowledgeCard> usagePatterns;

    private List<WikiKnowledgeCard> metricDefinitions;

    private List<WikiKnowledgeCard> semanticMappings;

    private List<WikiEntity> relatedEntities;

    private List<WikiKnowledgeCard> knowledgeCards;

    public List<WikiKnowledgeCard> getKnowledgeCards() {
        if (knowledgeCards == null) {
            knowledgeCards = new ArrayList<>();
        }
        return knowledgeCards;
    }

    public List<WikiKnowledgeCard> getBusinessRules() {
        if (businessRules == null) {
            businessRules = new ArrayList<>();
        }
        return businessRules;
    }

    public List<WikiKnowledgeCard> getUsagePatterns() {
        if (usagePatterns == null) {
            usagePatterns = new ArrayList<>();
        }
        return usagePatterns;
    }

    public List<WikiKnowledgeCard> getMetricDefinitions() {
        if (metricDefinitions == null) {
            metricDefinitions = new ArrayList<>();
        }
        return metricDefinitions;
    }

    public List<WikiKnowledgeCard> getSemanticMappings() {
        if (semanticMappings == null) {
            semanticMappings = new ArrayList<>();
        }
        return semanticMappings;
    }

    public List<WikiEntity> getRelatedEntities() {
        if (relatedEntities == null) {
            relatedEntities = new ArrayList<>();
        }
        return relatedEntities;
    }
}
