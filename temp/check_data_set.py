# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

sql = """
SET search_path TO heating_analytics;
SELECT id, name, data_set_detail FROM s2_data_set WHERE domain_id >= 4 ORDER BY id;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== s2_data_set 数据集配置 ===\n")

lines = result.stdout.strip().split('\n')
for line in lines:
    if '|' in line:
        parts = line.split('|')
        if len(parts) >= 3:
            id_val = parts[0]
            name = parts[1]
            detail = parts[2]
            print(f"数据集: {name} (ID: {id_val})")
            try:
                parsed = json.loads(detail)
                print(f"  data_set_detail: {json.dumps(parsed, indent=4, ensure_ascii=False)}")
            except:
                print(f"  data_set_detail: {detail}")
            print()
