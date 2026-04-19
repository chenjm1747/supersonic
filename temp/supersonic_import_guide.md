# SuperSonic数据导入问题解决方案

## 问题描述

执行完 `supersonic_semantic_model_insert.sql` 后，前端界面没有显示新建的模型。

## 根本原因

SuperSonic需要在以下表中正确注册数据才能在界面显示：
1. `s2_database` - 数据库连接配置
2. `s2_agent` - Agent配置
3. 所有记录的 `is_open` 状态必须为1

## 解决方案

### 步骤1: 执行数据库注册脚本

```powershell
# 连接到PostgreSQL
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -f "e:\trae\supersonic\temp\supersonic_database_register.sql"
```

或者分步执行：

```powershell
# 1. 先执行基础元数据导入
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -f "e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql"

# 2. 再执行数据库注册
& "D:\Program Files\pgAdmin 4\runtime\psql.exe" "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -f "e:\trae\supersonic\temp\supersonic_database_register.sql"
```

### 步骤2: 重启SuperSonic服务

```powershell
# 停止服务
taskkill /F /IM java.exe

# 启动服务
& "D:\java\jdk-21.0.10.7-hotspot\bin\java.exe" -Xmx2g -Xms1g -jar "E:\trae\supersonic\launchers\standalone\target\launchers-standalone-0.9.10.jar"
```

### 步骤3: 清除浏览器缓存并刷新

1. 按 `Ctrl + Shift + Delete`
2. 选择"所有时间"
3. 勾选"缓存的图片和文件"
4. 点击"清除数据"
5. 刷新页面

## 验证步骤

执行以下SQL验证数据是否正确：

```sql
-- 检查主题域
SELECT * FROM s2_domain;

-- 检查数据模型
SELECT * FROM s2_model;

-- 检查数据库配置
SELECT * FROM s2_database;

-- 检查Agent配置
SELECT * FROM s2_agent;

-- 检查维度数量
SELECT COUNT(*) FROM s2_dimension;

-- 检查指标数量
SELECT COUNT(*) FROM s2_metric;
```

## 一键执行脚本

创建 `import_all.ps1`：

```powershell
# SuperSonic数据导入一键执行脚本

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "SuperSonic 供热收费系统数据导入" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$psqlPath = "D:\Program Files\pgAdmin 4\runtime\psql.exe"
$connStr = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"
$sqlPath = "E:\trae\supersonic\temp"

# 1. 执行基础元数据导入
Write-Host "`n[1/4] 执行基础元数据导入..." -ForegroundColor Yellow
& $psqlPath $connStr -f "$sqlPath\supersonic_semantic_model_insert.sql"

# 2. 执行数据库注册
Write-Host "`n[2/4] 执行数据库注册..." -ForegroundColor Yellow
& $psqlPath $connStr -f "$sqlPath\supersonic_database_register.sql"

# 3. 验证数据
Write-Host "`n[3/4] 验证数据完整性..." -ForegroundColor Yellow
Write-Host "主题域数量:" -NoNewline
& $psqlPath $connStr -t -c "SELECT COUNT(*) FROM s2_domain;"

Write-Host "数据模型数量:" -NoNewline
& $psqlPath $connStr -t -c "SELECT COUNT(*) FROM s2_model;"

Write-Host "维度数量:" -NoNewline
& $psqlPath $connStr -t -c "SELECT COUNT(*) FROM s2_dimension;"

Write-Host "指标数量:" -NoNewline
& $psqlPath $connStr -t -c "SELECT COUNT(*) FROM s2_metric;"

Write-Host "`n[4/4] 导入完成！" -ForegroundColor Green
Write-Host "请重启SuperSonic服务并刷新浏览器" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
```

## 常见问题

### Q1: 执行SQL时报错"relation does not exist"

**原因**: 表不存在，需要先执行建表脚本

**解决**:
```powershell
# 先执行建表
& $psqlPath $connStr -f "E:\trae\supersonic\launchers\standalone\src\main\resources\db\schema-postgres.sql"

# 再执行数据导入
& $psqlPath $connStr -f "e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql"
```

### Q2: 界面仍然不显示

**检查项**:
1. 是否重启了SuperSonic服务？
2. 是否清除了浏览器缓存？
3. is_open字段是否为1？

**快速修复**:
```sql
-- 强制设置所有记录为可见
UPDATE s2_domain SET is_open = 1;
UPDATE s2_model SET is_open = 1;
UPDATE s2_database SET is_open = 1;
```

### Q3: 如何确认数据在哪几个schema？

```sql
-- 查看所有schema
SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT IN ('pg_catalog', 'information_schema');

-- 查看当前search_path
SHOW search_path;

-- 查看表所在的schema
SELECT table_schema, table_name FROM information_schema.tables WHERE table_name LIKE 's2_%';
```

---

*文档版本: v1.0*
*创建日期: 2026-04-13*
