-- 修复 s2_term 表的 related_dimensions 字段
-- 由于 fylb, sffs 等维度在 s2_dimension 中不存在，将其设为空数组

UPDATE heating_analytics.s2_term SET related_dimensions = '[]' WHERE related_dimensions IS NOT NULL AND related_dimensions != '[]';

-- 验证修复结果
SELECT id, name, related_dimensions FROM heating_analytics.s2_term ORDER BY id;
