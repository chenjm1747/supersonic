-- 恢复数据集12的原关联（关联模型22）
SET search_path TO heating_analytics;

UPDATE s2_data_set
SET data_set_detail = '{"dataSetModelConfigs":[{"id": 22, "includesAll": true}]}'
WHERE id = 12;

-- 验证恢复结果
SELECT id, name, data_set_detail FROM s2_data_set WHERE id = 12;
