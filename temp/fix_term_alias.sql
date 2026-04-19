-- Fix s2_term alias field to be proper JSON array format
SET search_path TO heating_analytics;

-- Update alias to JSON array format
UPDATE s2_term 
SET alias = '["' || REPLACE(alias, ',', '","') || '"]' 
WHERE alias IS NOT NULL 
  AND alias != '' 
  AND alias NOT LIKE '[%';

-- Verify the data
SELECT id, name, alias FROM s2_term;
