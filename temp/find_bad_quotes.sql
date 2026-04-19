-- Find and fix corrupted JSON with extra quotes
SET search_path TO heating_analytics;

-- Find records with corrupted JSON (extra quotes after numbers/booleans)
SELECT id, name, type_params
FROM s2_metric
WHERE type_params LIKE '%"1",""%'
   OR type_params LIKE '%"false",""%'
   OR type_params LIKE '%"true",""%'
LIMIT 20;
