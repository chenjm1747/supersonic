package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

@Data
public class KnowledgeCardGenerateResp {
    private String title;
    private String cardType;
    private String content;
    private BigDecimal confidence;
    private List<String> tags;
    private List<String> extractedFrom;
}
