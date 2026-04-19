import re
from pathlib import Path

sql_file = r'E:\trae\supersonic\sql\charge_zbhx_20260303.sql'
sql_content = Path(sql_file).read_text(encoding='utf-8')

# 测试正则匹配
pattern = r'CREATE TABLE `(\w+)`  \((.+?)\);'
matches = re.findall(pattern, sql_content, re.DOTALL)
print(f'用空格正则找到 {len(matches)} 个')

pattern2 = r'CREATE TABLE `(\w+)`\s*\((.+?)\);'
matches2 = re.findall(pattern2, sql_content, re.DOTALL)
print(f'用\\s*正则找到 {len(matches2)} 个')

# 测试第一个匹配的完整内容
if matches2:
    table_name, content = matches2[0]
    print(f'\n第一个表: {table_name}')
    print(f'内容长度: {len(content)}')
    print(f'内容前300字符:')
    print(repr(content[:300]))
