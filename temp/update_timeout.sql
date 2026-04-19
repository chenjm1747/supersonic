SET search_path TO heating_analytics;

UPDATE s2_chat_model
SET config = config::jsonb || '{"timeOut": 300}'
WHERE id = 2;

SELECT id, name, config::json->>'timeOut' as timeout FROM s2_chat_model WHERE id = 2;
