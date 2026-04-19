# -*- coding: utf-8 -*-
import subprocess

conn_str = "postgresql://postgres:Huilian1234@192.168.1.7:54321/postgres"

# 创建供热收费系统的业务术语
terms_sql = """
SET search_path TO heating_analytics;

-- 1. 收费率（收缴率）
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '收费率', '实际收取的热费与应收热费的比率，反映收费效率', '["收缴率"]', '[52, 53]', '["cnq", "org_level1", "fylb"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 2. 欠费率
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '欠费率', '欠费金额占总应收金额的比例', '["欠费比例"]', '[54, 52]', '["cnq", "org_level1", "yhlx"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 3. 采暖期
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '采暖期', '供热季节周期，通常为当年11月至次年3月', '["供暖季", "供热季"]', '[]', '["cnq"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 4. 收费面积
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '收费面积', '收取供热费用的建筑面积', '["供热面积", "计费面积"]', '[50, 51]', '["cnq", "org_level1", "mjlb"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 5. 实收金额
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '实收金额', '实际收取的热费金额', '["已收热费", "收费金额"]', '[53, 59]', '["cnq", "org_level1", "fylb"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 6. 应收金额
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '应收金额', '应当收取的热费金额', '["应收费", "应收热费"]', '[52]', '["cnq", "org_level1", "fylb"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 7. 欠费金额
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '欠费金额', '用户未按时缴纳的热费金额', '["欠费", "未收热费"]', '[54]', '["cnq", "org_level1", "yhlx"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 8. 用户数
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '用户数', '热用户数量', '["客户数", "户数"]', '[49]', '["cnq", "org_level1", "yhlx"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 9. 分公司
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '分公司', '供热公司下属分公司或营业厅', '["营业厅", "分公司"]', '[]', '["org_level1"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 10. 热力站
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '热力站', '供热热力站或换热站', '["换热站"]', '[]', '["org_level2"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 11. 小区
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '小区', '供热服务的小区或楼宇', '["楼宇", "楼栋"]', '[]', '["org_level3"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 12. 用户类型
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '用户类型', '热用户的类型分类', '["客户类型"]', '[]', '["yhlx"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 13. 费用类别
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '费用类别', '热费和其他费用的分类', '["收费类型"]', '[]', '["fylb"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 14. 收费笔数
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '收费笔数', '收费记录的数量', '["收费次数", "交费笔数"]', '[58]', '["cnq", "org_level1", "sffs"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 15. 折扣金额
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '折扣金额', '减免或优惠的热费金额', '["减免", "优惠"]', '[56]', '["cnq", "org_level1"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

-- 16. 核减金额
INSERT INTO s2_term (domain_id, name, description, alias, related_metrics, related_dimensions, created_at, created_by, updated_at, updated_by)
VALUES (11, '核减金额', '核销或减免的热费金额', '["核销"]', '[57]', '["cnq", "org_level1"]', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, 'admin');

SELECT '业务术语创建完成' AS status;
"""

result = subprocess.run(['D:\\Program Files\\pgAdmin 4\\runtime\\psql.exe', conn_str], input=terms_sql, capture_output=True, text=True, encoding='utf-8')
print(result.stdout)
if result.stderr:
    print("错误:", result.stderr)
