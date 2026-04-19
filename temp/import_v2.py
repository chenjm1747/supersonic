# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清理旧数据 - 只删除供热收费相关的
cleanup_sql = """
SET search_path TO heating_analytics;
DELETE FROM s2_data_set WHERE domain_id >= 4;
DELETE FROM s2_model WHERE domain_id >= 4;
DELETE FROM s2_dimension WHERE model_id >= 9;
DELETE FROM s2_metric WHERE model_id >= 9;
DELETE FROM s2_model_rela WHERE domain_id >= 4;
DELETE FROM s2_term WHERE domain_id >= 4;
DELETE FROM s2_domain WHERE id >= 4;
DELETE FROM s2_domain WHERE biz_name LIKE 'heating_%';
"""

# 主题域SQL
domain_sql = """
SET search_path TO heating_analytics;
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费系统', 'heating_charge', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '供热收费核心业务域');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费用户域', 'heating_customer', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '热用户管理');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费计费域', 'heating_billing', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '费用计算与结算');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费收费域', 'heating_collection', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '实收费用管理');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费运营域', 'heating_operation', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '业务运营分析');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费质量域', 'heating_quality', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '数据质量监控');
"""

# 用户维度模型
user_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT customer_id, customer_code, customer_name, yhlx, mob_no, rwrq, kz_hmd, kz_sf FROM sf_dim_customer",
    "identifiers": [{"name": "用户ID", "type": "primary", "bizName": "customer_id", "isCreateDimension": 1, "fieldName": "customer_id"}],
    "dimensions": [
        {"name": "用户ID", "type": "primary_key", "expr": "customer_id", "bizName": "customer_id", "fieldName": "customer_id"},
        {"name": "用户编码", "type": "categorical", "expr": "customer_code", "bizName": "customer_code", "fieldName": "customer_code"},
        {"name": "用户名称", "type": "categorical", "expr": "customer_name", "bizName": "customer_name", "fieldName": "customer_name"},
        {"name": "用户类型", "type": "categorical", "expr": "yhlx", "bizName": "yhlx", "fieldName": "yhlx"},
        {"name": "手机号码", "type": "categorical", "expr": "mob_no", "bizName": "mob_no", "fieldName": "mob_no"},
        {"name": "入网日期", "type": "time", "expr": "rwrq", "bizName": "rwrq", "fieldName": "rwrq"},
        {"name": "黑名单标识", "type": "categorical", "expr": "kz_hmd", "bizName": "kz_hmd", "fieldName": "kz_hmd"},
        {"name": "允许收费标识", "type": "categorical", "expr": "kz_sf", "bizName": "kz_sf", "fieldName": "kz_sf"}
    ],
    "measures": [{"name": "用户总数", "agg": "COUNT", "expr": "customer_id", "bizName": "USER_CNT", "isCreateMetric": 1, "fieldName": "customer_id"}],
    "fields": [{"fieldName": "customer_id", "dataType": "Bigint"}, {"fieldName": "customer_code", "dataType": "Varchar"}, {"fieldName": "customer_name", "dataType": "Varchar"}, {"fieldName": "yhlx", "dataType": "Varchar"}, {"fieldName": "mob_no", "dataType": "Varchar"}, {"fieldName": "rwrq", "dataType": "Date"}, {"fieldName": "kz_hmd", "dataType": "Smallint"}, {"fieldName": "kz_sf", "dataType": "Smallint"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 组织维度模型
org_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT org_id, org_level1, org_level2, org_level3, org_type FROM sf_dim_org",
    "identifiers": [{"name": "组织ID", "type": "primary", "bizName": "org_id", "isCreateDimension": 1, "fieldName": "org_id"}],
    "dimensions": [
        {"name": "组织ID", "type": "primary_key", "expr": "org_id", "bizName": "org_id", "fieldName": "org_id"},
        {"name": "分公司", "type": "categorical", "expr": "org_level1", "bizName": "org_level1", "fieldName": "org_level1"},
        {"name": "热力站", "type": "categorical", "expr": "org_level2", "bizName": "org_level2", "fieldName": "org_level2"},
        {"name": "小区", "type": "categorical", "expr": "org_level3", "bizName": "org_level3", "fieldName": "org_level3"},
        {"name": "组织类型", "type": "categorical", "expr": "org_type", "bizName": "org_type", "fieldName": "org_type"}
    ],
    "measures": [],
    "fields": [{"fieldName": "org_id", "dataType": "Bigint"}, {"fieldName": "org_level1", "dataType": "Varchar"}, {"fieldName": "org_level2", "dataType": "Varchar"}, {"fieldName": "org_level3", "dataType": "Varchar"}, {"fieldName": "org_type", "dataType": "Varchar"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 面积维度模型
area_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT area_id, customer_id, mjlb, djlb, jsfs, sfmj, zdmj, gnzt, fmzt FROM sf_dim_area",
    "identifiers": [{"name": "面积ID", "type": "primary", "bizName": "area_id", "isCreateDimension": 1, "fieldName": "area_id"}],
    "dimensions": [
        {"name": "面积ID", "type": "primary_key", "expr": "area_id", "bizName": "area_id", "fieldName": "area_id"},
        {"name": "面积类别", "type": "categorical", "expr": "mjlb", "bizName": "mjlb", "fieldName": "mjlb"},
        {"name": "单价类别", "type": "categorical", "expr": "djlb", "bizName": "djlb", "fieldName": "djlb"},
        {"name": "结算方式", "type": "categorical", "expr": "jsfs", "bizName": "jsfs", "fieldName": "jsfs"},
        {"name": "供暖状态", "type": "categorical", "expr": "gnzt", "bizName": "gnzt", "fieldName": "gnzt"},
        {"name": "阀门状态", "type": "categorical", "expr": "fmzt", "bizName": "fmzt", "fieldName": "fmzt"}
    ],
    "measures": [
        {"name": "收费面积汇总", "agg": "SUM", "expr": "sfmj", "bizName": "AREA_SFMJ_SUM", "isCreateMetric": 1, "fieldName": "sfmj"},
        {"name": "建筑面积汇总", "agg": "SUM", "expr": "zdmj", "bizName": "AREA_ZDMJ_SUM", "isCreateMetric": 1, "fieldName": "zdmj"}
    ],
    "fields": [{"fieldName": "area_id", "dataType": "Bigint"}, {"fieldName": "customer_id", "dataType": "Bigint"}, {"fieldName": "mjlb", "dataType": "Varchar"}, {"fieldName": "djlb", "dataType": "Varchar"}, {"fieldName": "jsfs", "dataType": "Varchar"}, {"fieldName": "sfmj", "dataType": "Numeric"}, {"fieldName": "zdmj", "dataType": "Numeric"}, {"fieldName": "gnzt", "dataType": "Varchar"}, {"fieldName": "fmzt", "dataType": "Varchar"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 时间维度模型
time_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT date_id, year, month, quarter, cnq, cnq_year, cnq_month, is_payment_season FROM sf_dim_time",
    "identifiers": [{"name": "日期ID", "type": "primary", "bizName": "date_id", "isCreateDimension": 1, "fieldName": "date_id"}],
    "dimensions": [
        {"name": "日期ID", "type": "time", "expr": "date_id", "bizName": "date_id", "fieldName": "date_id"},
        {"name": "年份", "type": "categorical", "expr": "year", "bizName": "year", "fieldName": "year"},
        {"name": "月份", "type": "categorical", "expr": "month", "bizName": "month", "fieldName": "month"},
        {"name": "季度", "type": "categorical", "expr": "quarter", "bizName": "quarter", "fieldName": "quarter"},
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "采暖期年份", "type": "categorical", "expr": "cnq_year", "bizName": "cnq_year", "fieldName": "cnq_year"},
        {"name": "采暖期月份", "type": "categorical", "expr": "cnq_month", "bizName": "cnq_month", "fieldName": "cnq_month"},
        {"name": "缴费季标识", "type": "categorical", "expr": "is_payment_season", "bizName": "is_payment_season", "fieldName": "is_payment_season"}
    ],
    "measures": [],
    "fields": [{"fieldName": "date_id", "dataType": "Date"}, {"fieldName": "year", "dataType": "Integer"}, {"fieldName": "month", "dataType": "Integer"}, {"fieldName": "quarter", "dataType": "Integer"}, {"fieldName": "cnq", "dataType": "Varchar"}, {"fieldName": "cnq_year", "dataType": "Integer"}, {"fieldName": "cnq_month", "dataType": "Integer"}, {"fieldName": "is_payment_season", "dataType": "Smallint"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 收费结算事实模型
charge_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT cnq, fylb, gnzt, yhlx, one, two, three, djlb, event, ysje, jcys, qfje, hjje, zkje, wyje FROM sf_rpt_charge",
    "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}],
    "dimensions": [
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "费用类别", "type": "categorical", "expr": "fylb", "bizName": "fylb", "fieldName": "fylb"},
        {"name": "供暖状态", "type": "categorical", "expr": "gnzt", "bizName": "gnzt", "fieldName": "gnzt"},
        {"name": "用户类型", "type": "categorical", "expr": "yhlx", "bizName": "yhlx", "fieldName": "yhlx"},
        {"name": "分公司", "type": "categorical", "expr": "one", "bizName": "org_level1", "fieldName": "one"},
        {"name": "热力站", "type": "categorical", "expr": "two", "bizName": "org_level2", "fieldName": "two"},
        {"name": "小区", "type": "categorical", "expr": "three", "bizName": "org_level3", "fieldName": "three"},
        {"name": "单价类别", "type": "categorical", "expr": "djlb", "bizName": "djlb", "fieldName": "djlb"},
        {"name": "业务事件", "type": "categorical", "expr": "event", "bizName": "event", "fieldName": "event"}
    ],
    "measures": [
        {"name": "应收金额", "agg": "SUM", "expr": "ysje", "bizName": "BILL_YSJE_SUM", "isCreateMetric": 1, "fieldName": "ysje"},
        {"name": "基础应收", "agg": "SUM", "expr": "jcys", "bizName": "BILL_JCYS_SUM", "isCreateMetric": 1, "fieldName": "jcys"},
        {"name": "欠费金额", "agg": "SUM", "expr": "qfje", "bizName": "BILL_QFJE_SUM", "isCreateMetric": 1, "fieldName": "qfje"},
        {"name": "核减金额", "agg": "SUM", "expr": "hjje", "bizName": "BILL_HJJE_SUM", "isCreateMetric": 1, "fieldName": "hjje"},
        {"name": "折扣金额", "agg": "SUM", "expr": "zkje", "bizName": "BILL_ZKJE_SUM", "isCreateMetric": 1, "fieldName": "zkje"},
        {"name": "违约金额", "agg": "SUM", "expr": "wyje", "bizName": "BILL_WYJE_SUM", "isCreateMetric": 1, "fieldName": "wyje"}
    ],
    "fields": [{"fieldName": "cnq", "dataType": "Varchar"}, {"fieldName": "fylb", "dataType": "Varchar"}, {"fieldName": "gnzt", "dataType": "Varchar"}, {"fieldName": "yhlx", "dataType": "Varchar"}, {"fieldName": "one", "dataType": "Varchar"}, {"fieldName": "two", "dataType": "Varchar"}, {"fieldName": "three", "dataType": "Varchar"}, {"fieldName": "djlb", "dataType": "Varchar"}, {"fieldName": "event", "dataType": "Varchar"}, {"fieldName": "ysje", "dataType": "Numeric"}, {"fieldName": "jcys", "dataType": "Numeric"}, {"fieldName": "qfje", "dataType": "Numeric"}, {"fieldName": "hjje", "dataType": "Numeric"}, {"fieldName": "zkje", "dataType": "Numeric"}, {"fieldName": "wyje", "dataType": "Numeric"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 收费明细事实模型
payment_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT sfrq, sffs, zfqd, fplb, sfje FROM sf_rpt_payment",
    "identifiers": [{"name": "收费日期", "type": "primary", "bizName": "sfrq", "isCreateDimension": 1, "fieldName": "sfrq"}],
    "dimensions": [
        {"name": "收费日期", "type": "time", "expr": "sfrq", "bizName": "sfrq", "fieldName": "sfrq"},
        {"name": "收费方式", "type": "categorical", "expr": "sffs", "bizName": "sffs", "fieldName": "sffs"},
        {"name": "支付渠道", "type": "categorical", "expr": "zfqd", "bizName": "zfqd", "fieldName": "zfqd"},
        {"name": "发票类别", "type": "categorical", "expr": "fplb", "bizName": "fplb", "fieldName": "fplb"}
    ],
    "measures": [
        {"name": "实收金额", "agg": "SUM", "expr": "sfje", "bizName": "PAY_SFJE_SUM", "isCreateMetric": 1, "fieldName": "sfje"},
        {"name": "收费笔数", "agg": "COUNT", "expr": "1", "bizName": "PAY_CNT", "isCreateMetric": 1, "fieldName": "id"}
    ],
    "fields": [{"fieldName": "sfrq", "dataType": "Timestamp"}, {"fieldName": "sffs", "dataType": "Varchar"}, {"fieldName": "zfqd", "dataType": "Varchar"}, {"fieldName": "fplb", "dataType": "Varchar"}, {"fieldName": "sfje", "dataType": "Numeric"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 停供复供事实模型
stop_restart_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT ywlx, sqrq, lx, org_level1 FROM sf_fact_stop_restart",
    "identifiers": [{"name": "申请日期", "type": "primary", "bizName": "sqrq", "isCreateDimension": 1, "fieldName": "sqrq"}],
    "dimensions": [
        {"name": "业务类型", "type": "categorical", "expr": "ywlx", "bizName": "ywlx", "fieldName": "ywlx"},
        {"name": "申请日期", "type": "time", "expr": "sqrq", "bizName": "sqrq", "fieldName": "sqrq"},
        {"name": "类型", "type": "categorical", "expr": "lx", "bizName": "lx", "fieldName": "lx"},
        {"name": "分公司", "type": "categorical", "expr": "org_level1", "bizName": "org_level1", "fieldName": "org_level1"}
    ],
    "measures": [],
    "fields": [{"fieldName": "ywlx", "dataType": "Varchar"}, {"fieldName": "sqrq", "dataType": "Date"}, {"fieldName": "lx", "dataType": "Varchar"}, {"fieldName": "org_level1", "dataType": "Varchar"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 采暖期收费汇总模型
cnq_charge_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT cnq, org_level1, stat_month, stat_date, arrears_level, customer_cnt, sfmj_sum, ysje_sum, sfje_sum FROM sf_rpt_cnq_charge",
    "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}],
    "dimensions": [
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "分公司", "type": "categorical", "expr": "org_level1", "bizName": "org_level1", "fieldName": "org_level1"},
        {"name": "统计月份", "type": "categorical", "expr": "stat_month", "bizName": "stat_month", "fieldName": "stat_month"},
        {"name": "统计日期", "type": "time", "expr": "stat_date", "bizName": "stat_date", "fieldName": "stat_date"},
        {"name": "欠费等级", "type": "categorical", "expr": "arrears_level", "bizName": "arrears_level", "fieldName": "arrears_level"}
    ],
    "measures": [
        {"name": "用户数", "agg": "SUM", "expr": "customer_cnt", "bizName": "CUSTOMER_CNT", "isCreateMetric": 1, "fieldName": "customer_cnt"},
        {"name": "收费面积", "agg": "SUM", "expr": "sfmj_sum", "bizName": "SFMJ_SUM", "isCreateMetric": 1, "fieldName": "sfmj_sum"},
        {"name": "应收金额", "agg": "SUM", "expr": "ysje_sum", "bizName": "YSJE_SUM", "isCreateMetric": 1, "fieldName": "ysje_sum"},
        {"name": "实收金额", "agg": "SUM", "expr": "sfje_sum", "bizName": "SFJE_SUM", "isCreateMetric": 1, "fieldName": "sfje_sum"}
    ],
    "fields": [{"fieldName": "cnq", "dataType": "Varchar"}, {"fieldName": "org_level1", "dataType": "Varchar"}, {"fieldName": "stat_month", "dataType": "Varchar"}, {"fieldName": "stat_date", "dataType": "Date"}, {"fieldName": "arrears_level", "dataType": "Varchar"}, {"fieldName": "customer_cnt", "dataType": "Bigint"}, {"fieldName": "sfmj_sum", "dataType": "Numeric"}, {"fieldName": "ysje_sum", "dataType": "Numeric"}, {"fieldName": "sfje_sum", "dataType": "Numeric"}],
    "sqlVariables": []
}, ensure_ascii=False)

# 模型SQL
model_sql = f"""
SET search_path TO heating_analytics;
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('用户维度模型', 'sf_dim_customer', 5, '用户信息', 1, '热用户基本信息', 1, '{user_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('组织维度模型', 'sf_dim_org', 5, '组织架构', 1, '组织架构维度', 1, '{org_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('面积维度模型', 'sf_dim_area', 5, '供热面积', 1, '供热面积维度', 1, '{area_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('时间维度模型', 'sf_dim_time', 5, '时间维度', 1, '时间维度', 1, '{time_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('收费结算事实模型', 'sf_rpt_charge', 6, '收费结算', 1, '收费结算核心事实表', 1, '{charge_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('收费明细事实模型', 'sf_rpt_payment', 7, '收费明细', 1, '收费明细事实表', 1, '{payment_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('停供复供事实模型', 'sf_fact_stop_restart', 8, '停供复供', 1, '停供复供业务事实表', 1, '{stop_restart_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('采暖期收费汇总模型', 'sf_rpt_cnq_charge', 8, '采暖期汇总', 1, '采暖期收费汇总表', 1, '{cnq_charge_model_detail}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
"""

# 数据集SQL
data_set_sql = """
SET search_path TO heating_analytics;
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '用户维度数据集', 'sf_dim_customer_ds', '热用户基本信息数据集', 1, '用户信息', '{"dataSetModelConfigs":[{"id": 9, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '组织维度数据集', 'sf_dim_org_ds', '组织架构维度数据集', 1, '组织架构', '{"dataSetModelConfigs":[{"id": 10, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '面积维度数据集', 'sf_dim_area_ds', '供热面积维度数据集', 1, '供热面积', '{"dataSetModelConfigs":[{"id": 11, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '时间维度数据集', 'sf_dim_time_ds', '时间维度数据集', 1, '时间维度', '{"dataSetModelConfigs":[{"id": 12, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (6, '收费结算数据集', 'sf_rpt_charge_ds', '收费结算核心数据集', 1, '收费结算', '{"dataSetModelConfigs":[{"id": 13, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', 'CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (7, '收费明细数据集', 'sf_rpt_payment_ds', '收费明细数据集', 1, '收费明细', '{"dataSetModelConfigs":[{"id": 14, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (8, '停供复供数据集', 'sf_fact_stop_restart_ds', '停供复供业务数据集', 1, '停供复供', '{"dataSetModelConfigs":[{"id": 15, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (8, '采暖期收费汇总数据集', 'sf_rpt_cnq_charge_ds', '采暖期收费汇总数据集', 1, '采暖期汇总', '{"dataSetModelConfigs":[{"id": 16, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
"""

# 执行清理
result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=cleanup_sql, capture_output=True, text=True, encoding='utf-8')
print("清理:", result.stdout)

# 执行主题域导入
result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=domain_sql, capture_output=True, text=True, encoding='utf-8')
print("主题域:", result.stdout)

# 执行模型导入
result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=model_sql, capture_output=True, text=True, encoding='utf-8')
print("模型:", result.stdout)

# 执行数据集导入
result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=data_set_sql, capture_output=True, text=True, encoding='utf-8')
print("数据集:", result.stdout)

print("\n全部导入完成!")
