package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.Contradiction;
import com.tencent.supersonic.headless.core.wiki.dto.Evidence;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

/**
 * ContradictionDetectionService detects semantic contradictions between new knowledge and existing
 * knowledge cards.
 */
@Service
@Slf4j
public class ContradictionDetectionService {

    private final WikiContradictionService contradictionService;
    private final WikiKnowledgeService knowledgeService;
    private final JdbcTemplate jdbcTemplate;

    // Keywords for contradiction detection
    private static final List<String> POSITIVE_DEBT_KEYWORDS =
            Arrays.asList("大于0", ">0", "欠费", "未结清", "未缴", "有欠款");

    private static final List<String> NEGATIVE_DEBT_KEYWORDS =
            Arrays.asList("等于0", "=0", "已结清", "已缴清", "已付清", "无欠款");

    private static final List<String> RELATIONSHIP_CONFLICT_KEYWORDS =
            Arrays.asList("1:1", "1对1", "一对一", "1:N", "1对多", "一对多");

    // Similarity threshold for contradiction detection
    private static final double SIMILARITY_THRESHOLD = 0.7;

    // Contradiction keywords in text
    private static final Pattern CONTRADICTION_PATTERN = Pattern.compile("但|然而|相反|实际上|实际是|不是|而是");

    public ContradictionDetectionService(WikiContradictionService contradictionService,
            WikiKnowledgeService knowledgeService,
            JdbcTemplate jdbcTemplate) {
        this.contradictionService = contradictionService;
        this.knowledgeService = knowledgeService;
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * Detect contradictions between a new knowledge card and existing cards
     *
     * @param newCard the newly added or updated knowledge card
     * @return detection result, or null if no contradiction detected
     */
    public ContradictionDetectionResult detect(WikiKnowledgeCard newCard) {
        if (newCard == null || newCard.getEntityId() == null) {
            return null;
        }

        // Get existing cards for the same entity
        List<WikiKnowledgeCard> existingCards =
                knowledgeService.getCardsByEntityId(newCard.getEntityId());
        if (existingCards == null || existingCards.isEmpty()) {
            return null;
        }

        // Find potential contradictions
        for (WikiKnowledgeCard existingCard : existingCards) {
            if (existingCard.getCardId().equals(newCard.getCardId())) {
                continue; // Skip self
            }

            // Check for semantic contradiction
            ContradictionDetectionResult result = checkSemanticContradiction(newCard, existingCard);
            if (result != null && result.isContradiction()) {
                return result;
            }

            // Check for relationship contradiction
            result = checkRelationshipContradiction(newCard, existingCard);
            if (result != null && result.isContradiction()) {
                return result;
            }

            // Check for rule contradiction
            result = checkRuleContradiction(newCard, existingCard);
            if (result != null && result.isContradiction()) {
                return result;
            }
        }

        return null;
    }

    /**
     * Check for semantic contradiction between two cards Example: "qfje > 0 表示欠费" vs "qfje = 0
     * 表示已结清"
     */
    private ContradictionDetectionResult checkSemanticContradiction(WikiKnowledgeCard card1,
            WikiKnowledgeCard card2) {
        String content1 = card1.getContent();
        String content2 = card2.getContent();

        if (content1 == null || content2 == null) {
            return null;
        }

        // Check for debt-related contradictions
        boolean hasPositiveDebt = containsAny(content1, POSITIVE_DEBT_KEYWORDS)
                || containsAny(content2, POSITIVE_DEBT_KEYWORDS);
        boolean hasNegativeDebt = containsAny(content1, NEGATIVE_DEBT_KEYWORDS)
                || containsAny(content2, NEGATIVE_DEBT_KEYWORDS);

        if (hasPositiveDebt && hasNegativeDebt) {
            Contradiction contradiction = buildContradiction(card1, card2, "SEMANTIC_CONFLICT",
                    "对同一字段的数值含义理解存在矛盾", "一个认为值大于0表示某种状态，另一个认为值等于0表示另一种相反状态");

            ContradictionDetectionResult result = new ContradictionDetectionResult();
            result.setContradiction(contradiction);
            result.setContradictionType("SEMANTIC_CONFLICT");
            result.setConfidence(0.9);
            result.setHasContradiction(true);
            return result;
        }

        // Check for explicit contradiction markers
        if (CONTRADICTION_PATTERN.matcher(content1).find()
                || CONTRADICTION_PATTERN.matcher(content2).find()) {
            // Further analysis needed - could be explicit contradiction
            double similarity = calculateSimilarity(content1, content2);
            if (similarity > SIMILARITY_THRESHOLD) {
                Contradiction contradiction = buildContradiction(card1, card2, "SEMANTIC_CONFLICT",
                        "两个知识卡片存在语义冲突", "内容相似但含义相反");

                ContradictionDetectionResult result = new ContradictionDetectionResult();
                result.setContradiction(contradiction);
                result.setContradictionType("SEMANTIC_CONFLICT");
                result.setConfidence(similarity);
                result.setHasContradiction(true);
                return result;
            }
        }

        return null;
    }

    /**
     * Check for relationship contradiction Example: "customer 和 sf_js_t 是 1:1 关系" vs "customer 和
     * sf_js_t 是 1:N 关系"
     */
    private ContradictionDetectionResult checkRelationshipContradiction(WikiKnowledgeCard card1,
            WikiKnowledgeCard card2) {
        String content1 = card1.getContent();
        String content2 = card2.getContent();

        if (content1 == null || content2 == null) {
            return null;
        }

        boolean has1to1_1 = containsAny(content1, Arrays.asList("1:1", "1对1", "一对一"));
        boolean has1to1_2 = containsAny(content2, Arrays.asList("1:1", "1对1", "一对一"));
        boolean has1toN_1 = containsAny(content1, Arrays.asList("1:N", "1对多", "一对多"));
        boolean has1toN_2 = containsAny(content2, Arrays.asList("1:N", "1对多", "一对多"));

        if ((has1to1_1 && has1toN_2) || (has1toN_1 && has1to1_2)) {
            Contradiction contradiction = buildContradiction(card1, card2, "RELATIONSHIP_CONFLICT",
                    "对表间关系类型理解存在矛盾", "一个认为是1:1关系，另一个认为是1:N关系");

            ContradictionDetectionResult result = new ContradictionDetectionResult();
            result.setContradiction(contradiction);
            result.setContradictionType("RELATIONSHIP_CONFLICT");
            result.setConfidence(0.95);
            result.setHasContradiction(true);
            return result;
        }

        return null;
    }

    /**
     * Check for business rule contradiction
     */
    private ContradictionDetectionResult checkRuleContradiction(WikiKnowledgeCard card1,
            WikiKnowledgeCard card2) {
        // Similar logic for business rule conflicts
        // For now, use a simple similarity check
        String content1 = card1.getContent();
        String content2 = card2.getContent();

        if (content1 == null || content2 == null) {
            return null;
        }

        double similarity = calculateSimilarity(content1, content2);
        if (similarity > 0.8) {
            // High similarity but different rules - potential contradiction
            // This would need more sophisticated analysis
            return null;
        }

        return null;
    }

    /**
     * Build a Contradiction object from two conflicting cards
     */
    private Contradiction buildContradiction(WikiKnowledgeCard card1, WikiKnowledgeCard card2,
            String conflictType, String impact, String description) {
        Contradiction contradiction = new Contradiction();
        contradiction.setEntityId(card1.getEntityId());
        contradiction.setOldKnowledgeCardId(card2.getCardId());
        contradiction.setConflictType(conflictType);
        contradiction.setOldContent(card2.getContent());
        contradiction.setNewEvidence(card1.getContent());
        contradiction.setEvidenceSource("knowledge_card:" + card1.getCardId());
        contradiction.setImpact(impact + " - " + description);
        contradiction.setResolution("PENDING");

        return contradiction;
    }

    /**
     * Save a detected contradiction
     */
    public Contradiction saveContradiction(Contradiction contradiction) {
        return contradictionService.createContradiction(contradiction);
    }

    public List<Contradiction> detectAll() {
        List<Contradiction> results = new ArrayList<>();
        try {
            // Detect semantic mapping contradictions via SQL
            results.addAll(detectSemanticMappingContradictions());
            // Detect business rule contradictions via SQL
            results.addAll(detectBusinessRuleContradictions());
        } catch (Exception e) {
            log.error("Error detecting all contradictions", e);
        }
        return results;
    }

    public List<Contradiction> detectSemanticMappingContradictions() {
        String sql = """
            SELECT a.entity_id, a.title as a_title, b.title as b_title,
                   a.content as a_content, b.content as b_content,
                   a.card_id as a_card_id, b.card_id as b_card_id
            FROM s2_wiki_knowledge_card a
            JOIN s2_wiki_knowledge_card b ON a.entity_id = b.entity_id
            WHERE a.card_type = 'SEMANTIC_MAPPING'
              AND b.card_type = 'SEMANTIC_MAPPING'
              AND a.card_id < b.card_id
              AND a.status = 'ACTIVE'
              AND b.status = 'ACTIVE'
              AND (a.content->>'term') = (b.content->>'term')
              AND (a.content->>'field') != (b.content->>'field')
            """;

        try {
            return jdbcTemplate.query(sql, (rs, rowNum) -> {
                Contradiction c = new Contradiction();
                c.setEntityId(rs.getString("entity_id"));
                c.setConflictType("SEMANTIC_MAPPING");
                c.setOldContent(rs.getString("a_content"));
                c.setNewEvidence(rs.getString("b_content"));
                c.setOldKnowledgeCardId(rs.getString("a_card_id"));
                return c;
            });
        } catch (Exception e) {
            log.error("Error detecting semantic mapping contradictions", e);
            return new ArrayList<>();
        }
    }

    public List<Contradiction> detectBusinessRuleContradictions() {
        String sql = """
            SELECT a.entity_id, a.title as a_title, b.title as b_title,
                   a.content as a_content, b.content as b_content,
                   a.card_id as a_card_id, b.card_id as b_card_id
            FROM s2_wiki_knowledge_card a
            JOIN s2_wiki_knowledge_card b ON a.entity_id = b.entity_id
            WHERE a.card_type = 'BUSINESS_RULE'
              AND b.card_type = 'BUSINESS_RULE'
              AND a.card_id < b.card_id
              AND a.status = 'ACTIVE'
              AND b.status = 'ACTIVE'
              AND (a.content->>'condition') = (b.content->>'condition')
              AND (a.content->>'meaning') != (b.content->>'meaning')
            """;

        try {
            return jdbcTemplate.query(sql, (rs, rowNum) -> {
                Contradiction c = new Contradiction();
                c.setEntityId(rs.getString("entity_id"));
                c.setConflictType("BUSINESS_RULE");
                c.setOldContent(rs.getString("a_content"));
                c.setNewEvidence(rs.getString("b_content"));
                c.setOldKnowledgeCardId(rs.getString("a_card_id"));
                return c;
            });
        } catch (Exception e) {
            log.error("Error detecting business rule contradictions", e);
            return new ArrayList<>();
        }
    }

    public int countPending() {
        String sql = "SELECT COUNT(*) FROM s2_wiki_knowledge_card WHERE status = 'CONFLICTED'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    /**
     * Calculate similarity between two text contents
     */
    private double calculateSimilarity(String text1, String text2) {
        if (text1 == null || text2 == null) {
            return 0.0;
        }

        // Simple word-based Jaccard similarity
        String[] words1 = text1.toLowerCase().split("\\s+");
        String[] words2 = text2.toLowerCase().split("\\s+");

        java.util.Set<String> set1 = new java.util.HashSet<>(Arrays.asList(words1));
        java.util.Set<String> set2 = new java.util.HashSet<>(Arrays.asList(words2));

        java.util.Set<String> intersection = new java.util.HashSet<>(set1);
        intersection.retainAll(set2);

        java.util.Set<String> union = new java.util.HashSet<>(set1);
        union.addAll(set2);

        return union.isEmpty() ? 0.0 : (double) intersection.size() / union.size();
    }

    private boolean containsAny(String text, List<String> keywords) {
        if (text == null) {
            return false;
        }
        String lowerText = text.toLowerCase();
        for (String keyword : keywords) {
            if (lowerText.contains(keyword.toLowerCase())) {
                return true;
            }
        }
        return false;
    }

    /**
     * Result of contradiction detection
     */
    @lombok.Data
    @lombok.Builder
    @lombok.NoArgsConstructor
    @lombok.AllArgsConstructor
    public static class ContradictionDetectionResult {
        private Contradiction contradiction;
        private String contradictionType;
        private double confidence;
        private boolean hasContradiction;
        private String explanation;

        public boolean isContradiction() {
            return hasContradiction;
        }
    }
}
