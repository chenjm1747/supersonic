package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Map;

@Data
public class ChatMessage {

    private Long id;

    private String conversationId;

    private String userId;

    private String message;

    private String intent;

    private String response;

    private Map<String, Object> extractedEntities;

    private String action;

    private String status;

    private LocalDateTime createdAt;

    public enum Intent {
        CREATE_CARD,
        UPDATE_CARD,
        DELETE_CARD,
        QUERY_KNOWLEDGE,
        EXPLAIN_ENTITY,
        SUGGEST_RELATION,
        UNKNOWN
    }

    public enum ActionStatus {
        PENDING, SUCCESS, FAILED, PARTIAL
    }
}
