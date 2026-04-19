package com.tencent.supersonic.headless.chat.parser.wiki;

import com.tencent.supersonic.headless.api.pojo.SemanticSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EnhancedSchema {

    private SemanticSchema originalSchema;

    private List<WikiEntity> relatedWikiEntities;

    private List<WikiKnowledgeCard> knowledgeCards;

    @Builder.Default
    private Map<String, String> termToFieldMapping = new HashMap<>();

    @Builder.Default
    private Map<String, String> fieldToTermMapping = new HashMap<>();

    @Builder.Default
    private List<String> businessRules = new ArrayList<>();

    public List<WikiEntity> getRelatedWikiEntities() {
        if (relatedWikiEntities == null) {
            relatedWikiEntities = new ArrayList<>();
        }
        return relatedWikiEntities;
    }

    public List<WikiKnowledgeCard> getKnowledgeCards() {
        if (knowledgeCards == null) {
            knowledgeCards = new ArrayList<>();
        }
        return knowledgeCards;
    }

    public Map<String, String> getTermToFieldMapping() {
        if (termToFieldMapping == null) {
            termToFieldMapping = new HashMap<>();
        }
        return termToFieldMapping;
    }

    public Map<String, String> getFieldToTermMapping() {
        if (fieldToTermMapping == null) {
            fieldToTermMapping = new HashMap<>();
        }
        return fieldToTermMapping;
    }

    public List<String> getBusinessRules() {
        if (businessRules == null) {
            businessRules = new ArrayList<>();
        }
        return businessRules;
    }
}
