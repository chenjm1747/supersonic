package com.tencent.supersonic.headless.core.permission;

/**
 * MaskingType defines the types of data masking available.
 */
public enum MaskingType {

    /**
     * Phone number masking: 138****5678
     */
    PHONE("手机号", "(\\d{3})\\d{4}(\\d{4})", "$1****$2"),

    /**
     * ID card masking: 110***********1234
     */
    ID_CARD("身份证", "(\\d{6})\\d{8}(\\d{4})", "$1**********$2"),

    /**
     * Address masking: 北京市朝阳区***
     */
    ADDRESS("地址", "^(.{2,10}).*", "$1***"),

    /**
     * Email masking: u***@example.com
     */
    EMAIL("邮箱", "(\\w)\\w*(@\\w+\\.\\w+)", "$1***$2"),

    /**
     * Name masking: 张*
     */
    NAME("姓名", "^(.{1}).*$", "$1*"),

    /**
     * Bank card masking: **** **** **** 1234
     */
    BANK_CARD("银行卡", "(\\d{4})\\d{8}(\\d{4})", "$1 **** **** $2"),

    /**
     * No masking (show as-is)
     */
    NONE("无", null, null);

    private final String description;
    private final String pattern;
    private final String replacement;

    MaskingType(String description, String pattern, String replacement) {
        this.description = description;
        this.pattern = pattern;
        this.replacement = replacement;
    }

    public String getDescription() {
        return description;
    }

    public String getPattern() {
        return pattern;
    }

    public String getReplacement() {
        return replacement;
    }

    public boolean isEnabled() {
        return this != NONE && pattern != null && replacement != null;
    }

    /**
     * Apply masking to a value
     *
     * @param value the value to mask
     * @return masked value
     */
    public String apply(String value) {
        if (value == null || value.isEmpty() || !isEnabled()) {
            return value;
        }

        try {
            return value.replaceAll(pattern, replacement);
        } catch (Exception e) {
            return value;
        }
    }

    /**
     * Get masking type by field name
     *
     * @param fieldName the field name
     * @return appropriate masking type
     */
    public static MaskingType fromFieldName(String fieldName) {
        if (fieldName == null) {
            return NONE;
        }

        String lowerField = fieldName.toLowerCase();

        if (lowerField.contains("phone") || lowerField.contains("mobile")
                || lowerField.contains("tel") || lowerField.contains("mob_no")) {
            return PHONE;
        }

        if (lowerField.contains("idcard") || lowerField.contains("id_card")
                || lowerField.contains("身份证")) {
            return ID_CARD;
        }

        if (lowerField.contains("address") || lowerField.contains("addr")
                || lowerField.contains("地址")) {
            return ADDRESS;
        }

        if (lowerField.contains("email") || lowerField.contains("mail")
                || lowerField.contains("邮箱")) {
            return EMAIL;
        }

        if (lowerField.contains("name") || lowerField.contains("username")
                || lowerField.contains("姓名") || lowerField.contains("用户")) {
            return NAME;
        }

        if (lowerField.contains("bank") || lowerField.contains("card")
                || lowerField.contains("银行卡")) {
            return BANK_CARD;
        }

        return NONE;
    }
}
