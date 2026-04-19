package com.tencent.supersonic.headless.core.permission;

import com.tencent.supersonic.headless.core.executor.QueryResult;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for FieldMaskingService.
 */
public class FieldMaskingServiceTest {

    private FieldMaskingService maskingService;

    @BeforeEach
    public void setUp() {
        maskingService = new FieldMaskingService();
    }

    @Test
    public void testMaskPhoneNumber() {
        String phone = "13812345678";
        String masked = maskingService.mask("phone", phone);

        assertNotNull(masked);
        assertTrue(masked.contains("*"));
        assertFalse(masked.equals(phone));
        assertEquals("138****5678", masked);
    }

    @Test
    public void testMaskPhoneNumberWithDifferentFieldNames() {
        String phone = "13812345678";

        assertEquals("138****5678", maskingService.mask("mob_no", phone));
        assertEquals("138****5678", maskingService.mask("tel_no", phone));
        assertEquals("138****5678", maskingService.mask("mobile", phone));
    }

    @Test
    public void testMaskIdCard() {
        String idCard = "110101199001011234";
        String masked = maskingService.mask("id_card", idCard);

        assertNotNull(masked);
        assertTrue(masked.contains("*"));
        assertFalse(masked.equals(idCard));
    }

    @Test
    public void testMaskName() {
        String name = "张三";
        String masked = maskingService.mask("name", name);

        assertNotNull(masked);
        assertTrue(masked.contains("*"));
    }

    @Test
    public void testMaskAddress() {
        String address = "北京市朝阳区建国路88号";
        String masked = maskingService.mask("address", address);

        assertNotNull(masked);
        assertTrue(masked.contains("*"));
    }

    @Test
    public void testMaskEmail() {
        String email = "user@example.com";
        String masked = maskingService.mask("email", email);

        assertNotNull(masked);
        assertTrue(masked.contains("*"));
        assertTrue(masked.startsWith("u***@"));
    }

    @Test
    public void testMaskBankCard() {
        String bankCard = "6222021234567890123";
        String masked = maskingService.mask("bank_card", bankCard);

        assertNotNull(masked);
        assertTrue(masked.contains("*"));
    }

    @Test
    public void testMaskNullValue() {
        String masked = maskingService.mask("phone", null);
        assertNull(masked);
    }

    @Test
    public void testMaskEmptyValue() {
        String masked = maskingService.mask("phone", "");
        assertEquals("", masked);
    }

    @Test
    public void testGetMaskingType_Phone() {
        assertEquals(MaskingType.PHONE, maskingService.getMaskingType("phone"));
        assertEquals(MaskingType.PHONE, maskingService.getMaskingType("mob_no"));
        assertEquals(MaskingType.PHONE, maskingService.getMaskingType("tel_no"));
        assertEquals(MaskingType.PHONE, maskingService.getMaskingType("mobile"));
    }

    @Test
    public void testGetMaskingType_IdCard() {
        assertEquals(MaskingType.ID_CARD, maskingService.getMaskingType("id_card"));
        assertEquals(MaskingType.ID_CARD, maskingService.getMaskingType("idcard"));
        assertEquals(MaskingType.ID_CARD, maskingService.getMaskingType("certificate_no"));
    }

    @Test
    public void testGetMaskingType_Address() {
        assertEquals(MaskingType.ADDRESS, maskingService.getMaskingType("address"));
        assertEquals(MaskingType.ADDRESS, maskingService.getMaskingType("addr"));
        assertEquals(MaskingType.ADDRESS, maskingService.getMaskingType("location"));
    }

    @Test
    public void testGetMaskingType_Name() {
        assertEquals(MaskingType.NAME, maskingService.getMaskingType("name"));
        assertEquals(MaskingType.NAME, maskingService.getMaskingType("username"));
        assertEquals(MaskingType.NAME, maskingService.getMaskingType("user_name"));
    }

    @Test
    public void testGetMaskingType_Unknown() {
        assertEquals(MaskingType.NONE, maskingService.getMaskingType("unknown_field"));
        assertEquals(MaskingType.NONE, maskingService.getMaskingType("some_random_field"));
    }

    @Test
    public void testShouldMask_True() {
        assertTrue(maskingService.shouldMask("phone"));
        assertTrue(maskingService.shouldMask("id_card"));
        assertTrue(maskingService.shouldMask("address"));
        assertTrue(maskingService.shouldMask("email"));
    }

    @Test
    public void testShouldMask_False() {
        assertFalse(maskingService.shouldMask("id"));
        assertFalse(maskingService.shouldMask("amount"));
        assertFalse(maskingService.shouldMask("created_at"));
    }

    @Test
    public void testDetectMaskingFields() {
        List<String> columns = Arrays.asList("id", "name", "phone", "address", "amount");
        Set<String> maskingFields = maskingService.detectMaskingFields(columns);

        assertTrue(maskingFields.contains("name"));
        assertTrue(maskingFields.contains("phone"));
        assertTrue(maskingFields.contains("address"));
        assertFalse(maskingFields.contains("id"));
        assertFalse(maskingFields.contains("amount"));
    }

    @Test
    public void testDetectMaskingFields_NullColumns() {
        Set<String> maskingFields = maskingService.detectMaskingFields(null);
        assertTrue(maskingFields.isEmpty());
    }

    @Test
    public void testDetectMaskingFields_EmptyColumns() {
        Set<String> maskingFields = maskingService.detectMaskingFields(Collections.emptyList());
        assertTrue(maskingFields.isEmpty());
    }

    @Test
    public void testApplyMasking_WithExplicitFields() {
        QueryResult result = createTestQueryResult();
        Set<String> fieldsToMask = new HashSet<>(Arrays.asList("phone", "name"));

        QueryResult maskedResult = maskingService.applyMasking(result, fieldsToMask);

        assertNotNull(maskedResult);
        assertFalse(maskedResult.getRows().isEmpty());
    }

    @Test
    public void testApplyMasking_AutoDetect() {
        QueryResult result = createTestQueryResult();

        QueryResult maskedResult = maskingService.applyMasking(result, null);

        assertNotNull(maskedResult);
    }

    @Test
    public void testApplyMasking_NullResult() {
        QueryResult maskedResult = maskingService.applyMasking(null, null);
        assertNull(maskedResult);
    }

    @Test
    public void testApplyMasking_EmptyRows() {
        QueryResult result = new QueryResult();
        result.setColumns(Arrays.asList("id", "phone"));
        result.setRows(Collections.emptyList());

        QueryResult maskedResult = maskingService.applyMasking(result, null);

        assertNotNull(maskedResult);
        assertTrue(maskedResult.getRows().isEmpty());
    }

    @Test
    public void testGetMaskingRules() {
        Map<String, MaskingType> rules = maskingService.getMaskingRules();

        assertNotNull(rules);
        assertFalse(rules.isEmpty());
        assertEquals(MaskingType.PHONE, rules.get("phone"));
        assertEquals(MaskingType.ID_CARD, rules.get("id_card"));
    }

    private QueryResult createTestQueryResult() {
        QueryResult result = new QueryResult();
        result.setColumns(Arrays.asList("id", "name", "phone", "address", "amount"));

        List<Map<String, Object>> rows = new ArrayList<>();
        Map<String, Object> row1 = new LinkedHashMap<>();
        row1.put("id", 1);
        row1.put("name", "张三");
        row1.put("phone", "13812345678");
        row1.put("address", "北京市朝阳区");
        row1.put("amount", 1000);
        rows.add(row1);

        result.setRows(rows);
        return result;
    }
}
