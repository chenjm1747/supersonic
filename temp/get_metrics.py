# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 获取所有指标
sql = """
SET search_path TO heating_analytics;
SELECT id, biz_name, name, model_id FROM s2_metric WHERE model_id >= 22 ORDER BY model_id, id;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== 指标列表 ===\n")
print("ID | biz_name | name | model_id")
print("-" * 50)
print(result.stdout)
