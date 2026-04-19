import re
from pathlib import Path

SQL_FILE = r'E:\trae\supersonic\sql\charge_zbhx_20260303.sql'
OUTPUT_FILE = r'E:\trae\supersonic\temp\wiki_entity_inserts.sql'

def extract_create_table_blocks(sql_content):
    blocks = []
    lines = sql_content.split('\n')
    current_block = []

    for line in lines:
        if 'CREATE TABLE' in line:
            if current_block:
                blocks.append('\n'.join(current_block))
            current_block = [line]
        elif current_block:
            current_block.append(line)
            if line.strip() == ');':
                blocks.append('\n'.join(current_block))
                current_block = []

    if current_block:
        blocks.append('\n'.join(current_block))

    return blocks

def parse_columns(block_content):
    columns = []

    lines = block_content.split('\n')
    for line in lines:
        line = line.strip()

        if not line:
            continue
        if line.startswith('PRIMARY KEY') or line.startswith('INDEX') or line.startswith('CONSTRAINT') or line.startswith('ENGINE') or line.startswith('UNIQUE') or line.startswith('FOREIGN'):
            continue

        col_match = re.match(r'`(\w+)`\s+([\w(),]+)', line)
        if col_match:
            col_name = col_match.group(1)
            col_type = col_match.group(2).strip()

            not_null = 'NOT NULL' in line.upper()
            is_pk = 'PRIMARY KEY' in line.upper()

            comment_match = re.search(r"COMMENT\s+'([^']*)'", line)
            if comment_match:
                raw_comment = comment_match.group(1)
                try:
                    comment = raw_comment.encode('latin1').decode('gbk')
                except:
                    try:
                        comment = raw_comment.encode('latin1').decode('utf-8')
                    except:
                        comment = raw_comment
                comment = comment.replace("'", "''")
            else:
                comment = col_name

            columns.append({
                'name': col_name.lower(),
                'type': col_type.lower(),
                'nullable': not not_null,
                'is_pk': is_pk,
                'comment': comment
            })

    return columns

def generate_entity_inserts():
    try:
        sql_content = Path(SQL_FILE).read_text(encoding='gbk')
    except:
        sql_content = Path(SQL_FILE).read_text(encoding='utf-8', errors='replace')

    blocks = extract_create_table_blocks(sql_content)
    print(f'Extracted {len(blocks)} CREATE TABLE blocks')

    table_inserts = []
    column_inserts = []

    for block in blocks:
        table_match = re.search(r'CREATE TABLE `(\w+)`', block)
        if not table_match:
            continue

        table_name = table_match.group(1)

        if table_name.startswith('act_'):
            continue

        columns = parse_columns(block)
        if not columns:
            continue

        col_names = [c['name'] for c in columns]
        pk_cols = [c['name'] for c in columns if c['is_pk']]
        
        col_array = '{' + ','.join(f'"{n}"' for n in col_names) + '}'
        pk_value = f'"{pk_cols[0]}"' if pk_cols else 'NULL'

        table_sql = f"""INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:{table_name.lower()}',
    'TABLE',
    '{table_name.lower()}',
    '{table_name}',
    '{table_name} table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{col_array}'::text[],
        'primaryKey', {pk_value if pk_cols else 'NULL'}
    ),
    'ACTIVE'
);"""
        table_inserts.append(table_sql)

        for col in columns:
            col_sql = f"""INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:{table_name.lower()}.{col['name'].lower()}',
    'COLUMN',
    '{col['name'].lower()}',
    '{col['comment']}',
    '{col['comment']} column',
    jsonb_build_object(
        'dataType', '{col['type']}',
        'nullable', {str(col['nullable']).lower()},
        'isPrimaryKey', {str(col['is_pk']).lower()}
    ),
    'table:{table_name.lower()}',
    'ACTIVE'
);"""
            column_inserts.append(col_sql)

    return table_inserts, column_inserts

def main():
    print(f"Reading SQL file: {SQL_FILE}")

    print("Parsing DDL and generating entity INSERT statements...")
    table_inserts, column_inserts = generate_entity_inserts()

    output = f"""-- ============================================================
-- LLM-SQL-Wiki Entity Data
-- Generated from charge_zbhx_20260303.sql
-- Date: 2026-04-17
-- ============================================================

SET search_path TO heating_analytics,public;

"""
    output += '\n\n'.join(table_inserts)
    output += '\n\n' + '\n\n'.join(column_inserts)

    Path(OUTPUT_FILE).write_text(output, encoding='utf-8')
    print(f"Output file: {OUTPUT_FILE}")

    print(f"\nStatistics:")
    print(f"  - Table entities: {len(table_inserts)}")
    print(f"  - Column entities: {len(column_inserts)}")
    print(f"  - Total: {len(table_inserts) + len(column_inserts)} INSERT statements")

if __name__ == '__main__':
    main()
