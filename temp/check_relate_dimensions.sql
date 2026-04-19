-- Check metric relate_dimensions field
SET search_path TO heating_analytics;

-- Check for corrupted JSON
SELECT id, name, relate_dimensions
FROM s2_metric
WHERE relate_dimensions IS NOT NULL
  AND relate_dimensions != ''
  AND relate_dimensions != '{}'
LIMIT 20;
