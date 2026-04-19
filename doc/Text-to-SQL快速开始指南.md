# Text-to-SQL 快速开始指南

## 一、环境准备

### 1.1 依赖服务

确保以下服务正常运行：

| 服务 | 地址 | 说明 |
|------|------|------|
| PostgreSQL | 192.168.1.10:5432 | 元数据库，已配置 |
| MySQL | 192.168.1.7:7001 | 业务数据库，已配置 |
| Ollama | 192.168.1.10:11435 | Embedding 服务 |
| MiniMax API | https://api.minimaxi.com/v1 | LLM 服务 |

### 1.2 配置检查

在启动服务前，确保 `application-local.yaml` 中已配置 Ollama：

```yaml
s2:
  embedding:
    model:
      provider: OLLAMA
      baseUrl: http://192.168.1.10:11435
      name: bge-m3:latest
```

## 二、构建知识库

### 2.1 自动构建（推荐）

在 Spring Boot 启动时自动构建知识库：

```yaml
text2sql:
  enabled: true
  knowledge:
    build-on-startup: true
    sql-file-path: e:\trae\supersonic\sql\charge_zbhx_20260303.sql
    target-tables:
      - customer
      - sf_js_t
      - pay_order
      - contract_info
      - area
```

### 2.2 手动构建

通过 API 手动触发知识库构建：

```bash
curl -X POST http://localhost:9080/api/text2sql/knowledge/build \
  -H "Content-Type: application/json" \
  -d '{
    "sqlFilePath": "e:\\trae\\supersonic\\sql\\charge_zbhx_20260303.sql",
    "targetTables": ["customer", "sf_js_t", "pay_order"]
  }'
```

## 三、使用示例

### 3.1 基本查询

```bash
curl -X POST http://localhost:9080/api/text2sql/convert \
  -H "Content-Type: application/json" \
  -d '{
    "question": "查询本采暖期欠费用户有哪些？",
    "topK": 5
  }'
```

### 3.2 预期输出

```json
{
  "code": 200,
  "message": "success",
  "data": {
    "question": "查询本采暖期欠费用户有哪些？",
    "sql": "SELECT c.`name`, c.`mob_no`, c.`address`, s.`qfje`\nFROM `customer` c\nINNER JOIN `sf_js_t` s ON c.`id` = s.`customer_id`\nWHERE s.`cnq` = '2025-2026'\n  AND s.`qfje` > 0\n  AND s.`zf` = 0\nORDER BY s.`qfje` DESC",
    "valid": true,
    "schemas": [
      {
        "tableName": "customer",
        "tableComment": "用户信息表",
        "columns": ["name", "mob_no", "address"]
      },
      {
        "tableName": "sf_js_t",
        "tableComment": "收费结算表",
        "columns": ["cnq", "qfje"]
      }
    ]
  }
}
```

### 3.3 更多示例问题

| 序号 | 问题 | 预期用途 |
|------|------|----------|
| 1 | 查询所有居民用户 | SELECT + WHERE yhlx='居民' |
| 2 | 本采暖期欠费用户有哪些？ | JOIN + WHERE qfje > 0 |
| 3 | 统计每个地区的用户数量 | GROUP BY + COUNT |
| 4 | 查询某个用户的缴费记录 | WHERE customer_id = ? |
| 5 | 本采暖期缴费金额超过1000元的用户 | HAVING SUM(sfje) > 1000 |

## 四、测试验证

### 4.1 单元测试

```bash
cd E:\trae\supersonic
mvn test -Dtest=Text2SqlServiceTest -pl headless/core
```

### 4.2 集成测试

启动服务后，使用上述 curl 命令测试。

## 五、常见问题

### 5.1 Embedding 服务无响应

检查 Ollama 服务是否正常：

```bash
curl http://192.168.1.10:11435/api/tags
```

### 5.2 LLM 生成 SQL 错误

检查 MiniMax API 配置：

```yaml
s2:
  llm:
    provider: OPEN_AI
    baseUrl: https://api.minimaxi.com/v1
    modelName: MiniMax-M2.7
    apiKey: <your-api-key>
```

### 5.3 知识库为空

检查 SQL 文件路径是否正确：

```java
String sqlFilePath = "e:\\trae\\supersonic\\sql\\charge_zbhx_20260303.sql";
```

路径需要使用双反斜杠或正斜杠。

## 六、性能优化

### 6.1 Embedding 缓存

系统会自动缓存相同问题的 embedding 结果，减少 Ollama 调用。

### 6.2 Schema 缓存

热点表结构信息会缓存在内存中。

### 6.3 并发限制

建议限制并发请求数，避免 LLM 服务过载。

## 七、扩展阅读

详细技术方案请参考：[Text-to-SQL-RAG技术方案.md](./Text-to-SQL-RAG技术方案.md)
