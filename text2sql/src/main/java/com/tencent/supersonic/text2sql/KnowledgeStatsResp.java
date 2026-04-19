package com.tencent.supersonic.text2sql;

import lombok.Data;

import java.util.Map;

@Data
public class KnowledgeStatsResp {
    private Boolean success;
    private String message;
    private Map<String, Object> stats;
}
