package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * ConversationContext stores multi-turn conversation context for Text-to-SQL queries. It captures
 * the history of user queries, generated SQLs, and referenced entities to enable context-aware SQL
 * generation in follow-up questions.
 */
@Data
public class ConversationContext {

    private Long id;

    /**
     * Unique conversation session identifier
     */
    private String conversationId;

    /**
     * User identifier
     */
    private String userId;

    /**
     * Dataset ID for this conversation
     */
    private Long dataSetId;

    /**
     * Context type: TIME_RANGE, ENTITY, FILTER, INTENT, SQL_RESULT
     */
    private String contextType;

    /**
     * Context key for indexing and retrieval
     */
    private String contextKey;

    /**
     * Context value stored as JSON
     */
    private String contextValue;

    /**
     * Original question that generated this context
     */
    private String queryText;

    /**
     * Generated SQL for this round
     */
    private String generatedSql;

    /**
     * Referenced entities in this round (e.g., table names, field names)
     */
    private List<String> referencedEntities;

    /**
     * Referenced knowledge cards in this round
     */
    private List<String> referencedCards;

    /**
     * Round number in the conversation
     */
    private Integer roundNumber;

    /**
     * Conversation status: ACTIVE, EXPIRED, ARCHIVED
     */
    private String status;

    /**
     * When this context was created
     */
    private LocalDateTime createdAt;

    /**
     * When this context expires
     */
    private LocalDateTime expiresAt;

    /**
     * Context snapshot as JSON for quick retrieval
     */
    private String contextSnapshot;

    /**
     * Context types enumeration
     */
    public enum ContextType {
        TIME_RANGE("时间范围上下文"),
        ENTITY("实体上下文"),
        FILTER("过滤条件上下文"),
        INTENT("意图上下文"),
        SQL_RESULT("SQL结果上下文");

        private final String description;

        ContextType(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }
    }

    /**
     * Context status enumeration
     */
    public enum ContextStatus {
        ACTIVE("活跃"), EXPIRED("已过期"), ARCHIVED("已归档");

        private final String description;

        ContextStatus(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }
    }
}
