# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 插入缺失的数据集（使用正确的 domain_id）
data_set_sql = """
SET search_path TO heating_analytics;
INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (10, '供热收费系统', 'heating_charge_ds', '供热收费系统', 1, '系统', '{"dataSetModelConfigs":[]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (12, '收费结算数据集', 'sf_rpt_charge_ds', '收费结算核心数据集', 1, '收费结算', '{"dataSetModelConfigs":[{"id": 13, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (13, '收费明细数据集', 'sf_rpt_payment_ds', '收费明细数据集', 1, '收费明细', '{"dataSetModelConfigs":[{"id": 14, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (14, '停供复供数据集', 'sf_fact_stop_restart_ds', '停供复供业务数据集', 1, '停供复供', '{"dataSetModelConfigs":[{"id": 15, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (14, '采暖期收费汇总数据集', 'sf_rpt_cnq_charge_ds', '采暖期收费汇总数据集', 1, '采暖期汇总', '{"dataSetModelConfigs":[{"id": 16, "includesAll": true}]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

INSERT INTO s2_data_set (domain_id, name, biz_name, description, status, alias, data_set_detail, created_at, created_by, updated_at, updated_by)
VALUES (15, '供热收费质量域', 'heating_quality_ds', '数据质量监控', 1, '质量', '{"dataSetModelConfigs":[]}', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=data_set_sql, capture_output=True, text=True, encoding='utf-8')
print("数据集导入:", result.stdout)
if result.stderr:
    print("错误:", result.stderr)
