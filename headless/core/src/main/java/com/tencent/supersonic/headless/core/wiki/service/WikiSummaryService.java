package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.TopicSummary;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Array;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class WikiSummaryService {

    private final JdbcTemplate jdbcTemplate;
    private final WikiEntityService entityService;
    private final WikiKnowledgeService knowledgeService;

    private static final String INSERT_SUMMARY_SQL = """
            INSERT INTO s2_wiki_topic_summary
            (topic_id, topic_name, summary, member_entities, relationships, metrics,
             summary_version, llm_model, generated_at, status, created_at, updated_at)
            VALUES (?, ?, ?, ?::text[], ?, ?::jsonb, ?, ?, ?, ?, ?, ?)
            """;

    private static final String UPDATE_SUMMARY_SQL = """
            UPDATE s2_wiki_topic_summary
            SET topic_name = ?, summary = ?, member_entities = ?::text[], relationships = ?::text[],
                metrics = ?::jsonb, summary_version = ?, llm_model = ?, generated_at = ?,
                status = ?, updated_at = ?
            WHERE topic_id = ?
            """;

    private static final String SELECT_BY_TOPIC_ID_SQL = """
            SELECT * FROM s2_wiki_topic_summary WHERE topic_id = ?
            """;

    private static final String SELECT_ALL_SQL = """
            SELECT * FROM s2_wiki_topic_summary WHERE status = 'ACTIVE' ORDER BY topic_name
            """;

    private static final String SELECT_ALL_WITH_HISTORY_SQL = """
            SELECT * FROM s2_wiki_topic_summary ORDER BY topic_name, summary_version DESC
            """;

    private static final String DELETE_SUMMARY_SQL = """
            UPDATE s2_wiki_topic_summary SET status = 'DELETED', updated_at = ? WHERE topic_id = ?
            """;

    private static final String GET_VERSION_HISTORY_SQL = """
            SELECT * FROM s2_wiki_topic_summary WHERE topic_id = ? ORDER BY summary_version DESC
            """;

    public WikiSummaryService(DataSource dataSource, WikiEntityService entityService,
            WikiKnowledgeService knowledgeService) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.entityService = entityService;
        this.knowledgeService = knowledgeService;
    }

    @Transactional
    public TopicSummary createOrUpdateSummary(TopicSummary summary) {
        summary.setUpdatedAt(LocalDateTime.now());
        summary.setGeneratedAt(LocalDateTime.now());
        summary.setStatus("ACTIVE");

        TopicSummary existing = getSummaryByTopicId(summary.getTopicId());

        if (existing != null) {
            summary.setId(existing.getId());
            summary.setSummaryVersion(existing.getSummaryVersion() + 1);

            jdbcTemplate.update(UPDATE_SUMMARY_SQL, summary.getTopicName(), summary.getSummary(),
                    summary.getMemberEntities() != null
                            ? summary.getMemberEntities().toArray(new String[0])
                            : null,
                    summary.getRelationships() != null
                            ? summary.getRelationships().toArray(new String[0])
                            : null,
                    toJsonString(summary.getMetrics()), summary.getSummaryVersion(),
                    summary.getLlmModel(), summary.getGeneratedAt(), summary.getStatus(),
                    summary.getUpdatedAt(), summary.getTopicId());

            log.info("Updated topic summary for topic: {}, version: {}", summary.getTopicId(),
                    summary.getSummaryVersion());
        } else {
            summary.setCreatedAt(LocalDateTime.now());
            summary.setSummaryVersion(1);

            jdbcTemplate.update(INSERT_SUMMARY_SQL, summary.getTopicId(), summary.getTopicName(),
                    summary.getSummary(),
                    summary.getMemberEntities() != null
                            ? summary.getMemberEntities().toArray(new String[0])
                            : null,
                    summary.getRelationships() != null
                            ? summary.getRelationships().toArray(new String[0])
                            : null,
                    toJsonString(summary.getMetrics()), summary.getSummaryVersion(),
                    summary.getLlmModel(), summary.getGeneratedAt(), summary.getStatus(),
                    summary.getCreatedAt(), summary.getUpdatedAt());

            log.info("Created topic summary for topic: {}", summary.getTopicId());
        }

        return summary;
    }

    public TopicSummary getSummaryByTopicId(String topicId) {
        List<TopicSummary> results =
                jdbcTemplate.query(SELECT_BY_TOPIC_ID_SQL, new TopicSummaryRowMapper(), topicId);
        return results.isEmpty() ? null : results.get(0);
    }

    public List<TopicSummary> getAllActiveSummaries() {
        return jdbcTemplate.query(SELECT_ALL_SQL, new TopicSummaryRowMapper());
    }

    public List<TopicSummary> getVersionHistory(String topicId) {
        return jdbcTemplate.query(GET_VERSION_HISTORY_SQL, new TopicSummaryRowMapper(), topicId);
    }

    @Transactional
    public void deleteSummary(String topicId) {
        log.info("Deleting topic summary for topic: {}", topicId);
        jdbcTemplate.update(DELETE_SUMMARY_SQL, LocalDateTime.now(), topicId);
    }

    public TopicSummary generateSummary(String topicId) {
        log.info("Generating summary for topic: {}", topicId);

        List<WikiEntity> topicEntities = entityService.getEntitiesByTopic(topicId);

        if (topicEntities.isEmpty()) {
            log.warn("No entities found for topic: {}", topicId);
            return null;
        }

        StringBuilder summaryContent = new StringBuilder();
        summaryContent.append("# ").append(topicId).append(" 主题摘要\n\n");

        summaryContent.append("## 主题概述\n");
        summaryContent.append("本主题包含 ").append(topicEntities.size()).append(" 个实体。\n\n");

        List<String> memberEntities = new ArrayList<>();
        List<String> relationships = new ArrayList<>();

        for (WikiEntity entity : topicEntities) {
            memberEntities.add(entity.getEntityId());

            summaryContent.append("### ").append(
                    entity.getDisplayName() != null ? entity.getDisplayName() : entity.getName())
                    .append("\n");
            summaryContent.append("- 实体ID: ").append(entity.getEntityId()).append("\n");
            summaryContent.append("- 类型: ").append(entity.getEntityType()).append("\n");

            if (entity.getDescription() != null && !entity.getDescription().isEmpty()) {
                summaryContent.append("- 描述: ").append(entity.getDescription()).append("\n");
            }

            List<WikiKnowledgeCard> cards =
                    knowledgeService.getCardsByEntityId(entity.getEntityId());
            if (!cards.isEmpty()) {
                summaryContent.append("- 知识卡片数: ").append(cards.size()).append("\n");

                for (WikiKnowledgeCard card : cards) {
                    if (card.getCardType().equals("RELATIONSHIP")) {
                        relationships.add(entity.getName() + ": " + card.getContent());
                    }
                }
            }

            summaryContent.append("\n");
        }

        TopicSummary summary = new TopicSummary();
        summary.setTopicId(topicId);
        summary.setTopicName(topicId.replace("topic:", ""));
        summary.setSummary(summaryContent.toString());
        summary.setMemberEntities(memberEntities);
        summary.setRelationships(relationships);
        summary.setMetrics(new HashMap<>());
        summary.setLlmModel("AUTO_GENERATED");
        summary.setGeneratedAt(LocalDateTime.now());
        summary.setStatus("ACTIVE");

        return createOrUpdateSummary(summary);
    }

    public List<TopicSummary> refreshAllSummaries() {
        log.info("Refreshing all topic summaries...");

        List<TopicSummary> summaries = new ArrayList<>();
        List<WikiEntity> topicEntities = entityService.getEntitiesByType("TOPIC");

        for (WikiEntity topic : topicEntities) {
            try {
                TopicSummary summary = generateSummary(topic.getEntityId());
                if (summary != null) {
                    summaries.add(summary);
                }
            } catch (Exception e) {
                log.error("Failed to generate summary for topic: {}", topic.getEntityId(), e);
            }
        }

        log.info("Refreshed {} topic summaries", summaries.size());
        return summaries;
    }

    private String toJsonString(Map<String, Object> map) {
        if (map == null || map.isEmpty()) {
            return "{}";
        }
        StringBuilder sb = new StringBuilder();
        sb.append("{");
        boolean first = true;
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            if (!first) {
                sb.append(",");
            }
            sb.append("\"").append(entry.getKey()).append("\":");
            Object value = entry.getValue();
            if (value instanceof String) {
                sb.append("\"").append(((String) value).replace("\"", "\\\"")).append("\"");
            } else {
                sb.append(value);
            }
            first = false;
        }
        sb.append("}");
        return sb.toString();
    }

    private static class TopicSummaryRowMapper implements RowMapper<TopicSummary> {
        @Override
        public TopicSummary mapRow(ResultSet rs, int rowNum) throws SQLException {
            TopicSummary s = new TopicSummary();
            s.setId(rs.getLong("id"));
            s.setTopicId(rs.getString("topic_id"));
            s.setTopicName(rs.getString("topic_name"));
            s.setSummary(rs.getString("summary"));

            Array memberArrayResult = rs.getArray("member_entities");
            String[] memberArray =
                    memberArrayResult != null ? (String[]) memberArrayResult.getArray() : null;
            s.setMemberEntities(memberArray != null ? List.of(memberArray) : new ArrayList<>());

            Array relArrayResult = rs.getArray("relationships");
            String[] relArray =
                    relArrayResult != null ? (String[]) relArrayResult.getArray() : null;
            s.setRelationships(relArray != null ? List.of(relArray) : new ArrayList<>());

            String metricsStr = rs.getString("metrics");
            s.setMetrics(parseJsonToMap(metricsStr));

            s.setSummaryVersion(rs.getInt("summary_version"));
            s.setLlmModel(rs.getString("llm_model"));
            s.setGeneratedAt(rs.getTimestamp("generated_at") != null
                    ? rs.getTimestamp("generated_at").toLocalDateTime()
                    : null);
            s.setStatus(rs.getString("status"));
            s.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            s.setUpdatedAt(rs.getTimestamp("updated_at") != null
                    ? rs.getTimestamp("updated_at").toLocalDateTime()
                    : null);
            return s;
        }

        private Map<String, Object> parseJsonToMap(String json) {
            Map<String, Object> map = new HashMap<>();
            if (json == null || json.isEmpty() || "{}".equals(json)) {
                return map;
            }
            return map;
        }
    }
}
