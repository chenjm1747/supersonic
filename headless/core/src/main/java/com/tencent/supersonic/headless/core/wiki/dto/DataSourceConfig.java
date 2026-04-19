package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Map;

@Data
public class DataSourceConfig {

    private Long id;

    private String name;

    private String type;

    private String host;

    private Integer port;

    private String databaseName;

    private String username;

    private String passwordEncrypted;

    private Map<String, Object> properties;

    private String status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public enum DataSourceType {
        MYSQL, POSTGRESQL, ORACLE, SQLSERVER, CLICKHOUSE, DUCKDB
    }

    public enum DataSourceStatus {
        ACTIVE, INACTIVE, ERROR, TESTING
    }
}
