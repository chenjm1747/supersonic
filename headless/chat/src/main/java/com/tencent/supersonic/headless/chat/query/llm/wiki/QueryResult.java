package com.tencent.supersonic.headless.chat.query.llm.wiki;

import lombok.Data;

@Data
public class QueryResult {
    private String sql;
    private ValidationResult validation;
    private WikiRetrievalResult retrieval;

    public QueryResult(String sql, ValidationResult validation, WikiRetrievalResult retrieval) {
        this.sql = sql;
        this.validation = validation;
        this.retrieval = retrieval;
    }
}
