import re
import json
import requests
import psycopg2
from psycopg2.extras import execute_values

OLLAMA_URL = "http://192.168.1.10:11435"
OLLAMA_MODEL = "bge-m3:latest"
DIMENSION = 1024

DB_CONFIG = {
    "host": "192.168.1.10",
    "port": 5432,
    "database": "postgres",
    "user": "postgres",
    "password": "Huilian1234",
    "options": "-c search_path=heating_analytics,public"
}

TABLE_DEFINITIONS = {
    "customer": {
        "table_comment": "用户信息表",
        "columns": [
            {"name": "id", "type": "bigint", "comment": "用户主键", "is_pk": True},
            {"name": "code", "type": "varchar(20)", "comment": "用户编码", "is_uk": True},
            {"name": "yhkh", "type": "varchar(20)", "comment": "用户卡号"},
            {"name": "name", "type": "varchar(40)", "comment": "用户名称"},
            {"name": "id_number", "type": "varchar(80)", "comment": "身份证号"},
            {"name": "tel_no", "type": "varchar(50)", "comment": "座机号"},
            {"name": "mob_no", "type": "varchar(200)", "comment": "手机号"},
            {"name": "ry", "type": "varchar(20)", "comment": "热源"},
            {"name": "jz", "type": "varchar(20)", "comment": "机组"},
            {"name": "one", "type": "varchar(20)", "comment": "一级-地区等级名称"},
            {"name": "two", "type": "varchar(20)", "comment": "二级-地区等级名称"},
            {"name": "three", "type": "varchar(30)", "comment": "三级-地区等级名称"},
            {"name": "address_prefix", "type": "varchar(35)", "comment": "地址前缀"},
            {"name": "unit", "type": "varchar(15)", "comment": "单元"},
            {"name": "floor", "type": "varchar(10)", "comment": "楼层"},
            {"name": "room", "type": "varchar(10)", "comment": "房间"},
            {"name": "mp", "type": "varchar(50)", "comment": "门牌号"},
            {"name": "address", "type": "varchar(100)", "comment": "地址"},
            {"name": "yhlx", "type": "varchar(10)", "comment": "用户类型：居民/单位"},
            {"name": "rwrq", "type": "date", "comment": "入网日期"},
            {"name": "rwht_bh", "type": "varchar(30)", "comment": "入网合同编号"},
            {"name": "kzfs", "type": "varchar(10)", "comment": "控制方式：分户/未分户"},
            {"name": "created_time", "type": "datetime", "comment": "创建时间"},
            {"name": "updated_time", "type": "datetime", "comment": "更新时间"},
            {"name": "bz", "type": "varchar(150)", "comment": "备注"},
            {"name": "zf", "type": "tinyint(1)", "comment": "是否作废：0-正常 1-作废"},
            {"name": "kz_hmd", "type": "tinyint(1)", "comment": "用户控制-是否黑名单：0-否 1-是"},
            {"name": "kz_hmd_reason", "type": "varchar(128)", "comment": "用户控制-是否黑名单-原因"},
            {"name": "kz_sf", "type": "tinyint(1)", "comment": "用户控制-是否允许收费：0-否 1-是"},
            {"name": "kz_sf_reason", "type": "varchar(50)", "comment": "用户控制-是否允许收费-原因"},
            {"name": "kz_yhsf", "type": "tinyint(1)", "comment": "用户控制-是否允许银行收费：0-否 1-是"},
            {"name": "kz_jcsh", "type": "tinyint(1)", "comment": "用户控制-稽查锁户：0-否 1-是"},
            {"name": "kz_jcsh_reason", "type": "varchar(128)", "comment": "用户控制-稽查锁户-原因"},
            {"name": "xzcnq", "type": "varchar(10)", "comment": "新增采暖期"},
            {"name": "rlz_id", "type": "bigint", "comment": "热力站主键"},
            {"name": "zdfq_id", "type": "bigint", "comment": "站点分区主键"},
            {"name": "zdfq_name", "type": "varchar(30)", "comment": "站点分区名称"},
        ]
    },
    "sf_js_t": {
        "table_comment": "收费结算表",
        "columns": [
            {"name": "id", "type": "bigint", "comment": "主键", "is_pk": True},
            {"name": "customer_id", "type": "bigint", "comment": "用户主键", "fk": "customer.id"},
            {"name": "cnq", "type": "varchar(20)", "comment": "采暖期"},
            {"name": "zdmj", "type": "decimal(10,3)", "comment": "占地面积"},
            {"name": "cgmj", "type": "decimal(10,3)", "comment": "超高面积"},
            {"name": "sfmj", "type": "decimal(10,3)", "comment": "收费面积"},
            {"name": "cwmj", "type": "decimal(10,3)", "comment": "拆网面积"},
            {"name": "tgmj", "type": "decimal(10,3)", "comment": "停供面积"},
            {"name": "ysje", "type": "decimal(10,2)", "comment": "应收金额"},
            {"name": "sfje", "type": "decimal(10,2)", "comment": "收费金额"},
            {"name": "qfje", "type": "decimal(10,2)", "comment": "欠费金额"},
            {"name": "wyje", "type": "decimal(10,2)", "comment": "违约金额"},
            {"name": "zkje", "type": "decimal(10,2)", "comment": "折扣金额"},
            {"name": "hjje", "type": "decimal(10,2)", "comment": "核减金额"},
            {"name": "zf", "type": "tinyint(1)", "comment": "是否作废：0-正常 1-作废"},
        ]
    },
    "pay_order": {
        "table_comment": "缴费订单表",
        "columns": [
            {"name": "id", "type": "bigint", "comment": "主键", "is_pk": True},
            {"name": "customer_id", "type": "bigint", "comment": "用户主键", "fk": "customer.id"},
            {"name": "mjjs_id", "type": "bigint", "comment": "面积结算主键"},
            {"name": "cnq", "type": "varchar(10)", "comment": "采暖期"},
            {"name": "fylb", "type": "varchar(10)", "comment": "费用类别"},
            {"name": "sfje", "type": "decimal(10,2)", "comment": "收费金额"},
            {"name": "wyje", "type": "decimal(10,2)", "comment": "违约金额"},
            {"name": "zkje", "type": "decimal(10,2)", "comment": "折扣金额"},
            {"name": "bill_no", "type": "varchar(100)", "comment": "商户订单号-业务订单号"},
            {"name": "bank_order", "type": "varchar(100)", "comment": "银商订单号-平台订单号"},
            {"name": "bill_date", "type": "datetime", "comment": "订单时间"},
            {"name": "pay_date", "type": "datetime", "comment": "支付时间"},
            {"name": "created_time", "type": "datetime", "comment": "创建时间"},
            {"name": "updated_time", "type": "datetime", "comment": "更新时间"},
            {"name": "trace_no", "type": "varchar(100)", "comment": "凭证号"},
            {"name": "merchant_no", "type": "varchar(100)", "comment": "终端号"},
            {"name": "terminal_no", "type": "varchar(100)", "comment": "批次号"},
            {"name": "reference_no", "type": "varchar(100)", "comment": "交易参考号"},
            {"name": "source", "type": "varchar(30)", "comment": "来源-渠道唯一标识"},
            {"name": "sfzt", "type": "tinyint(1)", "comment": "收费状态：0-未收费 1-收费"},
            {"name": "yywd", "type": "varchar(50)", "comment": "营业网点"},
            {"name": "czy", "type": "varchar(50)", "comment": "操作员"},
            {"name": "zf", "type": "tinyint(1)", "comment": "是否作废：0-正常 1-作废"},
            {"name": "term_sn", "type": "varchar(31)", "comment": "终端设备唯一机器码"},
        ]
    },
    "contract_info": {
        "table_comment": "供暖合同表",
        "columns": [
            {"name": "id", "type": "bigint", "comment": "主键", "is_pk": True},
            {"name": "type", "type": "tinyint", "comment": "类型：1-供暖合同"},
            {"name": "customer_id", "type": "bigint", "comment": "用户id", "fk": "customer.id"},
            {"name": "cnq", "type": "char(10)", "comment": "采暖期"},
            {"name": "operation_no", "type": "char(20)", "comment": "编号供暖季开始年度+户号"},
            {"name": "status", "type": "tinyint", "comment": "状态：1-生效中 2-已作废 3-已过期"},
            {"name": "sign_name", "type": "varchar(30)", "comment": "签字人"},
            {"name": "zf", "type": "tinyint", "comment": "是否作废：0-不作废 1-作废"},
            {"name": "created_time", "type": "datetime", "comment": "创建时间"},
            {"name": "updated_time", "type": "datetime", "comment": "更新时间"},
            {"name": "file_path", "type": "varchar(200)", "comment": "文件路径"},
            {"name": "file_type", "type": "tinyint", "comment": "文件类型：1-pdf 2-图片"},
        ]
    },
    "area": {
        "table_comment": "用户面积表",
        "columns": [
            {"name": "id", "type": "bigint", "comment": "主键", "is_pk": True},
            {"name": "customer_id", "type": "bigint", "comment": "用户主键", "fk": "customer.id"},
            {"name": "name", "type": "varchar(60)", "comment": "面积名称"},
            {"name": "sfmj", "type": "decimal(10,3)", "comment": "收费面积"},
            {"name": "zdmj", "type": "decimal(10,3)", "comment": "建筑面积"},
            {"name": "symj", "type": "decimal(10,3)", "comment": "使用面积"},
            {"name": "cgmj", "type": "decimal(10,3)", "comment": "超高面积"},
            {"name": "cg", "type": "decimal(10,3)", "comment": "层高"},
            {"name": "mjlb", "type": "varchar(40)", "comment": "面积类别"},
            {"name": "djlb", "type": "varchar(40)", "comment": "单价类别"},
            {"name": "jsfs", "type": "varchar(10)", "comment": "结算方式"},
            {"name": "gnsc", "type": "decimal(10,3)", "comment": "供暖时长（天，月，季）"},
            {"name": "ybbm", "type": "varchar(20)", "comment": "仪表编码"},
            {"name": "jldjlb", "type": "varchar(10)", "comment": "计量单价类别"},
            {"name": "created_time", "type": "datetime", "comment": "创建时间"},
            {"name": "updated_time", "type": "datetime", "comment": "更新时间"},
            {"name": "bz", "type": "varchar(125)", "comment": "备注"},
            {"name": "zf", "type": "tinyint(1)", "comment": "是否作废：0-正常 1-作废"},
            {"name": "czbh", "type": "bigint", "comment": "操作编号"},
            {"name": "generate", "type": "tinyint(1)", "comment": "是否生成账单：0-不生成 1-生成"},
        ]
    },
}


def get_embedding(text):
    url = f"{OLLAMA_URL}/api/embeddings"
    payload = {
        "model": OLLAMA_MODEL,
        "prompt": text
    }
    response = requests.post(url, json=payload, timeout=60)
    if response.status_code == 200:
        return response.json().get("embedding")
    else:
        raise Exception(f"Failed to get embedding: {response.status_code} - {response.text}")


def generate_knowledge_text(table_name, table_comment, column):
    column_name = column["name"]
    column_comment = column["comment"]
    column_type = column["type"]

    tags = []
    if column.get("is_pk"):
        tags.append("主键")
    if column.get("is_uk"):
        tags.append("唯一索引")
    if column.get("fk"):
        tags.append(f"外键引用{column['fk']}")

    tags_str = f" [{','.join(tags)}]" if tags else ""

    return f"表名: {table_name}\n表注释: {table_comment}\n列名: {column_name}\n列注释: {column_comment}\n列类型: {column_type}{tags_str}"


def insert_knowledge(knowledge_list):
    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    sql = """
        INSERT INTO s2_schema_knowledge
        (table_name, table_comment, column_name, column_comment, column_type,
         is_primary_key, is_foreign_key, fk_reference, knowledge_text, embedding)
        VALUES %s
    """

    values = [
        (
            k["table_name"],
            k["table_comment"],
            k["column_name"],
            k["column_comment"],
            k["column_type"],
            k["is_pk"],
            k["is_fk"],
            k["fk_reference"],
            k["knowledge_text"],
            k["embedding"]
        )
        for k in knowledge_list
    ]

    execute_values(cur, sql, values)
    conn.commit()
    cur.close()
    conn.close()
    print(f"Inserted {len(values)} records into knowledge base")


def main():
    print("Starting knowledge base build...")

    all_knowledge = []

    for table_name, table_def in TABLE_DEFINITIONS.items():
        table_comment = table_def["table_comment"]
        print(f"Processing table: {table_name}")

        for column in table_def["columns"]:
            knowledge_text = generate_knowledge_text(
                table_name, table_comment, column
            )

            print(f"  Getting embedding for column: {column['name']}")
            embedding = get_embedding(knowledge_text)

            all_knowledge.append({
                "table_name": table_name,
                "table_comment": table_comment,
                "column_name": column["name"],
                "column_comment": column["comment"],
                "column_type": column["type"],
                "is_pk": column.get("is_pk", False),
                "is_fk": "fk" in column,
                "fk_reference": column.get("fk"),
                "knowledge_text": knowledge_text,
                "embedding": embedding
            })

    print(f"\nTotal records: {len(all_knowledge)}")
    print("Inserting into database...")

    insert_knowledge(all_knowledge)

    print("Knowledge base build completed!")


if __name__ == "__main__":
    main()
