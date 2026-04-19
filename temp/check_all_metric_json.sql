-- Check all metrics and their JSON fields
SET search_path TO heating_analytics;

-- Try to parse each JSON field and find errors
SELECT id, name, type_params, ext
FROM s2_metric
WHERE type_params IS NOT NULL
  AND type_params != ''
  AND type_params != '{}'
LIMIT 20;
