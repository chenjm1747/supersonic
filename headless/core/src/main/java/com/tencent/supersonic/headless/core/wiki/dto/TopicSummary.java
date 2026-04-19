package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
public class TopicSummary {

    private Long id;

    private String topicId;

    private String topicName;

    private String summary;

    private List<String> memberEntities;

    private List<String> relationships;

    private Map<String, Object> metrics;

    private Integer summaryVersion;

    private String llmModel;

    private LocalDateTime generatedAt;

    private String status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    public enum SummaryStatus {
        ACTIVE, GENERATING, FAILED, DELETED
    }
}
