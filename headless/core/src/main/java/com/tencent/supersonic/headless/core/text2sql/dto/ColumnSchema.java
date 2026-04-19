package com.tencent.supersonic.headless.core.text2sql.dto;

public class ColumnSchema {
    private String columnName;
    private String columnComment;
    private String columnType;
    private Boolean isPrimaryKey;
    private Boolean isForeignKey;
    private String fkReference;

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnComment() {
        return columnComment;
    }

    public void setColumnComment(String columnComment) {
        this.columnComment = columnComment;
    }

    public String getColumnType() {
        return columnType;
    }

    public void setColumnType(String columnType) {
        this.columnType = columnType;
    }

    public Boolean getIsPrimaryKey() {
        return isPrimaryKey;
    }

    public void setIsPrimaryKey(Boolean isPrimaryKey) {
        this.isPrimaryKey = isPrimaryKey;
    }

    public Boolean getIsForeignKey() {
        return isForeignKey;
    }

    public void setIsForeignKey(Boolean isForeignKey) {
        this.isForeignKey = isForeignKey;
    }

    public String getFkReference() {
        return fkReference;
    }

    public void setFkReference(String fkReference) {
        this.fkReference = fkReference;
    }
}
