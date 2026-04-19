package com.tencent.supersonic.text2sql;

import javax.sql.DataSource;

import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.model.embedding.EmbeddingModel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class SchemaKnowledgeService {

    private final JdbcTemplate jdbcTemplate;
    private EmbeddingModel embeddingModel;

    public enum DatabaseType {
        MYSQL, POSTGRESQL, ORACLE, SQLSERVER, SQLITE
    }

    private static final String SEARCH_SQL = """
            SELECT id, table_name, table_comment, column_name, column_comment,
                   column_type, is_primary_key, is_foreign_key, fk_reference,
                   1 - (embedding <=> ?::vector) as similarity
            FROM s2_schema_knowledge
            WHERE embedding <=> ?::vector < 1.0
            ORDER BY embedding <=> ?::vector
            LIMIT ?
            """;

    private static final String SEARCH_BY_TABLE_SQL = """
            SELECT id, table_name, table_comment, column_name, column_comment,
                   column_type, is_primary_key, is_foreign_key, fk_reference,
                   1 - (embedding <=> ?::vector) as similarity
            FROM s2_schema_knowledge
            WHERE table_name = ? AND embedding <=> ?::vector < 1.0
            ORDER BY embedding <=> ?::vector
            LIMIT ?
            """;

    private static final String INSERT_SQL = """
            INSERT INTO s2_schema_knowledge
            (table_name, table_comment, column_name, column_comment, column_type,
             is_primary_key, is_foreign_key, fk_reference, knowledge_text, embedding)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?::vector)
            """;

    private static final String DELETE_SQL = "DELETE FROM s2_schema_knowledge";

    public SchemaKnowledgeService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Autowired(required = false)
    public void setEmbeddingModel(EmbeddingModel embeddingModel) {
        this.embeddingModel = embeddingModel;
    }

    public int buildKnowledgeBase(String sqlFilePath, List<String> targetTables) {
        return buildKnowledgeBase(sqlFilePath, targetTables, "MYSQL", null);
    }

    public int buildKnowledgeBase(String sqlFilePath, List<String> targetTables,
            String databaseTypeStr, String sqlContent) {
        log.info("Starting knowledge base build from: {}, target tables: {}, databaseType: {}",
                sqlFilePath, targetTables, databaseTypeStr);

        try {
            String content;
            if (sqlContent != null && !sqlContent.isEmpty()) {
                content = sqlContent;
            } else {
                content = Files.readString(Path.of(sqlFilePath));
            }

            DatabaseType databaseType = parseDatabaseType(databaseTypeStr);
            List<TableSchemaInfo> tables =
                    parseSqlFileInternal(content, targetTables, databaseType);

            jdbcTemplate.update(DELETE_SQL);

            int totalColumns = 0;
            for (TableSchemaInfo table : tables) {
                for (ColumnSchemaInfo column : table.columns) {
                    String knowledgeText = buildKnowledgeText(table, column);
                    float[] embeddingVector = generateEmbedding(knowledgeText);
                    String embeddingStr = arrayToPostgresVector(embeddingVector);

                    jdbcTemplate.update(INSERT_SQL, table.tableName, table.tableComment,
                            column.columnName, column.columnComment, column.columnType,
                            column.isPrimaryKey, column.isForeignKey, column.fkReference,
                            knowledgeText, embeddingStr);
                    totalColumns++;
                }
            }

            log.info("Knowledge base build completed: {} tables, {} columns", tables.size(),
                    totalColumns);
            return totalColumns;

        } catch (Exception e) {
            log.error("Failed to build knowledge base", e);
            throw new RuntimeException("Failed to build knowledge base: " + e.getMessage(), e);
        }
    }

    public List<TableSchemaInfo> parseSqlFileOnly(String sqlFilePath) {
        return parseSqlFileOnly(sqlFilePath, "MYSQL", null);
    }

    public List<TableSchemaInfo> parseSqlFileOnly(String sqlFilePath, String databaseTypeStr,
            String sqlContent) {
        log.info("Parsing SQL file: {}, databaseType: {}", sqlFilePath, databaseTypeStr);

        try {
            String content;
            if (sqlContent != null && !sqlContent.isEmpty()) {
                content = sqlContent;
            } else {
                content = Files.readString(Path.of(sqlFilePath));
            }

            DatabaseType databaseType = parseDatabaseType(databaseTypeStr);
            List<TableSchemaInfo> tables = parseSqlFileInternal(content, null, databaseType);

            for (TableSchemaInfo table : tables) {
                table.setColumnCount(table.getColumns() != null ? table.getColumns().size() : 0);
            }

            log.info("Parse SQL file completed: {} tables", tables.size());
            return tables;

        } catch (Exception e) {
            log.error("Failed to parse SQL file", e);
            throw new RuntimeException("Failed to parse SQL file: " + e.getMessage(), e);
        }
    }

    public Map<String, Object> getKnowledgeStats() {
        log.info("Getting knowledge base stats");

        try {
            String countSql =
                    "SELECT COUNT(DISTINCT table_name) as table_count, COUNT(*) as column_count, MAX(updated_time) as last_update FROM s2_schema_knowledge";
            Map<String, Object> stats = jdbcTemplate.queryForMap(countSql);

            log.info("Knowledge base stats: {}", stats);
            return stats;

        } catch (Exception e) {
            log.error("Failed to get knowledge base stats", e);
            throw new RuntimeException("Failed to get knowledge base stats: " + e.getMessage(), e);
        }
    }

    public void clearKnowledge() {
        log.info("Clearing knowledge base");

        try {
            int deleted = jdbcTemplate.update(DELETE_SQL);
            log.info("Knowledge base cleared: {} records deleted", deleted);

        } catch (Exception e) {
            log.error("Failed to clear knowledge base", e);
            throw new RuntimeException("Failed to clear knowledge base: " + e.getMessage(), e);
        }
    }

    private List<TableSchemaInfo> parseSqlFileInternal(String content, List<String> targetTables,
            DatabaseType databaseType) {
        List<TableSchemaInfo> tables = new ArrayList<>();

        String tablePatternStr = getTableNamePattern(databaseType);
        Pattern tablePattern = Pattern.compile(tablePatternStr, Pattern.CASE_INSENSITIVE);
        Matcher tableMatcher = tablePattern.matcher(content);

        while (tableMatcher.find()) {
            String tableName = tableMatcher.group(1);

            if (targetTables != null && !targetTables.isEmpty()
                    && !targetTables.contains(tableName)) {
                continue;
            }

            int startPos = tableMatcher.end();
            int endPos = findMatchingClosingParen(content, startPos);

            if (endPos > startPos) {
                String columnsBlock = content.substring(startPos, endPos);
                TableSchemaInfo table = new TableSchemaInfo();
                table.tableName = tableName;
                table.columns = parseColumns(columnsBlock, databaseType);
                tables.add(table);
            }
        }

        return tables;
    }

    private String getTableNamePattern(DatabaseType databaseType) {
        return switch (databaseType) {
            case MYSQL -> "CREATE TABLE `(\\w+)`\\s*\\(";
            case POSTGRESQL, ORACLE, SQLSERVER, SQLITE -> "CREATE TABLE \"?(\\w+)\"?\\s*\\(";
        };
    }

    private DatabaseType parseDatabaseType(String databaseTypeStr) {
        if (databaseTypeStr == null || databaseTypeStr.isEmpty()) {
            return DatabaseType.MYSQL;
        }
        try {
            return DatabaseType.valueOf(databaseTypeStr.toUpperCase());
        } catch (IllegalArgumentException e) {
            log.warn("Unknown database type: {}, defaulting to MYSQL", databaseTypeStr);
            return DatabaseType.MYSQL;
        }
    }

    private int findMatchingClosingParen(String content, int startPos) {
        int parenCount = 1;
        int i = startPos;
        while (i < content.length() && parenCount > 0) {
            char c = content.charAt(i);
            if (c == '(' && (i == 0 || content.charAt(i - 1) != '\'')) {
                parenCount++;
            } else if (c == ')' && (i == 0 || content.charAt(i - 1) != '\'')) {
                parenCount--;
            }
            i++;
        }
        if (parenCount == 0) {
            while (i < content.length() && Character.isWhitespace(content.charAt(i))) {
                i++;
            }
            while (i > startPos && !Character.isLetter(content.charAt(i - 1))) {
                i--;
            }
            return i - 1;
        }
        return -1;
    }

    private List<ColumnSchemaInfo> parseColumns(String block, DatabaseType databaseType) {
        List<ColumnSchemaInfo> columns = new ArrayList<>();
        String[] lines = block.split("\n");

        String colPatternStr = getColumnPattern(databaseType);
        Pattern colPattern = Pattern.compile(colPatternStr, Pattern.CASE_INSENSITIVE);

        Pattern pkPattern = Pattern.compile("PRIMARY\\s+KEY", Pattern.CASE_INSENSITIVE);
        Pattern fkPattern = Pattern.compile("FOREIGN\\s+KEY", Pattern.CASE_INSENSITIVE);

        String identifierQuote = getIdentifierQuote(databaseType);

        boolean inPrimaryKey = false;
        boolean inForeignKey = false;

        for (String line : lines) {
            String trimmedLine = line.trim();

            if (pkPattern.matcher(trimmedLine).find()) {
                inPrimaryKey = true;
                continue;
            }
            if (fkPattern.matcher(trimmedLine).find()) {
                inForeignKey = true;
                continue;
            }
            if (trimmedLine.startsWith("PRIMARY KEY") || trimmedLine.startsWith("FOREIGN KEY")
                    || trimmedLine.startsWith("INDEX") || trimmedLine.startsWith("KEY")
                    || trimmedLine.startsWith("CONSTRAINT") || trimmedLine.startsWith("UNIQUE")
                    || trimmedLine.startsWith("--") || trimmedLine.startsWith("ENGINE")
                    || trimmedLine.isEmpty()) {
                if (!trimmedLine.contains(identifierQuote)) {
                    inPrimaryKey = false;
                    inForeignKey = false;
                }
                continue;
            }

            Matcher colMatcher = colPattern.matcher(trimmedLine);
            if (colMatcher.find()) {
                ColumnSchemaInfo column = new ColumnSchemaInfo();
                column.columnName = colMatcher.group(1);
                column.columnType = colMatcher.group(2);
                column.columnComment = colMatcher.group(3);
                column.isPrimaryKey = inPrimaryKey;
                column.isForeignKey = inForeignKey;
                columns.add(column);
                inPrimaryKey = false;
                inForeignKey = false;
            }
        }

        return columns;
    }

    private String getColumnPattern(DatabaseType databaseType) {
        String quote = getIdentifierQuote(databaseType);
        return switch (databaseType) {
            case MYSQL -> quote + "(\\w+)" + quote
                    + "\\s+(\\w+(?:\\s*\\([^)]+\\))?)\\s*(?:COMMENT\\s+'([^']+)')?";
            default -> "(?:\"?(\\w+)\"?|(?:" + quote + "(\\w+)" + quote
                    + "))\\s+(\\w+(?:\\s*\\([^)]+\\))?)\\s*(?:COMMENT\\s+'([^']+)')?";
        };
    }

    private String getIdentifierQuote(DatabaseType databaseType) {
        return switch (databaseType) {
            case MYSQL -> "`";
            default -> "\"";
        };
    }

    private String buildKnowledgeText(TableSchemaInfo table, ColumnSchemaInfo column) {
        StringBuilder sb = new StringBuilder();
        sb.append("表名: ").append(table.tableName).append("\n");
        sb.append("表注释: ").append(table.tableComment != null ? table.tableComment : "")
                .append("\n");
        sb.append("列: ").append(column.columnName).append(" (").append(column.columnType)
                .append(")");
        if (column.columnComment != null && !column.columnComment.isEmpty()) {
            sb.append(" - ").append(column.columnComment);
        }
        if (column.isPrimaryKey) {
            sb.append(" [主键]");
        }
        if (column.isForeignKey) {
            sb.append(" [外键]");
        }
        return sb.toString();
    }

    private float[] generateEmbedding(String text) {
        if (embeddingModel == null) {
            throw new RuntimeException(
                    "EmbeddingModel is not configured. Please check s2.embedding configuration.");
        }
        try {
            Embedding embedding = embeddingModel.embed(text).content();
            return embedding.vector();
        } catch (Exception e) {
            log.error("Failed to generate embedding for text: {}", text, e);
            throw new RuntimeException("Failed to generate embedding", e);
        }
    }

    private String arrayToPostgresVector(float[] array) {
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

    public static class TableSchemaInfo {
        public String tableName;
        public String tableComment;
        public List<ColumnSchemaInfo> columns = new ArrayList<>();
        public Integer columnCount;

        public String getTableName() {
            return tableName;
        }

        public void setTableName(String tableName) {
            this.tableName = tableName;
        }

        public String getTableComment() {
            return tableComment;
        }

        public void setTableComment(String tableComment) {
            this.tableComment = tableComment;
        }

        public List<ColumnSchemaInfo> getColumns() {
            return columns;
        }

        public void setColumns(List<ColumnSchemaInfo> columns) {
            this.columns = columns;
        }

        public Integer getColumnCount() {
            return columnCount;
        }

        public void setColumnCount(Integer columnCount) {
            this.columnCount = columnCount;
        }
    }

    public static class ColumnSchemaInfo {
        public String columnName;
        public String columnType;
        public String columnComment;
        public Boolean isPrimaryKey;
        public Boolean isForeignKey;
        public String fkReference;

        public String getColumnName() {
            return columnName;
        }

        public void setColumnName(String columnName) {
            this.columnName = columnName;
        }

        public String getColumnType() {
            return columnType;
        }

        public void setColumnType(String columnType) {
            this.columnType = columnType;
        }

        public String getColumnComment() {
            return columnComment;
        }

        public void setColumnComment(String columnComment) {
            this.columnComment = columnComment;
        }

        public Boolean getIsPrimaryKey() {
            return isPrimaryKey;
        }

        public void setIsPrimaryKey(Boolean isPrimaryKey) {
            this.isPrimaryKey = isPrimaryKey;
        }

        public Boolean getIsForeignKey() {
            return isForeignKey;
        }

        public void setIsForeignKey(Boolean isForeignKey) {
            this.isForeignKey = isForeignKey;
        }

        public String getFkReference() {
            return fkReference;
        }

        public void setFkReference(String fkReference) {
            this.fkReference = fkReference;
        }
    }

    public List<SchemaKnowledge> searchSimilar(String query, int topK) {
        if (embeddingModel == null) {
            log.warn("EmbeddingModel is not configured, returning empty results");
            return new ArrayList<>();
        }
        try {
            Embedding embedding = embeddingModel.embed(query).content();
            float[] embeddingVector = embedding.vector();

            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for (int i = 0; i < embeddingVector.length; i++) {
                if (i > 0)
                    sb.append(",");
                sb.append(embeddingVector[i]);
            }
            sb.append("]");

            List<SchemaKnowledge> results = jdbcTemplate.query(SEARCH_SQL,
                    new Object[] {sb.toString(), sb.toString(), sb.toString(), topK},
                    new SchemaKnowledgeRowMapper());

            log.info("Search query: '{}', found {} results", query, results.size());
            return results;

        } catch (Exception e) {
            log.error("Error searching schema knowledge for query: {}", query, e);
            return new ArrayList<>();
        }
    }

    public List<SchemaKnowledge> searchByTable(String query, String tableName, int topK) {
        if (embeddingModel == null) {
            log.warn("EmbeddingModel is not configured, returning empty results");
            return new ArrayList<>();
        }
        try {
            Embedding embedding = embeddingModel.embed(query).content();
            float[] embeddingVector = embedding.vector();

            StringBuilder sb = new StringBuilder();
            sb.append("[");
            for (int i = 0; i < embeddingVector.length; i++) {
                if (i > 0)
                    sb.append(",");
                sb.append(embeddingVector[i]);
            }
            sb.append("]");

            List<SchemaKnowledge> results = jdbcTemplate.query(SEARCH_BY_TABLE_SQL,
                    new Object[] {sb.toString(), tableName, sb.toString(), sb.toString(), topK},
                    new SchemaKnowledgeRowMapper());

            log.info("Search query: '{}' in table: {}, found {} results", query, tableName,
                    results.size());
            return results;

        } catch (Exception e) {
            log.error("Error searching schema knowledge for query: {} in table: {}", query,
                    tableName, e);
            return new ArrayList<>();
        }
    }

    public String buildSchemaContext(List<SchemaKnowledge> schemas) {
        StringBuilder context = new StringBuilder();

        java.util.Map<String, List<SchemaKnowledge>> tableGroups = new java.util.LinkedHashMap<>();
        for (SchemaKnowledge schema : schemas) {
            tableGroups.computeIfAbsent(schema.getTableName(), k -> new ArrayList<>()).add(schema);
        }

        for (java.util.Map.Entry<String, List<SchemaKnowledge>> entry : tableGroups.entrySet()) {
            String tableName = entry.getKey();
            List<SchemaKnowledge> columns = entry.getValue();

            SchemaKnowledge first = columns.get(0);
            context.append("表名: ").append(tableName).append("\n");
            context.append("表注释: ").append(first.getTableComment()).append("\n");
            context.append("列:\n");

            for (SchemaKnowledge column : columns) {
                context.append("  - ").append(column.getColumnName()).append(" (")
                        .append(column.getColumnType()).append(")").append(" - ")
                        .append(column.getColumnComment());

                if (Boolean.TRUE.equals(column.getIsPrimaryKey())) {
                    context.append(" [主键]");
                }
                if (Boolean.TRUE.equals(column.getIsForeignKey())) {
                    context.append(" [外键: ").append(column.getFkReference()).append("]");
                }
                context.append("\n");
            }
            context.append("\n");
        }

        return context.toString();
    }

    private static class SchemaKnowledgeRowMapper implements RowMapper<SchemaKnowledge> {
        @Override
        public SchemaKnowledge mapRow(ResultSet rs, int rowNum) throws SQLException {
            SchemaKnowledge schema = new SchemaKnowledge();
            schema.setId(rs.getLong("id"));
            schema.setTableName(rs.getString("table_name"));
            schema.setTableComment(rs.getString("table_comment"));
            schema.setColumnName(rs.getString("column_name"));
            schema.setColumnComment(rs.getString("column_comment"));
            schema.setColumnType(rs.getString("column_type"));
            schema.setIsPrimaryKey(rs.getBoolean("is_primary_key"));
            schema.setIsForeignKey(rs.getBoolean("is_foreign_key"));
            schema.setFkReference(rs.getString("fk_reference"));
            schema.setSimilarity(rs.getDouble("similarity"));
            return schema;
        }
    }
}
