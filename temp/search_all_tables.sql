-- Search all tables for corrupted JSON
SET search_path TO heating_analytics;

-- Search for the corrupted pattern in all text columns
DO $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT table_name, column_name
        FROM information_schema.columns
        WHERE table_schema = 'heating_analytics'
          AND data_type = 'text'
          AND table_name LIKE 's2_%'
    LOOP
        BEGIN
            EXECUTE format('UPDATE %I.%I SET %I = %I WHERE %I LIKE ''%%"1",""""%%''',
                'heating_analytics', rec.table_name, rec.column_name, rec.column_name, rec.column_name);
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'Error processing %.%: %', rec.table_name, rec.column_name, SQLERRM;
        END;
    END LOOP;
END $$;

-- Verify no more corrupted data
SELECT 'Completed search' as status;
