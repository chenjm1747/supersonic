package com.tencent.supersonic.headless.chat.query.llm.wiki;

import lombok.Data;

@Data
public class ValidationResult {
    private boolean isValid;
    private String errorMsg;
    private String sql;

    public ValidationResult() {
        this.isValid = true;
    }

    public ValidationResult(boolean isValid, String errorMsg) {
        this.isValid = isValid;
        this.errorMsg = errorMsg;
    }

    public static ValidationResult success() {
        return new ValidationResult(true, null);
    }

    public static ValidationResult failure(String errorMsg) {
        return new ValidationResult(false, errorMsg);
    }
}
