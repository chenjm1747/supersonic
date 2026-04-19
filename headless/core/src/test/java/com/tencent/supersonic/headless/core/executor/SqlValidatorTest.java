package com.tencent.supersonic.headless.core.executor;

import com.tencent.supersonic.headless.core.executor.impl.SqlValidatorImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for SqlValidator.
 */
public class SqlValidatorTest {

    private SqlValidator sqlValidator;

    @BeforeEach
    public void setUp() {
        sqlValidator = new SqlValidatorImpl();
    }

    @Test
    public void testValidateSelectSql() {
        String sql = "SELECT * FROM customer WHERE id = 1";
        SqlValidationResult result = sqlValidator.validate(sql);

        assertNotNull(result);
        assertTrue(result.isValid());
        assertNull(result.getErrorMessage());
    }

    @Test
    public void testValidateSelectWithJoin() {
        String sql =
                "SELECT c.name, o.amount FROM customer c JOIN orders o ON c.id = o.customer_id";
        SqlValidationResult result = sqlValidator.validate(sql);

        assertNotNull(result);
        assertTrue(result.isValid());
    }

    @Test
    public void testValidateSelectWithAggregation() {
        String sql = "SELECT dept, COUNT(*) FROM employee GROUP BY dept";
        SqlValidationResult result = sqlValidator.validate(sql);

        assertNotNull(result);
        assertTrue(result.isValid());
    }

    @Test
    public void testValidateSelectWithSubquery() {
        String sql = "SELECT * FROM (SELECT id, name FROM customer WHERE status = 'active')";
        SqlValidationResult result = sqlValidator.validate(sql);

        assertNotNull(result);
        assertTrue(result.isValid());
    }

    @Test
    public void testContainsDangerousOperation_DROP() {
        String sql = "DROP TABLE customer";
        assertTrue(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testContainsDangerousOperation_DELETEWithoutWhere() {
        String sql = "DELETE FROM customer";
        assertTrue(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testContainsDangerousOperation_DELETEWithWhere() {
        String sql = "DELETE FROM customer WHERE id = 1";
        assertFalse(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testContainsDangerousOperation_TRUNCATE() {
        String sql = "TRUNCATE TABLE customer";
        assertTrue(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testContainsDangerousOperation_SELECTIsSafe() {
        String sql = "SELECT * FROM customer";
        assertFalse(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testContainsDangerousOperation_INSERTIsSafe() {
        String sql = "INSERT INTO customer (name) VALUES ('test')";
        assertFalse(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testContainsDangerousOperation_UPDATEWithWhereIsSafe() {
        String sql = "UPDATE customer SET name = 'test' WHERE id = 1";
        assertFalse(sqlValidator.containsDangerousOperation(sql));
    }

    @Test
    public void testExtractTableNames_SimpleSelect() {
        String sql = "SELECT * FROM customer";
        java.util.List<String> tables = sqlValidator.extractTableNames(sql);

        assertFalse(tables.isEmpty());
        assertTrue(tables.contains("customer"));
    }

    @Test
    public void testExtractTableNames_WithJoin() {
        String sql = "SELECT * FROM customer c JOIN orders o ON c.id = o.customer_id";
        java.util.List<String> tables = sqlValidator.extractTableNames(sql);

        assertTrue(tables.contains("customer"));
        assertTrue(tables.contains("orders"));
    }

    @Test
    public void testExtractTableNames_WithSchema() {
        String sql = "SELECT * FROM schema.customer";
        java.util.List<String> tables = sqlValidator.extractTableNames(sql);

        assertFalse(tables.isEmpty());
    }

    @Test
    public void testExtractTableNames_SelectWithAlias() {
        String sql = "SELECT c.name FROM customer AS c";
        java.util.List<String> tables = sqlValidator.extractTableNames(sql);

        assertTrue(tables.contains("customer"));
    }
}
