# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 修复模型的 domain_id
fix_sql = """
SET search_path TO heating_analytics;

-- 更新模型 domain_id 为新的主题域 id
-- 用户域: 5 → 11
UPDATE s2_model SET domain_id = 11 WHERE id IN (22, 23, 24, 25);

-- 计费域: 6 → 12
UPDATE s2_model SET domain_id = 12 WHERE id = 26;

-- 收费域: 7 → 13
UPDATE s2_model SET domain_id = 13 WHERE id = 27;

-- 运营域: 8 → 14
UPDATE s2_model SET domain_id = 14 WHERE id IN (28, 29);

SELECT id, biz_name, domain_id FROM s2_model WHERE id >= 22 ORDER BY id;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=fix_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
