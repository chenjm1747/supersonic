package com.tencent.supersonic.headless.chat.parser.question.dto;

import lombok.Data;

/**
 * ContextReference represents a reference to previous conversation context. Examples: "这些用户" ->
 * previous query result, "同样的条件" -> previous filters
 */
@Data
public class ContextReference {

    /**
     * The pronoun or reference phrase used in the current question e.g., "这些用户", "那些人", "继续"
     */
    private String pronoun;

    /**
     * Type of reference e.g., "previous_users", "same_condition", "continue_query"
     */
    private String referenceType;

    /**
     * The round number from which the reference originates
     */
    private Integer sourceRound;

    /**
     * Resolved value(s) from the context
     */
    private Object resolvedValue;

    /**
     * Resolved SQL or condition from the context
     */
    private String resolvedSql;

    /**
     * Confidence score of the resolution
     */
    private double confidence;

    /**
     * Reference type constants
     */
    public static final String REF_USERS = "previous_users";
    public static final String REF_CONDITION = "same_condition";
    public static final String REF_AREA = "previous_area";
    public static final String REF_TIME = "previous_time";
    public static final String REF_CONTINUE = "continue_query";
    public static final String REF_SQL = "previous_sql";

    /**
     * Pronoun to reference type mapping
     */
    public static final java.util.Map<String, String> PRONOUN_MAP = new java.util.LinkedHashMap<>();

    static {
        // User references
        PRONOUN_MAP.put("这些用户", REF_USERS);
        PRONOUN_MAP.put("那些人", REF_USERS);
        PRONOUN_MAP.put("这些", REF_USERS);
        PRONOUN_MAP.put("那", REF_USERS);
        PRONOUN_MAP.put("他们", REF_USERS);

        // Condition references
        PRONOUN_MAP.put("同样", REF_CONDITION);
        PRONOUN_MAP.put("同样的", REF_CONDITION);
        PRONOUN_MAP.put("同样条件", REF_CONDITION);
        PRONOUN_MAP.put("一样的", REF_CONDITION);

        // Area references
        PRONOUN_MAP.put("这个地区", REF_AREA);
        PRONOUN_MAP.put("那个地区", REF_AREA);
        PRONOUN_MAP.put("这里", REF_AREA);
        PRONOUN_MAP.put("那里", REF_AREA);

        // Time references
        PRONOUN_MAP.put("同一时间", REF_TIME);
        PRONOUN_MAP.put("同时", REF_TIME);
        PRONOUN_MAP.put("这期间", REF_TIME);

        // Continue references
        PRONOUN_MAP.put("继续", REF_CONTINUE);
        PRONOUN_MAP.put("接着", REF_CONTINUE);
        PRONOUN_MAP.put("然后", REF_CONTINUE);
    }

    public boolean isUserReference() {
        return REF_USERS.equals(referenceType);
    }

    public boolean isConditionReference() {
        return REF_CONDITION.equals(referenceType);
    }

    public boolean isContinueReference() {
        return REF_CONTINUE.equals(referenceType);
    }

    @Override
    public String toString() {
        return "ContextReference{" + "pronoun='" + pronoun + '\'' + ", referenceType='"
                + referenceType + '\'' + ", sourceRound=" + sourceRound + ", resolvedSql='"
                + resolvedSql + '\'' + '}';
    }
}
