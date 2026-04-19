# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 读取SQL文件
with open(r'e:\trae\supersonic\temp\supersonic_semantic_model_insert.sql', 'r', encoding='utf-8') as f:
    sql_content = f.read()

# 通过stdin传递SQL内容
result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=sql_content,
    capture_output=True,
    text=True,
    encoding='utf-8'
)

print(result.stdout)
print(result.stderr)
