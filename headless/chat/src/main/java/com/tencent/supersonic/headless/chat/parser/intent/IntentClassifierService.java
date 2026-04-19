package com.tencent.supersonic.headless.chat.parser.intent;

import com.tencent.supersonic.headless.chat.parser.intent.dto.IntentResult;
import com.tencent.supersonic.headless.chat.parser.intent.dto.IntentType;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * IntentClassifierService implements rule-based intent classification. It uses keyword matching to
 * identify user query intents.
 */
@Service
@Slf4j
public class IntentClassifierService implements IntentClassifier {

    // Intent keyword mapping
    private static final Map<IntentType, List<String>> INTENT_KEYWORDS =
            new EnumMap<>(IntentType.class);

    // Base score for each keyword match
    private static final double KEYWORD_BASE_SCORE = 0.15;

    // Minimum confidence threshold
    private static final double MIN_CONFIDENCE = 0.5;

    // Strong threshold (high confidence)
    private static final double STRONG_CONFIDENCE = 0.8;

    static {
        // Aggregate keywords
        INTENT_KEYWORDS.put(IntentType.QUERY_AGGREGATE,
                Arrays.asList("统计", "多少", "总计", "合计", "总共", "共有", "平均", "求和", "汇总", "总数", "总金额",
                        "总数量", "总额", "count", "sum", "avg", "maximum", "max", "minimum", "min"));

        // Compare keywords
        INTENT_KEYWORDS.put(IntentType.QUERY_COMPARE,
                Arrays.asList("对比", "比较", "差异", "差别", "区别", "不同于", "相比", "对比一下", "比较一下", "有什么不同"));

        // Ranking keywords
        INTENT_KEYWORDS.put(IntentType.QUERY_RANKING, Arrays.asList("排名", "前", "top", "top10",
                "top5", "top3", "最高", "最低", "最多", "最少", "最大", "最小", "最贵", "最便宜", "第一名", "倒数第一"));

        // Trend keywords
        INTENT_KEYWORDS.put(IntentType.QUERY_TREND, Arrays.asList("趋势", "变化", "增长", "下降", "走势",
                "同比", "环比", "增加", "减少", "增幅", "降幅", "变化趋势"));

        // Export keywords
        INTENT_KEYWORDS.put(IntentType.EXPORT_DATA,
                Arrays.asList("导出", "下载", "excel", "csv", "报表", "输出"));
    }

    @Override
    public IntentResult classify(String question) {
        return classifyWithContext(question, null);
    }

    @Override
    public IntentResult classifyWithContext(String question, Object contextHistory) {
        if (question == null || question.trim().isEmpty()) {
            return IntentResult.unknown();
        }

        String normalizedQuestion = question.toLowerCase().trim();
        Map<IntentType, Double> scores = new EnumMap<>(IntentType.class);

        // Initialize scores
        for (IntentType type : IntentType.values()) {
            scores.put(type, 0.0);
        }

        // Score each intent based on keyword matching
        for (Map.Entry<IntentType, List<String>> entry : INTENT_KEYWORDS.entrySet()) {
            IntentType intent = entry.getKey();
            List<String> keywords = entry.getValue();

            for (String keyword : keywords) {
                if (normalizedQuestion.contains(keyword.toLowerCase())) {
                    double currentScore = scores.get(intent);
                    scores.put(intent, currentScore + KEYWORD_BASE_SCORE);
                }
            }
        }

        // Boost score for continuation patterns
        boolean isContinuation = detectContinuation(normalizedQuestion);
        if (isContinuation) {
            // If this is a continuation, boost aggregate and detail intents
            scores.put(IntentType.QUERY_AGGREGATE, scores.get(IntentType.QUERY_AGGREGATE) + 0.1);
            scores.put(IntentType.QUERY_DETAIL, scores.get(IntentType.QUERY_DETAIL) + 0.1);
        }

        // Find the best intent
        IntentType bestIntent = findBestIntent(scores);

        // Calculate confidence
        double confidence = calculateConfidence(scores, bestIntent);

        // Get matched keywords for reasoning
        String reasoning = buildReasoning(normalizedQuestion, bestIntent, scores);

        IntentResult result = IntentResult.of(bestIntent, confidence, reasoning, scores);
        result.setContinuation(isContinuation);

        log.debug("Classified question '{}' as {} with confidence {}", question, bestIntent,
                confidence);

        return result;
    }

    /**
     * Detect if the question is a continuation of a previous query
     */
    private boolean detectContinuation(String question) {
        // Continuation patterns
        String[] continuationPatterns = {"这些", "那些", "继续", "接着", "然后", "还有", "同样", "一样", "同样条件"};

        for (String pattern : continuationPatterns) {
            if (question.contains(pattern)) {
                return true;
            }
        }

        return false;
    }

    /**
     * Find the best matching intent
     */
    private IntentType findBestIntent(Map<IntentType, Double> scores) {
        // If no keywords matched, default to detail query
        double maxScore = 0.0;
        IntentType bestIntent = IntentType.QUERY_DETAIL;

        for (Map.Entry<IntentType, Double> entry : scores.entrySet()) {
            if (entry.getValue() > maxScore) {
                maxScore = entry.getValue();
                bestIntent = entry.getKey();
            }
        }

        // If max score is too low, default to detail
        if (maxScore < MIN_CONFIDENCE) {
            return IntentType.QUERY_DETAIL;
        }

        return bestIntent;
    }

    /**
     * Calculate confidence based on score distribution
     */
    private double calculateConfidence(Map<IntentType, Double> scores, IntentType bestIntent) {
        double bestScore = scores.get(bestIntent);

        // Find second best score
        double secondBestScore = scores.entrySet().stream().filter(e -> e.getKey() != bestIntent)
                .mapToDouble(Map.Entry::getValue).max().orElse(0.0);

        // Confidence is based on:
        // 1. The absolute score of the best intent
        // 2. The gap between best and second best (clear winner)

        double absoluteConfidence = Math.min(bestScore, 1.0);
        double gapConfidence = bestScore - secondBestScore;

        // Weighted combination
        double confidence = absoluteConfidence * 0.7 + gapConfidence * 0.3;

        return Math.min(Math.max(confidence, MIN_CONFIDENCE), 1.0);
    }

    /**
     * Build reasoning text for the classification
     */
    private String buildReasoning(String question, IntentType intent,
            Map<IntentType, Double> scores) {
        StringBuilder reasoning = new StringBuilder();

        // Add matched keywords
        List<String> matchedKeywords = new ArrayList<>();
        List<String> keywords = INTENT_KEYWORDS.get(intent);
        if (keywords != null) {
            for (String keyword : keywords) {
                if (question.contains(keyword.toLowerCase())) {
                    matchedKeywords.add(keyword);
                }
            }
        }

        if (!matchedKeywords.isEmpty()) {
            reasoning.append("关键词匹配: ").append(String.join(", ", matchedKeywords)).append("; ");
        }

        // Add intent description
        reasoning.append("意图: ").append(intent.getLabel());

        // Add confidence indicator
        if (scores.get(intent) >= STRONG_CONFIDENCE) {
            reasoning.append(" (高置信度)");
        } else if (scores.get(intent) >= MIN_CONFIDENCE) {
            reasoning.append(" (中等置信度)");
        } else {
            reasoning.append(" (低置信度，使用默认意图)");
        }

        return reasoning.toString();
    }
}
