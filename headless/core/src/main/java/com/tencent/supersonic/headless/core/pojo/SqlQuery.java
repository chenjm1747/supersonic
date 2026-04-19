package com.tencent.supersonic.headless.core.pojo;

public class SqlQuery {
    private String sql;
    private String table;
    private boolean supportWith = true;
    private boolean withAlias = true;
    private String simplifiedSql;

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public boolean isSupportWith() {
        return supportWith;
    }

    public void setSupportWith(boolean supportWith) {
        this.supportWith = supportWith;
    }

    public boolean isWithAlias() {
        return withAlias;
    }

    public void setWithAlias(boolean withAlias) {
        this.withAlias = withAlias;
    }

    public String getSimplifiedSql() {
        return simplifiedSql;
    }

    public void setSimplifiedSql(String simplifiedSql) {
        this.simplifiedSql = simplifiedSql;
    }
}
