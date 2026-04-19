SET search_path TO heating_analytics;

UPDATE s2_chat_model 
SET config = '{"apiKey":"sk-cp-esandboxdemo","baseUrl":"https://api.openai.com/v1","timeOut":60,"provider":"OPEN_AI","modelName":"gpt-4o-mini","apiVersion":"2024-02-01","jsonFormat":false,"maxRetries":3,"logRequests":false,"temperature":0.0,"enableSearch":false,"logResponses":false,"jsonFormatType":"json_schema"}'
WHERE id = 1;

SELECT id, name, config FROM s2_chat_model WHERE id = 1;
