package com.tencent.supersonic.headless.chat.parser.intent;

import com.tencent.supersonic.headless.chat.parser.intent.dto.IntentResult;

/**
 * IntentClassifier identifies the intent of user questions. Common intents: QUERY_DETAIL,
 * QUERY_AGGREGATE, QUERY_COMPARE, QUERY_RANKING, QUERY_TREND
 */
public interface IntentClassifier {

    /**
     * Classify the intent of a user question
     *
     * @param question the user question
     * @return classified intent result
     */
    IntentResult classify(String question);

    /**
     * Classify with context awareness for multi-turn conversations
     *
     * @param question the user question
     * @param contextHistory previous conversation context
     * @return classified intent result with context awareness
     */
    IntentResult classifyWithContext(String question, Object contextHistory);
}
