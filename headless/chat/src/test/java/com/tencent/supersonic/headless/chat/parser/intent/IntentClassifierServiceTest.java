package com.tencent.supersonic.headless.chat.parser.intent;

import com.tencent.supersonic.headless.chat.parser.intent.dto.IntentResult;
import com.tencent.supersonic.headless.chat.parser.intent.dto.IntentType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for IntentClassifierService. These tests verify basic intent classification behavior.
 */
public class IntentClassifierServiceTest {

    private IntentClassifierService classifierService;

    @BeforeEach
    public void setUp() {
        classifierService = new IntentClassifierService();
    }

    @Test
    public void testClassifyAggregateQuery() {
        // 统计类问题 - 包含"总额"、"多少"等关键词
        String question = "本采暖期收费总额是多少？";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        assertNotNull(result.getIntent());
        assertTrue(result.getConfidence() >= 0.5);
        assertFalse(result.getReasoning().isEmpty());
    }

    @Test
    public void testClassifyDetailQuery() {
        // 明细查询 - 不包含特定关键词，应该返回默认意图
        String question = "查询用户信息";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        assertEquals(IntentType.QUERY_DETAIL, result.getIntent());
    }

    @Test
    public void testClassifyRankingQuery() {
        // 排名查询 - 包含"前10"等关键词
        String question = "查询收费金额前10的用户";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        assertNotNull(result.getIntent());
        assertTrue(result.getConfidence() >= 0.5);
    }

    @Test
    public void testClassifyCompareQuery() {
        // 对比查询 - 包含"对比"关键词
        String question = "对比本月和上月的数据差异";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        assertNotNull(result.getIntent());
        assertTrue(result.getConfidence() >= 0.5);
    }

    @Test
    public void testClassifyTrendQuery() {
        // 趋势查询 - 包含"趋势"关键词
        String question = "查看近半年收费趋势";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        assertNotNull(result.getIntent());
        assertTrue(result.getConfidence() >= 0.5);
    }

    @Test
    public void testClassifyEmptyQuestion() {
        IntentResult result = classifierService.classify("");

        assertNotNull(result);
        assertEquals(IntentType.UNKNOWN, result.getIntent());
    }

    @Test
    public void testClassifyNullQuestion() {
        IntentResult result = classifierService.classify(null);

        assertNotNull(result);
        assertEquals(IntentType.UNKNOWN, result.getIntent());
    }

    @Test
    public void testClassifyWithMultipleKeywords() {
        // 多个关键词匹配应该有较高置信度
        String question = "统计本采暖期有多少用户欠费，总金额是多少？";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        assertTrue(result.getConfidence() >= 0.5);
    }

    @Test
    public void testContinuationDetection() {
        // 继续之前的查询 - 应该检测到继续模式
        String question = "这些用户的地址分布？";
        IntentResult result = classifierService.classify(question);

        assertNotNull(result);
        // 继续模式应该被检测到，或者返回明细查询
        assertTrue(result.isContinuation() || result.getIntent() == IntentType.QUERY_DETAIL);
    }

    @Test
    public void testIntentRequiresGroupBy() {
        assertTrue(IntentType.QUERY_AGGREGATE.requiresGroupBy());
        assertTrue(IntentType.QUERY_COMPARE.requiresGroupBy());
        assertTrue(IntentType.QUERY_TREND.requiresGroupBy());
        assertFalse(IntentType.QUERY_DETAIL.requiresGroupBy());
        assertFalse(IntentType.QUERY_RANKING.requiresGroupBy());
    }

    @Test
    public void testIntentRequiresOrderBy() {
        assertTrue(IntentType.QUERY_RANKING.requiresOrderBy());
        assertFalse(IntentType.QUERY_DETAIL.requiresOrderBy());
        assertFalse(IntentType.QUERY_AGGREGATE.requiresOrderBy());
    }

    @Test
    public void testIntentDefaultLimit() {
        assertEquals(10, IntentType.QUERY_RANKING.getDefaultLimit());
        assertEquals(1000, IntentType.QUERY_AGGREGATE.getDefaultLimit());
        assertEquals(100, IntentType.QUERY_DETAIL.getDefaultLimit());
    }
}
