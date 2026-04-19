-- Check define_type values in s2_metric
SET search_path TO heating_analytics;

-- Check all define_type values
SELECT id, name, define_type FROM s2_metric WHERE define_type IS NOT NULL;

-- Fix invalid define_type values (ATOMIC -> MEASURE)
UPDATE s2_metric SET define_type = 'MEASURE' WHERE define_type = 'ATOMIC';

-- Verify
SELECT id, name, define_type FROM s2_metric WHERE define_type IS NOT NULL;
