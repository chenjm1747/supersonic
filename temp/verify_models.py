# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

sql = """
SET search_path TO heating_analytics;
SELECT id, biz_name, database_id, model_detail FROM s2_model WHERE id IN (22, 24) ORDER BY id;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== 模型配置 ===\n")
lines = result.stdout.strip().split('\n')
for line in lines:
    parts = line.split('|')
    if len(parts) >= 4:
        id_val = parts[0]
        biz_name = parts[1]
        database_id = parts[2]
        model_detail = parts[3]
        print(f"模型 ID: {id_val}, 名称: {biz_name}, 数据库ID: {database_id}")
        try:
            detail = json.loads(model_detail)
            print(f"  SQL查询: {detail.get('sqlQuery', 'N/A')}")
        except:
            pass
        print()
