# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 用户维度模型 - MySQL 表: customer
user_model_detail = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": "SELECT id as customer_id, code as customer_code, name as customer_name, yhlx, mob_no, rwrq, kz_hmd, kz_sf FROM customer WHERE zf = 0",
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
    "fields": [
        {"fieldName": "customer_id", "dataType": "Bigint"},
        {"fieldName": "customer_code", "dataType": "Varchar"},
        {"fieldName": "customer_name", "dataType": "Varchar"},
        {"fieldName": "yhlx", "dataType": "Varchar"},
        {"fieldName": "mob_no", "dataType": "Varchar"},
        {"fieldName": "rwrq", "dataType": "Date"},
        {"fieldName": "kz_hmd", "dataType": "Smallint"},
        {"fieldName": "kz_sf", "dataType": "Smallint"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

# 更新用户维度模型
update_sql = f"""
SET search_path TO heating_analytics;
UPDATE s2_model SET model_detail = '{user_model_detail}' WHERE id = 22;
SELECT '用户维度模型已更新' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
