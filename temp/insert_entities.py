import psycopg2
import re
from pathlib import Path

DB_URL = "postgresql://postgres:Huilian1234@192.168.1.10:5432/postgres"
SQL_FILE = r'E:\trae\supersonic\sql\charge_zbhx_20260303.sql'

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

def truncate(s, length=120):
    if len(s) > length:
        return s[:length-3] + '...'
    return s

def create_tables(cur):
    cur.execute("""
CREATE TABLE IF NOT EXISTS s2_wiki_entity (
    id BIGSERIAL PRIMARY KEY,
    entity_id VARCHAR(128) NOT NULL UNIQUE,
    entity_type VARCHAR(32) NOT NULL,
    name VARCHAR(64) NOT NULL,
    display_name VARCHAR(128),
    description TEXT,
    properties JSONB,
    summary TEXT,
    tags TEXT[],
    version VARCHAR(32),
    parent_entity_id VARCHAR(128),
    topic_id VARCHAR(64),
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
""")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_entity_type ON s2_wiki_entity(entity_type)")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_parent ON s2_wiki_entity(parent_entity_id)")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_topic ON s2_wiki_entity(topic_id)")
    cur.execute("CREATE INDEX IF NOT EXISTS idx_entity_name ON s2_wiki_entity(name)")
    print("Tables created")

def main():
    print(f"Reading SQL file: {SQL_FILE}")

    try:
        sql_content = Path(SQL_FILE).read_text(encoding='gbk')
    except:
        sql_content = Path(SQL_FILE).read_text(encoding='utf-8', errors='replace')

    blocks = extract_create_table_blocks(sql_content)
    print(f'Extracted {len(blocks)} CREATE TABLE blocks')

    conn = psycopg2.connect(DB_URL)
    cur = conn.cursor()

    cur.execute("SET search_path TO heating_analytics,public")
    create_tables(cur)
    conn.commit()

    table_count = 0
    column_count = 0

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
        pk_value = f'"{pk_cols[0]}"' if pk_cols else None

        table_sql = """
INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (%s, %s, %s, %s, %s, jsonb_build_object('database', %s, 'columns', %s::text[], 'primaryKey', %s), %s)
"""
        table_params = (
            f'table:{table_name.lower()}',
            'TABLE',
            table_name.lower(),
            truncate(table_name, 128),
            f'{table_name} table',
            'charge_zbhx_20260303',
            col_array,
            pk_value,
            'ACTIVE'
        )
        cur.execute(table_sql, table_params)
        table_count += 1

        for col in columns:
            col_sql = """
INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (%s, %s, %s, %s, %s, jsonb_build_object('dataType', %s, 'nullable', %s, 'isPrimaryKey', %s), %s, %s)
"""
            col_params = (
                f'column:{table_name.lower()}.{col["name"].lower()}',
                'COLUMN',
                col['name'].lower(),
                truncate(col['comment'], 128),
                truncate(f'{col["comment"]} column', 256),
                col['type'],
                col['nullable'],
                col['is_pk'],
                f'table:{table_name.lower()}',
                'ACTIVE'
            )
            cur.execute(col_sql, col_params)
            column_count += 1

        if table_count % 20 == 0:
            conn.commit()
            print(f'Processed {table_count} tables, {column_count} columns...')

    conn.commit()
    print(f'\nDone!')
    print(f'  - Table entities: {table_count}')
    print(f'  - Column entities: {column_count}')
    print(f'  - Total: {table_count + column_count} entities')

    cur.close()
    conn.close()

if __name__ == '__main__':
    main()
