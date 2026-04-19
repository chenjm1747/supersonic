# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 修复数据集的 domain_id
fix_sql = """
SET search_path TO heating_analytics;

-- 修复 domain_id:
-- 旧的 domain_id=5 是旧的用户域，应该改为 11 (新的供热收费用户域)
UPDATE s2_data_set SET domain_id = 11 WHERE id IN (12, 13, 14, 15);

-- 旧的数据集 id 16 domain_id=10 是对的，但需要关联模型
-- 检查当前状态
SELECT id, domain_id, name, data_set_detail FROM s2_data_set ORDER BY id;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=fix_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
