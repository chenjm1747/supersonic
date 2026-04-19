-- Check data_format and data_format_type fields
SET search_path TO heating_analytics;

SELECT id, name, data_format, data_format_type
FROM s2_metric
WHERE data_format IS NOT NULL
  AND data_format != ''
LIMIT 20;
