# Wiki 数据源导入功能设计

> **日期:** 2026-04-19
> **模块:** LLM-SQL-Wiki 结构导入
> **状态:** 设计完成，等待实现

## 1. 背景与目标

用户需要将已配置的 MySQL/PostgreSQL 数据源中的表结构直接导入到 Wiki Entity 中。当前系统已有 `WikiDataSourceService.parseSchemaFromSource()` 支持从数据源读取 schema，但缺少与 Wiki Entity 的联动能力。

**目标:**
- 从已配置的数据源导入表和字段为 Wiki Entity
- 支持选择性导入（用户勾选要导入的表）
- 重复表名时提示用户选择覆盖或跳过

## 2. 系统现状

### 已有的能力

| 组件 | 能力 | 位置 |
|------|------|------|
| `WikiDataSourceService` | CRUD 数据源配置、连接测试 | `headless-core/.../wiki/service/` |
| `parseSchemaFromSource()` | 从数据源读取表和字段结构 | 同上 |
| `WikiEntityService` | 创建/更新/删除 Wiki Entity | 同上 |
| `SchemaImportSection.tsx` | SQL 脚本导入 UI | `webapp/.../Wiki/components/` |

### 当前缺失

1. **后端**: 没有从数据源直接导入到 Wiki Entity 的 API
2. **前端**: 没有数据源选择 → 表列表勾选 → 导入的执行流程

## 3. 设计方案

### 3.1 后端 API 设计

#### 3.1.1 预览接口

```
GET /api/wiki/schema/import-preview/{dataSourceId}
```

**响应:**
```json
{
  "success": true,
  "data": {
    "tables": [
      {
        "tableName": "heating_period",
        "displayName": "采暖期表",
        "description": "记录新增的采暖期信息",
        "columns": [
          {
            "columnName": "temperature",
            "displayName": "室内温度",
            "description": "室内温度记录",
            "dataType": "DECIMAL(10,3)"
          }
        ],
        "conflictStatus": "NEW" | "EXISTS"
      }
    ],
    "totalCount": 5,
    "conflictCount": 2,
    "newCount": 3
  }
}
```

#### 3.1.2 执行导入接口

```
POST /api/wiki/schema/import-from-datasource/{dataSourceId}
```

**请求体:**
```json
{
  "selections": [
    { "tableName": "heating_period", "action": "IMPORT" },
    { "tableName": "customer", "action": "SKIP" }
  ]
}
```

**action 取值:** `IMPORT` | `SKIP`

**响应:**
```json
{
  "success": true,
  "data": {
    "successCount": 3,
    "skipCount": 0,
    "failCount": 0,
    "failedTables": []
  }
}
```

### 3.2 前端流程设计

#### Tab3:「从数据源导入」

**Step 1 - 选择数据源**
- 下拉选择已配置的数据源
- 显示数据源类型和数据库名

**Step 2 - 表列表勾选**
- 请求 `GET /api/wiki/schema/import-preview/{dataSourceId}`
- 表格展示：
  | 选择 | 表名 | 中文名 | 字段数 | 状态 |
  |------|------|--------|--------|------|
  | ☐ | heating_period | 采暖期表 | 12 | 新增 |
  | ☑ | customer | 用户信息表 | 8 | 已存在 |
- 冲突行高亮显示
- 全选/取消全选

**Step 3 - 冲突处理弹窗**
- 当用户勾选了「已存在」的表时弹出
- 内容：
  ```
  以下表已存在，请选择处理方式：
  
  [表名]          [操作]
  customer     [覆盖此表] [跳过此表]
  orders       [覆盖此表] [跳过此表]
  
  批量操作：[全部覆盖] [全部跳过]
  
  [取消导入] [确认导入]
  ```
- 点击「覆盖此表」将该行的 action 设为 `IMPORT`（覆盖模式）
- 点击「跳过此表」将该行的 action 设为 `SKIP`

**Step 4 - 执行导入**
- 显示进度条
- 执行完成后显示结果统计

### 3.3 后端处理逻辑

#### 冲突检测
```java
// 在 WikiEntityService 中新增方法
public Map<String, String> detectConflicts(List<String> tableNames) {
    // key: tableName, value: "NEW" | "EXISTS"
}
```

#### 导入执行
```java
@Transactional
public ImportResult importFromDataSource(Long dataSourceId, List<TableSelection> selections) {
    // 1. 解析数据源 schema
    List<TableSchema> schemas = dataSourceService.parseSchemaFromSource(dataSourceId);
    
    // 2. 按 selections 执行
    for (TableSelection sel : selections) {
        if (sel.action == SKIP) continue;
        
        TableSchema schema = findSchema(schemas, sel.tableName);
        // 创建或更新 entity
        createOrUpdateEntity(schema, sel.action == OVERWRITE);
    }
}
```

#### Entity 生成规则
| 数据源字段 | Wiki Entity 字段 |
|-----------|------------------|
| `tableName` | `entity.name` = `table:表名` |
| `tableComment` | `entity.displayName` / `entity.description` |
| `columnName` | 子 Entity `entity.name` = `column:列名` |
| `columnComment` | 子 Entity `displayName` / `description` |
| `columnType` | 子 Entity `properties.dataType` |

## 4. 接口清单

| 方法 | 路径 | 说明 |
|------|------|------|
| GET | `/api/wiki/schema/import-preview/{dataSourceId}` | 预览数据源表结构并检测冲突 |
| POST | `/api/wiki/schema/import-from-datasource/{dataSourceId}` | 执行导入 |

## 5. 测试用例

1. **正常导入**: 选择数据源 → 勾选表 → 执行 → 成功
2. **全部跳过**: 勾选已存在的表但全部跳过 → 无变更
3. **覆盖已存在**: 选择覆盖 → 原数据被替换
4. **部分导入**: 部分表选导入、部分选跳过 → 结果正确
5. **空选择**: 未勾选任何表 → 提示「请选择至少一个表」

## 6. 技术要点

- 使用 `WikiDataSourceService.parseSchemaFromSource()` 读取 schema
- 使用 `WikiEntityService` 创建 Entity
- 支持 MySQL 和 PostgreSQL 两种数据源类型
