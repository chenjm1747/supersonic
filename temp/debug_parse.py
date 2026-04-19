import re
from pathlib import Path

sql_file = r'E:\trae\supersonic\sql\charge_zbhx_20260303.sql'
sql_content = Path(sql_file).read_text(encoding='utf-8')

# 测试匹配 CREATE TABLE
matches = re.findall(r'CREATE TABLE `(\w+)`', sql_content)
print(f'找到 {len(matches)} 个 CREATE TABLE')
print('前5个:', matches[:5])

# 测试第一个 CREATE TABLE 块
block_match = re.search(r'CREATE TABLE `(\w+)`  \((.+?)\);', sql_content, re.DOTALL)
if block_match:
    print(f'\n第一个表: {block_match.group(1)}')
    content = block_match.group(2)
    print(f'内容长度: {len(content)}')
    print(f'内容前500字符:')
    print(content[:500])
