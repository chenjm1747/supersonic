package com.tencent.supersonic.headless.core.executor;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * SqlExplainResult represents the explanation of a SQL query.
 */
@Data
@Builder
public class SqlExplainResult {

    /**
     * Original SQL
     */
    private String sql;

    /**
     * Natural language explanation
     */
    private String explanation;

    /**
     * Tables involved in the query
     */
    private List<String> tables;

    /**
     * Conditions in the WHERE clause
     */
    private List<ConditionInfo> conditions;

    /**
     * Aggregations used
     */
    private List<String> aggregations;

    /**
     * GROUP BY columns
     */
    private List<String> groupByColumns;

    /**
     * ORDER BY columns
     */
    private List<String> orderByColumns;

    /**
     * Estimated row count
     */
    private Long estimatedRows;

    /**
     * Query complexity (SIMPLE, MEDIUM, COMPLEX)
     */
    private Complexity complexity;

    @Data
    @Builder
    public static class ConditionInfo {
        private String field;
        private String operator;
        private String value;
        private String meaning;
    }

    public enum Complexity {
        SIMPLE("简单", "单表查询，无聚合"), MEDIUM("中等", "多表连接或简单聚合"), COMPLEX("复杂", "嵌套查询或复杂聚合");

        private final String label;
        private final String description;

        Complexity(String label, String description) {
            this.label = label;
            this.description = description;
        }

        public String getLabel() {
            return label;
        }

        public String getDescription() {
            return description;
        }
    }

    public static SqlExplainResult explain(String sql, String explanation) {
        return SqlExplainResult.builder().sql(sql).explanation(explanation)
                .complexity(Complexity.SIMPLE).build();
    }

    public String toNaturalLanguage() {
        StringBuilder nl = new StringBuilder();

        nl.append("这条SQL的目的是：").append(explanation).append("\n");

        if (tables != null && !tables.isEmpty()) {
            nl.append("涉及的表：").append(String.join(", ", tables)).append("\n");
        }

        if (conditions != null && !conditions.isEmpty()) {
            nl.append("查询条件：");
            for (ConditionInfo cond : conditions) {
                nl.append(String.format("%s %s %s (%s)；", cond.getField(), cond.getOperator(),
                        cond.getValue(), cond.getMeaning()));
            }
            nl.append("\n");
        }

        if (aggregations != null && !aggregations.isEmpty()) {
            nl.append("使用的聚合函数：").append(String.join(", ", aggregations)).append("\n");
        }

        if (groupByColumns != null && !groupByColumns.isEmpty()) {
            nl.append("分组字段：").append(String.join(", ", groupByColumns)).append("\n");
        }

        if (complexity != null) {
            nl.append("查询复杂度：").append(complexity.getLabel()).append(" - ")
                    .append(complexity.getDescription());
        }

        return nl.toString();
    }
}
