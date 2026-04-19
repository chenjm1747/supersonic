-- Check dimension table for corrupted JSON
SET search_path TO heating_analytics;

-- Check all columns in dimension table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 's2_dimension'
ORDER BY ordinal_position;

-- Check for any JSON-like data
SELECT id, name, type_params, ext
FROM s2_dimension
WHERE type_params LIKE '%drillDown%'
   OR type_params LIKE '%"1",""%'
LIMIT 10;
