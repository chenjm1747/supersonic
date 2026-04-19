package com.tencent.supersonic.text2sql;

import lombok.Data;

import java.util.List;

@Data
public class ParseSqlResp {
    private Boolean success;
    private String message;
    private List<SchemaKnowledgeService.TableSchemaInfo> tables;
    private String databaseType;
}
