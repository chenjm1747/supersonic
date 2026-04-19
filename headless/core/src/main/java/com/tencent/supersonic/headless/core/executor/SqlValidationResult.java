package com.tencent.supersonic.headless.core.executor;

import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * SqlValidationResult represents the result of SQL validation.
 */
@Data
@Builder
public class SqlValidationResult {

    /**
     * Whether the SQL is valid
     */
    private boolean valid;

    /**
     * Error message if validation failed
     */
    private String errorMessage;

    /**
     * Tables referenced in the SQL
     */
    private List<String> tables;

    /**
     * Warnings about the SQL
     */
    private List<String> warnings;

    /**
     * Estimated row count
     */
    private Long estimatedRows;

    /**
     * Validation details
     */
    private ValidationDetails details;

    @Data
    @Builder
    public static class ValidationDetails {
        /**
         * Whether the SQL is a SELECT statement
         */
        private boolean isSelect;

        /**
         * Whether the SQL contains dangerous operations
         */
        private boolean containsDangerousOps;

        /**
         * Whether the SQL has proper WHERE clause
         */
        private boolean hasWhereClause;

        /**
         * Whether the SQL uses SELECT *
         */
        private boolean usesSelectAll;

        /**
         * Whether proper indexing might be used
         */
        private boolean potentiallyIndexed;
    }

    public static SqlValidationResult success() {
        return SqlValidationResult.builder().valid(true).build();
    }

    public static SqlValidationResult failure(String errorMessage) {
        return SqlValidationResult.builder().valid(false).errorMessage(errorMessage).build();
    }

    public void addWarning(String warning) {
        if (warnings == null) {
            warnings = new java.util.ArrayList<>();
        }
        warnings.add(warning);
    }
}
