-- ============================================================
-- SuperSonic 数据库注册与配置修复
-- 解决：数据插入后界面不显示的问题
-- 创建日期: 2026-04-13
-- ============================================================

-- 检查当前数据库配置
SELECT '=== 当前 s2_database 表内容 ===' AS info;
SELECT id, name, type, version, is_open FROM s2_database;

SELECT '=== 当前 s2_agent 表内容 ===' AS info;
SELECT id, name, status, model FROM s2_agent;

SELECT '=== 当前 s2_model 表内容 ===' AS info;
SELECT id, name, biz_name, domain_id FROM s2_model LIMIT 10;

-- ============================================================
-- 步骤1: 检查并注册数据库连接
-- ============================================================

-- 查看是否已有供热收费系统数据库配置
SELECT '=== 检查供热收费系统数据库 ===' AS info;
SELECT * FROM s2_database WHERE name LIKE '%charge%' OR name LIKE '%heating%' OR name LIKE '%收费%';

-- 如果没有数据库配置，执行以下插入
INSERT INTO s2_database (
    name,
    description,
    version,
    type,
    config,
    created_at,
    created_by,
    updated_at,
    updated_by,
    is_open
)
VALUES (
    'heating_analytics',
    '供热收费系统PostgreSQL分析库',
    '1.0',
    'POSTGRESQL',
    '{
        "url": "jdbc:postgresql://192.168.1.7:54321/postgres",
        "username": "postgres",
        "password": "Huilian1234",
        "schema": "heating_analytics",
        "poolSize": 10,
        "autoCreateTable": true
    }',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    1
)
ON CONFLICT DO NOTHING;

SELECT '数据库配置已添加' AS status;

-- ============================================================
-- 步骤2: 检查并注册Agent
-- ============================================================

-- 查看是否已有供热收费Agent
SELECT '=== 检查供热收费Agent ===' AS info;
SELECT * FROM s2_agent WHERE name LIKE '%charge%' OR name LIKE '%heating%' OR name LIKE '%收费%' OR name LIKE '%供热%';

-- 如果没有Agent配置，执行以下插入
INSERT INTO s2_agent (
    name,
    description,
    examples,
    status,
    model,
    tool_config,
    llm_config,
    enable_search,
    enable_feedback,
    created_by,
    created_at,
    updated_by,
    updated_at,
    is_open
)
VALUES (
    '供热收费智能分析助手',
    '基于供热收费系统的智能数据分析师，可以回答关于收费率、欠费分析、用户结构等问题',
    '{
        "examples": [
            "2025-2026采暖期收费率是多少？",
            "哪个分公司的收费率最高？",
            "欠费金额最多的前10个用户是谁？",
            "本月新增了多少用户？",
            "各收费方式的占比是多少？"
        ]
    }',
    1,
    'qwen-plus',
    '{
        "tools": [
            {
                "name": "query_data",
                "description": "查询数据库中的数据"
            }
        ]
    }',
    '{
        "temperature": 0.7,
        "max_tokens": 2000
    }',
    1,
    1,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    1
)
ON CONFLICT DO NOTHING;

SELECT 'Agent配置已添加' AS status;

-- ============================================================
-- 步骤3: 检查s2_chat_config配置
-- ============================================================

SELECT '=== 检查 s2_chat_config ===' AS info;
SELECT * FROM s2_chat_config;

-- 添加默认chat_config（如果不存在）
INSERT INTO s2_chat_config (
    model_id,
    chat_detail_config,
    chat_agg_config,
    recommended_questions,
    created_at,
    updated_at,
    created_by,
    updated_by,
    status,
    llm_examples
)
SELECT 
    1,
    '{"defaultModel": "qwen-plus"}',
    '{"defaultModel": "qwen-plus"}',
    '["2025-2026采暖期收费率是多少？","哪个分公司的收费率最高？","欠费用户分析"]',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP,
    'admin',
    'admin',
    1,
    NULL
WHERE NOT EXISTS (SELECT 1 FROM s2_chat_config WHERE model_id = 1);

-- ============================================================
-- 步骤4: 验证元数据是否正确插入
-- ============================================================

SELECT '=== 验证主题域 ===' AS info;
SELECT id, name, biz_name, status FROM s2_domain ORDER BY id;

SELECT '=== 验证数据模型 ===' AS info;
SELECT id, name, biz_name, domain_id, database_id, status FROM s2_model ORDER BY id;

SELECT '=== 验证维度数量 ===' AS info;
SELECT model_id, COUNT(*) AS dimension_count 
FROM s2_dimension 
GROUP BY model_id 
ORDER BY model_id;

SELECT '=== 验证指标数量 ===' AS info;
SELECT model_id, COUNT(*) AS metric_count 
FROM s2_metric 
GROUP BY model_id 
ORDER BY model_id;

-- ============================================================
-- 步骤5: 检查domain_id和model_id的对应关系
-- ============================================================

SELECT '=== 主题域与模型对应关系 ===' AS info;
SELECT 
    d.id AS domain_id,
    d.name AS domain_name,
    d.biz_name AS domain_biz_name,
    COUNT(m.id) AS model_count
FROM s2_domain d
LEFT JOIN s2_model m ON d.id = m.domain_id
GROUP BY d.id, d.name, d.biz_name
ORDER BY d.id;

-- ============================================================
-- 常见问题排查
-- ============================================================

SELECT '=== 问题排查1: 检查is_open状态 ===' AS info;
SELECT 'domain表:' AS table_name;
SELECT id, name, is_open FROM s2_domain;

SELECT 'model表:' AS table_name;
SELECT id, name, is_open FROM s2_model WHERE is_open IS NULL OR is_open = 0;

SELECT 'database表:' AS table_name;
SELECT id, name, is_open FROM s2_database WHERE is_open IS NULL OR is_open = 0;

-- 修复：将所有记录的is_open设为1
UPDATE s2_domain SET is_open = 1 WHERE is_open IS NULL OR is_open = 0;
UPDATE s2_model SET is_open = 1 WHERE is_open IS NULL OR is_open = 0;
UPDATE s2_database SET is_open = 1 WHERE is_open IS NULL OR is_open = 0;

SELECT '已将所有is_open字段设置为1' AS status;

-- ============================================================
-- 最终验证
-- ============================================================

SELECT '=== 最终验证：可查询的数据 ===' AS info;

SELECT '主题域(必须>=1):' AS check_item, COUNT(*) AS count FROM s2_domain;
SELECT '数据模型(必须>=1):' AS check_item, COUNT(*) AS count FROM s2_model;
SELECT '维度字段(必须>=1):' AS check_item, COUNT(*) AS count FROM s2_dimension;
SELECT '指标(必须>=1):' AS check_item, COUNT(*) AS count FROM s2_metric;
SELECT '数据库配置(必须>=1):' AS check_item, COUNT(*) AS count FROM s2_database;

-- ============================================================
-- 下一步操作
-- ============================================================

SELECT '=== 重要提示 ===' AS info;
SELECT 
    '执行完成！请按以下步骤操作：' AS message,
    '' AS step1,
    '1. 重启SuperSonic服务' AS step2,
    '2. 清除浏览器缓存' AS step3,
    '3. 访问 http://localhost:9080' AS step4,
    '4. 检查"模型管理"页面是否显示新建的模型' AS step5;
