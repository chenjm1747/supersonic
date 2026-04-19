package com.tencent.supersonic.headless.core.permission;

import com.tencent.supersonic.headless.core.executor.QueryResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

/**
 * FieldMaskingService applies data masking to query results based on field types and sensitivity
 * levels.
 */
@Service
@Slf4j
public class FieldMaskingService {

    // Patterns for identifying sensitive field types
    private static final Map<String, MaskingType> FIELD_MASKING_RULES = new HashMap<>();

    static {
        // Phone fields
        FIELD_MASKING_RULES.put("mob_no", MaskingType.PHONE);
        FIELD_MASKING_RULES.put("phone", MaskingType.PHONE);
        FIELD_MASKING_RULES.put("tel_no", MaskingType.PHONE);
        FIELD_MASKING_RULES.put("mobile", MaskingType.PHONE);

        // ID card fields
        FIELD_MASKING_RULES.put("id_card", MaskingType.ID_CARD);
        FIELD_MASKING_RULES.put("idcard", MaskingType.ID_CARD);
        FIELD_MASKING_RULES.put("certificate_no", MaskingType.ID_CARD);

        // Address fields
        FIELD_MASKING_RULES.put("address", MaskingType.ADDRESS);
        FIELD_MASKING_RULES.put("addr", MaskingType.ADDRESS);
        FIELD_MASKING_RULES.put("location", MaskingType.ADDRESS);

        // Email fields
        FIELD_MASKING_RULES.put("email", MaskingType.EMAIL);

        // Name fields
        FIELD_MASKING_RULES.put("name", MaskingType.NAME);
        FIELD_MASKING_RULES.put("username", MaskingType.NAME);
        FIELD_MASKING_RULES.put("user_name", MaskingType.NAME);

        // Bank card fields
        FIELD_MASKING_RULES.put("bank_card", MaskingType.BANK_CARD);
        FIELD_MASKING_RULES.put("card_no", MaskingType.BANK_CARD);
    }

    /**
     * Apply masking to query result based on field names
     *
     * @param result the query result
     * @param maskingEnabledFields fields that should be masked
     * @return masked query result
     */
    public QueryResult applyMasking(QueryResult result, Set<String> maskingEnabledFields) {
        if (result == null || result.getRows() == null || result.getRows().isEmpty()) {
            return result;
        }

        if (maskingEnabledFields == null || maskingEnabledFields.isEmpty()) {
            // Auto-detect fields to mask
            maskingEnabledFields = detectMaskingFields(result.getColumns());
        }

        // Apply masking to each row
        for (Map<String, Object> row : result.getRows()) {
            for (String field : maskingEnabledFields) {
                if (row.containsKey(field)) {
                    Object value = row.get(field);
                    if (value != null) {
                        MaskingType maskingType = getMaskingType(field);
                        String maskedValue = maskingType.apply(value.toString());
                        row.put(field, maskedValue);
                        result.addMasking(field, maskingType.name());
                    }
                }
            }
        }

        return result;
    }

    /**
     * Mask a specific field value
     *
     * @param fieldName the field name
     * @param value the value to mask
     * @return masked value
     */
    public String mask(String fieldName, String value) {
        if (value == null || value.isEmpty()) {
            return value;
        }

        MaskingType maskingType = getMaskingType(fieldName);
        return maskingType.apply(value);
    }

    /**
     * Get masking type for a field name
     *
     * @param fieldName the field name
     * @return masking type
     */
    public MaskingType getMaskingType(String fieldName) {
        if (fieldName == null) {
            return MaskingType.NONE;
        }

        // Check predefined rules first
        String lowerField = fieldName.toLowerCase();
        for (Map.Entry<String, MaskingType> entry : FIELD_MASKING_RULES.entrySet()) {
            if (lowerField.contains(entry.getKey())) {
                return entry.getValue();
            }
        }

        // Fallback to MaskingType.fromFieldName
        return MaskingType.fromFieldName(fieldName);
    }

    /**
     * Detect which fields should be masked based on column names
     *
     * @param columns the column names
     * @return set of fields to mask
     */
    public Set<String> detectMaskingFields(List<String> columns) {
        if (columns == null) {
            return Set.of();
        }

        java.util.Set<String> maskingFields = new java.util.HashSet<>();
        for (String column : columns) {
            MaskingType type = getMaskingType(column);
            if (type != MaskingType.NONE) {
                maskingFields.add(column);
            }
        }

        return maskingFields;
    }

    /**
     * Check if a field should be masked
     *
     * @param fieldName the field name
     * @return true if the field should be masked
     */
    public boolean shouldMask(String fieldName) {
        return getMaskingType(fieldName) != MaskingType.NONE;
    }

    /**
     * Get all masking rules
     *
     * @return map of field patterns to masking types
     */
    public Map<String, MaskingType> getMaskingRules() {
        return new HashMap<>(FIELD_MASKING_RULES);
    }
}
