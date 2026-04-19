# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 获取模型的 dimensions 配置
sql = """
SET search_path TO heating_analytics;
SELECT id, biz_name, model_detail FROM s2_model WHERE id >= 22 AND id <= 29 ORDER BY id;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== 模型维度配置 ===\n")
lines = result.stdout.strip().split('\n')
for line in lines:
    if '|' in line:
        parts = line.split('|')
        if len(parts) >= 3:
            id_val = parts[0]
            biz_name = parts[1]
            model_detail = parts[2]
            print(f"模型 {id_val} ({biz_name}):")
            try:
                detail = json.loads(model_detail)
                dimensions = detail.get('dimensions', [])
                print(f"  维度数量: {len(dimensions)}")
                for dim in dimensions:
                    print(f"    - {dim.get('bizName', 'N/A')} ({dim.get('name', 'N/A')})")
            except:
                pass
            print()
