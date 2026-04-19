-- Check and fix related_dimensions and related_metrics fields
SET search_path TO heating_analytics;

-- Show current data
SELECT id, name, alias, related_dimensions, related_metrics FROM s2_term;
