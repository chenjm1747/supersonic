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

# 更新所有模型
update_sql = f"""
SET search_path TO heating_analytics;

-- 用户维度模型 (id=22) - customer 表
UPDATE s2_model SET model_detail = '{user_model}' WHERE id = 22;

-- 面积维度模型 (id=24) - area 表
UPDATE s2_model SET model_detail = '{area_model}' WHERE id = 24;

SELECT '所有模型已更新' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
