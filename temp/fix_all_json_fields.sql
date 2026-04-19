-- Fix all JSON fields in s2_term
SET search_path TO heating_analytics;

-- Update related_dimensions to JSON array
UPDATE s2_term 
SET related_dimensions = CASE 
    WHEN related_dimensions IS NULL OR related_dimensions = '' OR related_dimensions = '[]' THEN '[]'
    ELSE '["' || REPLACE(related_dimensions, ',', '","') || '"]'
END
WHERE related_dimensions IS NOT NULL AND related_dimensions NOT LIKE '[%';

-- Update related_metrics to JSON array  
UPDATE s2_term 
SET related_metrics = CASE
    WHEN related_metrics IS NULL OR related_metrics = '' OR related_metrics = '[]' THEN '[]'
    ELSE '["' || REPLACE(related_metrics, ',', '","') || '"]'
END
WHERE related_metrics IS NOT NULL AND related_metrics NOT LIKE '[%';

-- Verify all data
SELECT id, name, alias, related_dimensions, related_metrics FROM s2_term;
