# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 清理旧的供热收费数据集
cleanup_sql = """
SET search_path TO heating_analytics;
DELETE FROM s2_data_set WHERE domain_id >= 4;
SELECT setval('s2_data_set_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_data_set));
"""

# 数据集SQL
data_set_sql = """
SET search_path TO heating_analytics;
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '用户维度数据集', 'sf_dim_customer_ds', '热用户基本信息数据集', 1, '用户信息', '{"tables": [{"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '组织维度数据集', 'sf_dim_org_ds', '组织架构维度数据集', 1, '组织架构', '{"tables": [{"table": "sf_dim_org", "alias": "o", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '面积维度数据集', 'sf_dim_area_ds', '供热面积维度数据集', 1, '供热面积', '{"tables": [{"table": "sf_dim_area", "alias": "a", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (5, '时间维度数据集', 'sf_dim_time_ds', '时间维度数据集', 1, '时间维度', '{"tables": [{"table": "sf_dim_time", "alias": "t", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (6, '收费结算数据集', 'sf_rpt_charge_ds', '收费结算核心数据集', 1, '收费结算', '{"tables": [{"table": "sf_rpt_charge", "alias": "m", "schema": "heating_analytics"}, {"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}], "joins": [{"left": "m.customer_id", "right": "c.customer_id", "type": "LEFT JOIN"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (7, '收费明细数据集', 'sf_rpt_payment_ds', '收费明细数据集', 1, '收费明细', '{"tables": [{"table": "sf_rpt_payment", "alias": "p", "schema": "heating_analytics"}, {"table": "sf_dim_customer", "alias": "c", "schema": "heating_analytics"}], "joins": [{"left": "p.customer_id", "right": "c.customer_id", "type": "LEFT JOIN"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (8, '停供复供数据集', 'sf_fact_stop_restart_ds', '停供复供业务数据集', 1, '停供复供', '{"tables": [{"table": "sf_fact_stop_restart", "alias": "sr", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (8, '采暖期收费汇总数据集', 'sf_rpt_cnq_charge_ds', '采暖期收费汇总数据集', 1, '采暖期汇总', '{"tables": [{"table": "sf_rpt_cnq_charge", "alias": "sc", "schema": "heating_analytics"}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
"""

# 执行清理
result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=cleanup_sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)
print("清理结果:", result.stdout)

# 执行数据集导入
result = subprocess.run(
    ['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str],
    input=data_set_sql,
    capture_output=True,
    text=True,
    encoding='utf-8'
)
print("数据集导入:", result.stdout)

print("\n导入完成!")
