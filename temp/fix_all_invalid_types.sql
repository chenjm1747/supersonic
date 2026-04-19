-- Fix all invalid define_type values
SET search_path TO heating_analytics;

-- Fix ATOMIC -> MEASURE
UPDATE s2_metric SET define_type = 'MEASURE' WHERE define_type = 'ATOMIC';

-- Fix DERIVED -> METRIC
UPDATE s2_metric SET define_type = 'METRIC' WHERE define_type = 'DERIVED';

-- Verify
SELECT DISTINCT define_type FROM s2_metric;
