-- 修复 s2_term 表的 related_metrics 字段，将业务名称改为ID
-- 使用完整schema路径

UPDATE heating_analytics.s2_term SET related_metrics = '[43, 31, 37]' WHERE id = 7;

UPDATE heating_analytics.s2_term SET related_metrics = '[33, 44]' WHERE id = 8;

UPDATE heating_analytics.s2_term SET related_metrics = '[31, 37]' WHERE id = 9;

UPDATE heating_analytics.s2_term SET related_metrics = '[25, 28]' WHERE id = 11;

-- 验证更新结果
SELECT id, name, related_metrics FROM heating_analytics.s2_term WHERE id IN (7, 8, 9, 11);
