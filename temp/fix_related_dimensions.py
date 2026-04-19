# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清空 related_dimensions，因为目前无法确定正确的维度 ID
fix_sql = """
SET search_path TO heating_analytics;

-- 将 related_dimensions 设为空数组
UPDATE s2_term SET related_dimensions = '[]' WHERE domain_id >= 10;

SELECT 'related_dimensions 已清空' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=fix_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
