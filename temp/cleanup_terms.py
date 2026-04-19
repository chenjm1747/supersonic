# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清理与供热收费模型相关的 term
cleanup_sql = """
SET search_path TO heating_analytics;

-- 删除所有与供热收费相关的 term
DELETE FROM s2_term WHERE domain_id >= 10;

-- 删除所有 model_id >= 22 的 term
DELETE FROM s2_term WHERE model_id >= 22;

SELECT '清理完成' AS status, COUNT(*) as remaining_terms FROM s2_term;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=cleanup_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
