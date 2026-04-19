-- ============================================================
-- 修复语义层别名和同义词问题
-- 问题："哪个小区收费率高"意图解析失败
-- 原因：
--   1. "小区"维度的alias缺少同义词(社区、楼盘)
--   2. "收费率"指标的alias缺少同义词(收缴率)
--   3. 维度关联不完整
-- 创建日期: 2026-04-14
-- ============================================================

SET search_path TO heating_analytics;

-- ============================================================
-- 一、更新"小区"维度的别名，增强同义词识别
-- ============================================================

-- 更新id=55的"小区"维度别名
UPDATE s2_dimension
SET alias = '["小区", "社区", "楼盘", "住宅区", "住宅小区"]',
    description = '供热服务覆盖的小区或社区，包含小区名称、地址等信息'
WHERE id = 55;

-- 同时更新其他模型中可能的org_level3维度
UPDATE s2_dimension
SET alias = '["小区", "社区", "楼盘", "住宅区"]'
WHERE biz_name = 'org_level3' AND (alias IS NULL OR alias = '' OR alias = '[]');

SELECT '已更新小区维度别名' AS status;

-- ============================================================
-- 二、更新"收费率"指标的别名，增强同义词识别
-- ============================================================

-- 更新id=43的"收费率"指标别名
UPDATE s2_metric
SET alias = '["收费率", "收缴率", "缴费率", "实收比例"]',
    description = '实际收取的热费与应收热费的比率，反映收费效率。计算公式：实收金额/应收金额*100%'
WHERE id = 43;

-- 同时更新其他模型中的收费率指标
UPDATE s2_metric
SET alias = '["收费率", "收缴率", "缴费率"]'
WHERE biz_name = 'PAY_RATE' AND (alias IS NULL OR alias = '' OR alias = '[]');

SELECT '已更新收费率指标别名' AS status;

-- ============================================================
-- 三、更新关键维度的别名
-- ============================================================

-- 更新"采暖期"维度别名
UPDATE s2_dimension
SET alias = '["采暖期", "供暖季", "供热季", "供热期"]'
WHERE biz_name = 'cnq' AND (alias IS NULL OR alias = '');

-- 更新"费用类别"维度别名
UPDATE s2_dimension
SET alias = '["费用类别", "费用类型", "收费类型"]'
WHERE biz_name = 'fylb';

-- 更新"供暖状态"维度别名
UPDATE s2_dimension
SET alias = '["供暖状态", "供热状态", "用热状态"]'
WHERE biz_name = 'gnzt';

-- 更新"用户类型"维度别名
UPDATE s2_dimension
SET alias = '["用户类型", "用热类型", "客户类型"]'
WHERE biz_name = 'yhlx';

-- 更新"分公司"维度别名
UPDATE s2_dimension
SET alias = '["分公司", "公司", "分支机构"]'
WHERE biz_name = 'org_level1';

-- 更新"热力站"维度别名
UPDATE s2_dimension
SET alias = '["热力站", "换热站", "供热站"]'
WHERE biz_name = 'org_level2';

SELECT '已更新关键维度别名' AS status;

-- ============================================================
-- 四、更新关键指标的别名
-- ============================================================

-- 更新"实收金额"指标别名
UPDATE s2_metric
SET alias = '["实收金额", "已收金额", "收费金额", "已收热费"]'
WHERE biz_name = 'PAY_SFJE_SUM' AND (alias IS NULL OR alias = '' OR alias = '[]');

-- 更新"应收金额"指标别名
UPDATE s2_metric
SET alias = '["应收金额", "应收热费", "应收暖气费"]'
WHERE biz_name = 'BILL_YSJE_SUM' AND (alias IS NULL OR alias = '' OR alias = '[]');

-- 更新"欠费金额"指标别名
UPDATE s2_metric
SET alias = '["欠费金额", "欠费", "未收金额", "欠缴热费"]'
WHERE biz_name = 'BILL_QFJE_SUM' AND (alias IS NULL OR alias = '' OR alias = '[]');

SELECT '已更新关键指标别名' AS status;

-- ============================================================
-- 五、补充业务术语(s2_term)，建立语义关联
-- ============================================================

-- 检查并添加"小区"术语
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
SELECT
    3,
    '小区',
    '供热服务覆盖的住宅小区或社区',
    '["社区", "楼盘", "住宅区"]',
    '["USER_CNT", "PAY_RATE", "AREA_SFMJ_SUM"]',
    '["org_level3", "cnq", "yhlx"]',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin'
WHERE NOT EXISTS (
    SELECT 1 FROM s2_term WHERE name = '小区' AND domain_id = 3
);

-- 检查并添加"收费率"术语
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
SELECT
    3,
    '收费率',
    '实际收取的热费与应收热费的比率，反映收费效率',
    '["收缴率", "缴费率"]',
    '["PAY_RATE", "BILL_YSJE_SUM", "PAY_SFJE_SUM"]',
    '["cnq", "org_level1", "org_level2", "org_level3", "fylb"]',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin'
WHERE NOT EXISTS (
    SELECT 1 FROM s2_term WHERE name = '收费率' AND domain_id = 3
);

-- 检查并添加"收缴率"术语（同收费率）
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
SELECT
    3,
    '收缴率',
    '实际收取的热费与应收热费的比率，与收费率同义',
    '["收费率", "缴费率"]',
    '["PAY_RATE", "BILL_YSJE_SUM", "PAY_SFJE_SUM"]',
    '["cnq", "org_level1", "org_level3"]',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin'
WHERE NOT EXISTS (
    SELECT 1 FROM s2_term WHERE name = '收缴率' AND domain_id = 3
);

SELECT '已补充业务术语' AS status;

-- ============================================================
-- 六、验证修复结果
-- ============================================================

SELECT '验证1: 检查小区维度' AS check_step;
SELECT id, name, biz_name, alias, description
FROM s2_dimension
WHERE biz_name = 'org_level3';

SELECT '验证2: 检查收费率指标' AS check_step;
SELECT id, name, biz_name, alias, type, description
FROM s2_metric
WHERE biz_name = 'PAY_RATE';

SELECT '验证3: 检查相关术语' AS check_step;
SELECT id, name, alias, description
FROM s2_term
WHERE name IN ('小区', '收费率', '收缴率')
AND domain_id = 3;

-- ============================================================
-- 七、生成分析SQL示例
-- ============================================================

SELECT '示例查询1: 各小区收费率' AS example;
SELECT
    c.zdfq_name AS 小区,
    COUNT(DISTINCT c.customer_id) AS 用户数,
    SUM(m.ysje) AS 应收金额,
    SUM(m.sfje) AS 实收金额,
    CASE WHEN SUM(m.ysje) > 0
         THEN ROUND(SUM(m.sfje) / SUM(m.ysje) * 100, 2)
         ELSE 0 END AS 收费率
FROM sf_rpt_charge m
LEFT JOIN sf_dim_customer c ON m.customer_id = c.customer_id
WHERE m.cnq = '2025-2026'
  AND m.zf = 0
GROUP BY c.zdfq_name
HAVING c.zdfq_name IS NOT NULL
ORDER BY 收费率 DESC;

-- ============================================================
-- 八、重启服务提示
-- ============================================================

SELECT '请重启SuperSonic服务以应用修改' AS notice;

-- ============================================================
-- 执行完成
-- ============================================================
