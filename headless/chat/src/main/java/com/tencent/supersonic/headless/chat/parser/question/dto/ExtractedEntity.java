package com.tencent.supersonic.headless.chat.parser.question.dto;

import lombok.Data;

/**
 * ExtractedEntity represents an entity extracted from user question. Types include: USERNAME,
 * PHONE, ADDRESS, REGION, PRODUCT, COMPANY, etc.
 */
@Data
public class ExtractedEntity {

    /**
     * Entity type
     */
    private String type;

    /**
     * The actual value extracted
     */
    private String value;

    /**
     * Normalized value (for matching against database)
     */
    private String normalizedValue;

    /**
     * Confidence score of the extraction
     */
    private double confidence;

    /**
     * Original text range in the question
     */
    private int startIndex;
    private int endIndex;

    /**
     * Whether this entity can be used for direct database matching
     */
    private boolean matchable;

    /**
     * Entity type constants
     */
    public static final String TYPE_USERNAME = "USERNAME";
    public static final String TYPE_PHONE = "PHONE";
    public static final String TYPE_ADDRESS = "ADDRESS";
    public static final String TYPE_REGION = "REGION";
    public static final String TYPE_EMAIL = "EMAIL";
    public static final String TYPE_ID_CARD = "ID_CARD";
    public static final String TYPE_CUSTOM = "CUSTOM";

    public ExtractedEntity() {}

    public ExtractedEntity(String type, String value) {
        this.type = type;
        this.value = value;
        this.normalizedValue = value;
        this.confidence = 1.0;
        this.matchable = true;
    }

    public ExtractedEntity(String type, String value, double confidence) {
        this.type = type;
        this.value = value;
        this.normalizedValue = value;
        this.confidence = confidence;
        this.matchable = confidence > 0.7;
    }

    public boolean isPhone() {
        return TYPE_PHONE.equals(type);
    }

    public boolean isAddress() {
        return TYPE_ADDRESS.equals(type) || TYPE_REGION.equals(type);
    }

    public boolean isUsername() {
        return TYPE_USERNAME.equals(type);
    }

    public String toMatchCondition(String fieldName) {
        if (!matchable || value == null) {
            return null;
        }
        return String.format("%s = '%s'", fieldName, normalizedValue);
    }

    @Override
    public String toString() {
        return "ExtractedEntity{" + "type='" + type + '\'' + ", value='" + value + '\''
                + ", normalizedValue='" + normalizedValue + '\'' + ", confidence=" + confidence
                + '}';
    }
}
