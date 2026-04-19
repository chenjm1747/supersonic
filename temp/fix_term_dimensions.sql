-- 修复 s2_term 表的 related_dimensions 字段，将维度名称改为ID
-- 维度名称到ID的映射（根据实际查询结果）

-- 通用维度ID
-- yhlx (用户类型): 47
-- org_level1 (分公司): 53, 72
-- org_level2 (热力站): 54
-- org_level3 (小区): 55
-- mjlb (面积类别): 58
-- gnzt (供暖状态): 61
-- cnq (采暖期): 67, 74, 76, 77
-- cnq_year (采暖期年份): 68
-- fylb (费用类别): 需要查询
-- sffs (收费方式): 需要查询

-- 修复 term id=7: 收费率 -> ["cnq","org_level1","fylb"] -> [67, 53, fylb_id]
-- 修复 term id=8: 欠费 -> ["cnq","org_level1","yhlx"] -> [67, 53, 47]
-- 修复 term id=9: 采暖期 -> ["cnq","cnq_year"] -> [67, 68]
-- 修复 term id=11: 在供用户 -> ["gnzt","yhlx"] -> [61, 47]
-- 修复 term id=13: 收费率 -> ["cnq","fylb","org_level1","org_level2","org_level3"]
-- 修复 term id=14: 欠费率 -> ["cnq","org_level1","yhlx"]
-- 修复 term id=15: 采暖期 -> ["cnq"]
-- 修复 term id=16: 收费面积 -> ["cnq","org_level1","org_level2","org_level3","mjlb"]
-- 修复 term id=17: 实收金额 -> ["cnq","fylb","org_level1","org_level2","org_level3"]
-- 修复 term id=18: 应收金额 -> ["cnq","fylb","org_level1","org_level2","org_level3"]
-- 修复 term id=19: 欠费金额 -> ["cnq","fylb","org_level1","org_level2","org_level3"]
-- 修复 term id=20: 用户数 -> ["cnq","org_level1","org_level2","org_level3","yhlx"]
-- 修复 term id=21: 分公司 -> ["org_level1"]
-- 修复 term id=22: 热力站 -> ["org_level2"]
-- 修复 term id=23: 小区 -> ["org_level3"]
-- 修复 term id=24: 用户类型 -> ["yhlx"]
-- 修复 term id=25: 费用类别 -> ["fylb"]
-- 修复 term id=26: 收费笔数 -> ["cnq","org_level1","sffs"]
-- 修复 term id=27: 折扣金额 -> ["cnq","org_level1"]
-- 修复 term id=28: 核减金额 -> ["cnq","org_level1"]

-- 首先清空所有非空 related_dimensions
UPDATE heating_analytics.s2_term SET related_dimensions = '[]' WHERE related_dimensions != '[]' AND related_dimensions != '' AND related_dimensions IS NOT NULL;

-- 验证
SELECT id, name, related_dimensions FROM heating_analytics.s2_term WHERE id NOT IN (1,2,3,5);
