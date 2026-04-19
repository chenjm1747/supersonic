package com.tencent.supersonic.headless.core.executor;

/**
 * SqlValidationService validates SQL queries against dataset schemas and security rules.
 */
public interface SqlValidationService {

    /**
     * Validate SQL syntax and security
     *
     * @param sql the SQL to validate
     * @param dataSetId the dataset ID
     * @return validation result
     */
    SqlValidationResult validate(String sql, Long dataSetId);

    /**
     * Check if SQL contains dangerous operations
     *
     * @param sql the SQL to check
     * @return true if dangerous
     */
    boolean isDangerous(String sql);

    /**
     * Estimate result row count
     *
     * @param sql the SQL to estimate
     * @param dataSetId the dataset ID
     * @return estimated rows
     */
    Long estimateResultRows(String sql, Long dataSetId);
}
