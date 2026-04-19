SET search_path TO heating_analytics;

UPDATE s2_chat_model 
SET config = '{"apiKey":"sk-cp-FWl4LepeyUkDxZ0iE9NJ-SqVcTEW3yqPbLtwf4PeQlM3M_YgVfquhqH74XbqSF7mzfboj5gjtVbK8GrxTmsW6PPvhQ9ta2A416UxziM3kodzJdrOHYCDYKM","baseUrl":"https://api.minimaxi.com/v1","timeOut":120,"provider":"OPEN_AI","modelName":"MiniMax-M2.7","apiVersion":"2026-02-01","jsonFormat":false,"maxRetries":3,"logRequests":true,"temperature":0.0,"enableSearch":false,"logResponses":true,"jsonFormatType":"json_schema"}'
WHERE id = 2;

SELECT config::jsonb->>'logRequests' as log_requests, config::jsonb->>'logResponses' as log_responses FROM s2_chat_model WHERE id = 2;
