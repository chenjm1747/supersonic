package com.tencent.supersonic.headless.core.executor.impl;

import com.tencent.supersonic.headless.core.executor.SqlValidationResult;
import com.tencent.supersonic.headless.core.executor.SqlValidator;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * SqlValidatorImpl implements SQL validation logic.
 */
@Service
@Slf4j
public class SqlValidatorImpl implements SqlValidator {

    // Dangerous SQL keywords that should not be allowed
    private static final List<String> DANGEROUS_KEYWORDS = Arrays.asList("DROP", "TRUNCATE",
            "ALTER", "CREATE", "INSERT", "UPDATE", "DELETE", "GRANT", "REVOKE");

    // Pattern to detect dangerous operations
    private static final Pattern DANGEROUS_PATTERN =
            Pattern.compile("\\b(DROP|TRUNCATE|ALTER|CREATE|INSERT|UPDATE|DELETE|GRANT|REVOKE)\\b",
                    Pattern.CASE_INSENSITIVE);

    // Pattern to extract table names from FROM and JOIN clauses
    private static final Pattern TABLE_PATTERN =
            Pattern.compile("(?:FROM|JOIN)\\s+`?([a-zA-Z0-9_]+)`?", Pattern.CASE_INSENSITIVE);

    // Pattern to check if it's a SELECT statement
    private static final Pattern SELECT_PATTERN =
            Pattern.compile("^\\s*SELECT\\s+", Pattern.CASE_INSENSITIVE);

    // Pattern to detect WHERE clause
    private static final Pattern WHERE_PATTERN =
            Pattern.compile("\\bWHERE\\s+", Pattern.CASE_INSENSITIVE);

    // Pattern to detect SELECT *
    private static final Pattern SELECT_ALL_PATTERN =
            Pattern.compile("^\\s*SELECT\\s+\\*", Pattern.CASE_INSENSITIVE);

    @Override
    public SqlValidationResult validate(String sql) {
        // Check if empty
        if (sql == null || sql.trim().isEmpty()) {
            return SqlValidationResult.failure("SQL is empty");
        }

        // Normalize SQL for analysis
        String normalizedSql = sql.trim();

        // Check if it's a SELECT statement
        boolean isSelect = SELECT_PATTERN.matcher(normalizedSql).find();

        // Check for dangerous operations
        boolean containsDangerous = containsDangerousOperation(normalizedSql);

        // Check for WHERE clause
        boolean hasWhere = WHERE_PATTERN.matcher(normalizedSql).find();

        // Check for SELECT *
        boolean usesSelectAll = SELECT_ALL_PATTERN.matcher(normalizedSql).find();

        // Extract table names
        List<String> tables = extractTableNames(normalizedSql);

        // Build validation details
        SqlValidationResult.ValidationDetails details = SqlValidationResult.ValidationDetails
                .builder().isSelect(isSelect).containsDangerousOps(containsDangerous)
                .hasWhereClause(hasWhere).usesSelectAll(usesSelectAll).build();

        // Build result
        SqlValidationResult.SqlValidationResultBuilder builder = SqlValidationResult.builder();
        builder.valid(isSelect && !containsDangerous);
        builder.tables(tables);
        builder.details(details);

        SqlValidationResult result = builder.build();

        if (!isSelect) {
            result.setErrorMessage("Only SELECT queries are allowed");
        } else if (containsDangerous) {
            result.setErrorMessage("SQL contains forbidden operations");
        }

        // Add warnings
        if (usesSelectAll) {
            result.addWarning("建议指定具体字段而非 SELECT *");
        }
        if (!hasWhere) {
            result.addWarning("查询没有 WHERE 条件，可能返回大量数据");
        }

        return result;
    }

    @Override
    public SqlValidationResult validateWithSchema(String sql, Long dataSetId) {
        SqlValidationResult result = validate(sql);

        // TODO: Add schema validation against the dataset
        // For now, just return the basic validation result

        return result;
    }

    @Override
    public boolean containsDangerousOperation(String sql) {
        if (sql == null || sql.trim().isEmpty()) {
            return false;
        }

        String upperSql = sql.toUpperCase();

        // DROP, TRUNCATE, ALTER, CREATE, GRANT, REVOKE are always dangerous
        if (Pattern.compile("\\b(DROP|TRUNCATE|ALTER|CREATE|GRANT|REVOKE)\\b",
                Pattern.CASE_INSENSITIVE).matcher(sql).find()) {
            return true;
        }

        // DELETE without WHERE is dangerous
        if (Pattern.compile("\\bDELETE\\b", Pattern.CASE_INSENSITIVE).matcher(sql).find()
                && !Pattern.compile("\\bWHERE\\b", Pattern.CASE_INSENSITIVE).matcher(sql).find()) {
            return true;
        }

        // UPDATE without WHERE is dangerous
        if (Pattern.compile("\\bUPDATE\\b", Pattern.CASE_INSENSITIVE).matcher(sql).find()
                && !Pattern.compile("\\bWHERE\\b", Pattern.CASE_INSENSITIVE).matcher(sql).find()) {
            return true;
        }

        return false;
    }

    @Override
    public List<String> extractTableNames(String sql) {
        List<String> tables = new ArrayList<>();

        if (sql == null || sql.trim().isEmpty()) {
            return tables;
        }

        Matcher matcher = TABLE_PATTERN.matcher(sql);
        while (matcher.find()) {
            String tableName = matcher.group(1);
            if (!tables.contains(tableName)) {
                tables.add(tableName);
            }
        }

        return tables;
    }
}
