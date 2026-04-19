package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import com.tencent.supersonic.headless.core.wiki.dto.DataSourceConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class WikiDataSourceService {

    private final JdbcTemplate jdbcTemplate;

    private static final String INSERT_SQL =
            """
                    INSERT INTO s2_wiki_datasource
                    (name, type, host, port, database_name, username, password_encrypted, properties, status, created_at, updated_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?::jsonb, ?, ?, ?)
                    """;

    private static final String UPDATE_SQL = """
            UPDATE s2_wiki_datasource
            SET name = ?, type = ?, host = ?, port = ?, database_name = ?, username = ?,
                password_encrypted = ?, properties = ?::jsonb, status = ?, updated_at = ?
            WHERE id = ?
            """;

    private static final String SELECT_ALL_SQL = """
            SELECT * FROM s2_wiki_datasource ORDER BY created_at DESC
            """;

    private static final String SELECT_BY_ID_SQL = """
            SELECT * FROM s2_wiki_datasource WHERE id = ?
            """;

    private static final String SELECT_BY_NAME_SQL = """
            SELECT * FROM s2_wiki_datasource WHERE name = ?
            """;

    private static final String DELETE_SQL = """
            DELETE FROM s2_wiki_datasource WHERE id = ?
            """;

    private static final String TEST_CONNECTION_SQL = """
            SELECT 1
            """;

    public WikiDataSourceService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Transactional
    public DataSourceConfig create(DataSourceConfig config) {
        config.setCreatedAt(LocalDateTime.now());
        config.setUpdatedAt(LocalDateTime.now());
        if (config.getStatus() == null) {
            config.setStatus("ACTIVE");
        }

        log.info("Creating datasource: {}", config.getName());

        jdbcTemplate.update(INSERT_SQL, config.getName(), config.getType(), config.getHost(),
                config.getPort(), config.getDatabaseName(), config.getUsername(),
                config.getPasswordEncrypted(), toJsonString(config.getProperties()),
                config.getStatus(), config.getCreatedAt(), config.getUpdatedAt());

        DataSourceConfig saved = findByName(config.getName());
        config.setId(saved.getId());
        return config;
    }

    @Transactional
    public DataSourceConfig update(DataSourceConfig config) {
        config.setUpdatedAt(LocalDateTime.now());

        log.info("Updating datasource: {} (id={})", config.getName(), config.getId());

        jdbcTemplate.update(UPDATE_SQL, config.getName(), config.getType(), config.getHost(),
                config.getPort(), config.getDatabaseName(), config.getUsername(),
                config.getPasswordEncrypted(), toJsonString(config.getProperties()),
                config.getStatus(), config.getUpdatedAt(), config.getId());

        return config;
    }

    public List<DataSourceConfig> list() {
        return jdbcTemplate.query(SELECT_ALL_SQL, new DataSourceConfigRowMapper());
    }

    public DataSourceConfig getById(Long id) {
        List<DataSourceConfig> results =
                jdbcTemplate.query(SELECT_BY_ID_SQL, new DataSourceConfigRowMapper(), id);
        return results.isEmpty() ? null : results.get(0);
    }

    public DataSourceConfig findByName(String name) {
        List<DataSourceConfig> results =
                jdbcTemplate.query(SELECT_BY_NAME_SQL, new DataSourceConfigRowMapper(), name);
        return results.isEmpty() ? null : results.get(0);
    }

    @Transactional
    public void delete(Long id) {
        log.info("Deleting datasource: {}", id);
        jdbcTemplate.update(DELETE_SQL, id);
    }

    public boolean testConnection(Long id) {
        DataSourceConfig config = getById(id);
        if (config == null) {
            log.warn("Datasource not found: {}", id);
            return false;
        }

        try {
            javax.sql.DataSource testDs = createTestDataSource(config);
            JdbcTemplate testTemplate = new JdbcTemplate(testDs);
            testTemplate.queryForList(TEST_CONNECTION_SQL);
            log.info("Connection test successful for datasource: {}", config.getName());
            return true;
        } catch (Exception e) {
            log.error("Connection test failed for datasource: {}", config.getName(), e);
            return false;
        }
    }

    public List<TableSchema> parseSchemaFromSource(Long dataSourceId) {
        DataSourceConfig config = getById(dataSourceId);
        if (config == null) {
            throw new RuntimeException("DataSource not found: " + dataSourceId);
        }

        log.info("Parsing schema from datasource: {}", config.getName());

        List<TableSchema> tables = new ArrayList<>();

        try {
            javax.sql.DataSource sourceDs = createTestDataSource(config);
            JdbcTemplate sourceTemplate = new JdbcTemplate(sourceDs);

            String schemaSql;
            if ("MYSQL".equalsIgnoreCase(config.getType())) {
                schemaSql = """
                        SELECT TABLE_NAME, TABLE_COMMENT
                        FROM INFORMATION_SCHEMA.TABLES
                        WHERE TABLE_SCHEMA = ?
                        ORDER BY TABLE_NAME
                        """;
            } else {
                schemaSql = """
                        SELECT TABLE_NAME, ''
                        FROM INFORMATION_SCHEMA.TABLES
                        WHERE TABLE_CATALOG = CURRENT_CATALOG
                        ORDER BY TABLE_NAME
                        """;
            }

            List<Map<String, Object>> tableRows;
            if ("MYSQL".equalsIgnoreCase(config.getType())) {
                tableRows = sourceTemplate.queryForList(schemaSql, config.getDatabaseName());
            } else {
                tableRows = sourceTemplate.queryForList(schemaSql);
            }

            for (Map<String, Object> tableRow : tableRows) {
                String tableName = (String) tableRow.get("TABLE_NAME");
                String tableComment = tableRow.get("TABLE_COMMENT") != null
                        ? (String) tableRow.get("TABLE_COMMENT")
                        : "";

                TableSchema tableSchema = new TableSchema();
                tableSchema.setTableName(tableName);
                tableSchema.setTableComment(tableComment);
                tableSchema.setColumns(parseColumnsFromTable(sourceTemplate, config, tableName));

                tables.add(tableSchema);
            }

            log.info("Parsed {} tables from datasource: {}", tables.size(), config.getName());

        } catch (Exception e) {
            log.error("Failed to parse schema from datasource: {}", config.getName(), e);
            throw new RuntimeException("Failed to parse schema: " + e.getMessage(), e);
        }

        return tables;
    }

    private List<com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema> parseColumnsFromTable(
            JdbcTemplate sourceTemplate, DataSourceConfig config, String tableName) {

        List<com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema> columns =
                new ArrayList<>();

        String columnSql;
        if ("MYSQL".equalsIgnoreCase(config.getType())) {
            columnSql =
                    """
                            SELECT COLUMN_NAME, COLUMN_TYPE, COLUMN_COMMENT, IS_NULLABLE, COLUMN_KEY, COLUMN_DEFAULT
                            FROM INFORMATION_SCHEMA.COLUMNS
                            WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?
                            ORDER BY ORDINAL_POSITION
                            """;
        } else {
            columnSql =
                    """
                            SELECT COLUMN_NAME, DATA_TYPE, '', CASE WHEN IS_NULLABLE = 'YES' THEN true ELSE false END, '', ''
                            FROM INFORMATION_SCHEMA.COLUMNS
                            WHERE TABLE_CATALOG = CURRENT_CATALOG AND TABLE_NAME = ?
                            ORDER BY ORDINAL_POSITION
                            """;
        }

        List<Map<String, Object>> columnRows;
        if ("MYSQL".equalsIgnoreCase(config.getType())) {
            columnRows =
                    sourceTemplate.queryForList(columnSql, config.getDatabaseName(), tableName);
        } else {
            columnRows = sourceTemplate.queryForList(columnSql, tableName);
        }

        for (Map<String, Object> columnRow : columnRows) {
            com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema column =
                    new com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema();
            column.setColumnName((String) columnRow.get("COLUMN_NAME"));

            String columnType =
                    columnRow.get("COLUMN_TYPE") != null ? (String) columnRow.get("COLUMN_TYPE")
                            : (String) columnRow.get("DATA_TYPE");
            column.setColumnType(columnType);

            String columnComment = columnRow.get("COLUMN_COMMENT") != null
                    ? (String) columnRow.get("COLUMN_COMMENT")
                    : "";
            column.setColumnComment(columnComment);

            String columnKey =
                    columnRow.get("COLUMN_KEY") != null ? (String) columnRow.get("COLUMN_KEY") : "";
            column.setIsPrimaryKey("PRI".equalsIgnoreCase(columnKey));

            columns.add(column);
        }

        return columns;
    }

    private javax.sql.DataSource createTestDataSource(DataSourceConfig config) {
        String url;

        if ("MYSQL".equalsIgnoreCase(config.getType())) {
            url = String.format("jdbc:mysql://%s:%d/%s?useSSL=false&serverTimezone=UTC",
                    config.getHost(), config.getPort(), config.getDatabaseName());
        } else if ("POSTGRESQL".equalsIgnoreCase(config.getType())) {
            url = String.format("jdbc:postgresql://%s:%d/%s", config.getHost(), config.getPort(),
                    config.getDatabaseName());
        } else {
            throw new RuntimeException("Unsupported datasource type: " + config.getType());
        }

        com.zaxxer.hikari.HikariConfig hikariConfig = new com.zaxxer.hikari.HikariConfig();
        hikariConfig.setJdbcUrl(url);
        hikariConfig.setUsername(config.getUsername());
        hikariConfig.setPassword(config.getPasswordEncrypted());
        hikariConfig.setMaximumPoolSize(5);
        hikariConfig.setMinimumIdle(1);

        return new com.zaxxer.hikari.HikariDataSource(hikariConfig);
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

    private static class DataSourceConfigRowMapper implements RowMapper<DataSourceConfig> {
        @Override
        public DataSourceConfig mapRow(ResultSet rs, int rowNum) throws SQLException {
            DataSourceConfig config = new DataSourceConfig();
            config.setId(rs.getLong("id"));
            config.setName(rs.getString("name"));
            config.setType(rs.getString("type"));
            config.setHost(rs.getString("host"));
            config.setPort(rs.getInt("port"));
            config.setDatabaseName(rs.getString("database_name"));
            config.setUsername(rs.getString("username"));
            config.setPasswordEncrypted(rs.getString("password_encrypted"));

            String propertiesStr = rs.getString("properties");
            config.setProperties(parseJsonToMap(propertiesStr));

            config.setStatus(rs.getString("status"));
            config.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            config.setUpdatedAt(rs.getTimestamp("updated_at") != null
                    ? rs.getTimestamp("updated_at").toLocalDateTime()
                    : null);
            return config;
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
