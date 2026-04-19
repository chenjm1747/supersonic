package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import com.tencent.supersonic.headless.core.wiki.dto.WikiLink;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.sql.Array;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Slf4j
public class WikiEntityService {

    private final JdbcTemplate jdbcTemplate;

    private static final String INSERT_ENTITY_SQL =
            """
                    INSERT INTO s2_wiki_entity
                    (entity_id, entity_type, name, display_name, description, properties, summary, tags, version, parent_entity_id, topic_id, status, created_at, updated_at)
                    VALUES (?, ?, ?, ?, ?, ?::jsonb, ?, ?::text[], ?, ?, ?, ?, ?, ?, ?)
                    """;

    private static final String UPDATE_ENTITY_SQL =
            """
                    UPDATE s2_wiki_entity
                    SET entity_type = ?, name = ?, display_name = ?, description = ?, properties = ?::jsonb,
                        summary = ?, tags = ?::text[], version = ?, parent_entity_id = ?, topic_id = ?, status = ?, updated_at = ?
                    WHERE entity_id = ?
                    """;

    private static final String SELECT_BY_ID_SQL =
            "SELECT * FROM s2_wiki_entity WHERE entity_id = ?";

    private static final String SELECT_BY_TYPE_SQL =
            "SELECT * FROM s2_wiki_entity WHERE entity_type = ? AND status = 'ACTIVE'";

    private static final String SELECT_BY_TOPIC_SQL =
            "SELECT * FROM s2_wiki_entity WHERE topic_id = ? AND status = 'ACTIVE'";

    private static final String SELECT_BY_PARENT_SQL =
            "SELECT * FROM s2_wiki_entity WHERE parent_entity_id = ? AND status = 'ACTIVE'";

    private static final String SELECT_ALL_ACTIVE_SQL =
            "SELECT * FROM s2_wiki_entity WHERE status = 'ACTIVE'";

    private static final String DELETE_ENTITY_SQL =
            "UPDATE s2_wiki_entity SET status = 'DELETED', updated_at = ? WHERE entity_id = ?";

    // Entity-Topic association SQLs
    private static final String INSERT_ENTITY_TOPIC_SQL =
            "INSERT INTO s2_wiki_entity_topic (entity_id, topic_id, created_at) VALUES (?, ?, ?)";

    private static final String DELETE_ENTITY_TOPIC_SQL =
            "DELETE FROM s2_wiki_entity_topic WHERE entity_id = ? AND topic_id = ?";

    private static final String SELECT_TOPICS_BY_ENTITY_SQL =
            "SELECT topic_id FROM s2_wiki_entity_topic WHERE entity_id = ?";

    private static final String SELECT_ENTITIES_BY_TOPIC_SQL =
            "SELECT e.* FROM s2_wiki_entity e INNER JOIN s2_wiki_entity_topic et ON e.entity_id = et.entity_id WHERE et.topic_id = ? AND e.status = 'ACTIVE'";

    private static final String DELETE_ALL_ENTITY_TOPICS_SQL =
            "DELETE FROM s2_wiki_entity_topic WHERE entity_id = ?";

    private static final String SEARCH_ENTITIES_SQL =
            "SELECT * FROM s2_wiki_entity " + "WHERE status = 'ACTIVE' "
                    + "AND (name LIKE ? OR display_name LIKE ? OR description LIKE ?) " + "LIMIT ?";

    public WikiEntityService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Transactional
    public WikiEntity createEntity(WikiEntity entity) {
        if (!StringUtils.hasText(entity.getEntityId())) {
            entity.setEntityId(generateEntityId(entity));
        }
        entity.setCreatedAt(LocalDateTime.now());
        entity.setUpdatedAt(LocalDateTime.now());
        entity.setStatus("ACTIVE");
        if (entity.getVersion() == null) {
            entity.setVersion("1.0.0");
        }

        log.info("Creating wiki entity: {}", entity.getEntityId());

        jdbcTemplate.update(INSERT_ENTITY_SQL, entity.getEntityId(), entity.getEntityType(),
                entity.getName(), entity.getDisplayName(), entity.getDescription(),
                toJsonString(entity.getProperties()), entity.getSummary(),
                entity.getTags() != null ? entity.getTags().toArray(new String[0]) : null,
                entity.getVersion(), entity.getParentEntityId(), entity.getTopicId(),
                entity.getStatus(), entity.getCreatedAt(), entity.getUpdatedAt());

        return entity;
    }

    @Transactional
    public WikiEntity updateEntity(WikiEntity entity) {
        entity.setUpdatedAt(LocalDateTime.now());

        log.info("Updating wiki entity: {}", entity.getEntityId());

        jdbcTemplate.update(UPDATE_ENTITY_SQL, entity.getEntityType(), entity.getName(),
                entity.getDisplayName(), entity.getDescription(),
                toJsonString(entity.getProperties()), entity.getSummary(),
                entity.getTags() != null ? entity.getTags().toArray(new String[0]) : null,
                incrementVersion(entity.getVersion()), entity.getParentEntityId(),
                entity.getTopicId(), entity.getStatus(), entity.getUpdatedAt(),
                entity.getEntityId());

        return entity;
    }

    public WikiEntity getEntityById(String entityId) {
        List<WikiEntity> results =
                jdbcTemplate.query(SELECT_BY_ID_SQL, new WikiEntityRowMapper(), entityId);
        return results.isEmpty() ? null : results.get(0);
    }

    public List<WikiEntity> getEntitiesByType(String entityType) {
        List<WikiEntity> entities =
                jdbcTemplate.query(SELECT_BY_TYPE_SQL, new WikiEntityRowMapper(), entityType);
        // Batch fetch all entity-topic associations to avoid N+1 queries
        Map<String, List<String>> topicMap = getAllEntityTopicMappings();
        for (WikiEntity entity : entities) {
            entity.setTopicIds(topicMap.getOrDefault(entity.getEntityId(), new ArrayList<>()));
        }
        return entities;
    }

    public List<WikiEntity> getEntitiesByTopic(String topicId) {
        List<WikiEntity> entities =
                jdbcTemplate.query(SELECT_BY_TOPIC_SQL, new WikiEntityRowMapper(), topicId);
        // Batch fetch all entity-topic associations to avoid N+1 queries
        Map<String, List<String>> topicMap = getAllEntityTopicMappings();
        for (WikiEntity entity : entities) {
            entity.setTopicIds(topicMap.getOrDefault(entity.getEntityId(), new ArrayList<>()));
        }
        return entities;
    }

    public List<WikiEntity> getChildEntities(String parentEntityId) {
        List<WikiEntity> entities =
                jdbcTemplate.query(SELECT_BY_PARENT_SQL, new WikiEntityRowMapper(), parentEntityId);
        // Batch fetch all entity-topic associations to avoid N+1 queries
        Map<String, List<String>> topicMap = getAllEntityTopicMappings();
        for (WikiEntity entity : entities) {
            entity.setTopicIds(topicMap.getOrDefault(entity.getEntityId(), new ArrayList<>()));
        }
        return entities;
    }

    public List<WikiEntity> getAllActiveEntities() {
        List<WikiEntity> entities =
                jdbcTemplate.query(SELECT_ALL_ACTIVE_SQL, new WikiEntityRowMapper());
        // Batch fetch all entity-topic associations to avoid N+1 queries
        Map<String, List<String>> topicMap = getAllEntityTopicMappings();
        for (WikiEntity entity : entities) {
            entity.setTopicIds(topicMap.getOrDefault(entity.getEntityId(), new ArrayList<>()));
        }
        return entities;
    }

    private Map<String, List<String>> getAllEntityTopicMappings() {
        String sql = "SELECT entity_id, topic_id FROM s2_wiki_entity_topic";
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
        Map<String, List<String>> topicMap = new HashMap<>();
        for (Map<String, Object> row : rows) {
            String entityId = (String) row.get("entity_id");
            String topicId = (String) row.get("topic_id");
            topicMap.computeIfAbsent(entityId, k -> new ArrayList<>()).add(topicId);
        }
        return topicMap;
    }

    public List<WikiEntity> searchEntities(String queryText) {
        return searchEntities(queryText, 10);
    }

    public List<WikiEntity> searchEntities(String queryText, int limit) {
        if (queryText == null || queryText.trim().isEmpty()) {
            return new ArrayList<>();
        }
        String searchPattern = "%" + queryText.trim() + "%";
        return jdbcTemplate.query(SEARCH_ENTITIES_SQL, new WikiEntityRowMapper(), searchPattern,
                searchPattern, searchPattern, limit);
    }

    // Entity-Topic association methods
    @Transactional
    public void addTopicToEntity(String entityId, String topicId) {
        log.info("Adding topic {} to entity {}", topicId, entityId);
        jdbcTemplate.update(INSERT_ENTITY_TOPIC_SQL, entityId, topicId, LocalDateTime.now());
    }

    @Transactional
    public void removeTopicFromEntity(String entityId, String topicId) {
        log.info("Removing topic {} from entity {}", topicId, entityId);
        jdbcTemplate.update(DELETE_ENTITY_TOPIC_SQL, entityId, topicId);
    }

    public List<String> getTopicIdsByEntityId(String entityId) {
        List<String> topicIds =
                jdbcTemplate.queryForList(SELECT_TOPICS_BY_ENTITY_SQL, String.class, entityId);
        return topicIds;
    }

    public List<WikiEntity> getEntitiesByTopicId(String topicId) {
        return jdbcTemplate.query(SELECT_ENTITIES_BY_TOPIC_SQL, new WikiEntityRowMapper(), topicId);
    }

    public int countOrphanEntities() {
        // Count entities that are not referenced by any knowledge card or link
        String sql = "SELECT COUNT(*) FROM s2_wiki_entity e "
                + "WHERE e.status = 'ACTIVE' "
                + "AND NOT EXISTS (SELECT 1 FROM s2_wiki_knowledge_card k WHERE k.entity_id = e.entity_id) "
                + "AND NOT EXISTS (SELECT 1 FROM s2_wiki_link l WHERE l.source_entity_id = e.entity_id OR l.target_entity_id = e.entity_id) "
                + "AND e.entity_type != 'TOPIC'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    @Transactional
    public void setEntityTopics(String entityId, List<String> topicIds) {
        log.info("Setting topics for entity {}: {}", entityId, topicIds);
        // Remove all existing associations
        jdbcTemplate.update(DELETE_ALL_ENTITY_TOPICS_SQL, entityId);
        // Add new associations
        if (topicIds != null) {
            for (String topicId : topicIds) {
                if (StringUtils.hasText(topicId)) {
                    jdbcTemplate.update(INSERT_ENTITY_TOPIC_SQL, entityId, topicId,
                            LocalDateTime.now());
                }
            }
        }
    }

    @Transactional
    public void deleteEntity(String entityId) {
        log.info("Deleting wiki entity: {}", entityId);
        jdbcTemplate.update(DELETE_ENTITY_SQL, LocalDateTime.now(), entityId);
    }

    private String generateEntityId(WikiEntity entity) {
        if (entity.getEntityType().equals("TABLE")) {
            return "table:" + entity.getName();
        } else if (entity.getEntityType().equals("COLUMN")) {
            return "column:" + entity.getName();
        } else if (entity.getEntityType().equals("TOPIC")) {
            return "topic:" + entity.getName();
        }
        return "entity:" + UUID.randomUUID().toString();
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
            } else if (value instanceof List) {
                sb.append("[");
                List<?> list = (List<?>) value;
                for (int i = 0; i < list.size(); i++) {
                    if (i > 0)
                        sb.append(",");
                    sb.append("\"").append(list.get(i).toString().replace("\"", "\\\""))
                            .append("\"");
                }
                sb.append("]");
            } else {
                sb.append(value);
            }
            first = false;
        }
        sb.append("}");
        return sb.toString();
    }

    /**
     * 检测表名列表中哪些已存在
     * @param tableNames 要检测的表名列表
     * @return Map<tableName, "NEW"|"EXISTS">
     */
    public Map<String, String> detectConflicts(List<String> tableNames) {
        Map<String, String> result = new HashMap<>();
        if (tableNames == null || tableNames.isEmpty()) {
            return result;
        }
        String sql = "SELECT name FROM s2_wiki_entity WHERE entity_type = 'TABLE' AND status = 'ACTIVE' AND name = ?";
        for (String tableName : tableNames) {
            List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, tableName);
            result.put(tableName, rows.isEmpty() ? "NEW" : "EXISTS");
        }
        return result;
    }

    /**
     * 导入单个表的结构到 Wiki Entity
     */
    public void importTableSchema(TableSchema schema, String topicId) {
        String entityId = "table:" + schema.getTableName();

        // 检查是否已存在
        WikiEntity existing = getEntityById(entityId);
        if (existing != null) {
            // 更新
            existing.setDisplayName(schema.getTableComment());
            existing.setDescription(schema.getTableComment());
            existing.setTopicId(topicId);
            updateEntity(existing);
        } else {
            // 创建
            WikiEntity entity = new WikiEntity();
            entity.setEntityId(entityId);
            entity.setEntityType("TABLE");
            entity.setName(schema.getTableName());
            entity.setDisplayName(schema.getTableComment());
            entity.setDescription(schema.getTableComment());
            entity.setTopicId(topicId);
            entity.setStatus("ACTIVE");
            createEntity(entity);
        }

        // 处理字段 (COLUMN)
        for (com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema col : schema.getColumns()) {
            importColumnSchema(entityId, col);
        }
    }

    private void importColumnSchema(String parentEntityId, com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema col) {
        String columnEntityId = parentEntityId + ":column:" + col.getColumnName();

        WikiEntity existing = getEntityById(columnEntityId);
        Map<String, Object> props = new HashMap<>();
        props.put("dataType", col.getColumnType());

        if (existing != null) {
            existing.setDisplayName(col.getColumnComment());
            existing.setDescription(col.getColumnComment());
            existing.setProperties(props);
            updateEntity(existing);
        } else {
            WikiEntity columnEntity = new WikiEntity();
            columnEntity.setEntityId(columnEntityId);
            columnEntity.setEntityType("COLUMN");
            columnEntity.setName(col.getColumnName());
            columnEntity.setDisplayName(col.getColumnComment());
            columnEntity.setDescription(col.getColumnComment());
            columnEntity.setProperties(props);
            columnEntity.setParentEntityId(parentEntityId);
            columnEntity.setStatus("ACTIVE");
            createEntity(columnEntity);
        }
    }

    private static class WikiEntityRowMapper implements RowMapper<WikiEntity> {
        @Override
        public WikiEntity mapRow(ResultSet rs, int rowNum) throws SQLException {
            WikiEntity entity = new WikiEntity();
            entity.setId(rs.getLong("id"));
            entity.setEntityId(rs.getString("entity_id"));
            entity.setEntityType(rs.getString("entity_type"));
            entity.setName(rs.getString("name"));
            entity.setDisplayName(rs.getString("display_name"));
            entity.setDescription(rs.getString("description"));

            String propertiesStr = rs.getString("properties");
            entity.setProperties(parseJsonToMap(propertiesStr));

            entity.setSummary(rs.getString("summary"));

            Array tagsArrayResult = rs.getArray("tags");
            String[] tagsArray =
                    tagsArrayResult != null ? (String[]) tagsArrayResult.getArray() : null;
            entity.setTags(tagsArray != null ? List.of(tagsArray) : new ArrayList<>());

            entity.setVersion(rs.getString("version"));
            entity.setParentEntityId(rs.getString("parent_entity_id"));
            entity.setTopicId(rs.getString("topic_id"));
            entity.setStatus(rs.getString("status"));
            entity.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            entity.setUpdatedAt(rs.getTimestamp("updated_at") != null
                    ? rs.getTimestamp("updated_at").toLocalDateTime()
                    : null);
            return entity;
        }

        private Map<String, Object> parseJsonToMap(String json) {
            Map<String, Object> map = new HashMap<>();
            if (json == null || json.isEmpty()) {
                return map;
            }
            json = json.trim();
            if (json.startsWith("{") && json.endsWith("}")) {
                json = json.substring(1, json.length() - 1);
                if (json.isEmpty()) {
                    return map;
                }
                String[] pairs = json.split(",");
                for (String pair : pairs) {
                    String[] keyValue = pair.split(":", 2);
                    if (keyValue.length == 2) {
                        String key = keyValue[0].trim().replace("\"", "");
                        String value = keyValue[1].trim().replace("\"", "");
                        map.put(key, value);
                    }
                }
            }
            return map;
        }
    }
}
