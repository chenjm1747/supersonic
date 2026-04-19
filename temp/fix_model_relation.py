# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清理旧的供热收费模型（id 9-13）
cleanup_sql = """
SET search_path TO heating_analytics;
DELETE FROM s2_model WHERE id BETWEEN 9 AND 21;
"""

# 更新数据集SQL - 使用正确的 model id (22-29)
update_data_set_sql = """
SET search_path TO heating_analytics;

-- 供热收费用户域 (domain_id=11) 的数据集
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 22, "includesAll": true}]}' WHERE id = 12;
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 23, "includesAll": true}]}' WHERE id = 13;
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 24, "includesAll": true}]}' WHERE id = 14;
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 25, "includesAll": true}]}' WHERE id = 15;

-- 供热收费计费域 (domain_id=12) 的数据集
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 26, "includesAll": true}]}' WHERE id = 17;

-- 供热收费收费域 (domain_id=13) 的数据集
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 27, "includesAll": true}]}' WHERE id = 18;

-- 供热收费运营域 (domain_id=14) 的数据集
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 28, "includesAll": true}]}' WHERE id = 19;
UPDATE s2_data_set SET data_set_detail = '{"dataSetModelConfigs":[{"id": 29, "includesAll": true}]}' WHERE id = 20;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=cleanup_sql, capture_output=True, text=True, encoding='utf-8')
print("清理:", result.stdout)

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=update_data_set_sql, capture_output=True, text=True, encoding='utf-8')
print("更新数据集:", result.stdout)

print("\n完成!")
