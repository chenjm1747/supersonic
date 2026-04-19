# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 修复收费结算事实模型 - 添加组织维度
charge_model = json.dumps({
    "queryType": "sql_query",
    "sqlQuery": """SELECT c.one as org_level1, c.two as org_level2, c.three as org_level3,
        s.cnq, s.fylb, s.ysje, s.sfje, s.qfje, s.wyje, s.zkje, s.hjje
        FROM sf_js_t s
        LEFT JOIN customer c ON s.customer_id = c.id
        WHERE s.zf = 0""",
    "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}],
    "dimensions": [
        {"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"},
        {"name": "费用类别", "type": "categorical", "expr": "fylb", "bizName": "fylb", "fieldName": "fylb"},
        {"name": "分公司", "type": "categorical", "expr": "org_level1", "bizName": "org_level1", "fieldName": "org_level1"},
        {"name": "热力站", "type": "categorical", "expr": "org_level2", "bizName": "org_level2", "fieldName": "org_level2"},
        {"name": "小区", "type": "categorical", "expr": "org_level3", "bizName": "org_level3", "fieldName": "org_level3"}
    ],
    "measures": [
        {"name": "应收金额", "agg": "SUM", "expr": "ysje", "bizName": "ysje", "isCreateMetric": 1, "fieldName": "ysje"},
        {"name": "实收金额", "agg": "SUM", "expr": "sfje", "bizName": "sfje", "isCreateMetric": 1, "fieldName": "sfje"},
        {"name": "欠费金额", "agg": "SUM", "expr": "qfje", "bizName": "qfje", "isCreateMetric": 1, "fieldName": "qfje"},
        {"name": "违约金额", "agg": "SUM", "expr": "wyje", "bizName": "wyje", "isCreateMetric": 1, "fieldName": "wyje"},
        {"name": "折扣金额", "agg": "SUM", "expr": "zkje", "bizName": "zkje", "isCreateMetric": 1, "fieldName": "zkje"},
        {"name": "核减金额", "agg": "SUM", "expr": "hjje", "bizName": "hjje", "isCreateMetric": 1, "fieldName": "hjje"}
    ],
    "fields": [
        {"fieldName": "cnq", "dataType": "Varchar"},
        {"fieldName": "fylb", "dataType": "Varchar"},
        {"fieldName": "org_level1", "dataType": "Varchar"},
        {"fieldName": "org_level2", "dataType": "Varchar"},
        {"fieldName": "org_level3", "dataType": "Varchar"},
        {"fieldName": "ysje", "dataType": "Decimal"},
        {"fieldName": "sfje", "dataType": "Decimal"},
        {"fieldName": "qfje", "dataType": "Decimal"},
        {"fieldName": "wyje", "dataType": "Decimal"},
        {"fieldName": "zkje", "dataType": "Decimal"},
        {"fieldName": "hjje", "dataType": "Decimal"}
    ],
    "sqlVariables": []
}, ensure_ascii=False)

update_sql = f"""
SET search_path TO heating_analytics;
UPDATE s2_model SET model_detail = '{charge_model}' WHERE id = 26;
SELECT '收费结算模型已更新' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
