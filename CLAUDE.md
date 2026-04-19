# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 环境要求

| 工具 | 版本/说明 |
|------|-----------|
| JDK | 21 |
| Maven | mvnd 1.0.5+ 或 Maven 3.9+ |
| Node.js | >=16 |
| pnpm | 9.12.3+ |
| PostgreSQL | 192.168.1.10:5432 (项目数据库) |
| Ollama | 192.168.1.10:11435 (LLM服务) |

## Build Commands

### Backend (Java/Maven)

```bash
# 快速编译（推荐，每次代码修改后使用）
mvn clean package -DskipTests -Dspotless.skip=true -pl launchers/standalone -am

# 完整编译（首次或依赖变更时使用）
mvn clean package -DskipTests -Dspotless.skip=true

# 运行单个测试类
mvn test -Dtest=ClassName

# Full CI build
mvn -B package --file pom.xml
```

**编译产物：**
- `launchers/standalone/target/launchers-standalone-1.0.0-SNAPSHOT.jar` - Thin JAR（约 0.1 MB），不可直接运行
- `launchers/standalone/target/launchers-standalone-1.0.0-SNAPSHOT-bin.tar.gz` - 完整包，包含所有依赖

### Frontend (pnpm/React)

```bash
cd webapp/packages/supersonic-fe

# 安装依赖
pnpm install

# 开发模式
pnpm dev

# 生产构建
pnpm build
```

### 数据库初始化

```bash
# 创建模式
psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "CREATE SCHEMA IF NOT EXISTS heating_analytics;"

# 创建表结构
psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers/standalone/src/main/resources/db/schema-postgres.sql"

# 导入基础数据
psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers/standalone/src/main/resources/db/data-postgres.sql"

# 导入演示数据（可选）
psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers/standalone/src/main/resources/db/schema-postgres-demo.sql"
psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "SET search_path TO heating_analytics;" -f "launchers/standalone/src/main/resources/db/data-postgres-demo.sql"
```

### 快速启动

```bash
# 停止现有服务
taskkill /F /IM java.exe

# 编译后端
mvn clean package -DskipTests -Dspotless.skip=true -pl launchers/standalone -am

# 启动服务
java -Xmx2g -Xms1g -jar launchers/standalone/target/launchers-standalone-1.0.0-SNAPSHOT.jar
```

> ⚠️ 必须解压 tar.gz 后才能用 `-jar` 方式启动，jar 文件不包含依赖

### 服务验证

```bash
# 检查端口
netstat -ano | findstr "9080"

# 访问地址
http://localhost:9080          # Web 应用
http://localhost:9080/swagger-ui.html  # Swagger API
http://localhost:9080/doc.html        # Knife4j API文档
```

### 日志

日志目录：`launchers/standalone/logs/`

| 文件 | 说明 |
|------|------|
| s2-info.log | 信息日志 |
| s2-error.log | 错误日志 |
| s2-llm.log | LLM 调用日志 |

```bash
# 实时查看错误日志
Get-Content launchers/standalone/logs/s2-error.log -Tail 50 -Wait
```

### 常见问题排查

```bash
# 检查端口占用
netstat -ano | findstr "9080"

# 检查数据库连接
psql "postgresql://postgres:密码@192.168.1.10:5432/postgres" -c "SELECT 1;"

# 检查 Ollama 服务
Invoke-WebRequest -Uri "http://192.168.1.10:11435/api/tags" -Method Get

# 查看错误日志
Get-Content launchers/standalone/logs/s2-error.log -Tail 100
```

### Windows 开发脚本

```bash
# 一键编译启动（后端+前端，Windows）
assembly\bin\supersonic-dev.bat
```

脚本会自动完成：停止服务 → 编译后端 → 解压 tar.gz → 编译前端 → 部署前端 → 启动服务 → 验证端口

## Architecture Overview

SuperSonic unifies **Chat BI** (LLM-powered) and **Headless BI** (semantic layer) paradigms.

### Core Modules

```
supersonic/
├── auth/           # Authentication & authorization (SPI-based)
├── chat/           # Chat BI module - LLM-powered Q&A interface
├── common/         # Shared utilities
├── headless/       # Headless BI - semantic layer with open API
├── launchers/      # Application entry points
│   ├── standalone/ # Combined Chat + Headless (default)
│   ├── chat/       # Chat-only service
│   └── headless/   # Headless-only service
└── webapp/         # Frontend React app (UmiJS 4 + Ant Design)
```

### Data Flow

1. **Knowledge Base**: Extracts schema from semantic models, builds dictionary/index for schema mapping
2. **Schema Mapper**: Identifies metrics/dimensions/entities/values in user queries
3. **Semantic Parser**: Generates S2SQL (semantic SQL) using rule-based and LLM-based parsers
4. **Semantic Corrector**: Validates and corrects semantic queries
5. **Semantic Translator**: Converts S2SQL to executable SQL

### Key Entry Points

- `StandaloneLauncher.java` - Combined service with `scanBasePackages: ["com.tencent.supersonic", "dev.langchain4j"]`
- `ChatLauncher.java` - Chat BI only
- `HeadlessLauncher.java` - Headless BI only

## Key Technologies

**Backend:** Spring Boot 3.3.9, MyBatis-Plus 3.5.10.1, LangChain4j 0.36.2, JSqlParser 4.9, Calcite 1.38.0

**Frontend:** React 18, UmiJS 4, Ant Design 5.17.4, ECharts 5.0.2, AntV G6/X6

**Databases:** MySQL, PostgreSQL (with pgvector), H2, ClickHouse, StarRocks, Presto, Trino, DuckDB

## Testing

**Java tests:** JUnit 5, Mockito. Located in `src/test/java/` of each module.

**Frontend tests:** Jest with Puppeteer environment in `webapp/packages/supersonic-fe/`

**Evaluation scripts:** Python scripts in `evaluation/` directory for Text2SQL accuracy testing.

## Related Documentation

- [README.md](README.md) - English documentation
- [README_CN.md](README_CN.md) - Chinese documentation
- [Evaluation Guide](evaluation/README.md) - Text2SQL evaluation process
