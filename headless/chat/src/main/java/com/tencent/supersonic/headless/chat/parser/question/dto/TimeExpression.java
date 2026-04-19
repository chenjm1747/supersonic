package com.tencent.supersonic.headless.chat.parser.question.dto;

import lombok.Data;

/**
 * TimeExpression represents a recognized time expression in a user question. Examples: "本采暖期",
 * "近30天", "2024-2025采暖期"
 */
@Data
public class TimeExpression {

    /**
     * The original time expression text
     */
    private String expression;

    /**
     * SQL condition derived from the expression e.g., "cnq = '2025-2026'" for "本采暖期"
     */
    private String sqlCondition;

    /**
     * Time range type
     */
    private RangeType rangeType;

    /**
     * Start value for range expressions
     */
    private String startValue;

    /**
     * End value for range expressions
     */
    private String endValue;

    /**
     * Numeric value for relative expressions (e.g., 30 for "近30天")
     */
    private Integer numericValue;

    /**
     * Time unit for relative expressions (DAY, MONTH, YEAR, etc.)
     */
    private TimeUnit timeUnit;

    /**
     * Original text range in the question
     */
    private int startIndex;
    private int endIndex;

    /**
     * Range type enumeration
     */
    public enum RangeType {
        /**
         * Heating season (采暖期), e.g., "2025-2026"
         */
        CNQ,

        /**
         * Relative date range, e.g., "近30天"
         */
        RELATIVE,

        /**
         * Absolute date range, e.g., "2024-01-01到2024-12-31"
         */
        ABSOLUTE,

        /**
         * Natural date, e.g., "本月", "本季度"
         */
        NATURAL,

        /**
         * Year to date
         */
        YEAR_TO_DATE
    }

    /**
     * Time unit enumeration
     */
    public enum TimeUnit {
        DAY("天"), WEEK("周"), MONTH("月"), QUARTER("季度"), YEAR("年"), HEATING_SEASON("采暖期");

        private final String description;

        TimeUnit(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }
    }

    public String toSqlCondition() {
        if (sqlCondition != null && !sqlCondition.isEmpty()) {
            return sqlCondition;
        }

        StringBuilder sql = new StringBuilder();

        switch (rangeType) {
            case CNQ:
                sql.append("cnq = '").append(startValue).append("'");
                break;

            case RELATIVE:
                if (numericValue != null && timeUnit != null) {
                    if (timeUnit == TimeUnit.HEATING_SEASON) {
                        sql.append("cnq = '").append(startValue).append("'");
                    } else {
                        sql.append("dt >= DATE_SUB(CURRENT_DATE, INTERVAL ").append(numericValue)
                                .append(" ").append(getIntervalUnit()).append(")");
                    }
                }
                break;

            case ABSOLUTE:
                if (startValue != null && endValue != null) {
                    sql.append("dt BETWEEN '").append(startValue).append("' AND '").append(endValue)
                            .append("'");
                }
                break;

            case NATURAL:
                sql.append(sqlCondition);
                break;

            case YEAR_TO_DATE:
                sql.append("YEAR(dt) = YEAR(CURRENT_DATE)");
                break;

            default:
                break;
        }

        return sql.toString();
    }

    private String getIntervalUnit() {
        if (timeUnit == null) {
            return "DAY";
        }
        switch (timeUnit) {
            case DAY:
                return "DAY";
            case WEEK:
                return "WEEK";
            case MONTH:
                return "MONTH";
            case QUARTER:
                return "QUARTER";
            case YEAR:
                return "YEAR";
            default:
                return "DAY";
        }
    }

    @Override
    public String toString() {
        return "TimeExpression{" + "expression='" + expression + '\'' + ", rangeType=" + rangeType
                + ", sqlCondition='" + sqlCondition + '\'' + '}';
    }
}
