package com.tencent.supersonic.text2sql;

import lombok.Data;

@Data
public class SearchKnowledgeReq {
    private String query;
    private Integer topK = 10;
}
