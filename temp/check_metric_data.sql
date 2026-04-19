-- Check all tables in heating_analytics schema
SET search_path TO heating_analytics;

-- Check s2_metric table structure
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 's2_metric' 
ORDER BY ordinal_position;

-- Check sample data
SELECT id, name, data_format, schema_type FROM s2_metric LIMIT 5;
