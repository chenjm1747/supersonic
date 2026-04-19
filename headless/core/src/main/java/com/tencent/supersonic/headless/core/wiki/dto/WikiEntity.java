package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
public class WikiEntity {

    private Long id;

    private String entityId;

    private String entityType;

    private String name;

    private String displayName;

    private String description;

    private Map<String, Object> properties;

    private String summary;

    private List<String> tags;

    private String version;

    private String parentEntityId;

    private String topicId;

    private List<String> topicIds;

    private String status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private List<WikiKnowledgeCard> knowledgeCards;

    private List<WikiLink> links;

    public enum EntityType {
        TABLE, COLUMN, TOPIC, RELATIONSHIP
    }

    public enum EntityStatus {
        ACTIVE, INACTIVE, DELETED
    }
}
