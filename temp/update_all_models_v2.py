# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 用户维度模型 - MySQL: customer
user_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT id as customer_id, code as customer_code, name as customer_name, yhlx, mob_no, rwrq, kz_hmd, kz_sf, one, two, three, rlz_id FROM customer WHERE zf = 0",
    "identifiers": [{"name": "用户ID", "type": "primary", "bizName": "customer_id", "isCreateDimension": 1, "fieldName": "customer_id"}],
    "dimensions": [
        {"name": "用户ID", "type": "primary_key", "expr": "customer_id", "bizName": "customer_id", "fieldName": "customer_id"},
        {"name": "用户编码", "type": "categorical", "expr": "customer_code", "bizName": "customer_code", "fieldName": "customer_code"},
        {"name": "用户名称", "type": "categorical", "expr": "customer_name", "bizName": "customer_name", "fieldName": "customer_name"},
        {"name": "用户类型", "type": "categorical", "expr": "yhlx", "bizName": "yhlx", "fieldName": "yhlx"},
        {"name": "手机号码", "type": "categorical", "expr": "mob_no", "bizName": "mob_no", "fieldName": "mob_no"},
        {"name": "入网日期", "type": "time", "expr": "rwrq", "bizName": "rwrq", "fieldName": "rwrq"},
        {"name": "黑名单标识", "type": "categorical", "expr": "kz_hmd", "bizName": "kz_hmd", "fieldName": "kz_hmd"},
        {"name": "允许收费标识", "type": "categorical", "expr": "kz_sf", "bizName": "kz_sf", "fieldName": "kz_sf"},
        {"name": "分公司", "type": "categorical", "expr": "one", "bizName": "org_level1", "fieldName": "one"},
        {"name": "热力站", "type": "categorical", "expr": "two", "bizName": "org_level2", "fieldName": "two"},
        {"name": "小区", "type": "categorical", "expr": "three", "bizName": "org_level3", "fieldName": "three"},
        {"name": "热力站ID", "type": "categorical", "expr": "rlz_id", "bizName": "rlz_id", "fieldName": "rlz_id"}
    ],
    "measures": [
        {"name": "用户总数", "agg": "COUNT", "expr": "customer_id", "bizName": "USER_CNT", "isCreateMetric": 1, "fieldName": "customer_id"}
    ],
    "fields": [
        {"fieldName": "customer_id", "dataType": "Bigint"},
        {"fieldName": "customer_code", "dataType": "Varchar"},
        {"fieldName": "customer_name", "dataType": "Varchar"},
        {"fieldName": "yhlx", "dataType": "Varchar"},
        {"fieldName": "mob_no", "dataType": "Varchar"},
        {"fieldName": "rwrq", "dataType": "Date"},
        {"fieldName": "kz_hmd", "dataType": "Smallint"},
        {"fieldName": "kz_sf", "dataType": "Smallint"},
        {"fieldName": "one", "dataType": "Varchar"},
        {"fieldName": "two", "dataType": "Varchar"},
        {"fieldName": "three", "dataType": "Varchar"},
        {"fieldName": "rlz_id", "dataType": "Bigint"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 组织维度模型 - 使用 customer 表的 one/two/three 字段
org_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT DISTINCT one, two, three FROM customer WHERE zf = 0",
    "identifiers": [{"name": "分公司", "type": "primary", "bizName": "org_level1", "isCreateDimension": 1, "fieldName": "one"}],
    "dimensions": [
        {"name": "分公司", "type": "categorical", "expr": "one", "bizName": "org_level1", "fieldName": "one"},
        {"name": "热力站", "type": "categorical", "expr": "two", "bizName": "org_level2", "fieldName": "two"},
        {"name": "小区", "type": "categorical", "expr": "three", "bizName": "org_level3", "fieldName": "three"}
    ],
    "measures": [],
    "fields": [
        {"fieldName": "one", "dataType": "Varchar"},
        {"fieldName": "two", "dataType": "Varchar"},
        {"fieldName": "three", "dataType": "Varchar"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 面积维度模型 - MySQL: area
area_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT id as area_id, customer_id, mjlb, djlb, jsfs, sfmj, zdmj, symj FROM area WHERE zf = 0",
    "identifiers": [{"name": "面积ID", "type": "primary", "bizName": "area_id", "isCreateDimension": 1, "fieldName": "area_id"}],
    "dimensions": [
        {"name": "面积ID", "type": "primary_key", "expr": "area_id", "bizName": "area_id", "fieldName": "area_id"},
        {"name": "面积类别", "type": "categorical", "expr": "mjlb", "bizName": "mjlb", "fieldName": "mjlb"},
        {"name": "单价类别", "type": "categorical", "expr": "djlb", "bizName": "djlb", "fieldName": "djlb"},
        {"name": "结算方式", "type": "categorical", "expr": "jsfs", "bizName": "jsfs", "fieldName": "jsfs"}
    ],
    "measures": [
        {"name": "收费面积汇总", "agg": "SUM", "expr": "sfmj", "bizName": "AREA_SFMJ_SUM", "isCreateMetric": 1, "fieldName": "sfmj"},
        {"name": "建筑面积汇总", "agg": "SUM", "expr": "zdmj", "bizName": "AREA_ZDMJ_SUM", "isCreateMetric": 1, "fieldName": "zdmj"}
    ],
    "fields": [
        {"fieldName": "area_id", "dataType": "Bigint"},
        {"fieldName": "customer_id", "dataType": "Bigint"},
        {"fieldName": "mjlb", "dataType": "Varchar"},
        {"fieldName": "djlb", "dataType": "Varchar"},
        {"fieldName": "jsfs", "dataType": "Varchar"},
        {"fieldName": "sfmj", "dataType": "Decimal"},
        {"fieldName": "zdmj", "dataType": "Decimal"},
        {"fieldName": "symj", "dataType": "Decimal"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 时间维度模型 - 使用 sf_mj_t 表的 created_time
time_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT DATE_FORMAT(created_time, '%Y-%m-%d') as date_id, YEAR(created_time) as year, MONTH(created_time) as month, QUARTER(created_time) as quarter FROM sf_mj_t WHERE zf = 0 GROUP BY DATE_FORMAT(created_time, '%Y-%m-%d'), YEAR(created_time), MONTH(created_time), QUARTER(created_time)",
    "identifiers": [{"name": "日期", "type": "primary", "bizName": "date_id", "isCreateDimension": 1, "fieldName": "date_id"}],
    "dimensions": [
        {"name": "日期", "type": "time", "expr": "date_id", "bizName": "date_id", "fieldName": "date_id"},
        {"name": "年份", "type": "categorical", "expr": "year", "bizName": "year", "fieldName": "year"},
        {"name": "月份", "type": "categorical", "expr": "month", "bizName": "month", "fieldName": "month"},
        {"name": "季度", "type": "categorical", "expr": "quarter", "bizName": "quarter", "fieldName": "quarter"}
    ],
    "measures": [],
    "fields": [
        {"fieldName": "date_id", "dataType": "Date"},
        {"fieldName": "year", "dataType": "Integer"},
        {"fieldName": "month", "dataType": "Integer"},
        {"fieldName": "quarter", "dataType": "Integer"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 收费结算事实模型 - MySQL: sf_js_t
charge_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT cnq, customer_id, fylb, ysje, sfje, qfje, wyje, zkje, hjje FROM sf_js_t WHERE zf = 0",
    "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}],
    "dimensions": [
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "费用类别", "type": "categorical", "expr": "fylb", "bizName": "fylb", "fieldName": "fylb"}
    ],
    "measures": [
        {"name": "应收金额", "agg": "SUM", "expr": "ysje", "bizName": "BILL_YSJE_SUM", "isCreateMetric": 1, "fieldName": "ysje"},
        {"name": "实收金额", "agg": "SUM", "expr": "sfje", "bizName": "BILL_SFJE_SUM", "isCreateMetric": 1, "fieldName": "sfje"},
        {"name": "欠费金额", "agg": "SUM", "expr": "qfje", "bizName": "BILL_QFJE_SUM", "isCreateMetric": 1, "fieldName": "qfje"},
        {"name": "违约金额", "agg": "SUM", "expr": "wyje", "bizName": "BILL_WYJE_SUM", "isCreateMetric": 1, "fieldName": "wyje"},
        {"name": "折扣金额", "agg": "SUM", "expr": "zkje", "bizName": "BILL_ZKJE_SUM", "isCreateMetric": 1, "fieldName": "zkje"},
        {"name": "核减金额", "agg": "SUM", "expr": "hjje", "bizName": "BILL_HJJE_SUM", "isCreateMetric": 1, "fieldName": "hjje"}
    ],
    "fields": [
        {"fieldName": "cnq", "dataType": "Varchar"},
        {"fieldName": "customer_id", "dataType": "Bigint"},
        {"fieldName": "fylb", "dataType": "Varchar"},
        {"fieldName": "ysje", "dataType": "Decimal"},
        {"fieldName": "sfje", "dataType": "Decimal"},
        {"fieldName": "qfje", "dataType": "Decimal"},
        {"fieldName": "wyje", "dataType": "Decimal"},
        {"fieldName": "zkje", "dataType": "Decimal"},
        {"fieldName": "hjje", "dataType": "Decimal"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 收费明细事实模型 - MySQL: pay_order
payment_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT id, customer_id, cnq, fylb, sfje, bill_date, sffs, source FROM pay_order WHERE zf = 0 AND sfzt = 1",
    "identifiers": [{"name": "收费ID", "type": "primary", "bizName": "id", "isCreateDimension": 1, "fieldName": "id"}],
    "dimensions": [
        {"name": "收费日期", "type": "time", "expr": "bill_date", "bizName": "bill_date", "fieldName": "bill_date"},
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "费用类别", "type": "categorical", "expr": "fylb", "bizName": "fylb", "fieldName": "fylb"},
        {"name": "收费方式", "type": "categorical", "expr": "sffs", "bizName": "sffs", "fieldName": "sffs"},
        {"name": "支付渠道", "type": "categorical", "expr": "source", "bizName": "source", "fieldName": "source"}
    ],
    "measures": [
        {"name": "实收金额", "agg": "SUM", "expr": "sfje", "bizName": "PAY_SFJE_SUM", "isCreateMetric": 1, "fieldName": "sfje"},
        {"name": "收费笔数", "agg": "COUNT", "expr": "id", "bizName": "PAY_CNT", "isCreateMetric": 1, "fieldName": "id"}
    ],
    "fields": [
        {"fieldName": "id", "dataType": "Bigint"},
        {"fieldName": "customer_id", "dataType": "Bigint"},
        {"fieldName": "cnq", "dataType": "Varchar"},
        {"fieldName": "fylb", "dataType": "Varchar"},
        {"fieldName": "sfje", "dataType": "Decimal"},
        {"fieldName": "bill_date", "dataType": "Datetime"},
        {"fieldName": "sffs", "dataType": "Varchar"},
        {"fieldName": "source", "dataType": "Varchar"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 停供复供事实模型 - MySQL: sf_ksgs_t
stop_restart_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT id, customer_id, cnq, type, cljg, fmzt, czsj, one FROM sf_ksgs_t WHERE zf = 0",
    "identifiers": [{"name": "ID", "type": "primary", "bizName": "id", "isCreateDimension": 1, "fieldName": "id"}],
    "dimensions": [
        {"name": "申请日期", "type": "time", "expr": "czsj", "bizName": "czsj", "fieldName": "czsj"},
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "业务类型", "type": "categorical", "expr": "type", "bizName": "type", "fieldName": "type"},
        {"name": "处理结果", "type": "categorical", "expr": "cljg", "bizName": "cljg", "fieldName": "cljg"},
        {"name": "阀门状态", "type": "categorical", "expr": "fmzt", "bizName": "fmzt", "fieldName": "fmzt"},
        {"name": "分公司", "type": "categorical", "expr": "one", "bizName": "org_level1", "fieldName": "one"}
    ],
    "measures": [],
    "fields": [
        {"fieldName": "id", "dataType": "Bigint"},
        {"fieldName": "customer_id", "dataType": "Bigint"},
        {"fieldName": "cnq", "dataType": "Varchar"},
        {"fieldName": "type", "dataType": "Varchar"},
        {"fieldName": "cljg", "dataType": "Varchar"},
        {"fieldName": "fmzt", "dataType": "Varchar"},
        {"fieldName": "czsj", "dataType": "Datetime"},
        {"fieldName": "one", "dataType": "Varchar"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 采暖期收费汇总模型 - MySQL: 聚合 sf_js_t
cnq_charge_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT cnq, COUNT(DISTINCT customer_id) as customer_cnt, SUM(ysje) as ysje_sum, SUM(sfje) as sfje_sum, SUM(sfmj) as sfmj_sum FROM sf_mj_t WHERE zf = 0 GROUP BY cnq",
    "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}],
    "dimensions": [
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"}
    ],
    "measures": [
        {"name": "用户数", "agg": "SUM", "expr": "customer_cnt", "bizName": "CUSTOMER_CNT", "isCreateMetric": 1, "fieldName": "customer_cnt"},
        {"name": "收费面积", "agg": "SUM", "expr": "sfmj_sum", "bizName": "SFMJ_SUM", "isCreateMetric": 1, "fieldName": "sfmj_sum"},
        {"name": "应收金额", "agg": "SUM", "expr": "ysje_sum", "bizName": "YSJE_SUM", "isCreateMetric": 1, "fieldName": "ysje_sum"},
        {"name": "实收金额", "agg": "SUM", "expr": "sfje_sum", "bizName": "SFJE_SUM", "isCreateMetric": 1, "fieldName": "sfje_sum"}
    ],
    "fields": [
        {"fieldName": "cnq", "dataType": "Varchar"},
        {"fieldName": "customer_cnt", "dataType": "Bigint"},
        {"fieldName": "sfmj_sum", "dataType": "Decimal"},
        {"fieldName": "ysje_sum", "dataType": "Decimal"},
        {"fieldName": "sfje_sum", "dataType": "Decimal"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 更新所有模型
update_sql = f"""
SET search_path TO heating_analytics;

-- 用户维度模型 (id=22)
UPDATE s2_model SET model_detail = '{user_model}' WHERE id = 22;

-- 组织维度模型 (id=23)
UPDATE s2_model SET model_detail = '{org_model}' WHERE id = 23;

-- 面积维度模型 (id=24)
UPDATE s2_model SET model_detail = '{area_model}' WHERE id = 24;

-- 时间维度模型 (id=25)
UPDATE s2_model SET model_detail = '{time_model}' WHERE id = 25;

-- 收费结算事实模型 (id=26)
UPDATE s2_model SET model_detail = '{charge_model}' WHERE id = 26;

-- 收费明细事实模型 (id=27)
UPDATE s2_model SET model_detail = '{payment_model}' WHERE id = 27;

-- 停供复供事实模型 (id=28)
UPDATE s2_model SET model_detail = '{stop_restart_model}' WHERE id = 28;

-- 采暖期收费汇总模型 (id=29)
UPDATE s2_model SET model_detail = '{cnq_charge_model}' WHERE id = 29;

SELECT '所有模型已更新' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
