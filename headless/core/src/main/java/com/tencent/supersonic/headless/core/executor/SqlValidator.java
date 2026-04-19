package com.tencent.supersonic.headless.core.executor;

/**
 * SqlValidator validates SQL queries for syntax, security, and correctness.
 */
public interface SqlValidator {

    /**
     * Validate SQL syntax
     *
     * @param sql the SQL to validate
     * @return validation result
     */
    SqlValidationResult validate(String sql);

    /**
     * Validate SQL against schema
     *
     * @param sql the SQL to validate
     * @param dataSetId the dataset ID
     * @return validation result
     */
    SqlValidationResult validateWithSchema(String sql, Long dataSetId);

    /**
     * Check if SQL contains dangerous operations (DROP, DELETE without WHERE, etc.)
     *
     * @param sql the SQL to check
     * @return true if dangerous operations are found
     */
    boolean containsDangerousOperation(String sql);

    /**
     * Extract table names from SQL
     *
     * @param sql the SQL to parse
     * @return list of table names
     */
    java.util.List<String> extractTableNames(String sql);
}
