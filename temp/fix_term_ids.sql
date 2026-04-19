-- Clear incorrect metric and dimension ID fields in s2_term
-- The data contains names instead of IDs, which is wrong
SET search_path TO heating_analytics;

-- Set related_metrics and related_dimensions to empty arrays
UPDATE s2_term SET related_metrics = '[]' WHERE related_metrics IS NOT NULL;
UPDATE s2_term SET related_dimensions = '[]' WHERE related_dimensions IS NOT NULL;

-- Verify the data
SELECT id, name, alias, related_metrics, related_dimensions FROM s2_term;
