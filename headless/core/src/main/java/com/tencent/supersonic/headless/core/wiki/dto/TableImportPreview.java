package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.util.List;

@Data
public class TableImportPreview {
    private List<TablePreviewItem> tables;
    private int totalCount;
    private int conflictCount;
    private int newCount;

    @Data
    public static class TablePreviewItem {
        private String tableName;
        private String displayName;
        private String description;
        private List<ColumnPreviewItem> columns;
        private String conflictStatus; // "NEW" | "EXISTS"
    }

    @Data
    public static class ColumnPreviewItem {
        private String columnName;
        private String displayName;
        private String description;
        private String dataType;
    }
}