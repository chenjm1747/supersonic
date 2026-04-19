# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 时间维度模型 - 使用 MySQL DATE_FORMAT 函数，修复 %Y 问题
sql_query = "SELECT DATE_FORMAT(created_time, '%%Y-%%m-%%d') as date_id, YEAR(created_time) as year_num, MONTH(created_time) as month_num, QUARTER(created_time) as quarter_num FROM sf_mj_t WHERE zf = 0 GROUP BY DATE_FORMAT(created_time, '%%Y-%%m-%%d'), YEAR(created_time), MONTH(created_time), QUARTER(created_time)"

time_model = {
    "queryType": "sql_query",
    "sqlQuery": sql_query,
    "identifiers": [{"name": "日期", "type": "primary", "bizName": "date_id", "isCreateDimension": 1, "fieldName": "date_id"}],
    "dimensions": [
        {"name": "日期", "type": "time", "expr": "date_id", "bizName": "date_id", "fieldName": "date_id"},
        {"name": "年份", "type": "categorical", "expr": "year_num", "bizName": "year", "fieldName": "year_num"},
        {"name": "月份", "type": "categorical", "expr": "month_num", "bizName": "month", "fieldName": "month_num"},
        {"name": "季度", "type": "categorical", "expr": "quarter_num", "bizName": "quarter", "fieldName": "quarter_num"}
    ],
    "measures": [],
    "fields": [
        {"fieldName": "date_id", "dataType": "Date"},
        {"fieldName": "year_num", "dataType": "Integer"},
        {"fieldName": "month_num", "dataType": "Integer"},
        {"fieldName": "quarter_num", "dataType": "Integer"}
    ],
    "sqlVariables": []
}

model_json = json.dumps(time_model, ensure_ascii=False)

update_sql = f"""
SET search_path TO heating_analytics;
UPDATE s2_model SET model_detail = '{model_json}' WHERE id = 25;
SELECT '时间维度模型已修复' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
