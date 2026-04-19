package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.WikiCardUsageLog;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
@RequiredArgsConstructor
public class SelfEnhancementService {
    private final WikiKnowledgeService knowledgeService;
    private final JdbcTemplate jdbcTemplate;

    private static final BigDecimal SUCCESS_BOOST = BigDecimal.valueOf(1.02);
    private static final BigDecimal FAILURE_PENALTY = BigDecimal.valueOf(0.90);
    private static final BigDecimal CONFIDENCE_THRESHOLD = BigDecimal.valueOf(0.3);
    private static final BigDecimal UPGRADE_CONFIDENCE_THRESHOLD = BigDecimal.valueOf(0.95);
    private static final int UPGRADE_USAGE_THRESHOLD = 20;
    private static final double UPGRADE_SUCCESS_RATE = 0.9;

    public void onSqlSuccess(String sql, List<String> usedCardIds) {
        if (usedCardIds == null || usedCardIds.isEmpty()) {
            return;
        }

        for (String cardId : usedCardIds) {
            try {
                WikiKnowledgeCard card = knowledgeService.getCardById(cardId);
                if (card == null) {
                    log.warn("Card not found: {}", cardId);
                    continue;
                }

                // 增加使用次数和成功次数
                card.setUsageCount(card.getUsageCount() + 1);
                card.setSuccessCount(card.getSuccessCount() + 1);
                card.setLastUsedAt(LocalDateTime.now());

                // 置信度提升（成功一次 +2%）
                BigDecimal newConfidence = card.getConfidence().multiply(SUCCESS_BOOST)
                    .min(BigDecimal.ONE);
                card.setConfidence(newConfidence);

                // 检查是否达到升级条件
                double successRate = calculateSuccessRate(card);
                if (card.getUsageCount() >= UPGRADE_USAGE_THRESHOLD
                    && card.getConfidence().compareTo(UPGRADE_CONFIDENCE_THRESHOLD) >= 0
                    && successRate > UPGRADE_SUCCESS_RATE) {
                    generateRecommendedVersion(card);
                }

                knowledgeService.updateCard(card);
                logUsage(cardId, sql, "SUCCESS", null);

                log.info("SQL success recorded for card: {}, new confidence: {}",
                    cardId, card.getConfidence());
            } catch (Exception e) {
                log.error("Error processing SQL success for card: {}", cardId, e);
            }
        }
    }

    public void onSqlFailure(String sql, String errorMsg, List<String> usedCardIds) {
        if (usedCardIds == null || usedCardIds.isEmpty()) {
            return;
        }

        for (String cardId : usedCardIds) {
            try {
                WikiKnowledgeCard card = knowledgeService.getCardById(cardId);
                if (card == null) {
                    log.warn("Card not found: {}", cardId);
                    continue;
                }

                // 增加失败次数
                card.setFailureCount(card.getFailureCount() + 1);
                card.setConfidence(card.getConfidence().multiply(FAILURE_PENALTY));
                card.setLastUsedAt(LocalDateTime.now());

                // 低于阈值时标记待审核
                if (card.getConfidence().compareTo(CONFIDENCE_THRESHOLD) < 0) {
                    card.setStatus("PENDING_REVIEW");
                    log.warn("Card {} confidence below threshold, marking as PENDING_REVIEW", cardId);
                }

                knowledgeService.updateCard(card);
                logUsage(cardId, sql, "FAILURE", errorMsg);

                log.info("SQL failure recorded for card: {}, new confidence: {}",
                    cardId, card.getConfidence());
            } catch (Exception e) {
                log.error("Error processing SQL failure for card: {}", cardId, e);
            }
        }
    }

    public void feedback(String sql, boolean isValid, List<String> usedCardIds) {
        if (isValid) {
            onSqlSuccess(sql, usedCardIds);
        } else {
            onSqlFailure(sql, "SQL validation failed", usedCardIds);
        }
    }

    private double calculateSuccessRate(WikiKnowledgeCard card) {
        int total = card.getSuccessCount() + card.getFailureCount();
        if (total == 0) {
            return 0.0;
        }
        return (double) card.getSuccessCount() / total;
    }

    private void generateRecommendedVersion(WikiKnowledgeCard card) {
        log.info("Generating recommended version for card: {}", card.getCardId());

        WikiKnowledgeCard newCard = new WikiKnowledgeCard();
        newCard.setCardId(generateCardId(card));
        newCard.setEntityId(card.getEntityId());
        newCard.setCardType(card.getCardType());
        newCard.setTitle(card.getTitle() + " ⭐推荐");
        newCard.setContent(card.getContent());
        newCard.setConfidence(BigDecimal.valueOf(0.9));
        newCard.setStatus("RECOMMENDED");
        newCard.setExtractedFrom(List.of("SELF_ENHANCEMENT"));
        newCard.setUsageCount(0);
        newCard.setSuccessCount(0);
        newCard.setFailureCount(0);

        // 旧版本标记为过时
        card.setStatus("SUPERSEDED");
        card.setReplacementCardId(newCard.getCardId());

        knowledgeService.createCard(newCard);
        knowledgeService.updateCard(card);

        log.info("Recommended version created: {}, old card superseded: {}",
            newCard.getCardId(), card.getCardId());
    }

    private String generateCardId(WikiKnowledgeCard card) {
        return "kc:" + card.getEntityId() + ":" + card.getCardType() + ":"
            + UUID.randomUUID().toString().substring(0, 8);
    }

    private void logUsage(String cardId, String sql, String result, String errorMsg) {
        try {
            jdbcTemplate.update(
                "INSERT INTO s2_wiki_card_usage_log (card_id, sql, result, error_msg, created_at) VALUES (?, ?, ?, ?, ?)",
                cardId, sql, result, errorMsg, LocalDateTime.now()
            );
        } catch (Exception e) {
            log.error("Failed to log card usage", e);
        }
    }
}
