package com.tencent.supersonic.headless.core.permission;

/**
 * DataPermissionService manages data access permissions.
 */
public interface DataPermissionService {

    /**
     * Check if a user has read permission on a table
     *
     * @param userId the user ID
     * @param tableName the table name
     * @return true if permission is granted
     */
    boolean hasReadPermission(String userId, String tableName);

    /**
     * Check if a user has read permission on a field
     *
     * @param userId the user ID
     * @param tableName the table name
     * @param fieldName the field name
     * @return true if permission is granted
     */
    boolean hasReadPermission(String userId, String tableName, String fieldName);

    /**
     * Filter fields based on user permissions
     *
     * @param userId the user ID
     * @param tableName the table name
     * @param fields the fields to filter
     * @return filtered fields that the user can access
     */
    java.util.Set<String> filterAccessibleFields(String userId, String tableName,
            java.util.Set<String> fields);

    /**
     * Check if a user has permission to execute a query
     *
     * @param userId the user ID
     * @param dataSetId the dataset ID
     * @param sql the SQL to execute
     * @return true if permission is granted
     */
    boolean canExecuteQuery(String userId, Long dataSetId, String sql);
}
