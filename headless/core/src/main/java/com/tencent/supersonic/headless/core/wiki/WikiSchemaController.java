package com.tencent.supersonic.headless.core.wiki;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import com.tencent.supersonic.headless.core.wiki.service.AutoKnowledgeGenerator;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiKnowledgeService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/wiki/schema")
@RequiredArgsConstructor
@Slf4j
public class WikiSchemaController {
    private final JdbcTemplate jdbcTemplate;
    private final WikiEntityService entityService;
    private final WikiKnowledgeService knowledgeService;
    private final AutoKnowledgeGenerator autoKnowledgeGenerator;

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
        // Execute the SQL script directly
        String[] statements = sqlScript.split(";");
        int successCount = 0;
        int failCount = 0;

        for (String statement : statements) {
            String trimmed = statement.trim();
            if (trimmed.isEmpty() || trimmed.startsWith("--")) {
                continue;
            }
            try {
                jdbcTemplate.execute(trimmed);
                successCount++;
            } catch (Exception e) {
                log.warn("Statement failed: {}", e.getMessage());
                failCount++;
            }
        }

        result.setSuccessCount(successCount);
        result.setFailCount(failCount);
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
