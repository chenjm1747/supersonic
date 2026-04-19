-- Fix s2_metric table JSON fields
SET search_path TO heating_analytics;

-- Update relate_dimensions to JSON array
UPDATE s2_metric 
SET relate_dimensions = CASE 
    WHEN relate_dimensions IS NULL OR relate_dimensions = '' OR relate_dimensions = '[]' THEN '[]'
    WHEN relate_dimensions LIKE '[%' THEN relate_dimensions  -- Already JSON
    ELSE '["' || REPLACE(relate_dimensions, ',', '","') || '"]'
END
WHERE relate_dimensions IS NOT NULL;

-- Update type_params if it's not already JSON
UPDATE s2_metric 
SET type_params = CASE
    WHEN type_params IS NULL OR type_params = '' THEN '{}'
    WHEN type_params LIKE '{' || '%' || '}' THEN type_params  -- Already JSON
    ELSE '{"raw": "' || type_params || '"}'
END
WHERE type_params IS NOT NULL;

-- Update ext if needed
UPDATE s2_metric 
SET ext = CASE
    WHEN ext IS NULL OR ext = '' THEN '{}'
    WHEN ext LIKE '{' || '%' || '}' THEN ext  -- Already JSON
    ELSE '{"raw": "' || ext || '"}'
END
WHERE ext IS NOT NULL;

-- Update classifications if needed
UPDATE s2_metric 
SET classifications = CASE
    WHEN classifications IS NULL OR classifications = '' THEN '[]'
    WHEN classifications LIKE '[%' THEN classifications  -- Already JSON
    ELSE '["' || REPLACE(classifications, ',', '","') || '"]'
END
WHERE classifications IS NOT NULL;

-- Verify the data
SELECT id, name, relate_dimensions, type_params FROM s2_metric LIMIT 10;
