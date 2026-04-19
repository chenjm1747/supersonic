package com.tencent.supersonic.headless.core.executor;

/**
 * SqlExecutorService executes SQL queries against data sources.
 */
public interface SqlExecutorService {

    /**
     * Execute a SQL query
     *
     * @param sql the SQL to execute
     * @param dataSetId the dataset ID
     * @param limit max rows to return
     * @param offset row offset for pagination
     * @return query result
     */
    QueryResult execute(String sql, Long dataSetId, int limit, int offset);

    /**
     * Execute a SQL query with default pagination
     *
     * @param sql the SQL to execute
     * @param dataSetId the dataset ID
     * @return query result with default limit
     */
    default QueryResult execute(String sql, Long dataSetId) {
        return execute(sql, dataSetId, 100, 0);
    }

    /**
     * Preview SQL results (limited rows)
     *
     * @param sql the SQL to execute
     * @param dataSetId the dataset ID
     * @param previewLimit number of rows to preview
     * @return query result
     */
    QueryResult preview(String sql, Long dataSetId, int previewLimit);

    /**
     * Explain a SQL query (return execution plan description)
     *
     * @param sql the SQL to explain
     * @param dataSetId the dataset ID
     * @return explanation result
     */
    SqlExplainResult explain(String sql, Long dataSetId);

    /**
     * Validate SQL before execution
     *
     * @param sql the SQL to validate
     * @param dataSetId the dataset ID
     * @return validation result
     */
    SqlValidationResult validate(String sql, Long dataSetId);
}
