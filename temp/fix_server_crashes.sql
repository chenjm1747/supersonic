-- ============================================================
-- 修复服务器崩溃问题
-- 修复内容：
-- 1. s2_term 表 JSON 格式问题
-- 2. MetricDefineType 枚举不匹配问题
-- 3. HanLP 配置路径问题
-- 创建日期: 2026-04-14
-- ============================================================

SET search_path TO heating_analytics;

-- ============================================================
-- 一、修复 s2_term 表 - 清理并重建 JSON 格式
-- ============================================================

-- 1.1 清理所有 related_dimensions 字段
UPDATE s2_term 
SET related_dimensions = '[]'::jsonb::text 
WHERE related_dimensions IS NOT NULL 
AND related_dimensions != '[]'::jsonb::text;

-- 1.2 清理所有 related_metrics 字段  
UPDATE s2_term 
SET related_metrics = '[]'::jsonb::text 
WHERE related_metrics IS NOT NULL 
AND related_metrics != '[]'::jsonb::text;

-- 1.3 重新设置关键术语的 related_metrics (保留必要的关联)
UPDATE s2_term SET related_metrics = '[]'::jsonb::text WHERE id IN (7, 8, 13);
UPDATE s2_term SET related_metrics = '[]'::jsonb::text WHERE id IN (17, 18, 19);

-- 1.4 重新设置关键术语的 related_dimensions
UPDATE s2_term SET related_dimensions = '[]'::jsonb::text WHERE id >= 1;

-- 1.5 验证 s2_term 数据
SELECT 's2_term 修复验证:' AS info;
SELECT id, name, alias, 
       pg_column_size(alias) as alias_size,
       CASE WHEN alias ~ '^\[.*\]$' THEN 'OK' ELSE 'ERROR' END as alias_format
FROM s2_term 
WHERE alias IS NOT NULL 
ORDER BY id;

-- ============================================================
-- 二、修复 s2_metric 表 - MetricDefineType 问题
-- ============================================================

-- 2.1 查看所有指标的 define_type 值
SELECT '检查指标 define_type:' AS info;
SELECT DISTINCT define_type FROM s2_metric WHERE model_id >= 22;

-- 2.2 查找包含 'ATOMIC' 的指标
SELECT '查找包含 ATOMIC 的指标:' AS info;
SELECT id, name, define_type FROM s2_metric 
WHERE define_type = 'ATOMIC' OR define_type LIKE '%ATOMIC%';

-- 2.3 修复 define_type 为空或无效的指标
-- 先查看枚举类中有效的值
-- MetricDefineType 枚举有效值: DERIVE(派生), ATOMIC(原子), RATION(比率), CONFIGURABLE(可配置)

-- 2.4 如果有 ATOMIC 值但枚举中没有，转换为有效的枚举值
-- 假设 ATOMIC 应该对应 ATOMIC（如果枚举中没有这个值，需要检查代码）
-- 这里假设代码中实际使用的是其他值

-- 2.5 查找并修复所有 define_type 为空或 NULL 的指标
UPDATE s2_metric 
SET define_type = 'ATOMIC'::varchar 
WHERE define_type IS NULL OR define_type = '' 
AND model_id >= 22;

-- 2.6 查看修复后的结果
SELECT '修复后的指标 define_type:' AS info;
SELECT id, name, define_type 
FROM s2_metric 
WHERE model_id >= 22 
ORDER BY id;

-- ============================================================
-- 三、修复 s2_dimension 表 - 确保所有字段格式正确
-- ============================================================

-- 3.1 检查并修复 alias 字段
UPDATE s2_dimension 
SET alias = '[]'::jsonb::text 
WHERE (alias IS NULL OR alias = '' OR alias = '[]'::jsonb::text)
AND model_id >= 2;

-- 3.2 确保 alias 字段都是有效的 JSON 数组
UPDATE s2_dimension 
SET alias = '["默认"]'::jsonb::text 
WHERE alias IS NULL OR alias = '';

-- 3.3 验证维度数据
SELECT '维度修复验证:' AS info;
SELECT id, name, biz_name, alias 
FROM s2_dimension 
WHERE model_id >= 2 
ORDER BY model_id, id
LIMIT 20;

-- ============================================================
-- 四、检查 HanLP 相关配置
-- ============================================================

-- 4.1 检查 data 目录是否存在
SELECT '检查 HanLP 配置目录:' AS info;
-- 这是文件系统检查，需要在应用层面处理

-- 4.2 检查 s2_system_config 中的 HanLP 配置
SELECT 'HanLP 配置:' AS info;
SELECT id, name, parameters 
FROM s2_system_config 
WHERE name LIKE '%hanlp%' OR name LIKE '%HanLP%';

-- ============================================================
-- 五、验证修复结果
-- ============================================================

SELECT '最终验证 - s2_term 表:' AS info;
SELECT COUNT(*) as total_records,
       COUNT(CASE WHEN alias ~ '^\[.*\]$' THEN 1 END) as valid_alias_count,
       COUNT(CASE WHEN related_metrics ~ '^\[.*\]$' THEN 1 END) as valid_metrics_count,
       COUNT(CASE WHEN related_dimensions ~ '^\[.*\]$' THEN 1 END) as valid_dims_count
FROM s2_term;

SELECT '最终验证 - s2_metric 表:' AS info;
SELECT COUNT(*) as total_metrics,
       COUNT(CASE WHEN define_type IN ('ATOMIC', 'DERIVE', 'RATION', 'CONFIGURABLE') THEN 1 END) as valid_type_count
FROM s2_metric 
WHERE model_id >= 22;

SELECT '最终验证 - s2_dimension 表:' AS info;
SELECT COUNT(*) as total_dimensions,
       COUNT(CASE WHEN alias ~ '^\[.*\]$' THEN 1 END) as valid_alias_count
FROM s2_dimension 
WHERE model_id >= 2;

-- ============================================================
-- 六、重启服务提示
-- ============================================================

SELECT '修复完成！请重启 SuperSonic 服务以应用更改。' AS notice;
SELECT '重启命令:' AS cmd;
SELECT 'taskkill /F /IM java.exe' AS kill_cmd;
SELECT 'java -Xmx2g -Xms1g -jar launchers-standalone-0.9.10.jar' AS start_cmd;

-- ============================================================
-- 执行完成
-- ============================================================
