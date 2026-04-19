-- Check all tables for potential JSON field issues
SET search_path TO heating_analytics;

-- List all tables
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'heating_analytics' 
  AND table_type = 'BASE TABLE'
ORDER BY table_name;
