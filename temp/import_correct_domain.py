# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清理旧的供热收费主题域和数据
cleanup_sql = """
SET search_path TO heating_analytics;
DELETE FROM s2_model_rela WHERE domain_id >= 4;
DELETE FROM s2_term WHERE domain_id >= 4;
DELETE FROM s2_metric WHERE model_id >= 9;
DELETE FROM s2_dimension WHERE model_id >= 5;
DELETE FROM s2_model WHERE domain_id >= 4;
DELETE FROM s2_domain WHERE id >= 4;
SELECT setval('s2_domain_id_seq', 3);
SELECT setval('s2_model_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_model));
"""

# 主题域SQL（所有都是顶级域，parent_id=0）
domain_sql = """
SET search_path TO heating_analytics;
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费系统', 'heating_charge', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '供热收费核心业务域');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费用户域', 'heating_customer', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '热用户管理');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费计费域', 'heating_billing', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '费用计算与结算');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费收费域', 'heating_collection', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '实收费用管理');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费运营域', 'heating_operation', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '业务运营分析');
INSERT INTO s2_domain (name, biz_name, parent_id, status, created_at, created_by, updated_at, updated_by, entity) VALUES ('供热收费质量域', 'heating_quality', 0, 1, CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', '数据质量监控');
"""

# 数据模型SQL（使用新的domain_id）
model_sql = """
SET search_path TO heating_analytics;
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('用户维度模型', 'sf_dim_customer', 5, '用户信息', 1, '热用户基本信息维度', 1, '{"tables": [{"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('组织维度模型', 'sf_dim_org', 5, '组织架构', 1, '组织架构维度', 1, '{"tables": [{"table": "sf_dim_org", "alias": "o", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('面积维度模型', 'sf_dim_area', 5, '供热面积', 1, '供热面积维度', 1, '{"tables": [{"table": "sf_dim_area", "alias": "a", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('时间维度模型', 'sf_dim_time', 5, '时间维度', 1, '时间维度', 1, '{"tables": [{"table": "sf_dim_time", "alias": "t", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('收费结算事实模型', 'sf_rpt_charge', 6, '收费结算', 1, '收费结算核心事实表', 1, '{"tables": [{"table": "sf_rpt_charge", "alias": "m", "schema": "heating_analytics"}, {"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}], "joins": [{"left": "m.customer_id", "right": "c.customer_id", "type": "LEFT JOIN"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('收费明细事实模型', 'sf_rpt_payment', 7, '收费明细', 1, '收费明细事实表', 1, '{"tables": [{"table": "sf_rpt_payment", "alias": "p", "schema": "heating_analytics"}, {"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}], "joins": [{"left": "p.customer_id", "right": "c.customer_id", "type": "LEFT JOIN"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('停供复供事实模型', 'sf_fact_stop_restart', 8, '停供复供', 1, '停供复供业务事实表', 1, '{"tables": [{"table": "sf_fact_stop_restart", "alias": "sr", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
INSERT INTO s2_model (name, biz_name, domain_id, alias, status, description, database_id, model_detail, created_at, created_by, updated_at, updated_by, source_type) VALUES ('采暖期收费汇总模型', 'sf_rpt_cnq_charge', 8, '采暖期汇总', 1, '采暖期收费汇总表', 1, '{"tables": [{"table": "sf_rpt_cnq_charge", "alias": "sc", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin', 'TABLE');
"""

# 执行清理
result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=cleanup_sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)
print("清理结果:", result.stdout, result.stderr)

# 执行主题域导入
result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=domain_sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)
print("主题域导入:", result.stdout, result.stderr)

# 执行数据模型导入
result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=model_sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)
print("数据模型导入:", result.stdout, result.stderr)

print("\n导入完成!")
