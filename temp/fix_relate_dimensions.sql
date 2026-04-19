-- Clear corrupted relate_dimensions in s2_metric
SET search_path TO heating_analytics;

-- Set all relate_dimensions to empty JSON array
UPDATE s2_metric SET relate_dimensions = '[]' WHERE relate_dimensions IS NOT NULL;

-- Verify
SELECT id, name, relate_dimensions FROM s2_metric LIMIT 10;
