# ETL数据同步使用指南

## 一、环境要求

### 1.1 Python环境

```bash
# Python 3.8+
python --version

# 安装依赖
pip install psycopg2-binary mysql-connector-python pandas schedule
```

### 1.2 数据库要求

- **MySQL**: charge_zbhx数据库，需要读取权限
- **PostgreSQL**: heating_analytics模式，需要读写权限

---

## 二、快速开始

### 2.1 配置数据库连接

编辑 `etl_config.json` 文件，配置数据库连接信息：

```json
{
    "mysql": {
        "host": "192.168.1.7",
        "port": 3306,
        "database": "charge_zbhx",
        "user": "root",
        "password": "your_mysql_password"
    },
    "postgresql": {
        "host": "192.168.1.7",
        "port": 54321,
        "database": "postgres",
        "schema": "heating_analytics",
        "user": "postgres",
        "password": "Huilian1234"
    }
}
```

### 2.2 执行同步

```bash
# 进入temp目录
cd e:\trae\supersonic\temp

# 执行全量同步
python etl_sync.py

# 查看日志
type etl_sync.log
```

### 2.3 执行特定同步

```python
from etl_sync import ETLSync

etl = ETLSync()

# 只同步用户数据
etl.sync_customer()

# 只同步收费明细
etl.sync_payment()

# 只刷新汇总表
etl.refresh_summary()
```

---

## 三、定时任务配置

### 3.1 Windows任务计划程序

```powershell
# 创建定时任务
# 1. 打开"任务计划程序"
# 2. 创建基本任务
# 3. 设置触发器: 每天凌晨2:00
# 4. 操作: 启动程序
#    程序: python.exe
#    参数: E:\trae\supersonic\temp\etl_sync.py

# 命令行创建
$action = New-ScheduledTaskAction -Execute "python.exe" -Argument "E:\trae\supersonic\temp\etl_sync.py"
$trigger = New-ScheduledTaskTrigger -Daily -At "02:00"
Register-ScheduledTask -TaskName "ETL_HeatingCharge" -Action $action -Trigger $trigger
```

### 3.2 Linux crontab

```bash
# 编辑crontab
crontab -e

# 每天凌晨2点执行全量同步
0 2 * * * cd /path/to/temp && python etl_sync.py >> /var/log/etl_sync.log 2>&1

# 每小时执行增量同步
0 * * * * cd /path/to/temp && python -c "from etl_sync import ETLSync; ETLSync().incremental_sync()" >> /var/log/etl_incremental.log 2>&1
```

---

## 四、同步模式说明

### 4.1 全量同步 (full_sync)

- 同步所有维度表数据
- 同步所有收费结算数据
- 同步增量收费明细
- 刷新所有汇总表
- **执行频率**: 每日1次（建议凌晨）

### 4.2 增量同步 (incremental_sync)

- 只同步新增的收费明细记录
- 基于ID增量获取
- **执行频率**: 每小时1次

### 4.3 汇总刷新 (refresh_summary)

- 刷新采暖期收费汇总
- 刷新月度收费汇总
- 刷新每日收费汇总
- 刷新欠费分析汇总
- **执行频率**: 每日凌晨

---

## 五、同步数据对应关系

| 源表(MySQL) | 目标表(PostgreSQL) | 同步方式 | 说明 |
|-------------|-------------------|---------|------|
| customer | sf_dim_customer | 增量 | 用户信息 |
| sys_address | sf_dim_org | 全量 | 组织架构 |
| sf_mjjs_t | sf_rpt_charge | 增量 | 收费结算 |
| sf_mjsf_t | sf_rpt_payment | 增量(ID) | 收费明细 |
| - | sf_rpt_cnq_charge | 刷新 | 汇总表 |
| - | sf_rpt_month_charge | 刷新 | 月度汇总 |
| - | sf_rpt_daily_charge | 刷新 | 日汇总 |
| - | sf_rpt_arrears | 刷新 | 欠费汇总 |

---

## 六、日志查看

### 6.1 Python脚本日志

```bash
# 查看ETL同步日志
type etl_sync.log

# 过滤成功记录
findstr "SUCCESS" etl_sync.log

# 过滤失败记录
findstr "FAILED" etl_sync.log
```

### 6.2 数据库日志表

```sql
-- 查看最近同步记录
SELECT * FROM sf_sync_log ORDER BY create_time DESC LIMIT 20;

-- 查看同步失败记录
SELECT * FROM sf_sync_log WHERE sync_status LIKE 'FAILED%';

-- 统计每日同步量
SELECT 
    DATE(create_time) AS sync_date,
    table_name,
    SUM(records_processed) AS total_records
FROM sf_sync_log
GROUP BY DATE(create_time), table_name
ORDER BY sync_date DESC;
```

---

## 七、故障排查

### 7.1 MySQL连接失败

```python
# 测试MySQL连接
import mysql.connector

try:
    conn = mysql.connector.connect(
        host='192.168.1.7',
        port=3306,
        database='charge_zbhx',
        user='root',
        password='your_password'
    )
    print("MySQL连接成功")
    conn.close()
except Exception as e:
    print(f"MySQL连接失败: {e}")
```

### 7.2 PostgreSQL连接失败

```python
# 测试PostgreSQL连接
import psycopg2

try:
    conn = psycopg2.connect(
        host='192.168.1.7',
        port=54321,
        database='postgres',
        user='postgres',
        password='your_password',
        options='-c search_path=heating_analytics'
    )
    print("PostgreSQL连接成功")
    conn.close()
except Exception as e:
    print(f"PostgreSQL连接失败: {e}")
```

### 7.3 数据不一致排查

```sql
-- 对比源表和目标表记录数
SELECT 'MySQL customer' AS source, COUNT(*) AS cnt FROM mysql_linked_server.customer WHERE zf = 0
UNION ALL
SELECT 'PostgreSQL sf_dim_customer', COUNT(*) FROM sf_dim_customer;

-- 对比源表和目标表金额
SELECT 'MySQL sf_mjjs_t' AS source, SUM(ysje) AS total_ysje FROM mysql_linked_server.sf_mjjs_t WHERE zf = 0 AND cnq = '2025-2026'
UNION ALL
SELECT 'PostgreSQL sf_rpt_charge', SUM(ysje) FROM sf_rpt_charge WHERE cnq = '2025-2026';
```

---

## 八、性能优化

### 8.1 批量大小调整

```python
# 在etl_sync.py中调整batch_size
df = pd.read_sql(query, self.mysql_conn, chunksize=5000)  # 分批读取
```

### 8.2 并行同步

```python
from concurrent.futures import ThreadPoolExecutor

def parallel_sync():
    with ThreadPoolExecutor(max_workers=4) as executor:
        futures = [
            executor.submit(etl.sync_customer),
            executor.submit(etl.sync_org),
            executor.submit(etl.sync_charge),
            executor.submit(etl.sync_payment)
        ]
        for future in futures:
            print(future.result())
```

---

## 九、备份与恢复

### 9.1 同步前备份

```sql
-- 在PostgreSQL中创建备份
CREATE TABLE sf_dim_customer_backup AS SELECT * FROM sf_dim_customer;
CREATE TABLE sf_rpt_charge_backup AS SELECT * FROM sf_rpt_charge;
CREATE TABLE sf_rpt_payment_backup AS SELECT * FROM sf_rpt_payment;
```

### 9.2 从备份恢复

```sql
-- 清空目标表
TRUNCATE sf_dim_customer;
TRUNCATE sf_rpt_charge;
TRUNCATE sf_rpt_payment;

-- 从备份恢复
INSERT INTO sf_dim_customer SELECT * FROM sf_dim_customer_backup;
INSERT INTO sf_rpt_charge SELECT * FROM sf_rpt_charge_backup;
INSERT INTO sf_rpt_payment SELECT * FROM sf_rpt_payment_backup;
```

---

## 十、联系支持

如有问题，请联系数据分析团队。

---

*文档版本: v1.0*
*创建日期: 2026-04-13*
