-- Check metric table data with JSON fields
SET search_path TO heating_analytics;

SELECT id, name, alias, relate_dimensions, type_params, ext, classifications 
FROM s2_metric 
LIMIT 10;
