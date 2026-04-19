-- 清理供热收费相关数据（domain_id >= 4）
SET search_path TO heating_analytics;

-- 删除模型关联
DELETE FROM s2_model_rela WHERE domain_id >= 4;

-- 删除业务术语
DELETE FROM s2_term WHERE domain_id >= 4;

-- 删除指标（与新数据集相关的）
DELETE FROM s2_metric WHERE model_id >= 9;

-- 删除维度（与新数据集相关的）
DELETE FROM s2_dimension WHERE model_id >= 5;

-- 删除数据集
DELETE FROM s2_model WHERE domain_id >= 4;

-- 删除主题域（供热收费相关的）
DELETE FROM s2_domain WHERE id >= 4;

-- 重置序列
SELECT setval('s2_domain_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_domain));
SELECT setval('s2_model_id_seq', (SELECT COALESCE(MAX(id), 1) FROM s2_model));

SELECT '清理完成' AS status;
