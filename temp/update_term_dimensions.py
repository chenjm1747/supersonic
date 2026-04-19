# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 更新业务术语的维度关联
update_sql = """
SET search_path TO heating_analytics;

-- 更新收费率、实收金额、应收金额、欠费金额的业务术语维度
UPDATE s2_term SET related_dimensions = '["cnq", "fylb", "org_level1", "org_level2", "org_level3"]' WHERE id IN (13, 17, 18, 19);

-- 更新收费面积
UPDATE s2_term SET related_dimensions = '["cnq", "org_level1", "org_level2", "org_level3", "mjlb"]' WHERE id = 16;

-- 更新用户数
UPDATE s2_term SET related_dimensions = '["cnq", "org_level1", "org_level2", "org_level3", "yhlx"]' WHERE id = 20;

SELECT '业务术语维度已更新' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
