# LLM-SQL-Wiki Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现以 Wiki 为核心的 LLM-SQL 知识中心，支持自然语言查询、健康巡检、知识复利累积

**Architecture:** 深度重构方案，以 WikiQueryEngine 为核心引擎，协调意图识别、知识检索、上下文管理和 SQL 生成。健康巡检半自动化，知识卡片直接编辑模式，强自增强机制。

**Tech Stack:** Java 21, Spring Boot 3.3.9, PostgreSQL + PGVector, LangChain4j

---

## 阶段一：基础设施（数据库 + 核心服务）

### Task 1: 扩展 WikiKnowledgeCard 数据结构

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCard.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCardTest.java`

- [ ] **Step 1: 添加自增强相关字段到 WikiKnowledgeCard**

```java
// 在 WikiKnowledgeCard.java 中添加以下字段
private Integer usageCount = 0;        // 使用次数
private Integer successCount = 0;      // 成功次数
private Integer failureCount = 0;      // 失败次数
private LocalDateTime lastUsedAt;      // 最后使用时间
private String replacementCardId;      // 替代卡片 ID
```

- [ ] **Step 2: 添加 WikiKnowledgeCardTest 测试**

```java
@Test
void testCardHasUsageFields() {
    WikiKnowledgeCard card = new WikiKnowledgeCard();
    card.setUsageCount(0);
    card.setSuccessCount(0);
    card.setFailureCount(0);
    assertEquals(0, card.getUsageCount());
    assertEquals(0, card.getSuccessCount());
}
```

- [ ] **Step 3: 运行测试**

Run: `mvn test -Dtest=WikiKnowledgeCardTest -pl headless/core`
Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCard.java
git add headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCardTest.java
git commit -m "feat(wiki): add self-enhancement fields to WikiKnowledgeCard"
```

---

### Task 2: 创建数据库新表（健康巡检报告 + 使用日志 + 研究方向）

**Files:**
- Modify: `launchers/standalone/src/main/resources/db/schema-postgres.sql`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/service/WikiHealthServiceTest.java`

- [ ] **Step 1: 添加新表 SQL**

```sql
-- 健康巡检报告表
CREATE TABLE IF NOT EXISTS s2_wiki_health_report (
    id BIGSERIAL PRIMARY KEY,
    report_id VARCHAR(128) NOT NULL UNIQUE,
    report_type VARCHAR(16) NOT NULL,
    checked_at TIMESTAMP NOT NULL,
    contradictions_found INT DEFAULT 0,
    outdated_cards INT DEFAULT 0,
    orphan_entities INT DEFAULT 0,
    missing_refs INT DEFAULT 0,
    status VARCHAR(32) DEFAULT 'PENDING_PROCESSED',
    report_content JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 知识卡片使用历史表
CREATE TABLE IF NOT EXISTS s2_wiki_card_usage_log (
    id BIGSERIAL PRIMARY KEY,
    card_id VARCHAR(128) NOT NULL,
    sql TEXT NOT NULL,
    result VARCHAR(16) NOT NULL,
    error_msg TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 研究方向表
CREATE TABLE IF NOT EXISTS s2_wiki_research_topic (
    id BIGSERIAL PRIMARY KEY,
    topic_id VARCHAR(128) NOT NULL UNIQUE,
    topic VARCHAR(512) NOT NULL,
    priority VARCHAR(16) DEFAULT 'MEDIUM',
    reason TEXT,
    status VARCHAR(32) DEFAULT 'PENDING',
    related_entity_ids TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    confirmed_at TIMESTAMP,
    confirmed_by VARCHAR(64)
);

CREATE INDEX IF NOT EXISTS idx_report_type ON s2_wiki_health_report(report_type);
CREATE INDEX IF NOT EXISTS idx_card_usage_card ON s2_wiki_card_usage_log(card_id);
CREATE INDEX IF NOT EXISTS idx_topic_status ON s2_wiki_research_topic(status);
```

- [ ] **Step 2: 运行数据库迁移**

Run: `psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f launchers/standalone/src/main/resources/db/schema-postgres.sql`

Expected: CREATE TABLE 成功

- [ ] **Step 3: Commit**

```bash
git add launchers/standalone/src/main/resources/db/schema-postgres.sql
git commit -m "feat(wiki): add health report, usage log and research topic tables"
```

---

### Task 3: 创建 WikiHealthReport DTO

**Files:**
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiHealthReport.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/dto/WikiHealthReportTest.java`

- [ ] **Step 1: 创建 WikiHealthReport 类**

```java
package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class WikiHealthReport {
    private Long id;
    private String reportId;
    private String reportType;  // DAILY/WEEKLY
    private LocalDateTime checkedAt;
    private Integer contradictionsFound;
    private Integer outdatedCards;
    private Integer orphanEntities;
    private Integer missingRefs;
    private String status;  // PENDING_PROCESSED / PROCESSED
    private String reportContent;  // JSON
    private LocalDateTime createdAt;
}
```

- [ ] **Step 2: 创建测试**

```java
@Test
void testReportCreation() {
    WikiHealthReport report = new WikiHealthReport();
    report.setReportId("RPT-20260419-001");
    report.setReportType("DAILY");
    report.setStatus("PENDING_PROCESSED");
    assertEquals("RPT-20260419-001", report.getReportId());
}
```

- [ ] **Step 3: 运行测试**

Run: `mvn test -Dtest=WikiHealthReportTest -pl headless/core`
Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiHealthReport.java
git commit -m "feat(wiki): add WikiHealthReport DTO"
```

---

### Task 4: 创建 WikiQueryEngine 核心引擎

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/wiki/WikiQueryEngine.java`
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/wiki/IntentDetector.java`
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/wiki/WikiRetriever.java`
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/wiki/KnowledgeAssembler.java`
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/wiki/WikiRetrievalResult.java`
- Test: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/query/llm/wiki/WikiQueryEngineTest.java`

- [ ] **Step 1: 创建 WikiRetrievalResult**

```java
@Data
public class WikiRetrievalResult {
    private List<WikiEntity> entities;
    private List<WikiKnowledgeCard> knowledgeCards;
    private List<SemanticMapping> semanticMappings;
    private List<BusinessRule> businessRules;
    private List<UsagePattern> usagePatterns;
    private List<MetricDefinition> metricDefinitions;
    private List<String> relatedEntityIds;
}
```

- [ ] **Step 2: 创建 IntentDetector**

```java
@Component
public class IntentDetector {
    
    public Intent detect(QueryRequest request) {
        String queryText = request.getQueryText().toLowerCase();
        Intent intent = new Intent();
        
        if (queryText.contains("多少") || queryText.contains("总计") || queryText.contains("sum")) {
            intent.setType("AGGREGATE");
        } else if (queryText.contains("查询") || queryText.contains("列出")) {
            intent.setType("SELECT");
        } else if (queryText.contains("超过") || queryText.contains("大于")) {
            intent.setType("FILTER");
        }
        return intent;
    }
}

@Data
class Intent {
    private String type;
    private List<String> entities;
    private List<String> metrics;
    private List<String> filters;
}
```

- [ ] **Step 3: 创建 WikiRetriever**

```java
@Component
@RequiredArgsConstructor
public class WikiRetriever {
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService entityService;
    
    public WikiRetrievalResult retrieve(QueryRequest request, Intent intent) {
        WikiRetrievalResult result = new WikiRetrievalResult();
        
        // 向量检索
        float[] queryEmbedding = knowledgeService.generateEmbedding(request.getQueryText());
        List<WikiKnowledgeCard> cards = knowledgeService.searchByEmbedding(queryEmbedding, 10);
        result.setKnowledgeCards(cards);
        
        // 按类型分类
        result.setSemanticMappings(filterByType(cards, "SEMANTIC_MAPPING"));
        result.setBusinessRules(filterByType(cards, "BUSINESS_RULE"));
        result.setUsagePatterns(filterByType(cards, "USAGE_PATTERN"));
        result.setMetricDefinitions(filterByType(cards, "METRIC_DEFINITION"));
        
        return result;
    }
    
    private List<SemanticMapping> filterByType(List<WikiKnowledgeCard> cards, String type) {
        // parse and return filtered cards
    }
}
```

- [ ] **Step 4: 创建 WikiQueryEngine**

```java
@Service
@RequiredArgsConstructor
public class WikiQueryEngine {
    private final IntentDetector intentDetector;
    private final WikiRetriever wikiRetriever;
    private final KnowledgeAssembler knowledgeAssembler;
    private final LLMRequestService llmRequestService;
    private final SqlExecutor sqlExecutor;
    private final SelfEnhancementService selfEnhancementService;
    private final ConversationContextService contextService;
    
    public QueryResult process(QueryRequest request) {
        // 1. 意图识别
        Intent intent = intentDetector.detect(request);
        
        // 2. 上下文恢复
        ConversationContext ctx = contextService.restore(request.getConversationId());
        
        // 3. Wiki 检索
        WikiRetrievalResult retrieval = wikiRetriever.retrieve(request, intent);
        
        // 4. 上下文组装
        String wikiContext = knowledgeAssembler.assemble(retrieval, intent);
        
        // 5. SQL 生成
        String sql = llmRequestService.generateSql(request.getQueryText(), wikiContext, ctx);
        
        // 6. SQL 验证
        ValidationResult validation = sqlExecutor.validate(sql);
        
        // 7. 自增强反馈
        selfEnhancementService.feedback(sql, validation, retrieval);
        
        // 8. 上下文持久化
        contextService.save(sql, validation, retrieval, ctx, request);
        
        return new QueryResult(sql, validation, retrieval);
    }
}
```

- [ ] **Step 5: 创建测试**

```java
@Test
void testWikiQueryEngineProcess() {
    QueryRequest request = new QueryRequest();
    request.setQueryText("查询本季度收入超过100万的客户");
    request.setDataSetId(1L);
    
    QueryResult result = wikiQueryEngine.process(request);
    
    assertNotNull(result.getSql());
    assertTrue(result.getSql().contains("SELECT"));
}
```

- [ ] **Step 6: 运行测试**

Run: `mvn test -Dtest=WikiQueryEngineTest -pl headless/chat`
Expected: PASS

- [ ] **Step 7: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/wiki/
git commit -m "feat(wiki): add WikiQueryEngine core engine"
```

---

### Task 5: 创建 SelfEnhancementService（自增强服务）

**Files:**
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/SelfEnhancementService.java`
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiCardUsageLog.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/service/SelfEnhancementServiceTest.java`

- [ ] **Step 1: 创建 WikiCardUsageLog DTO**

```java
@Data
public class WikiCardUsageLog {
    private Long id;
    private String cardId;
    private String sql;
    private String result;  // SUCCESS/FAILURE
    private String errorMsg;
    private LocalDateTime createdAt;
}
```

- [ ] **Step 2: 创建 SelfEnhancementService**

```java
@Service
@RequiredArgsConstructor
public class SelfEnhancementService {
    private final WikiKnowledgeService knowledgeService;
    private final JdbcTemplate jdbcTemplate;
    
    private static final BigDecimal SUCCESS_BOOST = BigDecimal.valueOf(1.02);
    private static final BigDecimal FAILURE_PENALTY = BigDecimal.valueOf(0.90);
    private static final BigDecimal CONFIDENCE_THRESHOLD = BigDecimal.valueOf(0.3);
    
    public void onSqlSuccess(String sql, List<String> usedCardIds) {
        for (String cardId : usedCardIds) {
            WikiKnowledgeCard card = knowledgeService.getCardById(cardId);
            if (card == null) continue;
            
            card.setUsageCount(card.getUsageCount() + 1);
            card.setSuccessCount(card.getSuccessCount() + 1);
            card.setLastUsedAt(LocalDateTime.now());
            card.setConfidence(card.getConfidence().multiply(SUCCESS_BOOST).min(BigDecimal.ONE));
            
            // 检查是否达到升级条件
            if (card.getUsageCount() >= 20 
                && card.getConfidence().compareTo(BigDecimal.valueOf(0.95)) >= 0
                && card.getSuccessRate() > 0.9) {
                generateRecommendedVersion(card);
            }
            
            knowledgeService.updateCard(card);
            logUsage(cardId, sql, "SUCCESS", null);
        }
    }
    
    public void onSqlFailure(String sql, String errorMsg, List<String> usedCardIds) {
        for (String cardId : usedCardIds) {
            WikiKnowledgeCard card = knowledgeService.getCardById(cardId);
            if (card == null) continue;
            
            card.setFailureCount(card.getFailureCount() + 1);
            card.setConfidence(card.getConfidence().multiply(FAILURE_PENALTY));
            card.setLastUsedAt(LocalDateTime.now());
            
            if (card.getConfidence().compareTo(CONFIDENCE_THRESHOLD) < 0) {
                card.setStatus("PENDING_REVIEW");
            }
            
            knowledgeService.updateCard(card);
            logUsage(cardId, sql, "FAILURE", errorMsg);
        }
    }
    
    private void generateRecommendedVersion(WikiKnowledgeCard card) {
        WikiKnowledgeCard newCard = new WikiKnowledgeCard();
        newCard.setCardId(generateCardId(card));
        newCard.setEntityId(card.getEntityId());
        newCard.setCardType(card.getCardType());
        newCard.setTitle(card.getTitle() + " ⭐推荐");
        newCard.setContent(card.getContent());
        newCard.setConfidence(BigDecimal.valueOf(0.9));
        newCard.setStatus("RECOMMENDED");
        newCard.setExtractedFrom(List.of("SELF_ENHANCEMENT"));
        newCard.setUsageCount(0);
        
        card.setStatus("SUPERSEDED");
        card.setReplacementCardId(newCard.getCardId());
        
        knowledgeService.createCard(newCard);
        knowledgeService.updateCard(card);
    }
    
    private void logUsage(String cardId, String sql, String result, String errorMsg) {
        jdbcTemplate.update(
            "INSERT INTO s2_wiki_card_usage_log (card_id, sql, result, error_msg) VALUES (?, ?, ?, ?)",
            cardId, sql, result, errorMsg
        );
    }
}
```

- [ ] **Step 3: 创建测试**

```java
@Test
void testOnSqlSuccessBoostsConfidence() {
    WikiKnowledgeCard card = new WikiKnowledgeCard();
    card.setCardId("kc:test:001");
    card.setConfidence(BigDecimal.valueOf(0.9));
    card.setUsageCount(10);
    card.setSuccessCount(9);
    
    selfEnhancementService.onSqlSuccess("SELECT ...", List.of("kc:test:001"));
    
    WikiKnowledgeCard updated = knowledgeService.getCardById("kc:test:001");
    assertTrue(updated.getConfidence().compareTo(BigDecimal.valueOf(0.9)) > 0);
    assertEquals(11, updated.getUsageCount());
}
```

- [ ] **Step 4: 运行测试**

Run: `mvn test -Dtest=SelfEnhancementServiceTest -pl headless/core`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/SelfEnhancementService.java
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiCardUsageLog.java
git commit -m "feat(wiki): add SelfEnhancementService for knowledge compounding"
```

---

## 阶段二：健康巡检系统

### Task 6: 完善 WikiScheduler 健康巡检

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/scheduler/WikiScheduler.java`
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiHealthService.java`
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/ContradictionDetectionService.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/scheduler/WikiSchedulerTest.java`

- [ ] **Step 1: 创建 WikiHealthService**

```java
@Service
@RequiredArgsConstructor
public class WikiHealthService {
    private final JdbcTemplate jdbcTemplate;
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService entityService;
    private final ContradictionDetectionService contradictionDetection;
    
    public WikiHealthReport generateDailyReport() {
        WikiHealthReport report = new WikiHealthReport();
        report.setReportId("RPT-" + LocalDate.now().format(DateTimeFormatter.BASIC_ISO_DATE) + "-001");
        report.setReportType("DAILY");
        report.setCheckedAt(LocalDateTime.now());
        
        // 矛盾检测
        List<Contradiction> contradictions = contradictionDetection.detectAll();
        report.setContradictionsFound(contradictions.size());
        
        // 过时卡片
        int outdatedCards = knowledgeService.countOutdatedCards(30);
        report.setOutdatedCards(outdatedCards);
        
        // 孤立实体
        int orphanEntities = entityService.countOrphanEntities();
        report.setOrphanEntities(orphanEntities);
        
        report.setStatus("PENDING_PROCESSED");
        
        saveReport(report);
        return report;
    }
    
    private void saveReport(WikiHealthReport report) {
        jdbcTemplate.update(
            "INSERT INTO s2_wiki_health_report (report_id, report_type, checked_at, "
            + "contradictions_found, outdated_cards, orphan_entities, status, created_at) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
            report.getReportId(), report.getReportType(), report.getCheckedAt(),
            report.getContradictionsFound(), report.getOutdatedCards(), 
            report.getOrphanEntities(), report.getStatus(), LocalDateTime.now()
        );
    }
}
```

- [ ] **Step 2: 完善 ContradictionDetectionService**

```java
@Service
@RequiredArgsConstructor
public class ContradictionDetectionService {
    private final JdbcTemplate jdbcTemplate;
    private final WikiKnowledgeService knowledgeService;
    
    public List<Contradiction> detectAll() {
        List<Contradiction> results = new ArrayList<>();
        results.addAll(detectSemanticMappingContradictions());
        results.addAll(detectBusinessRuleContradictions());
        return results;
    }
    
    public List<Contradiction> detectSemanticMappingContradictions() {
        String sql = """
            SELECT a.entity_id, a.title as a_title, b.title as b_title, 
                   a.content as a_content, b.content as b_content
            FROM s2_wiki_knowledge_card a
            JOIN s2_wiki_knowledge_card b ON a.entity_id = b.entity_id
            WHERE a.card_type = 'SEMANTIC_MAPPING' 
              AND b.card_type = 'SEMANTIC_MAPPING'
              AND a.card_id < b.card_id
              AND (a.content->>'term') = (b.content->>'term')
              AND (a.content->>'field') != (b.content->>'field')
            """;
        
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            Contradiction c = new Contradiction();
            c.setEntityId(rs.getString("entity_id"));
            c.setConflictType("SEMANTIC_MAPPING");
            c.setOldContent(rs.getString("a_content"));
            c.setNewEvidence(rs.getString("b_content"));
            return c;
        });
    }
}
```

- [ ] **Step 3: 更新 WikiScheduler**

```java
@Component
@EnableScheduling
@Slf4j
public class WikiScheduler {
    private final WikiHealthService healthService;
    private final WikiSummaryService summaryService;
    
    @Scheduled(cron = "0 0 2 * * ?")
    public void dailyHealthCheck() {
        log.info("Starting daily wiki health check...");
        try {
            WikiHealthReport report = healthService.generateDailyReport();
            log.info("Daily health check completed: {} contradictions, {} outdated, {} orphans",
                report.getContradictionsFound(), report.getOutdatedCards(), report.getOrphanEntities());
        } catch (Exception e) {
            log.error("Daily health check failed", e);
        }
    }
    
    @Scheduled(cron = "0 0 3 * * ?")
    public void weeklyDeepCheck() {
        log.info("Starting weekly deep health check...");
        // 孤立页面检测 + 缺失引用检测 + 研究方向生成
    }
}
```

- [ ] **Step 4: 测试**

```java
@Test
void testDailyHealthCheck() {
    WikiHealthReport report = healthService.generateDailyReport();
    assertNotNull(report.getReportId());
    assertEquals("DAILY", report.getReportType());
}
```

- [ ] **Step 5: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/scheduler/WikiScheduler.java
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiHealthService.java
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/ContradictionDetectionService.java
git commit -m "feat(wiki): implement daily health check scheduler"
```

---

### Task 7: 创建 WikiHealthController（健康巡检报告 API）

**Files:**
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiHealthController.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/WikiHealthControllerTest.java`

- [ ] **Step 1: 创建 WikiHealthController**

```java
@RestController
@RequestMapping("/api/wiki/health")
@RequiredArgsConstructor
public class WikiHealthController {
    private final WikiHealthService healthService;
    private final ContradictionDetectionService contradictionService;
    private final WikiEntityService entityService;
    
    @GetMapping("/reports")
    public BaseResp<List<WikiHealthReport>> getReports(
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(defaultValue = "0") int offset) {
        List<WikiHealthReport> reports = healthService.getReports(limit, offset);
        return BaseResp.ok(reports);
    }
    
    @GetMapping("/reports/{reportId}")
    public BaseResp<WikiHealthReport> getReportDetail(@PathVariable String reportId) {
        WikiHealthReport report = healthService.getReportById(reportId);
        return report != null ? BaseResp.ok(report) : BaseResp.fail("Report not found");
    }
    
    @GetMapping("/stats")
    public BaseResp<HealthStats> getStats() {
        HealthStats stats = new HealthStats();
        stats.setPendingReports(healthService.countPendingReports());
        stats.setPendingContradictions(contradictionService.countPending());
        stats.setOrphanEntities(entityService.countOrphanEntities());
        return BaseResp.ok(stats);
    }
    
    @PostMapping("/trigger")
    public BaseResp<Void> triggerHealthCheck(@RequestParam(defaultValue = "FULL") String type) {
        if ("FULL".equals(type)) {
            healthService.generateDailyReport();
        }
        return BaseResp.ok();
    }
}
```

- [ ] **Step 2: 测试**

```java
@Test
void testGetReports() {
    List<WikiHealthReport> reports = healthController.getReports(10, 0).getData();
    assertNotNull(reports);
}
```

- [ ] **Step 3: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiHealthController.java
git commit -m "feat(wiki): add WikiHealthController for health report API"
```

---

## 阶段三：表结构导入与知识自动生成

### Task 8: 创建 WikiSchemaController（SQL 脚本导入 API）

**Files:**
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiSchemaController.java`
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/AutoKnowledgeGenerator.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/WikiSchemaControllerTest.java`

- [ ] **Step 1: 创建 WikiSchemaController**

```java
@RestController
@RequestMapping("/api/wiki/schema")
@RequiredArgsConstructor
public class WikiSchemaController {
    private final JdbcTemplate jdbcTemplate;
    private final WikiEntityService entityService;
    private final WikiKnowledgeService knowledgeService;
    private final AutoKnowledgeGenerator autoKnowledgeGenerator;
    
    @GetMapping("/template")
    public BaseResp<String> getImportTemplate() {
        return BaseResp.ok(getSqlTemplate());
    }
    
    @PostMapping("/validate")
    public BaseResp<ImportPreview> validateScript(@RequestBody String sqlScript) {
        ImportPreview preview = parseSqlPreview(sqlScript);
        return BaseResp.ok(preview);
    }
    
    @PostMapping("/import")
    @Transactional
    public BaseResp<ImportResult> executeImport(@RequestBody String sqlScript) {
        ImportResult result = new ImportResult();
        executeSqlScript(sqlScript, result);
        return BaseResp.ok(result);
    }
    
    private String getSqlTemplate() {
        return """
            -- LLM-SQL-Wiki 表结构导入脚本
            -- 1. 定义主题
            INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, topic_id, status)
            VALUES ('topic:example', 'TOPIC', 'example', '示例主题', '描述', 'topic:example', 'ACTIVE');
            
            -- 2. 定义表
            INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, topic_id, status)
            VALUES ('table:example_table', 'TABLE', 'example_table', '示例表', '描述', '{}', 'topic:example', 'ACTIVE');
            
            -- 3. 定义字段
            INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
            VALUES ('table:example_table:column:id', 'COLUMN', 'id', 'ID', '主键', '{}', 'table:example_table', 'ACTIVE');
            """;
    }
}
```

- [ ] **Step 2: 创建 AutoKnowledgeGenerator**

```java
@Service
@RequiredArgsConstructor
public class AutoKnowledgeGenerator {
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService entityService;
    private final WikiLinkService linkService;
    
    public List<WikiKnowledgeCard> generateFromTableSchema(WikiEntity table) {
        List<WikiKnowledgeCard> cards = new ArrayList<>();
        List<WikiEntity> columns = entityService.getChildEntities(table.getEntityId());
        
        for (WikiEntity column : columns) {
            // 语义映射
            WikiKnowledgeCard mappingCard = generateSemanticMapping(table, column);
            if (mappingCard != null) cards.add(mappingCard);
            
            // 业务规则
            WikiKnowledgeCard ruleCard = generateBusinessRule(table, column);
            if (ruleCard != null) cards.add(ruleCard);
            
            // 使用模式
            WikiKnowledgeCard patternCard = generateUsagePattern(table, column);
            if (patternCard != null) cards.add(patternCard);
        }
        
        // 指标定义
        cards.addAll(generateMetricDefinitions(table, columns));
        
        return cards;
    }
    
    private WikiKnowledgeCard generateSemanticMapping(WikiEntity table, WikiEntity column) {
        if (isMeaninglessField(column.getName())) return null;
        
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setCardId(generateCardId(table, column, "SEMANTIC_MAPPING"));
        card.setEntityId(table.getEntityId());
        card.setCardType("SEMANTIC_MAPPING");
        card.setTitle(column.getDisplayName() + " → " + column.getName() + " 映射");
        
        Map<String, String> content = new HashMap<>();
        content.put("term", column.getDisplayName());
        content.put("field", column.getName());
        content.put("table", table.getName());
        card.setContent(JSON.toJSONString(content));
        
        card.setConfidence(BigDecimal.valueOf(0.7));
        card.setStatus("AUTO_GENERATED");
        card.setExtractedFrom(List.of("AUTO_EXTRACTED"));
        
        return card;
    }
    
    private WikiKnowledgeCard generateBusinessRule(WikiEntity table, WikiEntity column) {
        String businessNote = column.getProperties().get("businessNote");
        if (businessNote == null || businessNote.isEmpty()) return null;
        
        BusinessRule rule = parseBusinessNote(businessNote);
        if (rule == null) return null;
        
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setCardId(generateCardId(table, column, "BUSINESS_RULE"));
        card.setEntityId(table.getEntityId());
        card.setCardType("BUSINESS_RULE");
        card.setTitle(rule.getMeaning());
        card.setContent(JSON.toJSONString(rule));
        card.setConfidence(BigDecimal.valueOf(0.8));
        card.setStatus("AUTO_GENERATED");
        card.setExtractedFrom(List.of("AUTO_EXTRACTED"));
        
        return card;
    }
    
    private BusinessRule parseBusinessNote(String note) {
        // 解析 "qfje > 0 表示存在欠费"
        Pattern pattern = Pattern.compile("(.*?)\\s*>(>|<=)?\\s*(.*?)\\s*表示(.*)");
        Matcher matcher = pattern.matcher(note);
        if (matcher.matches()) {
            return new BusinessRule(
                matcher.group(1).trim() + " " + (matcher.group(2) != null ? matcher.group(2) : ">") + " " + matcher.group(3).trim(),
                matcher.group(4).trim(),
                1
            );
        }
        return null;
    }
    
    private boolean isMeaninglessField(String fieldName) {
        return fieldName == null || fieldName.isEmpty() 
            || fieldName.equalsIgnoreCase("id") 
            || fieldName.equalsIgnoreCase("created_at")
            || fieldName.equalsIgnoreCase("updated_at");
    }
}
```

- [ ] **Step 3: 测试**

```java
@Test
void testAutoGenerateFromTable() {
    WikiEntity table = new WikiEntity();
    table.setEntityId("table:test");
    table.setName("test");
    
    WikiEntity column = new WikiEntity();
    column.setEntityId("table:test:column:amount");
    column.setName("amount");
    column.setDisplayName("金额");
    
    when(entityService.getChildEntities("table:test")).thenReturn(List.of(column));
    
    List<WikiKnowledgeCard> cards = autoKnowledgeGenerator.generateFromTableSchema(table);
    
    assertFalse(cards.isEmpty());
    assertTrue(cards.stream().anyMatch(c -> c.getCardType().equals("SEMANTIC_MAPPING")));
}
```

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiSchemaController.java
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/AutoKnowledgeGenerator.java
git commit -m "feat(wiki): add WikiSchemaController and AutoKnowledgeGenerator"
```

---

### Task 9: 完善 PromptHelper（Wiki-SQL Prompt 模板）

**Files:**
- Modify: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/llm/PromptHelper.java`
- Test: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/parser/llm/PromptHelperTest.java`

- [ ] **Step 1: 添加 Wiki-SQL Prompt 方法**

```java
// 在 PromptHelper.java 中添加

public static final String WIKI_SQL_PROMPT_TEMPLATE = """
    # Role: 你是数据分析师，擅长将自然语言转换为 SQL
    
    # Task: 根据用户的自然语言查询，结合提供的 Wiki 知识，生成准确的 SQL
    
    ## Wiki 知识上下文
    
    ### 业务术语映射
    {semantic_mappings}
    
    ### 业务规则
    {business_rules}
    
    ### 常用查询模式
    {usage_patterns}
    
    ### 指标定义
    {metric_definitions}
    
    ## 数据库表结构
    {schema_info}
    
    ## 当前会话上下文
    {conversation_context}
    
    # 用户查询
    {query_text}
    
    # 输出要求
    1. 只输出 SQL 语句，不要其他解释
    2. SQL 必须基于上述表结构
    3. 如需时间范围筛选，使用 cnq = '{default_time_range}'
    4. 如果 Wiki 知识与表结构冲突，以表结构为准
    5. 必须使用 Wiki 知识中的字段映射，不要自行推断字段名
    
    # SQL 生成
    """;

public String buildWikiSqlPrompt(WikiRetrievalResult retrieval, 
                                  ConversationContext ctx,
                                  String queryText) {
    Map<String, String> placeholders = new HashMap<>();
    placeholders.put("semantic_mappings", buildSemanticMappings(retrieval.getSemanticMappings()));
    placeholders.put("business_rules", buildBusinessRules(retrieval.getBusinessRules()));
    placeholders.put("usage_patterns", buildUsagePatterns(retrieval.getUsagePatterns()));
    placeholders.put("metric_definitions", buildMetricDefinitions(retrieval.getMetricDefinitions()));
    placeholders.put("schema_info", buildSchemaInfo(retrieval));
    placeholders.put("conversation_context", buildConversationContext(ctx));
    placeholders.put("query_text", queryText);
    placeholders.put("default_time_range", getDefaultTimeRange());
    
    return interpolateTemplate(WIKI_SQL_PROMPT_TEMPLATE, placeholders);
}

private String buildSemanticMappings(List<SemanticMapping> mappings) {
    if (mappings == null || mappings.isEmpty()) return "无";
    return mappings.stream()
        .map(m -> String.format("- %s → %s (%s)", m.getTerm(), m.getField(), m.getTable()))
        .collect(Collectors.joining("\n"));
}
```

- [ ] **Step 2: 测试**

```java
@Test
void testBuildWikiSqlPrompt() {
    WikiRetrievalResult retrieval = new WikiRetrievalResult();
    retrieval.setSemanticMappings(List.of(
        new SemanticMapping("收入", "order_amount", "sales_order")
    ));
    
    String prompt = promptHelper.buildWikiSqlPrompt(retrieval, null, "查询收入");
    
    assertTrue(prompt.contains("收入 → order_amount"));
    assertTrue(prompt.contains("查询收入"));
}
```

- [ ] **Step 3: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/llm/PromptHelper.java
git commit -m "feat(wiki): add Wiki-SQL prompt template to PromptHelper"
```

---

## 阶段四：知识卡片管理与复利看板

### Task 10: 扩展 WikiController 知识卡片管理 API

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiController.java`
- Test: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/WikiControllerKnowledgeCardTest.java`

- [ ] **Step 1: 添加知识卡片批量查询方法**

```java
// 在 WikiController 中添加

@GetMapping("/knowledge/search")
public BaseResp<List<WikiKnowledgeCard>> searchKnowledge(
        @RequestParam String query,
        @RequestParam(defaultValue = "10") int topK) {
    List<WikiKnowledgeCard> cards = knowledgeService.searchKnowledge(query, topK);
    return BaseResp.ok(cards);
}

@GetMapping("/knowledge/stats")
public BaseResp<KnowledgeStats> getKnowledgeStats() {
    KnowledgeStats stats = new KnowledgeStats();
    stats.setTotalCards(knowledgeService.countActiveCards());
    stats.setAvgConfidence(knowledgeService.getAvgConfidence());
    stats.setCardsByType(knowledgeService.countByType());
    return BaseResp.ok(stats);
}

@GetMapping("/knowledge/compounding-trend")
public BaseResp<CompoundingTrend> getCompoundingTrend(
        @RequestParam(defaultValue = "30") int days) {
    CompoundingTrend trend = knowledgeService.getCompoundingTrend(days);
    return BaseResp.ok(trend);
}
```

- [ ] **Step 2: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiController.java
git commit -m "feat(wiki): add knowledge card search and stats API"
```

---

## 实施检查清单

| 阶段 | 任务 | 描述 | 状态 |
|------|------|------|------|
| 一 | Task 1 | 扩展 WikiKnowledgeCard | ⬜ |
| 一 | Task 2 | 创建数据库新表 | ⬜ |
| 一 | Task 3 | 创建 WikiHealthReport DTO | ⬜ |
| 一 | Task 4 | 创建 WikiQueryEngine | ⬜ |
| 一 | Task 5 | 创建 SelfEnhancementService | ⬜ |
| 二 | Task 6 | 完善 WikiScheduler 健康巡检 | ⬜ |
| 二 | Task 7 | 创建 WikiHealthController | ⬜ |
| 三 | Task 8 | 创建 WikiSchemaController | ⬜ |
| 三 | Task 9 | 完善 PromptHelper | ⬜ |
| 四 | Task 10 | 扩展 WikiController | ⬜ |

---

## 依赖关系

```
Task 1 ──→ Task 2 ──→ Task 3
                      ↓
Task 4 ──→ Task 5 ──→ Task 6 ──→ Task 7
                  ↓                   
             Task 9 ←────────────────┘
                  ↓
             Task 8 ──→ Task 10
```
