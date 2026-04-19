package com.tencent.supersonic.headless.core.pojo;

import com.tencent.supersonic.common.pojo.User;
import com.tencent.supersonic.headless.api.pojo.response.QueryState;
import com.tencent.supersonic.headless.api.pojo.response.SemanticSchemaResp;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Triple;

public class QueryStatement {

    private Long dataSetId;
    private String dataSetName;
    private String sql;
    private String errMsg;
    private StructQuery structQuery;
    private SqlQuery sqlQuery;
    private OntologyQuery ontologyQuery;
    private QueryState status = QueryState.SUCCESS;
    private Boolean isS2SQL = false;
    private Boolean enableOptimize = true;
    private Triple<String, String, String> minMaxTime;
    private Ontology ontology;
    private SemanticSchemaResp semanticSchema;
    private Integer limit = 1000;
    private Boolean isTranslated = false;
    private User user;

    public boolean isOk() {
        return StringUtils.isBlank(errMsg) && StringUtils.isNotBlank(sql);
    }

    public boolean isTranslated() {
        return isTranslated != null && isTranslated && isOk();
    }

    public Long getDataSetId() {
        return dataSetId;
    }

    public void setDataSetId(Long dataSetId) {
        this.dataSetId = dataSetId;
    }

    public String getDataSetName() {
        return dataSetName;
    }

    public void setDataSetName(String dataSetName) {
        this.dataSetName = dataSetName;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getErrMsg() {
        return errMsg;
    }

    public void setErrMsg(String errMsg) {
        this.errMsg = errMsg;
    }

    public StructQuery getStructQuery() {
        return structQuery;
    }

    public void setStructQuery(StructQuery structQuery) {
        this.structQuery = structQuery;
    }

    public SqlQuery getSqlQuery() {
        return sqlQuery;
    }

    public void setSqlQuery(SqlQuery sqlQuery) {
        this.sqlQuery = sqlQuery;
    }

    public OntologyQuery getOntologyQuery() {
        return ontologyQuery;
    }

    public void setOntologyQuery(OntologyQuery ontologyQuery) {
        this.ontologyQuery = ontologyQuery;
    }

    public QueryState getStatus() {
        return status;
    }

    public void setStatus(QueryState status) {
        this.status = status;
    }

    public Boolean getIsS2SQL() {
        return isS2SQL;
    }

    public void setIsS2SQL(Boolean isS2SQL) {
        this.isS2SQL = isS2SQL;
    }

    public Boolean getEnableOptimize() {
        return enableOptimize;
    }

    public void setEnableOptimize(Boolean enableOptimize) {
        this.enableOptimize = enableOptimize;
    }

    public Triple<String, String, String> getMinMaxTime() {
        return minMaxTime;
    }

    public void setMinMaxTime(Triple<String, String, String> minMaxTime) {
        this.minMaxTime = minMaxTime;
    }

    public Ontology getOntology() {
        return ontology;
    }

    public void setOntology(Ontology ontology) {
        this.ontology = ontology;
    }

    public SemanticSchemaResp getSemanticSchema() {
        return semanticSchema;
    }

    public void setSemanticSchema(SemanticSchemaResp semanticSchema) {
        this.semanticSchema = semanticSchema;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public Boolean getIsTranslated() {
        return isTranslated;
    }

    public void setIsTranslated(Boolean isTranslated) {
        this.isTranslated = isTranslated;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
