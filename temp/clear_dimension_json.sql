-- Clear potentially problematic JSON fields in s2_dimension
SET search_path TO heating_analytics;

-- Check current data
SELECT id, name, type_params FROM s2_dimension LIMIT 10;
