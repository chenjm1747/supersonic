-- ============================================================
-- 供热收费系统语义建模 - SuperSonic元数据导入SQL
-- 适用范围: SuperSonic 供热收费客服智能分析平台
-- 创建日期: 2026-04-13
-- 数据库: heating_analytics
-- ============================================================

SET search_path TO heating_analytics;

-- ============================================================
-- 一、主题域 (s2_domain)
-- ============================================================

-- 1. 根主题域 - 供热收费系统
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity)
VALUES ('供热收费系统', 'heating_charge', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '供热收费核心业务域');

-- 2. 用户域 (Customer Domain)
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity)
VALUES ('用户域', 'customer', 1, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '热用户管理');

-- 3. 计费域 (Billing Domain)
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity)
VALUES ('计费域', 'billing', 1, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '费用计算与结算');

-- 4. 收费域 (Collection Domain)
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity)
VALUES ('收费域', 'collection', 1, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '实收费用管理');

-- 5. 运营域 (Operation Domain)
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity)
VALUES ('运营域', 'operation', 1, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '业务运营分析');

-- 6. 质量域 (Quality Domain)
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity)
VALUES ('质量域', 'quality', 1, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '数据质量监控');

-- ============================================================
-- 二、数据模型 (s2_model)
-- ============================================================

-- 1. 用户维度模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '用户维度模型',
    'sf_dim_customer',
    2,
    '用户信息',
    1,
    '热用户基本信息维度，包含用户编码、名称、联系方式、用户类型、入网信息等',
    1,
    '{"tables": [{"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 2. 组织维度模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '组织维度模型',
    'sf_dim_org',
    2,
    '组织架构',
    1,
    '组织架构维度，包含分公司、热力站、小区三级组织结构',
    1,
    '{"tables": [{"table": "sf_dim_org", "alias": "o", "schema": "heating_analytics"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 3. 面积维度模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '面积维度模型',
    'sf_dim_area',
    2,
    '供热面积',
    1,
    '供热面积维度，包含收费面积、建筑面积、结算方式、供暖状态等',
    1,
    '{"tables": [{"table": "sf_dim_area", "alias": "a", "schema": "heating_analytics"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 4. 时间维度模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '时间维度模型',
    'sf_dim_time',
    2,
    '时间维度',
    1,
    '时间维度，支持采暖期(2025-2026)、年月季度分析',
    1,
    '{"tables": [{"table": "sf_dim_time", "alias": "t", "schema": "heating_analytics"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 5. 收费结算事实模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '收费结算事实模型',
    'sf_rpt_charge',
    3,
    '收费结算',
    1,
    '收费结算核心事实表，存储每个用户每采暖期的应收、实收、欠费金额',
    1,
    '{"tables": [{"table": "sf_rpt_charge", "alias": "m", "schema": "heating_analytics"}, {"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}], "joins": [{"left": "m.customer_id", "right": "c.customer_id", "type": "LEFT JOIN"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 6. 收费明细事实模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '收费明细事实模型',
    'sf_rpt_payment',
    4,
    '收费明细',
    1,
    '收费明细事实表，存储每笔收费的详细信息，包含收费方式、支付渠道等',
    1,
    '{"tables": [{"table": "sf_rpt_payment", "alias": "p", "schema": "heating_analytics"}, {"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}], "joins": [{"left": "p.customer_id", "right": "c.customer_id", "type": "LEFT JOIN"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 7. 停供复供事实模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '停供复供事实模型',
    'sf_fact_stop_restart',
    5,
    '停供复供',
    1,
    '停供复供业务事实表，记录用户的停供申请、复供办理等业务事件',
    1,
    '{"tables": [{"table": "sf_fact_stop_restart", "alias": "sr", "schema": "heating_analytics"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- 8. 采暖期收费汇总模型
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES (
    '采暖期收费汇总模型',
    'sf_rpt_cnq_charge',
    5,
    '采暖期汇总',
    1,
    '采暖期收费汇总表，按采暖期、组织、费用类别等多维度汇总',
    1,
    '{"tables": [{"table": "sf_rpt_cnq_charge", "alias": "sc", "schema": "heating_analytics"}]}',
    CURRENT_TIMESTAMP,
    'admin',
    CURRENT_TIMESTAMP,
    'admin',
    'TABLE'
);

-- ============================================================
-- 三、维度管理 (s2_dimension)
-- ============================================================

-- 用户维度模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '用户ID', 'customer_id', '用户唯一标识', 1, 'categorical', 'BIGINT', 'c.customer_id', 'ID', '["用户标识"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '用户编码', 'customer_code', '用户编码', 1, 'categorical', 'VARCHAR', 'c.customer_code', 'COMMON', '["编码"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '用户名称', 'customer_name', '用户名称', 1, 'categorical', 'VARCHAR', 'c.customer_name', 'COMMON', '["姓名"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '用户类型', 'yhlx', '用户类型:居民/单位', 1, 'categorical', 'VARCHAR', 'c.yhlx', 'COMMON', '["类型"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '手机号码', 'mob_no', '手机号码', 1, 'categorical', 'VARCHAR', 'c.mob_no', 'PHONE', '["电话"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '入网日期', 'rwrq', '入网日期', 1, 'categorical', 'DATE', 'c.rwrq', 'TIME', '["入网时间"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '黑名单标识', 'kz_hmd', '是否黑名单:0-否 1-是', 1, 'categorical', 'SMALLINT', 'c.kz_hmd', 'COMMON', '["黑名单"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(1, '允许收费标识', 'kz_sf', '是否允许收费:0-否 1-是', 1, 'categorical', 'SMALLINT', 'c.kz_sf', 'COMMON', '["可收费"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 组织维度模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '组织ID', 'org_id', '组织唯一标识', 1, 'categorical', 'BIGINT', 'o.org_id', 'ID', '["组织标识"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '分公司', 'org_level1', '分公司名称', 1, 'categorical', 'VARCHAR', 'o.org_level1', 'COMMON', '["分公司"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '热力站', 'org_level2', '热力站名称', 1, 'categorical', 'VARCHAR', 'o.org_level2', 'COMMON', '["热力站"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '小区', 'org_level3', '小区名称', 1, 'categorical', 'VARCHAR', 'o.org_level3', 'COMMON', '["小区"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(2, '组织类型', 'org_type', '组织类型:分公司/热力站/小区', 1, 'categorical', 'VARCHAR', 'o.org_type', 'COMMON', '类型', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 面积维度模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(3, '面积ID', 'area_id', '面积唯一标识', 1, 'categorical', 'BIGINT', 'a.area_id', 'ID', '面积标识', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(3, '面积类别', 'mjlb', '面积类别', 1, 'categorical', 'VARCHAR', 'a.mjlb', 'COMMON', '类别', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(3, '单价类别', 'djlb', '单价类别:居民/非居民/困难户等', 1, 'categorical', 'VARCHAR', 'a.djlb', 'COMMON', '单价类别', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(3, '结算方式', 'jsfs', '结算方式:按面积/计量/两部制', 1, 'categorical', 'VARCHAR', 'a.jsfs', 'COMMON', '结算方式', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(3, '供暖状态', 'gnzt', '供暖状态:正常/停供/部分停供', 1, 'categorical', 'VARCHAR', 'a.gnzt', 'COMMON', '状态', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(3, '阀门状态', 'fmzt', '阀门状态:开阀/关阀', 1, 'categorical', 'VARCHAR', 'a.fmzt', 'COMMON', '阀门', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 时间维度模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '日期ID', 'date_id', '日期主键', 1, 'categorical', 'DATE', 't.date_id', 'TIME', '日期', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '年份', 'year', '年份', 1, 'categorical', 'INT', 't.year', 'TIME', '年', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '月份', 'month', '月份(1-12)', 1, 'categorical', 'INT', 't.month', 'TIME', '月', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '季度', 'quarter', '季度', 1, 'categorical', 'INT', 't.quarter', 'TIME', '季度', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '采暖期', 'cnq', '采暖期(如:2025-2026)', 1, 'categorical', 'VARCHAR', 't.cnq', 'TIME', '采暖期', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '采暖期年份', 'cnq_year', '采暖期起始年', 1, 'categorical', 'INT', 't.cnq_year', 'TIME', '采暖年', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '采暖期月份', 'cnq_month', '采暖期月份(11月=1,12月=2...)', 1, 'categorical', 'INT', 't.cnq_month', 'TIME', '采暖月', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(4, '缴费季标识', 'is_payment_season', '是否缴费季(11月-次年3月)', 1, 'categorical', 'SMALLINT', 't.is_payment_season', 'COMMON', '缴费季', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 收费结算事实模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '采暖期', 'cnq', '采暖期', 1, 'categorical', 'VARCHAR', 'm.cnq', 'TIME', '采暖期', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '费用类别', 'fylb', '费用类别:采暖费/基本热费/计量热费', 1, 'categorical', 'VARCHAR', 'm.fylb', 'COMMON', '费用类别', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '供暖状态', 'gnzt', '供暖状态:正常/停供/部分停供', 1, 'categorical', 'VARCHAR', 'm.gnzt', 'COMMON', '状态', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '用户类型', 'yhlx', '用户类型:居民/单位', 1, 'categorical', 'VARCHAR', 'c.yhlx', 'COMMON', '用户类型', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '分公司', 'org_level1', '分公司', 1, 'categorical', 'VARCHAR', 'c.one', 'COMMON', '分公司', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '热力站', 'org_level2', '热力站', 1, 'categorical', 'VARCHAR', 'c.two', 'COMMON', '热力站', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '小区', 'org_level3', '小区', 1, 'categorical', 'VARCHAR', 'c.three', 'COMMON', '小区', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '单价类别', 'djlb', '单价类别', 1, 'categorical', 'VARCHAR', 'm.djlb', 'COMMON', '单价类别', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(5, '业务事件', 'event', '业务事件:面积变更/停供/复供', 1, 'categorical', 'VARCHAR', 'm.event', 'COMMON', '事件', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 收费明细事实模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(6, '收费日期', 'sfrq', '收费日期', 1, 'categorical', 'TIMESTAMP', 'p.sfrq', 'TIME', '收费时间', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(6, '收费方式', 'sffs', '收费方式:现金/微信/支付宝/银行转账/POS', 1, 'categorical', 'VARCHAR', 'p.sffs', 'COMMON', '支付方式', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(6, '支付渠道', 'zfqd', '支付渠道', 1, 'categorical', 'VARCHAR', 'p.zfqd', 'COMMON', '渠道', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(6, '发票类别', 'fplb', '发票类别', 1, 'categorical', 'VARCHAR', 'p.fplb', 'COMMON', '发票', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 汇总模型的维度字段
INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(8, '统计月份', 'stat_month', '统计月份(YYYY-MM)', 1, 'categorical', 'VARCHAR', 'sc.stat_month', 'TIME', '月份', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(8, '统计日期', 'stat_date', '统计日期', 1, 'categorical', 'DATE', 'sc.stat_date', 'TIME', '日期', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_dimension (model_id, name, biz_name, description, status, type, data_type, expr, semantic_type, alias, created_at, created_by, updated_at, updated_by)
VALUES
(8, '欠费等级', 'arrears_level', '欠费等级:重大欠费/一般欠费/轻微欠费', 1, 'categorical', 'VARCHAR', 'sc.arrears_level', 'COMMON', '欠费等级', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- ============================================================
-- 四、指标管理 (s2_metric)
-- ============================================================

-- 用户类指标
INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(1, '用户总数', 'USER_CNT', '用户总数', 1, 0, 'SIMPLE', '{"expr": "COUNT(DISTINCT c.customer_id)"}', NULL, '用户数', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(1, '新增用户数', 'USER_NEW_CNT', '本期新增用户数', 1, 0, 'SIMPLE', '{"expr": "COUNT(DISTINCT c.customer_id) WHERE c.rwrq >= CURRENT_DATE - INTERVAL ''30 days''"}', NULL, '新增用户', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(1, '黑名单用户数', 'USER_BLACK_CNT', '黑名单用户数', 1, 0, 'SIMPLE', '{"expr": "COUNT(DISTINCT c.customer_id) WHERE c.kz_hmd = 1"}', NULL, '黑名单数', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

-- 面积类指标
INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(3, '收费面积汇总', 'AREA_SFMJ_SUM', '收费面积汇总', 1, 0, 'SIMPLE', '{"expr": "SUM(a.sfmj)"}', 'AREA', '收费面积', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(3, '建筑面积汇总', 'AREA_ZDMJ_SUM', '建筑面积汇总', 1, 0, 'SIMPLE', '{"expr": "SUM(a.zdmj)"}', 'AREA', '建筑面积', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(3, '在供面积数', 'AREA_ACTIVE_CNT', '在供面积数', 1, 0, 'SIMPLE', '{"expr": "COUNT(*) WHERE a.gnzt = ''正常''"}', NULL, '在供数', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

-- 计费类指标
INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(5, '应收金额汇总', 'BILL_YSJE_SUM', '应收金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.ysje)"}', 'MONEY', '应收金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(5, '基础应收汇总', 'BILL_JCYS_SUM', '基础应收汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.jcys)"}', 'MONEY', '基础应收', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(5, '欠费金额汇总', 'BILL_QFJE_SUM', '欠费金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.qfje)"}', 'MONEY', '欠费金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(5, '核减金额汇总', 'BILL_HJJE_SUM', '核减金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.hjje)"}', 'MONEY', '核减金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(5, '折扣金额汇总', 'BILL_ZKJE_SUM', '折扣金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.zkje)"}', 'MONEY', '折扣金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(5, '违约金额汇总', 'BILL_WYJE_SUM', '违约金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.wyje)"}', 'MONEY', '违约金', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

-- 收费类指标
INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(6, '实收金额汇总', 'PAY_SFJE_SUM', '实收金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(p.sfje)"}', 'MONEY', '实收金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(6, '收费笔数', 'PAY_CNT', '收费笔数', 1, 0, 'SIMPLE', '{"expr": "COUNT(*)"}', NULL, '收费笔数', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(6, '线上收费笔数', 'PAY_ONLINE_CNT', '线上收费笔数(微信/支付宝/网银)', 1, 0, 'SIMPLE', '{"expr": "COUNT(*) WHERE p.sffs IN (''微信'',''支付宝'',''网银'')"}', NULL, '线上笔数', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(6, '线下收费笔数', 'PAY_OFFLINE_CNT', '线下收费笔数(现金/POS/转账)', 1, 0, 'SIMPLE', '{"expr": "COUNT(*) WHERE p.sffs IN (''现金'',''POS'',''转账'')"}', NULL, '线下笔数', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(6, '线上收费金额', 'PAY_ONLINE_AMT', '线上收费金额', 1, 1, 'SIMPLE', '{"expr": "SUM(p.sfje) WHERE p.sffs IN (''微信'',''支付宝'',''网银'')"}', 'MONEY', '线上金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type)
VALUES
(6, '线下收费金额', 'PAY_OFFLINE_AMT', '线下收费金额', 1, 1, 'SIMPLE', '{"expr": "SUM(p.sfje) WHERE p.sffs IN (''现金'',''POS'',''转账'')"}', 'MONEY', '线下金额', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE');

-- 衍生指标
INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type, relate_dimensions)
VALUES
(5, '收费率', 'PAY_RATE', '收费率:实收金额/应收金额*100%', 1, 0, 'DERIVED', '{"expr": "sfje_sum / ysje_sum * 100"}', 'PERCENT', '["收费率"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'METRIC', '["cnq","fylb","org_level1"]');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type, relate_dimensions)
VALUES
(5, '欠费率', 'ARREARS_RATE', '欠费率:欠费金额/应收金额*100%', 1, 0, 'DERIVED', '{"expr": "qfje_sum / ysje_sum * 100"}', 'PERCENT', '["欠费率"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'METRIC', '["cnq","fylb","org_level1"]');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type, relate_dimensions)
VALUES
(8, '户均热费', 'AVG_FEE', '户均热费:实收金额/用户数', 1, 0, 'DERIVED', '{"expr": "sfje_sum / customer_cnt"}', 'MONEY', '["户均"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'METRIC', '["cnq","org_level1"]');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type, relate_dimensions)
VALUES
(8, '单位面积热费', 'UNIT_PRICE', '单位面积热费:实收金额/收费面积', 1, 0, 'DERIVED', '{"expr": "sfje_sum / sfmj_sum"}', 'MONEY', '["单价"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'METRIC', '["cnq","fylb","org_level1"]');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type, relate_dimensions)
VALUES
(8, '用户数', 'CUSTOMER_CNT', '用户数', 1, 0, 'SIMPLE', '{"expr": "SUM(sc.customer_cnt)"}', NULL, '["用户数"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE', '["cnq","org_level1"]');

INSERT INTO s2_metric (model_id, name, biz_name, description, status, sensitive_level, type, type_params, data_format_type, alias, created_at, created_by, updated_at, updated_by, define_type, relate_dimensions)
VALUES
(8, '收费面积', 'SFMJ_SUM', '收费面积', 1, 0, 'SIMPLE', '{"expr": "SUM(sc.sfmj_sum)"}', 'AREA', '["面积"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'MEASURE', '["cnq","org_level1"]');

-- ============================================================
-- 五、模型关联 (s2_model_rela)
-- ============================================================

-- 收费结算模型关联用户维度
INSERT INTO s2_model_rela (domain_id, from_model_id, to_model_id, join_type, join_condition)
VALUES (3, 5, 1, 'LEFT JOIN', 'm.customer_id = c.customer_id');

-- 收费结算模型关联组织维度
INSERT INTO s2_model_rela (domain_id, from_model_id, to_model_id, join_type, join_condition)
VALUES (3, 5, 2, 'LEFT JOIN', 'c.rlz_id = o.rlz_id');

-- 收费明细模型关联用户维度
INSERT INTO s2_model_rela (domain_id, from_model_id, to_model_id, join_type, join_condition)
VALUES (4, 6, 1, 'LEFT JOIN', 'p.customer_id = c.customer_id');

-- 收费明细模型关联组织维度
INSERT INTO s2_model_rela (domain_id, from_model_id, to_model_id, join_type, join_condition)
VALUES (4, 6, 2, 'LEFT JOIN', 'c.rlz_id = o.rlz_id');

-- 面积维度关联用户维度
INSERT INTO s2_model_rela (domain_id, from_model_id, to_model_id, join_type, join_condition)
VALUES (2, 3, 1, 'LEFT JOIN', 'a.customer_id = c.customer_id');

-- 汇总模型关联组织维度
INSERT INTO s2_model_rela (domain_id, from_model_id, to_model_id, join_type, join_condition)
VALUES (5, 8, 2, 'LEFT JOIN', 'sc.org_level1 = o.org_level1');

-- ============================================================
-- 六、业务术语 (s2_term)
-- ============================================================

INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(3, '收费率', '实际收取的热费与应收热费的比率，反映收费效率', '["收缴率"]', '["PAY_RATE","BILL_YSJE_SUM","PAY_SFJE_SUM"]', '["cnq","org_level1","fylb"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(3, '欠费', '用户未按时缴纳的热费金额', '["欠费金额"]', '["BILL_QFJE_SUM","ARREARS_RATE"]', '["cnq","org_level1","yhlx"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(3, '采暖期', '供热季节周期，通常为当年11月至次年3月', '["供暖季"]', '["BILL_YSJE_SUM","PAY_SFJE_SUM"]', '["cnq","cnq_year"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(4, '线上收费', '通过微信、支付宝、网银等线上渠道收取的热费', '["电子支付"]', '["PAY_ONLINE_CNT","PAY_ONLINE_AMT"]', '["sffs","zfqd"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(2, '在供用户', '正在享受供热服务的用户', '["正常供热"]', '["USER_CNT","AREA_SFMJ_SUM"]', '["gnzt","yhlx"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES
(5, '停供', '用户申请暂停供热服务', '["停止供暖"]', '["AREA_TGMJ_SUM"]', '["ywlx","org_level1"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- ============================================================
-- 执行完成
-- ============================================================

SELECT '供热收费系统语义建模数据导入完成' AS status;
SELECT '主题域: 6个' AS domain_count;
SELECT '数据模型: 8个' AS model_count;
SELECT '维度字段: 约50个' AS dimension_count;
SELECT '指标: 约25个' AS metric_count;
SELECT '模型关联: 6个' AS model_rela_count;
SELECT '业务术语: 6个' AS term_count;
