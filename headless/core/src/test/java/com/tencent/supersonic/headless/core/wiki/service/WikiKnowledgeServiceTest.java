package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = WikiKnowledgeServiceTestConfiguration.class)
class WikiKnowledgeServiceTest {

    @Autowired
    private WikiKnowledgeService wikiKnowledgeService;

    @Test
    void testGetSemanticMappings() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getSemanticMappings(null);
        assertNotNull(cards);
    }

    @Test
    void testGetBusinessRules() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getBusinessRules(null);
        assertNotNull(cards);
    }

    @Test
    void testGetUsagePatterns() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getUsagePatterns(null);
        assertNotNull(cards);
    }

    @Test
    void testGetMetricDefinitions() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getMetricDefinitions(null);
        assertNotNull(cards);
    }

    @Test
    void testSearchKnowledge() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.searchKnowledge("收入");
        assertNotNull(cards);
    }
}
