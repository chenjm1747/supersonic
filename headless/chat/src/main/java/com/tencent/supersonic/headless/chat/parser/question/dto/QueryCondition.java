package com.tencent.supersonic.headless.chat.parser.question.dto;

import lombok.Builder;
import lombok.Data;

/**
 * QueryCondition represents a query condition derived from the question. Examples: time ranges,
 * value filters, entity references
 */
@Data
@Builder
public class QueryCondition {

    /**
     * Field name in the database
     */
    private String field;

    /**
     * Comparison operator: =, >, <, >=, <=, LIKE, IN, BETWEEN
     */
    private String operator;

    /**
     * Condition value
     */
    private Object value;

    /**
     * Multiple values for IN or BETWEEN operators
     */
    private Object[] values;

    /**
     * Logical operator to combine with previous condition: AND, OR
     */
    private String logicalOperator;

    /**
     * Source of this condition: time_expression, entity, context_inheritance
     */
    private String source;

    /**
     * Confidence score
     */
    private double confidence;

    /**
     * Whether this condition is inherited from context
     */
    private boolean inherited;

    /**
     * Round number from which this condition was inherited
     */
    private Integer inheritedFromRound;

    public String toSql() {
        if (field == null || operator == null) {
            return null;
        }

        StringBuilder sql = new StringBuilder();
        sql.append(field).append(" ").append(operator).append(" ");

        switch (operator.toUpperCase()) {
            case "IN":
                if (values != null && values.length > 0) {
                    sql.append("(");
                    for (int i = 0; i < values.length; i++) {
                        sql.append("'").append(values[i]).append("'");
                        if (i < values.length - 1) {
                            sql.append(", ");
                        }
                    }
                    sql.append(")");
                }
                break;

            case "BETWEEN":
                if (values != null && values.length >= 2) {
                    sql.append("'").append(values[0]).append("' AND '").append(values[1])
                            .append("'");
                }
                break;

            case "LIKE":
                sql.append("'%").append(value).append("%'");
                break;

            case "=":
            case ">":
            case "<":
            case ">=":
            case "<=":
            default:
                if (value != null) {
                    if (value instanceof String) {
                        sql.append("'").append(value).append("'");
                    } else {
                        sql.append(value);
                    }
                }
                break;
        }

        return sql.toString();
    }

    public boolean isTimeCondition() {
        return "time_expression".equals(source) || "context_inheritance".equals(source);
    }

    public boolean isEntityCondition() {
        return "entity".equals(source);
    }
}
