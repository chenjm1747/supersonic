# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 质量域模型 - 使用 sf_js_t 和 pay_order 统计数据质量
quality_model = {
    "queryType": "sql_query",
    "sqlQuery": "SELECT cnq, COUNT(DISTINCT customer_id) as total_customers, SUM(CASE WHEN sfje > 0 THEN 1 ELSE 0 END) as paid_customers, SUM(CASE WHEN qfje > 0 THEN 1 ELSE 0 END) as arrears_customers, SUM(qfje) as total_arrears FROM sf_js_t WHERE zf = 0 GROUP BY cnq",
    "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}],
    "dimensions": [
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"}
    ],
    "measures": [
        {"name": "总用户数", "agg": "SUM", "expr": "total_customers", "bizName": "TOTAL_CUSTOMERS", "isCreateMetric": 1, "fieldName": "total_customers"},
        {"name": "已缴费用户数", "agg": "SUM", "expr": "paid_customers", "bizName": "PAID_CUSTOMERS", "isCreateMetric": 1, "fieldName": "paid_customers"},
        {"name": "欠费用户数", "agg": "SUM", "expr": "arrears_customers", "bizName": "ARREARS_CUSTOMERS", "isCreateMetric": 1, "fieldName": "arrears_customers"},
        {"name": "欠费总额", "agg": "SUM", "expr": "total_arrears", "bizName": "TOTAL_ARREARS", "isCreateMetric": 1, "fieldName": "total_arrears"}
    ],
    "fields": [
        {"fieldName": "cnq", "dataType": "Varchar"},
        {"fieldName": "total_customers", "dataType": "Bigint"},
        {"fieldName": "paid_customers", "dataType": "Bigint"},
        {"fieldName": "arrears_customers", "dataType": "Bigint"},
        {"fieldName": "total_arrears", "dataType": "Decimal"}
    ],
    "sqlVariables": []
}

# 质量域模型2 - 作废记录统计
quality_model2 = {
    "queryType": "sql_query",
    "sqlQuery": "SELECT DATE_FORMAT(created_time, '%Y-%m') as stat_month, COUNT(*) as cancel_count FROM pay_order WHERE zf = 1 GROUP BY DATE_FORMAT(created_time, '%Y-%m')",
    "identifiers": [{"name": "统计月份", "type": "primary", "bizName": "stat_month", "isCreateDimension": 1, "fieldName": "stat_month"}],
    "dimensions": [
        {"name": "统计月份", "type": "categorical", "expr": "stat_month", "bizName": "stat_month", "fieldName": "stat_month"}
    ],
    "measures": [
        {"name": "作废笔数", "agg": "SUM", "expr": "cancel_count", "bizName": "CANCEL_COUNT", "isCreateMetric": 1, "fieldName": "cancel_count"}
    ],
    "fields": [
        {"fieldName": "stat_month", "dataType": "Varchar"},
        {"fieldName": "cancel_count", "dataType": "Bigint"}
    ],
    "sqlVariables": []
}

# 添加模型
add_models_sql = """
SET search_path TO heating_analytics;

-- 质量域模型1 (id=30)
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('数据质量监控模型', 'sf_quality_monitor', 15, '质量监控', 1, '数据质量监控指标', 2, '{"queryType":"sql_query","sqlQuery":"SELECT cnq, COUNT(DISTINCT customer_id) as total_customers, SUM(CASE WHEN sfje > 0 THEN 1 ELSE 0 END) as paid_customers, SUM(CASE WHEN qfje > 0 THEN 1 ELSE 0 END) as arrears_customers, SUM(qfje) as total_arrears FROM sf_js_t WHERE zf = 0 GROUP BY cnq","identifiers":[{"name":"采暖期","type":"primary","bizName":"cnq","isCreateDimension":1,"fieldName":"cnq"}],"dimensions":[{"name":"采暖期","type":"categorical","expr":"cnq","bizName":"cnq","fieldName":"cnq"}],"measures":[{"name":"总用户数","agg":"SUM","expr":"total_customers","bizName":"TOTAL_CUSTOMERS","isCreateMetric":1,"fieldName":"total_customers"},{"name":"已缴费用户数","agg":"SUM","expr":"paid_customers","bizName":"PAID_CUSTOMERS","isCreateMetric":1,"fieldName":"paid_customers"},{"name":"欠费用户数","agg":"SUM","expr":"arrears_customers","bizName":"ARREARS_CUSTOMERS","isCreateMetric":1,"fieldName":"arrears_customers"},{"name":"欠费总额","agg":"SUM","expr":"total_arrears","bizName":"TOTAL_ARREARS","isCreateMetric":1,"fieldName":"total_arrears"}],"fields":[{"fieldName":"cnq","dataType":"Varchar"},{"fieldName":"total_customers","dataType":"Bigint"},{"fieldName":"paid_customers","dataType":"Bigint"},{"fieldName":"arrears_customers","dataType":"Bigint"},{"fieldName":"total_arrears","dataType":"Decimal"}],"sqlVariables":[]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');

-- 质量域模型2 (id=31)
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type)
VALUES ('作废记录统计模型', 'sf_cancel_stat', 15, '作废统计', 1, '收费作废记录统计', 2, '{"queryType":"sql_query","sqlQuery":"SELECT DATE_FORMAT(created_time, ''%Y-%m'') as stat_month, COUNT(*) as cancel_count FROM pay_order WHERE zf = 1 GROUP BY DATE_FORMAT(created_time, ''%Y-%m'')","identifiers":[{"name":"统计月份","type":"primary","bizName":"stat_month","isCreateDimension":1,"fieldName":"stat_month"}],"dimensions":[{"name":"统计月份","type":"categorical","expr":"stat_month","bizName":"stat_month","fieldName":"stat_month"}],"measures":[{"name":"作废笔数","agg":"SUM","expr":"cancel_count","bizName":"CANCEL_COUNT","isCreateMetric":1,"fieldName":"cancel_count"}],"fields":[{"fieldName":"stat_month","dataType":"Varchar"},{"fieldName":"cancel_count","dataType":"Bigint"}],"sqlVariables":[]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'SQL');
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=add_models_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)

# 更新数据集关联模型
update_data_set_sql = """
SET search_path TO heating_analytics;
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 30, "includesAll": true}, {"id": 31, "includesAll": true}]}' WHERE id = 21;
SELECT '数据集已更新' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_data_set_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
