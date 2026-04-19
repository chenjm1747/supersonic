package com.tencent.supersonic.headless.chat.parser.intent.dto;

import lombok.Builder;
import lombok.Data;

import java.util.HashMap;
import java.util.Map;

/**
 * IntentResult represents the result of intent classification.
 */
@Data
@Builder
public class IntentResult {

    /**
     * The classified intent type
     */
    private IntentType intent;

    /**
     * Confidence score (0.0 - 1.0)
     */
    private double confidence;

    /**
     * All intent scores for potential secondary classification
     */
    private Map<IntentType, Double> allIntentScores;

    /**
     * Reasoning for the classification
     */
    private String reasoning;

    /**
     * Keywords that matched in the question
     */
    private String[] matchedKeywords;

    /**
     * Whether this is a context continuation
     */
    private boolean isContinuation;

    /**
     * Create a successful classification result
     */
    public static IntentResult of(IntentType intent, double confidence, String reasoning) {
        return IntentResult.builder().intent(intent).confidence(confidence).reasoning(reasoning)
                .allIntentScores(new HashMap<>()).isContinuation(false).build();
    }

    /**
     * Create a result with all scores
     */
    public static IntentResult of(IntentType intent, double confidence, String reasoning,
            Map<IntentType, Double> allScores) {
        return IntentResult.builder().intent(intent).confidence(confidence).reasoning(reasoning)
                .allIntentScores(allScores).isContinuation(false).build();
    }

    /**
     * Create an unknown intent result
     */
    public static IntentResult unknown() {
        return IntentResult.builder().intent(IntentType.UNKNOWN).confidence(0.0).reasoning("无法识别意图")
                .allIntentScores(new HashMap<>()).isContinuation(false).build();
    }

    /**
     * Check if the classification is confident enough
     */
    public boolean isConfident() {
        return confidence >= 0.7;
    }

    /**
     * Get the second best intent (if any)
     */
    public IntentType getSecondBestIntent() {
        if (allIntentScores == null || allIntentScores.isEmpty()) {
            return IntentType.UNKNOWN;
        }

        return allIntentScores.entrySet().stream().filter(e -> e.getKey() != intent)
                .max(Map.Entry.comparingByValue()).map(Map.Entry::getKey)
                .orElse(IntentType.UNKNOWN);
    }

    /**
     * Get the score for a specific intent
     */
    public double getScore(IntentType type) {
        return allIntentScores != null ? allIntentScores.getOrDefault(type, 0.0) : 0.0;
    }

    public void setScore(IntentType type, double score) {
        if (allIntentScores == null) {
            allIntentScores = new HashMap<>();
        }
        allIntentScores.put(type, score);
    }

    /**
     * Add matched keyword
     */
    public void addMatchedKeyword(String keyword) {
        if (matchedKeywords == null) {
            matchedKeywords = new String[] {keyword};
        } else {
            String[] newKeywords = new String[matchedKeywords.length + 1];
            System.arraycopy(matchedKeywords, 0, newKeywords, 0, matchedKeywords.length);
            newKeywords[matchedKeywords.length] = keyword;
            matchedKeywords = newKeywords;
        }
    }

    @Override
    public String toString() {
        return "IntentResult{" + "intent=" + intent + ", confidence=" + confidence + ", reasoning='"
                + reasoning + '\'' + ", isContinuation=" + isContinuation + '}';
    }
}
