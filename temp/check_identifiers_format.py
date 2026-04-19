# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 查看示例数据中模型的 identifiers 格式
sql = """
SET search_path TO heating_analytics;
SELECT model_detail FROM s2_model WHERE id = 1;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== 示例模型 identifiers 格式 ===\n")
try:
    detail = json.loads(result.stdout.strip())
    print("identifiers:", json.dumps(detail.get('identifiers', []), indent=2, ensure_ascii=False))
except Exception as e:
    print(f"解析错误: {e}")
    print("原始数据:", result.stdout)
