# Wiki 知识卡片 AI 自动生成功能设计

> **日期:** 2026-04-20
> **模块:** Wiki 知识库 - 知识卡片编辑
> **状态:** 设计完成，等待实现

## 1. 背景与目标

用户需要在 Wiki 知识库的知识卡片新建编辑框中，通过大模型实时自动生成填充内容，减少手动输入工作量。

**目标:**
- 用户在知识卡片编辑框中选择实体、输入标题或选择卡片类型时，自动触发大模型生成内容
- 生成内容填充到所有字段（cardType、title、content、confidence、tags、extractedFrom）
- 生成失败时静默处理，不影响用户手动编辑

## 2. 系统现状

### 已有能力

| 组件 | 能力 | 位置 |
|------|------|------|
| `WikiKnowledgeCard` | 知识卡片数据模型 | `headless-core/.../wiki/dto/` |
| `WikiController` | 知识卡片 CRUD API | `headless-core/.../wiki/` |
| `KnowledgeCardSection.tsx` | 知识卡片前端编辑组件 | `webapp/.../Wiki/components/` |
| `ModelProvider` | LLM 统一接入（支持 Ollama/OpenAI 等） | `common/.../langchain4j/provider/` |
| `WikiEntityService` | 获取 Entity 详细信息 | `headless-core/.../wiki/service/` |

### 当前缺失

1. **后端**: 没有根据上下文信息（实体、Schema、卡片类型）生成知识卡片内容的 API
2. **前端**: 没有在编辑框中调用生成接口并自动填充的逻辑

## 3. 设计方案

### 3.1 后端 API 设计

#### 3.1.1 生成知识卡片内容接口

```
POST /api/wiki/knowledge/generate
```

**请求体:**
```json
{
  "entityId": "entity_123",
  "cardType": "RELATIONSHIP",
  "title": "用户与订单的关系"
}
```

**响应:**
```json
{
  "success": true,
  "data": {
    "title": "用户与订单的关系",
    "cardType": "RELATIONSHIP",
    "content": "{\"description\": \"一个用户可以有多个订单，每个订单属于一个用户\", \"cardinality\": \"1:N\"}",
    "confidence": 0.85,
    "tags": ["用户", "订单", "关系"],
    "extractedFrom": ["实体: user", "实体: order"]
  }
}
```

**content 字段格式说明:**
| cardType | content 结构 |
|----------|--------------|
| RELATIONSHIP | `{description, cardinality}` |
| BUSINESS_RULE | `{rule, condition, action}` |
| DATA_PATTERN | `{pattern, frequency, example}` |
| USAGE_PATTERN | `{scenario, steps,注意事项}` |
| SEMANTIC_MAPPING | `{source, target, mappingRule}` |
| METRIC_DEFINITION | `{metricName, formula, unit, description}` |

#### 3.1.2 获取实体 Schema 信息

后端需要能够根据 entityId 获取：
1. 实体基本信息（名称、描述）
2. 实体的所有字段（字段名、类型、描述）
3. 与该实体关联的其他实体信息

### 3.2 前端流程设计

#### 3.2.1 编辑框交互流程

```
用户点击「新建知识卡片」
    ↓
弹出编辑 Modal
    ↓
用户选择关联实体（下拉选择） + 选择卡片类型/输入标题
    ↓
触发条件满足（实体已选 + 标题已输入 或 卡片类型已选）
    ↓
前端调用 POST /api/wiki/knowledge/generate
    ↓
返回结果 → 自动填充到表单
    ↓
用户可手动修改或直接保存
```

**触发时机:**
- 用户选择实体 + 输入标题后立即触发
- 或用户选择实体 + 选择卡片类型后立即触发
- 防抖处理：输入完成后 500ms 再触发

**实体选择下拉框:**
- 显示实体名称（displayName）
- 支持搜索过滤

### 3.3 后端处理逻辑

#### 3.3.1 生成逻辑流程

```java
public KnowledgeCardGenerateResp generate(KnowledgeCardGenerateReq req) {
    // 1. 获取实体信息
    WikiEntity entity = wikiEntityService.getEntity(req.getEntityId());

    // 2. 获取实体的 Schema 信息（字段、关联）
    EntitySchema schema = wikiEntityService.getEntitySchema(req.getEntityId());

    // 3. 构建 Prompt
    String prompt = buildPrompt(req, entity, schema);

    // 4. 调用 LLM 生成
    ChatLanguageModel model = ModelProvider.getChatModel(modelConfig);
    String response = model.generate(prompt);

    // 5. 解析响应
    return parseAndBuildResp(response, req);
}
```

#### 3.3.2 Prompt 构建示例

```
你是一个知识卡片生成助手。请根据以下信息生成知识卡片内容。

## 实体信息
- 名称: user
- 描述: 用户信息表，记录用户的基本信息

## 实体字段
- id: 用户ID (主键)
- name: 用户姓名 (varchar)
- email: 邮箱地址 (varchar)
- created_at: 创建时间 (timestamp)

## 关联实体
- order: 一个用户可以有多个订单 (1:N)

## 卡片类型
RELATIONSHIP

## 标题
用户与订单的关系

请生成一个知识卡片，内容包含：
1. title: 标题（可直接使用提供的标题）
2. cardType: 卡片类型
3. content: JSON格式，描述关系细节
4. confidence: 置信度 (0-1之间的小数)
5. tags: 标签列表
6. extractedFrom: 内容来源

只返回JSON格式，不要包含其他文字。
```

### 3.4 LLM 选择策略

- 复用现有的 `ModelProvider` 体系
- 使用默认配置的 LLM（可在配置文件中指定模型）
- 生成失败时捕获异常，返回 null（静默处理）

## 4. 接口清单

| 方法 | 路径 | 说明 |
|------|------|------|
| POST | `/api/wiki/knowledge/generate` | 生成知识卡片内容 |

## 5. 前端改动点

| 文件 | 改动内容 |
|------|----------|
| `KnowledgeCardSection.tsx` | 新增实体选择下拉框、防抖逻辑、调用生成 API、自动填充表单 |
| `wiki.ts` | 新增 `generateKnowledgeCard` API 调用 |

## 6. 后端改动点

| 文件 | 改动内容 |
|------|----------|
| `WikiController.java` | 新增 `POST /api/wiki/knowledge/generate` 接口 |
| `WikiKnowledgeService.java` | 新增 `generateKnowledgeCard` 方法 |
| 新建 `KnowledgeCardPromptBuilder.java` | Prompt 构建逻辑 |
| 新建 `KnowledgeCardRespParser.java` | LLM 响应解析 |

## 7. 测试用例

1. **正常生成**: 选择实体 → 输入标题 → 自动生成 → 内容填充正确
2. **生成失败**: LLM 服务不可用 → 静默处理 → 用户可手动编辑
3. **仅选卡片类型**: 选择实体 + 卡片类型（无标题）→ 生成内容
4. **防抖验证**: 快速输入 → 只触发一次生成

## 8. 技术要点

- 前端使用 Ant Design Select 组件作为实体选择器
- 防抖使用 lodash.debounce 或自定义实现
- 后端 LLM 调用复用现有 ModelProvider，不重复造轮子
- JSON 响应解析需处理格式不稳定的情况
