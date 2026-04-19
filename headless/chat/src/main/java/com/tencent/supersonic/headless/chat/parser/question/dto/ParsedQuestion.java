package com.tencent.supersonic.headless.chat.parser.question.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 * ParsedQuestion represents the structured result of parsing a user question. It contains extracted
 * time expressions, entities, conditions, and normalized question text.
 */
@Data
public class ParsedQuestion {

    /**
     * Original user question
     */
    private String originalQuestion;

    /**
     * Normalized question after spoken language normalization
     */
    private String normalizedQuestion;

    /**
     * Extracted time expressions
     */
    private List<TimeExpression> timeExpressions = new ArrayList<>();

    /**
     * Extracted entities (usernames, addresses, regions, etc.)
     */
    private List<ExtractedEntity> extractedEntities = new ArrayList<>();

    /**
     * Extracted and completed query conditions
     */
    private List<QueryCondition> conditions = new ArrayList<>();

    /**
     * Detected query intent
     */
    private String intent;

    /**
     * Context references (pronouns resolved to previous context)
     */
    private List<ContextReference> contextReferences = new ArrayList<>();

    /**
     * Whether the question contains references to previous context
     */
    private boolean hasContextReference;

    /**
     * Confidence score of the parsing
     */
    private double confidence;

    public void addTimeExpression(TimeExpression expr) {
        this.timeExpressions.add(expr);
    }

    public void addExtractedEntity(ExtractedEntity entity) {
        this.extractedEntities.add(entity);
    }

    public void addCondition(QueryCondition condition) {
        this.conditions.add(condition);
    }

    public void addContextReference(ContextReference ref) {
        this.contextReferences.add(ref);
        this.hasContextReference = true;
    }

    public boolean hasTimeExpression() {
        return !timeExpressions.isEmpty();
    }

    public boolean hasEntities() {
        return !extractedEntities.isEmpty();
    }

    public boolean hasConditions() {
        return !conditions.isEmpty();
    }

    public boolean hasIntent() {
        return intent != null && !intent.isEmpty();
    }

    public String getPrimaryTimeExpression() {
        return timeExpressions.isEmpty() ? null : timeExpressions.get(0).getExpression();
    }

    public String getPrimaryEntityValue(String entityType) {
        return extractedEntities.stream().filter(e -> e.getType().equals(entityType)).findFirst()
                .map(ExtractedEntity::getValue).orElse(null);
    }
}
