# Wiki 数据源导入功能实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现从已配置的数据源直接导入表结构到 Wiki Entity，支持选择性导入和重复表覆盖处理

**Architecture:** 后端在 WikiSchemaController 新增两个 API（预览、执行）， WikiEntityService 新增冲突检测和导入方法；前端在 SchemaImportSection 新增 Tab3「从数据源导入」，包含数据源选择、表列表勾选、冲突处理弹窗

**Tech Stack:** Spring Boot + JdbcTemplate + React + Ant Design

---

## 文件结构

```
后端修改:
- headless-core/.../wiki/WikiSchemaController.java  (新增API)
- headless-core/.../wiki/service/WikiEntityService.java  (新增冲突检测+导入方法)
- headless-core/.../wiki/dto/TableImportPreview.java  (新建: 预览响应DTO)
- headless-core/.../wiki/dto/TableSelection.java  (新建: 用户选择DTO)
- headless-core/.../wiki/dto/ImportResult.java  (新建: 导入结果DTO)

前端修改:
- webapp/.../Wiki/components/SchemaImportSection.tsx  (新增Tab3)
- webapp/.../services/wiki.ts  (新增API调用)
```

---

## Task 1: 后端 - 新建 DTO 类

**Files:**
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/TableImportPreview.java`
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/TableSelection.java`
- Create: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/ImportResult.java`

- [ ] **Step 1: 创建 TableImportPreview.java**

```java
package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.util.List;

@Data
public class TableImportPreview {
    private List<TablePreviewItem> tables;
    private int totalCount;
    private int conflictCount;
    private int newCount;

    @Data
    public static class TablePreviewItem {
        private String tableName;
        private String displayName;
        private String description;
        private List<ColumnPreviewItem> columns;
        private String conflictStatus; // "NEW" | "EXISTS"
    }

    @Data
    public static class ColumnPreviewItem {
        private String columnName;
        private String displayName;
        private String description;
        private String dataType;
    }
}
```

- [ ] **Step 2: 创建 TableSelection.java**

```java
package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

@Data
public class TableSelection {
    private String tableName;
    private String action; // "IMPORT" | "SKIP"

    public static final String ACTION_IMPORT = "IMPORT";
    public static final String ACTION_SKIP = "SKIP";
}
```

- [ ] **Step 3: 创建 ImportResult.java**

```java
package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.util.List;

@Data
public class ImportResult {
    private int successCount;
    private int skipCount;
    private int failCount;
    private List<String> failedTables;
}
```

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/*.java
git commit -m "feat(wiki): add DTOs for datasource import"
```

---

## Task 2: 后端 - WikiEntityService 新增方法

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiEntityService.java`

- [ ] **Step 1: 新增 detectConflicts 方法**

在 WikiEntityService.java 中添加：

```java
/**
 * 检测表名列表中哪些已存在
 * @param tableNames 要检测的表名列表
 * @return Map<tableName, "NEW"|"EXISTS">
 */
public Map<String, String> detectConflicts(List<String> tableNames) {
    Map<String, String> result = new HashMap<>();
    if (tableNames == null || tableNames.isEmpty()) {
        return result;
    }
    String sql = "SELECT name FROM s2_wiki_entity WHERE entity_type = 'TABLE' AND status = 'ACTIVE' AND name = ?";
    for (String tableName : tableNames) {
        List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql, tableName);
        result.put(tableName, rows.isEmpty() ? "NEW" : "EXISTS");
    }
    return result;
}
```

- [ ] **Step 2: 新增 importTableSchema 方法**

```java
/**
 * 导入单个表的结构到 Wiki Entity
 */
public void importTableSchema(TableSchema schema, String topicId) {
    String entityId = "table:" + schema.getTableName();

    // 检查是否已存在
    WikiEntity existing = getEntityById(entityId);
    if (existing != null) {
        // 更新
        existing.setDisplayName(schema.getTableComment());
        existing.setDescription(schema.getTableComment());
        existing.setTopicId(topicId);
        updateEntity(existing);
    } else {
        // 创建
        WikiEntity entity = new WikiEntity();
        entity.setEntityId(entityId);
        entity.setEntityType("TABLE");
        entity.setName(schema.getTableName());
        entity.setDisplayName(schema.getTableComment());
        entity.setDescription(schema.getTableComment());
        entity.setTopicId(topicId);
        entity.setStatus("ACTIVE");
        createEntity(entity);
    }

    // 处理字段 (COLUMN)
    for (com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema col : schema.getColumns()) {
        importColumnSchema(entityId, col);
    }
}

private void importColumnSchema(String parentEntityId, com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema col) {
    String columnEntityId = parentEntityId + ":column:" + col.getColumnName();

    WikiEntity existing = getEntityById(columnEntityId);
    Map<String, Object> props = new HashMap<>();
    props.put("dataType", col.getColumnType());

    if (existing != null) {
        existing.setDisplayName(col.getColumnComment());
        existing.setDescription(col.getColumnComment());
        existing.setProperties(props);
        updateEntity(existing);
    } else {
        WikiEntity columnEntity = new WikiEntity();
        columnEntity.setEntityId(columnEntityId);
        columnEntity.setEntityType("COLUMN");
        columnEntity.setName(col.getColumnName());
        columnEntity.setDisplayName(col.getColumnComment());
        columnEntity.setDescription(col.getColumnComment());
        columnEntity.setProperties(props);
        columnEntity.setParentEntityId(parentEntityId);
        columnEntity.setStatus("ACTIVE");
        createEntity(columnEntity);
    }
}
```

- [ ] **Step 3: 添加必要 import**

```java
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import java.util.HashSet;
import java.util.Set;
```

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiEntityService.java
git commit -m "feat(wiki): add detectConflicts and importTableSchema to WikiEntityService"
```

---

## Task 3: 后端 - WikiSchemaController 新增 API

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiSchemaController.java`

- [ ] **Step 1: 新增 import-preview API**

在 WikiSchemaController.java 的 `@GetMapping("/template")` 后添加：

```java
@GetMapping("/import-preview/{dataSourceId}")
public BaseResp<TableImportPreview> getImportPreview(@PathVariable Long dataSourceId) {
    try {
        // 解析数据源 schema
        List<TableSchema> schemas = dataSourceService.parseSchemaFromSource(dataSourceId);

        // 收集所有表名
        List<String> tableNames = schemas.stream()
            .map(TableSchema::getTableName)
            .collect(Collectors.toList());

        // 检测冲突
        Map<String, String> conflicts = entityService.detectConflicts(tableNames);

        // 构建预览数据
        List<TableImportPreview.TablePreviewItem> items = new ArrayList<>();
        for (TableSchema schema : schemas) {
            TableImportPreview.TablePreviewItem item = new TableImportPreview.TablePreviewItem();
            item.setTableName(schema.getTableName());
            item.setDisplayName(schema.getTableComment());
            item.setDescription(schema.getTableComment());
            item.setConflictStatus(conflicts.getOrDefault(schema.getTableName(), "NEW"));

            List<TableImportPreview.ColumnPreviewItem> cols = new ArrayList<>();
            for (com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema col : schema.getColumns()) {
                TableImportPreview.ColumnPreviewItem ci = new TableImportPreview.ColumnPreviewItem();
                ci.setColumnName(col.getColumnName());
                ci.setDisplayName(col.getColumnComment());
                ci.setDescription(col.getColumnComment());
                ci.setDataType(col.getColumnType());
                cols.add(ci);
            }
            item.setColumns(cols);
            items.add(item);
        }

        TableImportPreview preview = new TableImportPreview();
        preview.setTables(items);
        preview.setTotalCount(items.size());
        preview.setConflictCount((int) items.stream().filter(i -> "EXISTS".equals(i.getConflictStatus())).count());
        preview.setNewCount((int) items.stream().filter(i -> "NEW".equals(i.getConflictStatus())).count());

        return BaseResp.ok(preview);
    } catch (Exception e) {
        log.error("Failed to get import preview", e);
        return BaseResp.fail("获取预览失败: " + e.getMessage());
    }
}
```

- [ ] **Step 2: 新增 import-from-datasource API**

```java
@PostMapping("/import-from-datasource/{dataSourceId}")
@Transactional
public BaseResp<ImportResult> importFromDataSource(@PathVariable Long dataSourceId, @RequestBody List<TableSelection> selections) {
    try {
        // 解析数据源 schema
        List<TableSchema> schemas = dataSourceService.parseSchemaFromSource(dataSourceId);

        ImportResult result = new ImportResult();
        int successCount = 0;
        int skipCount = 0;
        int failCount = 0;
        List<String> failedTables = new ArrayList<>();

        for (TableSelection sel : selections) {
            if (TableSelection.ACTION_SKIP.equals(sel.getAction())) {
                skipCount++;
                continue;
            }

            // 查找对应的 schema
            TableSchema schema = schemas.stream()
                .filter(s -> sel.getTableName().equals(s.getTableName()))
                .findFirst()
                .orElse(null);

            if (schema == null) {
                failCount++;
                failedTables.add(sel.getTableName());
                continue;
            }

            try {
                entityService.importTableSchema(schema, null);
                successCount++;
            } catch (Exception e) {
                failCount++;
                failedTables.add(sel.getTableName());
                log.error("Failed to import table: {}", sel.getTableName(), e);
            }
        }

        result.setSuccessCount(successCount);
        result.setSkipCount(skipCount);
        result.setFailCount(failCount);
        result.setFailedTables(failedTables);

        return BaseResp.ok(result);
    } catch (Exception e) {
        log.error("Failed to import from datasource", e);
        return BaseResp.fail("导入失败: " + e.getMessage());
    }
}
```

- [ ] **Step 3: 添加必要 import**

```java
import com.tencent.supersonic.headless.core.wiki.dto.*;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import java.util.stream.Collectors;
```

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/WikiSchemaController.java
git commit -m "feat(wiki): add import-preview and import-from-datasource APIs"
```

---

## Task 4: 前端 - API 服务层

**Files:**
- Modify: `webapp/packages/supersonic-fe/src/services/wiki.ts`

- [ ] **Step 1: 添加 API 调用**

在 wiki.ts 文件末尾添加：

```typescript
export const getImportPreview = async (
  dataSourceId: number
): Promise<ApiResponse<ImportPreview>> => {
  return request(`/api/wiki/schema/import-preview/${dataSourceId}`, {
    method: 'GET',
  });
};

export const importFromDataSource = async (
  dataSourceId: number,
  selections: TableSelection[]
): Promise<ApiResponse<ImportApiResult>> => {
  return request(`/api/wiki/schema/import-from-datasource/${dataSourceId}`, {
    method: 'POST',
    data: selections,
  });
};

export interface ImportPreview {
  tables: TablePreviewItem[];
  totalCount: number;
  conflictCount: number;
  newCount: number;
}

export interface TablePreviewItem {
  tableName: string;
  displayName: string;
  description: string;
  columns: ColumnPreviewItem[];
  conflictStatus: 'NEW' | 'EXISTS';
}

export interface ColumnPreviewItem {
  columnName: string;
  displayName: string;
  description: string;
  dataType: string;
}

export interface TableSelection {
  tableName: string;
  action: 'IMPORT' | 'SKIP';
}

export interface ImportApiResult {
  successCount: number;
  skipCount: number;
  failCount: number;
  failedTables: string[];
}
```

- [ ] **Step 2: Commit**

```bash
git add webapp/packages/supersonic-fe/src/services/wiki.ts
git commit -m "feat(wiki): add getImportPreview and importFromDataSource APIs"
```

---

## Task 5: 前端 - SchemaImportSection 新增 Tab3

**Files:**
- Modify: `webapp/packages/supersonic-fe/src/pages/Wiki/components/SchemaImportSection.tsx`

- [ ] **Step 1: 添加状态和 API 导入**

在文件顶部 import 后添加类型和 API 导入：

```typescript
import {
  getImportPreview,
  importFromDataSource,
  getDataSources,
  ImportPreview,
  TableSelection,
} from '@/services/wiki';

interface DataSource {
  id: number;
  name: string;
  type: string;
  databaseName: string;
}
```

- [ ] **Step 2: 添加 Tab3 状态**

在 SchemaImportSection 组件中添加状态：

```typescript
const [dataSources, setDataSources] = useState<DataSource[]>([]);
const [selectedDataSource, setSelectedDataSource] = useState<number | null>(null);
const [importPreview, setImportPreview] = useState<ImportPreview | null>(null);
const [selectedTables, setSelectedTables] = useState<string[]>([]);
const [conflictModalVisible, setConflictModalVisible] = useState(false);
const [conflictTables, setConflictTables] = useState<TablePreviewItem[]>([]);
const [tableActions, setTableActions] = useState<Record<string, 'IMPORT' | 'SKIP'>>({});
```

- [ ] **Step 3: 获取数据源列表**

```typescript
useEffect(() => {
  fetchDataSources();
}, []);

const fetchDataSources = async () => {
  try {
    const resp = await getDataSources();
    if (resp.success && resp.data) {
      setDataSources(resp.data);
    }
  } catch (error) {
    console.error('Failed to fetch datasources:', error);
  }
};
```

- [ ] **Step 4: Tab3 「从数据源导入」UI**

在 Tabs 的 items 中添加第三个 tab：

```typescript
{
  key: 'datasource',
  label: (
    <span>
      <UploadOutlined />
      从数据源导入
    </span>
  ),
  children: (
    <div>
      <Space style={{ marginBottom: 16 }}>
        <Select
          placeholder="选择数据源"
          style={{ width: 300 }}
          onChange={handleDataSourceChange}
          value={selectedDataSource}
        >
          {dataSources.map((ds) => (
            <Option key={ds.id} value={ds.id}>
              {ds.name} ({ds.type} - {ds.databaseName})
            </Option>
          ))}
        </Select>
        <Button
          type="primary"
          onClick={handleLoadPreview}
          disabled={!selectedDataSource}
        >
          加载表结构
        </Button>
      </Space>

      {importPreview && (
        <Table
          rowKey="tableName"
          columns={[
            { title: '选择', render: (_, record) => (
              <Checkbox
                checked={selectedTables.includes(record.tableName)}
                onChange={(e) => handleTableSelect(record.tableName, e.target.checked)}
              />
            )},
            { title: '表名', dataIndex: 'tableName' },
            { title: '中文名', dataIndex: 'displayName' },
            { title: '字段数', render: (_, record) => record.columns?.length || 0 },
            { title: '状态', render: (_, record) => (
              <Tag color={record.conflictStatus === 'NEW' ? 'green' : 'orange'}>
                {record.conflictStatus === 'NEW' ? '新增' : '已存在'}
              </Tag>
            )},
          ]}
          dataSource={importPreview.tables}
          pagination={false}
          size="small"
        />
      )}

      <Space style={{ marginTop: 16 }}>
        <Button
          type="primary"
          onClick={handleImport}
          disabled={selectedTables.length === 0}
        >
          导入选中表 ({selectedTables.length})
        </Button>
      </Space>

      {/* 冲突处理弹窗 */}
      <ConflictModal />
    </div>
  ),
},
```

- [ ] **Step 5: 添加处理函数**

```typescript
const handleDataSourceChange = (value: number) => {
  setSelectedDataSource(value);
  setImportPreview(null);
  setSelectedTables([]);
};

const handleLoadPreview = async () => {
  if (!selectedDataSource) return;
  try {
    const resp = await getImportPreview(selectedDataSource);
    if (resp.success && resp.data) {
      setImportPreview(resp.data);
      // 默认全选
      const allTableNames = resp.data.tables.map((t: TablePreviewItem) => t.tableName);
      setSelectedTables(allTableNames);
    }
  } catch (error) {
    message.error('加载表结构失败');
  }
};

const handleTableSelect = (tableName: string, checked: boolean) => {
  if (checked) {
    setSelectedTables([...selectedTables, tableName]);
  } else {
    setSelectedTables(selectedTables.filter((t) => t !== tableName));
  }
};

const handleImport = async () => {
  const conflicts = importPreview?.tables.filter(
    (t: TablePreviewItem) => t.conflictStatus === 'EXISTS' && selectedTables.includes(t.tableName)
  );

  if (conflicts && conflicts.length > 0) {
    setConflictTables(conflicts);
    setConflictModalVisible(true);
    return;
  }

  await executeImport([]);
};

const executeImport = async (selections: TableSelection[]) => {
  if (!selectedDataSource) return;
  setLoading(true);
  try {
    const resp = await importFromDataSource(selectedDataSource, selections);
    if (resp.success && resp.data) {
      message.success(`导入完成: 成功 ${resp.data.successCount}, 跳过 ${resp.data.skipCount}`);
      if (resp.data.failCount > 0) {
        message.warning(`失败 ${resp.data.failCount} 个表`);
      }
      setConflictModalVisible(false);
      onRefresh();
    }
  } catch (error) {
    message.error('导入失败');
  } finally {
    setLoading(false);
  }
};
```

- [ ] **Step 6: 添加冲突处理弹窗组件**

```typescript
const ConflictModal = () => {
  if (!conflictTables.length) return null;

  const handleBatchAction = (action: 'IMPORT' | 'SKIP') => {
    const newActions = { ...tableActions };
    conflictTables.forEach((t: TablePreviewItem) => {
      newActions[t.tableName] = action;
    });
    setTableActions(newActions);
  };

  const handleConfirm = async () => {
    const selections: TableSelection[] = selectedTables.map((tableName) => ({
      tableName,
      action: tableActions[tableName] || 'IMPORT',
    }));
    await executeImport(selections);
  };

  return (
    <Modal
      title="以下表已存在，请选择处理方式"
      open={conflictModalVisible}
      onCancel={() => setConflictModalVisible(false)}
      onOk={handleConfirm}
    >
      <Table
        rowKey="tableName"
        columns={[
          { title: '表名', dataIndex: 'tableName' },
          { title: '操作', render: (_, record) => (
            <Space>
              <Button
                size="small"
                type={tableActions[record.tableName] === 'IMPORT' ? 'primary' : 'default'}
                onClick={() => setTableActions({ ...tableActions, [record.tableName]: 'IMPORT' })}
              >
                覆盖此表
              </Button>
              <Button
                size="small"
                type={tableActions[record.tableName] === 'SKIP' ? 'primary' : 'default'}
                onClick={() => setTableActions({ ...tableActions, [record.tableName]: 'SKIP' })}
              >
                跳过此表
              </Button>
            </Space>
          )},
        ]}
        dataSource={conflictTables}
        pagination={false}
        size="small"
      />
      <Space style={{ marginTop: 16 }}>
        <Button onClick={() => handleBatchAction('IMPORT')}>全部覆盖</Button>
        <Button onClick={() => handleBatchAction('SKIP')}>全部跳过</Button>
      </Space>
    </Modal>
  );
};
```

- [ ] **Step 7: Commit**

```bash
git add webapp/packages/supersonic-fe/src/pages/Wiki/components/SchemaImportSection.tsx
git add webapp/packages/supersonic-fe/src/services/wiki.ts
git commit -m "feat(wiki): add datasource import tab to SchemaImportSection"
```

---

## 自检清单

**1. Spec 覆盖检查:**
- [x] GET /api/wiki/schema/import-preview/{dataSourceId} → Task 3 Step 1
- [x] POST /api/wiki/schema/import-from-datasource/{dataSourceId} → Task 3 Step 2
- [x] 前端 Tab3 从数据源导入 → Task 5 Step 4-6
- [x] 表列表勾选 → Task 5 Step 4
- [x] 冲突处理弹窗 → Task 5 Step 6

**2. 占位符扫描:** 无 TBD/TODO/implement later

**3. 类型一致性:**
- TableImportPreview.TablePreviewItem.conflictStatus 使用 "NEW" | "EXISTS"
- TableSelection.action 使用 "IMPORT" | "SKIP"
- 前端 ImportApiResult 与后端 ImportResult 字段一致

---

## 实施选项

**1. Subagent-Driven (推荐)** - 每个 Task 由新的 subagent 执行，Task 间有检查点，快速迭代

**2. Inline Execution** - 在当前 session 中使用 executing-plans 批量执行，有检查点

选择哪种方式？