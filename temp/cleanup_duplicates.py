# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清理重复数据 - 保留 id 较大的新数据，删除 id 较小的旧数据
cleanup_sql = """
SET search_path TO heating_analytics;

-- 清理 s2_domain 重复数据（保留 id >= 10 的新数据）
DELETE FROM s2_domain WHERE id >= 4 AND id < 10;

-- 清理所有相关数据
DELETE FROM s2_data_set WHERE domain_id >= 4;
DELETE FROM s2_model WHERE domain_id >= 4;
DELETE FROM s2_dimension WHERE model_id >= 9;
DELETE FROM s2_metric WHERE model_id >= 9;
DELETE FROM s2_model_rela WHERE domain_id >= 4;
DELETE FROM s2_term WHERE domain_id >= 4;

-- 重置序列
SELECT setval('s2_domain_id_seq', 3);
SELECT setval('s2_data_set_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_data_set));
SELECT setval('s2_model_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_model));
SELECT setval('s2_dimension_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_dimension));
SELECT setval('s2_metric_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_metric));
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=cleanup_sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)
print("清理结果:", result.stdout)
print("错误:", result.stderr if result.stderr else "无")
