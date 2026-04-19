-- Clear potentially problematic JSON fields in s2_metric
SET search_path TO heating_analytics;

-- Set all JSON fields to empty/null
UPDATE s2_metric SET type_params = '{}' WHERE type_params IS NOT NULL;
UPDATE s2_metric SET ext = '{}' WHERE ext IS NOT NULL;
UPDATE s2_metric SET classifications = '[]' WHERE classifications IS NOT NULL;
UPDATE s2_metric SET data_format = NULL WHERE data_format IS NOT NULL;
UPDATE s2_metric SET alias = '[]' WHERE alias IS NOT NULL;

-- Verify
SELECT id, name, type_params, ext FROM s2_metric LIMIT 10;
