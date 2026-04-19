# LLM-SQL-Wiki 知识中心设计规范

## 一、背景与目标

### 1.1 核心理念

LLM-SQL-Wiki 是一套基于关系型数据库表结构为知识点的专业 SQL 生成知识中心。系统以 **Wiki 为核心**，所有知识持久化存储在 PostgreSQL + PGVector 中，自然语言查询通过 Wiki 知识库转换为数据库可执行的 SQL，知识可复利累积并动态自增强。

核心思想来自 LLM Wiki 模式：
- **Raw Sources** → 原始数据库表结构（不可变）
- **The Wiki** → WikiEntity + WikiKnowledgeCard（可累积、交叉引用）
- **The Schema** → Prompt 模板（告诉 LLM 如何使用知识）

### 1.2 设计原则

1. **纯数据库方案**：所有知识存储在 PostgreSQL + PGVector，保证性能和查询能力
2. **半自动健康巡检**：发现问题自动生成报告，低风险操作自动执行，高风险操作需人工确认
3. **持久化上下文**：用户查询意图、已确定的实体、已生成的 SQL 持久化到数据库，跨会话可恢复
4. **SQL 脚本导入**：通过 SQL 脚本导入表结构，可批量导入并自动生成知识卡片
5. **强自增强**：知识被成功使用后自动提升置信度，达到条件时自动生成新版本推荐卡片

---

## 二、整体架构

```
┌──────────────────────────────────────────────────────────────────┐
│                        用户查询入口                                │
│                     ChatQueryController                          │
└────────────────────────────┬─────────────────────────────────────┘
                             ↓
┌──────────────────────────────────────────────────────────────────┐
│                    WikiQueryEngine（核心引擎）                     │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐  │
│  │  意图识别   │  │  知识检索   │  │    上下文管理            │  │
│  │ IntentDetector│  │ WikiRetriever│  │ ConversationContextMgr │  │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘  │
└────────────────────────────┬─────────────────────────────────────┘
                             ↓
┌──────────────────────────────────────────────────────────────────┐
│                      知识编排层 WikiKnowledgeBase                 │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐    │
│  │ SemanticMap│ │BusinessRule│ │UsagePattern│ │MetricDef   │    │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘    │
└────────────────────────────┬─────────────────────────────────────┘
                             ↓
┌──────────────────────────────────────────────────────────────────┐
│                      SQL 生成与验证                                 │
│  ┌─────────────────┐    ┌─────────────────┐                       │
│  │   SqlGenerator  │───→│ SqlValidator    │                       │
│  └─────────────────┘    └─────────────────┘                       │
│           │                      ↓                                │
│           └──────────────────────↓                                │
└─────────────────────────────────┼─────────────────────────────────┘
                                  ↓
┌──────────────────────────────────────────────────────────────────┐
│                      自增强层 SelfEnhancement                      │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐    │
│  │ 成功累计   │ │ 失败记录   │ │ 版本管理   │ │ 矛盾检测   │    │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘    │
└────────────────────────────┬─────────────────────────────────────┘
                             ↓
┌──────────────────────────────────────────────────────────────────┐
│                      持久化层 PostgreSQL + PGVector               │
│  s2_wiki_entity | s2_wiki_knowledge_card | s2_wiki_topic_summary │
└──────────────────────────────────────────────────────────────────┘
```

---

## 三、核心组件设计

### 3.1 WikiQueryEngine（核心引擎）

负责协调意图识别、知识检索、上下文管理和 SQL 生成。

```java
public class WikiQueryEngine {
    
    // 核心流程
    public QueryResult process(QueryRequest request) {
        // 1. 意图识别 - 判断用户查询类型（统计、筛选、排序等）
        Intent intent = intentDetector.detect(request);
        
        // 2. 持久化上下文恢复 - 从数据库加载跨会话上下文
        ConversationContext ctx = contextManager.restore(request.getConversationId());
        
        // 3. Wiki 知识检索 - 基于查询文本检索相关实体和知识卡片
        WikiRetrievalResult retrieval = wikiRetriever.retrieve(request, intent);
        
        // 4. 知识组装 - 将检索结果组装成 LLM 可理解的上下文
        String wikiContext = knowledgeAssembler.assemble(retrieval, intent);
        
        // 5. SQL 生成
        String sql = sqlGenerator.generate(request, intent, wikiContext, ctx);
        
        // 6. SQL 验证
        ValidationResult validation = sqlValidator.validate(sql, retrieval.getRelatedEntityIds());
        
        // 7. 自增强反馈
        selfEnhancement.feedback(request, sql, validation, retrieval);
        
        // 8. 持久化上下文更新
        contextManager.save(sql, validation, retrieval, ctx);
        
        return new QueryResult(sql, validation, retrieval);
    }
}
```

**组件职责：**

| 组件 | 职责 | 依赖 |
|------|------|------|
| `IntentDetector` | 识别查询意图（统计/筛选/排序/对比） | 无 |
| `WikiRetriever` | 检索相关 WikiEntity 和 WikiKnowledgeCard | WikiKnowledgeService |
| `KnowledgeAssembler` | 组装 wiki 上下文为 Prompt | WikiRetriever |
| `SqlGenerator` | 调用 LLM 生成 SQL | WikiRetriever, LLM |
| `SqlValidator` | 验证 SQL 语法和语义 | JdbcExecutor |
| `SelfEnhancement` | 自增强反馈 | WikiKnowledgeService |
| `ConversationContextManager` | 跨会话上下文持久化 | s2_wiki_conversation_context |

### 3.2 WikiKnowledgeBase（知识库）

```java
public class WikiKnowledgeBase {
    
    // 1. 语义映射管理 - 业务术语 ↔ 数据库字段
    public SemanticMapping getSemanticMapping(Long dataSetId, String term);
    
    // 2. 业务规则管理 - 如 qfje > 0 表示欠费
    public List<BusinessRule> getBusinessRules(Long dataSetId, String entityId);
    
    // 3. 使用模式管理 - 常用查询模式
    public List<UsagePattern> getUsagePatterns(Long dataSetId, String entityId);
    
    // 4. 指标定义管理 - 指标计算公式
    public List<MetricDefinition> getMetricDefinitions(Long dataSetId, String entityId);
    
    // 5. 向量检索 - 基于语义相似度检索
    public List<WikiKnowledgeCard> searchByEmbedding(String queryText, int topK);
    
    // 6. 矛盾检测 - 检测新旧知识冲突
    public List<Contradiction> detectContradictions(String entityId, WikiKnowledgeCard newCard);
    
    // 7. 知识版本管理 - 自动版本递增
    public WikiKnowledgeCard createNewVersion(String cardId, WikiKnowledgeCard newContent);
}
```

**数据模型扩展：**

| 类型 | content 格式示例 |
|------|-----------------|
| SEMANTIC_MAPPING | `{"term":"收入","field":"order_amount","table":"sales_order"}` |
| BUSINESS_RULE | `{"condition":"qfje > 0","meaning":"存在欠费","priority":1}` |
| USAGE_PATTERN | `{"pattern":"查询欠费用户","sql_template":"WHERE qfje > 0 AND cnq = ?"}` |
| METRIC_DEFINITION | `{"metric":"收入总额","formula":"SUM(order_amount)","unit":"元"}` |

---

## 四、数据流设计

### 4.1 用户查询完整数据流

```
用户输入："查询本季度收入超过100万的客户"
                                    ↓
Step 1: 意图识别 IntentDetector.detect()
  输出：Intent { type: "AGGREGATE_FILTER", entities: ["sales_order"],
                metrics: ["order_amount"], filters: [...] }
                                    ↓
Step 2: 持久化上下文恢复 ConversationContextManager.restore()
  SELECT * FROM s2_wiki_conversation_context
  WHERE conversation_id = ? AND status = 'ACTIVE'
  ORDER BY round_number DESC LIMIT 10
                                    ↓
Step 3: Wiki 知识检索 WikiRetriever.retrieve()
  -- 3.1 基于查询文本向量检索知识卡片
  SELECT * FROM s2_wiki_knowledge_card
  WHERE status = 'ACTIVE' AND embedding <=> '[...]' < 1.0
  ORDER BY embedding <=> '[...]' LIMIT 10

  -- 3.2 基于识别的实体检索关联知识
  SELECT * FROM s2_wiki_knowledge_card
  WHERE entity_id IN (?) AND status = 'ACTIVE'

  -- 3.3 获取表结构信息
  SELECT * FROM s2_wiki_entity
  WHERE entity_id IN (?) AND entity_type = 'TABLE'
                                    ↓
Step 4: Wiki 上下文组装 KnowledgeAssembler.assemble()
  ## 语义映射
  - 收入 → order_amount (sales_order.order_amount)
  - 客户 → buyer_name (sales_order 表)

  ## 业务规则
  - qfje > 0 表示存在欠费

  ## 使用模式
  - 查询本季度: WHERE cnq = '当前采暖期'

  ## 指标定义
  - 收入总额 = SUM(order_amount)
                                    ↓
Step 5: SQL 生成 SqlGenerator.generate()
  构造 LLM Prompt，调用 LLM 生成 SQL
                                    ↓
Step 6: SQL 验证 SqlValidator.validate()
  -- 语法验证、语义验证、Schema 验证
                                    ↓
Step 7: 自增强反馈 SelfEnhancement.feedback()
  -- 成功：置信度 +5%，使用次数 +1
  -- 失败：置信度 -10%，记录失败原因
                                    ↓
Step 8: 持久化上下文更新 ContextManager.save()
  INSERT INTO s2_wiki_conversation_context (...)
```

---

## 五、健康巡检系统设计

### 5.1 巡检任务类型

| 任务 | 频率 | 检查内容 |
|------|------|---------|
| 矛盾检测 | 每日 | 同一实体的知识卡片是否存在逻辑冲突 |
| 过时检测 | 每周 | 知识卡片是否超过 30 天未更新且使用频率低 |
| 孤立页面检测 | 每周 | 没有任何引用的实体或知识卡片 |
| 缺失引用检测 | 每周 | 知识卡片中提到的实体是否都存在于知识库 |
| 自增强巡检 | 实时 | 置信度变化的卡片是否需要处理 |

### 5.2 矛盾检测 SQL

```sql
-- 检测 SEMANTIC_MAPPING 类型中，同一个 term 是否映射到不同字段
SELECT a.entity_id, a.title, b.title, a.content, b.content
FROM s2_wiki_knowledge_card a
JOIN s2_wiki_knowledge_card b ON a.entity_id = b.entity_id
WHERE a.card_type = 'SEMANTIC_MAPPING' 
  AND b.card_type = 'SEMANTIC_MAPPING'
  AND a.card_id < b.card_id
  AND (a.content->>'term') = (b.content->>'term')
  AND (a.content->>'field') != (b.content->>'field');
```

### 5.3 WikiScheduler 巡检调度

```java
@Component
@EnableScheduling
public class WikiHealthScheduler {
    
    @Scheduled(cron = "0 0 2 * * ?")  // 每天凌晨 2 点
    public void dailyHealthCheck() {
        // 1. 矛盾检测
        contradictionDetector.detectAll();
        // 2. 生成巡检报告
        HealthReport report = new HealthReport();
        report.setCheckedAt(LocalDateTime.now());
        report.setContradictionsFound(contradictionService.getPendingCount());
        report.setOutdatedCards(cardingService.getOutdatedCards(30));
        report.setOrphanEntities(entityService.getOrphanEntities());
        // 3. 发送报告
        notificationService.sendHealthReport(report);
    }
    
    @Scheduled(cron = "0 0 3 * * ?")  // 每天凌晨 3 点
    public void weeklyDeepCheck() {
        // 1. 孤立页面检测
        // 2. 缺失引用检测
        // 3. 研究方向生成
    }
}
```

---

## 六、健康巡检报告 UI

### 6.1 报告数据结构

```java
@TableName("s2_wiki_health_report")
public class WikiHealthReport {
    private Long id;
    private String reportId;           // 报告唯一标识
    private String reportType;          // DAILY/WEEKLY
    private LocalDateTime checkedAt;   // 检查时间
    private Integer contradictionsFound; // 发现的矛盾数
    private Integer outdatedCards;     // 过时卡片数
    private Integer orphanEntities;    // 孤立实体数
    private Integer missingRefs;      // 缺失引用数
    private String status;             // PENDING_PROCESSED / PROCESSED
    private String reportContent;      // JSON 格式详细报告
    private LocalDateTime createdAt;
}
```

### 6.2 REST API

```java
@RestController
@RequestMapping("/api/wiki/health")
public class WikiHealthController {
    
    @GetMapping("/reports")
    public BaseResp<List<WikiHealthReport>> getReports(int limit, int offset);
    
    @GetMapping("/reports/{reportId}")
    public BaseResp<WikiHealthReport> getReportDetail(@PathVariable String reportId);
    
    @GetMapping("/stats")
    public BaseResp<HealthStats> getStats();
    
    @PostMapping("/contradictions/{contradictionId}/resolve")
    public BaseResp<Void> resolveContradiction(@PathVariable String contradictionId, @RequestBody ResolveReq req);
    
    @PostMapping("/cards/{cardId}/refresh")
    public BaseResp<Void> refreshCard(@PathVariable String cardId);
    
    @PostMapping("/entities/{entityId}/link")
    public BaseResp<Void> linkOrphanEntity(@PathVariable String entityId, @RequestBody LinkReq req);
    
    @PostMapping("/trigger")
    public BaseResp<Void> triggerHealthCheck(@RequestParam(defaultValue = "FULL") String type);
    
    @GetMapping("/research-topics")
    public BaseResp<List<ResearchTopic>> getResearchTopics(@RequestParam(defaultValue = "PENDING") String status);
    
    @PostMapping("/research-topics/{topicId}/confirm")
    public BaseResp<Void> confirmResearchTopic(@PathVariable String topicId, @RequestBody ConfirmReq req);
}
```

---

## 七、表结构录入 UI（SQL 脚本导入）

### 7.1 SQL 脚本格式

```sql
-- ============================================
-- LLM-SQL-Wiki 表结构导入脚本
-- ============================================

-- 1. 定义主题（Topic）
INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, topic_id, status)
VALUES ('topic:heating', 'TOPIC', 'heating', '采暖主题', '与采暖相关的所有业务表', 'topic:heating', 'ACTIVE');

-- 2. 定义表（Table）
INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, topic_id, status)
VALUES ('table:sales_order', 'TABLE', 'sales_order', '销售订单表', '存储所有销售订单信息',
   '{"database": "heating_analytics", "schema": "public"}', 'topic:heating', 'ACTIVE');

-- 3. 定义字段（Column）
INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES 
  ('table:sales_order:column:order_amount', 'COLUMN', 'order_amount', '订单金额', '销售订单的总金额（元）',
   '{"dataType": "DECIMAL(15,2)", "nullable": true}', 'table:sales_order', 'ACTIVE'),
  ('table:sales_order:column:qfje', 'COLUMN', 'qfje', '欠费金额', '当前欠费金额',
   '{"dataType": "DECIMAL(15,2)", "nullable": false, "businessNote": "qfje > 0 表示存在欠费"}',
   'table:sales_order', 'ACTIVE');
```

### 7.2 REST API

```java
@RestController
@RequestMapping("/api/wiki/schema")
public class WikiSchemaController {
    
    @GetMapping("/template")
    public BaseResp<String> getImportTemplate();
    
    @PostMapping("/validate")
    public BaseResp<ImportPreview> validateScript(@RequestBody String sqlScript);
    
    @PostMapping("/import")
    public BaseResp<ImportResult> executeImport(@RequestBody String sqlScript);
    
    @PutMapping("/columns/batch-comment")
    public BaseResp<Void> batchUpdateColumnComments(@RequestBody List<ColumnCommentUpdate> updates);
    
    @PostMapping("/columns/{columnId}/business-rule")
    public BaseResp<Void> addBusinessRule(@PathVariable String columnId, @RequestBody BusinessRuleCreate req);
}
```

---

## 八、知识卡片管理与知识复利累积

### 8.1 知识卡片结构

```java
public class WikiKnowledgeCard {
    private Long id;
    private String cardId;
    private String entityId;
    private String cardType;          // SEMANTIC_MAPPING / BUSINESS_RULE / USAGE_PATTERN / METRIC_DEFINITION
    private String title;
    private String content;          // JSON 格式内容
    private List<String> extractedFrom;  // MANUAL / AUTO_EXTRACTED / SELF_ENHANCEMENT
    private BigDecimal confidence;    // 置信度 0.0-1.0
    private String status;           // ACTIVE / INACTIVE / CONFLICTED / DELETED / PENDING_REVIEW / SUPERSEDED
    private Integer usageCount;       // 使用次数
    private Integer successCount;     // 成功次数
    private Integer failureCount;     // 失败次数
    private LocalDateTime lastUsedAt;
    private String replacementCardId;
}
```

### 8.2 知识复利累积机制

```java
public class KnowledgeCompoundingService {
    
    // 成功使用：置信度缓慢提升（+2%）
    public void onCardUsedSuccessfully(String cardId, String sql) {
        card.setUsageCount(card.getUsageCount() + 1);
        card.setSuccessCount(card.getSuccessCount() + 1);
        card.setConfidence(card.getConfidence().multiply(BigDecimal.valueOf(1.02)).min(BigDecimal.ONE));
        
        // 使用次数 >= 20 且置信度 >= 0.95 且成功率 > 90%：自动生成推荐版本
        if (card.getUsageCount() >= 20 
            && card.getConfidence().compareTo(BigDecimal.valueOf(0.95)) >= 0
            && card.getSuccessRate() > 0.9) {
            autoGenerateRecommendedVersion(card);
        }
    }
    
    // 失败使用：置信度下降（-10%），低于 0.3 标记待审核
    public void onCardUsedFailed(String cardId, String sql, String errorMsg) {
        card.setFailureCount(card.getFailureCount() + 1);
        card.setConfidence(card.getConfidence().multiply(BigDecimal.valueOf(0.9)));
        if (card.getConfidence().compareTo(BigDecimal.valueOf(0.3)) < 0) {
            card.setStatus("PENDING_REVIEW");
        }
    }
}
```

---

## 九、SQL 脚本导入后自动生成知识

### 9.1 自动提取知识卡片

```java
public class AutoKnowledgeGenerator {
    
    // 分析表结构，自动生成知识卡片
    public List<WikiKnowledgeCard> generateFromTableSchema(WikiEntity table) {
        List<WikiKnowledgeCard> cards = new ArrayList<>();
        List<WikiEntity> columns = entityService.getChildEntities(table.getEntityId());
        
        for (WikiEntity column : columns) {
            // 1. 基于字段名生成语义映射
            WikiKnowledgeCard mappingCard = generateSemanticMapping(table, column);
            if (mappingCard != null) cards.add(mappingCard);
            
            // 2. 基于字段业务注释生成业务规则
            WikiKnowledgeCard ruleCard = generateBusinessRule(table, column);
            if (ruleCard != null) cards.add(ruleCard);
            
            // 3. 基于字段类型生成使用模式
            WikiKnowledgeCard patternCard = generateUsagePattern(table, column);
            if (patternCard != null) cards.add(patternCard);
        }
        
        // 4. 分析字段间关系，生成指标定义
        cards.addAll(generateMetricDefinitions(table, columns));
        
        return cards;
    }
}
```

### 9.2 自动生成的知识类型

| 知识类型 | 生成规则 | 置信度 |
|---------|---------|-------|
| SEMANTIC_MAPPING | 字段中文字段名 → 英文字段名 | 0.7 |
| BUSINESS_RULE | 解析字段的 businessNote 属性 | 0.8 |
| USAGE_PATTERN | 基于字段类型推断用法 | 0.6 |
| METRIC_DEFINITION | 分析金额类字段，自动生成 SUM 聚合 | 0.5 |
| RELATIONSHIP | 基于外键/字段名相似度建立表间关系 | 0.6 |

---

## 十、LLM Prompt 模板设计

### 10.1 系统级 Prompt

```java
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
```

### 10.2 Prompt 示例

**输入：** "查询本季度收入超过100万的客户"

**生成的 Prompt：**

```
## Wiki 知识上下文

### 业务术语映射
- 收入 → order_amount (sales_order)
- 客户 → buyer_name (sales_order)

### 业务规则
- 存在欠费: qfje > 0

### 常用查询模式
- 查询本季度: WHERE cnq = '2026Q1'

### 指标定义
- 收入总额 = SUM(order_amount)

## 数据库表结构
sales_order(
    order_amount DECIMAL(15,2)  -- 订单金额
    buyer_name VARCHAR(128)      -- 客户名称
    qfje DECIMAL(15,2)          -- 欠费金额
    cnq VARCHAR(20)             -- 采暖期
)

# 用户查询
查询本季度收入超过100万的客户

# SQL 生成
```

**期望输出：**

```sql
SELECT buyer_name, SUM(order_amount) AS total_amount
FROM sales_order
WHERE cnq = '2026Q1'
  AND order_amount > 1000000
GROUP BY buyer_name
```

---

## 十一、数据库表设计

### 11.1 新增表

```sql
-- 健康巡检报告表
CREATE TABLE IF NOT EXISTS s2_wiki_health_report (
    id BIGSERIAL PRIMARY KEY,
    report_id VARCHAR(128) NOT NULL UNIQUE,
    report_type VARCHAR(16) NOT NULL,  -- DAILY/WEEKLY
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
    result VARCHAR(16) NOT NULL,  -- SUCCESS/FAILURE
    error_msg TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 研究方向表
CREATE TABLE IF NOT EXISTS s2_wiki_research_topic (
    id BIGSERIAL PRIMARY KEY,
    topic_id VARCHAR(128) NOT NULL UNIQUE,
    topic VARCHAR(512) NOT NULL,
    priority VARCHAR(16) DEFAULT 'MEDIUM',  -- HIGH/MEDIUM/LOW
    reason TEXT,
    status VARCHAR(32) DEFAULT 'PENDING',  -- PENDING/CONFIRMED/DISMISSED
    related_entity_ids TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    confirmed_at TIMESTAMP,
    confirmed_by VARCHAR(64)
);

CREATE INDEX IF NOT EXISTS idx_report_type ON s2_wiki_health_report(report_type);
CREATE INDEX IF NOT EXISTS idx_report_status ON s2_wiki_health_report(status);
CREATE INDEX IF NOT EXISTS idx_card_usage_card ON s2_wiki_card_usage_log(card_id);
CREATE INDEX IF NOT EXISTS idx_topic_status ON s2_wiki_research_topic(status);
```

---

## 十二、风险与缓解

| 风险 | 影响 | 缓解措施 |
|------|------|----------|
| 自增强生成错误版本 | 知识库质量下降 | 生成的版本标记为 RECOMMENDED，需人工确认后才使用 |
| 矛盾检测误报 | 增加人工审核负担 | 仅当置信度都很高时才自动生成矛盾报告 |
| Prompt 过长 | LLM 上下文溢出 | 限制注入知识数量，按优先级截断 |
| 孤立实体积累 | 知识库碎片化 | 自动尝试基于名称相似度建立关联 |

---

## 十三、后续扩展

1. **动态示例注入**：根据 Wiki 知识自动生成 Few-shot 示例
2. **矛盾可视化**：在前端展示 Wiki 知识冲突关系图
3. **主动建议**：基于对话上下文主动推荐相关 Wiki 知识
4. **多语言支持**：Wiki 知识跨语言映射（中文术语 ↔ 英文字段名）
