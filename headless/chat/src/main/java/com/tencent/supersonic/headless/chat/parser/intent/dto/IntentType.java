package com.tencent.supersonic.headless.chat.parser.intent.dto;

/**
 * IntentType defines the types of query intents supported by the system.
 */
public enum IntentType {

    /**
     * Detail query - retrieves specific records Example: "查询欠费用户有哪些"
     */
    QUERY_DETAIL("明细查询", "查询具体记录、详情数据", "SELECT + WHERE"),

    /**
     * Aggregate query - calculates sum, count, average, etc. Example: "统计本采暖期收费总额"
     */
    QUERY_AGGREGATE("聚合查询", "求和、计数、平均等聚合计算", "SELECT + GROUP BY + 聚合函数"),

    /**
     * Compare query - compares data across dimensions Example: "对比本月和上月的数据"
     */
    QUERY_COMPARE("对比查询", "比较两个或多个维度的数据", "SELECT + GROUP BY + 排序"),

    /**
     * Ranking query - Top N or Bottom N results Example: "查询收费金额前10的用户"
     */
    QUERY_RANKING("排名查询", "Top N、Bottom N 排序查询", "ORDER BY + LIMIT"),

    /**
     * Trend query - analyzes data over time Example: "查看近半年收费趋势"
     */
    QUERY_TREND("趋势查询", "随时间变化的数据趋势", "SELECT + GROUP BY + 时间维度"),

    /**
     * Export query - exports data Example: "导出用户数据"
     */
    EXPORT_DATA("导出数据", "导出查询结果为文件", "SELECT + EXPORT"),

    /**
     * Unknown intent - cannot be classified
     */
    UNKNOWN("未知", "无法识别的意图", "N/A");

    private final String label;
    private final String description;
    private final String sqlPattern;

    IntentType(String label, String description, String sqlPattern) {
        this.label = label;
        this.description = description;
        this.sqlPattern = sqlPattern;
    }

    public String getLabel() {
        return label;
    }

    public String getDescription() {
        return description;
    }

    public String getSqlPattern() {
        return sqlPattern;
    }

    public boolean isAggregate() {
        return this == QUERY_AGGREGATE;
    }

    public boolean isRanking() {
        return this == QUERY_RANKING;
    }

    public boolean isTrend() {
        return this == QUERY_TREND;
    }

    public boolean isCompare() {
        return this == QUERY_COMPARE;
    }

    public boolean isDetail() {
        return this == QUERY_DETAIL;
    }

    public boolean isUnknown() {
        return this == UNKNOWN;
    }

    public boolean requiresGroupBy() {
        return this == QUERY_AGGREGATE || this == QUERY_COMPARE || this == QUERY_TREND;
    }

    public boolean requiresOrderBy() {
        return this == QUERY_RANKING;
    }

    public boolean requiresLimit() {
        return this == QUERY_RANKING;
    }

    public int getDefaultLimit() {
        switch (this) {
            case QUERY_RANKING:
                return 10;
            case QUERY_AGGREGATE:
                return 1000;
            default:
                return 100;
        }
    }
}
