# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

sql = """
SET search_path TO heating_analytics;
SELECT id, biz_name, name, model_detail FROM s2_model WHERE id = 22;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

lines = result.stdout.strip().split('\n')
for line in lines:
    parts = line.split('|')
    if len(parts) >= 4:
        id_val = parts[0]
        biz_name = parts[1]
        name = parts[2]
        model_detail = parts[3]
        print(f"=== 用户维度模型 (ID: {id_val}) ===")
        print(f"名称: {name}")
        print(f"model_detail: {model_detail}\n")
        try:
            detail = json.loads(model_detail)
            print("解析后的关键配置:")
            print(f"  sqlQuery: {detail.get('sqlQuery', 'N/A')}")
            print(f"  queryType: {detail.get('queryType', 'N/A')}")
            print(f"  数据库表: {detail.get('sqlQuery', '').split('FROM')[1].strip() if 'FROM' in detail.get('sqlQuery', '') else 'N/A'}")
        except Exception as e:
            print(f"解析错误: {e}")
