package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

@Data
public class TableSelection {
    private String tableName;
    private String action; // "IMPORT" | "SKIP"

    public static final String ACTION_IMPORT = "IMPORT";
    public static final String ACTION_SKIP = "SKIP";
}