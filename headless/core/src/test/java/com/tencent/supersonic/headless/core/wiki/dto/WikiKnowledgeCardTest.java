package com.tencent.supersonic.headless.core.wiki.dto;

import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

class WikiKnowledgeCardTest {

    @Test
    void testCardHasUsageFields() {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setUsageCount(0);
        card.setSuccessCount(0);
        card.setFailureCount(0);
        assertEquals(0, card.getUsageCount());
        assertEquals(0, card.getSuccessCount());
        assertEquals(0, card.getFailureCount());
    }

    @Test
    void testCardUsageFieldsDefaultToZero() {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        assertEquals(0, card.getUsageCount());
        assertEquals(0, card.getSuccessCount());
        assertEquals(0, card.getFailureCount());
    }

    @Test
    void testCardStatusEnum() {
        assertNotNull(WikiKnowledgeCard.CardStatus.ACTIVE);
        assertNotNull(WikiKnowledgeCard.CardStatus.PENDING_REVIEW);
        assertNotNull(WikiKnowledgeCard.CardStatus.SUPERSEDED);
        assertNotNull(WikiKnowledgeCard.CardStatus.RECOMMENDED);
        assertNotNull(WikiKnowledgeCard.CardStatus.AUTO_GENERATED);
    }

    @Test
    void testSetLastUsedAt() {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        LocalDateTime now = LocalDateTime.now();
        card.setLastUsedAt(now);
        assertEquals(now, card.getLastUsedAt());
    }

    @Test
    void testSetReplacementCardId() {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setReplacementCardId("kc:new:001");
        assertEquals("kc:new:001", card.getReplacementCardId());
    }

    @Test
    void testConfidenceBoostAndPenalty() {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setConfidence(BigDecimal.valueOf(0.9));
        card.setUsageCount(10);
        card.setSuccessCount(9);

        // Simulate success boost
        card.setConfidence(card.getConfidence().multiply(BigDecimal.valueOf(1.02)).min(BigDecimal.ONE));
        assertTrue(card.getConfidence().compareTo(BigDecimal.valueOf(0.9)) > 0);

        // Simulate failure penalty
        card.setConfidence(card.getConfidence().multiply(BigDecimal.valueOf(0.9)));
        assertTrue(card.getConfidence().compareTo(BigDecimal.valueOf(0.9)) < 0);
    }
}
