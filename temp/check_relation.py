# -*- coding: utf-8 -*-
import subprocess
import json

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

sql = """
SET search_path TO heating_analytics;
SELECT ds.id, ds.name, ds.data_set_detail, m.id as model_id, m.biz_name as model_name
FROM s2_data_set ds
LEFT JOIN LATERAL (
    SELECT (jsonb_array_elements(ds.data_set_detail::jsonb->'dataSetModelConfigs') ->> 'id')::int as id
) config ON true
LEFT JOIN s2_model m ON m.id = config.id
WHERE ds.domain_id >= 10
ORDER BY ds.id;
"""

result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str, '-t', '-A'],
    input=sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print("=== 数据集与模型关联 ===\n")
print(result.stdout)
