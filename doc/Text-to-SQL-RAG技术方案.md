# Text-to-SQL RAG 技术方案

## 一、概述

### 1.1 背景

供热收费客服智能分析平台需要支持客服人员通过自然语言查询业务数据。当前平台已有：
- **SuperSonic 0.9.10** BI 平台
- **MiniMax-M2** LLM 模型
- **Ollama bge-m3** Embedding 模型
- **PostgreSQL** 元数据库
- **MySQL** 业务数据库（charge_zbhx_20260303）

### 1.2 目标

通过 **RAG（检索增强生成）** 架构，实现自然语言到 SQL 的转换，使客服人员能够：
- 用中文自然语言查询用户信息、收费记录、缴费状态等
- 无需了解底层表结构，即可获取业务数据

### 1.3 方案优势

| 优势 | 说明 |
|------|------|
| 无需训练 | 直接利用现有 LLM 能力 |
| 快速上线 | 2-3 周可完成开发 |
| 可解释性 | RAG 检索过程透明 |
| 可扩展 | 可不断丰富知识库提升准确率 |
| 成本低 | 无需 GPU 训练资源 |

---

## 二、架构设计

### 2.1 整体架构

```
┌─────────────────────────────────────────────────────────────────┐
│                         用户层                                    │
│                   自然语言查询："查询本采暖期欠费用户"              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Text-to-SQL 服务                            │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐       │
│  │  问题解析    │ -> │  RAG 检索    │ -> │  SQL 生成    │       │
│  │  (Parser)    │    │  (Retrieval) │    │  (LLM)       │       │
│  └──────────────┘    └──────────────┘    └──────────────┘       │
└─────────────────────────────────────────────────────────────────┘
         │                    │                    │
         ▼                    ▼                    ▼
┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  PostgreSQL  │    │  向量知识库   │    │  MiniMax LLM │
│  元数据库    │    │  (Schema)     │    │  (SQL Gen)   │
└──────────────┘    └──────────────┘    └──────────────┘
```

### 2.2 数据流

```
                    离线构建流程
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ SQL 文件    │ -> │ 表结构解析  │ -> │ Schema 描述 │ -> │ 向量存储   │
│ charge_*.sql│    │ (Parser)    │    │ (文本)      │    │ (Embedding) │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘

                    在线查询流程
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│ 用户问题   │ -> │ 意图识别    │ -> │ RAG 检索    │ -> │ LLM 生成    │
│ "欠费用户" │    │ (意图分类)   │    │ (Top-K)    │    │ SQL        │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

---

## 三、表结构提取

### 3.1 核心业务表

从 `charge_zbhx_20260303.sql` 提取以下核心业务表：

| 表名 | 说明 | 记录数 | 优先级 |
|------|------|--------|--------|
| customer | 用户信息表 | ~10万 | P0 |
| sf_js_t | 收费结算表 | ~20万 | P0 |
| pay_order | 缴费订单表 | ~50万 | P0 |
| contract_info | 合同信息表 | ~5万 | P1 |
| area | 地区表 | ~1万 | P1 |

### 3.2 表结构 Schema 描述

#### customer 用户信息表

```json
{
  "tableName": "customer",
  "tableComment": "用户信息表",
  "columns": [
    {"name": "id", "type": "bigint", "comment": "用户主键", "isPK": true},
    {"name": "code", "type": "varchar(20)", "comment": "用户编码", "isUK": true},
    {"name": "name", "type": "varchar(40)", "comment": "用户名称"},
    {"name": "mob_no", "type": "varchar(200)", "comment": "手机号"},
    {"name": "tel_no", "type": "varchar(50)", "comment": "座机号"},
    {"name": "yhlx", "type": "varchar(10)", "comment": "用户类型：居民/单位"},
    {"name": "one", "type": "varchar(20)", "comment": "一级地区"},
    {"name": "two", "type": "varchar(20)", "comment": "二级地区"},
    {"name": "three", "type": "varchar(30)", "comment": "三级地区"},
    {"name": "address", "type": "varchar(100)", "comment": "地址"},
    {"name": "rwrq", "type": "date", "comment": "入网日期"},
    {"name": "kf_sf", "type": "tinyint", "comment": "是否允许收费：0-否 1-是"},
    {"name": "kf_hmd", "type": "tinyint", "comment": "是否黑名单：0-否 1-是"}
  ]
}
```

#### sf_js_t 收费结算表

```json
{
  "tableName": "sf_js_t",
  "tableComment": "收费结算表",
  "columns": [
    {"name": "id", "type": "bigint", "comment": "主键", "isPK": true},
    {"name": "customer_id", "type": "bigint", "comment": "用户主键", "fk": "customer.id"},
    {"name": "cnq", "type": "varchar(20)", "comment": "采暖期"},
    {"name": "sfmj", "type": "decimal(10,3)", "comment": "收费面积"},
    {"name": "ysje", "type": "decimal(10,2)", "comment": "应收金额"},
    {"name": "sfje", "type": "decimal(10,2)", "comment": "收费金额"},
    {"name": "qfje", "type": "decimal(10,2)", "comment": "欠费金额"},
    {"name": "zkje", "type": "decimal(10,2)", "comment": "折扣金额"},
    {"name": "wyje", "type": "decimal(10,2)", "comment": "违约金额"},
    {"name": "hjje", "type": "decimal(10,2)", "comment": "核减金额"},
    {"name": "zf", "type": "tinyint", "comment": "是否作废：0-正常 1-作废"}
  ]
}
```

#### pay_order 缴费订单表

```json
{
  "tableName": "pay_order",
  "tableComment": "缴费订单表",
  "columns": [
    {"name": "id", "type": "bigint", "comment": "主键", "isPK": true},
    {"name": "customer_id", "type": "bigint", "comment": "用户主键", "fk": "customer.id"},
    {"name": "mjjs_id", "type": "bigint", "comment": "面积结算主键"},
    {"name": "cnq", "type": "varchar(10)", "comment": "采暖期"},
    {"name": "fylb", "type": "varchar(10)", "comment": "费用类别"},
    {"name": "sfje", "type": "decimal(10,2)", "comment": "收费金额"},
    {"name": "zkje", "type": "decimal(10,2)", "comment": "折扣金额"},
    {"name": "wyje", "type": "decimal(10,2)", "comment": "违约金额"},
    {"name": "sfzt", "type": "tinyint", "comment": "收费状态：0-未收费 1-收费"},
    {"name": "bill_date", "type": "datetime", "comment": "订单时间"},
    {"name": "pay_date", "type": "datetime", "comment": "支付时间"},
    {"name": "source", "type": "varchar(30)", "comment": "缴费渠道"},
    {"name": "czy", "type": "varchar(50)", "comment": "操作员"}
  ]
}
```

### 3.3 表关系

```
customer (用户)
    │
    ├── 1:N ── sf_js_t (收费结算) ── cnq (采暖期)
    │
    └── 1:N ── pay_order (缴费订单) ── cnq, fylb (费用类别)
```

---

## 四、向量知识库设计

### 4.1 存储结构

在 PostgreSQL 元数据库 `heating_analytics` 中创建向量知识库表：

```sql
-- 表结构知识库
CREATE TABLE s2_schema_knowledge (
    id BIGSERIAL PRIMARY KEY,
    table_name VARCHAR(64) NOT NULL,           -- 表名
    table_comment VARCHAR(255),                  -- 表注释
    column_name VARCHAR(64),                    -- 列名
    column_comment VARCHAR(255),                -- 列注释
    column_type VARCHAR(32),                     -- 列类型
    is_primary_key BOOLEAN DEFAULT FALSE,       -- 是否主键
    is_foreign_key BOOLEAN DEFAULT FALSE,       -- 是否外键
    fk_reference VARCHAR(128),                  -- 外键引用
    knowledge_text TEXT NOT NULL,               -- 知识库文本（用于 embedding）
    embedding VECTOR(1024),                      -- 向量（bge-m3 维度）
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 创建索引
CREATE INDEX idx_schema_embedding ON s2_schema_knowledge USING ivfflat (embedding vector_cosine_ops);
CREATE INDEX idx_table_name ON s2_schema_knowledge(table_name);
```

### 4.2 知识文本格式

每条记录的知识文本格式如下：

```
表名: customer
表注释: 用户信息表
列: id (bigint) - 用户主键 [主键]
列: code (varchar) - 用户编码 [唯一索引]
列: name (varchar) - 用户名称
列: mob_no (varchar) - 手机号
列: tel_no (varchar) - 座机号
列: yhlx (varchar) - 用户类型，取值: 居民/单位
列: one/two/three (varchar) - 一级/二级/三级地区
列: address (varchar) - 地址
列: kz_sf (tinyint) - 是否允许收费: 0-否 1-是
列: kz_hmd (tinyint) - 是否黑名单: 0-否 1-是
```

---

## 五、Prompt 工程设计

### 5.1 SQL 生成 Prompt

```prompt
你是专业的 SQL 生成专家，擅长根据表结构信息将自然语言转换为准确的 SQL 查询。

## 可用的表结构信息
{schema_context}

## 当前时间
{current_time}

## 业务规则
1. MySQL 数据库，SQL 语句使用标准语法
2. 字段名和表名使用反引号包裹，如 `customer`.`name`
3. 字符串值使用单引号，如 WHERE `yhlx` = '居民'
4. 金额比较使用 DECIMAL 类型，注意精度
5. 日期时间使用 'YYYY-MM-DD' 或 'YYYY-MM-DD HH:MI:SS' 格式

## 输出要求
1. 只输出 SQL 语句，不要其他解释
2. SQL 语句必须完整，可直接执行
3. 使用合理的 JOIN 连接表
4. 注意字段的类型匹配

## 用户问题
{user_question}

## 生成的 SQL
```

### 5.2 Schema 检索 Prompt

```prompt
从以下表结构知识中，检索与用户问题相关的表和字段。

用户问题: {question}

相关表结构:
{retrieved_schemas}

请提取：
1. 需要的表列表
2. 每个表需要的字段
3. 表之间的关联关系
4. 可能的查询条件
```

---

## 六、核心服务实现

### 6.1 项目模块结构

```
supersonic/
├── core/
│   └── text2sql/
│       ├── Text2SqlService.java           # 核心服务
│       ├── SchemaKnowledgeService.java    # 知识库服务
│       ├── EmbeddingService.java           # 向量化服务
│       ├── SqlGeneratorService.java        # SQL 生成服务
│       └── parser/
│           ├── QuestionParser.java        # 问题解析
│           └── IntentClassifier.java      # 意图分类
├── controller/
│   └── Text2SqlController.java            # API 控制器
└── dto/
    ├── Text2SqlRequest.java               # 请求 DTO
    ├── Text2SqlResponse.java              # 响应 DTO
    └── SchemaKnowledge.java               # 知识库实体
```

### 6.2 核心类设计

#### Text2SqlService 核心服务

```java
@Service
public class Text2SqlService {

    @Autowired
    private SchemaKnowledgeService schemaService;

    @Autowired
    private EmbeddingService embeddingService;

    @Autowired
    private SqlGeneratorService sqlGenerator;

    public Text2SqlResponse convert(String question) {
        // 1. 检索相关表结构
        List<SchemaKnowledge> schemas = schemaService.retrieve(question, topK = 5);

        // 2. 构建上下文
        String schemaContext = buildSchemaContext(schemas);

        // 3. 生成 SQL
        String sql = sqlGenerator.generate(question, schemaContext);

        // 4. 验证 SQL（可选）
        boolean valid = validateSql(sql);

        return Text2SqlResponse.builder()
                .question(question)
                .sql(sql)
                .schemas(schemas)
                .valid(valid)
                .build();
    }
}
```

#### SchemaKnowledgeService 知识库服务

```java
@Service
public class SchemaKnowledgeService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private EmbeddingService embeddingService;

    private static final String RETRIEVE_SQL = """
        SELECT id, table_name, table_comment, column_name, column_comment,
               column_type, knowledge_text, embedding
        FROM s2_schema_knowledge
        WHERE 1=1
        ORDER BY embedding <=> ?::vector
        LIMIT ?
        """;

    public List<SchemaKnowledge> retrieve(String question, int topK) {
        // 1. 问题向量化
        float[] embedding = embeddingService.embed(question);

        // 2. 向量检索
        List<SchemaKnowledge> results = jdbcTemplate.query(
            RETRIEVE_SQL,
            new Object[]{embedding, topK},
            new SchemaRowMapper()
        );

        return results;
    }

    public void buildKnowledgeBase(String sqlFilePath) {
        // 1. 解析 SQL 文件
        List<TableSchema> tables = SqlParser.parse(sqlFilePath);

        // 2. 生成知识文本
        for (TableSchema table : tables) {
            for (ColumnSchema column : table.getColumns()) {
                SchemaKnowledge knowledge = buildKnowledgeText(table, column);
                // 3. 向量化
                float[] embedding = embeddingService.embed(knowledge.getKnowledgeText());
                knowledge.setEmbedding(embedding);
                // 4. 存储
                save(knowledge);
            }
        }
    }
}
```

#### EmbeddingService 向量化服务

```java
@Service
public class EmbeddingService {

    @Value("${ollama.url:http://192.168.1.10:11435}")
    private String ollamaUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    public float[] embed(String text) {
        String url = ollamaUrl + "/api/embeddings";

        Map<String, Object> request = new HashMap<>();
        request.put("model", "bge-m3:latest");
        request.put("prompt", text);

        Map response = restTemplate.postForObject(url, request, Map.class);

        @SuppressWarnings("unchecked")
        List<Number> embedding = (List<Number>) response.get("embedding");

        return embedding.stream()
            .mapToDouble(Number::doubleValue)
            .mapToFloat(i -> (float) i)
            .toArray();
    }
}
```

#### SqlGeneratorService SQL 生成服务

```java
@Service
public class SqlGeneratorService {

    @Value("${llm.api.url:https://api.minimaxi.com/v1}")
    private String apiUrl;

    @Value("${llm.api.key:}")
    private String apiKey;

    @Value("${llm.model: MiniMax-M2.7}")
    private String model;

    private final RestTemplate restTemplate = new RestTemplate();

    private static final String SQL_GENERATION_PROMPT = """
        你是专业的 SQL 生成专家，擅长根据表结构信息将自然语言转换为准确的 SQL 查询。

        ## 可用的表结构信息
        %s

        ## 当前时间
        %s

        ## 业务规则
        1. MySQL 数据库，SQL 语句使用标准语法
        2. 字段名和表名使用反引号包裹
        3. 字符串值使用单引号
        4. 金额比较使用 DECIMAL 类型

        ## 输出要求
        1. 只输出 SQL 语句，不要其他解释
        2. SQL 语句必须完整，可直接执行

        ## 用户问题
        %s

        ## 生成的 SQL
        """;

    public String generate(String question, String schemaContext) {
        String prompt = String.format(
            SQL_GENERATION_PROMPT,
            schemaContext,
            LocalDateTime.now().toString(),
            question
        );

        return callLlm(prompt);
    }

    private String callLlm(String prompt) {
        String url = apiUrl + "/chat/completions";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(apiKey);

        Map<String, Object> request = Map.of(
            "model", model,
            "messages", List.of(
                Map.of("role", "user", "content", prompt)
            ),
            "temperature", 0.0,
            "max_tokens", 1000
        );

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(request, headers);
        Map<String, Object> response = restTemplate.postForObject(url, entity, Map.class);

        @SuppressWarnings("unchecked")
        List<Map<String, Object>> choices = (List<Map<String, Object>>) response.get("choices");
        Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");

        return (String) message.get("content");
    }
}
```

---

## 七、API 接口设计

### 7.1 Text-to-SQL 转换

```
POST /api/text2sql/convert
Content-Type: application/json

Request:
{
    "question": "查询本采暖期欠费用户有哪些？",
    "database": "mysql_sf_charge"
}

Response:
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

### 7.2 SQL 执行（可选）

```
POST /api/text2sql/execute
Content-Type: application/json

Request:
{
    "sql": "SELECT c.`name`, c.`mob_no` FROM `customer` c WHERE c.`yhlx` = '居民'"
}

Response:
{
    "code": 200,
    "message": "success",
    "data": {
        "columns": ["name", "mob_no"],
        "rows": [
            {"name": "张三", "mob_no": "13800138000"},
            {"name": "李四", "mob_no": "13900139000"}
        ],
        "total": 2
    }
}
```

### 7.3 知识库构建

```
POST /api/text2sql/knowledge/build
Content-Type: application/json

Request:
{
    "sqlFilePath": "e:\\trae\\supersonic\\sql\\charge_zbhx_20260303.sql",
    "targetTables": ["customer", "sf_js_t", "pay_order"]
}

Response:
{
    "code": 200,
    "message": "success",
    "data": {
        "totalTables": 3,
        "totalColumns": 45,
        "knowledgeCount": 45
    }
}
```

---

## 八、知识库构建流程

### 8.1 离线构建脚本

```java
@Component
public class SchemaInitializer implements CommandLineRunner {

    @Autowired
    private SchemaKnowledgeService schemaService;

    @Override
    public void run(String... args) {
        String sqlFilePath = "e:\\trae\\supersonic\\sql\\charge_zbhx_20260303.sql";

        log.info("开始构建表结构知识库...");
        long startTime = System.currentTimeMillis();

        try {
            int count = schemaService.buildKnowledgeBase(sqlFilePath);
            long duration = System.currentTimeMillis() - startTime;
            log.info("知识库构建完成，共 {} 条记录，耗时 {} ms", count, duration);
        } catch (Exception e) {
            log.error("知识库构建失败", e);
        }
    }
}
```

### 8.2 SQL 解析工具

```java
public class SqlFileParser {

    public List<TableSchema> parse(String filePath) throws Exception {
        String content = Files.readString(Path.of(filePath));
        List<TableSchema> tables = new ArrayList<>();

        // 使用正则提取 CREATE TABLE 语句
        Pattern pattern = Pattern.compile(
            "CREATE TABLE `(\\w+)`\\s*\\((.*?)\\)\\s*ENGINE",
            Pattern.DOTALL
        );

        Matcher matcher = pattern.matcher(content);
        while (matcher.find()) {
            String tableName = matcher.group(1);
            String columnsBlock = matcher.group(2);

            TableSchema table = new TableSchema();
            table.setTableName(tableName);
            table.setColumns(parseColumns(columnsBlock));

            tables.add(table);
        }

        return tables;
    }

    private List<ColumnSchema> parseColumns(String block) {
        List<ColumnSchema> columns = new ArrayList<>();
        String[] lines = block.split("\n");

        for (String line : lines) {
            line = line.trim();
            if (line.isEmpty() || line.startsWith("PRIMARY KEY")
                || line.startsWith("INDEX") || line.startsWith("KEY")
                || line.startsWith("CONSTRAINT") || line.startsWith("--")) {
                continue;
            }

            // 解析列定义
            Pattern colPattern = Pattern.compile(
                "`?(\\w+)`?\\s+([\\w\\(,\\s']+)(?:\\s+COMMENT\\s+'([^']+)')?"
            );
            Matcher colMatcher = colPattern.matcher(line);

            if (colMatcher.find()) {
                ColumnSchema column = new ColumnSchema();
                column.setColumnName(colMatcher.group(1));
                column.setColumnType(colMatcher.group(2).trim());
                column.setColumnComment(colMatcher.group(3));
                columns.add(column);
            }
        }

        return columns;
    }
}
```

---

## 九、测试用例

### 9.1 功能测试用例

| 序号 | 用户问题 | 预期 SQL |
|------|----------|----------|
| 1 | 查询所有居民用户 | `SELECT * FROM customer WHERE yhlx = '居民'` |
| 2 | 本采暖期欠费用户有哪些？ | `SELECT c.name, c.mob_no, s.qfje FROM customer c JOIN sf_js_t s ON c.id = s.customer_id WHERE s.cnq = '2025-2026' AND s.qfje > 0` |
| 3 | 查询某个用户的缴费记录 | `SELECT * FROM pay_order WHERE customer_id = ?` |
| 4 | 统计本采暖期缴费金额超过1000元的用户 | `SELECT c.name, SUM(p.sfje) as total FROM customer c JOIN pay_order p ON c.id = p.customer_id WHERE p.cnq = '2025-2026' GROUP BY c.id, c.name HAVING total > 1000` |
| 5 | 查询某个地区的所有用户 | `SELECT * FROM customer WHERE one = 'XX区'` |

### 9.2 边界测试用例

| 序号 | 用户问题 | 预期行为 |
|------|----------|----------|
| 1 | 无意义问题 | 返回错误提示 |
| 2 | 跨多表复杂查询 | 正确 JOIN |
| 3 | 聚合查询 | 正确使用 GROUP BY |
| 4 | 空结果查询 | 返回空结果 |

---

## 十、部署方案

### 10.1 依赖组件

| 组件 | 版本 | 说明 |
|------|------|------|
| Java | JDK 21 | 运行环境 |
| PostgreSQL | - | 向量存储（pgvector） |
| Ollama | - | Embedding 服务 |
| MiniMax API | - | LLM 服务 |

### 10.2 配置项

```yaml
# application-local.yaml
text2sql:
  enabled: true
  ollama:
    url: http://192.168.1.10:11435
    model: bge-m3:latest
  llm:
    api-url: https://api.minimaxi.com/v1
    model: MiniMax-M2.7
    temperature: 0.0
    timeout: 120
  knowledge:
    build-on-startup: false
    target-tables:
      - customer
      - sf_js_t
      - pay_order
      - contract_info
      - area
```

### 10.3 部署步骤

1. **编译项目**
   ```powershell
   mvnd clean package -DskipTests -pl launchers/standalone -am
   ```

2. **初始化向量扩展**（如未安装）
   ```sql
   CREATE EXTENSION IF NOT EXISTS vector;
   ```

3. **构建知识库**
   - 方式一：调用 API `POST /api/text2sql/knowledge/build`
   - 方式二：启动时自动构建（配置 `build-on-startup: true`）

4. **重启服务**
   ```powershell
   taskkill /F /IM java.exe
   java -Xmx2g -Xms1g -jar launchers-standalone-0.9.10.jar
   ```

---

## 十一、常见问题与优化

### 11.1 SQL 准确率优化

| 问题 | 解决方案 |
|------|----------|
| 字段映射错误 | 丰富 Schema 描述，增加同义词 |
| JOIN 条件错误 | 完善外键关系描述 |
| 聚合函数错误 | 明确业务指标定义 |
| 边界条件错误 | 增加示例 SQL |

### 11.2 性能优化

| 优化项 | 方案 |
|--------|------|
| Embedding 缓存 | 对相同问题缓存向量结果 |
| Schema 缓存 | 本地缓存热点 Schema |
| LLM 调用优化 | 使用 streaming 减少等待 |

### 11.3 安全考虑

1. **SQL 注入防护**
   - LLM 生成的 SQL 需经过语法验证
   - 禁止直接拼接用户输入

2. **权限控制**
   - 只允许查询授权的表和字段
   - 添加数据脱敏规则

3. **审计日志**
   - 记录所有 SQL 生成请求
   - 保存生成的 SQL 备查

---

## 十二、后续扩展

### 12.1 QuestionParser 问题解析器

问题解析器负责对用户输入的自然语言问题进行预处理和结构化。

#### 12.1.1 功能设计

| 功能 | 说明 |
|------|------|
| 问题规范化 | 去除口语化表达，统一术语 |
| 时间表达式识别 | 解析"本采暖期"、"上月"、"近30天"等 |
| 实体提取 | 提取用户名称、地址、地区等实体 |
| 条件补全 | 补全省略的查询条件 |

#### 12.1.2 实现方案

```java
@Service
public class QuestionParser {

    @Autowired
    private EmbeddingService embeddingService;

    public ParsedQuestion parse(String question) {
        ParsedQuestion parsed = new ParsedQuestion();
        parsed.setOriginalQuestion(question);

        // 1. 时间表达式识别
        parsed.setTimeExpressions(extractTimeExpressions(question));

        // 2. 实体提取
        parsed.setEntities(extractEntities(question));

        // 3. 查询意图识别
        parsed.setIntent(detectIntent(question));

        // 4. 条件补全
        parsed.setConditions(extractConditions(question));

        return parsed;
    }

    private List<TimeExpression> extractTimeExpressions(String question) {
        List<TimeExpression> expressions = new ArrayList<>();
        // 采暖期识别：本采暖期、上一采暖期
        // 日期范围识别：近30天、2024年1月
        // 季节识别：夏季、冬季
        return expressions;
    }

    private List<Entity> extractEntities(String question) {
        // 用户名提取
        // 地址提取
        // 地区提取
    }
}
```

#### 12.1.3 时间表达式映射

| 表达式 | 映射值 |
|--------|--------|
| 本采暖期 | cnq = '2025-2026' |
| 上一采暖期 | cnq = '2024-2025' |
| 本月 | bill_date BETWEEN '2026-04-01' AND '2026-04-30' |
| 近30天 | bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) |

---

### 12.2 IntentClassifier 意图分类器

意图分类器识别用户查询的类型，决定后续处理流程。

#### 12.2.1 意图类型

| 意图 | 英文 | 说明 |
|------|------|------|
| 明细查询 | QUERY_DETAIL | 查询具体记录 |
| 统计汇总 | QUERY_AGGREGATE | 统计计数、求和等 |
| 对比分析 | QUERY_COMPARE | 对比不同维度 |
| 排名查询 | QUERY_RANKING | Top N 查询 |
| 趋势分析 | QUERY_TREND | 时间趋势分析 |
| 导出数据 | EXPORT_DATA | 导出查询结果 |
| 未知 | UNKNOWN | 无法识别的意图 |

#### 12.2.2 实现方案

```java
@Service
public class IntentClassifier {

    private static final Map<String, IntentType> INTENT_KEYWORDS = Map.of(
        "统计", IntentType.QUERY_AGGREGATE,
        "有多少", IntentType.QUERY_AGGREGATE,
        "合计", IntentType.QUERY_AGGREGATE,
        "平均", IntentType.QUERY_AGGREGATE,
        "对比", IntentType.QUERY_COMPARE,
        "排名", IntentType.QUERY_RANKING,
        "前10", IntentType.QUERY_RANKING,
        "导出", IntentType.EXPORT_DATA,
        "下载", IntentType.EXPORT_DATA
    );

    public IntentType classify(String question) {
        for (Map.Entry<String, IntentType> entry : INTENT_KEYWORDS.entrySet()) {
            if (question.contains(entry.getKey())) {
                return entry.getValue();
            }
        }

        if (question.contains("多少") || question.contains("总计")) {
            return IntentType.QUERY_AGGREGATE;
        }

        return IntentType.QUERY_DETAIL;
    }

    public ConfidenceScore getConfidence(String question, IntentType intent) {
        // 返回分类置信度
        return new ConfidenceScore(intent, 0.95);
    }
}
```

---

### 12.3 SQL 执行 API

执行生成的 SQL 并返回结果。

#### 12.3.1 API 设计

```
POST /api/text2sql/execute
Content-Type: application/json

Request:
{
    "sql": "SELECT c.name, c.mob_no, s.qfje FROM customer c JOIN sf_js_t s ON c.id = s.customer_id WHERE s.cnq = '2025-2026'",
    "limit": 100,
    "offset": 0
}

Response:
{
    "code": 200,
    "message": "success",
    "data": {
        "columns": ["name", "mob_no", "qfje"],
        "rows": [
            {"name": "张三", "mob_no": "138****8000", "qfje": 1500.00},
            {"name": "李四", "mob_no": "139****9000", "qfje": 2300.50}
        ],
        "total": 156,
        "limit": 100,
        "offset": 0,
        "executionTime": 125
    }
}
```

#### 12.3.2 实现方案

```java
@Service
public class SqlExecutorService {

    @Autowired
    private DataSource dataSource;

    public QueryResult execute(String sql, int limit, int offset) {
        String paginatedSql = sql + String.format(" LIMIT %d OFFSET %d", limit, offset);

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(paginatedSql);
             ResultSet rs = stmt.executeQuery()) {

            QueryResult result = new QueryResult();
            result.setColumns(extractColumns(rs));
            result.setRows(extractRows(rs));
            result.setLimit(limit);
            result.setOffset(offset);

            return result;
        }
    }

    private List<Map<String, Object>> extractRows(ResultSet rs) {
        List<Map<String, Object>> rows = new ArrayList<>();
        while (rs.next()) {
            Map<String, Object> row = new LinkedHashMap<>();
            ResultSetMetaData metaData = rs.getMetaData();
            for (int i = 1; i <= metaData.getColumnCount(); i++) {
                row.put(metaData.getColumnLabel(i), rs.getObject(i));
            }
            rows.add(row);
        }
        return rows;
    }
}
```

---

### 12.4 多数据源切换

支持从多个业务数据库查询。

#### 12.4.1 数据源配置

```yaml
text2sql:
  datasources:
    - id: mysql_sf_charge
      name: 供热收费系统
      type: MYSQL
      host: 192.168.1.7
      port: 7001
      database: charge_zbhx_20260303
      username: root
      password: Huilian1234
    - id: mysql_his
      name: 历史数据系统
      type: MYSQL
      host: 192.168.1.8
      port: 3306
      database: charge_history
      username: root
      password: Huilian1234
```

#### 12.4.2 API 设计

```
POST /api/text2sql/convert
Request:
{
    "question": "查询本采暖期欠费用户",
    "database": "mysql_sf_charge"
}
```

#### 12.4.3 实现方案

```java
@Service
public class MultiDataSourceService {

    private Map<String, DataSource> dataSources = new ConcurrentHashMap<>();

    public DataSource getDataSource(String datasourceId) {
        return dataSources.get(datasourceId);
    }

    public List<DatasourceInfo> getAvailableDatasources() {
        return dataSources.entrySet().stream()
            .map(e -> new DatasourceInfo(e.getKey(), getDatabaseName(e.getValue())))
            .collect(Collectors.toList());
    }
}
```

---

### 12.5 SQL 解释功能

对生成的 SQL 进行自然语言解释。

#### 12.5.1 API 设计

```
POST /api/text2sql/explain
Request:
{
    "sql": "SELECT c.name FROM customer c WHERE c.yhlx = '居民'"
}

Response:
{
    "code": 200,
    "message": "success",
    "data": {
        "sql": "SELECT c.name FROM customer c WHERE c.yhlx = '居民'",
        "explanation": "查询所有居民类型的用户姓名。",
        "tables": ["customer"],
        "conditions": [
            {
                "field": "yhlx",
                "operator": "=",
                "value": "居民",
                "meaning": "用户类型为居民"
            }
        ],
        "estimatedRows": 85000
    }
}
```

---

### 12.6 查询结果导出

支持将查询结果导出为 Excel、CSV 等格式。

#### 12.6.1 API 设计

```
POST /api/text2sql/export
Request:
{
    "sql": "SELECT * FROM customer LIMIT 1000",
    "format": "xlsx",
    "filename": "用户数据导出"
}

Response:
- Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
- Content-Disposition: attachment; filename=用户数据导出.xlsx
```

---

### 12.7 短期扩展清单

| 功能 | 优先级 | 状态 | 负责人 |
|------|--------|------|--------|
| QuestionParser | P1 | 待开发 | - |
| IntentClassifier | P1 | 待开发 | - |
| SQL 执行 API | P1 | 待开发 | - |
| SQL 解释功能 | P2 | 待开发 | - |
| 多数据源切换 | P2 | 待开发 | - |
| 结果导出 | P3 | 待开发 | - |

### 12.8 长期规划

| 功能 | 优先级 | 状态 | 说明 |
|------|--------|------|------|
| Fine-tune 专用模型 | P2 | 规划中 | 训练专用 Text-to-SQL 模型 |
| 复杂业务逻辑校验 | P2 | 规划中 | 增加业务规则校验层 |
| 对接 SuperSonic 语义层 | P1 | 规划中 | 复用语义层指标维度 |
| 多轮对话支持 | P3 | 规划中 | 支持上下文关联查询 |
| 语音输入 | P3 | 规划中 | 语音转文字后查询 |

---

## 附录

### A. 参考资料

- [LangChain4j 文档](https://docs.langchain4j.ai/)
- [pgvector 使用指南](https://github.com/pgvector/pgvector)
- [MiniMax API 文档](https://www.minimaxi.com/document)

### B. 更新记录

| 日期 | 版本 | 更新内容 |
|------|------|----------|
| 2026-04-16 | 1.0 | 初始版本 |
| 2026-04-18 | 1.1 | 补充完善方案：多轮对话、QuestionParser、IntentClassifier、矛盾检测等 |

---

## 十三、完善方案详细设计

### 13.1 多轮对话支持

#### 13.1.1 问题分析

当前系统每轮对话独立处理，无法记住上下文。用户问"本采暖期欠费用户有哪些？"后，无法追问"这些用户的地址分布？"。

#### 13.1.2 实现方案

**新增表结构：**

```sql
-- 对话上下文表
CREATE TABLE s2_wiki_conversation_context (
    id BIGSERIAL PRIMARY KEY,
    conversation_id VARCHAR(64) NOT NULL,     -- 对话会话ID
    user_id VARCHAR(64) NOT NULL,             -- 用户ID
    round_number INT NOT NULL,                 -- 对话轮次
    user_message TEXT NOT NULL,                -- 用户消息
    generated_sql TEXT,                        -- 生成的SQL
    sql_result JSONB,                          -- SQL执行结果（摘要）
    referenced_entities TEXT[],                 -- 本轮引用的实体列表
    referenced_cards TEXT[],                   -- 本轮引用的知识卡片
    parent_conversation_id VARCHAR(64),         -- 父对话ID（用于分支）
    context_snapshot JSONB,                    -- 上下文快照
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expired_at TIMESTAMP,                      -- 过期时间（默认30分钟）
    status VARCHAR(16) DEFAULT 'ACTIVE'        -- ACTIVE/EXPIRED/ARCHIVED
);

CREATE INDEX idx_conversation_id ON s2_wiki_conversation_context(conversation_id);
CREATE INDEX idx_user_id ON s2_wiki_conversation_context(user_id);
CREATE INDEX idx_created_at ON s2_wiki_conversation_context(created_at);
```

**核心服务实现：**

```java
@Service
@Slf4j
public class ConversationContextService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private static final int CONTEXT_EXPIRE_MINUTES = 30;
    private static final int MAX_CONTEXT_ROUNDS = 20;

    /**
     * 保存对话上下文
     */
    public ConversationContext saveContext(String conversationId, String userId,
            String userMessage, String generatedSql, Object sqlResult,
            List<String> referencedEntities, List<String> referencedCards) {

        // 1. 获取当前轮次
        int roundNumber = getMaxRoundNumber(conversationId) + 1;

        // 2. 构建上下文快照
        JsonNode snapshot = buildContextSnapshot(conversationId, roundNumber);

        // 3. 保存上下文
        String sql = """
            INSERT INTO s2_wiki_conversation_context
            (conversation_id, user_id, round_number, user_message, generated_sql,
             sql_result, referenced_entities, referenced_cards, context_snapshot, expired_at)
            VALUES (?, ?, ?, ?, ?, ?::jsonb, ?, ?, ?, ?)
            """;

        jdbcTemplate.update(sql, conversationId, userId, roundNumber, userMessage,
                generatedSql, JsonUtils.toJson(sqlResult), referencedEntities.toArray(),
                referencedCards.toArray(), JsonUtils.toJson(snapshot),
                LocalDateTime.now().plusMinutes(CONTEXT_EXPIRE_MINUTES));

        return ConversationContext.builder()
                .conversationId(conversationId)
                .roundNumber(roundNumber)
                .userMessage(userMessage)
                .generatedSql(generatedSql)
                .referencedEntities(referencedEntities)
                .build();
    }

    /**
     * 获取对话上下文（用于下一轮对话）
     */
    public ConversationContext getContext(String conversationId) {
        String sql = """
            SELECT * FROM s2_wiki_conversation_context
            WHERE conversation_id = ? AND status = 'ACTIVE'
            ORDER BY round_number DESC
            LIMIT 1
            """;
        return jdbcTemplate.queryForObject(sql, new ConversationContextRowMapper(),
                conversationId);
    }

    /**
     * 获取历史对话（最近N轮）
     */
    public List<ConversationContext> getRecentContexts(String conversationId, int limit) {
        String sql = """
            SELECT * FROM s2_wiki_conversation_context
            WHERE conversation_id = ? AND status = 'ACTIVE'
            ORDER BY round_number DESC
            LIMIT ?
            """;
        return jdbcTemplate.query(sql, new ConversationContextRowMapper(), conversationId, limit);
    }

    /**
     * 构建上下文快照（用于传递给LLM）
     */
    public String buildContextPrompt(List<ConversationContext> contexts) {
        if (CollectionUtils.isEmpty(contexts)) {
            return "";
        }

        StringBuilder prompt = new StringBuilder("\n## 对话历史上下文\n");
        for (ConversationContext ctx : contexts) {
            prompt.append(String.format("【第%d轮】用户: %s\n", ctx.getRoundNumber(), ctx.getUserMessage()));
            if (StringUtils.isNotEmpty(ctx.getGeneratedSql())) {
                prompt.append(String.format("      SQL: %s\n", ctx.getGeneratedSql()));
            }
        }
        prompt.append("\n请结合上述上下文理解用户当前问题。\n");
        return prompt.toString();
    }

    /**
     * 清理过期上下文
     */
    @Scheduled(fixedRate = 300000) // 每5分钟执行一次
    public void cleanupExpiredContexts() {
        String sql = """
            UPDATE s2_wiki_conversation_context
            SET status = 'EXPIRED'
            WHERE status = 'ACTIVE' AND expired_at < NOW()
            """;
        int updated = jdbcTemplate.update(sql);
        log.info("Cleaned up {} expired conversation contexts", updated);
    }
}
```

**修改后的 SQL 生成 Prompt：**

```java
// 在 OnePassSCSqlGenStrategy.java 的 INSTRUCTION 中添加：
private static final String INSTRUCTION_WITH_CONTEXT = """
    #Role: You are a data analyst experienced in SQL languages."
    + "\n#Task: You will be provided with a natural language question asked by users,"
    + "please convert it to a SQL query."
    + "\n#Context: {context}"
    + "\n#Rules:"
    + "\n1.If the current question refers to previous context (e.g., 'these users', 'the same period'),"
    + "use the context to understand what entities or conditions are being referenced."
    + "\n2. When context contains previous SQL, you can:"
    + "   - Use previous tables/joins as base"
    + "   - Add new filters based on previous results"
    + "   - Create nested queries referencing previous CTEs"
    + "\n3.SQL columns and values must be mentioned in the Schema, DO NOT hallucinate."
    + "\n4.Always use context to resolve pronouns and implicit references."
    + "\n#Exemplars: {exemplar}"
    + "\n#Query: Question:{question},Schema:{schema},SideInfo:{information}";
```

**API 扩展：**

```
GET  /api/text2sql/conversation/{conversationId}/context
     返回：{contexts: [...], currentRound: 3}

DELETE /api/text2sql/conversation/{conversationId}/context
     清除对话上下文，重新开始
```

---

### 13.2 QuestionParser 问题解析器

#### 13.2.1 功能设计

| 功能 | 说明 |
|------|------|
| 时间表达式识别 | 解析"本采暖期"、"上月"、"近30天"等 |
| 实体提取 | 提取用户名、地址、地区等实体 |
| 条件补全 | 补全省略的查询条件 |
| 口语规范化 | 去除口语化表达，统一术语 |

#### 13.2.2 核心实现

```java
@Service
@Slf4j
public class QuestionParser {

    // 时间表达式映射
    private static final Map<String, String> TIME_EXPRESSION_MAP = new LinkedHashMap<>();
    private static final Pattern CNQ_PATTERN = Pattern.compile("(\\d{4})-(\\d{4})");

    static {
        // 采暖期表达式
        TIME_EXPRESSION_MAP.put("本采暖期", "cnq = '2025-2026'");
        TIME_EXPRESSION_MAP.put("上一采暖期", "cnq = '2024-2025'");
        TIME_EXPRESSION_MAP.put("当前采暖期", "cnq = '2025-2026'");

        // 日期范围表达式
        TIME_EXPRESSION_MAP.put("本月", "MONTH(CURRENT_DATE)");
        TIME_EXPRESSION_MAP.put("上月", "MONTH(DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH))");
        TIME_EXPRESSION_MAP.put("本季度", "QUARTER(CURRENT_DATE)");
        TIME_EXPRESSION_MAP.put("近30天", "DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)");
        TIME_EXPRESSION_MAP.put("近7天", "DATE_SUB(CURRENT_DATE, INTERVAL 7 DAY)");
        TIME_EXPRESSION_MAP.put("今年以来", "YEAR(CURRENT_DATE)");
    }

    @Autowired
    private EmbeddingService embeddingService;

    /**
     * 解析问题
     */
    public ParsedQuestion parse(String question, ConversationContext context) {
        ParsedQuestion parsed = new ParsedQuestion();
        parsed.setOriginalQuestion(question);

        // 1. 时间表达式识别
        parsed.setTimeExpressions(extractTimeExpressions(question));

        // 2. 实体提取（用户名、地址、地区）
        parsed.setEntities(extractEntities(question));

        // 3. 上下文引用解析
        if (context != null) {
            parsed.setContextReferences(resolveContextReferences(question, context));
        }

        // 4. 查询意图识别
        parsed.setIntent(detectIntent(question));

        // 5. 口语规范化
        parsed.setNormalizedQuestion(normalizeQuestion(question));

        // 6. 条件补全
        parsed.setConditions(extractAndCompleteConditions(parsed, context));

        return parsed;
    }

    /**
     * 提取时间表达式
     */
    private List<TimeExpression> extractTimeExpressions(String question) {
        List<TimeExpression> expressions = new ArrayList<>();

        for (Map.Entry<String, String> entry : TIME_EXPRESSION_MAP.entrySet()) {
            if (question.contains(entry.getKey())) {
                TimeExpression te = new TimeExpression();
                te.setExpression(entry.getKey());
                te.setSqlCondition(entry.getValue());
                te.setRangeType(determineRangeType(entry.getKey()));
                expressions.add(te);
            }
        }

        // 特殊处理：直接指定采暖期如"2024-2025采暖期"
        Matcher cnqMatcher = CNQ_PATTERN.matcher(question);
        if (cnqMatcher.find()) {
            TimeExpression te = new TimeExpression();
            te.setExpression(cnqMatcher.group());
            te.setSqlCondition(String.format("cnq = '%s'", cnqMatcher.group()));
            te.setRangeType(RangeType.CNQ);
            expressions.add(te);
        }

        return expressions;
    }

    /**
     * 提取实体（用户名、地址、地区）
     */
    private List<ExtractedEntity> extractEntities(String question) {
        List<ExtractedEntity> entities = new ArrayList<>();

        // 地址模式：XX市XX区XX街道/小区
        Pattern addressPattern = Pattern.compile("([\\u4e00-\\u9fa5]+市)?([\\u4e00-\\u9fa5]+区)?([\\u4e00-\\u9fa5]+(?:街道|小区|路))?");
        Matcher addressMatcher = addressPattern.matcher(question);
        while (addressMatcher.find()) {
            if (addressMatcher.group().length() >= 2) {
                ExtractedEntity entity = new ExtractedEntity();
                entity.setType("ADDRESS");
                entity.setValue(addressMatcher.group());
                entities.add(entity);
            }
        }

        // 手机号模式
        Pattern phonePattern = Pattern.compile("1[3-9]\\d{9}");
        Matcher phoneMatcher = phonePattern.matcher(question);
        while (phoneMatcher.find()) {
            ExtractedEntity entity = new ExtractedEntity();
            entity.setType("PHONE");
            entity.setValue(phoneMatcher.group());
            entities.add(entity);
        }

        // 用户名模式（需要结合业务词典）
        // ...

        return entities;
    }

    /**
     * 解析上下文引用
     */
    private List<ContextReference> resolveContextReferences(String question,
            ConversationContext context) {
        List<ContextReference> references = new ArrayList<>();

        // 代词映射
        Map<String, String> pronounMap = Map.of(
            "这些用户", "previous_users",
            "那些人", "previous_users",
            "同样", "same_condition",
            "这个地区", "previous_area",
            "继续", "continue_query"
        );

        for (Map.Entry<String, String> entry : pronounMap.entrySet()) {
            if (question.contains(entry.getKey())) {
                ContextReference ref = new ContextReference();
                ref.setPronoun(entry.getKey());
                ref.setReferenceType(entry.getValue());
                ref.setSourceRound(context.getRoundNumber());
                references.add(ref);
            }
        }

        return references;
    }

    /**
     * 口语规范化
     */
    private String normalizeQuestion(String question) {
        String normalized = question;

        // 口语化转标准术语
        normalized = normalized.replace("咋", "怎么");
        normalized = normalized.replace("啥", "什么");
        normalized = normalized.replace("有没有", "查询");
        normalized = normalized.replace("给我查一下", "查询");
        normalized = normalized.replace("帮我看看", "查询");

        // 去除多余空格
        normalized = normalized.replaceAll("\\s+", " ").trim();

        return normalized;
    }

    /**
     * 补全查询条件
     */
    private List<QueryCondition> extractAndCompleteConditions(ParsedQuestion parsed,
            ConversationContext context) {
        List<QueryCondition> conditions = new ArrayList<>();

        // 从解析出的时间表达式添加条件
        for (TimeExpression te : parsed.getTimeExpressions()) {
            if (te.getSqlCondition().contains("cnq")) {
                conditions.add(QueryCondition.builder()
                        .field("cnq")
                        .operator("=")
                        .value(extractCnqValue(te.getSqlCondition()))
                        .source("time_expression")
                        .build());
            }
        }

        // 如果上下文有采暖期且当前问题没有指定，沿用上下文
        if (context != null && StringUtils.isNotEmpty(context.getGeneratedSql())) {
            if (parsed.getTimeExpressions().isEmpty() && containsAggregation(parsed.getIntent())) {
                // 沿用上次的采暖期条件
                String previousCnq = extractCnqFromSql(context.getGeneratedSql());
                if (previousCnq != null) {
                    conditions.add(QueryCondition.builder()
                            .field("cnq")
                            .operator("=")
                            .value(previousCnq)
                            .source("context_inheritance")
                            .build());
                }
            }
        }

        return conditions;
    }
}
```

**时间表达式映射表：**

| 表达式 | SQL 条件 | 说明 |
|--------|----------|------|
| 本采暖期 | `cnq = '2025-2026'` | 需要根据当前日期动态计算 |
| 上一采暖期 | `cnq = '2024-2025'` | 自动推断 |
| 本月 | `MONTH(bill_date) = MONTH(CURRENT_DATE)` | 当前月份 |
| 上月 | `MONTH(bill_date) = MONTH(DATE_SUB(...))` | 上一个自然月 |
| 近30天 | `bill_date >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY)` | 动态计算 |
| 本季度 | `QUARTER(bill_date) = QUARTER(CURRENT_DATE)` | 当前季度 |

---

### 13.3 IntentClassifier 意图分类器

#### 13.3.1 意图类型定义

| 意图 | 英文 | 关键词 | SQL 模式 |
|------|------|--------|----------|
| 明细查询 | QUERY_DETAIL | 查询、看看、有哪些 | SELECT + WHERE |
| 统计汇总 | QUERY_AGGREGATE | 统计、多少、总计、合计 | SELECT + GROUP BY + 聚合函数 |
| 对比分析 | QUERY_COMPARE | 对比、差异、相比 | SELECT + GROUP BY + 排序 |
| 排名查询 | QUERY_RANKING | 排名、前10、Top N | ORDER BY + LIMIT |
| 趋势分析 | QUERY_TREND | 趋势、变化、增长 | SELECT + GROUP BY + 时间维度 |
| 导出数据 | EXPORT_DATA | 导出、下载 | SELECT + EXPORT |
| 未知 | UNKNOWN | - | - |

#### 13.3.2 核心实现

```java
@Service
@Slf4j
public class IntentClassifier {

    // 意图关键词映射
    private static final Map<IntentType, List<String>> INTENT_KEYWORDS = new EnumMap<>(IntentType.class);

    static {
        INTENT_KEYWORDS.put(IntentType.QUERY_AGGREGATE, Arrays.asList(
            "统计", "多少", "总计", "合计", "总共", "共有", "平均",
            "求和", "汇总", "总数", "总金额", "总数量", "count", "sum", "avg"
        ));

        INTENT_KEYWORDS.put(IntentType.QUERY_COMPARE, Arrays.asList(
            "对比", "比较", "差异", "差别", "区别", "不同于", "相比"
        ));

        INTENT_KEYWORDS.put(IntentType.QUERY_RANKING, Arrays.asList(
            "排名", "前", "top", "top10", "top5", "最高", "最低",
            "最多", "最少", "最大", "最小", "最贵", "最便宜"
        ));

        INTENT_KEYWORDS.put(IntentType.QUERY_TREND, Arrays.asList(
            "趋势", "变化", "增长", "下降", "走势", "同比", "环比",
            "增加", "减少", "增幅", "降幅"
        ));

        INTENT_KEYWORDS.put(IntentType.EXPORT_DATA, Arrays.asList(
            "导出", "下载", "excel", "csv", "报表"
        ));
    }

    /**
     * 分类用户意图
     */
    public IntentType classify(String question) {
        String normalizedQuestion = question.toLowerCase();

        // 按优先级逐一匹配
        for (Map.Entry<IntentType, List<String>> entry : INTENT_KEYWORDS.entrySet()) {
            for (String keyword : entry.getValue()) {
                if (normalizedQuestion.contains(keyword.toLowerCase())) {
                    return entry.getKey();
                }
            }
        }

        // 默认明细查询
        return IntentType.QUERY_DETAIL;
    }

    /**
     * 获取分类置信度
     */
    public ConfidenceScore getConfidence(String question, IntentType intent) {
        String normalizedQuestion = question.toLowerCase();

        List<String> intentKeywords = INTENT_KEYWORDS.get(intent);
        if (intentKeywords == null) {
            return new ConfidenceScore(intent, 0.5);
        }

        int matchCount = 0;
        for (String keyword : intentKeywords) {
            if (normalizedQuestion.contains(keyword.toLowerCase())) {
                matchCount++;
            }
        }

        double confidence = Math.min(0.5 + (matchCount * 0.15), 0.95);
        return new ConfidenceScore(intent, confidence);
    }

    /**
     * 根据意图调整 SQL 生成策略
     */
    public SqlGenerationStrategy adjustStrategy(IntentType intent, String baseSchema) {
        switch (intent) {
            case QUERY_AGGREGATE:
                return SqlGenerationStrategy.builder()
                        .useGroupBy(true)
                        .requiredAggregations(true)
                        .defaultLimit(1000)
                        .build();

            case QUERY_RANKING:
                return SqlGenerationStrategy.builder()
                        .useOrderBy(true)
                        .defaultLimit(10)
                        .build();

            case QUERY_TREND:
                return SqlGenerationStrategy.builder()
                        .useGroupBy(true)
                        .timeDimensionRequired(true)
                        .build();

            default:
                return SqlGenerationStrategy.builder().build();
        }
    }

    @Data
    @AllArgsConstructor
    public static class ConfidenceScore {
        private IntentType intent;
        private double confidence;
    }

    @Data
    @Builder
    public static class SqlGenerationStrategy {
        private boolean useGroupBy;
        private boolean requiredAggregations;
        private boolean timeDimensionRequired;
        private boolean useOrderBy;
        private int defaultLimit;
    }
}
```

---

### 13.4 矛盾检测完整实现

#### 13.4.1 核心服务

```java
@Service
@Slf4j
public class WikiContradictionService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private WikiKnowledgeService knowledgeService;

    /**
     * 检测矛盾
     */
    public Contradiction detectContradiction(WikiKnowledgeCard newCard,
            List<WikiKnowledgeCard> existingCards) {
        Contradiction contradiction = null;

        for (WikiKnowledgeCard existingCard : existingCards) {
            if (!isSameEntity(newCard, existingCard)) {
                continue;
            }

            double similarity = calculateSimilarity(newCard, existingCard);
            if (similarity > 0.7 && isContradictory(newCard, existingCard)) {
                contradiction = buildContradiction(newCard, existingCard, similarity);
                break;
            }
        }

        return contradiction;
    }

    /**
     * 计算两个卡片是否矛盾
     */
    private boolean isContradictory(WikiKnowledgeCard card1, WikiKnowledgeCard card2) {
        // 1. 类型相同但含义冲突
        if (card1.getCardType().equals(card2.getCardType())) {
            return isSemanticConflict(card1.getContent(), card2.getContent());
        }

        // 2. 不同类型但存在逻辑冲突
        // 例如：一个是"欠费>0表示欠费"，另一个是"欠费=0表示已结清"
        return false;
    }

    /**
     * 语义冲突检测
     */
    private boolean isSemanticConflict(String content1, String content2) {
        // 使用关键词检测
        String[] posKeywords = {"大于0", ">", "欠费", "未结清"};
        String[] negKeywords = {"等于0", "=", "已结清", "已付清"};

        boolean hasPositive = containsAny(content1, posKeywords)
                || containsAny(content2, posKeywords);
        boolean hasNegative = containsAny(content1, negKeywords)
                || containsAny(content2, negKeywords);

        return hasPositive && hasNegative;
    }

    /**
     * 保存矛盾记录
     */
    public void saveContradiction(Contradiction contradiction) {
        String sql = """
            INSERT INTO s2_wiki_contradiction
            (contradiction_id, entity_id, old_knowledge_card_id, conflict_type,
             old_content, new_evidence, evidence_source, impact, resolution, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())
            ON CONFLICT (contradiction_id) DO UPDATE SET
                resolution = EXCLUDED.resolution,
                updated_at = NOW()
            """;

        jdbcTemplate.update(sql,
                contradiction.getContradictionId(),
                contradiction.getEntityId(),
                contradiction.getOldKnowledgeCardId(),
                contradiction.getConflictType().name(),
                contradiction.getOldContent(),
                contradiction.getNewEvidence(),
                contradiction.getEvidenceSource(),
                contradiction.getImpact(),
                contradiction.getResolution().name());
    }

    /**
     * 解决矛盾
     */
    public void resolveContradiction(String contradictionId, Resolution resolution) {
        Contradiction contradiction = getContradictionById(contradictionId);
        if (contradiction == null) {
            throw new IllegalArgumentException("Contradiction not found: " + contradictionId);
        }

        switch (resolution) {
            case ACCEPT_NEW:
                // 接受新知识，标记旧卡片为过时
                knowledgeService.deprecateCard(contradiction.getOldKnowledgeCardId());
                break;

            case KEEP_OLD:
                // 保留旧知识，忽略新证据
                break;

            case MERGE:
                // 合并两者，创建新版本
                mergeCards(contradiction);
                break;

            case DISMISS:
                // 忽略
                break;
        }

        // 更新矛盾状态
        updateContradictionStatus(contradictionId, resolution);
    }
}
```

#### 13.4.2 矛盾处理 API

```
GET  /api/wiki/contradictions?status=PENDING
     返回所有待处理的矛盾

POST /api/wiki/contradictions/{id}/resolve
Request:
{
    "resolution": "ACCEPT_NEW|KEEP_OLD|MERGE|DISMISS",
    "mergeContent": "合并后的内容（当resolution=MERGE时）"
}
```

---

### 13.5 SQL 执行与验证 API

#### 13.5.1 核心服务

```java
@Service
@Slf4j
public class SqlExecutorService {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private WikiSqlValidationService validationService;

    @Autowired
    private SqlRewriteService rewriteService;

    /**
     * 执行 SQL
     */
    public QueryResult execute(String sql, int limit, int offset, String datasourceId) {
        // 1. SQL 验证
        ValidationResult validation = validationService.validate(sql);
        if (!validation.isValid()) {
            throw new SqlValidationException(validation.getErrorMessage());
        }

        // 2. SQL 重写（根据数据库类型调整语法）
        String rewrittenSql = rewriteService.rewrite(sql, datasourceId);

        // 3. 添加分页
        String paginatedSql = addPagination(rewrittenSql, limit, offset);

        // 4. 执行
        long startTime = System.currentTimeMillis();
        try (Connection conn = dataSource.getConnection(datasourceId);
             PreparedStatement stmt = conn.prepareStatement(paginatedSql);
             ResultSet rs = stmt.executeQuery()) {

            QueryResult result = new QueryResult();
            result.setColumns(extractColumns(rs));
            result.setRows(extractRows(rs, limit));
            result.setTotal(CountHelper.count(conn, rewrittenSql)); // 实际生产中需要优化
            result.setLimit(limit);
            result.setOffset(offset);
            result.setExecutionTime(System.currentTimeMillis() - startTime);

            return result;
        } catch (SQLException e) {
            log.error("SQL execution failed: {}", sql, e);
            throw new SqlExecutionException("SQL执行失败: " + e.getMessage());
        }
    }

    /**
     * SQL 验证
     */
    public ValidationResult validate(String sql) {
        ValidationResult result = new ValidationResult();

        // 1. 基础语法检查
        if (!isValidSqlSyntax(sql)) {
            result.setValid(false);
            result.setErrorMessage("SQL 语法错误");
            return result;
        }

        // 2. 只允许 SELECT 语句
        if (!isSelectStatement(sql)) {
            result.setValid(false);
            result.setErrorMessage("只允许 SELECT 查询语句");
            return result;
        }

        // 3. 禁止危险关键字
        if (containsDangerousKeywords(sql)) {
            result.setValid(false);
            result.setErrorMessage("SQL 包含禁止的关键字");
            return result;
        }

        // 4. 表权限检查
        List<String> tables = extractTableNames(sql);
        if (!permissionService.hasReadPermission(tables)) {
            result.setValid(false);
            result.setErrorMessage("无权访问部分表");
            return result;
        }

        result.setValid(true);
        return result;
    }

    /**
     * SQL 解释
     */
    public SqlExplanation explain(String sql, String datasourceId) {
        SqlExplanation explanation = new SqlExplanation();
        explanation.setSql(sql);

        // 解析表
        explanation.setTables(extractTableNames(sql));

        // 解析条件
        explanation.setConditions(extractConditions(sql));

        // 解析聚合函数
        explanation.setAggregations(extractAggregations(sql));

        // 生成自然语言描述
        explanation.setNaturalLanguage(generateNaturalLanguage(sql));

        return explanation;
    }
}
```

#### 13.5.2 API 接口

```
POST /api/text2sql/execute
Content-Type: application/json

Request:
{
    "sql": "SELECT c.name, c.mob_no, s.qfje FROM customer c JOIN sf_js_t s ON c.id = s.customer_id WHERE s.cnq = '2025-2026'",
    "limit": 100,
    "offset": 0,
    "datasourceId": "mysql_sf_charge"
}

Response:
{
    "code": 200,
    "message": "success",
    "data": {
        "columns": ["name", "mob_no", "qfje"],
        "rows": [
            {"name": "张三", "mob_no": "138****8000", "qfje": 1500.00}
        ],
        "total": 156,
        "limit": 100,
        "offset": 0,
        "executionTime": 125
    }
}

---

POST /api/text2sql/validate
Request:
{
    "sql": "SELECT * FROM customer"
}

Response:
{
    "code": 200,
    "data": {
        "valid": true,
        "tables": ["customer"],
        "warnings": ["建议指定具体字段而非 SELECT *"]
    }
}

---

POST /api/text2sql/explain
Request:
{
    "sql": "SELECT c.name, COUNT(*) FROM customer c GROUP BY c.name"
}

Response:
{
    "code": 200,
    "data": {
        "sql": "SELECT c.name, COUNT(*) FROM customer c GROUP BY c.name",
        "explanation": "查询每个用户的名称及其出现次数（用户数量统计）",
        "tables": ["customer"],
        "conditions": [],
        "aggregations": ["COUNT(*)"],
        "groupBy": ["c.name"]
    }
}
```

---

### 13.6 数据权限与脱敏

#### 13.6.1 权限控制

```java
@Service
@Slf4j
public class DataPermissionService {

    /**
     * 检查用户是否有权访问指定表
     */
    public boolean hasReadPermission(String userId, String tableName) {
        // 从权限配置中检查
        Set<String> allowedTables = getAllowedTables(userId);
        return allowedTables.contains(tableName);
    }

    /**
     * 字段级权限控制
     */
    public Set<String> filterAccessibleFields(String userId, Set<String> fields) {
        Map<String, Set<String>> fieldPermissions = getFieldPermissions(userId);
        return fields.stream()
                .filter(field -> isFieldAccessible(userId, field))
                .collect(Collectors.toSet());
    }

    /**
     * 脱敏处理
     */
    public Object maskSensitiveData(String fieldName, Object value, String userId) {
        if (!isSensitiveField(fieldName)) {
            return value;
        }

        // 手机号：138****8000
        if (isPhoneField(fieldName)) {
            return maskPhone(value.toString());
        }

        // 身份证：110***********1234
        if (isIdCardField(fieldName)) {
            return maskIdCard(value.toString());
        }

        // 地址：只显示到区
        if (isAddressField(fieldName)) {
            return maskAddress(value.toString());
        }

        return value;
    }
}
```

---

### 13.7 项目模块结构（完善后）

```
supersonic/
├── core/
│   └── text2sql/
│       ├── Text2SqlService.java              # 核心服务（整合各组件）
│       ├── ConversationContextService.java    # 多轮对话上下文服务
│       ├── QuestionParser.java               # 问题解析器
│       ├── IntentClassifier.java             # 意图分类器
│       ├── SqlExecutorService.java           # SQL 执行服务
│       ├── SqlRewriteService.java            # SQL 重写服务
│       ├── DataPermissionService.java        # 数据权限服务
│       └── EmbeddingService.java             # 向量化服务
├── headless/
│   └── chat/
│       ├── parser/
│       │   └── llm/
│       │       └── OnePassSCSqlGenStrategy.java  # 已有的 LLM SQL 生成
│       └── knowledge/
│           └── MetaEmbeddingService.java     # 知识检索
└── wiki/
    ├── WikiChatService.java                  # Wiki 对话服务
    ├── WikiContradictionService.java        # 矛盾检测服务
    └── WikiKnowledgeService.java             # 知识卡片服务
```

---

### 13.8 完善功能优先级

| 优先级 | 功能 | 工作量 | 价值 | 说明 |
|--------|------|--------|------|------|
| P0 | 多轮对话上下文 | 中 | 极高 | 核心体验，竞品差异化 |
| P0 | QuestionParser 时间表达式 | 小 | 高 | 口语化支持，即插即用 |
| P0 | SQL 执行 API | 中 | 极高 | 完整闭环，文档已设计 |
| P1 | IntentClassifier | 小 | 高 | 提升 SQL 准确率 |
| P1 | SQL 验证 + 解释 | 中 | 高 | 用户友好性 |
| P2 | 矛盾检测完整实现 | 大 | 中 | 知识库质量保障 |
| P2 | 数据权限 + 脱敏 | 中 | 中 | 企业级需求 |
| P3 | 结果导出 | 小 | 低 | 附加功能 |
