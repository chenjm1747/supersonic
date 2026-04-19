-- ============================================================
-- 修复缺失的维度定义和指标定义
-- 问题："哪个小区收费率高"意图解析失败
-- 原因：数据库中缺少"小区"维度和"收费率"指标的定义
-- 创建日期: 2026-04-14
-- ============================================================

SET search_path TO heating_analytics;

-- ============================================================
-- 一、检查现有数据
-- ============================================================

-- 检查现有模型
SELECT '现有模型:' AS info;
SELECT id, name, biz_name, domain_id FROM s2_model WHERE domain_id >= 2 ORDER BY id;

-- 检查现有维度数量
SELECT '现有维度数量:' AS info, COUNT(*) as dimension_count FROM s2_dimension WHERE model_id >= 1;

-- 检查现有指标数量
SELECT '现有指标数量:' AS info, COUNT(*) as metric_count FROM s2_metric WHERE model_id >= 1;

-- ============================================================
-- 二、补充组织维度模型(model_id=2)缺失的维度
-- ============================================================

-- 检查model_id=2是否已有小区维度
SELECT '检查组织维度模型(model_id=2):' AS info;
SELECT id, name, biz_name, alias FROM s2_dimension WHERE model_id = 2;

-- 补充组织维度模型的小区维度
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '小区', 'org_level3', '小区名称', 1, 'categorical', 'VARCHAR', 'o.org_level3', 'COMMON', '["小区", "社区", "楼盘"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin')
ON CONFLICT DO NOTHING;

-- 补充组织维度模型的热力站维度
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '热力站', 'org_level2', '热力站名称', 1, 'categorical', 'VARCHAR', 'o.org_level2', 'COMMON', '["热力站", "换热站"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin')
ON CONFLICT DO NOTHING;

-- ============================================================
-- 三、补充收费结算事实模型(model_id=5)缺失的维度
-- ============================================================

-- 检查model_id=5是否已有小区维度
SELECT '检查收费结算事实模型(model_id=5):' AS info;
SELECT id, name, biz_name, alias FROM s2_dimension WHERE model_id = 5;

-- 补充收费结算模型的小区维度(从用户表关联)
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '小区', 'org_level3', '小区名称', 1, 'categorical', 'VARCHAR', 'c.zdfq_name', 'COMMON', '["小区", "社区"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin')
ON CONFLICT DO NOTHING;

-- 补充收费结算模型的分公司维度
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '分公司', 'org_level1', '分公司名称', 1, 'categorical', 'VARCHAR', 'c.one', 'COMMON', '["分公司", "公司"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin')
ON CONFLICT DO NOTHING;

-- ============================================================
-- 四、补充业务术语(s2_term)
-- ============================================================

-- 检查现有术语
SELECT '现有业务术语:' AS info;
SELECT id, name, alias FROM s2_term;

-- 补充"小区"相关术语
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(3, '小区', '供热服务覆盖的住宅小区或社区', '["社区", "楼盘"]', '["USER_CNT", "PAY_RATE"]', '["org_level3", "cnq"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin')
ON CONFLICT DO NOTHING;

-- 补充"收费率"术语
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(3, '收费率', '实际收取的热费与应收热费的比率', '["收缴率", "缴费率"]', '["PAY_RATE", "BILL_YSJE_SUM", "PAY_SFJE_SUM"]', '["cnq", "org_level1", "org_level3"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin')
ON CONFLICT DO NOTHING;

-- ============================================================
-- 五、更新维度别名，增强语义识别能力
-- ============================================================

-- 更新分公司维度别名
UPDATE s2_dimension SET alias = '["分公司", "公司", "分支机构"]'
WHERE biz_name = 'org_level1' AND model_id >= 2;

-- 更新热力站维度别名
UPDATE s2_dimension SET alias = '["热力站", "换热站", "供热站"]'
WHERE biz_name = 'org_level2' AND model_id >= 2;

-- 更新小区维度别名
UPDATE s2_dimension SET alias = '["小区", "社区", "楼盘", "住宅区"]'
WHERE biz_name = 'org_level3';

-- ============================================================
-- 六、验证修复结果
-- ============================================================

SELECT '修复后的维度定义:' AS info;
SELECT d.id, d.name, d.biz_name, d.alias, m.name as model_name
FROM s2_dimension d
LEFT JOIN s2_model m ON d.model_id = m.id
WHERE d.model_id >= 2
ORDER BY d.model_id, d.id;

SELECT '修复后的术语定义:' AS info;
SELECT id, name, alias, description FROM s2_term WHERE domain_id >= 2;

-- ============================================================
-- 七、刷新语义层缓存（需要重启服务）
-- ============================================================

SELECT '请重启SuperSonic服务以刷新语义层缓存' AS notice;
SELECT '重启命令:' AS cmd;
SELECT 'taskkill /F /IM java.exe' AS kill_java;
SELECT 'java -Xmx2g -Xms1g -jar launchers-standalone-0.9.10.jar' AS start_java;

-- ============================================================
-- 执行完成
-- ============================================================
