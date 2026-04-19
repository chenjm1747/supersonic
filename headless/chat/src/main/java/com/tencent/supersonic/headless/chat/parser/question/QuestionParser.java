package com.tencent.supersonic.headless.chat.parser.question;

import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.parser.question.dto.ParsedQuestion;

/**
 * QuestionParser parses user natural language questions into structured data for SQL generation. It
 * handles: - Time expression recognition (e.g., "本采暖期", "近30天") - Entity extraction (e.g.,
 * usernames, addresses, regions) - Condition completion - Spoken language normalization
 */
public interface QuestionParser {

    /**
     * Parse a user question into structured data
     *
     * @param queryCtx the chat query context
     * @return parsed question with structured data
     */
    ParsedQuestion parse(ChatQueryContext queryCtx);

    /**
     * Parse with conversation context for multi-turn support
     *
     * @param queryCtx the chat query context
     * @param conversationHistory previous conversation rounds
     * @return parsed question with context awareness
     */
    ParsedQuestion parseWithContext(ChatQueryContext queryCtx, Object conversationHistory);
}
