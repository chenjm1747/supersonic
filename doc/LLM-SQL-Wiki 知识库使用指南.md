# LLM-SQL-Wiki 知识库使用指南

## 一、系统概述

LLM-SQL-Wiki 是 SuperSonic 的知识库模块，用于管理文本到 SQL 转换所需的 schema 知识、元数据信息。它包含以下核心概念：

| 概念 | 说明 |
|------|------|
| **实体 (Entity)** | 表（TABLE）、字段（COLUMN）、主题（TOPIC）的统称 |
| **主题 (Topic)** | 用于将相关的表分组管理 |
| **知识卡片 (Knowledge Card)** | 附加在实体上的业务知识、元数据描述 |
| **关系图 (Entity Graph)** | 展示主题与表的层级关系 |

## 二、实体类型

### 2.1 表 (TABLE)

- **name**: 表名，通常与数据库表名一致
- **displayName**: 显示名称，用于前端展示
- **description**: 表的描述信息
- **properties**: 扩展属性，存储 JSON 格式的额外信息
- **parentEntityId**: 父实体ID（字段所属的表）
- **topicId**: 所属主题ID

### 2.2 字段 (COLUMN)

- **name**: 字段名，与数据库列名一致
- **displayName**: 显示名称
- **columnType**: 字段类型（来自 properties）
- **parentEntityId**: 所属表的 entityId
- **description**: 字段描述

### 2.3 主题 (TOPIC)

- **name**: 主题名称，如"用户主题"、"订单主题"
- **displayName**: 显示名称
- **description**: 主题描述
- 用于将多个相关的表组织在一起

## 三、功能模块

### 3.1 实体关系图

入口：**知识库 → 实体关系图**

展示主题与表的层级关系：
- 按主题分组显示所有表
- 未分类的表显示在"未分类表"分组中
- 点击表名可查看表详情和关联字段

**配置说明**：
- `topicId` 字段决定了表属于哪个主题
- 通过"添加到主题"功能可将表分配到主题

### 3.2 实体列表

入口：**知识库 → 实体列表**

左侧显示所有表，右侧显示选中表的字段。

**功能按钮**：
| 按钮 | 说明 |
|------|------|
| 新建实体 | 创建新的 TABLE、COLUMN 或 TOPIC |
| 刷新 | 刷新实体列表 |
| 添加到主题 | 将选中的表分配到指定主题（需先选中表） |
| 批量删除 | 删除所有选中的表及其字段 |

**表字段搜索**：
- 可按表名或显示名搜索
- 点击表名在右侧查看其所有字段

### 3.3 知识卡片

入口：**知识库 → 知识卡片**

为实体（表或字段）附加业务知识描述。

**卡片类型**：

| 类型 | 说明 | 用途 |
|------|------|------|
| RELATIONSHIP | 关系 | 描述表之间或字段之间的关系 |
| BUSINESS_RULE | 业务规则 | 描述业务逻辑和计算规则 |
| DATA_PATTERN | 数据模式 | 描述数据分布特征 |
| USAGE_PATTERN | 使用模式 | 描述常见的查询用法 |
| SEMANTIC_MAPPING | 语义映射 | 描述自然语言到字段的映射 |
| METRIC_DEFINITION | 指标定义 | 描述指标的计算方式 |

**置信度**：0-100%，表示该知识的可信程度

**创建知识卡片**：
1. 在"实体关系图"中点击选择一个实体
2. 切换到"知识卡片"标签
3. 点击"新建知识卡片"按钮
4. 填写卡片类型、标题、内容等信息
5. 点击确定保存

### 3.4 矛盾处理

入口：**知识库 → 矛盾处理**

当新的 schema 信息与现有知识卡片存在冲突时，系统会自动创建矛盾记录。

**矛盾状态**：
| 状态 | 说明 |
|------|------|
| PENDING | 待处理 |
| ACCEPT_NEW | 接受新知识 |
| KEEP_OLD | 保留旧知识 |
| MERGE | 合并两者 |
| DISMISS | 忽略 |

### 3.5 主题摘要

入口：**知识库 → 主题摘要**

为每个主题生成 AI 摘要，汇总该主题下所有表的信息。

## 四、操作流程

### 4.1 创建主题

1. 进入"实体列表"
2. 选中一个或多个表
3. 点击"添加到主题"按钮
4. 在下拉菜单中选择"创建新主题"
5. 填写主题名称、描述
6. 点击确定

### 4.2 将表添加到主题

1. 在"实体列表"中选中目标表（可多选）
2. 点击"添加到主题"按钮
3. 从下拉列表中选择目标主题
4. 点击"确认添加"

### 4.3 从主题移除表

1. 在"实体列表"中点击目标表
2. 在表右侧操作栏中点击"编辑"
3. 在表单中清空"主题ID"字段
4. 点击确定保存

### 4.4 创建知识卡片

1. 在"实体关系图"中点击目标表
2. 切换到"知识卡片"标签
3. 点击"新建知识卡片"
4. 选择卡片类型（如 RELATIONSHIP）
5. 填写标题和内容
6. 设置置信度（默认90%）
7. 可添加标签便于分类
8. 点击确定保存

### 4.5 级联删除

删除表时会自动删除：
- 该表下的所有字段
- 所有字段关联的知识卡片
- 所有字段参与的实体链接

## 五、数据库表结构

### 5.1 s2_wiki_entity（实体表）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL | 主键 |
| entity_id | VARCHAR(64) | 实体唯一ID |
| entity_type | VARCHAR(16) | 类型：TABLE/COLUMN/TOPIC |
| name | VARCHAR(128) | 名称 |
| display_name | VARCHAR(256) | 显示名称 |
| description | TEXT | 描述 |
| properties | JSONB | 扩展属性 |
| summary | TEXT | AI生成的摘要 |
| tags | TEXT[] | 标签数组 |
| version | VARCHAR(16) | 版本号 |
| parent_entity_id | VARCHAR(64) | 父实体ID（字段所属表） |
| topic_id | VARCHAR(64) | 所属主题ID |
| status | VARCHAR(16) | 状态：ACTIVE/DELETED |
| created_at | TIMESTAMP | 创建时间 |
| updated_at | TIMESTAMP | 更新时间 |

### 5.2 s2_wiki_knowledge_card（知识卡片表）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL | 主键 |
| card_id | VARCHAR(64) | 卡片唯一ID |
| entity_id | VARCHAR(64) | 关联的实体ID |
| card_type | VARCHAR(32) | 卡片类型 |
| title | VARCHAR(256) | 标题 |
| content | TEXT | 内容 |
| extracted_from | TEXT[] | 来源 |
| confidence | DECIMAL | 置信度 |
| status | VARCHAR(16) | 状态 |
| tags | TEXT[] | 标签 |
| version | VARCHAR(16) | 版本号 |
| created_at | TIMESTAMP | 创建时间 |
| updated_at | TIMESTAMP | 更新时间 |

### 5.3 s2_wiki_entity_link（实体关系表）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL | 主键 |
| source_entity_id | VARCHAR(64) | 源实体ID |
| target_entity_id | VARCHAR(64) | 目标实体ID |
| link_type | VARCHAR(32) | 关系类型 |
| description | TEXT | 关系描述 |
| weight | FLOAT | 权重 |
| bidirectional | BOOLEAN | 是否双向 |
| created_at | TIMESTAMP | 创建时间 |

### 5.4 s2_wiki_summary（主题摘要表）

| 字段 | 类型 | 说明 |
|------|------|------|
| id | BIGSERIAL | 主键 |
| topic_id | VARCHAR(64) | 主题ID |
| topic_name | VARCHAR(256) | 主题名称 |
| summary | TEXT | AI生成的摘要 |
| member_entities | TEXT[] | 包含的实体ID列表 |
| relationships | TEXT[] | 关键关系列表 |
| metrics | JSONB | 指标数据 |
| summary_version | INT | 摘要版本 |
| llm_model | VARCHAR(64) | 使用的LLM模型 |
| generated_at | TIMESTAMP | 生成时间 |

## 六、API 接口

### 6.1 实体相关

| 接口 | 方法 | 说明 |
|------|------|------|
| `/api/wiki/graph/nodes` | GET | 获取所有实体节点 |
| `/api/wiki/graph/edges` | GET | 获取所有实体关系边 |
| `/api/wiki/entities` | GET | 获取实体列表 |
| `/api/wiki/entities` | POST | 创建实体 |
| `/api/wiki/entities/{entityId}` | PUT | 更新实体 |
| `/api/wiki/entities/{entityId}` | DELETE | 删除实体（含级联） |

### 6.2 知识卡片相关

| 接口 | 方法 | 说明 |
|------|------|------|
| `/api/wiki/knowledge` | GET | 获取知识卡片 |
| `/api/wiki/knowledge` | POST | 创建知识卡片 |
| `/api/wiki/knowledge/{cardId}` | PUT | 更新知识卡片 |
| `/api/wiki/knowledge/{cardId}` | DELETE | 删除知识卡片 |

### 6.3 主题摘要相关

| 接口 | 方法 | 说明 |
|------|------|------|
| `/api/wiki/summaries` | GET | 获取所有主题摘要 |
| `/api/wiki/summaries/refresh-all` | POST | 刷新所有摘要 |
| `/api/wiki/summaries/{topicId}/refresh` | POST | 刷新指定主题摘要 |

## 七、常见问题

### 7.1 为什么实体关系图中主题显示为0？

检查 `GraphNode` 是否包含 `status` 字段，且主题的 `status` 为 `ACTIVE`。

### 7.2 为什么表没有显示在对应的主题下？

确保表的 `topicId` 字段已正确设置，且主题存在。

### 7.3 创建知识卡片失败

检查数据库表 `s2_wiki_knowledge_card` 是否已创建。

### 7.4 删除表时字段没有一起删除

确保调用的是级联删除接口，会自动删除子实体和关联数据。

## 八、最佳实践

1. **主题规划**：先规划好主题结构，再将表分配到主题
2. **知识沉淀**：为重要字段添加知识卡片，记录业务含义
3. **定期更新**：当 schema 变化时，及时更新相关知识卡片
4. **矛盾处理**：及时处理矛盾记录，保持知识一致性
