# LLM-SQL-Wiki 技术方案

## 一、概述

### 1.1 背景

现有的 Text-to-SQL RAG 系统存在以下问题：

| 问题 | 说明 |
|------|------|
| 每次查询从头推导 | 相同问题的检索和 SQL 生成每次都重新执行 |
| 知识碎片化 | 表结构以碎片化条目存储，缺乏整体视图 |
| 无增量更新机制 | 新增表需要手动重建整个知识库 |
| 无知识沉淀 | 每次回答都需要 LLM 重新理解表结构 |
| 无法检测矛盾 | 新表与旧结论冲突时无法自动发现 |

### 1.2 目标

构建 **LLM-SQL-Wiki** 系统，实现：

- **结构化知识库**：表结构以实体（Entity）为单位组织，形成 Wiki 式的知识网络
- **增量更新**：新增表结构时自动阅读、提取、整合，无需全量重建
- **知识沉淀**：编译一次的知识片段持续沉淀，查询时直接复用
- **实体页面**：每个表/字段拥有独立的实体页面，包含摘要、关系、示例
- **矛盾检测**：标注新旧数据之间的矛盾，用新证据强化或推翻旧结论
- **主题摘要**：自动生成业务域的主题摘要，整合相关实体

### 1.3 核心概念

```
┌─────────────────────────────────────────────────────────────────┐
│                        LLM-SQL-Wiki                              │
├─────────────────────────────────────────────────────────────────┤
│  Entity (实体)      │ 表结构实体：customer, sf_js_t, pay_order │
│  Page (页面)        │ 实体的Wiki页面：包含摘要、关系、示例       │
│  Link (链接)        │ 实体间的双向链接：customer → sf_js_t       │
│  Summary (摘要)     │ 自动生成的主题摘要：收费主题摘要          │
│  Knowledge (知识)   │ 沉淀的知识片段：字段业务含义、数据规则     │
│  Evidence (证据)    │ 支持/反驳结论的证据                        │
│  Contradiction (矛盾)│ 新旧知识冲突的标注                       │
└─────────────────────────────────────────────────────────────────┘
```

### 1.4 与现有 Text-to-SQL RAG 的对比

| 维度 | Text-to-SQL RAG | LLM-SQL-Wiki |
|------|-----------------|--------------|
| 知识组织 | 碎片化条目 | 结构化实体+页面 |
| 检索方式 | 每次向量检索 | 实体导航+向量检索 |
| 知识更新 | 全量重建 | 增量更新 |
| 知识沉淀 | 无 | 有（Knowledge Card） |
| 矛盾检测 | 无 | 有 |
| 主题视图 | 无 | 有（Summary） |

---

## 二、架构设计

### 2.1 整体架构

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              用户层                                       │
│         自然语言查询 / 实体导航 / 主题浏览                               │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                            Wiki 服务层                                   │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │  EntityPage  │  │  TopicSummary │  │  SearchService│  │ GraphService│ │
│  │  Service     │  │  Service      │  │              │  │            │ │
│  └──────────────┘  └──────────────┘  └──────────────┘  └────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                          知识编译层                                       │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │ Knowledge    │  │ Contradiction │  │ Evidence     │  │ Link       │ │
│  │ Compiler     │  │ Detector      │  │ Analyzer     │  │ Resolver   │ │
│  └──────────────┘  └──────────────┘  └──────────────┘  └────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                          知识存储层                                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │
│  │ Entity Store │  │ Link Store   │  │ Summary Store│  │ Embedding  │ │
│  │ (PostgreSQL) │  │ (PostgreSQL) │  │ (PostgreSQL) │  │ (PostgreSQL)│ │
│  └──────────────┘  └──────────────┘  └──────────────┘  └────────────┘ │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                          数据源层                                        │
│       SQL 文件 / 新表 DDL / 业务数据库 Schema                            │
└─────────────────────────────────────────────────────────────────────────┘
```

### 2.2 数据流

```
                          离线构建流程（增量）
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ 新增表结构   │ -> │ Schema解析   │ -> │ 知识提取    │ -> │ 实体创建    │
│ (SQL/DDL)   │    │             │    │             │    │ & 链接建立   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
                          │                              │
                          ▼                              ▼
                   ┌─────────────┐              ┌─────────────┐
                   │ 矛盾检测    │              │ 摘要更新    │
                   │             │              │             │
                   └─────────────┘              └─────────────┘
                          │                              │
                          ▼                              ▼
                   ┌─────────────┐              ┌─────────────┐
                   │ 证据分析    │              │ 知识沉淀    │
                   │ (强化/推翻) │              │ (Knowledge) │
                   └─────────────┘              └─────────────┘

                          在线查询流程
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ 用户查询    │ -> │ 实体导航    │ -> │ 知识检索    │ -> │ LLM生成     │
│             │    │ 或向量检索   │    │ (复用沉淀)  │    │ SQL         │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

---

## 三、核心实体设计

### 3.1 实体类型

| 实体类型 | 说明 | 示例 |
|----------|------|------|
| TableEntity | 表实体 | customer, sf_js_t, pay_order |
| ColumnEntity | 字段实体 | customer.name, sf_js_t.qfje |
| TopicEntity | 主题实体 | 收费主题、用户主题、采暖期主题 |
| RelationshipEntity | 关系实体 | customer → sf_js_t (1:N) |

### 3.2 TableEntity 表实体

```json
{
  "entityId": "table:customer",
  "entityType": "TABLE",
  "name": "customer",
  "displayName": "用户信息表",
  "description": "存储供热收费系统中的用户基本信息",
  "properties": {
    "database": "charge_zbhx_20260303",
    "recordCount": 100000,
    "columns": ["id", "code", "name", "mob_no", "yhlx", ...],
    "primaryKey": "id",
    "indexes": ["code"],
    "businessDomain": "用户管理"
  },
  "summary": "用户信息表是供热收费系统的核心表之一，存储约10万用户的基本信息...",
  "tags": ["用户", "基本信息", "P0核心表"],
  "version": "1.2.0",
  "createdAt": "2026-04-01T10:00:00Z",
  "updatedAt": "2026-04-17T15:30:00Z"
}
```

### 3.3 ColumnEntity 字段实体

```json
{
  "entityId": "column:sf_js_t.qfje",
  "entityType": "COLUMN",
  "parentEntity": "table:sf_js_t",
  "name": "qfje",
  "displayName": "欠费金额",
  "description": "用户当前采暖期的欠费金额，正数表示欠费",
  "properties": {
    "dataType": "decimal(10,2)",
    "nullable": false,
    "defaultValue": null,
    "minValue": null,
    "maxValue": null,
    "businessMeaning": "反映用户欠费状态，大于0表示存在欠费",
    "usageExamples": ["查询欠费用户: WHERE qfje > 0", "欠费统计: SUM(qfje)"]
  },
  "relatedEntities": [
    "table:customer",
    "column:sf_js_t.ysje",
    "column:sf_js_t.sfje"
  ],
  "knowledgeCards": [
    {
      "cardId": "kc:sf_js_t.qfje:001",
      "content": "qfje > 0 表示用户存在欠费",
      "evidence": "基于业务规则分析",
      "confidence": 0.95,
      "type": "RULE"
    }
  ],
  "version": "1.0.0"
}
```

### 3.4 TopicEntity 主题实体

```json
{
  "entityId": "topic:charging",
  "entityType": "TOPIC",
  "name": "charging",
  "displayName": "收费管理主题",
  "description": "涵盖供热收费全流程的业务主题",
  "summary": "收费管理主题是供热系统的核心业务域，主要包含...",
  "memberEntities": [
    "table:customer",
    "table:sf_js_t",
    "table:pay_order",
    "column:sf_js_t.sfje",
    "column:pay_order.sfzt"
  ],
  "metrics": [
    {"name": "本采暖期收费总额", "sql": "SELECT SUM(sfje) FROM sf_js_t WHERE cnq = ?"},
    {"name": "本采暖期欠费用户数", "sql": "SELECT COUNT(DISTINCT customer_id) FROM sf_js_t WHERE qfje > 0 AND cnq = ?"}
  ],
  "links": [
    {"targetTopic": "topic:heating_period", "relation": "关联", "description": "每个采暖期对应多个收费记录"},
    {"targetTopic": "topic:user", "relation": "包含", "description": "用户是收费的主体"}
  ],
  "summaryVersion": 3,
  "lastUpdatedAt": "2026-04-17T14:00:00Z"
}
```

---

## 四、知识沉淀设计

### 4.1 KnowledgeCard 知识卡片

知识卡片是知识沉淀的基本单元，每个卡片包含：

```json
{
  "cardId": "kc:sf_js_t:relationship:001",
  "entityId": "table:sf_js_t",
  "cardType": "RELATIONSHIP",
  "title": "与用户表的关联关系",
  "content": "sf_js_t 通过 customer_id 字段关联 customer 表，形成 1:N 关系",
  "extractedFrom": ["sf_js_t 建表语句", "业务需求文档"],
  "confidence": 0.98,
  "status": "CONFIRMED",
  "tags": ["外键关联", "1:N关系", "核心关系"],
  "createdAt": "2026-04-01T10:00:00Z",
  "updatedAt": "2026-04-01T10:00:00Z"
}
```

### 4.2 卡片类型

| 类型 | 说明 | 示例 |
|------|------|------|
| RELATIONSHIP | 表/字段间关系 | "sf_js_t 通过 customer_id 关联 customer" |
| BUSINESS_RULE | 业务规则 | "qfje > 0 表示欠费状态" |
| DATA_PATTERN | 数据模式 | "yhlx 取值为居民/单位" |
| USAGE_PATTERN | 使用模式 | "查询欠费用户: WHERE qfje > 0" |
| SEMANTIC_MAPPING | 语义映射 | "用户类型 = yhlx 字段" |
| METRIC_DEFINITION | 指标定义 | "收费率 = SUM(sfje) / SUM(ysje)" |

### 4.3 知识编译流程

```
┌─────────────────────────────────────────────────────────────────┐
│                     知识编译流程                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. Schema 解析                                                  │
│     ├── 提取表名、字段名、类型、注释                              │
│     ├── 识别主键、外键、索引                                      │
│     └── 解析表关系                                                │
│                         │                                        │
│                         ▼                                        │
│  2. 知识抽取 (LLM)                                               │
│     ├── 业务含义推断                                              │
│     ├── 数据规则提取                                              │
│     ├── 使用模式识别                                              │
│     └── 语义映射生成                                              │
│                         │                                        │
│                         ▼                                        │
│  3. 矛盾检测                                                     │
│     ├── 与现有知识对比                                            │
│     ├── 冲突标注                                                  │
│     └── 证据分析                                                  │
│                         │                                        │
│                         ▼                                        │
│  4. 知识沉淀                                                     │
│     ├── 新卡片写入                                                │
│     ├── 旧卡片更新                                                │
│     └── 矛盾卡片标注                                              │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 五、矛盾检测与证据分析

### 5.1 矛盾类型

| 类型 | 说明 | 示例 |
|------|------|------|
| SCHEMA_CONFLICT | Schema 定义冲突 | 新表字段类型与旧理解不一致 |
| SEMANTIC_CONFLICT | 语义理解冲突 | 旧理解 "qfje 是已收金额"，新发现 "qfje > 0 表示欠费" |
| RELATIONSHIP_CONFLICT | 关系理解冲突 | 旧理解 1:1，新发现实际是 1:N |
| RULE_CONFLICT | 业务规则冲突 | 旧规则 "居民按面积收费"，新发现存在按热计收费 |

### 5.2 矛盾检测流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    矛盾检测流程                                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  新知识进入 ──┬──> 与同类知识比对 ──> 相似度计算                   │
│              │                                                      │
│              │         ┌─────────────────┐                        │
│              │         │  相似度 > 阈值   │                        │
│              │         └────────┬────────┘                        │
│              │                  │                                  │
│              │         ┌────────▼────────┐                        │
│              │         │  含义一致？      │                        │
│              │         └────────┬────────┘                        │
│              │                  │                                  │
│              │         ┌───────┴───────┐                          │
│              │         │YES            │NO                        │
│              │         ▼               ▼                          │
│              │   [强化现有知识]  [检测到矛盾]                       │
│              │                              │                     │
│              └──> 无相似知识 ──> [新增知识卡片]                    │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 5.3 证据分析

```json
{
  "evidenceId": "ev:sf_js_t.qfje:001",
  "contradictionId": "ct:sf_js_t.qfje:001",
  "evidenceType": "SUPPORTS | REFUTES | NEUTRAL",
  "source": "新表结构分析",
  "content": "qfje 字段注释为 '欠费金额'，默认值无约束",
  "confidence": 0.90,
  "impact": "推翻旧结论：旧理解 qfje 为 '实收金额'",
  "resolution": "PENDING | ACCEPT_NEW | KEEP_OLD | MERGE"
}
```

### 5.4 矛盾标注示例

当添加新表 `sf_js_t` 并发现 `qfje` 字段含义与旧知识冲突时：

```json
{
  "contradictionId": "ct:customer.balance:001",
  "detectedAt": "2026-04-17T15:00:00Z",
  "oldKnowledge": {
    "cardId": "kc:customer.balance:old:001",
    "content": "balance 字段表示用户账户余额",
    "confidence": 0.85,
    "status": "CONFLICTED"
  },
  "newEvidence": {
    "source": "sf_js_t 表结构",
    "content": "sf_js_t.qfje 字段注释为 '欠费金额'，而非 '账户余额'",
    "confidence": 0.95
  },
  "conflictType": "SEMANTIC_CONFLICT",
  "impact": "影响 '查询用户余额' 相关 SQL 生成",
  "resolution": "PENDING",
  "autoResolutionSuggestion": {
    "action": "UPDATE",
    "suggestedContent": "qfje 表示采暖期欠费金额，非账户总余额"
  }
}
```

---

## 六、数据库表结构

### 6.1 实体表 (s2_wiki_entity)

```sql
CREATE TABLE s2_wiki_entity (
    id BIGSERIAL PRIMARY KEY,
    entity_id VARCHAR(128) NOT NULL UNIQUE,
    entity_type VARCHAR(32) NOT NULL,
    name VARCHAR(64) NOT NULL,
    display_name VARCHAR(128),
    description TEXT,
    properties JSONB,
    summary TEXT,
    tags TEXT[],
    version VARCHAR(32),
    parent_entity_id VARCHAR(128),
    topic_id VARCHAR(64),
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_entity_type ON s2_wiki_entity(entity_type);
CREATE INDEX idx_parent ON s2_wiki_entity(parent_entity_id);
CREATE INDEX idx_topic ON s2_wiki_entity(topic_id);
CREATE INDEX idx_entity_name ON s2_wiki_entity(name);
```

### 6.2 实体链接表 (s2_wiki_entity_link)

```sql
CREATE TABLE s2_wiki_entity_link (
    id BIGSERIAL PRIMARY KEY,
    source_entity_id VARCHAR(128) NOT NULL,
    target_entity_id VARCHAR(128) NOT NULL,
    link_type VARCHAR(32) NOT NULL,
    relation VARCHAR(64),
    description TEXT,
    bidirectional BOOLEAN DEFAULT FALSE,
    weight DECIMAL(3,2) DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_source FOREIGN KEY (source_entity_id) REFERENCES s2_wiki_entity(entity_id),
    CONSTRAINT fk_target FOREIGN KEY (target_entity_id) REFERENCES s2_wiki_entity(entity_id)
);

CREATE INDEX idx_link_source ON s2_wiki_entity_link(source_entity_id);
CREATE INDEX idx_link_target ON s2_wiki_entity_link(target_entity_id);
CREATE UNIQUE INDEX idx_link_unique ON s2_wiki_entity_link(source_entity_id, target_entity_id, link_type);
```

### 6.3 知识卡片表 (s2_wiki_knowledge_card)

```sql
CREATE TABLE s2_wiki_knowledge_card (
    id BIGSERIAL PRIMARY KEY,
    card_id VARCHAR(128) NOT NULL UNIQUE,
    entity_id VARCHAR(128) NOT NULL,
    card_type VARCHAR(32) NOT NULL,
    title VARCHAR(256),
    content TEXT NOT NULL,
    extracted_from TEXT[],
    confidence DECIMAL(5,4) DEFAULT 1.0,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    tags TEXT[],
    embedding VECTOR(1024),
    version VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_card_entity FOREIGN KEY (entity_id) REFERENCES s2_wiki_entity(entity_id)
);

CREATE INDEX idx_card_entity ON s2_wiki_knowledge_card(entity_id);
CREATE INDEX idx_card_type ON s2_wiki_knowledge_card(card_type);
CREATE INDEX idx_card_embedding ON s2_wiki_knowledge_card USING ivfflat (embedding vector_cosine_ops);
```

### 6.4 主题摘要表 (s2_wiki_topic_summary)

```sql
CREATE TABLE s2_wiki_topic_summary (
    id BIGSERIAL PRIMARY KEY,
    topic_id VARCHAR(64) NOT NULL UNIQUE,
    topic_name VARCHAR(128) NOT NULL,
    summary TEXT NOT NULL,
    member_entities TEXT[],
    relationships TEXT[],
    metrics JSONB,
    summary_version INT DEFAULT 1,
    llm_model VARCHAR(64),
    generated_at TIMESTAMP,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_topic_name ON s2_wiki_topic_summary(topic_name);
```

### 6.5 矛盾标注表 (s2_wiki_contradiction)

```sql
CREATE TABLE s2_wiki_contradiction (
    id BIGSERIAL PRIMARY KEY,
    contradiction_id VARCHAR(128) NOT NULL UNIQUE,
    entity_id VARCHAR(128) NOT NULL,
    old_knowledge_card_id VARCHAR(128),
    conflict_type VARCHAR(32) NOT NULL,
    old_content TEXT,
    new_evidence TEXT,
    evidence_source VARCHAR(256),
    impact TEXT,
    resolution VARCHAR(16) DEFAULT 'PENDING',
    resolved_at TIMESTAMP,
    resolved_by VARCHAR(64),
    resolution_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_contradiction_entity ON s2_wiki_contradiction(entity_id);
CREATE INDEX idx_contradiction_status ON s2_wiki_contradiction(resolution);
CREATE INDEX idx_contradiction_type ON s2_wiki_contradiction(conflict_type);
```

### 6.6 证据表 (s2_wiki_evidence)

```sql
CREATE TABLE s2_wiki_evidence (
    id BIGSERIAL PRIMARY KEY,
    evidence_id VARCHAR(128) NOT NULL UNIQUE,
    contradiction_id VARCHAR(128),
    source_entity_id VARCHAR(128),
    evidence_type VARCHAR(16) NOT NULL,
    content TEXT NOT NULL,
    source VARCHAR(256),
    confidence DECIMAL(5,4),
    impact VARCHAR(32),
    resolution VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_evidence_contradiction FOREIGN KEY (contradiction_id) REFERENCES s2_wiki_contradiction(contradiction_id),
    CONSTRAINT fk_evidence_entity FOREIGN KEY (source_entity_id) REFERENCES s2_wiki_entity(entity_id)
);

CREATE INDEX idx_evidence_contradiction ON s2_wiki_evidence(contradiction_id);
CREATE INDEX idx_evidence_type ON s2_wiki_evidence(evidence_type);
```

---

## 七、核心服务实现

### 7.1 模块结构

```
headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/
├── WikiInitializer.java                    # 启动初始化器
├── service/
│   ├── WikiEntityService.java               # 实体服务
│   ├── WikiLinkService.java                 # 链接服务
│   ├── WikiKnowledgeService.java            # 知识卡片服务
│   ├── WikiSummaryService.java              # 摘要生成服务
│   ├── WikiSearchService.java               # 检索服务
│   └── WikiGraphService.java                # 图关系服务
├── compiler/
│   ├── SchemaCompiler.java                  # Schema 编译器官核
│   ├── KnowledgeExtractor.java              # 知识抽取 (LLM)
│   ├── KnowledgeCompiler.java              # 知识编译
│   └── SummaryGenerator.java               # 摘要生成
├── detector/
│   ├── ContradictionDetector.java          # 矛盾检测器
│   └── EvidenceAnalyzer.java               # 证据分析器
├── dto/
│   ├── WikiEntity.java                     # 实体 DTO
│   ├── WikiLink.java                       # 链接 DTO
│   ├── KnowledgeCard.java                   # 知识卡片 DTO
│   ├── TopicSummary.java                    # 主题摘要 DTO
│   ├── Contradiction.java                   # 矛盾 DTO
│   └── Evidence.java                        # 证据 DTO
└── repository/
    ├── WikiEntityRepository.java           # 实体仓储
    ├── WikiLinkRepository.java              # 链接仓储
    ├── WikiKnowledgeRepository.java         # 知识仓储
    └── WikiSummaryRepository.java           # 摘要仓储
```

### 7.2 WikiEntityService 实体服务

```java
@Service
@Slf4j
public class WikiEntityService {

    @Autowired
    private WikiEntityRepository entityRepository;

    @Autowired
    private WikiLinkService linkService;

    @Autowired
    private WikiKnowledgeService knowledgeService;

    public WikiEntity createOrUpdateEntity(WikiEntity entity) {
        WikiEntity existing = entityRepository.findByEntityId(entity.getEntityId());

        if (existing == null) {
            return createEntity(entity);
        } else {
            return updateEntity(existing, entity);
        }
    }

    @Transactional
    public WikiEntity createEntity(WikiEntity entity) {
        log.info("Creating new wiki entity: {}", entity.getEntityId());

        WikiEntity saved = entityRepository.save(entity);

        linkService.autoCreateLinks(saved);
        knowledgeService.extractAndSaveCards(saved);

        updateRelatedTopicSummary(saved.getTopicId());

        return saved;
    }

    @Transactional
    public WikiEntity updateEntity(WikiEntity existing, WikiEntity updated) {
        log.info("Updating wiki entity: {}", existing.getEntityId());

        ContradictionDetector.ConflictResult conflict =
            contradictionDetector.detect(existing, updated);

        if (conflict.hasContradiction()) {
            contradictionDetector.record(conflict);
            log.warn("Contradiction detected for entity {}: {}",
                existing.getEntityId(), conflict.getDescription());
        }

        existing.setProperties(updated.getProperties());
        existing.setSummary(updated.getSummary());
        existing.setVersion(incrementVersion(existing.getVersion()));

        return entityRepository.save(existing);
    }

    public List<WikiEntity> getEntitiesByType(String entityType) {
        return entityRepository.findByEntityType(entityType);
    }

    public List<WikiEntity> getEntitiesByTopic(String topicId) {
        return entityRepository.findByTopicId(topicId);
    }

    public WikiEntity getEntityById(String entityId) {
        return entityRepository.findByEntityId(entityId);
    }
}
```

### 7.3 SchemaCompiler Schema 编译器官核

```java
@Service
@Slf4j
public class SchemaCompiler {

    @Autowired
    private WikiEntityService entityService;

    @Autowired
    private SqlFileParser sqlParser;

    @Autowired
    private KnowledgeExtractor knowledgeExtractor;

    @Autowired
    private ContradictionDetector contradictionDetector;

    public CompileResult compile(String sqlFilePath, CompileOptions options) {
        CompileResult result = new CompileResult();

        try {
            List<TableSchema> tables = sqlParser.parse(sqlFilePath);

            List<String> targetTables = options.getTargetTables();
            if (targetTables != null && !targetTables.isEmpty()) {
                tables = tables.stream()
                    .filter(t -> targetTables.contains(t.getTableName()))
                    .collect(Collectors.toList());
            }

            for (TableSchema table : tables) {
                CompileResult.TableResult tableResult = compileTable(table);
                result.addTableResult(tableResult);
            }

            contradictionDetector.processPendingContradictions();

            result.setStatus("SUCCESS");
            log.info("Schema compilation completed: {} tables processed", tables.size());

        } catch (Exception e) {
            log.error("Schema compilation failed", e);
            result.setStatus("FAILED");
            result.setError(e.getMessage());
        }

        return result;
    }

    public CompileResult.TableResult compileTable(TableSchema tableSchema) {
        CompileResult.TableResult result = new CompileResult.TableResult();
        result.setTableName(tableSchema.getTableName());

        WikiEntity tableEntity = buildTableEntity(tableSchema);
        WikiEntity savedEntity = entityService.createOrUpdateEntity(tableEntity);
        result.setEntityId(savedEntity.getEntityId());

        for (ColumnSchema column : tableSchema.getColumns()) {
            WikiEntity columnEntity = buildColumnEntity(column, savedEntity);
            entityService.createOrUpdateEntity(columnEntity);
            result.addColumn(column.getColumnName());
        }

        List<KnowledgeCard> cards = knowledgeExtractor.extract(savedEntity, tableSchema);
        result.setKnowledgeCardCount(cards.size());

        return result;
    }

    private WikiEntity buildTableEntity(TableSchema schema) {
        WikiEntity entity = new WikiEntity();
        entity.setEntityId("table:" + schema.getTableName());
        entity.setEntityType("TABLE");
        entity.setName(schema.getTableName());
        entity.setDisplayName(schema.getTableComment() != null
            ? schema.getTableComment() : schema.getTableName());
        entity.setDescription(generateTableDescription(schema));
        entity.setProperties(buildTableProperties(schema));
        entity.setTags(inferTags(schema));
        entity.setTopicId(inferTopic(schema));
        return entity;
    }

    private WikiEntity buildColumnEntity(ColumnSchema column, WikiEntity parent) {
        WikiEntity entity = new WikiEntity();
        entity.setEntityId("column:" + parent.getName() + "." + column.getColumnName());
        entity.setEntityType("COLUMN");
        entity.setName(column.getColumnName());
        entity.setDisplayName(column.getColumnComment() != null
            ? column.getColumnComment() : column.getColumnName());
        entity.setParentEntityId(parent.getEntityId());
        entity.setProperties(buildColumnProperties(column));
        return entity;
    }

    private Map<String, Object> buildTableProperties(TableSchema schema) {
        Map<String, Object> props = new HashMap<>();
        props.put("columnCount", schema.getColumns().size());
        props.put("primaryKey", schema.getPrimaryKey());
        props.put("indexes", schema.getIndexes());
        props.put("foreignKeys", schema.getForeignKeys());
        props.put("businessDomain", inferBusinessDomain(schema));
        return props;
    }
}
```

### 7.4 KnowledgeExtractor 知识抽取

```java
@Service
@Slf4j
public class KnowledgeExtractor {

    @Value("${llm.api.url:https://api.minimaxi.com/v1}")
    private String llmApiUrl;

    @Value("${llm.model:MiniMax-M2.7}")
    private String llmModel;

    @Autowired
    private EmbeddingService embeddingService;

    @Autowired
    private WikiKnowledgeService knowledgeService;

    private static final String EXTRACTION_PROMPT = """
        你是数据架构分析专家。请分析以下表结构，提取知识卡片。

        ## 表名: %s
        ## 表注释: %s
        ## 字段列表:
        %s

        请提取以下类型的知识：
        1. 业务含义：每个字段的业务含义
        2. 数据规则：字段的取值范围、约束条件
        3. 使用模式：常见的查询方式
        4. 语义映射：业务术语到字段的映射

        输出 JSON 格式的知识卡片列表。
        """;

    public List<KnowledgeCard> extract(WikiEntity entity, TableSchema schema) {
        String prompt = buildExtractionPrompt(entity, schema);

        try {
            String llmResponse = callLlm(prompt);
            List<KnowledgeCard> cards = parseKnowledgeCards(llmResponse, entity);

            for (KnowledgeCard card : cards) {
                card.setEmbedding(embeddingService.embed(card.getContent()));
                knowledgeService.save(card);
            }

            log.info("Extracted {} knowledge cards for entity {}",
                cards.size(), entity.getEntityId());

            return cards;

        } catch (Exception e) {
            log.error("Failed to extract knowledge for entity {}",
                entity.getEntityId(), e);
            return Collections.emptyList();
        }
    }

    private String buildExtractionPrompt(WikiEntity entity, TableSchema schema) {
        StringBuilder columns = new StringBuilder();
        for (ColumnSchema col : schema.getColumns()) {
            columns.append(String.format("- %s (%s): %s\n",
                col.getColumnName(),
                col.getColumnType(),
                col.getColumnComment() != null ? col.getColumnComment() : "无注释"));
        }

        return String.format(EXTRACTION_PROMPT,
            entity.getName(),
            entity.getDisplayName(),
            columns.toString());
    }

    private List<KnowledgeCard> parseKnowledgeCards(String llmResponse, WikiEntity entity) {
        try {
            JSONArray jsonArray = new JSONArray(llmResponse);
            List<KnowledgeCard> cards = new ArrayList<>();

            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject obj = jsonArray.getJSONObject(i);
                KnowledgeCard card = new KnowledgeCard();
                card.setCardId("kc:" + entity.getName() + ":" + obj.getString("type") + ":" + i);
                card.setEntityId(entity.getEntityId());
                card.setCardType(obj.getString("type"));
                card.setTitle(obj.getString("title"));
                card.setContent(obj.getString("content"));
                card.setConfidence(obj.optDouble("confidence", 0.9));
                card.setStatus("ACTIVE");
                cards.add(card);
            }

            return cards;
        } catch (Exception e) {
            log.warn("Failed to parse LLM response as JSON: {}", llmResponse);
            return Collections.emptyList();
        }
    }
}
```

### 7.5 ContradictionDetector 矛盾检测器

```java
@Service
@Slf4j
public class ContradictionDetector {

    @Autowired
    private WikiKnowledgeRepository knowledgeRepository;

    @Autowired
    private WikiContradictionRepository contradictionRepository;

    @Autowired
    private EmbeddingService embeddingService;

    private static final double SIMILARITY_THRESHOLD = 0.85;

    public ContradictionDetector.ConflictResult detect(
            WikiEntity oldEntity, WikiEntity newEntity) {

        List<KnowledgeCard> oldCards = knowledgeRepository.findByEntityId(oldEntity.getEntityId());
        List<KnowledgeCard> newCards = knowledgeRepository.findByEntityId(newEntity.getEntityId());

        ConflictResult result = new ConflictResult();
        result.setEntityId(oldEntity.getEntityId());

        for (KnowledgeCard oldCard : oldCards) {
            for (KnowledgeCard newCard : newCards) {
                if (isSameAspect(oldCard, newCard)) {
                    double similarity = calculateSimilarity(oldCard, newCard);

                    if (similarity < SIMILARITY_THRESHOLD) {
                        if (isContradictory(oldCard, newCard)) {
                            Contradiction contradiction = buildContradiction(
                                oldCard, newCard, ConflictType.SEMANTIC_CONFLICT);
                            contradictionRepository.save(contradiction);

                            result.addContradiction(contradiction);
                            log.warn("Contradiction detected: {} vs {}",
                                oldCard.getContent(), newCard.getContent());
                        } else if (isReinforcing(oldCard, newCard)) {
                            updateConfidence(oldCard, newCard);
                            result.addReinforcement(oldCard.getCardId());
                        }
                    }
                }
            }
        }

        return result;
    }

    private boolean isSameAspect(KnowledgeCard a, KnowledgeCard b) {
        return a.getCardType().equals(b.getCardType())
            && a.getTitle() != null
            && a.getTitle().equals(b.getTitle());
    }

    private double calculateSimilarity(KnowledgeCard a, KnowledgeCard b) {
        if (a.getEmbedding() == null || b.getEmbedding() == null) {
            return textSimilarity(a.getContent(), b.getContent());
        }
        return cosineSimilarity(a.getEmbedding(), b.getEmbedding());
    }

    private boolean isContradictory(KnowledgeCard a, KnowledgeCard b) {
        String contentA = a.getContent().toLowerCase();
        String contentB = b.getContent().toLowerCase();

        return (contentA.contains("是") && contentB.contains("否"))
            || (contentA.contains("有") && contentB.contains("无"))
            || (contentA.contains("正") && contentB.contains("负"))
            || (contentA.contains("大于") && contentB.contains("小于"));
    }

    private boolean isReinforcing(KnowledgeCard a, KnowledgeCard b) {
        double similarity = calculateSimilarity(a, b);
        return similarity >= SIMILARITY_THRESHOLD
            && !isContradictory(a, b)
            && b.getConfidence() > a.getConfidence();
    }

    @Data
    public static class ConflictResult {
        private String entityId;
        private List<Contradiction> contradictions = new ArrayList<>();
        private List<String> reinforcedCards = new ArrayList<>();

        public void addContradiction(Contradiction c) {
            contradictions.add(c);
        }

        public void addReinforcement(String cardId) {
            reinforcedCards.add(cardId);
        }

        public boolean hasContradiction() {
            return !contradictions.isEmpty();
        }
    }
}
```

### 7.6 WikiSearchService 检索服务

```java
@Service
@Slf4j
public class WikiSearchService {

    @Autowired
    private WikiEntityRepository entityRepository;

    @Autowired
    private WikiKnowledgeRepository knowledgeRepository;

    @Autowired
    private EmbeddingService embeddingService;

    @Autowired
    private WikiGraphService graphService;

    public SearchResult search(String query, SearchOptions options) {
        SearchResult result = new SearchResult();

        if (options.isEntityFirst() && isEntityQuery(query)) {
            List<WikiEntity> entities = searchEntities(query);
            result.setEntities(entities);

            if (!entities.isEmpty()) {
                result.setKnowledgeCards(
                    knowledgeRepository.findByEntityIdIn(
                        entities.stream()
                            .map(WikiEntity::getEntityId)
                            .collect(Collectors.toList())
                    )
                );
                result.setRelatedLinks(
                    graphService.getLinksForEntities(
                        entities.stream()
                            .map(WikiEntity::getEntityId)
                            .collect(Collectors.toList())
                    )
                );
            }
        } else {
            List<KnowledgeCard> cards = searchKnowledge(query, options.getTopK());
            result.setKnowledgeCards(cards);

            Set<String> entityIds = cards.stream()
                .map(KnowledgeCard::getEntityId)
                .collect(Collectors.toSet());

            if (!entityIds.isEmpty()) {
                result.setEntities(
                    entityRepository.findByEntityIdIn(entityIds)
                );
            }
        }

        return result;
    }

    private List<WikiEntity> searchEntities(String query) {
        String normalizedQuery = query.toLowerCase().replace("表", "").replace("字段", "");

        List<WikiEntity> byName = entityRepository.findByNameContaining(normalizedQuery);

        List<WikiEntity> byDisplayName = entityRepository.findByDisplayNameContaining(normalizedQuery);

        Set<WikiEntity> merged = new LinkedHashSet<>(byName);
        merged.addAll(byDisplayName);

        return new ArrayList<>(merged);
    }

    private List<KnowledgeCard> searchKnowledge(String query, int topK) {
        float[] queryEmbedding = embeddingService.embed(query);

        return knowledgeRepository.findSimilarByEmbedding(
            queryEmbedding, topK,
            List.of("ACTIVE", "CONFLICTED")
        );
    }

    public TopicSummary getTopicSummary(String topicId) {
        List<WikiEntity> entities = entityRepository.findByTopicId(topicId);
        List<WikiEntity> allEntities = new ArrayList<>(entities);

        for (WikiEntity entity : entities) {
            List<WikiEntity> linked = graphService.getLinkedEntities(entity.getEntityId());
            allEntities.addAll(linked);
        }

        return buildTopicSummary(topicId, allEntities);
    }

    private TopicSummary buildTopicSummary(String topicId, List<WikiEntity> entities) {
        TopicSummary summary = new TopicSummary();
        summary.setTopicId(topicId);
        summary.setMemberEntities(
            entities.stream()
                .map(WikiEntity::getEntityId)
                .collect(Collectors.toList())
        );

        String context = buildSummaryContext(entities);
        String generatedSummary = generateSummary(context);

        summary.setSummary(generatedSummary);
        summary.setSummaryVersion(
            summary.getSummaryVersion() + 1
        );
        summary.setGeneratedAt(LocalDateTime.now());

        return summary;
    }
}
```

---

## 八、API 接口设计

### 8.1 实体管理

```
GET /api/wiki/entities
GET /api/wiki/entities/{entityId}
POST /api/wiki/entities
PUT /api/wiki/entities/{entityId}
DELETE /api/wiki/entities/{entityId}

GET /api/wiki/entities/{entityId}/links
GET /api/wiki/entities/{entityId}/knowledge
GET /api/wiki/entities/{entityId}/summary
```

### 8.2 主题摘要

```
GET /api/wiki/topics
GET /api/wiki/topics/{topicId}
GET /api/wiki/topics/{topicId}/summary
POST /api/wiki/topics/{topicId}/refresh
```

### 8.3 知识卡片

```
GET /api/wiki/knowledge
GET /api/wiki/knowledge/{cardId}
POST /api/wiki/knowledge/search
GET /api/wiki/knowledge/entity/{entityId}
```

### 8.4 矛盾管理

```
GET /api/wiki/contradictions
GET /api/wiki/contradictions/{contradictionId}
POST /api/wiki/contradictions/{contradictionId}/resolve
GET /api/wiki/contradictions/pending
```

### 8.5 编译构建

```
POST /api/wiki/compile
POST /api/wiki/compile/schema
GET /api/wiki/compile/status/{taskId}
```

### 8.6 搜索

```
POST /api/wiki/search
GET /api/wiki/search/entity?q={query}
GET /api/wiki/search/knowledge?q={query}&topK={topK}
```

---

## 九、与 Text-to-SQL 的集成

### 9.1 集成架构

```
┌─────────────────────────────────────────────────────────────────┐
│                    Text-to-SQL 查询流程                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  用户问题 ──> Intent 识别 ──> Wiki 检索                          │
│                              │                                   │
│                              ▼                                   │
│                    ┌─────────────────┐                          │
│                    │   实体导航      │                          │
│                    │   或向量检索    │                          │
│                    └────────┬────────┘                          │
│                             │                                    │
│                             ▼                                    │
│                    ┌─────────────────┐                          │
│                    │ 获取实体上下文  │                          │
│                    │ - 摘要          │                          │
│                    │ - 关系          │                          │
│                    │ - 知识卡片      │                          │
│                    │ - 矛盾标注      │                          │
│                    └────────┬────────┘                          │
│                             │                                    │
│                             ▼                                    │
│                    ┌─────────────────┐                          │
│                    │ 构建增强上下文  │                          │
│                    │ (包含沉淀知识)  │                          │
│                    └────────┬────────┘                          │
│                             │                                    │
│                             ▼                                    │
│                    ┌─────────────────┐                          │
│                    │   LLM 生成 SQL  │                          │
│                    └─────────────────┘                          │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 9.2 增强的 Prompt

```prompt
你是专业的 SQL 生成专家，擅长根据数据库 Schema 知识生成准确的 SQL 查询。

## 知识上下文（来自 LLM-SQL-Wiki）

### 实体信息
{entityInfo}

### 主题摘要
{topicSummary}

### 相关知识卡片
{knowledgeCards}

### 矛盾标注（注意避免冲突）
{contradictions}

### 表结构
{schemaContext}

## 业务规则
1. MySQL 数据库，使用标准 SQL 语法
2. 字段名和表名使用反引号
3. 字符串值使用单引号
4. 注意字段的语义和业务规则

## 用户问题
{userQuestion}

## 生成的 SQL
```

---

## 十、部署与配置

### 10.1 配置项

```yaml
wiki:
  enabled: true
  compile-on-startup: false
  embedding:
    model: bge-m3:latest
    url: http://192.168.1.10:11435
    dimension: 1024
  llm:
    model: MiniMax-M2.7
    api-url: https://api.minimaxi.com/v1
    temperature: 0.3
    timeout: 120
  contradiction:
    similarity-threshold: 0.85
    auto-resolve: false
  summary:
    auto-generate: true
    refresh-interval: 86400
```

### 10.2 初始化 SQL

```sql
-- 创建 wiki 相关表
CREATE TABLE IF NOT EXISTS s2_wiki_entity (
    id BIGSERIAL PRIMARY KEY,
    entity_id VARCHAR(128) NOT NULL UNIQUE,
    entity_type VARCHAR(32) NOT NULL,
    name VARCHAR(64) NOT NULL,
    display_name VARCHAR(128),
    description TEXT,
    properties JSONB,
    summary TEXT,
    tags TEXT[],
    version VARCHAR(32),
    parent_entity_id VARCHAR(128),
    topic_id VARCHAR(64),
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_entity_type ON s2_wiki_entity(entity_type);
CREATE INDEX idx_parent ON s2_wiki_entity(parent_entity_id);
CREATE INDEX idx_topic ON s2_wiki_entity(topic_id);
CREATE INDEX idx_entity_name ON s2_wiki_entity(name);

CREATE TABLE IF NOT EXISTS s2_wiki_entity_link (
    id BIGSERIAL PRIMARY KEY,
    source_entity_id VARCHAR(128) NOT NULL,
    target_entity_id VARCHAR(128) NOT NULL,
    link_type VARCHAR(32) NOT NULL,
    relation VARCHAR(64),
    description TEXT,
    bidirectional BOOLEAN DEFAULT FALSE,
    weight DECIMAL(3,2) DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS s2_wiki_knowledge_card (
    id BIGSERIAL PRIMARY KEY,
    card_id VARCHAR(128) NOT NULL UNIQUE,
    entity_id VARCHAR(128) NOT NULL,
    card_type VARCHAR(32) NOT NULL,
    title VARCHAR(256),
    content TEXT NOT NULL,
    extracted_from TEXT[],
    confidence DECIMAL(5,4) DEFAULT 1.0,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    tags TEXT[],
    embedding VECTOR(1024),
    version VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_card_entity ON s2_wiki_knowledge_card(entity_id);
CREATE INDEX idx_card_type ON s2_wiki_knowledge_card(card_type);
CREATE INDEX idx_card_embedding ON s2_wiki_knowledge_card USING ivfflat (embedding vector_cosine_ops);

CREATE TABLE IF NOT EXISTS s2_wiki_topic_summary (
    id BIGSERIAL PRIMARY KEY,
    topic_id VARCHAR(64) NOT NULL UNIQUE,
    topic_name VARCHAR(128) NOT NULL,
    summary TEXT NOT NULL,
    member_entities TEXT[],
    relationships TEXT[],
    metrics JSONB,
    summary_version INT DEFAULT 1,
    llm_model VARCHAR(64),
    generated_at TIMESTAMP,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS s2_wiki_contradiction (
    id BIGSERIAL PRIMARY KEY,
    contradiction_id VARCHAR(128) NOT NULL UNIQUE,
    entity_id VARCHAR(128) NOT NULL,
    old_knowledge_card_id VARCHAR(128),
    conflict_type VARCHAR(32) NOT NULL,
    old_content TEXT,
    new_evidence TEXT,
    evidence_source VARCHAR(256),
    impact TEXT,
    resolution VARCHAR(16) DEFAULT 'PENDING',
    resolved_at TIMESTAMP,
    resolved_by VARCHAR(64),
    resolution_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_contradiction_entity ON s2_wiki_contradiction(entity_id);
CREATE INDEX idx_contradiction_status ON s2_wiki_contradiction(resolution);

CREATE TABLE IF NOT EXISTS s2_wiki_evidence (
    id BIGSERIAL PRIMARY KEY,
    evidence_id VARCHAR(128) NOT NULL UNIQUE,
    contradiction_id VARCHAR(128),
    source_entity_id VARCHAR(128),
    evidence_type VARCHAR(16) NOT NULL,
    content TEXT NOT NULL,
    source VARCHAR(256),
    confidence DECIMAL(5,4),
    impact VARCHAR(32),
    resolution VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 十一、详细 API 规范

### 11.1 实体管理 API

#### 11.1.1 获取实体列表

```
GET /api/wiki/entities
```

**Query Parameters:**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| type | string | 否 | 实体类型：TABLE, COLUMN, TOPIC |
| topicId | string | 否 | 主题 ID |
| status | string | 否 | 状态：ACTIVE, DELETED, CONFLICTED |
| page | int | 否 | 页码，默认 0 |
| size | int | 否 | 每页大小，默认 20 |

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "content": [
      {
        "entityId": "table:customer",
        "entityType": "TABLE",
        "name": "customer",
        "displayName": "用户信息表",
        "description": "存储供热收费系统中的用户基本信息",
        "properties": {
          "database": "charge_zbhx_20260303",
          "columnCount": 12,
          "primaryKey": "id"
        },
        "tags": ["用户", "核心表"],
        "version": "1.0.0",
        "status": "ACTIVE",
        "createdAt": "2026-04-01T10:00:00Z",
        "updatedAt": "2026-04-17T15:30:00Z"
      }
    ],
    "totalElements": 156,
    "totalPages": 8,
    "page": 0,
    "size": 20
  }
}
```

#### 11.1.2 获取单个实体

```
GET /api/wiki/entities/{entityId}
```

**Path Parameters:**

| 参数 | 说明 |
|------|------|
| entityId | 实体 ID，如 `table:customer` |

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "entityId": "table:customer",
    "entityType": "TABLE",
    "name": "customer",
    "displayName": "用户信息表",
    "description": "存储供热收费系统中的用户基本信息",
    "properties": {
      "database": "charge_zbhx_20260303",
      "recordCount": 100000,
      "columns": ["id", "code", "name", "mob_no", "yhlx", "one", "two", "three", "address", "rwrq", "kf_sf", "kf_hmd"],
      "primaryKey": "id",
      "indexes": ["code"],
      "businessDomain": "用户管理"
    },
    "summary": "用户信息表是供热收费系统的核心表之一，存储约10万用户的基本信息，包括用户编码、名称、联系方式、地址等...",
    "tags": ["用户", "基本信息", "P0核心表"],
    "parentEntityId": null,
    "topicId": "topic:user",
    "version": "1.2.0",
    "status": "ACTIVE",
    "createdAt": "2026-04-01T10:00:00Z",
    "updatedAt": "2026-04-17T15:30:00Z"
  }
}
```

#### 11.1.3 获取实体的关联链接

```
GET /api/wiki/entities/{entityId}/links
```

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "entityId": "table:customer",
    "links": [
      {
        "linkId": 1,
        "sourceEntityId": "table:customer",
        "targetEntityId": "table:sf_js_t",
        "linkType": "FOREIGN_KEY",
        "relation": "1:N",
        "description": "customer 通过 customer_id 字段关联 sf_js_t 表",
        "bidirectional": true,
        "weight": 1.0
      },
      {
        "linkId": 2,
        "sourceEntityId": "table:customer",
        "targetEntityId": "table:pay_order",
        "linkType": "FOREIGN_KEY",
        "relation": "1:N",
        "description": "customer 通过 customer_id 字段关联 pay_order 表",
        "bidirectional": true,
        "weight": 1.0
      }
    ],
    "totalLinks": 2
  }
}
```

#### 11.1.4 获取实体的知识卡片

```
GET /api/wiki/entities/{entityId}/knowledge
```

**Query Parameters:**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| type | string | 否 | 卡片类型 |
| status | string | 否 | 状态 |
| page | int | 否 | 页码 |
| size | int | 否 | 每页大小 |

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "entityId": "table:customer",
    "cards": [
      {
        "cardId": "kc:customer:relationship:001",
        "entityId": "table:customer",
        "cardType": "RELATIONSHIP",
        "title": "与收费表的关联关系",
        "content": "customer 通过 customer_id 字段与 sf_js_t 形成 1:N 关系，每个用户可有多个收费记录",
        "extractedFrom": ["sf_js_t 建表语句"],
        "confidence": 0.98,
        "status": "CONFIRMED",
        "tags": ["外键关联", "1:N关系"],
        "version": "1.0.0",
        "createdAt": "2026-04-01T10:00:00Z"
      },
      {
        "cardId": "kc:customer:yhlx:001",
        "entityId": "table:customer",
        "cardType": "DATA_PATTERN",
        "title": "用户类型取值",
        "content": "yhlx 字段取值为'居民'或'单位'，用于区分用户类型",
        "extractedFrom": ["字段分析", "业务规则"],
        "confidence": 0.95,
        "status": "CONFIRMED",
        "tags": ["枚举值", "业务规则"],
        "version": "1.0.0",
        "createdAt": "2026-04-01T10:00:00Z"
      }
    ],
    "totalCards": 5
  }
}
```

### 11.2 知识卡片 API

#### 11.2.1 搜索知识卡片

```
POST /api/wiki/knowledge/search
```

**Request:**

```json
{
  "query": "欠费金额如何查询",
  "topK": 10,
  "entityTypes": ["TABLE", "COLUMN"],
  "cardTypes": ["BUSINESS_RULE", "USAGE_PATTERN"],
  "status": ["ACTIVE"]
}
```

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "query": "欠费金额如何查询",
    "results": [
      {
        "cardId": "kc:sf_js_t.qfje:rule:001",
        "entityId": "column:sf_js_t.qfje",
        "cardType": "BUSINESS_RULE",
        "title": "欠费金额业务规则",
        "content": "qfje 字段大于 0 表示存在欠费，可用于筛选欠费用户",
        "confidence": 0.95,
        "relevanceScore": 0.92,
        "entity": {
          "entityId": "column:sf_js_t.qfje",
          "name": "qfje",
          "displayName": "欠费金额"
        }
      },
      {
        "cardId": "kc:sf_js_t.qfje:usage:001",
        "entityId": "column:sf_js_t.qfje",
        "cardType": "USAGE_PATTERN",
        "title": "欠费查询示例",
        "content": "查询欠费用户: SELECT * FROM sf_js_t WHERE qfje > 0",
        "confidence": 0.90,
        "relevanceScore": 0.88,
        "entity": {
          "entityId": "column:sf_js_t.qfje",
          "name": "qfje",
          "displayName": "欠费金额"
        }
      }
    ],
    "totalResults": 2,
    "searchTime": 125
  }
}
```

### 11.3 矛盾管理 API

#### 11.3.1 获取矛盾列表

```
GET /api/wiki/contradictions
```

**Query Parameters:**

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| entityId | string | 否 | 实体 ID |
| conflictType | string | 否 | 矛盾类型 |
| resolution | string | 否 | 解决状态：PENDING, ACCEPT_NEW, KEEP_OLD, MERGED |
| page | int | 否 | 页码 |
| size | int | 否 | 每页大小 |

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "content": [
      {
        "contradictionId": "ct:customer.balance:001",
        "entityId": "column:customer.balance",
        "conflictType": "SEMANTIC_CONFLICT",
        "oldKnowledge": {
          "cardId": "kc:customer.balance:old:001",
          "content": "balance 字段表示用户账户余额",
          "confidence": 0.85,
          "status": "CONFLICTED"
        },
        "newEvidence": {
          "source": "sf_js_t 表结构分析",
          "content": "sf_js_t.qfje 才是欠费金额，customer.balance 含义待确认",
          "confidence": 0.90,
          "detectedAt": "2026-04-17T15:00:00Z"
        },
        "impact": "影响'查询用户余额'相关 SQL 生成",
        "resolution": "PENDING",
        "evidenceCount": 2,
        "createdAt": "2026-04-17T15:00:00Z"
      }
    ],
    "totalElements": 5,
    "pendingCount": 3,
    "resolvedCount": 2
  }
}
```

#### 11.3.2 解决矛盾

```
POST /api/wiki/contradictions/{contradictionId}/resolve
```

**Request:**

```json
{
  "resolution": "ACCEPT_NEW",
  "resolvedBy": "admin",
  "resolutionNotes": "确认新理解正确，更新知识卡片"
}
```

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "contradictionId": "ct:customer.balance:001",
    "resolution": "ACCEPT_NEW",
    "resolvedBy": "admin",
    "resolvedAt": "2026-04-17T16:00:00Z",
    "resolutionNotes": "确认新理解正确，更新知识卡片",
    "updatedCards": [
      {
        "cardId": "kc:customer.balance:001",
        "status": "ARCHIVED"
      },
      {
        "cardId": "kc:customer.balance:new:001",
        "status": "ACTIVE",
        "content": "customer.balance 字段含义待进一步确认"
      }
    ]
  }
}
```

### 11.4 编译构建 API

#### 11.4.1 编译 Schema

```
POST /api/wiki/compile/schema
```

**Request:**

```json
{
  "sqlFilePath": "e:\\trae\\supersonic\\sql\\charge_zbhx_20260303.sql",
  "targetTables": ["customer", "sf_js_t", "pay_order"],
  "options": {
    "extractKnowledge": true,
    "detectContradiction": true,
    "updateSummary": true,
    "parallelProcessing": true
  }
}
```

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "taskId": "compile-20260417-001",
    "status": "PROCESSING",
    "progress": 65,
    "startTime": "2026-04-17T16:00:00Z",
    "estimatedCompletion": "2026-04-17T16:05:00Z",
    "result": {
      "totalTables": 3,
      "processedTables": 2,
      "failedTables": 0,
      "newEntities": 45,
      "updatedEntities": 3,
      "newKnowledgeCards": 28,
      "contradictionsDetected": 1,
      "summariesUpdated": 1
    },
    "tableResults": [
      {
        "tableName": "customer",
        "status": "COMPLETED",
        "entityId": "table:customer",
        "columnsProcessed": 12,
        "knowledgeCardsExtracted": 8,
        "linksCreated": 2,
        "contradictions": 0
      },
      {
        "tableName": "sf_js_t",
        "status": "COMPLETED",
        "entityId": "table:sf_js_t",
        "columnsProcessed": 11,
        "knowledgeCardsExtracted": 12,
        "linksCreated": 3,
        "contradictions": 1
      }
    ]
  }
}
```

#### 11.4.2 获取编译状态

```
GET /api/wiki/compile/status/{taskId}
```

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "taskId": "compile-20260417-001",
    "status": "COMPLETED",
    "progress": 100,
    "startTime": "2026-04-17T16:00:00Z",
    "endTime": "2026-04-17T16:03:45Z",
    "duration": 225,
    "result": {
      "totalTables": 3,
      "processedTables": 3,
      "failedTables": 0,
      "newEntities": 45,
      "updatedEntities": 3,
      "newKnowledgeCards": 28,
      "contradictionsDetected": 1,
      "summariesUpdated": 1
    }
  }
}
```

### 11.5 搜索 API

#### 11.5.1 综合搜索

```
POST /api/wiki/search
```

**Request:**

```json
{
  "query": "查询本采暖期欠费用户",
  "searchType": "HYBRID",
  "entityFirst": true,
  "topK": 10,
  "includeTypes": ["TABLE", "COLUMN", "KNOWLEDGE_CARD"],
  "filters": {
    "topicId": "topic:charging",
    "tags": ["收费", "欠费"]
  }
}
```

**Response:**

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "query": "查询本采暖期欠费用户",
    "entities": [
      {
        "entityId": "table:sf_js_t",
        "entityType": "TABLE",
        "name": "sf_js_t",
        "displayName": "收费结算表",
        "relevanceScore": 0.95,
        "matchedFields": ["name", "displayName", "description"]
      }
    ],
    "knowledgeCards": [
      {
        "cardId": "kc:sf_js_t.qfje:rule:001",
        "entityId": "column:sf_js_t.qfje",
        "cardType": "BUSINESS_RULE",
        "title": "欠费金额业务规则",
        "content": "qfje > 0 表示用户存在欠费",
        "relevanceScore": 0.92
      }
    ],
    "topicSummary": {
      "topicId": "topic:charging",
      "summary": "收费管理主题涵盖供热收费全流程...",
      "matchedEntities": 5
    },
    "suggestions": [
      "查询欠费用户: SELECT c.name, c.mob_no FROM customer c JOIN sf_js_t s ON c.id = s.customer_id WHERE s.qfje > 0 AND s.cnq = '2025-2026'"
    ],
    "searchTime": 185
  }
}
```

---

## 十二、DTO 完整设计

### 12.1 WikiEntity DTO

```java
@Data
public class WikiEntity {

    private Long id;

    @NotBlank(message = "entityId 不能为空")
    @Size(max = 128, message = "entityId 长度不能超过 128")
    private String entityId;

    @NotBlank(message = "entityType 不能为空")
    private String entityType;

    @NotBlank(message = "name 不能为空")
    @Size(max = 64, message = "name 长度不能超过 64")
    private String name;

    @Size(max = 128, message = "displayName 长度不能超过 128")
    private String displayName;

    private String description;

    private Map<String, Object> properties;

    private String summary;

    private List<String> tags;

    private String version;

    private String parentEntityId;

    private String topicId;

    private String status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private List<WikiEntity> childEntities;

    private List<WikiLink> outgoingLinks;

    private List<WikiLink> incomingLinks;

    private List<KnowledgeCard> knowledgeCards;
}
```

### 12.2 WikiLink DTO

```java
@Data
public class WikiLink {

    private Long id;

    @NotBlank(message = "sourceEntityId 不能为空")
    private String sourceEntityId;

    @NotBlank(message = "targetEntityId 不能为空")
    private String targetEntityId;

    @NotBlank(message = "linkType 不能为空")
    private String linkType;

    private String relation;

    private String description;

    private Boolean bidirectional;

    private BigDecimal weight;

    private LocalDateTime createdAt;

    private WikiEntity sourceEntity;

    private WikiEntity targetEntity;
}
```

### 12.3 KnowledgeCard DTO

```java
@Data
public class KnowledgeCard {

    private Long id;

    @NotBlank(message = "cardId 不能为空")
    private String cardId;

    @NotBlank(message = "entityId 不能为空")
    private String entityId;

    @NotBlank(message = "cardType 不能为空")
    private String cardType;

    @Size(max = 256, message = "title 长度不能超过 256")
    private String title;

    @NotBlank(message = "content 不能为空")
    private String content;

    private List<String> extractedFrom;

    private BigDecimal confidence;

    private String status;

    private List<String> tags;

    private Float[] embedding;

    private String version;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private WikiEntity entity;
}
```

### 12.4 TopicSummary DTO

```java
@Data
public class TopicSummary {

    private Long id;

    @NotBlank(message = "topicId 不能为空")
    private String topicId;

    @NotBlank(message = "topicName 不能为空")
    private String topicName;

    @NotBlank(message = "summary 不能为空")
    private String summary;

    private List<String> memberEntities;

    private List<String> relationships;

    private List<MetricDefinition> metrics;

    private Integer summaryVersion;

    private String llmModel;

    private LocalDateTime generatedAt;

    private String status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @Data
    public static class MetricDefinition {
        private String name;
        private String description;
        private String sql;
        private String unit;
    }
}
```

### 12.5 Contradiction DTO

```java
@Data
public class Contradiction {

    private Long id;

    @NotBlank(message = "contradictionId 不能为空")
    private String contradictionId;

    @NotBlank(message = "entityId 不能为空")
    private String entityId;

    private String oldKnowledgeCardId;

    @NotBlank(message = "conflictType 不能为空")
    private String conflictType;

    private String oldContent;

    private String newEvidence;

    private String evidenceSource;

    private String impact;

    private String resolution;

    private LocalDateTime resolvedAt;

    private String resolvedBy;

    private String resolutionNotes;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private KnowledgeCard oldKnowledge;

    private List<Evidence> evidences;

    @Data
    public static class ConflictType {
        public static final String SCHEMA_CONFLICT = "SCHEMA_CONFLICT";
        public static final String SEMANTIC_CONFLICT = "SEMANTIC_CONFLICT";
        public static final String RELATIONSHIP_CONFLICT = "RELATIONSHIP_CONFLICT";
        public static final String RULE_CONFLICT = "RULE_CONFLICT";
    }

    @Data
    public static class Resolution {
        public static final String PENDING = "PENDING";
        public static final String ACCEPT_NEW = "ACCEPT_NEW";
        public static final String KEEP_OLD = "KEEP_OLD";
        public static final String MERGED = "MERGED";
    }
}
```

### 12.6 Evidence DTO

```java
@Data
public class Evidence {

    private Long id;

    @NotBlank(message = "evidenceId 不能为空")
    private String evidenceId;

    private String contradictionId;

    private String sourceEntityId;

    @NotBlank(message = "evidenceType 不能为空")
    private String evidenceType;

    @NotBlank(message = "content 不能为空")
    private String content;

    private String source;

    private BigDecimal confidence;

    private String impact;

    private String resolution;

    private LocalDateTime createdAt;

    @Data
    public static class EvidenceType {
        public static final String SUPPORTS = "SUPPORTS";
        public static final String REFUTES = "REFUTES";
        public static final String NEUTRAL = "NEUTRAL";
    }
}
```

### 12.7 Request/Response DTO

```java
@Data
public class WikiSearchRequest {
    private String query;
    private String searchType;
    private Boolean entityFirst;
    private Integer topK;
    private List<String> includeTypes;
    private SearchFilters filters;
}

@Data
public class WikiSearchResponse {
    private String query;
    private List<WikiEntity> entities;
    private List<KnowledgeCard> knowledgeCards;
    private TopicSummary topicSummary;
    private List<String> suggestions;
    private Long searchTime;
}

@Data
public class CompileSchemaRequest {
    private String sqlFilePath;
    private List<String> targetTables;
    private CompileOptions options;
}

@Data
public class CompileOptions {
    private Boolean extractKnowledge = true;
    private Boolean detectContradiction = true;
    private Boolean updateSummary = true;
    private Boolean parallelProcessing = true;
}

@Data
public class CompileResult {
    private String taskId;
    private String status;
    private Integer progress;
    private LocalDateTime startTime;
    private LocalDateTime estimatedCompletion;
    private CompileStatistics result;
    private List<TableResult> tableResults;
    private String error;
}
```

---

## 十三、Repository 接口设计

### 13.1 WikiEntityRepository

```java
@Repository
public interface WikiEntityRepository {

    WikiEntity save(WikiEntity entity);

    WikiEntity findByEntityId(String entityId);

    List<WikiEntity> findByEntityIdIn(List<String> entityIds);

    List<WikiEntity> findByEntityType(String entityType);

    List<WikiEntity> findByEntityTypeAndStatus(String entityType, String status);

    List<WikiEntity> findByTopicId(String topicId);

    List<WikiEntity> findByParentEntityId(String parentEntityId);

    List<WikiEntity> findByNameContaining(String name);

    List<WikiEntity> findByDisplayNameContaining(String displayName);

    Page<WikiEntity> findByEntityType(String entityType, Pageable pageable);

    Page<WikiEntity> findByStatus(String status, Pageable pageable);

    long countByEntityType(String entityType);

    long countByTopicId(String topicId);

    void deleteByEntityId(String entityId);

    boolean existsByEntityId(String entityId);

    List<WikiEntity> findByTagsContaining(String tag);

    List<WikiEntity> findByEntityTypeAndTopicId(String entityType, String topicId);
}
```

### 13.2 WikiLinkRepository

```java
@Repository
public interface WikiLinkRepository {

    WikiLink save(WikiLink link);

    List<WikiLink> saveAll(List<WikiLink> links);

    WikiLink findById(Long id);

    List<WikiLink> findBySourceEntityId(String sourceEntityId);

    List<WikiLink> findByTargetEntityId(String targetEntityId);

    List<WikiLink> findBySourceEntityIdOrTargetEntityId(
            String sourceEntityId, String targetEntityId);

    List<WikiLink> findByLinkType(String linkType);

    List<WikiLink> findBySourceEntityIdAndLinkType(
            String sourceEntityId, String linkType);

    List<WikiEntity> findLinkedEntities(String entityId);

    boolean existsBySourceEntityIdAndTargetEntityIdAndLinkType(
            String sourceEntityId, String targetEntityId, String linkType);

    void deleteById(Long id);

    void deleteBySourceEntityIdOrTargetEntityId(
            String sourceEntityId, String targetEntityId);

    long countBySourceEntityId(String sourceEntityId);

    List<WikiLink> findByWeightGreaterThan(BigDecimal weight);
}
```

### 13.3 WikiKnowledgeRepository

```java
@Repository
public interface WikiKnowledgeRepository {

    KnowledgeCard save(KnowledgeCard card);

    List<KnowledgeCard> saveAll(List<KnowledgeCard> cards);

    KnowledgeCard findByCardId(String cardId);

    List<KnowledgeCard> findByEntityId(String entityId);

    List<KnowledgeCard> findByEntityIdAndCardType(String entityId, String cardType);

    List<KnowledgeCard> findByEntityIdAndStatus(String entityId, String status);

    List<KnowledgeCard> findByCardType(String cardType);

    List<KnowledgeCard> findByStatus(String status);

    List<KnowledgeCard> findByTagsContaining(String tag);

    Page<KnowledgeCard> findByCardType(String cardType, Pageable pageable);

    List<KnowledgeCard> findSimilarByEmbedding(Float[] embedding, int topK, List<String> statuses);

    long countByEntityId(String entityId);

    long countByCardType(String cardType);

    void deleteByCardId(String cardId);

    void deleteByEntityId(String entityId);

    boolean existsByCardId(String cardId);

    List<KnowledgeCard> findByConfidenceGreaterThan(BigDecimal threshold);
}
```

### 13.4 WikiContradictionRepository

```java
@Repository
public interface WikiContradictionRepository {

    Contradiction save(Contradiction contradiction);

    Contradiction findByContradictionId(String contradictionId);

    List<Contradiction> findByEntityId(String entityId);

    List<Contradiction> findByConflictType(String conflictType);

    List<Contradiction> findByResolution(String resolution);

    List<Contradiction> findByResolutionIn(List<String> resolutions);

    Page<Contradiction> findByResolution(String resolution, Pageable pageable);

    Page<Contradiction> findAll(Pageable pageable);

    List<Contradiction> findPending();

    long countByResolution(String resolution);

    long countByConflictType(String conflictType);

    void deleteByContradictionId(String contradictionId);

    boolean existsByEntityIdAndOldKnowledgeCardId(
            String entityId, String oldKnowledgeCardId);
}
```

---

## 十四、错误处理设计

### 14.1 异常类型

```java
public class WikiException extends RuntimeException {

    private String code;
    private Map<String, Object> details;

    public WikiException(String code, String message) {
        super(message);
        this.code = code;
    }

    public WikiException(String code, String message, Throwable cause) {
        super(message, cause);
        this.code = code;
    }

    public WikiException(String code, String message, Map<String, Object> details) {
        super(message);
        this.code = code;
        this.details = details;
    }
}

public class EntityNotFoundException extends WikiException {

    public EntityNotFoundException(String entityId) {
        super("WIKI_001", String.format("实体不存在: %s", entityId));
    }
}

public class DuplicateEntityException extends WikiException {

    public DuplicateEntityException(String entityId) {
        super("WIKI_002", String.format("实体已存在: %s", entityId));
    }
}

public class CompilationException extends WikiException {

    public CompilationException(String message, Throwable cause) {
        super("WIKI_003", message, cause);
    }
}

public class KnowledgeExtractionException extends WikiException {

    public KnowledgeExtractionException(String entityId, Throwable cause) {
        super("WIKI_004", String.format("知识抽取失败: %s", entityId), cause);
    }
}

public class ContradictionResolutionException extends WikiException {

    public ContradictionResolutionException(String contradictionId, String reason) {
        super("WIKI_005", String.format("矛盾解决失败 [%s]: %s", contradictionId, reason));
    }
}
```

### 14.2 异常码定义

| 异常码 | 说明 | HTTP 状态码 |
|--------|------|-------------|
| WIKI_001 | 实体不存在 | 404 |
| WIKI_002 | 实体已存在 | 409 |
| WIKI_003 | 编译失败 | 500 |
| WIKI_004 | 知识抽取失败 | 500 |
| WIKI_005 | 矛盾解决失败 | 400 |
| WIKI_006 | 无效的参数 | 400 |
| WIKI_007 | LLM 服务不可用 | 503 |
| WIKI_008 | 嵌入服务不可用 | 503 |
| WIKI_009 | 数据库操作失败 | 500 |
| WIKI_010 | 权限不足 | 403 |

### 14.3 全局异常处理

```java
@RestControllerAdvice
public class WikiExceptionHandler {

    @ExceptionHandler(EntityNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleEntityNotFound(EntityNotFoundException ex) {
        ErrorResponse error = ErrorResponse.builder()
                .code(ex.getCode())
                .message(ex.getMessage())
                .timestamp(LocalDateTime.now())
                .build();
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
    }

    @ExceptionHandler(DuplicateEntityException.class)
    public ResponseEntity<ErrorResponse> handleDuplicateEntity(DuplicateEntityException ex) {
        ErrorResponse error = ErrorResponse.builder()
                .code(ex.getCode())
                .message(ex.getMessage())
                .timestamp(LocalDateTime.now())
                .build();
        return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
    }

    @ExceptionHandler(WikiException.class)
    public ResponseEntity<ErrorResponse> handleWikiException(WikiException ex) {
        ErrorResponse error = ErrorResponse.builder()
                .code(ex.getCode())
                .message(ex.getMessage())
                .details(ex.getDetails())
                .timestamp(LocalDateTime.now())
                .build();
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidation(MethodArgumentNotValidException ex) {
        Map<String, Object> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage()));

        ErrorResponse error = ErrorResponse.builder()
                .code("WIKI_006")
                .message("参数验证失败")
                .details(errors)
                .timestamp(LocalDateTime.now())
                .build();
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
    }

    @Data
    @Builder
    public static class ErrorResponse {
        private String code;
        private String message;
        private Map<String, Object> details;
        private LocalDateTime timestamp;
    }
}
```

---

## 十五、性能优化设计

### 15.1 缓存策略

| 缓存层级 | 内容 | TTL | 更新策略 |
|----------|------|-----|----------|
| L1 (进程内) | 热点实体 | 5分钟 | LRU 淘汰 |
| L2 (Redis) | 实体列表 | 30分钟 | 主动失效 |
| L3 (数据库) | 全量数据 | 永久 | 实时更新 |

```java
@Service
@Slf4j
public class WikiCacheService {

    private static final String ENTITY_CACHE_PREFIX = "wiki:entity:";
    private static final String LINK_CACHE_PREFIX = "wiki:link:";
    private static final String SUMMARY_CACHE_PREFIX = "wiki:summary:";

    private static final long ENTITY_CACHE_TTL = 300;
    private static final long LIST_CACHE_TTL = 1800;

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    @Cacheable(value = "wikiEntity", key = "#entityId")
    public WikiEntity getEntity(String entityId) {
        log.debug("Cache miss for entity: {}", entityId);
        return entityRepository.findByEntityId(entityId);
    }

    @CacheEvict(value = "wikiEntity", key = "#entityId")
    public void evictEntity(String entityId) {
        log.debug("Evict entity cache: {}", entityId);
    }

    @CachePut(value = "wikiEntity", key = "#entity.entityId")
    public WikiEntity updateEntity(WikiEntity entity) {
        return entityRepository.save(entity);
    }

    public void evictEntityPattern(String pattern) {
        Set<String> keys = redisTemplate.keys(ENTITY_CACHE_PREFIX + pattern);
        if (keys != null && !keys.isEmpty()) {
            redisTemplate.delete(keys);
        }
    }
}
```

### 15.2 向量检索优化

```java
@Service
public class VectorSearchOptimizer {

    @Value("${wiki.embedding.dimension:1024}")
    private int embeddingDimension;

    public List<KnowledgeCard> optimizedSearch(
            Float[] queryEmbedding, int topK, List<String> statuses) {

        long startTime = System.currentTimeMillis();

        List<KnowledgeCard> candidates = knowledgeRepository
                .findByStatusIn(statuses);

        List<ScoredCard> scored = candidates.parallelStream()
                .filter(card -> card.getEmbedding() != null)
                .map(card -> new ScoredCard(
                        card,
                        cosineSimilarity(queryEmbedding, card.getEmbedding())
                ))
                .sorted(Comparator.comparingDouble(ScoredCard::getScore).reversed())
                .limit(topK)
                .collect(Collectors.toList());

        long duration = System.currentTimeMillis() - startTime;
        log.debug("Vector search completed in {}ms, candidates: {}, results: {}",
                duration, candidates.size(), scored.size());

        return scored.stream()
                .map(ScoredCard::getCard)
                .collect(Collectors.toList());
    }

    private float cosineSimilarity(Float[] a, Float[] b) {
        float dotProduct = 0.0f;
        float normA = 0.0f;
        float normB = 0.0f;

        for (int i = 0; i < a.length; i++) {
            dotProduct += a[i] * b[i];
            normA += a[i] * a[i];
            normB += b[i] * b[i];
        }

        return (float) (dotProduct / (Math.sqrt(normA) * Math.sqrt(normB)));
    }

    @Data
    private static class ScoredCard {
        private KnowledgeCard card;
        private double score;

        public ScoredCard(KnowledgeCard card, double score) {
            this.card = card;
            this.score = score;
        }
    }
}
```

### 15.3 并行处理

```java
@Service
@Slf4j
public class ParallelSchemaCompiler {

    @Value("${wiki.compile.parallel.threadPoolSize:4}")
    private int threadPoolSize;

    private ExecutorService executor;

    @PostConstruct
    public void init() {
        executor = Executors.newFixedThreadPool(threadPoolSize);
    }

    public CompileResult compileParallel(List<TableSchema> tables, CompileOptions options) {
        List<CompletableFuture<CompileResult.TableResult>> futures = tables.stream()
                .map(table -> CompletableFuture.supplyAsync(
                        () -> compileTable(table), executor))
                .collect(Collectors.toList());

        CompileResult result = new CompileResult();
        result.setStartTime(LocalDateTime.now());

        List<CompileResult.TableResult> tableResults = futures.stream()
                .map(CompletableFuture::join)
                .collect(Collectors.toList());

        result.setTableResults(tableResults);
        result.setEndTime(LocalDateTime.now());

        return result;
    }

    @PreDestroy
    public void shutdown() {
        executor.shutdown();
        try {
            if (!executor.awaitTermination(60, TimeUnit.SECONDS)) {
                executor.shutdownNow();
            }
        } catch (InterruptedException e) {
            executor.shutdownNow();
            Thread.currentThread().interrupt();
        }
    }
}
```

### 15.4 批量操作优化

```java
@Service
@Slf4j
public class BatchOperationService {

    @Value("${wiki.batch.size:100}")
    private int batchSize;

    @Transactional
    public void batchSaveEntities(List<WikiEntity> entities) {
        for (int i = 0; i < entities.size(); i += batchSize) {
            List<WikiEntity> batch = entities.subList(
                    i, Math.min(i + batchSize, entities.size()));
            entityRepository.saveAll(batch);
            log.debug("Saved batch {}/{}", (i / batchSize) + 1,
                    (entities.size() + batchSize - 1) / batchSize);
        }
    }

    @Transactional
    public void batchSaveKnowledgeCards(List<KnowledgeCard> cards) {
        List<Float[]> embeddings = cards.stream()
                .map(card -> embeddingService.embed(card.getContent()))
                .collect(Collectors.toList());

        for (int i = 0; i < cards.size(); i++) {
            cards.get(i).setEmbedding(embeddings.get(i));
        }

        for (int i = 0; i < cards.size(); i += batchSize) {
            List<KnowledgeCard> batch = cards.subList(
                    i, Math.min(i + batchSize, cards.size()));
            knowledgeRepository.saveAll(batch);
        }
    }
}
```

---

## 十六、测试用例设计

### 16.1 单元测试

#### 16.1.1 WikiEntityService 测试

```java
@SpringBootTest
class WikiEntityServiceTest {

    @Autowired
    private WikiEntityService entityService;

    @Autowired
    private WikiEntityRepository entityRepository;

    @Test
    void testCreateEntity() {
        WikiEntity entity = new WikiEntity();
        entity.setEntityId("table:test_" + System.currentTimeMillis());
        entity.setEntityType("TABLE");
        entity.setName("test_table");
        entity.setDisplayName("测试表");
        entity.setDescription("用于测试的表");

        WikiEntity saved = entityService.createEntity(entity);

        assertNotNull(saved.getId());
        assertEquals("TABLE", saved.getEntityType());
        assertEquals("test_table", saved.getName());
        assertNotNull(saved.getCreatedAt());
    }

    @Test
    void testGetEntityById() {
        WikiEntity entity = entityService.getEntityById("table:customer");
        assertNotNull(entity);
        assertEquals("customer", entity.getName());
    }

    @Test
    void testGetEntitiesByType() {
        List<WikiEntity> tables = entityService.getEntitiesByType("TABLE");
        assertTrue(tables.size() > 0);
        tables.forEach(e -> assertEquals("TABLE", e.getEntityType()));
    }

    @Test
    void testGetEntitiesByTopic() {
        List<WikiEntity> entities =
                entityService.getEntitiesByTopic("topic:charging");
        assertNotNull(entities);
    }
}
```

#### 16.1.2 ContradictionDetector 测试

```java
@SpringBootTest
class ContradictionDetectorTest {

    @Autowired
    private ContradictionDetector detector;

    @Test
    void testDetectContradiction() {
        WikiEntity oldEntity = createTestEntity("qfje 含义为实收金额");
        WikiEntity newEntity = createTestEntity("qfje 含义为欠费金额");

        ContradictionDetector.ConflictResult result =
                detector.detect(oldEntity, newEntity);

        assertTrue(result.hasContradiction());
        assertEquals(1, result.getContradictions().size());
    }

    @Test
    void testDetectReinforcement() {
        WikiEntity oldEntity = createTestEntity("qfje 大于0表示欠费");
        WikiEntity newEntity = createTestEntity("qfje 大于0表示欠费");

        ContradictionDetector.ConflictResult result =
                detector.detect(oldEntity, newEntity);

        assertFalse(result.hasContradiction());
        assertEquals(1, result.getReinforcedCards().size());
    }

    @Test
    void testNoConflictForDifferentAspects() {
        WikiEntity oldEntity = createTestEntity("qfje 用于计费");
        WikiEntity newEntity = createTestEntity("sfje 用于统计");

        ContradictionDetector.ConflictResult result =
                detector.detect(oldEntity, newEntity);

        assertFalse(result.hasContradiction());
    }

    private WikiEntity createTestEntity(String content) {
        WikiEntity entity = new WikiEntity();
        entity.setEntityId("test:" + System.currentTimeMillis());
        entity.setName("test");
        return entity;
    }
}
```

#### 16.1.3 KnowledgeExtractor 测试

```java
@SpringBootTest
class KnowledgeExtractorTest {

    @Autowired
    private KnowledgeExtractor extractor;

    @MockBean
    private EmbeddingService embeddingService;

    @Test
    void testExtractKnowledgeCards() {
        when(embeddingService.embed(anyString()))
                .thenReturn(new Float[1024]);

        WikiEntity entity = new WikiEntity();
        entity.setEntityId("table:customer");
        entity.setName("customer");
        entity.setDisplayName("用户信息表");

        TableSchema schema = new TableSchema();
        schema.setTableName("customer");
        schema.setColumns(List.of(
                createColumn("id", "bigint", "用户ID"),
                createColumn("name", "varchar", "用户名称"),
                createColumn("yhlx", "varchar", "用户类型")
        ));

        List<KnowledgeCard> cards = extractor.extract(entity, schema);

        assertNotNull(cards);
        assertTrue(cards.size() > 0);

        cards.forEach(card -> {
            assertNotNull(card.getCardId());
            assertNotNull(card.getCardType());
            assertNotNull(card.getContent());
            assertNotNull(card.getEmbedding());
        });
    }

    private ColumnSchema createColumn(String name, String type, String comment) {
        ColumnSchema column = new ColumnSchema();
        column.setColumnName(name);
        column.setColumnType(type);
        column.setColumnComment(comment);
        return column;
    }
}
```

### 16.2 集成测试

#### 16.2.1 Schema 编译流程测试

```java
@SpringBootTest
@DirtiesContext(classMode = ClassMode.AFTER_EACH_TEST_METHOD)
class SchemaCompilerIntegrationTest {

    @Autowired
    private SchemaCompiler compiler;

    @Test
    void testFullCompilation() {
        String sqlFilePath = "test-sql/customer.sql";

        CompileOptions options = new CompileOptions();
        options.setExtractKnowledge(true);
        options.setDetectContradiction(true);
        options.setUpdateSummary(true);

        CompileResult result = compiler.compile(sqlFilePath, options);

        assertEquals("SUCCESS", result.getStatus());
        assertTrue(result.getTotalTables() > 0);
        assertTrue(result.getNewEntities() > 0);
        assertTrue(result.getNewKnowledgeCards() > 0);
    }

    @Test
    void testIncrementalUpdate() {
        String sqlFilePath = "test-sql/partial.sql";

        CompileOptions options = new CompileOptions();
        options.setTargetTables(List.of("sf_js_t"));

        CompileResult result = compiler.compile(sqlFilePath, options);

        assertEquals("SUCCESS", result.getStatus());
        assertEquals(1, result.getTotalTables());
        assertTrue(result.getNewEntities() > 0);
    }
}
```

#### 16.2.2 搜索集成测试

```java
@SpringBootTest
class WikiSearchIntegrationTest {

    @Autowired
    private WikiSearchService searchService;

    @Test
    void testEntitySearch() {
        WikiSearchRequest request = new WikiSearchRequest();
        request.setQuery("用户信息表");
        request.setSearchType("ENTITY");
        request.setTopK(10);

        WikiSearchResponse response = searchService.search(request);

        assertNotNull(response.getEntities());
        assertTrue(response.getEntities().size() > 0);
        assertTrue(response.getSearchTime() > 0);
    }

    @Test
    void testKnowledgeSearch() {
        WikiSearchRequest request = new WikiSearchRequest();
        request.setQuery("欠费金额");
        request.setSearchType("KNOWLEDGE");
        request.setTopK(5);

        WikiSearchResponse response = searchService.search(request);

        assertNotNull(response.getKnowledgeCards());
        assertTrue(response.getKnowledgeCards().size() > 0);
    }

    @Test
    void testHybridSearch() {
        WikiSearchRequest request = new WikiSearchRequest();
        request.setQuery("查询欠费用户");
        request.setSearchType("HYBRID");
        request.setEntityFirst(true);
        request.setTopK(10);

        WikiSearchResponse response = searchService.search(request);

        assertNotNull(response.getEntities());
        assertNotNull(response.getKnowledgeCards());
        assertNotNull(response.getSuggestions());
    }
}
```

### 16.3 性能测试

```java
@SpringBootTest
class WikiPerformanceTest {

    @Autowired
    private WikiEntityService entityService;

    @Autowired
    private WikiSearchService searchService;

    @Test
    @PerformanceTest(expectedTime = 100)
    void testEntityRetrievalPerformance() {
        for (int i = 0; i < 100; i++) {
            entityService.getEntityById("table:customer");
        }
    }

    @Test
    @PerformanceTest(expectedTime = 500)
    void testSearchPerformance() {
        WikiSearchRequest request = new WikiSearchRequest();
        request.setQuery("欠费金额查询示例");
        request.setTopK(20);

        for (int i = 0; i < 10; i++) {
            searchService.search(request);
        }
    }

    @Test
    void testBulkInsertPerformance() {
        List<WikiEntity> entities = new ArrayList<>();
        for (int i = 0; i < 1000; i++) {
            WikiEntity entity = new WikiEntity();
            entity.setEntityId("perf:test:" + i);
            entity.setName("test_" + i);
            entity.setEntityType("TABLE");
            entities.add(entity);
        }

        long start = System.currentTimeMillis();
        entities.forEach(entityService::createEntity);
        long duration = System.currentTimeMillis() - start;

        assertTrue(duration < 30000);
        log.info("Bulk insert 1000 entities took {}ms", duration);
    }
}
```

---

## 十七、监控与运维

### 17.1 监控指标

| 指标名称 | 类型 | 说明 | 告警阈值 |
|----------|------|------|----------|
| wiki_entity_count | Gauge | 实体总数 | - |
| wiki_knowledge_card_count | Gauge | 知识卡片总数 | - |
| wiki_contradiction_pending | Gauge | 待处理矛盾数 | > 10 |
| wiki_compile_duration | Histogram | 编译耗时 | > 300s |
| wiki_search_duration | Histogram | 搜索耗时 | > 500ms |
| wiki_llm_call_duration | Histogram | LLM 调用耗时 | > 30s |
| wiki_embedding_call_duration | Histogram | 嵌入调用耗时 | > 1s |
| wiki_error_total | Counter | 错误总数 | > 0 |
| wiki_cache_hit_ratio | Gauge | 缓存命中率 | < 0.8 |

### 17.2 日志规范

```java
@Slf4j
public class WikiOperationLogger {

    public static void logEntityCreate(WikiEntity entity) {
        log.info("[WIKI_OP] CREATE entity:{} type:{} name:{}",
                entity.getEntityId(),
                entity.getEntityType(),
                entity.getName());
    }

    public static void logEntityUpdate(WikiEntity oldEntity, WikiEntity newEntity) {
        log.info("[WIKI_OP] UPDATE entity:{} version:{}->{}",
                oldEntity.getEntityId(),
                oldEntity.getVersion(),
                newEntity.getVersion());
    }

    public static void logContradictionDetected(Contradiction contradiction) {
        log.warn("[WIKI_OP] CONTRADICTION id:{} type:{} entity:{}",
                contradiction.getContradictionId(),
                contradiction.getConflictType(),
                contradiction.getEntityId());
    }

    public static void logCompilation(CompileResult result) {
        log.info("[WIKI_OP] COMPILE status:{} tables:{} entities:{} cards:{} duration:{}ms",
                result.getStatus(),
                result.getTotalTables(),
                result.getNewEntities(),
                result.getNewKnowledgeCards(),
                result.getDuration());
    }

    public static void logSearch(String query, long duration, int resultCount) {
        log.debug("[WIKI_OP] SEARCH query:{} duration:{}ms results:{}",
                query, duration, resultCount);
    }
}
```

### 17.3 健康检查

```java
@Component
@Slf4j
public class WikiHealthIndicator implements HealthIndicator {

    @Autowired
    private WikiEntityRepository entityRepository;

    @Autowired
    private WikiKnowledgeRepository knowledgeRepository;

    @Autowired
    private EmbeddingService embeddingService;

    @Override
    public Health health() {
        Map<String, Object> details = new HashMap<>();

        try {
            long entityCount = entityRepository.count();
            long cardCount = knowledgeRepository.count();
            details.put("entityCount", entityCount);
            details.put("knowledgeCardCount", cardCount);

            boolean embeddingHealthy = checkEmbeddingService();
            details.put("embeddingService", embeddingHealthy ? "UP" : "DOWN");

            if (!embeddingHealthy) {
                return Health.down()
                        .withDetails(details)
                        .withException(new Exception("Embedding service unavailable"))
                        .build();
            }

            return Health.up().withDetails(details).build();

        } catch (Exception e) {
            log.error("Wiki health check failed", e);
            return Health.down()
                    .withDetails(details)
                    .withException(e)
                    .build();
        }
    }

    private boolean checkEmbeddingService() {
        try {
            embeddingService.embed("health check");
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
```

---

## 十八、前端交互设计

### 18.1 技术栈与项目结构

#### 18.1.1 技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| React | 18.x | UI 框架 |
| TypeScript | 4.x | 类型安全 |
| Ant Design | 5.x | UI 组件库 |
| @ant-design/pro-components | 2.7.x | Pro 组件库 |
| @antv/g6 | 4.8.x | 图可视化 |
| umi/max | 4.x | 前端框架 |
| ahooks | 3.x | React Hooks |

#### 18.1.2 目录结构

```
webapp/packages/supersonic-fe/src/
├── pages/
│   └── Wiki/                              # Wiki 模块
│       ├── index.tsx                       # 主页面
│       ├── components/
│       │   ├── EntityPage/               # 实体页面
│       │   │   ├── EntityDetail.tsx       # 实体详情
│       │   │   ├── EntityLinks.tsx        # 关联链接
│       │   │   ├── KnowledgeCards.tsx     # 知识卡片
│       │   │   └── ContradictionAlert.tsx # 矛盾警告
│       │   ├── TopicPage/                # 主题页面
│       │   │   ├── TopicOverview.tsx      # 主题概览
│       │   │   ├── TopicSummary.tsx       # 主题摘要
│       │   │   └── TopicEntities.tsx      # 主题实体
│       │   ├── Search/                    # 搜索组件
│       │   │   ├── WikiSearch.tsx         # Wiki 搜索
│       │   │   ├── SearchResults.tsx       # 搜索结果
│       │   │   └── SearchFilters.tsx      # 搜索过滤
│       │   ├── Graph/                     # 图可视化
│       │   │   ├── EntityGraph.tsx        # 实体关系图
│       │   │   ├── GraphToolbar.tsx       # 图形工具栏
│       │   │   └── NodeDetail.tsx         # 节点详情
│       │   ├── Compiler/                  # 编译构建
│       │   │   ├── CompileForm.tsx        # 编译表单
│       │   │   ├── CompileProgress.tsx    # 编译进度
│       │   │   └── CompileResult.tsx      # 编译结果
│       │   └── Contradiction/             # 矛盾管理
│       │       ├── ContradictionList.tsx  # 矛盾列表
│       │       ├── ContradictionDetail.tsx # 矛盾详情
│       │       └── ResolveModal.tsx       # 解决弹窗
│       └── hooks/
│           ├── useWikiSearch.ts           # Wiki 搜索 Hook
│           ├── useEntity.ts               # 实体 Hook
│           └── useCompiler.ts              # 编译 Hook
├── services/
│   └── wiki.ts                            # Wiki API 服务
├── models/
│   └── wiki.ts                            # Wiki 状态模型
└── utils/
    └── wiki.ts                            # Wiki 工具函数
```

### 18.2 页面设计

#### 18.2.1 Wiki 首页

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  [Logo] LLM-SQL-Wiki                              [搜索框]        [用户菜单] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │                    🔍 搜索 Wiki 知识库...                            │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│  │   📊        │  │   🔗        │  │   📝        │  │   ⚠️        │       │
│  │   实体      │  │   链接      │  │   知识卡片  │  │   矛盾      │       │
│  │   156       │  │   423       │  │   1,234     │  │   5         │       │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘       │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  主题域                                                                     │
│  │  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐       │
│  │  │ 用户管理 │ │ 收费管理 │ │ 采暖期  │ │ 地区管理 │ │ 合同管理 │       │
│  │  │  12实体  │ │  8实体   │ │  5实体   │ │  3实体   │ │  6实体   │       │
│  │  └──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘       │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  最近更新                                                                    │
│  │  • customer 表 - 新增 3 个知识卡片 (2小时前)                           │
│  │  • sf_js_t.qfje 字段 - 检测到语义矛盾 (5小时前)                        │
│  │  • pay_order 表 - 主题摘要已更新 (1天前)                                │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### 18.2.2 实体详情页

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  ← 返回   table:customer                                        [编辑] [删除] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────┐  ┌─────────────────────────────────┐   │
│  │  用户信息表                     │  │  ⚠️ 存在 2 个待处理矛盾         │   │
│  │  TABLE | charge_zbhx_20260303  │  │  [查看矛盾详情]                  │   │
│  │                                 │  └─────────────────────────────────┘   │
│  │  描述:                          │                                        │
│  │  存储供热收费系统中的用户基本    │                                        │
│  │  信息，包括用户编码、名称、联    │                                        │
│  │  系方式、地址等...              │                                        │
│  │                                 │                                        │
│  │  标签: [用户] [核心表] [P0]     │                                        │
│  │  版本: 1.2.0                    │                                        │
│  └─────────────────────────────────┘                                        │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  字段列表                                            [+ 添加字段知识]   │  │
│  │  ┌───────────────────────────────────────────────────────────────┐  │  │
│  │  │ 字段名      │ 类型         │ 注释      │ 主键 │ 外键 │ 操作   │  │  │
│  │  ├───────────────────────────────────────────────────────────────┤  │  │
│  │  │ id          │ bigint       │ 用户ID    │  🔑  │      │ [详情] │  │  │
│  │  │ code        │ varchar(20)  │ 用户编码  │      │  🔗  │ [详情] │  │  │
│  │  │ name        │ varchar(40)  │ 用户名称  │      │      │ [详情] │  │  │
│  │  │ mob_no      │ varchar(200) │ 手机号    │      │      │ [详情] │  │  │
│  │  │ yhlx        │ varchar(10)  │ 用户类型  │      │      │ [详情] │  │  │
│  │  └───────────────────────────────────────────────────────────────┘  │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  关联链接                              [查看关系图]                    │  │
│  │  ┌─────────────────────┐  ┌─────────────────────┐                    │  │
│  │  │ → sf_js_t (1:N)    │  │ → pay_order (1:N)   │                    │  │
│  │  │   收费结算表        │  │   缴费订单表        │                    │  │
│  │  └─────────────────────┘  └─────────────────────┘                    │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  知识卡片 (8)                                       [+ 新增知识卡片]   │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ 📋 RELATIONSHIP                                               │    │  │
│  │  │ 与收费表的关联关系                                            │    │  │
│  │  │ customer 通过 customer_id 字段与 sf_js_t 形成 1:N 关系        │    │  │
│  │  │ 置信度: 98%  来源: [建表语句] [业务文档]          [编辑] [删除]│    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ 📋 DATA_PATTERN                                              │    │  │
│  │  │ 用户类型取值规则                                            │    │  │
│  │  │ yhlx 字段取值为'居民'或'单位'                               │    │  │
│  │  │ 置信度: 95%  来源: [字段分析]                    [编辑] [删除]│    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### 18.2.3 知识搜索页

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  搜索 Wiki                                                              [?] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  🔍  查询本采暖期欠费用户                                           │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  搜索范围: [全部 ▼]  实体类型: [全部 ▼]  卡片类型: [全部 ▼]  [高级]       │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  搜索结果 (0.185s)                                    找到 12 个结果  │  │
│  │                                                                       │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ 🔗 table:sf_js_t | 收费结算表                                    │    │  │
│  │  │  relevance: 95%                                                │    │  │
│  │  │ 匹配字段: 表名、描述                                             │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                                                       │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ 📝 知识卡片 | BUSINESS_RULE | 欠费金额业务规则                   │    │  │
│  │  │ qfje 字段大于 0 表示存在欠费，可用于筛选欠费用户               │    │  │
│  │  │ 置信度: 95%  相关实体: [sf_js_t.qfje]            [查看详情]    │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                                                       │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ 📝 知识卡片 | USAGE_PATTERN | 欠费查询示例                     │    │  │
│  │  │ SELECT * FROM sf_js_t WHERE qfje > 0 AND cnq = '2025-2026' │    │  │
│  │  │ 置信度: 90%  相关实体: [sf_js_t]                [查看详情]    │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                                                       │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ 📋 主题摘要 | 收费管理主题                                       │    │  │
│  │  │ 收费管理主题涵盖供热收费全流程，包含用户缴费、欠费催缴等功能... │    │  │
│  │  │ 匹配实体: 8 个                                      [查看详情]   │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                                                       │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  💡 建议 SQL                                                          │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ SELECT c.name, c.mob_no, s.qfje                            │    │  │
│  │  │ FROM customer c                                            │    │  │
│  │  │ JOIN sf_js_t s ON c.id = s.customer_id                     │    │  │
│  │  │ WHERE s.qfje > 0 AND s.cnq = '2025-2026'                  │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                              [复制] [执行] [查看解释] │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### 18.2.4 实体关系图

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  实体关系图                                          [全屏] [导出] [刷新]    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────┐       │
│  │                                                                   │       │
│  │                    ┌─────────────┐                               │       │
│  │                    │   customer   │                               │       │
│  │                    │  用户信息表  │                               │       │
│  │                    └──────┬──────┘                               │       │
│  │                           │                                       │       │
│  │              ┌───────────┼───────────┐                           │       │
│  │              │ 1:N       │           │ 1:N                      │       │
│  │              ▼           │           ▼                           │       │
│  │      ┌─────────────┐     │     ┌─────────────┐                   │       │
│  │      │  sf_js_t   │     │     │ pay_order   │                   │       │
│  │      │  收费结算表 │     │     │ 缴费订单表  │                   │       │
│  │      └──────┬─────┘     │     └──────┬─────┘                   │       │
│  │             │            │            │                          │       │
│  │             └────────────┼────────────┘                          │       │
│  │                          │ cnq (采暖期)                          │       │
│  │                          ▼                                       │       │
│  │                   ┌─────────────┐                                │       │
│  │                   │  cnq_info   │                                │       │
│  │                   │  采暖期信息  │                                │       │
│  │                   └─────────────┘                                │       │
│  │                                                                   │       │
│  └─────────────────────────────────────────────────────────────────┘       │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  图例:  [表实体] [字段实体] [主题实体]     筛选: [▼ 全选] [▼ 取消]    │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  点击节点查看详情 (当前选中: customer)                                │  │
│  │  表名: customer | 字段数: 12 | 关系数: 3 | 知识卡片: 8              │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

#### 18.2.5 矛盾管理页

```
┌─────────────────────────────────────────────────────────────────────────────┐
│  矛盾管理                                              [导出] [批量处理]    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  状态: [全部 ▼] [待处理(3)] [已解决(2)]   类型: [全部 ▼]   优先级: [全部 ▼]│
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐  │
│  │  矛盾列表                                                             │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ ⚠️ SEMANTIC_CONFLICT | PENDING                              │    │  │
│  │  │                                                               │    │  │
│  │  │ 实体: column:customer.balance                                │    │  │
│  │  │                                                               │    │  │
│  │  │ 旧知识: balance 字段表示用户账户余额 (置信度: 85%)            │    │  │
│  │  │ ↓ 与 ↓                                                        │    │  │
│  │  │ 新证据: sf_js_t.qfje 才是欠费金额，balance 含义待确认        │    │  │
│  │  │                                                               │    │  │
│  │  │ 影响: 影响'查询用户余额'相关 SQL 生成                         │    │  │
│  │  │ 检测时间: 2026-04-17 15:00:00                                │    │  │
│  │  │                                                               │    │  │
│  │  │            [查看详情]  [接受新证据]  [保留旧知识]  [合并]     │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                                                       │  │
│  │  ┌─────────────────────────────────────────────────────────────┐    │  │
│  │  │ ⚠️ RULE_CONFLICT | PENDING                                  │    │  │
│  │  │                                                               │    │  │
│  │  │ 实体: table:sf_js_t                                          │    │  │
│  │  │                                                               │    │  │
│  │  │ 旧知识: 居民按面积收费                                        │    │  │
│  │  │ ↓ 与 ↓                                                        │    │  │
│  │  │ 新证据: 发现存在按热计收费的记录                               │    │  │
│  │  │                                                               │    │  │
│  │  │            [查看详情]  [接受新证据]  [保留旧知识]  [合并]     │    │  │
│  │  └─────────────────────────────────────────────────────────────┘    │  │
│  │                                                                       │  │
│  └─────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 18.3 核心组件设计

#### 18.3.1 实体卡片组件

```tsx
// components/EntityCard/index.tsx
import React from 'react';
import { Card, Tag, Space, Typography, Tooltip } from 'antd';
import { 
  DatabaseOutlined, 
  ColumnHeightOutlined, 
  LinkOutlined 
} from '@ant-design/icons';

const { Text, Paragraph } = Typography;

interface EntityCardProps {
  entity: {
    entityId: string;
    entityType: 'TABLE' | 'COLUMN' | 'TOPIC';
    name: string;
    displayName: string;
    description?: string;
    properties?: Record<string, any>;
    tags?: string[];
    version?: string;
  };
  onClick?: () => void;
  onEdit?: () => void;
}

export const EntityCard: React.FC<EntityCardProps> = ({ entity, onClick, onEdit }) => {
  const getTypeIcon = (type: string) => {
    switch (type) {
      case 'TABLE': return <DatabaseOutlined />;
      case 'COLUMN': return <ColumnHeightOutlined />;
      default: return <DatabaseOutlined />;
    }
  };

  const getTypeColor = (type: string) => {
    switch (type) {
      case 'TABLE': return 'blue';
      case 'COLUMN': return 'green';
      case 'TOPIC': return 'purple';
      default: return 'default';
    }
  };

  return (
    <Card 
      hoverable 
      onClick={onClick}
      className="entity-card"
      title={
        <Space>
          {getTypeIcon(entity.entityType)}
          <Text strong>{entity.displayName}</Text>
          <Tag color={getTypeColor(entity.entityType)}>{entity.entityType}</Tag>
        </Space>
      }
      extra={
        <Space>
          <Text type="secondary" className="entity-id">{entity.entityId}</Text>
          {onEdit && <Button type="link" onClick={onEdit}>编辑</Button>}
        </Space>
      }
    >
      {entity.description && (
        <Paragraph type="secondary" ellipsis={{ rows: 2 }}>
          {entity.description}
        </Paragraph>
      )}
      
      <div className="entity-meta">
        {entity.properties && (
          <Space split={<Divider type="vertical" />}>
            {entity.properties.columnCount && (
              <Text type="secondary">
                字段数: {entity.properties.columnCount}
              </Text>
            )}
            {entity.properties.primaryKey && (
              <Text type="secondary">
                主键: {entity.properties.primaryKey}
              </Text>
            )}
          </Space>
        )}
      </div>

      {entity.tags && entity.tags.length > 0 && (
        <div className="entity-tags">
          <Space wrap>
            {entity.tags.map(tag => (
              <Tag key={tag}>{tag}</Tag>
            ))}
          </Space>
        </div>
      )}

      <style jsx>{`
        .entity-card {
          margin-bottom: 16px;
        }
        .entity-id {
          font-size: 12px;
        }
        .entity-tags {
          margin-top: 12px;
        }
      `}</style>
    </Card>
  );
};
```

#### 18.3.2 知识卡片组件

```tsx
// components/KnowledgeCard/index.tsx
import React from 'react';
import { Card, Tag, Space, Typography, Button, Tooltip, Popconfirm } from 'antd';
import { 
  FileTextOutlined, 
  CheckCircleOutlined, 
  WarningOutlined,
  EditOutlined,
  DeleteOutlined,
  CopyOutlined
} from '@ant-design/icons';
import { Prism as SyntaxHighlighter } from 'react-syntax-highlighter';

const { Text, Paragraph } = Typography;

interface KnowledgeCardProps {
  card: {
    cardId: string;
    cardType: 'RELATIONSHIP' | 'BUSINESS_RULE' | 'DATA_PATTERN' | 
              'USAGE_PATTERN' | 'SEMANTIC_MAPPING' | 'METRIC_DEFINITION';
    title: string;
    content: string;
    confidence: number;
    status: 'ACTIVE' | 'CONFLICTED' | 'ARCHIVED';
    extractedFrom?: string[];
    tags?: string[];
  };
  showActions?: boolean;
  onEdit?: () => void;
  onDelete?: () => void;
  onCopy?: () => void;
}

const cardTypeConfig = {
  RELATIONSHIP: { color: 'blue', label: '关系' },
  BUSINESS_RULE: { color: 'orange', label: '业务规则' },
  DATA_PATTERN: { color: 'green', label: '数据模式' },
  USAGE_PATTERN: { color: 'purple', label: '使用模式' },
  SEMANTIC_MAPPING: { color: 'cyan', label: '语义映射' },
  METRIC_DEFINITION: { color: 'magenta', label: '指标定义' },
};

export const KnowledgeCard: React.FC<KnowledgeCardProps> = ({
  card,
  showActions = true,
  onEdit,
  onDelete,
  onCopy
}) => {
  const config = cardTypeConfig[card.cardType] || { color: 'default', label: card.cardType };

  const isSqlContent = card.content.trim().toUpperCase().startsWith('SELECT') ||
                       card.content.trim().toUpperCase().startsWith('INSERT') ||
                       card.content.trim().toUpperCase().startsWith('UPDATE') ||
                       card.content.trim().toUpperCase().startsWith('DELETE');

  return (
    <Card 
      size="small" 
      className={`knowledge-card ${card.status === 'CONFLICTED' ? 'conflicted' : ''}`}
      title={
        <Space>
          <FileTextOutlined />
          <Tag color={config.color}>{config.label}</Tag>
          <Text strong>{card.title}</Text>
          {card.status === 'CONFLICTED' && (
            <Tooltip title="此卡片存在矛盾，需审核">
              <WarningOutlined style={{ color: '#faad14' }} />
            </Tooltip>
          )}
        </Space>
      }
      extra={
        showActions && (
          <Space>
            {isSqlContent && onCopy && (
              <Tooltip title="复制">
                <Button 
                  type="text" 
                  icon={<CopyOutlined />} 
                  onClick={onCopy}
                  size="small"
                />
              </Tooltip>
            )}
            {onEdit && (
              <Tooltip title="编辑">
                <Button 
                  type="text" 
                  icon={<EditOutlined />} 
                  onClick={onEdit}
                  size="small"
                />
              </Tooltip>
            )}
            {onDelete && (
              <Popconfirm
                title="确定删除此知识卡片？"
                onConfirm={onDelete}
              >
                <Tooltip title="删除">
                  <Button 
                    type="text" 
                    danger 
                    icon={<DeleteOutlined />} 
                    size="small"
                  />
                </Tooltip>
              </Popconfirm>
            )}
          </Space>
        )
      }
    >
      <div className="card-content">
        {isSqlContent ? (
          <SyntaxHighlighter 
            language="sql" 
            showLineNumbers
            customStyle={{ fontSize: '12px', maxHeight: '200px' }}
          >
            {card.content}
          </SyntaxHighlighter>
        ) : (
          <Paragraph>{card.content}</Paragraph>
        )}
      </div>

      <div className="card-footer">
        <Space split={<Divider type="vertical" />}>
          <Text type="secondary">
            置信度: {(card.confidence * 100).toFixed(0)}%
          </Text>
          {card.extractedFrom && card.extractedFrom.length > 0 && (
            <Text type="secondary">
              来源: {card.extractedFrom.join(', ')}
            </Text>
          )}
        </Space>
      </div>

      {card.tags && card.tags.length > 0 && (
        <div className="card-tags">
          <Space size={[4, 4]} wrap>
            {card.tags.map(tag => (
              <Tag key={tag}>#{tag}</Tag>
            ))}
          </Space>
        </div>
      )}

      <style jsx>{`
        .knowledge-card {
          margin-bottom: 12px;
          border-left: 3px solid ${config.color};
        }
        .knowledge-card.conflicted {
          border-left-color: #faad14;
          background: #fffbe6;
        }
        .card-content {
          margin-bottom: 12px;
        }
        .card-footer {
          padding-top: 8px;
          border-top: 1px solid #f0f0f0;
        }
        .card-tags {
          margin-top: 8px;
        }
      `}</style>
    </Card>
  );
};
```

#### 18.3.3 实体关系图组件

```tsx
// components/EntityGraph/index.tsx
import React, { useEffect, useRef } from 'react';
import { Card, Button, Space, Segmented } from 'antd';
import G6 from '@antv/g6';
import { FullscreenOutlined, ExportOutlined, ReloadOutlined } from '@ant-design/icons';

interface EntityGraphProps {
  data: {
    nodes: Array<{
      id: string;
      label: string;
      type: 'TABLE' | 'COLUMN' | 'TOPIC';
      [key: string]: any;
    }>;
    edges: Array<{
      source: string;
      target: string;
      label?: string;
      type?: string;
    }>;
  };
  onNodeClick?: (nodeId: string) => void;
  height?: number;
}

export const EntityGraph: React.FC<EntityGraphProps> = ({
  data,
  onNodeClick,
  height = 500
}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const graphRef = useRef<G6.Graph | null>(null);

  useEffect(() => {
    if (!containerRef.current) return;

    const graph = new G6.Graph({
      container: containerRef.current,
      width: containerRef.current.offsetWidth,
      height,
      modes: {
        default: ['drag-canvas', 'zoom-canvas', 'drag-node'],
      },
      defaultNode: {
        type: 'rect',
        style: {
          fill: '#fff',
          stroke: '#1890ff',
          cursor: 'pointer',
        },
        labelCfg: {
          style: {
            fontSize: 12,
          },
        },
      },
      defaultEdge: {
        type: 'quadratic',
        style: {
          stroke: '#e8e8e8',
          lineWidth: 2,
          endArrow: {
            path: G6.Arrow.triangle(6, 8, 0),
            fill: '#e8e8e8',
          },
        },
        labelCfg: {
          autoRotate: true,
          style: {
            fontSize: 10,
            fill: '#8c8c8c',
          },
        },
      },
      layout: {
        type: 'dagre',
        rankdir: 'TB',
        nodesep: 60,
        ranksep: 80,
      },
    });

    graph.data(data);
    graph.render();

    graph.on('node:click', (evt) => {
      if (onNodeClick && evt.item) {
        const model = evt.item.getModel();
        onNodeClick(model.id as string);
      }
    });

    graphRef.current = graph;

    return () => {
      graph.destroy();
    };
  }, [data, height, onNodeClick]);

  const handleFullscreen = () => {
    if (containerRef.current) {
      containerRef.current.requestFullscreen?.();
    }
  };

  const handleExport = () => {
    if (graphRef.current) {
      graphRef.current.downloadFullImage('entity-graph.png', 'image/png', {
        backgroundColor: '#fff',
      });
    }
  };

  const handleRefresh = () => {
    if (graphRef.current) {
      graphRef.current.refresh();
    }
  };

  return (
    <Card
      className="entity-graph-card"
      title="实体关系图"
      extra={
        <Space>
          <Segmented 
            size="small"
            options={[
              { label: '层级', value: 'TB' },
              { label: '环形', value: 'circular' },
            ]}
            defaultValue="TB"
          />
          <Button 
            type="text" 
            icon={<ReloadOutlined />} 
            onClick={handleRefresh}
            size="small"
          />
          <Button 
            type="text" 
            icon={<ExportOutlined />} 
            onClick={handleExport}
            size="small"
          />
          <Button 
            type="text" 
            icon={<FullscreenOutlined />} 
            onClick={handleFullscreen}
            size="small"
          />
        </Space>
      }
    >
      <div 
        ref={containerRef} 
        style={{ width: '100%', height }}
      />

      <style jsx>{`
        .entity-graph-card :global(.ant-card-body) {
          padding: 0;
        }
      `}</style>
    </Card>
  );
};
```

### 18.4 状态管理

#### 18.4.1 Wiki Model

```tsx
// models/wiki.ts
import { useState, useCallback } from 'react';
import { message } from 'antd';
import { 
  getEntities, 
  getEntityById, 
  searchWiki,
  getEntityLinks,
  getEntityKnowledge,
  compileSchema,
  getContradictions,
  resolveContradiction,
  getCompileStatus
} from '@/services/wiki';
import type {
  WikiEntity,
  WikiLink,
  KnowledgeCard,
  Contradiction,
  CompileRequest,
  SearchRequest
} from '@/services/wiki';

export interface WikiState {
  entities: WikiEntity[];
  currentEntity: WikiEntity | null;
  links: WikiLink[];
  knowledgeCards: KnowledgeCard[];
  contradictions: Contradiction[];
  searchResults: {
    entities: WikiEntity[];
    knowledgeCards: KnowledgeCard[];
    suggestions: string[];
  };
  loading: boolean;
  compileProgress: number | null;
}

export function useWikiModel() {
  const [state, setState] = useState<WikiState>({
    entities: [],
    currentEntity: null,
    links: [],
    knowledgeCards: [],
    contradictions: [],
    searchResults: {
      entities: [],
      knowledgeCards: [],
      suggestions: [],
    },
    loading: false,
    compileProgress: null,
  });

  const setLoading = useCallback((loading: boolean) => {
    setState(prev => ({ ...prev, loading }));
  }, []);

  const fetchEntities = useCallback(async (params?: {
    type?: string;
    topicId?: string;
    status?: string;
    page?: number;
    size?: number;
  }) => {
    setLoading(true);
    try {
      const response = await getEntities(params);
      if (response.success) {
        setState(prev => ({ 
          ...prev, 
          entities: response.data?.content || [] 
        }));
      }
    } catch (error) {
      message.error('获取实体列表失败');
    } finally {
      setLoading(false);
    }
  }, [setLoading]);

  const fetchEntityDetail = useCallback(async (entityId: string) => {
    setLoading(true);
    try {
      const [entityResp, linksResp, cardsResp] = await Promise.all([
        getEntityById(entityId),
        getEntityLinks(entityId),
        getEntityKnowledge(entityId),
      ]);

      if (entityResp.success) {
        setState(prev => ({ 
          ...prev, 
          currentEntity: entityResp.data,
          links: linksResp.data || [],
          knowledgeCards: cardsResp.data || [],
        }));
      }
    } catch (error) {
      message.error('获取实体详情失败');
    } finally {
      setLoading(false);
    }
  }, [setLoading]);

  const search = useCallback(async (request: SearchRequest) => {
    setLoading(true);
    try {
      const response = await searchWiki(request);
      if (response.success) {
        setState(prev => ({ 
          ...prev, 
          searchResults: {
            entities: response.data?.entities || [],
            knowledgeCards: response.data?.knowledgeCards || [],
            suggestions: response.data?.suggestions || [],
          },
        }));
      }
    } catch (error) {
      message.error('搜索失败');
    } finally {
      setLoading(false);
    }
  }, [setLoading]);

  const compile = useCallback(async (request: CompileRequest) => {
    setState(prev => ({ ...prev, compileProgress: 0 }));
    try {
      const response = await compileSchema(request);
      if (response.success && response.data?.taskId) {
        const taskId = response.data.taskId;
        
        const pollStatus = async () => {
          const statusResp = await getCompileStatus(taskId);
          if (statusResp.success && statusResp.data) {
            const progress = statusResp.data.progress;
            setState(prev => ({ ...prev, compileProgress: progress }));
            
            if (statusResp.data.status === 'COMPLETED') {
              message.success('编译完成');
              setState(prev => ({ ...prev, compileProgress: null }));
              fetchEntities();
            } else if (statusResp.data.status === 'FAILED') {
              message.error('编译失败: ' + statusResp.data.error);
              setState(prev => ({ ...prev, compileProgress: null }));
            } else {
              setTimeout(pollStatus, 2000);
            }
          }
        };
        
        pollStatus();
      }
    } catch (error) {
      message.error('编译失败');
      setState(prev => ({ ...prev, compileProgress: null }));
    }
  }, [fetchEntities]);

  const fetchContradictions = useCallback(async (params?: {
    status?: string;
    conflictType?: string;
  }) => {
    setLoading(true);
    try {
      const response = await getContradictions(params);
      if (response.success) {
        setState(prev => ({ 
          ...prev, 
          contradictions: response.data?.content || [] 
        }));
      }
    } catch (error) {
      message.error('获取矛盾列表失败');
    } finally {
      setLoading(false);
    }
  }, [setLoading]);

  const resolve = useCallback(async (
    contradictionId: string, 
    resolution: 'ACCEPT_NEW' | 'KEEP_OLD' | 'MERGE',
    notes?: string
  ) => {
    setLoading(true);
    try {
      const response = await resolveContradiction(contradictionId, {
        resolution,
        resolvedBy: 'currentUser',
        resolutionNotes: notes,
      });
      if (response.success) {
        message.success('矛盾已解决');
        fetchContradictions();
      }
    } catch (error) {
      message.error('解决矛盾失败');
    } finally {
      setLoading(false);
    }
  }, [fetchContradictions]);

  return {
    state,
    fetchEntities,
    fetchEntityDetail,
    search,
    compile,
    fetchContradictions,
    resolve,
    setLoading,
  };
}
```

### 18.5 API 服务封装

#### 18.5.1 Wiki 服务模块

```tsx
// services/wiki.ts
import request from 'umi-request';

export type EntityType = 'TABLE' | 'COLUMN' | 'TOPIC';
export type CardType = 'RELATIONSHIP' | 'BUSINESS_RULE' | 'DATA_PATTERN' | 
                       'USAGE_PATTERN' | 'SEMANTIC_MAPPING' | 'METRIC_DEFINITION';
export type ConflictType = 'SCHEMA_CONFLICT' | 'SEMANTIC_CONFLICT' | 
                           'RELATIONSHIP_CONFLICT' | 'RULE_CONFLICT';
export type ResolutionType = 'PENDING' | 'ACCEPT_NEW' | 'KEEP_OLD' | 'MERGED';

export interface WikiEntity {
  entityId: string;
  entityType: EntityType;
  name: string;
  displayName: string;
  description?: string;
  properties?: Record<string, any>;
  summary?: string;
  tags?: string[];
  version?: string;
  parentEntityId?: string;
  topicId?: string;
  status?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface WikiLink {
  linkId?: number;
  sourceEntityId: string;
  targetEntityId: string;
  linkType: string;
  relation?: string;
  description?: string;
  bidirectional?: boolean;
  weight?: number;
}

export interface KnowledgeCard {
  cardId: string;
  entityId: string;
  cardType: CardType;
  title: string;
  content: string;
  extractedFrom?: string[];
  confidence?: number;
  status?: string;
  tags?: string[];
  version?: string;
  createdAt?: string;
}

export interface Contradiction {
  contradictionId: string;
  entityId: string;
  conflictType: ConflictType;
  oldContent?: string;
  newEvidence?: string;
  evidenceSource?: string;
  impact?: string;
  resolution?: ResolutionType;
  resolvedAt?: string;
  resolvedBy?: string;
  resolutionNotes?: string;
  createdAt?: string;
}

export interface SearchRequest {
  query: string;
  searchType?: 'HYBRID' | 'ENTITY' | 'KNOWLEDGE';
  entityFirst?: boolean;
  topK?: number;
  includeTypes?: EntityType[];
  filters?: {
    topicId?: string;
    tags?: string[];
    cardTypes?: CardType[];
  };
}

export interface SearchResponse {
  success: boolean;
  data?: {
    entities: WikiEntity[];
    knowledgeCards: KnowledgeCard[];
    topicSummary?: {
      topicId: string;
      summary: string;
      matchedEntities: number;
    };
    suggestions: string[];
    searchTime: number;
  };
}

export interface CompileRequest {
  sqlFilePath: string;
  targetTables?: string[];
  options?: {
    extractKnowledge?: boolean;
    detectContradiction?: boolean;
    updateSummary?: boolean;
    parallelProcessing?: boolean;
  };
}

export interface CompileStatus {
  taskId: string;
  status: 'PROCESSING' | 'COMPLETED' | 'FAILED';
  progress: number;
  startTime: string;
  endTime?: string;
  result?: {
    totalTables: number;
    processedTables: number;
    newEntities: number;
    newKnowledgeCards: number;
    contradictionsDetected: number;
  };
  error?: string;
}

export async function getEntities(params?: {
  type?: string;
  topicId?: string;
  status?: string;
  page?: number;
  size?: number;
}): Promise<{ success: boolean; data?: { content: WikiEntity[]; totalElements: number } }> {
  return request('/api/wiki/entities', { params });
}

export async function getEntityById(entityId: string): Promise<{ success: boolean; data?: WikiEntity }> {
  return request(`/api/wiki/entities/${entityId}`);
}

export async function getEntityLinks(entityId: string): Promise<{ success: boolean; data?: WikiLink[] }> {
  return request(`/api/wiki/entities/${entityId}/links`);
}

export async function getEntityKnowledge(entityId: string, params?: {
  type?: CardType;
  status?: string;
}): Promise<{ success: boolean; data?: KnowledgeCard[] }> {
  return request(`/api/wiki/entities/${entityId}/knowledge`, { params });
}

export async function searchWiki(request: SearchRequest): Promise<SearchResponse> {
  return request('/api/wiki/search', {
    method: 'POST',
    data: request,
  });
}

export async function compileSchema(request: CompileRequest): Promise<{
  success: boolean;
  data?: { taskId: string };
}> {
  return request('/api/wiki/compile/schema', {
    method: 'POST',
    data: request,
  });
}

export async function getCompileStatus(taskId: string): Promise<{ success: boolean; data?: CompileStatus }> {
  return request(`/api/wiki/compile/status/${taskId}`);
}

export async function getContradictions(params?: {
  status?: ResolutionType;
  conflictType?: ConflictType;
  page?: number;
  size?: number;
}): Promise<{ success: boolean; data?: { content: Contradiction[]; totalElements: number } }> {
  return request('/api/wiki/contradictions', { params });
}

export async function getContradictionById(contradictionId: string): Promise<{
  success: boolean;
  data?: Contradiction;
}> {
  return request(`/api/wiki/contradictions/${contradictionId}`);
}

export async function resolveContradiction(
  contradictionId: string, 
  resolution: {
    resolution: ResolutionType;
    resolvedBy: string;
    resolutionNotes?: string;
  }
): Promise<{ success: boolean }> {
  return request(`/api/wiki/contradictions/${contradictionId}/resolve`, {
    method: 'POST',
    data: resolution,
  });
}

export async function getTopics(): Promise<{ success: boolean; data?: Array<{
  topicId: string;
  topicName: string;
  entityCount: number;
}> }> {
  return request('/api/wiki/topics');
}

export async function getTopicSummary(topicId: string): Promise<{
  success: boolean;
  data?: {
    summary: string;
    memberEntities: string[];
    relationships: string[];
    summaryVersion: number;
    generatedAt: string;
  };
}> {
  return request(`/api/wiki/topics/${topicId}/summary`);
}
```

### 18.6 路由配置

```tsx
// config/routes.ts
export default [
  {
    path: '/wiki',
    name: 'Wiki',
    icon: 'BookOutlined',
    component: './Wiki',
    routes: [
      {
        path: '/wiki',
        redirect: '/wiki/home',
      },
      {
        path: '/wiki/home',
        name: '首页',
        component: './Wiki/Home',
      },
      {
        path: '/wiki/entity/:entityId',
        name: '实体详情',
        component: './Wiki/EntityDetail',
        hideInMenu: true,
      },
      {
        path: '/wiki/search',
        name: '知识搜索',
        component: './Wiki/Search',
      },
      {
        path: '/wiki/graph',
        name: '关系图',
        component: './Wiki/EntityGraph',
      },
      {
        path: '/wiki/compiler',
        name: '编译构建',
        component: './Wiki/Compiler',
      },
      {
        path: '/wiki/contradictions',
        name: '矛盾管理',
        component: './Wiki/Contradictions',
      },
      {
        path: '/wiki/topic/:topicId',
        name: '主题详情',
        component: './Wiki/TopicDetail',
        hideInMenu: true,
      },
    ],
  },
];
```

### 18.7 用户操作流程

#### 18.7.1 知识搜索流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    知识搜索流程                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  用户输入查询 ──> 实时建议 ──> 选择建议/回车                      │
│       │                   │                                      │
│       │           ┌───────┴───────┐                            │
│       │           │ 历史记录匹配    │                            │
│       │           │ 热门查询推荐    │                            │
│       │           │ 相关实体匹配    │                            │
│       │           └───────────────┘                            │
│       │                                                          │
│       ▼                                                          │
│  ┌─────────────┐                                                │
│  │  加载动画   │  ◀──── 搜索中...                              │
│  │  (Spin)    │                                                │
│  └─────────────┘                                                │
│       │                                                          │
│       ▼                                                          │
│  ┌─────────────┐                                                │
│  │  结果展示   │                                                │
│  │  • 实体    │                                                │
│  │  • 知识卡片│                                                │
│  │  • 主题摘要│                                                │
│  └─────────────┘                                                │
│       │                                                          │
│       ▼                                                          │
│  点击结果 ──> 跳转实体详情 ──> 查看关联                           │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### 18.7.2 Schema 编译流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    Schema 编译流程                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. 填写编译表单                                                  │
│     ├── 选择 SQL 文件或输入内容                                   │
│     ├── 选择目标表                                               │
│     └── 设置编译选项                                             │
│                         │                                        │
│                         ▼                                        │
│  2. 提交编译请求                                                  │
│     └── 返回 taskId，进入轮询状态                                │
│                         │                                        │
│                         ▼                                        │
│  3. 进度展示                                                      │
│     ┌─────────────────────────────────────────────────────────┐ │
│     │  [=====================>          ] 65%                  │ │
│     │  正在处理: sf_js_t (3/5)                                │ │
│     │  • customer         ✅ 完成                              │ │
│     │  • sf_js_t         ⏳ 处理中                            │ │
│     │  • pay_order       ⏳ 等待中                            │ │
│     └─────────────────────────────────────────────────────────┘ │
│                         │                                        │
│                         ▼                                        │
│  4. 编译完成                                                      │
│     ├── 展示编译结果                                              │
│     ├── 显示统计: 新增实体、卡片、矛盾                            │
│     └── 跳转到实体详情或刷新列表                                  │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

#### 18.7.3 矛盾处理流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    矛盾处理流程                                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  发现矛盾 ──> 查看矛盾详情                                         │
│                   │                                              │
│         ┌─────────┴─────────┐                                  │
│         ▼                   ▼                                   │
│  ┌─────────────┐     ┌─────────────┐                          │
│  │ 旧知识内容   │     │ 新证据内容   │                          │
│  │             │     │             │                          │
│  │ 置信度: 85% │     │ 置信度: 95% │                          │
│  │ 来源: 文档  │     │ 来源: Schema │                          │
│  └─────────────┘     └─────────────┘                          │
│         │                   │                                   │
│         └─────────┬─────────┘                                   │
│                   ▼                                             │
│         ┌─────────────────┐                                     │
│         │   影响分析      │                                     │
│         │ 影响 3 个 SQL   │                                     │
│         │ 生成查询        │                                     │
│         └────────┬────────┘                                     │
│                  │                                               │
│     ┌────────────┼────────────┐                                │
│     ▼            ▼            ▼                                 │
│  [接受新证据] [保留旧知识] [合并知识]                            │
│     │            │            │                                 │
│     ▼            ▼            ▼                                 │
│  更新卡片     标记保留    创建新卡片                             │
│  状态为NEW    状态为OLD    合并内容                               │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

### 18.8 动画与过渡效果

#### 18.8.1 页面切换动画

```tsx
// components/PageTransition/index.tsx
import React from 'react';
import { PageTransition } from '@ant-design/pro-components';
import type { RouteContextType } from '@ant-design/pro-layout';

interface WikiPageTransitionProps {
  children: React.ReactNode;
}

export const WikiPageTransition: React.FC<WikiPageTransitionProps> = ({ children }) => {
  return (
    <PageTransition
      pathname="/wiki"
      transitionName="slide-fade"
      transitionDuration={300}
      layoutDomRef={(props as any).layoutDomRef}
    >
      {children}
    </PageTransition>
  );
};
```

#### 18.8.2 卡片悬停效果

```tsx
// styles/entity-card.less
.entity-card {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  
  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(24, 144, 255, 0.15);
    
    .entity-icon {
      transform: scale(1.1);
    }
  }
  
  .entity-icon {
    transition: transform 0.3s ease;
  }
}

.knowledge-card {
  transition: all 0.25s ease;
  
  &:hover {
    border-left-width: 6px;
    background: #fafafa;
    
    .card-actions {
      opacity: 1;
    }
  }
  
  .card-actions {
    opacity: 0;
    transition: opacity 0.2s ease;
  }
}
```

#### 18.8.3 加载骨架屏

```tsx
// components/Skeleton/EntitySkeleton.tsx
import React from 'react';
import { Skeleton, Card, Space } from 'antd';

export const EntitySkeleton: React.FC = () => {
  return (
    <Card>
      <Space direction="vertical" size="large" style={{ width: '100%' }}>
        <Skeleton active paragraph={{ rows: 2 }} />
        
        <Skeleton.Button active style={{ width: 120 }} />
        
        <Space size="middle">
          {[1, 2, 3].map(i => (
            <Skeleton.Avatar key={i} active size="small" />
          ))}
        </Space>
        
        <Skeleton active paragraph={{ rows: 1 }} />
      </Space>
    </Card>
  );
};

export const KnowledgeCardSkeleton: React.FC = () => {
  return (
    <Card size="small">
      <Space direction="vertical" size="middle" style={{ width: '100%' }}>
        <Skeleton active paragraph={false}>
          <Skeleton.Button active style={{ width: 200 }} />
        </Skeleton>
        
        <Skeleton active paragraph={{ rows: 2 }} />
        
        <Skeleton active paragraph={false}>
          <Skeleton.Button active style={{ width: 100 }} />
        </Skeleton>
      </Space>
    </Card>
  );
};
```

#### 18.8.4 搜索框实时建议

```tsx
// components/Search/SearchInput.tsx
import React, { useState, useCallback, useEffect } from 'react';
import { Input, Spin, List, Typography, Tag } from 'antd';
import { SearchOutlined, HistoryOutlined, FileTextOutlined } from '@ant-design/icons';

const { Text } = Typography;

interface SearchSuggestion {
  type: 'history' | 'entity' | 'keyword';
  value: string;
  count?: number;
}

export const WikiSearchInput: React.FC<{
  onSearch: (value: string) => void;
  loading?: boolean;
}> = ({ onSearch, loading }) => {
  const [value, setValue] = useState('');
  const [suggestions, setSuggestions] = useState<SearchSuggestion[]>([]);
  const [showDropdown, setShowDropdown] = useState(false);

  useEffect(() => {
    if (value.length > 1) {
      const timer = setTimeout(async () => {
        const results = await fetchSuggestions(value);
        setSuggestions(results);
        setShowDropdown(true);
      }, 300);
      return () => clearTimeout(timer);
    } else {
      setSuggestions([]);
      setShowDropdown(false);
    }
  }, [value]);

  const handleSearch = useCallback((searchValue: string) => {
    setShowDropdown(false);
    onSearch(searchValue);
  }, [onSearch]);

  return (
    <div className="wiki-search-input">
      <Input.Search
        value={value}
        onChange={e => setValue(e.target.value)}
        onSearch={handleSearch}
        placeholder="搜索 Wiki 知识库..."
        size="large"
        loading={loading}
        prefix={<SearchOutlined />}
        suffix={
          loading ? <Spin size="small" /> : null
        }
        onFocus={() => value.length > 1 && setShowDropdown(true)}
        onBlur={() => setTimeout(() => setShowDropdown(false), 200)}
      />
      
      {showDropdown && suggestions.length > 0 && (
        <div className="search-dropdown">
          <List
            size="small"
            dataSource={suggestions}
            renderItem={item => (
              <List.Item
                onClick={() => handleSearch(item.value)}
                className="suggestion-item"
              >
                {item.type === 'history' && <HistoryOutlined />}
                {item.type === 'entity' && <FileTextOutlined />}
                <Text>{item.value}</Text>
                {item.count && <Tag>{item.count}</Tag>}
              </List.Item>
            )}
          />
        </div>
      )}
    </div>
  );
};
```

### 18.9 错误处理与空状态

#### 18.9.1 错误状态组件

```tsx
// components/ErrorState/index.tsx
import React from 'react';
import { Result, Button, Typography } from 'antd';
import { 
  CloseCircleOutlined, 
  ReloadOutlined,
  HomeOutlined 
} from '@ant-design/icons';

const { Paragraph, Text } = Typography;

interface ErrorStateProps {
  type: 'network' | 'server' | 'notFound' | 'permission';
  message?: string;
  description?: string;
  onRetry?: () => void;
}

const errorConfig = {
  network: {
    icon: <CloseCircleOutlined style={{ color: '#ff4d4f' }} />,
    title: '网络连接失败',
    description: '请检查您的网络连接后重试',
  },
  server: {
    icon: <CloseCircleOutlined style={{ color: '#ff4d4f' }} />,
    title: '服务器错误',
    description: '服务端出现问题，请稍后重试',
  },
  notFound: {
    icon: <CloseCircleOutlined style={{ color: '#faad14' }} />,
    title: '未找到相关结果',
    description: '请尝试其他关键词搜索',
  },
  permission: {
    icon: <CloseCircleOutlined style={{ color: '#faad14' }} />,
    title: '权限不足',
    description: '您没有权限访问该内容',
  },
};

export const ErrorState: React.FC<ErrorStateProps> = ({
  type,
  message,
  description,
  onRetry,
}) => {
  const config = errorConfig[type];

  return (
    <Result
      icon={config.icon}
      title={message || config.title}
      subTitle={description || config.description}
      extra={
        <Space>
          {onRetry && (
            <Button 
              type="primary" 
              icon={<ReloadOutlined />}
              onClick={onRetry}
            >
              重试
            </Button>
          )}
          <Button icon={<HomeOutlined />}>
            返回首页
          </Button>
        </Space>
      }
    />
  );
};
```

#### 18.9.2 空状态组件

```tsx
// components/EmptyState/index.tsx
import React from 'react';
import { Empty, Button, Space, Typography } from 'antd';
import { 
  SearchOutlined, 
  PlusOutlined, 
  FileTextOutlined,
  LinkOutlined
} from '@ant-design/icons';

const { Text } = Typography;

type EmptyType = 'search' | 'entity' | 'knowledge' | 'link' | 'contradiction';

interface EmptyStateProps {
  type: EmptyType;
  keyword?: string;
  onAction?: () => void;
}

const emptyConfig = {
  search: {
    icon: <SearchOutlined />,
    title: '未找到相关结果',
    description: (keyword: string) => `未找到与"${keyword}"相关的知识`,
    actionText: '清除搜索',
  },
  entity: {
    icon: <FileTextOutlined />,
    title: '暂无实体',
    description: '知识库中还没有实体，请先编译 Schema',
    actionText: '去编译',
  },
  knowledge: {
    icon: <FileTextOutlined />,
    title: '暂无知识卡片',
    description: '该实体还没有知识卡片，可以手动添加',
    actionText: '添加知识',
  },
  link: {
    icon: <LinkOutlined />,
    title: '暂无关联',
    description: '该实体还没有关联其他实体',
    actionText: null,
  },
  contradiction: {
    icon: <FileTextOutlined />,
    title: '暂无矛盾',
    description: '很好，没有检测到知识冲突',
    actionText: null,
  },
};

export const EmptyState: React.FC<EmptyStateProps> = ({
  type,
  keyword,
  onAction,
}) => {
  const config = emptyConfig[type];

  return (
    <Empty
      image={Empty.PRESENTED_IMAGE_SIMPLE}
      description={
        <Space direction="vertical" size="small">
          <Text strong>{config.title}</Text>
          <Text type="secondary">
            {typeof config.description === 'function' 
              ? config.description(keyword || '')
              : config.description}
          </Text>
        </Space>
      }
      extra={
        config.actionText && onAction && (
          <Button 
            type="primary" 
            icon={<PlusOutlined />}
            onClick={onAction}
          >
            {config.actionText}
          </Button>
        )
      }
    />
  );
};
```

### 18.10 响应式布局

#### 18.10.1 断点配置

```tsx
// styles/responsive.less
@screen-xs: 480px;
@screen-sm: 576px;
@screen-md: 768px;
@screen-lg: 992px;
@screen-xl: 1200px;
@screen-xxl: 1600px;
```

#### 18.10.2 响应式组件

```tsx
// components/Responsive/index.tsx
import React from 'react';
import { useBreakpoint } from 'ahooks';

interface ResponsiveProps {
  children: React.ReactNode;
  mode: 'xs' | 'sm' | 'md' | 'lg' | 'xl';
  render: (visible: boolean) => React.ReactNode;
}

export const Responsive: React.FC<ResponsiveProps> = ({ 
  children, 
  mode, 
  render 
}) => {
  const screens = useBreakpoint();

  const getVisible = () => {
    const breakpoints: Record<string, string[]> = {
      xs: ['xs'],
      sm: ['xs', 'sm'],
      md: ['xs', 'sm', 'md'],
      lg: ['xs', 'sm', 'md', 'lg'],
      xl: ['xs', 'sm', 'md', 'lg', 'xl'],
    };
    return breakpoints[mode].some(bp => screens[bp]);
  };

  return <>{render(getVisible())}</>;
};

// 使用示例
const EntityList: React.FC = () => {
  return (
    <div className="entity-grid">
      <Responsive mode="md" render={(visible) => 
        visible ? <CardGrid /> : null
      } />
      <Responsive mode="lg" render={(visible) => 
        visible ? <Sidebar /> : null
      } />
    </div>
  );
};
```

#### 18.10.3 移动端适配

```tsx
// components/Mobile/wiki.tsx
import React, { useState } from 'react';
import { 
  MobileNavBar, 
  SwipeAction, 
  List, 
  Card,
  SearchBar,
  Segmented
} from 'antd-mobile';

export const WikiMobileHome: React.FC = () => {
  const [activeTab, setActiveTab] = useState<'entity' | 'search' | 'more'>('entity');

  return (
    <div className="wiki-mobile">
      <MobileNavBar>LLM-SQL-Wiki</MobileNavBar>
      
      <SearchBar 
        placeholder="搜索知识..." 
        onSearch={(val) => handleSearch(val)}
      />

      <Segmented 
        values={['entity', 'search', 'more']}
        onChange={setActiveTab}
      />

      <List>
        <SwipeAction
          rightActions={[
            { text: '编辑', color: 'primary' },
            { text: '删除', color: 'danger' },
          ]}
        >
          <List.Item
            prefix={<DatabaseOutlined />}
            description="用户信息表"
            extra="12 字段"
            onClick={() => navigateToEntity('table:customer')}
          >
            customer
          </List.Item>
        </SwipeAction>
      </List>
    </div>
  );
};
```

### 18.11 快捷键支持

#### 18.11.1 全局快捷键

```tsx
// hooks/useWikiShortcuts.ts
import { useEffect } from 'react';
import { useNavigate } from 'umi';
import { message } from 'antd';

export const useWikiShortcuts = () => {
  const navigate = useNavigate();

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      const isMac = navigator.platform.toUpperCase().indexOf('MAC') >= 0;
      const ctrlKey = isMac ? e.metaKey : e.ctrlKey;

      if (ctrlKey && e.key === 'k') {
        e.preventDefault();
        document.querySelector<HTMLInputElement>('.wiki-search input')?.focus();
      }

      if (e.key === 'Escape') {
        const modal = document.querySelector('.ant-modal');
        if (modal) {
          modal.remove();
        }
      }

      if (ctrlKey && e.shiftKey && e.key === 'N') {
        e.preventDefault();
        navigate('/wiki/compiler');
      }

      if (ctrlKey && e.shiftKey && e.key === 'S') {
        e.preventDefault();
        message.info('保存成功');
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [navigate]);
};
```

#### 18.11.2 快捷键提示

```tsx
// components/ShortcutHint/index.tsx
import React from 'react';
import { Tag, Typography } from 'antd';

const { Text } = Typography;

interface ShortcutHintProps {
  shortcuts: Array<{
    key: string;
    description: string;
  }>;
}

export const ShortcutHint: React.FC<ShortcutHintProps> = ({ shortcuts }) => {
  const isMac = navigator.platform.toUpperCase().indexOf('MAC') >= 0;

  return (
    <div className="shortcut-hints">
      <Text type="secondary">快捷键:</Text>
      {shortcuts.map(({ key, description }) => (
        <Tag key={key}>
          {isMac ? key.replace('Ctrl', '⌘') : key}
          {' '}
          {description}
        </Tag>
      ))}
    </div>
  );
};

// 使用
<ShortcutHint 
  shortcuts={[
    { key: 'Ctrl+K', description: '搜索' },
    { key: 'Ctrl+Shift+N', description: '编译' },
    { key: 'Ctrl+S', description: '保存' },
  ]}
/>
```

### 18.12 数据导出功能

#### 18.12.1 导出组件

```tsx
// components/ExportButton/index.tsx
import React, { useState } from 'react';
import { Dropdown, Button, Menu, message } from 'antd';
import { DownloadOutlined } from '@ant-design/icons';
import { exportToExcel, exportToJson, exportToCsv } from '@/utils/export';

interface ExportButtonProps {
  data: any[];
  filename: string;
  disabled?: boolean;
}

export const ExportButton: React.FC<ExportButtonProps> = ({
  data,
  filename,
  disabled
}) => {
  const [loading, setLoading] = useState(false);

  const handleExport = async (format: 'xlsx' | 'json' | 'csv') => {
    setLoading(true);
    try {
      switch (format) {
        case 'xlsx':
          await exportToExcel(data, filename);
          break;
        case 'json':
          await exportToJson(data, filename);
          break;
        case 'csv':
          await exportToCsv(data, filename);
          break;
      }
      message.success(`导出 ${format.toUpperCase()} 成功`);
    } catch (error) {
      message.error('导出失败');
    } finally {
      setLoading(false);
    }
  };

  return (
    <Dropdown
      overlay={
        <Menu>
          <Menu.Item 
            key="xlsx"
            onClick={() => handleExport('xlsx')}
            icon={<FileExcelOutlined />}
          >
            导出为 Excel (.xlsx)
          </Menu.Item>
          <Menu.Item 
            key="csv"
            onClick={() => handleExport('csv')}
            icon={<FileTextOutlined />}
          >
            导出为 CSV (.csv)
          </Menu.Item>
          <Menu.Item 
            key="json"
            onClick={() => handleExport('json')}
            icon={<FileJsonOutlined />}
          >
            导出为 JSON (.json)
          </Menu.Item>
        </Menu>
      }
      disabled={disabled || loading}
    >
      <Button icon={<DownloadOutlined />} loading={loading}>
        导出
      </Button>
    </Dropdown>
  );
};
```

---

## 十九、后续扩展

> **详细开发计划请参见**: [LLM-SQL-Wiki开发计划.md](./LLM-SQL-Wiki开发计划.md)

### 19.1 短期扩展

| 功能 | 优先级 | 预估工时 | 依赖 |
|------|--------|----------|------|
| 实体关系图可视化 | P1 | 3天 | 基础服务 |
| 知识卡片编辑 | P1 | 2天 | 基础服务 |
| 矛盾处理工作流 | P2 | 3天 | Phase 1 |
| 摘要自动刷新 | P2 | 2天 | Phase 1 |

### 19.2 长期规划

| 功能 | 优先级 | 预估工时 | 依赖 |
|------|--------|----------|------|
| 多数据源支持 | P1 | 5天 | Phase 1+2 |
| 知识图谱查询 | P2 | 4天 | Phase 1 |
| 自动 SQL 验证 | P2 | 3天 | Phase 2 |
| 对话式知识管理 | P3 | 5天 | Phase 1+2+3 |

### 19.3 里程碑

| 里程碑 | 完成内容 | 目标周期 |
|--------|----------|----------|
| M1 | Phase 1 核心功能 | +6天 |
| M2 | Phase 2 工作流 | +12天 |
| M3 | Phase 3 增强功能 | +20天 |
| M4 | Phase 4 高级功能 | +26天 |

---

## 附录

### A. 更新记录

| 日期 | 版本 | 更新内容 |
|------|------|----------|
| 2026-04-17 | 1.0 | 初始版本 |

### B. 参考资料

- [LangChain4j 文档](https://docs.langchain4j.ai/)
- [pgvector 使用指南](https://github.com/pgvector/pgvector)
- [Obsidian 双链笔记概念](https://obsidian.md/)
- [Roam Research](https://roamresearch.com/)
