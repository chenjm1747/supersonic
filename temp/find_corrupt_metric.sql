-- Find metrics with corrupted type_params JSON
SET search_path TO heating_analytics;

-- Check metrics with type_params that might be corrupted
SELECT id, name, type_params
FROM s2_metric
WHERE type_params LIKE '%drillDownDimensions%'
   OR type_params LIKE '%dimensionId":1","%'
LIMIT 10;
