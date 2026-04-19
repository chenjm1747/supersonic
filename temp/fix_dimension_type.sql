-- Fix invalid dimension type values
SET search_path TO heating_analytics;

-- Check all type values
SELECT DISTINCT type FROM s2_dimension;

-- Fix NORMAL -> categorical
UPDATE s2_dimension SET type = 'categorical' WHERE type = 'NORMAL';

-- Verify
SELECT DISTINCT type FROM s2_dimension;
