package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.math.BigDecimal;
import java.sql.Array;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
public class WikiKnowledgeService {

    private static final Logger keyPipelineLog = LoggerFactory.getLogger("keyPipeline");
    private final JdbcTemplate jdbcTemplate;

    private static final String INSERT_CARD_SQL =
            """
                    INSERT INTO s2_wiki_knowledge_card
                    (card_id, entity_id, card_type, title, content, extracted_from, confidence, status, tags, version, created_at, updated_at)
                    VALUES (?, ?, ?, ?, ?, ?::text[], ?, ?, ?::text[], ?, ?, ?)
                    """;

    private static final String UPDATE_CARD_SQL = """
            UPDATE s2_wiki_knowledge_card
            SET card_type = ?, title = ?, content = ?, extracted_from = ?::text[], confidence = ?,
                status = ?, tags = ?::text[], version = ?, updated_at = ?
            WHERE card_id = ?
            """;

    private static final String SELECT_BY_ID_SQL =
            "SELECT * FROM s2_wiki_knowledge_card WHERE card_id = ?";

    private static final String SELECT_BY_ENTITY_SQL =
            "SELECT * FROM s2_wiki_knowledge_card WHERE entity_id = ? AND status = 'ACTIVE'";

    private static final String SELECT_BY_TYPE_SQL =
            "SELECT * FROM s2_wiki_knowledge_card WHERE card_type = ? AND status = 'ACTIVE'";

    private static final String DELETE_CARD_SQL =
            "UPDATE s2_wiki_knowledge_card SET status = 'DELETED', updated_at = ? WHERE card_id = ?";

    private static final String DELETE_CARDS_BY_ENTITY_SQL =
            "UPDATE s2_wiki_knowledge_card SET status = 'DELETED', updated_at = ? WHERE entity_id = ?";

    private static final String SEARCH_BY_LIKE_SQL = "SELECT * FROM s2_wiki_knowledge_card "
            + "WHERE status = 'ACTIVE' " + "AND (title LIKE ? OR content LIKE ?) " + "LIMIT ?";

    private static final String SEARCH_BY_EMBEDDING_SQL = "SELECT * FROM s2_wiki_knowledge_card "
            + "WHERE status = 'ACTIVE' AND embedding <=> ?::vector < 1.0 "
            + "ORDER BY embedding <=> ?::vector " + "LIMIT ?";

    public static final String CARD_TYPE_SEMANTIC_MAPPING = "SEMANTIC_MAPPING";
    public static final String CARD_TYPE_BUSINESS_RULE = "BUSINESS_RULE";
    public static final String CARD_TYPE_USAGE_PATTERN = "USAGE_PATTERN";
    public static final String CARD_TYPE_METRIC_DEFINITION = "METRIC_DEFINITION";

    public List<WikiKnowledgeCard> getSemanticMappings(Long dataSetId) {
        return getCardsByType(CARD_TYPE_SEMANTIC_MAPPING);
    }

    public List<WikiKnowledgeCard> getBusinessRules(Long dataSetId) {
        return getCardsByType(CARD_TYPE_BUSINESS_RULE);
    }

    public List<WikiKnowledgeCard> getUsagePatterns(Long dataSetId) {
        return getCardsByType(CARD_TYPE_USAGE_PATTERN);
    }

    public List<WikiKnowledgeCard> getMetricDefinitions(Long dataSetId) {
        return getCardsByType(CARD_TYPE_METRIC_DEFINITION);
    }

    public List<WikiKnowledgeCard> searchKnowledge(String queryText) {
        return searchKnowledge(queryText, 10);
    }

    public List<WikiKnowledgeCard> searchKnowledge(String queryText, int topK) {
        if (queryText == null || queryText.trim().isEmpty()) {
            return new ArrayList<>();
        }
        String searchPattern = "%" + queryText.trim() + "%";
        return jdbcTemplate.query(SEARCH_BY_LIKE_SQL, new WikiKnowledgeCardRowMapper(),
                searchPattern, searchPattern, topK);
    }

    public WikiKnowledgeService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Transactional
    public WikiKnowledgeCard createCard(WikiKnowledgeCard card) {
        if (!StringUtils.hasText(card.getCardId())) {
            card.setCardId(generateCardId(card));
        }
        card.setCreatedAt(LocalDateTime.now());
        card.setUpdatedAt(LocalDateTime.now());
        card.setStatus("ACTIVE");
        if (card.getVersion() == null) {
            card.setVersion("1.0.0");
        }
        if (card.getConfidence() == null) {
            card.setConfidence(BigDecimal.valueOf(0.9));
        }

        log.info("Creating knowledge card: {}", card.getCardId());
        keyPipelineLog.info("[Wiki知识库] 创建知识卡片 | cardId:{} | entityId:{} | cardType:{}",
                card.getCardId(), card.getEntityId(), card.getCardType());

        jdbcTemplate.update(INSERT_CARD_SQL, card.getCardId(), card.getEntityId(),
                card.getCardType(), card.getTitle(), card.getContent(),
                card.getExtractedFrom() != null ? card.getExtractedFrom().toArray(new String[0])
                        : null,
                card.getConfidence(), card.getStatus(),
                card.getTags() != null ? card.getTags().toArray(new String[0]) : null,
                card.getVersion(), card.getCreatedAt(), card.getUpdatedAt());

        return card;
    }

    @Transactional
    public WikiKnowledgeCard updateCard(WikiKnowledgeCard card) {
        card.setUpdatedAt(LocalDateTime.now());

        log.info("Updating knowledge card: {}", card.getCardId());

        jdbcTemplate.update(UPDATE_CARD_SQL, card.getCardType(), card.getTitle(), card.getContent(),
                card.getExtractedFrom() != null ? card.getExtractedFrom().toArray(new String[0])
                        : null,
                card.getConfidence(), card.getStatus(),
                card.getTags() != null ? card.getTags().toArray(new String[0]) : null,
                incrementVersion(card.getVersion()), card.getUpdatedAt(), card.getCardId());

        return card;
    }

    public WikiKnowledgeCard getCardById(String cardId) {
        List<WikiKnowledgeCard> results =
                jdbcTemplate.query(SELECT_BY_ID_SQL, new WikiKnowledgeCardRowMapper(), cardId);
        return results.isEmpty() ? null : results.get(0);
    }

    public List<WikiKnowledgeCard> getCardsByEntityId(String entityId) {
        return jdbcTemplate.query(SELECT_BY_ENTITY_SQL, new WikiKnowledgeCardRowMapper(), entityId);
    }

    public List<WikiKnowledgeCard> getCardsByType(String cardType) {
        return jdbcTemplate.query(SELECT_BY_TYPE_SQL, new WikiKnowledgeCardRowMapper(), cardType);
    }

    @Transactional
    public void deleteCard(String cardId) {
        log.info("Deleting knowledge card: {}", cardId);
        jdbcTemplate.update(DELETE_CARD_SQL, LocalDateTime.now(), cardId);
    }

    @Transactional
    public void deleteCardsByEntityId(String entityId) {
        log.info("Deleting knowledge cards for entity: {}", entityId);
        jdbcTemplate.update(DELETE_CARDS_BY_ENTITY_SQL, LocalDateTime.now(), entityId);
    }

    public List<WikiKnowledgeCard> searchByEmbedding(float[] embedding, int topK) {
        String embeddingStr = arrayToPostgresVector(embedding);
        keyPipelineLog.info("[Wiki知识库->检索] 向量搜索开始 | topK:{} | embeddingDim:{}", topK,
                embedding != null ? embedding.length : 0);
        List<WikiKnowledgeCard> results = jdbcTemplate.query(SEARCH_BY_EMBEDDING_SQL,
                new WikiKnowledgeCardRowMapper(), embeddingStr, embeddingStr, topK);
        keyPipelineLog.info("[Wiki知识库->检索] 向量搜索完成 | resultSize:{}",
                results != null ? results.size() : 0);
        return results;
    }

    private String generateCardId(WikiKnowledgeCard card) {
        return "kc:" + card.getEntityId() + ":" + card.getCardType() + ":"
                + UUID.randomUUID().toString().substring(0, 8);
    }

    private String incrementVersion(String version) {
        if (!StringUtils.hasText(version)) {
            return "1.0.0";
        }
        String[] parts = version.split("\\.");
        if (parts.length >= 2) {
            int minor = Integer.parseInt(parts[1]) + 1;
            return parts[0] + "." + minor + ".0";
        }
        return version;
    }

    private String arrayToPostgresVector(float[] array) {
        if (array == null || array.length == 0) {
            return "[]";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < array.length; i++) {
            if (i > 0)
                sb.append(",");
            sb.append(array[i]);
        }
        sb.append("]");
        return sb.toString();
    }

    public boolean existsMapping(String entityId, String term, String field) {
        String sql = "SELECT COUNT(*) FROM s2_wiki_knowledge_card "
                + "WHERE entity_id = ? AND card_type = 'SEMANTIC_MAPPING' "
                + "AND content LIKE ? AND content LIKE ? AND status = 'ACTIVE'";
        String termPattern = "%\"term\":\"" + term + "\"%";
        String fieldPattern = "%\"field\":\"" + field + "\"%";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, entityId, termPattern, fieldPattern);
        return count != null && count > 0;
    }

    public int countOutdatedCards(int daysThreshold) {
        String sql = "SELECT COUNT(*) FROM s2_wiki_knowledge_card "
                + "WHERE status = 'ACTIVE' "
                + "AND updated_at < NOW() - INTERVAL '1 day' * ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, daysThreshold);
        return count != null ? count : 0;
    }

    public Long countActiveCards() {
        String sql = "SELECT COUNT(*) FROM s2_wiki_knowledge_card WHERE status = 'ACTIVE'";
        Long count = jdbcTemplate.queryForObject(sql, Long.class);
        return count != null ? count : 0L;
    }

    public Double getAvgConfidence() {
        String sql = "SELECT AVG(confidence) FROM s2_wiki_knowledge_card WHERE status = 'ACTIVE' AND confidence IS NOT NULL";
        BigDecimal result = jdbcTemplate.queryForObject(sql, BigDecimal.class);
        return result != null ? result.doubleValue() : null;
    }

    public Map<String, Long> countByType() {
        String sql = "SELECT card_type, COUNT(*) as cnt FROM s2_wiki_knowledge_card "
                + "WHERE status = 'ACTIVE' GROUP BY card_type";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            String type = rs.getString("card_type");
            Long count = rs.getLong("cnt");
            return new java.util.AbstractMap.SimpleEntry<>(type, count);
        }).stream().collect(java.util.stream.Collectors.toMap(java.util.Map.Entry::getKey, java.util.Map.Entry::getValue));
    }

    public List<Map<String, Object>> getCompoundingTrend(int days) {
        String sql = "SELECT DATE(created_at) as date, "
                + "SUM(CASE WHEN status = 'ACTIVE' THEN 1 ELSE 0 END) as success_count, "
                + "SUM(CASE WHEN status = 'SUPERSEDED' THEN 1 ELSE 0 END) as failure_count, "
                + "AVG(confidence) as avg_confidence "
                + "FROM s2_wiki_knowledge_card "
                + "WHERE created_at >= NOW() - INTERVAL '1 day' * ? "
                + "GROUP BY DATE(created_at) ORDER BY date";
        return jdbcTemplate.queryForList(sql, days);
    }

    private static class WikiKnowledgeCardRowMapper implements RowMapper<WikiKnowledgeCard> {
        @Override
        public WikiKnowledgeCard mapRow(ResultSet rs, int rowNum) throws SQLException {
            WikiKnowledgeCard card = new WikiKnowledgeCard();
            card.setId(rs.getLong("id"));
            card.setCardId(rs.getString("card_id"));
            card.setEntityId(rs.getString("entity_id"));
            card.setCardType(rs.getString("card_type"));
            card.setTitle(rs.getString("title"));
            card.setContent(rs.getString("content"));

            Array extractedArrayResult = rs.getArray("extracted_from");
            String[] extractedArray =
                    extractedArrayResult != null ? (String[]) extractedArrayResult.getArray()
                            : null;
            card.setExtractedFrom(
                    extractedArray != null ? List.of(extractedArray) : new ArrayList<>());

            card.setConfidence(rs.getBigDecimal("confidence"));
            card.setStatus(rs.getString("status"));

            Array tagsArrayResult = rs.getArray("tags");
            String[] tagsArray =
                    tagsArrayResult != null ? (String[]) tagsArrayResult.getArray() : null;
            card.setTags(tagsArray != null ? List.of(tagsArray) : new ArrayList<>());

            card.setVersion(rs.getString("version"));
            card.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            card.setUpdatedAt(rs.getTimestamp("updated_at") != null
                    ? rs.getTimestamp("updated_at").toLocalDateTime()
                    : null);
            return card;
        }
    }
}
