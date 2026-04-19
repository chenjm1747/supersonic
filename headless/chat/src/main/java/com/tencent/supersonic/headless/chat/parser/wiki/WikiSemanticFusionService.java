package com.tencent.supersonic.headless.chat.parser.wiki;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.tencent.supersonic.headless.api.pojo.SemanticSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class WikiSemanticFusionService {

    private static final String CARD_TYPE_SEMANTIC_MAPPING = "SEMANTIC_MAPPING";
    private static final String CARD_TYPE_BUSINESS_RULE = "BUSINESS_RULE";
    private static final String CARD_TYPE_USAGE_PATTERN = "USAGE_PATTERN";
    private static final String CARD_TYPE_METRIC_DEFINITION = "METRIC_DEFINITION";

    private final Gson gson = new Gson();

    public EnhancedSchema fuseWithWiki(Long dataSetId, String queryText,
            SemanticSchema semanticSchema, List<WikiEntity> wikiEntities,
            List<WikiKnowledgeCard> wikiCards) {
        EnhancedSchema.EnhancedSchemaBuilder builder =
                EnhancedSchema.builder().originalSchema(semanticSchema)
                        .relatedWikiEntities(wikiEntities).knowledgeCards(wikiCards);

        Map<String, String> termToFieldMapping = new HashMap<>();
        Map<String, String> fieldToTermMapping = new HashMap<>();
        List<String> businessRules = new ArrayList<>();

        for (WikiKnowledgeCard card : wikiCards) {
            if (card == null || card.getCardType() == null) {
                continue;
            }

            switch (card.getCardType()) {
                case CARD_TYPE_SEMANTIC_MAPPING:
                    Map<String, String> mapping = parseSemanticMapping(card.getContent());
                    if (mapping != null) {
                        termToFieldMapping.put(mapping.get("term"), mapping.get("field"));
                        fieldToTermMapping.put(mapping.get("field"), mapping.get("term"));
                    }
                    break;

                case CARD_TYPE_BUSINESS_RULE:
                    if (card.getContent() != null && !card.getContent().isEmpty()) {
                        businessRules.add(card.getContent());
                    }
                    break;

                case CARD_TYPE_USAGE_PATTERN:
                case CARD_TYPE_METRIC_DEFINITION:
                default:
                    break;
            }
        }

        return builder.termToFieldMapping(termToFieldMapping).fieldToTermMapping(fieldToTermMapping)
                .businessRules(businessRules).build();
    }

    private Map<String, String> parseSemanticMapping(String content) {
        if (content == null || content.isEmpty()) {
            return null;
        }

        try {
            Map<String, String> result = new HashMap<>();
            JsonMapping mapping = gson.fromJson(content, JsonMapping.class);
            result.put("term", mapping.getTerm());
            result.put("field", mapping.getField());
            result.put("table", mapping.getTable());
            return result;
        } catch (JsonSyntaxException e) {
            log.warn("[WikiSemanticFusionService] Failed to parse semantic mapping: {}", content);
            return null;
        }
    }

    @lombok.Data
    private static class JsonMapping {
        private String term;
        private String field;
        private String table;
        private String description;

        public String getTerm() {
            return term;
        }

        public String getField() {
            return field;
        }

        public String getTable() {
            return table;
        }
    }
}
