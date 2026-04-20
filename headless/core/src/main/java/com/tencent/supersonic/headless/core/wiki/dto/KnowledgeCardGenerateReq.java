package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

@Data
public class KnowledgeCardGenerateReq {
    private String entityId;
    private String cardType;
    private String title;
}
