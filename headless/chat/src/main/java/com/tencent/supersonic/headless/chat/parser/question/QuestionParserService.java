package com.tencent.supersonic.headless.chat.parser.question;

import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.parser.question.dto.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * QuestionParserService implements the QuestionParser interface. It parses user questions into
 * structured data for SQL generation.
 */
@Service
@Slf4j
public class QuestionParserService implements QuestionParser {

    // Time expression patterns
    private static final Map<String, String> TIME_EXPRESSION_MAP = new java.util.LinkedHashMap<>();
    private static final Pattern CNQ_PATTERN = Pattern.compile("(\\d{4})-(\\d{4})");
    private static final Pattern DATE_RANGE_PATTERN =
            Pattern.compile("(\\d{4}-\\d{2}-\\d{2})到(\\d{4}-\\d{2}-\\d{2})");
    private static final Pattern RELATIVE_DAY_PATTERN = Pattern.compile("近(\\d+)天");

    // Entity patterns
    private static final Pattern PHONE_PATTERN = Pattern.compile("1[3-9]\\d{9}");
    private static final Pattern ADDRESS_PATTERN =
            Pattern.compile("([\\u4e00-\\u9fa5]+(?:省|市|区|县))?([\\u4e00-\\u9fa5]+(?:街道|路|小区))?");

    static {
        // Heating season expressions
        TIME_EXPRESSION_MAP.put("本采暖期", "cnq = '2025-2026'");
        TIME_EXPRESSION_MAP.put("当前采暖期", "cnq = '2025-2026'");
        TIME_EXPRESSION_MAP.put("上一采暖期", "cnq = '2024-2025'");
        TIME_EXPRESSION_MAP.put("去年采暖期", "cnq = '2024-2025'");

        // Relative time expressions
        TIME_EXPRESSION_MAP.put("本月", "MONTH(bill_date) = MONTH(CURRENT_DATE)");
        TIME_EXPRESSION_MAP.put("上月",
                "MONTH(bill_date) = MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))");
        TIME_EXPRESSION_MAP.put("本季度", "QUARTER(bill_date) = QUARTER(CURRENT_DATE)");
        TIME_EXPRESSION_MAP.put("近7天", "bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)");
        TIME_EXPRESSION_MAP.put("近30天", "bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)");
        TIME_EXPRESSION_MAP.put("近90天", "bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY)");
        TIME_EXPRESSION_MAP.put("今年以来", "YEAR(bill_date) = YEAR(CURRENT_DATE)");
    }

    @Override
    public ParsedQuestion parse(ChatQueryContext queryCtx) {
        return parseWithContext(queryCtx, null);
    }

    @Override
    public ParsedQuestion parseWithContext(ChatQueryContext queryCtx, Object conversationHistory) {
        String question = queryCtx.getRequest().getQueryText();
        ParsedQuestion parsed = new ParsedQuestion();
        parsed.setOriginalQuestion(question);

        // 1. Normalize spoken language
        parsed.setNormalizedQuestion(normalizeQuestion(question));

        // 2. Extract time expressions
        List<TimeExpression> timeExpressions = extractTimeExpressions(question);
        timeExpressions.forEach(parsed::addTimeExpression);

        // 3. Extract entities
        List<ExtractedEntity> entities = extractEntities(question);
        entities.forEach(parsed::addExtractedEntity);

        // 4. Build conditions from time expressions
        buildTimeConditions(parsed, timeExpressions);

        // 5. Build conditions from entities
        buildEntityConditions(parsed, entities);

        // 6. Calculate confidence
        parsed.setConfidence(calculateConfidence(parsed));

        log.debug("Parsed question: {} -> timeExprs: {}, entities: {}, conditions: {}", question,
                parsed.getTimeExpressions().size(), parsed.getExtractedEntities().size(),
                parsed.getConditions().size());

        return parsed;
    }

    /**
     * Normalize spoken language to standard form
     */
    private String normalizeQuestion(String question) {
        String normalized = question;

        // Spoken language normalization
        normalized = normalized.replace("咋", "怎么");
        normalized = normalized.replace("啥", "什么");
        normalized = normalized.replace("有没有", "查询");
        normalized = normalized.replace("给我查一下", "查询");
        normalized = normalized.replace("帮我看看", "查询");
        normalized = normalized.replace("告我", "告诉");
        normalized = normalized.replace("问一下", "查询");

        // Remove extra spaces
        normalized = normalized.replaceAll("\\s+", " ").trim();

        return normalized;
    }

    /**
     * Extract time expressions from the question
     */
    private List<TimeExpression> extractTimeExpressions(String question) {
        List<TimeExpression> expressions = new ArrayList<>();

        // Check predefined expressions
        for (Map.Entry<String, String> entry : TIME_EXPRESSION_MAP.entrySet()) {
            if (question.contains(entry.getKey())) {
                TimeExpression expr = new TimeExpression();
                expr.setExpression(entry.getKey());
                expr.setSqlCondition(entry.getValue());
                expr.setRangeType(determineRangeType(entry.getKey(), entry.getValue()));
                extractTimeValue(expr, entry.getKey(), entry.getValue());
                expressions.add(expr);
            }
        }

        // Check direct CNQ pattern like "2024-2025采暖期"
        Matcher cnqMatcher = CNQ_PATTERN.matcher(question);
        while (cnqMatcher.find()) {
            String cnq = cnqMatcher.group();
            if (!question.contains("采暖期") || question.contains(cnq + "采暖期")) {
                TimeExpression expr = new TimeExpression();
                expr.setExpression(cnq);
                expr.setSqlCondition(String.format("cnq = '%s'", cnq));
                expr.setRangeType(TimeExpression.RangeType.CNQ);
                expr.setStartValue(cnq);
                expressions.add(expr);
            }
        }

        // Check relative day pattern like "近30天"
        Matcher relMatcher = RELATIVE_DAY_PATTERN.matcher(question);
        while (relMatcher.find()) {
            int days = Integer.parseInt(relMatcher.group(1));
            TimeExpression expr = new TimeExpression();
            expr.setExpression(relMatcher.group());
            expr.setSqlCondition(
                    String.format("bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL %d DAY)", days));
            expr.setRangeType(TimeExpression.RangeType.RELATIVE);
            expr.setNumericValue(days);
            expr.setTimeUnit(TimeExpression.TimeUnit.DAY);
            expressions.add(expr);
        }

        // Check date range pattern like "2024-01-01到2024-12-31"
        Matcher dateMatcher = DATE_RANGE_PATTERN.matcher(question);
        while (dateMatcher.find()) {
            TimeExpression expr = new TimeExpression();
            expr.setExpression(dateMatcher.group());
            expr.setStartValue(dateMatcher.group(1));
            expr.setEndValue(dateMatcher.group(2));
            expr.setSqlCondition(String.format("dt BETWEEN '%s' AND '%s'", dateMatcher.group(1),
                    dateMatcher.group(2)));
            expr.setRangeType(TimeExpression.RangeType.ABSOLUTE);
            expressions.add(expr);
        }

        return expressions;
    }

    private TimeExpression.RangeType determineRangeType(String expression, String sqlCondition) {
        if (expression.contains("采暖期")) {
            return TimeExpression.RangeType.CNQ;
        } else if (expression.contains("月") || expression.contains("季度")) {
            return TimeExpression.RangeType.NATURAL;
        } else if (expression.contains("天")) {
            return TimeExpression.RangeType.RELATIVE;
        } else if (expression.contains("以来")) {
            return TimeExpression.RangeType.YEAR_TO_DATE;
        }
        return TimeExpression.RangeType.RELATIVE;
    }

    private void extractTimeValue(TimeExpression expr, String expression, String sqlCondition) {
        if (expression.contains("采暖期")) {
            // Extract CNQ value like "2025-2026"
            if (sqlCondition.contains("cnq = '")) {
                int start = sqlCondition.indexOf("cnq = '") + 7;
                int end = sqlCondition.indexOf("'", start);
                if (end > start) {
                    expr.setStartValue(sqlCondition.substring(start, end));
                }
            }
        }
    }

    /**
     * Extract entities (usernames, phones, addresses, etc.) from the question
     */
    private List<ExtractedEntity> extractEntities(String question) {
        List<ExtractedEntity> entities = new ArrayList<>();

        // Extract phone numbers
        Matcher phoneMatcher = PHONE_PATTERN.matcher(question);
        while (phoneMatcher.find()) {
            ExtractedEntity entity =
                    new ExtractedEntity(ExtractedEntity.TYPE_PHONE, phoneMatcher.group(), 0.95);
            entities.add(entity);
        }

        // Extract addresses/regions
        Matcher addressMatcher = ADDRESS_PATTERN.matcher(question);
        while (addressMatcher.find()) {
            String region = addressMatcher.group(1);
            String address = addressMatcher.group(2);
            if (region != null && !region.isEmpty()) {
                entities.add(new ExtractedEntity(ExtractedEntity.TYPE_REGION, region, 0.8));
            }
            if (address != null && !address.isEmpty()) {
                entities.add(new ExtractedEntity(ExtractedEntity.TYPE_ADDRESS, address, 0.7));
            }
        }

        return entities;
    }

    /**
     * Build query conditions from time expressions
     */
    private void buildTimeConditions(ParsedQuestion parsed, List<TimeExpression> timeExpressions) {
        for (TimeExpression expr : timeExpressions) {
            if (expr.getSqlCondition() != null && !expr.getSqlCondition().isEmpty()) {
                // Parse SQL condition to extract field, operator, value
                QueryCondition condition =
                        parseSqlCondition(expr.getSqlCondition(), "time_expression");
                if (condition != null) {
                    condition.setConfidence(0.95);
                    parsed.addCondition(condition);
                }
            }
        }
    }

    /**
     * Build query conditions from extracted entities
     */
    private void buildEntityConditions(ParsedQuestion parsed, List<ExtractedEntity> entities) {
        for (ExtractedEntity entity : entities) {
            if (!entity.isMatchable()) {
                continue;
            }

            String field = mapEntityToField(entity);
            if (field != null) {
                QueryCondition condition = QueryCondition.builder().field(field).operator("=")
                        .value(entity.getNormalizedValue()).source("entity")
                        .confidence(entity.getConfidence()).build();
                parsed.addCondition(condition);
            }
        }
    }

    private String mapEntityToField(ExtractedEntity entity) {
        switch (entity.getType()) {
            case ExtractedEntity.TYPE_PHONE:
                return "mob_no";
            case ExtractedEntity.TYPE_REGION:
                return "one";
            case ExtractedEntity.TYPE_ADDRESS:
                return "address";
            case ExtractedEntity.TYPE_USERNAME:
                return "name";
            default:
                return null;
        }
    }

    private QueryCondition parseSqlCondition(String sqlCondition, String source) {
        if (sqlCondition == null || sqlCondition.isEmpty()) {
            return null;
        }

        // Simple SQL condition parser for common patterns
        QueryCondition.QueryConditionBuilder builder = QueryCondition.builder().source(source);

        if (sqlCondition.contains("cnq = '")) {
            int start = sqlCondition.indexOf("cnq = '") + 7;
            int end = sqlCondition.indexOf("'", start);
            if (end > start) {
                return builder.field("cnq").operator("=").value(sqlCondition.substring(start, end))
                        .build();
            }
        } else if (sqlCondition.contains(">=") && sqlCondition.contains("DATE_SUB")) {
            // Relative date like "bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)"
            builder.field("bill_date").operator(">=")
                    .value("DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)");
            return builder.build();
        } else if (sqlCondition.contains("BETWEEN")) {
            // Date range
            builder.field("dt").operator("BETWEEN");
            return builder.build();
        } else if (sqlCondition.contains("MONTH(")) {
            // Natural month/quarter
            if (sqlCondition.contains("MONTH(")) {
                builder.field("bill_date").operator("=").value("CURRENT_MONTH");
                return builder.build();
            }
        }

        // Fallback: return as-is if we can't parse
        return builder.field(sqlCondition.split(" ")[0]).operator("=").value(sqlCondition).build();
    }

    /**
     * Calculate parsing confidence
     */
    private double calculateConfidence(ParsedQuestion parsed) {
        double confidence = 0.5; // Base confidence

        // Boost for time expressions
        if (parsed.hasTimeExpression()) {
            confidence += 0.2;
        }

        // Boost for entities
        if (parsed.hasEntities()) {
            confidence += 0.15;
        }

        // Boost for complete conditions
        if (parsed.hasConditions()) {
            confidence += 0.15;
        }

        return Math.min(confidence, 1.0);
    }
}
