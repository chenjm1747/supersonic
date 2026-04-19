# SuperSonic 项目规则

## 一、项目概述

- **项目名称**: SuperSonic 供热收费客服智能分析平台
- **版本**: 0.9.10
- **项目路径**: `E:\trae\supersonic`

## 二、技术栈

| 组件 | 版本/路径 |
|------|-----------|
| Java | JDK 21 (`D:\java\jdk-21.0.10.7-hotspot`) |
| Maven | mvnd 1.0.5 (`D:\maven-mvnd-1.0.5-windows-amd64\bin\mvnd.exe`) |
| 数据库 | PostgreSQL (192.168.1.10:5432) - 数据库:postgres, 模式:heating_analytics |
| 前端 | Node.js 18+ |
| Ollama | 192.168.1.10:11435 |
| 服务端口 | 9080 |

## 三、编译命令

### 3.1 完整编译

```powershell
cd E:\trae\supersonic
$env:JAVA_HOME = "D:\java\jdk-21.0.10.7-hotspot"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
& "D:\maven-mvnd-1.0.5-windows-amd64\bin\mvnd.exe" clean package -DskipTests
```

### 3.2 快速编译（推荐）

```powershell
cd E:\trae\supersonic
$env:JAVA_HOME = "D:\java\jdk-21.0.10.7-hotspot"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
& "D:\maven-mvnd-1.0.5-windows-amd64\bin\mvnd.exe" clean package -DskipTests -pl launchers/standalone -am
```

### 3.3 前端编译

```powershell
cd E:\trae\supersonic\webapp\packages\supersonic-fe
npm run build:os
```

### 3.4 前端部署

```powershell
cd E:\trae\supersonic
xcopy /E /Y "webapp\packages\supersonic-fe\dist\*" "launchers\standalone\target\classes\static\"
```

## 四、启动命令

### 4.1 停止所有 Java 进程

```powershell
taskkill /F /IM java.exe
```

### 4.2 启动服务（推荐）

```powershell
& "D:\java\jdk-21.0.10.7-hotspot\bin\java.exe" -Xmx2g -Xms1g -jar "E:\trae\supersonic\launchers\standalone\target\launchers-standalone-0.9.10.jar"
```

### 4.3 验证服务状态

```powershell
netstat -ano | findstr "9080"
```

## 五、服务地址

| 服务 | 地址 |
|------|------|
| Web 应用 | http://localhost:9080 |
| Swagger API | http://localhost:9080/swagger-ui.html |
| Knife4j | http://localhost:9080/doc.html |

## 六、日志位置

```powershell
E:\trae\supersonic\launchers\standalone\logs\
```

日志文件：
- `s2-info.log` - 信息日志
- `s2-error.log` - 错误日志
- `s2-llm.log` - LLM 调用日志
- `serviceinfo.chat.log` - Chat 服务日志

## 七、数据库连接

### 7.1 数据库概览

| 数据库 ID | 名称 | 类型 | 业务数据 | 模型配置 |
|-----------|------|------|----------|----------|
| 1 | S2数据库DEMO | PostgreSQL | ❌ (废弃) | ❌ (仅演示) |
| **2** | **mysql_sf_charge** | **MySQL** | **✅ 业务数据** | **✅ 模型配置** |

### 7.2 PostgreSQL 元数据库（系统配置）

| 配置项 | 值 |
|--------|-----|
| 主机 | 192.168.1.10 |
| 端口 | 5432 |
| 数据库 | postgres |
| 模式 | heating_analytics |
| 用户 | postgres |
| 密码 | Huilian1234 |

**用途**：存储 SuperSonic 系统配置（数据集、数据模型、指标、维度等元数据）

### 7.3 MySQL 业务数据库

| 配置项 | 值 |
|--------|-----|
| 主机 | 192.168.1.7 |
| 端口 | 7001 |
| 数据库 | charge_zbhx_20260303 |
| 用户 | root |
| 密码 | Huilian1234 |

**用途**：存储供热收费实际业务数据（用户、收费、采暖期等）

### 7.4 配置文件位置

应用程序使用 `launchers\standalone\src\main\resources\application-local.yaml` 配置数据库连接。

### 7.5 使用 psql 连接

```powershell
# 连接 PostgreSQL 元数据库
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;"
```

### 7.6 业务数据表（MySQL）

| 表名 | 说明 |
|------|------|
| customer | 用户表 |
| sf_js_t | 结算表（包含 cnq 采暖期、fylb 费用类别） |
| pay_order | 缴费订单表 |

### 7.7 初始化数据库

```powershell
# 创建模式
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.10:5432/postgres" -c "CREATE SCHEMA IF NOT EXISTS heating_analytics;"

# 创建表结构
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers\standalone\src\main\resources\db\schema-postgres.sql"

# 导入基础数据
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers\standalone\src\main\resources\db\data-postgres.sql"

# 导入演示数据（可选）
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers\standalone\src\main\resources\db\data-postgres-demo.sql"
```

## 八、关键表结构

### 8.1 核心表（PostgreSQL 元数据库）

| 表名 | 说明 |
|------|------|
| s2_domain | 域/主题域 |
| s2_data_set | 数据集配置 |
| s2_model | 数据模型（关联 MySQL 业务表） |
| s2_metric | 指标定义 |
| s2_dimension | 维度定义 |
| s2_database | 数据库连接配置 |
| s2_system_config | 系统配置 |
| s2_chat_model | LLM 模型配置 |
| s2_chat_config | Chat 配置 |

### 8.2 数据集与模型关联（重要）

| 数据集 ID | 数据集名称 | 关联模型 ID | 模型名称 | 说明 |
|------------|------------|-------------|----------|------|
| 12 | 用户维度数据集 | 22 | 用户维度模型 | ❌ 无采暖期字段 |
| 17 | 收费结算数据集 | 26 | 收费结算事实模型 | ✅ 有 cnq、fylb 字段 |

**注意**：查询 "本采暖期缴费用户数量" 应使用 **收费结算数据集(id=17)**，因为模型 26 包含 `cnq`(采暖期) 和 `fylb`(费用类别) 字段。

## 九、模型配置

### 9.1 Embedding 模型（Ollama）

| 配置项 | 值 |
|--------|-----|
| 地址 | http://192.168.1.10:11435 |
| 模型 | bge-m3:latest |
| Provider | OLLAMA |
| 维度 | 1024 |

### 9.2 Chat 模型（MiniMax）

| 配置项 | 值 |
|--------|-----|
| 地址 | https://api.minimaxi.com/v1 |
| 模型 | MiniMax-M2.7 |
| Provider | OPEN_AI（兼容模式） |
| API 版本 | 2026-02-01 |
| Temperature | 0.0 |
| Timeout | 120s |

### 9.3 数据库中的模型配置

```sql
-- 查看 s2_chat_model 表中的 chat 模型配置
SET search_path TO heating_analytics;
SELECT id, name, config::json->>'provider' as provider, config::json->>'modelName' as model_name FROM s2_chat_model;

-- 查看当前使用的 chat 配置
SELECT id, model_id FROM s2_chat_config;
```

### 9.4 更新 Embedding 模型配置

```sql
-- 查看当前 embedding 配置
SET search_path TO heating_analytics;
SELECT (jsonb_array_elements(parameters::jsonb)->>'name') as param_name,
       (jsonb_array_elements(parameters::jsonb)->>'value') as param_value
FROM s2_system_config, jsonb_array_elements(parameters::jsonb)
WHERE (jsonb_array_elements->>'name') LIKE 's2.embedding%';
```

### 9.5 更新 Chat 模型配置

```sql
-- 将 s2_chat_config 的 model_id 设置为 MiniMax-M2.7 (id=2)
SET search_path TO heating_analytics;
UPDATE s2_chat_config SET model_id = 2 WHERE id = (SELECT id FROM s2_chat_config LIMIT 1);
```

## 十、代码规范

### 10.1 不要使用的模式

**❌ 禁止**: 在类加载时创建外部连接（如 Ollama 连接）

```java
// 错误示例 - 会导致启动失败
public static final EmbeddingModel MODEL = new OllamaEmbeddingModel(...);

// 正确示例 - 延迟初始化
public static EmbeddingModel getModel() {
    if (model == null) {
        model = new OllamaEmbeddingModel(...);
    }
    return model;
}
```

### 10.2 临时文件

所有临时脚本和文件应放在 `temp` 目录下：

```powershell
E:\trae\supersonic\temp\
```

## 十一、常见问题

### Q1: Maven 编译失败，提示 Java 版本错误

```powershell
$env:JAVA_HOME = "D:\java\jdk-21.0.10.7-hotspot"
$env:PATH = "$env:JAVA_HOME\bin;$env:PATH"
```

### Q2: 服务启动后立即关闭

检查日志中的 `EmbeddingModelConstant` 错误，确保不使用类加载时初始化的静态字段连接外部服务。

### Q3: API 返回 500 错误

1. 检查 `s2-error.log` 或 `s2-info.log`
2. 确认数据库连接正常
3. 确认 Ollama 服务可用

## 十二、工作流程

1. **修改代码** → 修改源代码
2. **编译** → `mvnd clean package -DskipTests -pl launchers/standalone -am`
3. **停止服务** → `taskkill /F /IM java.exe`
4. **启动服务** → `java -Xmx2g -Xms1g -jar launchers-standalone-0.9.10.jar`
5. **验证** → `netstat -ano | findstr 9080`

## 十三、目录结构规范

```
supersonic-v0.9.10/
├── doc/          # 方案和文档目录
│   ├── 项目分析报告.md
│   ├── 技术方案.md
│   ├── 测试用例.md
│   └── 编译和启动指南.md  # 编译和启动详细说明
├── temp/         # 临时调试文件目录
│   └── *.py       # 一次性调试脚本
└── ...
```

## 十四、文件类型归属

| 文件类型 | 存放目录 |
|---------|---------|
| 方案文档 | `doc/` |
| 技术文档 | `doc/` |
| 测试用例 | `doc/` |
| 调试脚本 | `temp/` |
| 临时SQL | `temp/` |
| 配置文件 | `config/` |
| 业务代码 | 各模块目录 |

## 十五、注意事项

### 15.1 代码规范
1. **不要使用 bat 脚本启动服务**，使用 PowerShell 命令直接启动
2. **不要在类加载时创建外部连接**（如 Ollama 连接），会导致启动失败
3. **不要在代码中硬编码数据库连接信息**（IP、密码等）

### 15.2 文件管理
4. **不要在项目根目录放置任何临时调试文件**，统一放在 `temp/` 目录
5. **不要在 `doc/` 或其他业务目录放置临时脚本**

### 15.3 开发流程
6. **启动前必须先停止所有 Java 进程**，避免端口冲突
7. **每次代码修改后需要重新编译**，增量编译使用 `-pl launchers/standalone -am`

### 15.4 Git 提交
- `temp/` 目录建议添加到 `.gitignore`
- 只提交必要的业务代码和文档
