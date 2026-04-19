package com.tencent.supersonic.headless.core.wiki;

import com.tencent.supersonic.headless.core.wiki.dto.*;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import com.tencent.supersonic.headless.core.wiki.service.AutoKnowledgeGenerator;
import com.tencent.supersonic.headless.core.wiki.service.WikiDataSourceService;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiKnowledgeService;

import java.util.stream.Collectors;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/wiki/schema")
@RequiredArgsConstructor
@Slf4j
public class WikiSchemaController {
    private final JdbcTemplate jdbcTemplate;
    private final WikiEntityService entityService;
    private final WikiKnowledgeService knowledgeService;
    private final AutoKnowledgeGenerator autoKnowledgeGenerator;
    private final WikiDataSourceService dataSourceService;

    @GetMapping("/template")
    public BaseResp<String> getImportTemplate() {
        return BaseResp.ok(getSqlTemplate());
    }

    @PostMapping("/validate")
    public BaseResp<ImportPreview> validateScript(@RequestBody String sqlScript) {
        try {
            ImportPreview preview = parseSqlPreview(sqlScript);
            return BaseResp.ok(preview);
        } catch (Exception e) {
            log.error("Failed to validate script", e);
            return BaseResp.fail("Validation failed: " + e.getMessage());
        }
    }

    @PostMapping("/import")
    @Transactional
    public BaseResp<ImportResult> executeImport(@RequestBody String sqlScript) {
        try {
            ImportResult result = new ImportResult();
            executeSqlScript(sqlScript, result);
            return BaseResp.ok(result);
        } catch (Exception e) {
            log.error("Failed to execute import", e);
            return BaseResp.fail("Import failed: " + e.getMessage());
        }
    }

    @PostMapping("/auto-generate/{entityId}")
    public BaseResp<List<WikiKnowledgeCard>> autoGenerateKnowledge(@PathVariable String entityId) {
        try {
            WikiEntity entity = entityService.getEntityById(entityId);
            if (entity == null) {
                return BaseResp.fail("Entity not found: " + entityId);
            }
            List<WikiKnowledgeCard> cards = autoKnowledgeGenerator.generateFromTableSchema(entity);
            return BaseResp.ok(cards);
        } catch (Exception e) {
            log.error("Failed to auto-generate knowledge", e);
            return BaseResp.fail("Auto-generate failed: " + e.getMessage());
        }
    }

    @GetMapping("/import-preview/{dataSourceId}")
    public BaseResp<TableImportPreview> getImportPreview(@PathVariable Long dataSourceId) {
        try {
            // 解析数据源 schema
            List<TableSchema> schemas = dataSourceService.parseSchemaFromSource(dataSourceId);

            // 收集所有表名
            List<String> tableNames = schemas.stream()
                .map(TableSchema::getTableName)
                .collect(Collectors.toList());

            // 检测冲突
            Map<String, String> conflicts = entityService.detectConflicts(tableNames);

            // 构建预览数据
            List<TableImportPreview.TablePreviewItem> items = new ArrayList<>();
            for (TableSchema schema : schemas) {
                TableImportPreview.TablePreviewItem item = new TableImportPreview.TablePreviewItem();
                item.setTableName(schema.getTableName());
                item.setDisplayName(schema.getTableComment());
                item.setDescription(schema.getTableComment());
                item.setConflictStatus(conflicts.getOrDefault(schema.getTableName(), "NEW"));

                List<TableImportPreview.ColumnPreviewItem> cols = new ArrayList<>();
                for (com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema col : schema.getColumns()) {
                    TableImportPreview.ColumnPreviewItem ci = new TableImportPreview.ColumnPreviewItem();
                    ci.setColumnName(col.getColumnName());
                    ci.setDisplayName(col.getColumnComment());
                    ci.setDescription(col.getColumnComment());
                    ci.setDataType(col.getColumnType());
                    cols.add(ci);
                }
                item.setColumns(cols);
                items.add(item);
            }

            TableImportPreview preview = new TableImportPreview();
            preview.setTables(items);
            preview.setTotalCount(items.size());
            preview.setConflictCount((int) items.stream().filter(i -> "EXISTS".equals(i.getConflictStatus())).count());
            preview.setNewCount((int) items.stream().filter(i -> "NEW".equals(i.getConflictStatus())).count());

            return BaseResp.ok(preview);
        } catch (Exception e) {
            log.error("Failed to get import preview", e);
            return BaseResp.fail("获取预览失败: " + e.getMessage());
        }
    }

    @PostMapping("/import-from-datasource/{dataSourceId}")
    @Transactional
    public BaseResp<ImportResult> importFromDataSource(@PathVariable Long dataSourceId, @RequestBody List<TableSelection> selections) {
        try {
            // 解析数据源 schema
            List<TableSchema> schemas = dataSourceService.parseSchemaFromSource(dataSourceId);

            ImportResult result = new ImportResult();
            int successCount = 0;
            int skipCount = 0;
            int failCount = 0;
            List<String> failedTables = new ArrayList<>();

            for (TableSelection sel : selections) {
                if (TableSelection.ACTION_SKIP.equals(sel.getAction())) {
                    skipCount++;
                    continue;
                }

                // 查找对应的 schema
                TableSchema schema = schemas.stream()
                    .filter(s -> sel.getTableName().equals(s.getTableName()))
                    .findFirst()
                    .orElse(null);

                if (schema == null) {
                    failCount++;
                    failedTables.add(sel.getTableName());
                    continue;
                }

                try {
                    entityService.importTableSchema(schema, null);
                    successCount++;
                } catch (Exception e) {
                    failCount++;
                    failedTables.add(sel.getTableName());
                    log.error("Failed to import table: {}", sel.getTableName(), e);
                }
            }

            result.setSuccessCount(successCount);
            result.setSkipCount(skipCount);
            result.setFailCount(failCount);
            result.setFailedTables(failedTables);

            return BaseResp.ok(result);
        } catch (Exception e) {
            log.error("Failed to import from datasource", e);
            return BaseResp.fail("导入失败: " + e.getMessage());
        }
    }

    private String getSqlTemplate() {
        return """
            -- ============================================
            -- LLM-SQL-Wiki 表结构导入脚本
            -- 导入前请确保已在数据库执行 wiki_schema.sql
            -- ============================================

            -- 1. 定义主题（Topic）
            INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, topic_id, status)
            VALUES ('topic:heating', 'TOPIC', 'heating', '采暖主题', '与采暖相关的所有业务表', 'topic:heating', 'ACTIVE');

            -- 2. 定义表（Table）
            INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, topic_id, status)
            VALUES ('table:sales_order', 'TABLE', 'sales_order', '销售订单表', '存储所有销售订单信息',
                '{"database": "heating_analytics", "schema": "public"}', 'topic:heating', 'ACTIVE');

            -- 3. 定义字段（Column）
            INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
            VALUES
              ('table:sales_order:column:order_amount', 'COLUMN', 'order_amount', '订单金额', '销售订单的总金额（元）',
               '{"dataType": "DECIMAL(15,2)", "nullable": true}', 'table:sales_order', 'ACTIVE'),
              ('table:sales_order:column:buyer_name', 'COLUMN', 'buyer_name', '客户名称', '购买方名称',
               '{"dataType": "VARCHAR(128)", "nullable": false}', 'table:sales_order', 'ACTIVE'),
              ('table:sales_order:column:qfje', 'COLUMN', 'qfje', '欠费金额', '当前欠费金额',
               '{"dataType": "DECIMAL(15,2)", "nullable": false, "businessNote": "qfje > 0 表示存在欠费"}',
               'table:sales_order', 'ACTIVE');
            """;
    }

    private ImportPreview parseSqlPreview(String sqlScript) {
        ImportPreview preview = new ImportPreview();
        // Simple parsing - count INSERT statements
        String[] lines = sqlScript.split(";");
        int topicCount = 0;
        int tableCount = 0;
        int columnCount = 0;

        for (String line : lines) {
            if (line.contains("'TOPIC'") || line.contains("'TOPIC'")) {
                topicCount++;
            } else if (line.contains("'TABLE'")) {
                tableCount++;
            } else if (line.contains("'COLUMN'")) {
                columnCount++;
            }
        }

        preview.setTopicCount(topicCount);
        preview.setTableCount(tableCount);
        preview.setColumnCount(columnCount);
        return preview;
    }

    private void executeSqlScript(String sqlScript, ImportResult result) {
        // Normalize line endings and split by semicolon, handling multi-line VALUES
        String normalized = sqlScript.replaceAll("\r\n", "\n").replaceAll("\r", "\n");
        // Split but keep track of whether we're inside a VALUES clause with nested semicolons
        List<String> statements = splitSqlStatements(normalized);
        int successCount = 0;
        int failCount = 0;
        StringBuilder errors = new StringBuilder();

        for (String statement : statements) {
            String trimmed = statement.trim();
            if (trimmed.isEmpty() || trimmed.startsWith("--")) {
                continue;
            }
            try {
                jdbcTemplate.execute(trimmed);
                successCount++;
            } catch (Exception e) {
                log.error("Statement failed: {} | Statement: {}", e.getMessage(), trimmed);
                errors.append(trimmed.substring(0, Math.min(100, trimmed.length()))).append("; ");
                failCount++;
            }
        }

        result.setSuccessCount(successCount);
        result.setFailCount(failCount);
        log.info("Schema import completed: success={}, fail={}, errors={}", successCount, failCount, errors);
    }

    private List<String> splitSqlStatements(String sql) {
        List<String> statements = new ArrayList<>();
        StringBuilder current = new StringBuilder();
        boolean inValues = false;
        int parenDepth = 0;
        char[] chars = sql.toCharArray();

        for (int i = 0; i < chars.length; i++) {
            char c = chars[i];
            if (c == '(' && !inValues) {
                inValues = true;
                parenDepth = 1;
            } else if (c == '(' && inValues) {
                parenDepth++;
            } else if (c == ')' && inValues) {
                parenDepth--;
                if (parenDepth == 0) {
                    inValues = false;
                }
            }

            if (c == ';' && !inValues) {
                // End of statement
                String stmt = current.toString().trim();
                if (!stmt.isEmpty()) {
                    statements.add(stmt);
                }
                current = new StringBuilder();
            } else {
                current.append(c);
            }
        }

        // Add last statement if not empty
        String last = current.toString().trim();
        if (!last.isEmpty()) {
            statements.add(last);
        }

        return statements;
    }

    @Data
    public static class ImportPreview {
        private int topicCount;
        private int tableCount;
        private int columnCount;
    }

    @Data
    public static class ImportResult {
        private int successCount;
        private int failCount;
    }

    @Data
    public static class BaseResp<T> {
        private boolean success;
        private String message;
        private T data;

        public static <T> BaseResp<T> ok(T data) {
            BaseResp<T> resp = new BaseResp<>();
            resp.setSuccess(true);
            resp.setData(data);
            return resp;
        }

        public static <T> BaseResp<T> fail(String message) {
            BaseResp<T> resp = new BaseResp<>();
            resp.setSuccess(false);
            resp.setMessage(message);
            return resp;
        }
    }
}
