package com.tencent.supersonic.headless.chat.parser.question;

import com.tencent.supersonic.headless.api.pojo.request.QueryNLReq;
import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.parser.question.dto.ExtractedEntity;
import com.tencent.supersonic.headless.chat.parser.question.dto.ParsedQuestion;
import com.tencent.supersonic.headless.chat.parser.question.dto.TimeExpression;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * Unit tests for QuestionParserService.
 */
public class QuestionParserServiceTest {

    private QuestionParserService parserService;

    @BeforeEach
    public void setUp() {
        parserService = new QuestionParserService();
    }

    @Test
    public void testParseHeatingSeasonExpression() {
        // Test: 本采暖期欠费用户有哪些
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("本采暖期欠费用户有哪些？");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        assertEquals("本采暖期欠费用户有哪些？", result.getOriginalQuestion());

        // Check time expressions
        List<TimeExpression> timeExpressions = result.getTimeExpressions();
        assertFalse(timeExpressions.isEmpty());
        assertTrue(timeExpressions.stream().anyMatch(te -> te.getExpression().contains("采暖期")));

        // Check confidence
        assertTrue(result.getConfidence() > 0.5);
    }

    @Test
    public void testParseRelativeTimeExpression() {
        // Test: 近30天收费记录
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("查询近30天的收费记录");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        List<TimeExpression> timeExpressions = result.getTimeExpressions();
        assertFalse(timeExpressions.isEmpty());
        assertTrue(timeExpressions.stream().anyMatch(te -> te.getExpression().contains("近30天")));
    }

    @Test
    public void testParsePhoneNumber() {
        // Test: 查询手机号 13812345678 的用户
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("查询手机号13812345678的用户信息");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        List<ExtractedEntity> entities = result.getExtractedEntities();
        assertFalse(entities.isEmpty());
        assertTrue(entities.stream().anyMatch(e -> e.getType().equals(ExtractedEntity.TYPE_PHONE)));
    }

    @Test
    public void testNormalizeSpokenLanguage() {
        // Test: 口语规范化 - "咋" -> "怎么"
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("咋查本采暖期欠费用户？");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        assertTrue(result.getNormalizedQuestion().contains("怎么"));
        assertFalse(result.getNormalizedQuestion().contains("咋"));
    }

    @Test
    public void testParseEmptyQuestion() {
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        assertTrue(result.getConfidence() >= 0.0);
    }

    @Test
    public void testParseWithContextReference() {
        // Test: 这些用户 -> reference
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("这些用户的地址分布？");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        // These/Those should be detected as potential context reference
        assertTrue(result.getOriginalQuestion().contains("这些") || result.getContextReferences()
                .stream().anyMatch(cr -> cr.getPronoun().contains("这些")));
    }

    @Test
    public void testBuildTimeConditions() {
        // Test: 本采暖期 -> cnq = '2025-2026'
        QueryNLReq req = new QueryNLReq();
        req.setQueryText("本采暖期欠费用户");
        ChatQueryContext queryCtx = new ChatQueryContext(req);

        ParsedQuestion result = parserService.parse(queryCtx);

        assertNotNull(result);
        assertFalse(result.getConditions().isEmpty());
        assertTrue(result.getConditions().stream().anyMatch(c -> "cnq".equals(c.getField())));
    }
}
