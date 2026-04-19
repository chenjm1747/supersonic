package com.tencent.supersonic.headless.chat.query.llm.wiki;

import lombok.Data;

@Data
public class QueryRequest {
    private String queryText;
    private Long dataSetId;
    private String conversationId;
    private String userId;
}
