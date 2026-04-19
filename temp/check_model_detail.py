# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 获取前3个 model 的信息
sql = """
SET search_path TO heating_analytics;
SELECT id, biz_name, name, model_detail FROM s2_model ORDER BY id LIMIT 3;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== s2_model 表结构和关联 ===\n")

lines = result.stdout.strip().split('\n')
for line in lines:
    if '|' in line:
        parts = line.split('|')
        if len(parts) >= 4:
            id_val = parts[0]
            biz_name = parts[1]
            name = parts[2]
            model_detail = parts[3] if len(parts) > 3 else ''
            print(f"ID: {id_val}, 名称: {name}")
            print(f"model_detail: {model_detail}")
            try:
                detail = json.loads(model_detail)
                print(f"解析后: {json.dumps(detail, indent=2, ensure_ascii=False)}")
            except:
                pass
            print("-" * 50)
