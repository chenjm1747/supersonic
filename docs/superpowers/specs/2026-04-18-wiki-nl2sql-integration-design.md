# Wiki 知识库与 NL2SQL 整合设计规范

## 一、背景与目标

### 1.1 问题描述

当前 NL2SQL 解析系统在指标维度配置上存在困难，需要人工大量配置术语映射和业务规则。当用户问"查询本季度收入超过100万的客户"时：
- "收入" 可能无法正确映射到 `order_amount` 字段
- "本季度" 的日期范围需要人工配置
- "超过100万" 的筛选条件可能丢失

### 1.2 解决方案

通过 **Wiki 知识库** 为 NL2SQL 提供语义识别补充，在 Schema Mapping 阶段和 SQL 生成阶段都接入 Wiki 知识，实现：
- 业务术语自动映射到数据库字段
- 业务规则（如欠费判定规则）自动注入 SQL
- 指标定义自动补全

### 1.3 整合方式

**完全重构** - 以 Wiki 实体为核心重新设计解析流程，Wiki 知识直接参与 Schema 匹配和 SQL 生成。

---

## 二、目标架构

### 2.1 整体数据流

```
用户 Query
    ↓
┌─────────────────────────────────────────────────────────────┐
│ 阶段一：Wiki 实体检索                                        │
│ WikiSearchService.search(query)                             │
│ 返回：List<WikiEntity> + List<WikiKnowledgeCard>           │
└─────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────┐
│ 阶段二：增强 Schema Mapping                                  │
│ WikiAwareMapper.enhancedMap()                                │
│ Wiki 实体带来的额外信息融合到 SemanticSchema                  │
└─────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────┐
│ 阶段三：Wiki 上下文构建                                       │
│ WikiContextBuilder.buildContext()                            │
│ 按类型分类 WikiKnowledgeCard，生成结构化上下文                │
└─────────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────────┐
│ 阶段四：LLM SQL 生成                                         │
│ WikiLLMReq + 扩展 Prompt 模板                                │
│ 生成最终 SQL                                                │
└─────────────────────────────────────────────────────────────┘
```

### 2.2 与现有系统关系

```
现有架构：
NL2SQLParser → ChatLayerService → LLMSqlParser → OnePassSCSqlGenStrategy

新增/修改后：
NL2SQLParser → [WikiPreProcessor] → ChatLayerService → [WikiAwareLLMSqlParser] → OnePassSCSqlGenStrategy
                          ↓                         ↓
                   WikiSearchService        WikiContextBuilder
                   WikiKnowledgeService     WikiSemanticFusionService
```

---

## 三、组件设计

### 3.1 新增组件

| 组件 | 职责 | 包路径 |
|------|------|--------|
| `WikiPreProcessor` | Wiki 预处理，将检索结果注入请求上下文 | `headless/chat/.../parser/wiki/` |
| `WikiSemanticFusionService` | 融合 WikiEntity 与 SemanticSchema | `headless/chat/.../parser/wiki/` |
| `WikiAwareMapper` | 基于 Wiki 知识的增强 Schema Mapping | `headless/chat/.../mapper/` |
| `WikiContextBuilder` | 构建 Wiki 增强上下文字符串 | `headless/chat/.../parser/llm/` |
| `WikiLLMReq` | 扩展 LLMReq，包含 Wiki 知识 | `headless/chat/.../query/llm/s2sql/` |
| `WikiAwareLLMSqlParser` | 使用 Wiki 知识的 SQL 生成策略 | `headless/chat/.../parser/llm/` |

### 3.2 修改组件

| 组件 | 修改内容 |
|------|----------|
| `NL2SQLParser` | 添加 WikiPreProcessor 调用入口 |
| `LLMRequestService` | 构建 WikiLLMReq，注入 Wiki 上下文 |
| `OnePassSCSqlGenStrategy` | 扩展 Prompt 模板支持 Wiki 知识 |
| `WikiKnowledgeService` | 新增语义映射查询方法 `getSemanticMappings()` |
| `WikiEntityService` | 新增按术语搜索实体的方法 `searchEntitiesByTerm()` |

### 3.3 核心接口

```java
// WikiPreProcessor
public class WikiPreProcessor {
    public void preprocess(ParseContext parseContext) {
        // 1. 调用 WikiSearchService 检索相关 WikiEntity 和 WikiKnowledgeCard
        // 2. 将检索结果注入 ParseContext
    }
}

// WikiSemanticFusionService
public interface WikiSemanticFusionService {
    EnhancedSchema fuseWithWiki(Long dataSetId, String queryText,
                                SemanticSchema semanticSchema,
                                List<WikiEntity> wikiEntities,
                                List<WikiKnowledgeCard> wikiCards);
}

// WikiAwareMapper
public interface WikiAwareMapper {
    List<SchemaElementMatch> enhancedMap(Long dataSetId, String queryText,
                                        EnhancedSchema enhancedSchema);
}

// WikiContextBuilder
public class WikiContextBuilder {
    public String buildContext(List<WikiKnowledgeCard> cards);
    public String buildBusinessRules(List<WikiKnowledgeCard> rules);
    public String buildUsagePatterns(List<WikiKnowledgeCard> patterns);
    public String buildMetricDefinitions(List<WikiKnowledgeCard> definitions);
    public String buildSemanticMappings(List<WikiKnowledgeCard> mappings);
}

// WikiLLMReq - 扩展 LLMReq
public class WikiLLMReq extends LLMReq {
    private List<WikiKnowledgeCard> businessRules;
    private List<WikiKnowledgeCard> usagePatterns;
    private List<WikiKnowledgeCard> metricDefinitions;
    private List<WikiKnowledgeCard> semanticMappings;
    private List<WikiEntity> relatedEntities;
}
```

---

## 四、数据结构设计

### 4.1 EnhancedSchema

```java
@Data
public class EnhancedSchema {
    private SemanticSchema originalSchema;
    private List<WikiEntity> relatedWikiEntities;
    private List<WikiKnowledgeCard> knowledgeCards;
    private Map<String, String> termToFieldMapping;  // 术语→字段映射
    private Map<String, String> fieldToTermMapping;  // 字段→术语映射
    private List<String> businessRules;               // 业务规则列表
}
```

### 4.2 WikiKnowledgeCard 扩展

现有 `WikiKnowledgeCard` 已包含所需字段，新增按类型查询方法：

```java
// WikiKnowledgeService 新增方法
public List<WikiKnowledgeCard> getSemanticMappings(Long dataSetId);
public List<WikiKnowledgeCard> getBusinessRules(Long dataSetId);
public List<WikiKnowledgeCard> getUsagePatterns(Long dataSetId);
public List<WikiKnowledgeCard> getMetricDefinitions(Long dataSetId);
```

### 4.3 术语映射结构

SEMANTIC_MAPPING 类型的卡片 content 格式：
```json
{
  "term": "收入",
  "field": "order_amount",
  "table": "sales_order",
  "description": "销售收入字段"
}
```

---

## 五、Prompt 模板设计

### 5.1 原始 Prompt

```prompt
#Role: You are a data analyst experienced in SQL languages.
#Task: Convert natural language question to SQL.
#Rules:
1.SQL columns and values must be mentioned in the Schema
2.ALWAYS specify time range using >,<,>=,<= operator.
...
#Exemplars: {exemplar}
#Query: Question:{question},Schema:{schema},SideInfo:{information}
```

### 5.2 Wiki 增强后 Prompt

```prompt
#Role: You are a data analyst experienced in SQL languages.
#Task: Convert natural language question to SQL.
#Rules:
1.SQL columns and values must be mentioned in the Schema
2.ALWAYS specify time range using >,<,>=,<= operator.
...
#Exemplars: {exemplar}
#Query: Question:{question},Schema:{schema},SideInfo:{information}

## Wiki 语义映射 (Semantic Mappings)
以下业务术语对应数据库字段：
{semantic_mappings_from_wiki}

## Wiki 业务规则 (Business Rules)
{business_rules_from_wiki}

## Wiki 使用模式 (Usage Patterns)
{usage_patterns_from_wiki}

## Wiki 指标定义 (Metric Definitions)
{metric_definitions_from_wiki}
```

### 5.3 示例

**用户问题**: "查询本季度收入超过100万的客户"

**Wiki 增强上下文**:
```
## Wiki 语义映射
- 收入 → order_amount (sales_order 表)
- 客户 → buyer_name (sales_order 表)

## Wiki 业务规则
- qfje > 0 表示存在欠费
- yhlx = '居民' 表示居民用户

## Wiki 使用模式
- 查询欠费用户: WHERE qfje > 0 AND cnq = '当前采暖期'
- 按地区统计: GROUP BY region_name

## Wiki 指标定义
- 收入总额 = SUM(order_amount)
- 收费率 = SUM(sfje) / SUM(ysje)
```

---

## 六、实现阶段

### Phase 1: Wiki 基础集成 (P0)

**目标**: 完成 Wiki 检索与 NL2SQL Parser 的集成

**工作内容**:
1. 创建 `WikiPreProcessor` 类
2. 修改 `NL2SQLParser` 添加 Wiki 预处理调用
3. 创建 `WikiSearchService` 与 `NL2SQLParser` 的桥接
4. 实现基础的 Wiki 上下文注入

**文件变更**:
- 新增: `headless/chat/src/main/java/.../parser/wiki/WikiPreProcessor.java`
- 修改: `chat/server/src/main/java/.../parser/NL2SQLParser.java`

### Phase 2: Schema 融合 (P0)

**目标**: 实现 WikiEntity 与 SemanticSchema 的融合

**工作内容**:
1. 创建 `WikiSemanticFusionService`
2. 创建 `EnhancedSchema` 数据结构
3. 创建 `WikiAwareMapper`
4. 实现术语→字段的自动映射逻辑

**文件变更**:
- 新增: `headless/chat/src/main/java/.../parser/wiki/WikiSemanticFusionService.java`
- 新增: `headless/chat/src/main/java/.../parser/wiki/EnhancedSchema.java`
- 新增: `headless/chat/src/main/java/.../mapper/WikiAwareMapper.java`

### Phase 3: 上下文构建 (P1)

**目标**: 构建 Wiki 知识到 Prompt 上下文的转换

**工作内容**:
1. 创建 `WikiContextBuilder`
2. 实现各类 WikiKnowledgeCard 到字符串的转换
3. 修改 `LLMRequestService` 支持 WikiLLMReq
4. 扩展 Prompt 模板

**文件变更**:
- 新增: `headless/chat/src/main/java/.../parser/llm/WikiContextBuilder.java`
- 新增: `headless/chat/src/main/java/.../query/llm/s2sql/WikiLLMReq.java`
- 修改: `headless/chat/src/main/java/.../parser/llm/LLMRequestService.java`
- 修改: `headless/chat/src/main/java/.../parser/llm/OnePassSCSqlGenStrategy.java`

### Phase 4: Wiki SQL 生成策略 (P2)

**目标**: 实现 Wiki 感知的 SQL 生成策略

**工作内容**:
1. 创建 `WikiAwareLLMSqlParser`
2. 实现 `WikiSqlGenStrategy`
3. 实现矛盾检测与处理

**文件变更**:
- 新增: `headless/chat/src/main/java/.../parser/llm/WikiAwareLLMSqlParser.java`

### Phase 5: 服务化与配置 (P3)

**目标**: 提供可配置开关和运维支持

**工作内容**:
1. 添加 Wiki 集成的配置开关
2. 添加监控指标
3. 完善异常处理

---

## 七、配置设计

### 7.1 开关配置

```yaml
wiki:
  enabled: true
  integration:
    preprocessor: true
    semantic-fusion: true
    context-builder: true
  retrieval:
    top-k-entities: 5
    top-k-cards: 10
  prompt:
    include-semantic-mappings: true
    include-business-rules: true
    include-usage-patterns: true
    include-metric-definitions: true
```

### 7.2 优先级配置

```yaml
wiki:
  card-type-priority:
    - SEMANTIC_MAPPING      # 最高优先级 - 术语映射
    - BUSINESS_RULE         # 业务规则
    - USAGE_PATTERN         # 使用模式
    - METRIC_DEFINITION     # 指标定义
    - RELATIONSHIP          # 关系
    - DATA_PATTERN           # 数据模式
```

---

## 八、风险与缓解

| 风险 | 影响 | 缓解措施 |
|------|------|----------|
| Wiki 知识质量参差 | 生成错误 SQL | 设置置信度阈值，低置信度不注入 |
| Wiki 知识与语义层冲突 | 解析结果不一致 | 实现矛盾检测，标记冲突 |
| 性能下降 | 检索延迟增加 | Wiki 检索异步化，结果缓存 |
| Prompt 过长 | LLM 上下文溢出 | 限制注入知识数量，按优先级截断 |

---

## 九、测试策略

### 9.1 单元测试

- `WikiSemanticFusionServiceTest`: 测试融合逻辑
- `WikiAwareMapperTest`: 测试增强 Mapping
- `WikiContextBuilderTest`: 测试上下文构建

### 9.2 集成测试

- Wiki 知识正确检索并注入
- 最终 SQL 包含 Wiki 业务规则
- 术语正确映射到字段

### 9.3 回归测试

- 现有 NL2SQL 功能不受影响
- 开关关闭时行为一致

---

## 十、后续扩展

### 10.1 潜在增强

1. **动态示例注入**: 根据 Wiki 知识自动生成 Few-shot 示例
2. **矛盾可视化**: 在前端展示 Wiki 知识冲突
3. **增量学习**: 根据 SQL 执行结果自动更新 Wiki 知识置信度

### 10.2 长期规划

1. **Wiki 知识自动抽取**：从 SQL 日志中学习常用模式（基于执行反馈自动补充 WikiKnowledgeCard）
2. **多语言支持**：Wiki 知识跨语言映射（中文术语 ↔ 英文字段名）
3. **主动建议**：基于对话上下文主动推荐相关 Wiki 知识（提高知识库覆盖率）
