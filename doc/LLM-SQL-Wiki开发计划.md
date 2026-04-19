# LLM-SQL-Wiki 开发计划

> 本开发计划基于 `LLM-SQL-Wiki技术方案.md`，将后续扩展功能分解为可执行的开发任务。

## 一、功能优先级总览

| 阶段 | 功能 | 优先级 | 工作量 | 依赖 |
|------|------|--------|--------|------|
| **Phase 1** | 实体关系图可视化 | P1 | 3天 | 基础服务 |
| **Phase 1** | 知识卡片编辑 | P1 | 2天 | 基础服务 |
| **Phase 2** | 矛盾处理工作流 | P2 | 3天 | Phase 1 |
| **Phase 2** | 摘要自动刷新 | P2 | 2天 | Phase 1 |
| **Phase 3** | 多数据源支持 | P1 | 5天 | Phase 1+2 |
| **Phase 3** | 知识图谱查询 | P2 | 4天 | Phase 1 |
| **Phase 3** | 自动 SQL 验证 | P2 | 3天 | Phase 2 |
| **Phase 4** | 对话式知识管理 | P3 | 5天 | Phase 1+2+3 |

---

## 二、Phase 1：核心功能开发

### 2.1 实体关系图可视化

**功能描述**: Web 端展示实体关系网络，支持拖拽、缩放、节点点击等交互

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T1.1.1 | 后端图数据 API 开发 | 0.5天 | 后端 |
| T1.1.2 | Graph组件基础实现（@antv/g6） | 1天 | 前端 |
| T1.1.3 | 节点渲染（表实体、字段实体、主题） | 0.5天 | 前端 |
| T1.1.4 | 边渲染（外键关系、语义关系） | 0.5天 | 前端 |
| T1.1.5 | 缩放、拖拽、画布操作 | 0.5天 | 前端 |

**后端 API**:

```java
// WikiGraphController.java
GET /api/wiki/graph/nodes
GET /api/wiki/graph/edges
GET /api/wiki/graph/entity/{entityId}/neighbors
```

**前端组件**:

```
Wiki/
└── components/
    └── Graph/
        ├── EntityGraph.tsx        // 主图组件
        ├── GraphToolbar.tsx       // 工具栏
        ├── NodeDetail.tsx          // 节点详情
        └── GraphFilters.tsx         // 筛选器
```

**验收标准**:
- [x] 能展示所有表实体及其外键关系
- [x] 点击节点显示详情
- [x] 支持缩放、拖拽
- [x] 支持按实体类型筛选

**实际完成情况** (2026-04-17):
- ✅ 已创建数据库表结构 (s2_wiki_entity, s2_wiki_entity_link, s2_wiki_knowledge_card, s2_wiki_topic_summary, s2_wiki_contradiction, s2_wiki_evidence)
- ✅ 已实现 WikiController (GET /api/wiki/graph/nodes, /api/wiki/graph/edges, /api/wiki/graph/entity/{entityId}/neighbors)
- ✅ 已实现 WikiEntityService, WikiLinkService, WikiGraphService
- ✅ 已创建前端 EntityGraph 组件，支持 Canvas 绑图渲染、节点点击、缩放拖拽、类型筛选
- ✅ 已创建 WikiInitializer，自动初始化示例数据

---

### 2.2 知识卡片编辑

**功能描述**: 支持手动编辑/补充知识卡片内容

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T1.2.1 | 知识卡片 CRUD API | 0.5天 | 后端 |
| T1.2.2 | 知识卡片编辑表单组件 | 0.5天 | 前端 |
| T1.2.3 | 知识卡片创建弹窗 | 0.5天 | 前端 |
| T1.2.4 | 卡片类型选择器 | 0.25天 | 前端 |
| T1.2.5 | 置信度设置组件 | 0.25天 | 前端 |

**后端 API**:

```java
// WikiKnowledgeController.java
GET    /api/wiki/knowledge/{cardId}
POST   /api/wiki/knowledge
PUT    /api/wiki/knowledge/{cardId}
DELETE /api/wiki/knowledge/{cardId}
```

**前端组件**:

```
Wiki/
└── components/
    └── KnowledgeCard/
        ├── KnowledgeCard.tsx       // 展示组件
        ├── KnowledgeCardEdit.tsx    // 编辑组件
        ├── KnowledgeCardForm.tsx    // 表单
        ├── CardTypeSelect.tsx       // 类型选择
        └── ConfidenceSlider.tsx    // 置信度滑块
```

**验收标准**:
- [x] 能查看现有知识卡片
- [x] 能编辑卡片内容、类型、标签
- [x] 能新建知识卡片
- [x] 能删除知识卡片
- [ ] 编辑后自动更新向量

**实际完成情况** (2026-04-17):
- ✅ 已实现知识卡片 CRUD API (GET, POST, PUT, DELETE /api/wiki/knowledge)
- ✅ 已创建前端 KnowledgeCardSection 组件，支持卡片列表展示、创建、编辑、删除
- ✅ 已实现卡片类型选择器 (RELATIONSHIP, BUSINESS_RULE, DATA_PATTERN 等)
- ✅ 已实现置信度滑块设置组件

---

## 三、Phase 2：工作流功能

### 3.1 矛盾处理工作流

**功能描述**: 人工审核矛盾并做出决策（接受新证据/保留旧知识/合并）

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T2.1.1 | 矛盾列表 API（含筛选） | 0.5天 | 后端 |
| T2.1.2 | 矛盾详情 API | 0.5天 | 后端 |
| T2.1.3 | 矛盾解决 API | 0.5天 | 后端 |
| T2.1.4 | 矛盾列表页面 | 0.5天 | 前端 |
| T2.1.5 | 矛盾详情抽屉/弹窗 | 0.5天 | 前端 |
| T2.1.6 | 解决操作组件 | 0.5天 | 前端 |

**后端 API**:

```java
// WikiContradictionController.java
GET    /api/wiki/contradictions
GET    /api/wiki/contradictions/{contradictionId}
POST   /api/wiki/contradictions/{contradictionId}/resolve
POST   /api/wiki/contradictions/{contradictionId}/evidence
```

**前端组件**:

```
Wiki/
└── components/
    └── Contradiction/
        ├── ContradictionList.tsx       // 列表页
        ├── ContradictionDetail.tsx      // 详情
        ├── ResolveModal.tsx              // 解决弹窗
        ├── EvidenceCompare.tsx          // 对比组件
        └── ImpactAnalysis.tsx            // 影响分析
```

**验收标准**:
- [x] 能查看所有矛盾列表
- [x] 能筛选矛盾（按类型、状态）
- [x] 能查看矛盾详情（旧知识 vs 新证据）
- [x] 能执行三种解决操作
- [ ] 解决后自动更新相关卡片状态

**实际完成情况** (2026-04-17):
- ✅ 已实现 WikiContradictionService
- ✅ 已实现矛盾列表 API (GET /api/wiki/contradictions, /api/wiki/contradictions/pending)
- ✅ 已实现矛盾详情 API (GET /api/wiki/contradictions/{id})
- ✅ 已实现矛盾解决 API (POST /api/wiki/contradictions/{id}/resolve)
- ✅ 已创建前端 ContradictionSection 组件，支持列表展示、筛选、详情查看、解决操作

---

### 3.2 摘要自动刷新

**功能描述**: 定时更新主题摘要，或在实体变更时触发更新

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T2.2.1 | 主题摘要生成服务 | 1天 | 后端 |
| T2.2.2 | 定时任务配置 | 0.5天 | 后端 |
| T2.2.3 | 摘要手动刷新按钮 | 0.25天 | 前端 |
| T2.2.4 | 摘要版本历史 | 0.25天 | 前端 |

**后端服务**:

```java
// TopicSummaryService.java
public void refreshSummary(String topicId);
public List<TopicSummary> getSummaryHistory(String topicId);
public String generateSummary(String topicId);

// Scheduler 配置
@Scheduled(cron = "0 0 2 * * ?") // 每天凌晨2点
public void scheduledSummaryRefresh() { ... }
```

**前端组件**:

```
Wiki/
└── components/
    └── TopicPage/
        ├── TopicSummary.tsx          // 摘要展示
        ├── SummaryVersion.tsx          // 版本历史
        └── RefreshButton.tsx          // 刷新按钮
```

**验收标准**:
- [x] 能手动刷新主题摘要
- [x] 定时任务自动刷新
- [x] 实体变更触发自动刷新
- [x] 显示摘要版本历史

**实际完成情况** (2026-04-17):
- ✅ 已实现 WikiSummaryService
- ✅ 已实现摘要 API (GET /api/wiki/summaries, /api/wiki/summaries/{topicId}/history)
- ✅ 已实现刷新 API (POST /api/wiki/summaries/{topicId}/refresh, /api/wiki/summaries/refresh-all)
- ✅ 已创建 WikiScheduler 定时任务配置（每天凌晨2点自动刷新）
- ✅ 已创建前端 SummarySection 组件，支持摘要展示、刷新、历史查看

---

## 四、Phase 3：增强功能

### 4.1 多数据源支持

**功能描述**: 支持跨数据库的知识整合，配置多个数据源

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T3.1.1 | 数据源配置实体和服务 | 1天 | 后端 |
| T3.1.2 | 多数据源 Schema 解析器 | 1天 | 后端 |
| T3.1.3 | 数据源管理页面 | 1天 | 前端 |
| T3.1.4 | 数据源切换组件 | 0.5天 | 前端 |
| T3.1.5 | 跨源知识关联 | 1天 | 后端 |
| T3.1.6 | 跨源搜索 | 0.5天 | 后端 |

**后端服务**:

```java
// DataSourceService.java
public DataSourceConfig create(DataSourceConfig config);
public List<DataSourceConfig> list();
public void delete(Long id);
public void testConnection(Long id);

// MultiSourceSchemaParser.java
public List<TableSchema> parseFromSource(Long dataSourceId);
```

**前端组件**:

```
Wiki/
└── components/
    └── DataSource/
        ├── DataSourceList.tsx         // 列表
        ├── DataSourceForm.tsx         // 表单
        ├── DataSourceTest.tsx         // 连接测试
        └── DataSourceSwitch.tsx        // 切换组件
```

**验收标准**:
- [x] 能添加多个数据源
- [x] 能测试连接
- [x] 能从不同数据源编译 Schema
- [ ] 搜索能跨数据源

**实际完成情况** (2026-04-17):
- ✅ 已实现 WikiDataSourceService
- ✅ 已实现数据源 CRUD API (GET/POST/PUT/DELETE /api/wiki/datasources)
- ✅ 已实现连接测试 API (POST /api/wiki/datasources/{id}/test)
- ✅ 已实现 Schema 解析 API (POST /api/wiki/datasources/{id}/parse-schema)
- ✅ 支持 MySQL 和 PostgreSQL 数据源

---

### 4.2 知识图谱查询

**功能描述**: 支持图数据库查询，实现更复杂的关系推理

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T3.2.1 | 图查询服务设计 | 1天 | 后端 |
| T3.2.2 | 路径查询 API | 1天 | 后端 |
| T3.2.3 | 图可视化增强 | 1天 | 前端 |
| T3.2.4 | 路径高亮显示 | 0.5天 | 前端 |
| T3.2.5 | 图查询语法高亮 | 0.5天 | 前端 |

**后端 API**:

```java
// GraphQueryController.java
POST /api/wiki/graph/query
GET  /api/wiki/graph/path?from={entityId}&to={entityId}
GET  /api/wiki/graph/neighbors/{entityId}?depth={n}
```

**验收标准**:
- [x] 支持查询两个实体间的路径
- [ ] 能在图上高亮显示路径
- [x] 支持 N 度关联查询

**实际完成情况** (2026-04-17):
- ✅ 已实现 WikiGraphQueryService
- ✅ 已实现最短路径查询 API (GET /api/wiki/graph/path)
- ✅ 已实现邻居查询 API (GET /api/wiki/graph/neighbors/{entityId})
- ✅ 已实现图查询 API (POST /api/wiki/graph/query)
- ✅ 支持 PostgreSQL 递归 CTE 实现路径查询

---

### 4.3 自动 SQL 验证

**功能描述**: 用样本数据验证生成的 SQL 是否正确

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T3.3.1 | SQL 验证服务 | 1天 | 后端 |
| T3.3.2 | 样本数据采样器 | 0.5天 | 后端 |
| T3.3.3 | 验证结果存储 | 0.5天 | 后端 |
| T3.3.4 | 验证结果展示 | 0.5天 | 前端 |
| T3.3.5 | 验证历史 | 0.5天 | 前端 |

**后端服务**:

```java
// SqlValidationService.java
public ValidationResult validate(String sql, String entityId);
public List<ValidationResult> getHistory(Long entityId);

// ValidationResult.java
{
  "sql": "...",
  "status": "VALID|INVALID|SYNTAX_ERROR",
  "executionTime": 125,
  "rowCount": 42,
  "errorMessage": null,
  "sampleData": [...],
  "validatedAt": "2026-04-17T10:00:00Z"
}
```

**验收标准**:
- [x] 能验证 SQL 语法正确性
- [x] 能执行 SQL 验证语义正确性
- [x] 能展示验证结果和样本数据
- [x] 验证失败时提供错误信息

**实际完成情况** (2026-04-17):
- ✅ 已实现 WikiSqlValidationService
- ✅ 已实现 SQL 验证 API (POST /api/wiki/sql/validate)
- ✅ 已实现验证历史 API (GET /api/wiki/sql/history/{entityId})
- ✅ 支持语法错误和语义错误检测
- ✅ 返回执行时间、行数和样本数据

---

## 五、Phase 4：高级功能

### 5.1 对话式知识管理

**功能描述**: 通过对话增删改知识，支持自然语言交互

**任务分解**:

| 任务 | 描述 | 预估工时 | 后端/前端 |
|------|------|----------|-----------|
| T4.1.1 | 对话管理后端服务 | 1天 | 后端 |
| T4.1.2 | 对话上下文管理 | 0.5天 | 后端 |
| T4.1.3 | 意图识别 | 1天 | 后端 |
| T4.1.4 | 对话式知识编辑 | 1天 | 前端 |
| T4.1.5 | 对话式知识查询 | 1天 | 前端 |
| T4.1.6 | 对话历史管理 | 0.5天 | 前端 |

**后端服务**:

```java
// ChatKnowledgeService.java
public ChatResponse chat(String userId, String message);
public List<ChatMessage> getHistory(String conversationId);

// 意图类型
enum KnowledgeIntent {
  CREATE_CARD,      // 创建知识卡片
  UPDATE_CARD,      // 更新知识卡片
  DELETE_CARD,      // 删除知识卡片
  QUERY_KNOWLEDGE,  // 查询知识
  EXPLAIN_ENTITY,   // 解释实体
  SUGGEST_RELATION  // 建议关系
}
```

**前端组件**:

```
Wiki/
└── components/
    └── ChatKnowledge/
        ├── ChatPanel.tsx              // 对话面板
        ├── ChatMessage.tsx            // 消息组件
        ├── KnowledgeAction.tsx         // 知识操作
        └── ChatHistory.tsx            // 历史记录
```

**验收标准**:
- [x] 能通过对话创建知识卡片
- [ ] 能通过对话更新知识卡片
- [x] 能通过对话查询知识
- [x] 支持多轮对话上下文

**实际完成情况** (2026-04-17):
- ✅ 已实现 ChatMessage DTO
- ✅ 已实现 WikiChatService
- ✅ 已实现意图识别 (CREATE_CARD, UPDATE_CARD, DELETE_CARD, QUERY_KNOWLEDGE, EXPLAIN_ENTITY, SUGGEST_RELATION)
- ✅ 已实现对话 API (POST /api/wiki/chat, GET /api/wiki/chat/history/{conversationId}, GET /api/wiki/chat/recent)
- ✅ 支持创建知识卡片、查询实体信息

---

## 六、技术债务与基础设施

### 6.1 必须完成的前置任务

| 任务 | 描述 | 工时 | 优先级 |
|------|------|------|--------|
| T0.1 | 数据库表结构创建 | 0.5天 | P0 |
| T0.2 | 基础服务层开发 | 2天 | P0 |
| T0.3 | 单元测试覆盖 | 1天 | P1 |
| T0.4 | API 文档生成 | 0.5天 | P1 |
| T0.5 | 前端项目脚手架 | 0.5天 | P0 |

### 6.2 数据库初始化 SQL

```sql
-- 实体表
CREATE TABLE s2_wiki_entity (...);
CREATE INDEX idx_entity_type ON s2_wiki_entity(entity_type);
CREATE INDEX idx_topic ON s2_wiki_entity(topic_id);

-- 链接表
CREATE TABLE s2_wiki_entity_link (...);
CREATE INDEX idx_link_source ON s2_wiki_entity_link(source_entity_id);
CREATE INDEX idx_link_target ON s2_wiki_entity_link(target_entity_id);

-- 知识卡片表
CREATE TABLE s2_wiki_knowledge_card (...);
CREATE INDEX idx_card_entity ON s2_wiki_knowledge_card(entity_id);
CREATE INDEX idx_card_embedding ON s2_wiki_knowledge_card USING ivfflat (embedding vector_cosine_ops);

-- 主题摘要表
CREATE TABLE s2_wiki_topic_summary (...);

-- 矛盾表
CREATE TABLE s2_wiki_contradiction (...);
CREATE INDEX idx_contradiction_status ON s2_wiki_contradiction(resolution);

-- 数据源配置表（新增）
CREATE TABLE s2_wiki_datasource (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    type VARCHAR(32) NOT NULL,
    host VARCHAR(256),
    port INT,
    database_name VARCHAR(128),
    username VARCHAR(64),
    password_encrypted VARCHAR(256),
    properties JSONB,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 对话历史表（新增）
CREATE TABLE s2_wiki_chat_history (
    id BIGSERIAL PRIMARY KEY,
    conversation_id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NOT NULL,
    message TEXT NOT NULL,
    intent VARCHAR(32),
    response TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_chat_conversation ON s2_wiki_chat_history(conversation_id);
```

---

## 七、里程碑计划

| 里程碑 | 完成内容 | 目标日期 |
|--------|----------|----------|
| **M1** | Phase 1 核心功能 | +6天 |
| **M2** | Phase 2 工作流 | +12天 |
| **M3** | Phase 3 增强功能 | +20天 |
| **M4** | Phase 4 高级功能 | +26天 |

---

## 八、风险与依赖

| 风险 | 影响 | 缓解措施 |
|------|------|----------|
| 图数据库选型不确定 | 高 | 先用 PostgreSQL 递归 CTE 实现 |
| LLM 调用成本 | 中 | 做好缓存和限流 |
| 性能问题（向量检索） | 中 | 提前做性能测试 |

---

## 九、任务分配（示例）

| 开发人员 | 负责模块 |
|----------|----------|
| 后端开发A | 实体服务、编译服务、图查询 |
| 后端开发B | 知识卡片、矛盾处理、数据源 |
| 前端开发A | Graph组件、搜索、关系图 |
| 前端开发B | 编辑表单、工作流、对话 |

---

## 十、更新记录

| 日期 | 版本 | 更新内容 | 修改人 |
|------|------|----------|--------|
| 2026-04-17 | 1.0 | 初始版本 | - |
| 2026-04-17 | 1.1 | Phase 1 核心功能开发完成：<br/>- 数据库表结构 (s2_wiki_* 6张表)<br/>- 后端: WikiEntityService, WikiKnowledgeService, WikiLinkService, WikiGraphService, WikiController<br/>- 前端: Wiki 页面, EntityGraph, EntityListSection, KnowledgeCardSection<br/>- WikiInitializer 自动初始化示例数据 | AI Assistant |
| 2026-04-17 | 1.2 | Phase 2 工作流功能开发完成：<br/>- 矛盾检测服务 WikiContradictionService<br/>- 矛盾列表/详情/解决 API<br/>- 矛盾处理前端组件 ContradictionSection<br/>- 主题摘要服务 WikiSummaryService<br/>- 摘要 API 和定时任务 WikiScheduler<br/>- 摘要前端组件 SummarySection | AI Assistant |
| 2026-04-17 | 1.3 | Phase 3 增强功能开发完成：<br/>- 数据源服务 WikiDataSourceService (MySQL/PostgreSQL)<br/>- 数据源 CRUD 和连接测试 API<br/>- 图查询服务 WikiGraphQueryService (最短路径、N度关联)<br/>- SQL 验证服务 WikiSqlValidationService | AI Assistant |
| 2026-04-17 | 1.4 | Phase 4 对话式知识管理开发完成：<br/>- ChatMessage DTO<br/>- WikiChatService 对话服务<br/>- 意图识别 (CREATE_CARD, QUERY_KNOWLEDGE 等)<br/>- 对话 API (/api/wiki/chat) | AI Assistant |
