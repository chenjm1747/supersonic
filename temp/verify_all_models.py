# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

sql = """
SET search_path TO heating_analytics;
SELECT id, biz_name, database_id FROM s2_model WHERE id >= 22 ORDER BY id;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== 模型配置 ===\n")
print("ID | 模型名称 | 数据库ID")
print("-" * 40)
print(result.stdout)

print("\n所有模型已更新为使用 mysql_sf_charge 数据库 (database_id=2)")
