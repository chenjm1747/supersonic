package com.tencent.supersonic.headless.core.text2sql.utils;

import com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;

import java.util.stream.Collectors;

public class KnowledgeTextBuilder {

    public static String build(TableSchema table, ColumnSchema column) {
        StringBuilder sb = new StringBuilder();
        sb.append("表名: ").append(table.getTableName());
        if (table.getTableComment() != null && !table.getTableComment().isEmpty()) {
            sb.append("\n表注释: ").append(table.getTableComment());
        }
        sb.append("\n字段: ").append(column.getColumnName());
        sb.append(" (").append(column.getColumnType()).append(")");
        if (column.getColumnComment() != null && !column.getColumnComment().isEmpty()) {
            sb.append(" - ").append(column.getColumnComment());
        }
        if (Boolean.TRUE.equals(column.getIsPrimaryKey())) {
            sb.append(" [主键]");
        }
        if (Boolean.TRUE.equals(column.getIsForeignKey())) {
            sb.append(" [外键, 引用: ").append(column.getFkReference()).append("]");
        }
        return sb.toString();
    }

    public static String buildTableDescription(TableSchema table) {
        StringBuilder sb = new StringBuilder();
        sb.append("表名: ").append(table.getTableName());
        if (table.getTableComment() != null && !table.getTableComment().isEmpty()) {
            sb.append("\n表注释: ").append(table.getTableComment());
        }
        sb.append("\n字段列表:\n");
        String columnsText = table.getColumns().stream().map(col -> {
            StringBuilder colSb = new StringBuilder();
            colSb.append("  - ").append(col.getColumnName());
            colSb.append(" (").append(col.getColumnType()).append(")");
            if (col.getColumnComment() != null && !col.getColumnComment().isEmpty()) {
                colSb.append(": ").append(col.getColumnComment());
            }
            return colSb.toString();
        }).collect(Collectors.joining("\n"));
        sb.append(columnsText);
        return sb.toString();
    }

    public static String buildSchemaContext(String tableName, String tableComment, String columns) {
        StringBuilder sb = new StringBuilder();
        sb.append("表名: ").append(tableName);
        if (tableComment != null && !tableComment.isEmpty()) {
            sb.append("\n表注释: ").append(tableComment);
        }
        sb.append("\n字段信息:\n").append(columns);
        return sb.toString();
    }
}
