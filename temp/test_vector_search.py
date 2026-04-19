import requests
import psycopg2

OLLAMA_URL = "http://192.168.1.10:11435"
OLLAMA_MODEL = "bge-m3:latest"

DB_CONFIG = {
    "host": "192.168.1.10",
    "port": 5432,
    "database": "postgres",
    "user": "postgres",
    "password": "Huilian1234",
    "options": "-c search_path=heating_analytics,public"
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
        raise Exception(f"Failed to get embedding: {response.status_code}")


def search_similar(query, top_k=5):
    embedding = get_embedding(query)

    conn = psycopg2.connect(**DB_CONFIG)
    cur = conn.cursor()

    sql = """
        SELECT table_name, column_name, column_comment, knowledge_text,
               1 - (embedding <=> %s::vector) as similarity
        FROM s2_schema_knowledge
        ORDER BY embedding <=> %s::vector
        LIMIT %s
    """

    cur.execute(sql, (embedding, embedding, top_k))
    results = cur.fetchall()

    cur.close()
    conn.close()

    return results


def main():
    print("Testing Vector Search...\n")

    test_queries = [
        "用户手机号",
        "欠费金额",
        "采暖期收费",
        "缴费订单",
        "用户地址"
    ]

    for query in test_queries:
        print(f"Query: {query}")
        print("-" * 60)

        results = search_similar(query, top_k=3)

        for i, (table_name, column_name, column_comment, knowledge_text, similarity) in enumerate(results, 1):
            print(f"{i}. [{table_name}.{column_name}] (相似度: {similarity:.4f})")
            print(f"   注释: {column_comment}")
            print()

        print()


if __name__ == "__main__":
    main()
