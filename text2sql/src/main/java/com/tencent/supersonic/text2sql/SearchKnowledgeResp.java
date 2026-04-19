package com.tencent.supersonic.text2sql;

import lombok.Data;

import java.util.List;

@Data
public class SearchKnowledgeResp {
    private Boolean success;
    private String message;
    private List<SchemaKnowledge> results;
}
