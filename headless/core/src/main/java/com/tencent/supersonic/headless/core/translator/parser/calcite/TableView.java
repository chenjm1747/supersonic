package com.tencent.supersonic.headless.core.translator.parser.calcite;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.tencent.supersonic.headless.api.pojo.response.ModelResp;
import org.apache.calcite.sql.SqlNode;
import org.apache.calcite.sql.SqlNodeList;
import org.apache.calcite.sql.SqlSelect;
import org.apache.calcite.sql.parser.SqlParserPos;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class TableView {

    private Set<String> fields = Sets.newHashSet();
    private List<SqlNode> select = Lists.newArrayList();
    private SqlNodeList order;
    private SqlNode fetch;
    private SqlNode offset;
    private SqlNode table;
    private String alias;
    private List<String> primary;
    private ModelResp dataModel;

    public TableView() {}

    public Set<String> getFields() {
        return fields;
    }

    public void setFields(Set<String> fields) {
        this.fields = fields;
    }

    public List<SqlNode> getSelect() {
        return select;
    }

    public void setSelect(List<SqlNode> select) {
        this.select = select;
    }

    public SqlNodeList getOrder() {
        return order;
    }

    public void setOrder(SqlNodeList order) {
        this.order = order;
    }

    public SqlNode getFetch() {
        return fetch;
    }

    public void setFetch(SqlNode fetch) {
        this.fetch = fetch;
    }

    public SqlNode getOffset() {
        return offset;
    }

    public void setOffset(SqlNode offset) {
        this.offset = offset;
    }

    public SqlNode getTable() {
        return table;
    }

    public void setTable(SqlNode table) {
        this.table = table;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public List<String> getPrimary() {
        return primary;
    }

    public void setPrimary(List<String> primary) {
        this.primary = primary;
    }

    public ModelResp getDataModel() {
        return dataModel;
    }

    public void setDataModel(ModelResp dataModel) {
        this.dataModel = dataModel;
    }

    public SqlNode build() {
        List<SqlNode> selectNodeList = new ArrayList<>();
        if (select.isEmpty()) {
            return new SqlSelect(SqlParserPos.ZERO, null,
                    new SqlNodeList(SqlNodeList.SINGLETON_STAR, SqlParserPos.ZERO), table, null,
                    null, null, null, null, order, offset, fetch, null);
        } else {
            selectNodeList.addAll(select);
            return new SqlSelect(SqlParserPos.ZERO, null,
                    new SqlNodeList(selectNodeList, SqlParserPos.ZERO), table, null, null, null,
                    null, null, order, offset, fetch, null);
        }
    }
}
