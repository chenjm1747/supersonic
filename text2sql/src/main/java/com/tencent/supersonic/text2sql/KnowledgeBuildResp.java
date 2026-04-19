package com.tencent.supersonic.text2sql;

import lombok.Data;

@Data
public class KnowledgeBuildResp {
    private Integer totalTables;
    private Integer totalColumns;
    private Integer knowledgeCount;
    private String message;
    private Boolean success;
}
