import re
from pathlib import Path

sql_file = r'E:\trae\supersonic\sql\charge_zbhx_20260303.sql'
sql_content = Path(sql_file).read_text(encoding='utf-8')

# 搜索 CREATE TABLE 开头的行
lines = sql_content.split('\n')
create_lines = [l for l in lines if 'CREATE TABLE' in l]
print(f'找到 {len(create_lines)} 行包含 CREATE TABLE')
print('前5行:')
for l in create_lines[:5]:
    print(repr(l))

# 直接搜索字符串
idx = sql_content.find('CREATE TABLE')
if idx >= 0:
    print(f'\n第一个 CREATE TABLE 位置: {idx}')
    print(f'前后100字符:')
    print(repr(sql_content[idx:idx+100]))
