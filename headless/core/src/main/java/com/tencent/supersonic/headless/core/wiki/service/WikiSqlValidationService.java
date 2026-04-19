package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator;
import org.springframework.jdbc.support.SQLExceptionTranslator;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class WikiSqlValidationService {

    private final JdbcTemplate jdbcTemplate;
    private final SQLExceptionTranslator exceptionTranslator;

    public WikiSqlValidationService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.exceptionTranslator = new SQLErrorCodeSQLExceptionTranslator();
    }

    public ValidationResult validate(String sql, String entityId) {
        log.info("Validating SQL for entity {}: {}", entityId, sql);

        ValidationResult result = new ValidationResult();
        result.setSql(sql);
        result.setEntityId(entityId);
        result.setValidatedAt(LocalDateTime.now());

        if (sql == null || sql.trim().isEmpty()) {
            result.setStatus(ValidationStatus.SYNTAX_ERROR);
            result.setErrorMessage("SQL is empty");
            return result;
        }

        try {
            String trimmedSql = sql.trim();
            if (!trimmedSql.toUpperCase().startsWith("SELECT")) {
                trimmedSql = "SELECT * FROM (" + trimmedSql + ") AS t";
            }

            long startTime = System.currentTimeMillis();
            List<Map<String, Object>> rows = jdbcTemplate.queryForList(trimmedSql + " LIMIT 10");
            long executionTime = System.currentTimeMillis() - startTime;

            result.setStatus(ValidationStatus.VALID);
            result.setExecutionTime(executionTime);
            result.setRowCount(rows.size());

            if (!rows.isEmpty()) {
                result.setSampleData(extractSampleData(rows));
            }

            result.setMessage("SQL validation passed");

        } catch (Exception e) {
            String message = e.getMessage();
            if (message != null && (message.contains("syntax") || message.contains("Syntax")
                    || message.contains("ERROR") || message.contains("42000"))) {
                log.warn("SQL syntax error: {}", e.getMessage());
                result.setStatus(ValidationStatus.SYNTAX_ERROR);
                result.setErrorMessage("Syntax error: " + e.getMessage());
                result.setMessage("SQL validation failed due to syntax error");
            } else {
                log.warn("SQL validation error: {}", e.getMessage());
                result.setStatus(ValidationStatus.INVALID);
                result.setErrorMessage(e.getMessage());
                result.setMessage("SQL validation failed");
            }
        }

        return result;
    }

    public List<ValidationResult> getHistory(String entityId) {
        log.info("Getting validation history for entity: {}", entityId);
        return new ArrayList<>();
    }

    public ValidationResult validateMultiple(String[] sqls, String entityId) {
        log.info("Validating {} SQL statements for entity: {}", sqls.length, entityId);

        ValidationResult combinedResult = new ValidationResult();
        combinedResult.setEntityId(entityId);
        combinedResult.setValidatedAt(LocalDateTime.now());

        List<ValidationResult> results = new ArrayList<>();
        int validCount = 0;
        int invalidCount = 0;

        for (String sql : sqls) {
            ValidationResult result = validate(sql, entityId);
            results.add(result);

            if (result.getStatus() == ValidationStatus.VALID) {
                validCount++;
            } else {
                invalidCount++;
            }
        }

        combinedResult.setResults(results);
        combinedResult.setSql(String.join("; ", sqls));

        if (invalidCount == 0) {
            combinedResult.setStatus(ValidationStatus.VALID);
            combinedResult.setMessage("All " + validCount + " SQL statements are valid");
        } else if (validCount == 0) {
            combinedResult.setStatus(ValidationStatus.INVALID);
            combinedResult.setMessage("All " + invalidCount + " SQL statements are invalid");
        } else {
            combinedResult.setStatus(ValidationStatus.PARTIAL);
            combinedResult.setMessage(validCount + " valid, " + invalidCount + " invalid");
        }

        return combinedResult;
    }

    private List<Map<String, Object>> extractSampleData(List<Map<String, Object>> rows) {
        List<Map<String, Object>> sampleData = new ArrayList<>();
        int maxRows = Math.min(rows.size(), 5);

        for (int i = 0; i < maxRows; i++) {
            Map<String, Object> row = rows.get(i);
            Map<String, Object> simplifiedRow = new HashMap<>();

            for (Map.Entry<String, Object> entry : row.entrySet()) {
                Object value = entry.getValue();
                if (value instanceof byte[]) {
                    simplifiedRow.put(entry.getKey(), "[BLOB]");
                } else if (value != null && value.toString().length() > 100) {
                    simplifiedRow.put(entry.getKey(), value.toString().substring(0, 100) + "...");
                } else {
                    simplifiedRow.put(entry.getKey(), value);
                }
            }

            sampleData.add(simplifiedRow);
        }

        return sampleData;
    }

    @Data
    public static class ValidationResult {
        private String sql;
        private String entityId;
        private ValidationStatus status;
        private long executionTime;
        private int rowCount;
        private String errorMessage;
        private List<Map<String, Object>> sampleData;
        private LocalDateTime validatedAt;
        private String message;
        private List<ValidationResult> results;
    }

    public enum ValidationStatus {
        VALID, INVALID, SYNTAX_ERROR, PARTIAL
    }
}
