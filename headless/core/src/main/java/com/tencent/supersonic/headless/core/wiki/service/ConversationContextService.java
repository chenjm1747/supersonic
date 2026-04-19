package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.ConversationContext;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing multi-turn conversation context. Enables context-aware SQL generation by
 * preserving and retrieving conversation history across multiple query rounds.
 */
@Service
@Slf4j
public class ConversationContextService {

    private final JdbcTemplate jdbcTemplate;

    private static final int CONTEXT_EXPIRE_MINUTES = 30;
    private static final int MAX_CONTEXT_ROUNDS = 20;

    private static final String INSERT_CONTEXT_SQL = """
            INSERT INTO s2_wiki_conversation_context
            (conversation_id, user_id, data_set_id, context_type, context_key, context_value,
             query_text, generated_sql, referenced_entities, referenced_cards, round_number,
             status, expires_at, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?::text[], ?::text[], ?, ?, ?, ?)
            """;

    private static final String SELECT_BY_CONVERSATION_SQL = """
            SELECT * FROM s2_wiki_conversation_context
            WHERE conversation_id = ? AND status = 'ACTIVE'
            ORDER BY round_number ASC
            LIMIT ?
            """;

    private static final String SELECT_BY_CONVERSATION_AND_TYPE_SQL = """
            SELECT * FROM s2_wiki_conversation_context
            WHERE conversation_id = ? AND context_type = ? AND status = 'ACTIVE'
            ORDER BY round_number DESC
            LIMIT 1
            """;

    private static final String SELECT_LATEST_ROUND_SQL = """
            SELECT MAX(round_number) FROM s2_wiki_conversation_context
            WHERE conversation_id = ?
            """;

    private static final String DELETE_EXPIRED_SQL = """
            UPDATE s2_wiki_conversation_context
            SET status = 'EXPIRED'
            WHERE status = 'ACTIVE' AND expires_at < NOW()
            """;

    private static final String DELETE_BY_CONVERSATION_SQL = """
            UPDATE s2_wiki_conversation_context
            SET status = 'ARCHIVED'
            WHERE conversation_id = ?
            """;

    private static final String UPDATE_STATUS_SQL = """
            UPDATE s2_wiki_conversation_context
            SET status = ?, expires_at = ?
            WHERE conversation_id = ? AND round_number = ?
            """;

    public ConversationContextService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    /**
     * Save a new conversation context entry
     */
    @Transactional
    public ConversationContext saveContext(ConversationContext context) {
        if (!StringUtils.hasText(context.getConversationId())) {
            context.setConversationId(UUID.randomUUID().toString());
        }

        // Get next round number
        int roundNumber = getMaxRoundNumber(context.getConversationId()) + 1;
        context.setRoundNumber(roundNumber);

        if (context.getStatus() == null) {
            context.setStatus(ConversationContext.ContextStatus.ACTIVE.name());
        }

        if (context.getExpiresAt() == null) {
            context.setExpiresAt(LocalDateTime.now().plusMinutes(CONTEXT_EXPIRE_MINUTES));
        }

        if (context.getCreatedAt() == null) {
            context.setCreatedAt(LocalDateTime.now());
        }

        log.info("Saving conversation context: conversationId={}, roundNumber={}, type={}",
                context.getConversationId(), roundNumber, context.getContextType());

        jdbcTemplate.update(INSERT_CONTEXT_SQL, context.getConversationId(), context.getUserId(),
                context.getDataSetId(), context.getContextType(), context.getContextKey(),
                context.getContextValue(), context.getQueryText(), context.getGeneratedSql(),
                context.getReferencedEntities() != null
                        ? context.getReferencedEntities().toArray(new String[0])
                        : null,
                context.getReferencedCards() != null
                        ? context.getReferencedCards().toArray(new String[0])
                        : null,
                context.getRoundNumber(), context.getStatus(), context.getExpiresAt(),
                context.getCreatedAt());

        return context;
    }

    /**
     * Get conversation context history
     */
    public List<ConversationContext> getContextByConversationId(String conversationId, int limit) {
        if (limit <= 0) {
            limit = MAX_CONTEXT_ROUNDS;
        }
        return jdbcTemplate.query(SELECT_BY_CONVERSATION_SQL, new ConversationContextRowMapper(),
                conversationId, limit);
    }

    /**
     * Get conversation context history (default limit)
     */
    public List<ConversationContext> getContextByConversationId(String conversationId) {
        return getContextByConversationId(conversationId, MAX_CONTEXT_ROUNDS);
    }

    /**
     * Get the latest context of a specific type
     */
    public ConversationContext getLatestContextByType(String conversationId, String contextType) {
        List<ConversationContext> results = jdbcTemplate.query(SELECT_BY_CONVERSATION_AND_TYPE_SQL,
                new ConversationContextRowMapper(), conversationId, contextType);
        return results.isEmpty() ? null : results.get(0);
    }

    /**
     * Build contextual prompt from conversation history
     */
    public String buildContextualPrompt(String conversationId, String currentQuery) {
        List<ConversationContext> contexts = getContextByConversationId(conversationId);

        if (contexts.isEmpty()) {
            return "";
        }

        StringBuilder prompt = new StringBuilder();
        prompt.append("\n## 对话历史上下文\n");
        prompt.append("请结合以下对话历史理解用户当前问题。如果当前问题引用了历史上下文（如\"这些用户\"、\"同样的条件\"），请使用历史上下文。\n\n");

        for (ConversationContext ctx : contexts) {
            prompt.append(String.format("【第%d轮】\n", ctx.getRoundNumber()));
            prompt.append(String.format("用户: %s\n", ctx.getQueryText()));
            if (StringUtils.hasText(ctx.getGeneratedSql())) {
                prompt.append(String.format("生成的SQL: %s\n", ctx.getGeneratedSql()));
            }
            if (StringUtils.hasText(ctx.getContextValue())) {
                prompt.append(String.format("上下文信息: %s\n", ctx.getContextValue()));
            }
            prompt.append("\n");
        }

        prompt.append("当前问题: ").append(currentQuery).append("\n");
        prompt.append("请根据对话历史和当前问题生成准确的SQL查询。\n");

        return prompt.toString();
    }

    /**
     * Get max round number for a conversation
     */
    public int getMaxRoundNumber(String conversationId) {
        Integer maxRound =
                jdbcTemplate.queryForObject(SELECT_LATEST_ROUND_SQL, Integer.class, conversationId);
        return maxRound != null ? maxRound : 0;
    }

    /**
     * Clean up expired contexts
     */
    @Transactional
    public int cleanupExpiredContexts() {
        int updated = jdbcTemplate.update(DELETE_EXPIRED_SQL);
        if (updated > 0) {
            log.info("Cleaned up {} expired conversation contexts", updated);
        }
        return updated;
    }

    /**
     * Archive a conversation (mark all contexts as archived)
     */
    @Transactional
    public void archiveConversation(String conversationId) {
        log.info("Archiving conversation: {}", conversationId);
        jdbcTemplate.update(DELETE_BY_CONVERSATION_SQL, conversationId);
    }

    /**
     * Save multiple contexts at once (batch operation)
     */
    @Transactional
    public void saveContextBatch(List<ConversationContext> contexts) {
        for (ConversationContext context : contexts) {
            saveContext(context);
        }
    }

    /**
     * Extract referenced entities from context history
     */
    public List<String> getReferencedEntities(String conversationId) {
        List<ConversationContext> contexts = getContextByConversationId(conversationId);
        return contexts.stream().filter(ctx -> ctx.getReferencedEntities() != null)
                .flatMap(ctx -> ctx.getReferencedEntities().stream()).distinct()
                .collect(Collectors.toList());
    }

    /**
     * Get the latest generated SQL from conversation
     */
    public String getLatestGeneratedSql(String conversationId) {
        List<ConversationContext> contexts = getContextByConversationId(conversationId, 1);
        if (contexts.isEmpty()) {
            return null;
        }
        return contexts.get(contexts.size() - 1).getGeneratedSql();
    }

    private static class ConversationContextRowMapper implements RowMapper<ConversationContext> {
        @Override
        public ConversationContext mapRow(ResultSet rs, int rowNum) throws SQLException {
            ConversationContext context = new ConversationContext();
            context.setId(rs.getLong("id"));
            context.setConversationId(rs.getString("conversation_id"));
            context.setUserId(rs.getString("user_id"));
            context.setDataSetId(rs.getLong("data_set_id"));
            context.setContextType(rs.getString("context_type"));
            context.setContextKey(rs.getString("context_key"));
            context.setContextValue(rs.getString("context_value"));
            context.setQueryText(rs.getString("query_text"));
            context.setGeneratedSql(rs.getString("generated_sql"));

            String[] entitiesArray = parseStringArray(rs.getString("referenced_entities"));
            context.setReferencedEntities(
                    entitiesArray != null ? Arrays.asList(entitiesArray) : null);

            String[] cardsArray = parseStringArray(rs.getString("referenced_cards"));
            context.setReferencedCards(cardsArray != null ? Arrays.asList(cardsArray) : null);

            context.setRoundNumber(
                    rs.getObject("round_number") != null ? rs.getInt("round_number") : null);
            context.setStatus(rs.getString("status"));
            context.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            context.setExpiresAt(rs.getTimestamp("expires_at") != null
                    ? rs.getTimestamp("expires_at").toLocalDateTime()
                    : null);

            return context;
        }

        private String[] parseStringArray(String str) {
            if (str == null || str.isEmpty() || str.equals("{}") || str.equals("[]")) {
                return null;
            }
            // PostgreSQL array format: {value1,value2,value3}
            if (str.startsWith("{") && str.endsWith("}")) {
                str = str.substring(1, str.length() - 1);
                if (str.isEmpty()) {
                    return null;
                }
                return str.split(",");
            }
            return null;
        }
    }
}
