package com.tencent.supersonic.headless.core.executor;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

/**
 * QueryResult represents the result of SQL execution.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QueryResult {

    /**
     * Column names in the result
     */
    private List<String> columns;

    /**
     * Result rows
     */
    private List<Map<String, Object>> rows;

    /**
     * Total row count (before pagination)
     */
    private Long total;

    /**
     * Limit applied
     */
    private Integer limit;

    /**
     * Offset applied
     */
    private Integer offset;

    /**
     * Execution time in milliseconds
     */
    private Long executionTime;

    /**
     * Error message if execution failed
     */
    private String errorMessage;

    /**
     * Whether the query was successful
     */
    private boolean success;

    /**
     * Data source ID
     */
    private String dataSourceId;

    /**
     * Original SQL that was executed
     */
    private String executedSql;

    /**
     * Masking information for sensitive fields
     */
    private Map<String, String> maskingInfo;

    public static QueryResult success(List<String> columns, List<Map<String, Object>> rows) {
        return QueryResult.builder().columns(columns).rows(rows).total((long) rows.size())
                .success(true).executionTime(0L).build();
    }

    public static QueryResult failure(String errorMessage) {
        return QueryResult.builder().success(false).errorMessage(errorMessage).build();
    }

    public void addMasking(String column, String maskingType) {
        if (maskingInfo == null) {
            maskingInfo = new java.util.HashMap<>();
        }
        maskingInfo.put(column, maskingType);
    }

    public boolean hasMasking() {
        return maskingInfo != null && !maskingInfo.isEmpty();
    }
}
