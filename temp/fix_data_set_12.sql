-- 修复数据集12关联到模型26
SET search_path TO heating_analytics;

-- 查看当前配置
SELECT id, name, data_set_detail FROM s2_data_set WHERE id = 12;

-- 更新数据集12关联到模型26
UPDATE s2_data_set
SET data_set_detail = '{"dataSetModelConfigs":[{"id": 26, "includesAll": true}]}'
WHERE id = 12;

-- 验证更新结果
SELECT id, name, data_set_detail FROM s2_data_set WHERE id = 12;
