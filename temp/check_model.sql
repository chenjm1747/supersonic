-- Check model table for corrupted JSON
SET search_path TO heating_analytics;

-- Check all columns in model table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 's2_model'
ORDER BY ordinal_position;

-- Check data
SELECT id, name, type_params, data_set_id FROM s2_model LIMIT 5;
