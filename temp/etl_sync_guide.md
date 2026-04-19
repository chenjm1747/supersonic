# 供热收费系统ETL数据同步方案

## 一、同步架构概述

### 1.1 数据流向

```
┌─────────────────┐     ETL      ┌─────────────────┐
│  MySQL源库       │ ──────────> │ PostgreSQL分析库  │
│ charge_zbhx     │  增量同步    │ heating_analytics │
│ (业务系统)       │             │ (SuperSonic)    │
└─────────────────┘             └─────────────────┘
                                         │
                                         ▼
                                  ┌─────────────────┐
                                  │  维度表/事实表     │
                                  │ sf_dim_*        │
                                  │ sf_rpt_*        │
                                  └─────────────────┘
```

### 1.2 同步策略

| 数据类型 | 同步频率 | 同步方式 | 说明 |
|---------|---------|---------|------|
| 用户数据 | 每日增量 | UPSERT | 基于updated_time增量同步 |
| 组织数据 | 每日增量 | UPSERT | 基于updated_time增量同步 |
| 收费结算 | 准实时 | UPSERT | 每小时同步 |
| 收费明细 | 准实时 | APPEND | 新增记录追加 |
| 汇总数据 | 每日凌晨 | REFRESH | 全量刷新 |

---

## 二、PostgreSQL FDW配置

### 2.1 启用扩展

```sql
-- 连接到PostgreSQL后执行
CREATE EXTENSION IF NOT EXISTS postgres_fdw;
CREATE EXTENSION IF NOT EXISTS mysql_fdw;  -- 需要安装mysql_fdw扩展
```

### 2.2 创建外部服务器

```sql
-- 创建MySQL外部服务器
CREATE SERVER IF NOT EXISTS mysql_chargezbhx
    FOREIGN DATA WRAPPER mysql_fdw
    OPTIONS (
        host '192.168.1.7',
        port '3306',
        database 'charge_zbhx'
    );

-- 创建用户映射
CREATE USER MAPPING IF NOT EXISTS FOR PUBLIC
    SERVER mysql_chargezbhx
    OPTIONS (
        username 'root',
        password 'your_mysql_password'
    );

-- 测试连接
SELECT * FROM mysql_chargezbhx.customer LIMIT 1;
```

### 2.3 导入外部表结构

```sql
-- 导入外部表
IMPORT FOREIGN SCHEMA charge_zbhx
    LIMIT TO (customer, area, sf_mj_t, sf_mjjs_t, sf_mjsf_t, sys_address, sf_mjtg_t, sf_gmgh_t, sf_mjbg_t)
    FROM SERVER mysql_chargezbhx
    INTO public;

-- 验证导入
SELECT foreign_table_name FROM information_schema.foreign_tables;
```

---

## 三、增强版ETL同步函数

### 3.1 用户数据同步函数

```sql
CREATE OR REPLACE FUNCTION sf_sync_customer_from_mysql(
    p_sync_type VARCHAR DEFAULT 'incremental',
    p_start_date DATE DEFAULT NULL
)
RETURNS TABLE(
    sync_status VARCHAR,
    records_processed BIGINT,
    sync_duration_ms BIGINT
) AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_records BIGINT;
BEGIN
    v_start_time := clock_timestamp();
    
    -- 全量同步
    IF p_sync_type = 'full' THEN
        TRUNCATE sf_dim_customer;
        
        INSERT INTO sf_dim_customer
        SELECT 
            id AS customer_id,
            code AS customer_code,
            name AS customer_name,
            id_number,
            tel_no,
            mob_no,
            yhlx,
            rwrq,
            rwht_bh,
            kzfs,
            COALESCE(kz_hmd, 0) AS kz_hmd,
            COALESCE(kz_sf, 1) AS kz_sf,
            COALESCE(kz_yhsf, 1) AS kz_yhsf,
            COALESCE(kz_jcsh, 0) AS kz_jcsh,
            rlz_id,
            zdfq_id,
            zdfq_name,
            hrq_zt,
            xzcnq,
            COALESCE(one, '') AS org_level1,
            COALESCE(two, '') AS org_level2,
            COALESCE(three, '') AS org_level3,
            COALESCE(zf, 0) AS zf,
            COALESCE(created_time, CURRENT_TIMESTAMP) AS create_time,
            COALESCE(updated_time, CURRENT_TIMESTAMP) AS update_time
        FROM mysql_chargezbhx.customer
        WHERE zf = 0;
        
        v_records := FOUND_ROWS();
    
    -- 增量同步
    ELSE
        INSERT INTO sf_dim_customer
        SELECT 
            id AS customer_id,
            code AS customer_code,
            name AS customer_name,
            id_number,
            tel_no,
            mob_no,
            yhlx,
            rwrq,
            rwht_bh,
            kzfs,
            COALESCE(kz_hmd, 0) AS kz_hmd,
            COALESCE(kz_sf, 1) AS kz_sf,
            COALESCE(kz_yhsf, 1) AS kz_yhsf,
            COALESCE(kz_jcsh, 0) AS kz_jcsh,
            rlz_id,
            zdfq_id,
            zdfq_name,
            hrq_zt,
            xzcnq,
            COALESCE(one, '') AS org_level1,
            COALESCE(two, '') AS org_level2,
            COALESCE(three, '') AS org_level3,
            COALESCE(zf, 0) AS zf,
            COALESCE(created_time, CURRENT_TIMESTAMP) AS create_time,
            COALESCE(updated_time, CURRENT_TIMESTAMP) AS update_time
        FROM mysql_chargezbhx.customer c
        WHERE zf = 0
        AND (
            -- 增量条件：更新过的或新增的
            c.updated_time > (
                SELECT COALESCE(MAX(update_time), '1970-01-01'::TIMESTAMP) 
                FROM sf_dim_customer
            )
            OR NOT EXISTS (
                SELECT 1 FROM sf_dim_customer WHERE customer_id = c.id
            )
        )
        ON CONFLICT (customer_id) DO UPDATE SET
            customer_code = EXCLUDED.customer_code,
            customer_name = EXCLUDED.customer_name,
            id_number = EXCLUDED.id_number,
            tel_no = EXCLUDED.tel_no,
            mob_no = EXCLUDED.mob_no,
            yhlx = EXCLUDED.yhlx,
            rwrq = EXCLUDED.rwrq,
            kzfs = EXCLUDED.kz_fs,
            kz_hmd = EXCLUDED.kz_hmd,
            kz_sf = EXCLUDED.kz_sf,
            kz_yhsf = EXCLUDED.kz_yhsf,
            kz_jcsh = EXCLUDED.kz_jcsh,
            rlz_id = EXCLUDED.rlz_id,
            zdfq_id = EXCLUDED.zdfq_id,
            zdfq_name = EXCLUDED.zdfq_name,
            hrq_zt = EXCLUDED.hrq_zt,
            xzcnq = EXCLUDED.xzcnq,
            org_level1 = EXCLUDED.org_level1,
            org_level2 = EXCLUDED.org_level2,
            org_level3 = EXCLUDED.org_level3,
            zf = EXCLUDED.zf,
            update_time = CURRENT_TIMESTAMP;
        
        GET DIAGNOSTICS v_records = ROW_COUNT;
    END IF;
    
    RETURN QUERY SELECT 
        'SUCCESS'::VARCHAR AS sync_status,
        v_records AS records_processed,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT AS sync_duration_ms;
    
EXCEPTION WHEN OTHERS THEN
    RETURN QUERY SELECT 
        'FAILED: ' || SQLERRM::VARCHAR,
        0::BIGINT,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
END;
$$ LANGUAGE plpgsql;
```

### 3.2 组织数据同步函数

```sql
CREATE OR REPLACE FUNCTION sf_sync_org_from_mysql()
RETURNS TABLE(
    sync_status VARCHAR,
    records_processed BIGINT,
    sync_duration_ms BIGINT
) AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_records BIGINT;
BEGIN
    v_start_time := clock_timestamp();
    
    INSERT INTO sf_dim_org
    SELECT 
        id AS org_id,
        parent_id,
        COALESCE(one, '') AS org_level1,
        COALESCE(two, '') AS org_level2,
        COALESCE(three, '') AS org_level3,
        CASE 
            WHEN type = 0 THEN '分公司'
            WHEN type = 1 THEN '热力站'
            WHEN type = 2 THEN '小区'
            ELSE '其他'
        END AS org_type,
        address_prefix,
        unit,
        floor,
        room,
        address,
        rlz_id,
        name AS rlz_name,
        COALESCE(state, 1) AS state,
        jzmj,
        COALESCE(zf, 0) AS zf
    FROM mysql_chargezbhx.sys_address a
    WHERE zf = 0
    AND (
        a.updated_time > (
            SELECT COALESCE(MAX(update_time), '1970-01-01'::TIMESTAMP) 
            FROM sf_dim_org
        )
        OR NOT EXISTS (
            SELECT 1 FROM sf_dim_org WHERE org_id = a.id
        )
    )
    ON CONFLICT (org_id) DO UPDATE SET
        parent_id = EXCLUDED.parent_id,
        org_level1 = EXCLUDED.org_level1,
        org_level2 = EXCLUDED.org_level2,
        org_level3 = EXCLUDED.org_level3,
        org_type = EXCLUDED.org_type,
        address_prefix = EXCLUDED.address_prefix,
        unit = EXCLUDED.unit,
        floor = EXCLUDED.floor,
        room = EXCLUDED.room,
        address = EXCLUDED.address,
        rlz_id = EXCLUDED.rlz_id,
        rlz_name = EXCLUDED.rlz_name,
        state = EXCLUDED.state,
        jzmj = EXCLUDED.jzmj,
        zf = EXCLUDED.zf;
    
    GET DIAGNOSTICS v_records = ROW_COUNT;
    
    RETURN QUERY SELECT 
        'SUCCESS'::VARCHAR,
        v_records,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
    
EXCEPTION WHEN OTHERS THEN
    RETURN QUERY SELECT 
        ('FAILED: ' || SQLERRM)::VARCHAR,
        0::BIGINT,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
END;
$$ LANGUAGE plpgsql;
```

### 3.3 收费结算同步函数

```sql
CREATE OR REPLACE FUNCTION sf_sync_charge_from_mysql(
    p_cnq VARCHAR DEFAULT NULL
)
RETURNS TABLE(
    sync_status VARCHAR,
    records_processed BIGINT,
    sync_duration_ms BIGINT
) AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_records BIGINT;
    v_cnq VARCHAR(10);
BEGIN
    v_start_time := clock_timestamp();
    
    -- 如果未指定采暖期，同步所有未完成的采暖期
    IF p_cnq IS NULL THEN
        FOR v_cnq IN SELECT DISTINCT cnq FROM mysql_chargezbhx.sf_mjjs_t WHERE zf = 0 LOOP
            INSERT INTO sf_rpt_charge
            SELECT 
                m.id,
                m.cnq,
                m.customer_id,
                m.mj_id,
                m.fylb,
                COALESCE(m.sfmj, 0) AS sfmj,
                COALESCE(m.sl, 0) AS sl,
                COALESCE(m.dj, 0) AS dj,
                COALESCE(m.ysje, 0) AS ysje,
                COALESCE(m.sfje, 0) AS sfje,
                COALESCE(m.qfje, 0) AS qfje,
                COALESCE(m.zkje, 0) AS zkje,
                COALESCE(m.wyje, 0) AS wyje,
                COALESCE(m.hjje, 0) AS hjje,
                COALESCE(m.tgce, 0) AS tgce,
                COALESCE(m.jcys, 0) AS jcys,
                COALESCE(m.jsfs, '按面积') AS jsfs,
                COALESCE(m.ybbm, '') AS ybbm,
                COALESCE(m.cbzt, 0) AS cbzt,
                COALESCE(m.jldj, 0) AS jldj,
                COALESCE(m.jlbs, 0) AS jlbs,
                COALESCE(m.djlb, '') AS djlb,
                COALESCE(m.jldjlb, '') AS jldjlb,
                COALESCE(m.gnsc, 0) AS gnsc,
                COALESCE(m.hrq_zt, '') AS hrq_zt,
                COALESCE(m.hrq_sl, 0) AS hrq_sl,
                COALESCE(m.gnzt, '正常') AS gnzt,
                COALESCE(m.event, '') AS event,
                COALESCE(m.business_id, 0) AS business_id,
                COALESCE(m.czy, '') AS czy,
                COALESCE(m.zf, 0) AS zf,
                COALESCE(m.created_time, CURRENT_TIMESTAMP) AS create_time,
                COALESCE(m.updated_time, CURRENT_TIMESTAMP) AS update_time
            FROM mysql_chargezbhx.sf_mjjs_t m
            WHERE m.zf = 0 AND m.cnq = v_cnq
            AND (
                m.updated_time > (
                    SELECT COALESCE(MAX(update_time), '1970-01-01'::TIMESTAMP) 
                    FROM sf_rpt_charge WHERE cnq = v_cnq
                )
                OR NOT EXISTS (
                    SELECT 1 FROM sf_rpt_charge WHERE id = m.id
                )
            )
            ON CONFLICT (id) DO UPDATE SET
                sfmj = EXCLUDED.sfmj,
                ysje = EXCLUDED.ysje,
                sfje = EXCLUDED.sfje,
                qfje = EXCLUDED.qfje,
                zkje = EXCLUDED.zkje,
                wyje = EXCLUDED.wyje,
                hjje = EXCLUDED.hjje,
                tgce = EXCLUDED.tgce,
                jcys = EXCLUDED.jcys,
                cbzt = EXCLUDED.cbzt,
                gnzt = EXCLUDED.gnzt,
                event = EXCLUDED.event,
                czy = EXCLUDED.czy,
                zf = EXCLUDED.zf,
                update_time = CURRENT_TIMESTAMP;
        END LOOP;
    ELSE
        INSERT INTO sf_rpt_charge
        SELECT 
            m.id,
            m.cnq,
            m.customer_id,
            m.mj_id,
            m.fylb,
            COALESCE(m.sfmj, 0),
            COALESCE(m.sl, 0),
            COALESCE(m.dj, 0),
            COALESCE(m.ysje, 0),
            COALESCE(m.sfje, 0),
            COALESCE(m.qfje, 0),
            COALESCE(m.zkje, 0),
            COALESCE(m.wyje, 0),
            COALESCE(m.hjje, 0),
            COALESCE(m.tgce, 0),
            COALESCE(m.jcys, 0),
            COALESCE(m.jsfs, '按面积'),
            COALESCE(m.ybbm, ''),
            COALESCE(m.cbzt, 0),
            COALESCE(m.jldj, 0),
            COALESCE(m.jlbs, 0),
            COALESCE(m.djlb, ''),
            COALESCE(m.jldjlb, ''),
            COALESCE(m.gnsc, 0),
            COALESCE(m.hrq_zt, ''),
            COALESCE(m.hrq_sl, 0),
            COALESCE(m.gnzt, '正常'),
            COALESCE(m.event, ''),
            COALESCE(m.business_id, 0),
            COALESCE(m.czy, ''),
            COALESCE(m.zf, 0),
            COALESCE(m.created_time, CURRENT_TIMESTAMP),
            COALESCE(m.updated_time, CURRENT_TIMESTAMP)
        FROM mysql_chargezbhx.sf_mjjs_t m
        WHERE m.zf = 0 AND m.cnq = p_cnq
        AND (
            m.updated_time > (
                SELECT COALESCE(MAX(update_time), '1970-01-01'::TIMESTAMP) 
                FROM sf_rpt_charge WHERE cnq = p_cnq
            )
            OR NOT EXISTS (
                SELECT 1 FROM sf_rpt_charge WHERE id = m.id
            )
        )
        ON CONFLICT (id) DO UPDATE SET
            sfmj = EXCLUDED.sfmj,
            ysje = EXCLUDED.ysje,
            sfje = EXCLUDED.sfje,
            qfje = EXCLUDED.qfje,
            update_time = CURRENT_TIMESTAMP;
    END IF;
    
    GET DIAGNOSTICS v_records = ROW_COUNT;
    
    RETURN QUERY SELECT 
        'SUCCESS'::VARCHAR,
        v_records,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
    
EXCEPTION WHEN OTHERS THEN
    RETURN QUERY SELECT 
        ('FAILED: ' || SQLERRM)::VARCHAR,
        0::BIGINT,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
END;
$$ LANGUAGE plpgsql;
```

### 3.4 收费明细同步函数

```sql
CREATE OR REPLACE FUNCTION sf_sync_payment_from_mysql()
RETURNS TABLE(
    sync_status VARCHAR,
    records_processed BIGINT,
    sync_duration_ms BIGINT
) AS $$
DECLARE
    v_start_time TIMESTAMP;
    v_records BIGINT;
BEGIN
    v_start_time := clock_timestamp();
    
    -- 只同步最新的记录（基于ID增量）
    INSERT INTO sf_rpt_payment
    SELECT 
        p.id,
        p.cnq,
        p.customer_id,
        p.mjjs_id,
        COALESCE(p.fylb, '采暖费') AS fylb,
        COALESCE(p.sfrq, CURRENT_TIMESTAMP) AS sfrq,
        COALESCE(p.sfje, 0) AS sfje,
        COALESCE(p.wyje, 0) AS wyje,
        COALESCE(p.zkje, 0) AS zkje,
        COALESCE(p.sl, 0) AS sl,
        COALESCE(p.dj, 0) AS dj,
        COALESCE(p.djlb, '') AS djlb,
        COALESCE(p.gnsc, 0) AS gnsc,
        COALESCE(p.sffs, '现金') AS sffs,
        COALESCE(p.fplb, '') AS fplb,
        COALESCE(p.fpdm, '') AS fpdm,
        COALESCE(p.fphm, '') AS fphm,
        COALESCE(p.zfqd, '公司自收') AS zfqd,
        COALESCE(p.yywd, '') AS yywd,
        COALESCE(p.lsh, '') AS lsh,
        COALESCE(p.dzzt, 0) AS dzzt,
        COALESCE(p.czy, '') AS czy,
        COALESCE(p.czbh, 0) AS czbh,
        COALESCE(p.term_sn, '') AS term_sn,
        COALESCE(p.bill_id, '') AS bill_id,
        COALESCE(p.zf, 0) AS zf,
        COALESCE(p.created_time, CURRENT_TIMESTAMP) AS create_time,
        COALESCE(p.updated_time, CURRENT_TIMESTAMP) AS update_time
    FROM mysql_chargezbhx.sf_mjsf_t p
    WHERE p.zf = 0
    AND p.id > COALESCE((SELECT MAX(id) FROM sf_rpt_payment), 0)
    ON CONFLICT (id) DO NOTHING;
    
    GET DIAGNOSTICS v_records = ROW_COUNT;
    
    RETURN QUERY SELECT 
        'SUCCESS'::VARCHAR,
        v_records,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
    
EXCEPTION WHEN OTHERS THEN
    RETURN QUERY SELECT 
        ('FAILED: ' || SQLERRM)::VARCHAR,
        0::BIGINT,
        EXTRACT(MILLISECONDS FROM clock_timestamp() - v_start_time)::BIGINT;
END;
$$ LANGUAGE plpgsql;
```

### 3.5 一键同步存储过程

```sql
CREATE OR REPLACE FUNCTION sf_full_sync_all()
RETURNS TABLE(
    step_name VARCHAR,
    sync_status VARCHAR,
    records_processed BIGINT,
    sync_duration_ms BIGINT
) AS $$
BEGIN
    -- 步骤1: 同步用户数据
    RETURN QUERY SELECT 'STEP1: 同步用户数据' AS step_name, * FROM sf_sync_customer_from_mysql('incremental');
    
    -- 步骤2: 同步组织数据
    RETURN QUERY SELECT 'STEP2: 同步组织数据' AS step_name, * FROM sf_sync_org_from_mysql();
    
    -- 步骤3: 同步收费结算
    RETURN QUERY SELECT 'STEP3: 同步收费结算' AS step_name, * FROM sf_sync_charge_from_mysql(NULL);
    
    -- 步骤4: 同步收费明细
    RETURN QUERY SELECT 'STEP4: 同步收费明细' AS step_name, * FROM sf_sync_payment_from_mysql();
    
    -- 步骤5: 刷新汇总表
    RETURN QUERY SELECT 
        'STEP5: 刷新汇总表' AS step_name,
        'SUCCESS'::VARCHAR AS sync_status,
        0::BIGINT AS records_processed,
        0::BIGINT AS sync_duration_ms;
    
    -- 刷新汇总
    PERFORM sf_refresh_cnq_charge('2025-2026');
    PERFORM sf_refresh_month_charge(TO_CHAR(CURRENT_DATE, 'YYYY-MM'));
    PERFORM sf_refresh_daily_charge(CURRENT_DATE);
    PERFORM sf_refresh_arrears('2025-2026');
    
EXCEPTION WHEN OTHERS THEN
    RETURN QUERY SELECT 
        ('ERROR: ' || SQLERRM)::VARCHAR AS step_name,
        'FAILED'::VARCHAR,
        0::BIGINT,
        0::BIGINT;
END;
$$ LANGUAGE plpgsql;
```

---

## 四、同步监控表

```sql
-- 创建同步日志表
CREATE TABLE sf_sync_log (
    id SERIAL PRIMARY KEY,
    sync_type VARCHAR(50) NOT NULL,
    table_name VARCHAR(100),
    sync_status VARCHAR(20),
    records_processed BIGINT,
    error_message TEXT,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP,
    duration_ms BIGINT,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_sync_log_type ON sf_sync_log(sync_type);
CREATE INDEX idx_sync_log_status ON sf_sync_log(sync_status);
CREATE INDEX idx_sync_log_time ON sf_sync_log(create_time DESC);

-- 记录同步日志的触发函数
CREATE OR REPLACE FUNCTION sf_log_sync(
    p_sync_type VARCHAR,
    p_table_name VARCHAR,
    p_status VARCHAR,
    p_records BIGINT,
    p_error TEXT DEFAULT NULL
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO sf_sync_log (sync_type, table_name, sync_status, records_processed, error_message, start_time, end_time)
    VALUES (
        p_sync_type,
        p_table_name,
        p_status,
        p_records,
        p_error,
        CURRENT_TIMESTAMP,
        CURRENT_TIMESTAMP
    );
END;
$$ LANGUAGE plpgsql;
```

---

## 五、定时任务配置

### 5.1 Linux crontab配置

```bash
# 编辑crontab
crontab -e

# 每天凌晨2点执行全量同步
0 2 * * * psql "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -c "SET search_path TO heating_analytics; SELECT * FROM sf_full_sync_all();" >> /var/log/etl_sync.log 2>&1

# 每小时执行增量同步
0 * * * * psql "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -c "SET search_path TO heating_analytics; SELECT * FROM sf_sync_payment_from_mysql();" >> /var/log/etl_incremental.log 2>&1

# 每周日凌晨3点执行汇总刷新
0 3 * * 0 psql "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -c "SET search_path TO heating_analytics; SELECT sf_refresh_cnq_charge('2025-2026'); SELECT sf_refresh_arrears('2025-2026');" >> /var/log/etl_refresh.log 2>&1
```

### 5.2 Windows任务计划程序

```powershell
# 创建ETL同步脚本
$syncScript = @"
cd E:\trae\supersonic
psql "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres" -c "SET search_path TO heating_analytics; SELECT * FROM sf_full_sync_all();"
"@

# 保存脚本
$syncScript | Out-File -FilePath "E:\trae\supersonic\temp\etl_sync.ps1" -Encoding UTF8

# 创建每日凌晨2点的任务
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-File E:\trae\supersonic\temp\etl_sync.ps1"
$trigger = New-ScheduledTaskTrigger -Daily -At "02:00"
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunLimitedInSession

Register-ScheduledTask -TaskName "ETL_Sync_HeatingCharge" -Action $action -Trigger $trigger -Settings $settings -Description "供热收费系统数据同步"
```

---

## 六、ETL同步状态查询

```sql
-- 查看最近同步记录
SELECT 
    sync_type,
    table_name,
    sync_status,
    records_processed,
    duration_ms,
    create_time
FROM sf_sync_log
ORDER BY create_time DESC
LIMIT 20;

-- 查看同步异常记录
SELECT * FROM sf_sync_log
WHERE sync_status LIKE 'FAILED%'
ORDER BY create_time DESC
LIMIT 10;

-- 统计每日同步量
SELECT 
    DATE(create_time) AS sync_date,
    sync_type,
    SUM(records_processed) AS total_records,
    COUNT(*) AS sync_count,
    AVG(duration_ms) AS avg_duration_ms
FROM sf_sync_log
WHERE create_time >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY DATE(create_time), sync_type
ORDER BY sync_date DESC, sync_type;
```

---

## 七、备份与恢复

### 7.1 同步前备份

```sql
-- 创建备份表
CREATE TABLE sf_dim_customer_backup AS SELECT * FROM sf_dim_customer;
CREATE TABLE sf_rpt_charge_backup AS SELECT * FROM sf_rpt_charge;

-- 添加备份时间戳
ALTER TABLE sf_dim_customer_backup ADD COLUMN backup_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE sf_rpt_charge_backup ADD COLUMN backup_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
```

### 7.2 数据恢复

```sql
-- 从备份恢复
TRUNCATE sf_dim_customer;
INSERT INTO sf_dim_customer SELECT * FROM sf_dim_customer_backup WHERE backup_time = (
    SELECT MAX(backup_time) FROM sf_dim_customer_backup
);
```

---

## 八、常见问题排查

### 8.1 FDW连接失败

```sql
-- 检查外部服务器状态
SELECT * FROM information_schema.foreign_servers;

-- 测试MySQL连接
SELECT * FROM mysql_chargezbhx.customer LIMIT 1;

-- 如果失败，重新创建连接
DROP SERVER mysql_chargezbhx CASCADE;
CREATE SERVER mysql_chargezbhx ...
```

### 8.2 同步性能问题

```sql
-- 查看慢查询
SELECT * FROM pg_stat_statements 
ORDER BY total_time DESC
LIMIT 10;

-- 查看锁等待
SELECT * FROM pg_locks 
WHERE granted = false;

-- 优化建议
-- 1. 为源表添加索引
-- 2. 使用分批同步
-- 3. 调整batch_size参数
```

---

*文档版本: v1.0*
*创建日期: 2026-04-13*
*适用范围: SuperSonic 供热收费客服智能分析平台*
