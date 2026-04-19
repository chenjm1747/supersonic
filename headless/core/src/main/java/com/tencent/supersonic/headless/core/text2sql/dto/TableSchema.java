package com.tencent.supersonic.headless.core.text2sql.dto;

import java.util.List;

public class TableSchema {
    private String tableName;
    private String tableComment;
    private List<ColumnSchema> columns;

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableComment() {
        return tableComment;
    }

    public void setTableComment(String tableComment) {
        this.tableComment = tableComment;
    }

    public List<ColumnSchema> getColumns() {
        return columns;
    }

    public void setColumns(List<ColumnSchema> columns) {
        this.columns = columns;
    }
}
