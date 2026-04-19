package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class WikiKnowledgeCard {

    private Long id;

    private String cardId;

    private String entityId;

    private String cardType;

    private String title;

    private String content;

    private List<String> extractedFrom;

    private BigDecimal confidence;

    private String status;

    private List<String> tags;

    private float[] embedding;

    private String version;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    // 自增强相关字段
    private Integer usageCount = 0;        // 使用次数
    private Integer successCount = 0;      // 成功次数
    private Integer failureCount = 0;     // 失败次数
    private LocalDateTime lastUsedAt;     // 最后使用时间
    private String replacementCardId;      // 替代卡片 ID

    public enum CardType {
        RELATIONSHIP,
        BUSINESS_RULE,
        DATA_PATTERN,
        USAGE_PATTERN,
        SEMANTIC_MAPPING,
        METRIC_DEFINITION
    }

    public enum CardStatus {
        ACTIVE, INACTIVE, CONFLICTED, DELETED, PENDING_REVIEW, SUPERSEDED, RECOMMENDED, AUTO_GENERATED
    }
}
