package com.tencent.supersonic.headless.core.text2sql.dto;

import java.util.List;

public class Text2SqlResponse {
    private String question;
    private String sql;
    private Boolean valid;
    private List<SchemaKnowledge> schemas;
    private String error;

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public Boolean getValid() {
        return valid;
    }

    public void setValid(Boolean valid) {
        this.valid = valid;
    }

    public List<SchemaKnowledge> getSchemas() {
        return schemas;
    }

    public void setSchemas(List<SchemaKnowledge> schemas) {
        this.schemas = schemas;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public static Text2SqlResponseBuilder builder() {
        return new Text2SqlResponseBuilder();
    }

    public static class Text2SqlResponseBuilder {
        private String question;
        private String sql;
        private Boolean valid;
        private List<SchemaKnowledge> schemas;
        private String error;

        public Text2SqlResponseBuilder question(String question) {
            this.question = question;
            return this;
        }

        public Text2SqlResponseBuilder sql(String sql) {
            this.sql = sql;
            return this;
        }

        public Text2SqlResponseBuilder valid(Boolean valid) {
            this.valid = valid;
            return this;
        }

        public Text2SqlResponseBuilder schemas(List<SchemaKnowledge> schemas) {
            this.schemas = schemas;
            return this;
        }

        public Text2SqlResponseBuilder error(String error) {
            this.error = error;
            return this;
        }

        public Text2SqlResponse build() {
            Text2SqlResponse response = new Text2SqlResponse();
            response.setQuestion(question);
            response.setSql(sql);
            response.setValid(valid);
            response.setSchemas(schemas);
            response.setError(error);
            return response;
        }
    }
}
