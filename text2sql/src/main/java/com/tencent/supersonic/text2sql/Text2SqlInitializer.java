package com.tencent.supersonic.text2sql;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.Arrays;
import java.util.List;

@Component
@Slf4j
public class Text2SqlInitializer implements CommandLineRunner {

    @Autowired
    private SchemaKnowledgeService schemaKnowledgeService;

    @Value("${text2sql.enabled:false}")
    private boolean enabled;

    @Value("${text2sql.knowledge.sql-file-path:}")
    private String sqlFilePath;

    @Value("${text2sql.knowledge.target-tables:}")
    private String targetTablesStr;

    @Override
    public void run(String... args) {
        if (!enabled) {
            log.info("Text-to-SQL knowledge base auto-build is disabled");
            return;
        }

        if (sqlFilePath == null || sqlFilePath.isEmpty()) {
            log.warn(
                    "text2sql.knowledge.sql-file-path is not configured, skipping knowledge base build");
            return;
        }

        log.info("Starting Text-to-SQL knowledge base auto-build...");
        log.info("SQL file path: {}", sqlFilePath);
        log.info("Target tables: {}", targetTablesStr);

        long startTime = System.currentTimeMillis();

        try {
            List<String> targetTables = null;
            if (targetTablesStr != null && !targetTablesStr.isEmpty()) {
                targetTables = Arrays.asList(targetTablesStr.split(","));
            }

            int count = schemaKnowledgeService.buildKnowledgeBase(sqlFilePath, targetTables);

            long duration = System.currentTimeMillis() - startTime;
            log.info("Text-to-SQL knowledge base auto-build completed: {} records, took {} ms",
                    count, duration);

        } catch (Exception e) {
            log.error("Failed to auto-build Text-to-SQL knowledge base", e);
        }
    }
}
