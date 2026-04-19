# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 修复模型使用 mysql_sf_charge 数据库
fix_sql = """
SET search_path TO heating_analytics;

-- 更新所有供热收费模型的 database_id 为 2 (mysql_sf_charge)
UPDATE s2_model SET database_id = 2 WHERE id >= 22;

SELECT id, biz_name, database_id FROM s2_model WHERE id >= 22 ORDER BY id;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=fix_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
