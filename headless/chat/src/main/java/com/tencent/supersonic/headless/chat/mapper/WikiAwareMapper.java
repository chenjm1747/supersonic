package com.tencent.supersonic.headless.chat.mapper;

import com.tencent.supersonic.headless.api.pojo.SchemaElementMatch;
import com.tencent.supersonic.headless.chat.parser.wiki.EnhancedSchema;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
@Slf4j
public class WikiAwareMapper {

    public List<SchemaElementMatch> enhancedMap(Long dataSetId, String queryText,
            EnhancedSchema enhancedSchema) {
        List<SchemaElementMatch> matches = new ArrayList<>();

        if (enhancedSchema == null || enhancedSchema.getTermToFieldMapping() == null) {
            return matches;
        }

        Map<String, String> termToFieldMapping = enhancedSchema.getTermToFieldMapping();

        for (Map.Entry<String, String> entry : termToFieldMapping.entrySet()) {
            String term = entry.getKey();
            String field = entry.getValue();

            if (queryText.contains(term)) {
                SchemaElementMatch match = createWikiEnhancedMatch(term, field, enhancedSchema);
                if (match != null) {
                    matches.add(match);
                }
            }
        }

        log.info("[WikiAwareMapper] Enhanced mapping found {} matches for query: {}",
                matches.size(), queryText);

        return matches;
    }

    private SchemaElementMatch createWikiEnhancedMatch(String term, String field,
            EnhancedSchema enhancedSchema) {
        SchemaElementMatch match = new SchemaElementMatch();
        match.setWord(term);
        match.setDetectWord(field);
        return match;
    }
}
