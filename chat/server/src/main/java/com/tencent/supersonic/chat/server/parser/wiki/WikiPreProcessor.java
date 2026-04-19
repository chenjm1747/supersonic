package com.tencent.supersonic.chat.server.parser.wiki;

import com.tencent.supersonic.chat.server.pojo.ParseContext;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiKnowledgeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
public class WikiPreProcessor {

    @Autowired
    private WikiEntityService entityService;

    @Autowired
    private WikiKnowledgeService knowledgeService;

    public void preprocess(ParseContext parseContext) {
        String queryText = parseContext.getRequest().getQueryText();

        if (queryText == null || queryText.trim().isEmpty()) {
            parseContext.setWikiEntities(new ArrayList<>());
            parseContext.setWikiKnowledgeCards(new ArrayList<>());
            return;
        }

        log.info("[WikiPreProcessor] Starting Wiki preprocessing for query: {}", queryText);

        List<WikiEntity> wikiEntities = searchWikiEntities(queryText);
        List<WikiKnowledgeCard> wikiKnowledgeCards = searchWikiKnowledgeCards(queryText);

        parseContext.setWikiEntities(wikiEntities);
        parseContext.setWikiKnowledgeCards(wikiKnowledgeCards);

        log.info("[WikiPreProcessor] Wiki preprocessing complete. Entities: {}, Cards: {}",
                wikiEntities.size(), wikiKnowledgeCards.size());
    }

    private List<WikiEntity> searchWikiEntities(String queryText) {
        try {
            return entityService.searchEntities(queryText);
        } catch (Exception e) {
            log.warn("[WikiPreProcessor] Failed to search Wiki entities: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    private List<WikiKnowledgeCard> searchWikiKnowledgeCards(String queryText) {
        try {
            return knowledgeService.searchKnowledge(queryText);
        } catch (Exception e) {
            log.warn("[WikiPreProcessor] Failed to search Wiki knowledge cards: {}",
                    e.getMessage());
            return new ArrayList<>();
        }
    }
}
