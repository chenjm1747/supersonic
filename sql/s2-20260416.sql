/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.1.10
 Source Server Type    : PostgreSQL
 Source Server Version : 120022
 Source Host           : 192.168.1.10:5432
 Source Catalog        : postgres
 Source Schema         : heating_analytics

 Target Server Type    : PostgreSQL
 Target Server Version : 120022
 File Encoding         : 65001

 Date: 16/04/2026 11:07:45
*/

CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_agent_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_app_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_available_date_info_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_canvas_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_chat_chat_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_chat_config_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_chat_memory_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_chat_model_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_chat_query_question_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_collect_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_data_set_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_database_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_dictionary_conf_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_dictionary_task_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_dimension_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_domain_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_metric_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_metric_query_default_config_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_model_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_model_rela_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_plugin_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_query_rule_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_query_stat_info_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_system_config_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_tag_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_tag_object_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_term_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_user_id_seq;
CREATE SEQUENCE IF NOT EXISTS heating_analytics.s2_user_token_id_seq;
-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."brand";
CREATE TABLE "heating_analytics"."brand" (
  "brand_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "brand_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "brand_established_time" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "company_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "legal_representative" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "registered_capital" int8
)
;

-- ----------------------------
-- Records of brand
-- ----------------------------

-- ----------------------------
-- Table structure for brand_revenue
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."brand_revenue";
CREATE TABLE "heating_analytics"."brand_revenue" (
  "year_time" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
  "brand_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "revenue" int8 NOT NULL,
  "profit" int8 NOT NULL,
  "revenue_growth_year_on_year" float8 NOT NULL,
  "profit_growth_year_on_year" float8 NOT NULL
)
;

-- ----------------------------
-- Records of brand_revenue
-- ----------------------------

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."company";
CREATE TABLE "heating_analytics"."company" (
  "company_id" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "company_name" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "headquarter_address" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "company_established_time" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "founder" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "ceo" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "annual_turnover" int8,
  "employee_count" int4
)
;

-- ----------------------------
-- Records of company
-- ----------------------------

-- ----------------------------
-- Table structure for genre
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."genre";
CREATE TABLE "heating_analytics"."genre" (
  "g_name" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "rating" int4,
  "most_popular_in" varchar(50) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of genre
-- ----------------------------
INSERT INTO "heating_analytics"."genre" VALUES ('tagore', 8, '瀛熷姞鎷夊浗');
INSERT INTO "heating_analytics"."genre" VALUES ('nazrul', 7, '瀛熷姞鎷夊浗');

-- ----------------------------
-- Table structure for s2_agent
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_agent";
CREATE TABLE "heating_analytics"."s2_agent" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_agent_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "description" text COLLATE "pg_catalog"."default",
  "examples" text COLLATE "pg_catalog"."default",
  "status" int2,
  "model" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "tool_config" varchar(6000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "llm_config" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "chat_model_config" text COLLATE "pg_catalog"."default",
  "visual_config" varchar(2000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "enable_search" int2 DEFAULT 1,
  "enable_feedback" int2 DEFAULT 1,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "created_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "updated_at" timestamp(6),
  "admin" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "admin_org" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_open" int2,
  "viewer" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "view_org" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_agent
-- ----------------------------
INSERT INTO "heating_analytics"."s2_agent" VALUES (1, '企业分析助手', '帮忙您对企业的员工数、收入、利润经营指标分析', '["各公司员工都有多少人","利润最高的品牌top 3","2024财年aws的营收和利润","特斯拉下有哪些品牌"]', 1, NULL, '{"tools":[{"dataSetIds":[2],"id":"1","type":"DATASET"}]}', NULL, '{"MEMORY_REVIEW":{"name":"记忆启用评估","description":"通过大模型对记忆做正确性评估以决定是否启用","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and give your opinion.\n#Rules: \n1.ALWAYS follow the output format: `opinion=(POSITIVE|NEGATIVE),comment=(your comment)`.\n2.NO NEED to check date filters as the junior engineer seldom makes mistakes in this regard.\n#Question: %s\n#Schema: %s\n#SideInfo: %s\n#SQL: %s\n#Response: ","enable":false,"chatModelId":1},"REWRITE_MULTI_TURN":{"name":"多轮对话改写","description":"通过大模型根据历史对话来改写本轮对话","prompt":"#Role: You are a data product manager experienced in data requirements.#Task: Your will be provided with current and history questions asked by a user,along with their mapped schema elements(metric, dimension and value),please try understanding the semantics and rewrite a question.#Rules: 1.ALWAYS keep relevant entities, metrics, dimensions, values and date ranges.2.ONLY respond with the rewritten question.#Current Question: {{current_question}}#Current Mapped Schema: {{current_schema}}#History Question: {{history_question}}#History Mapped Schema: {{history_schema}}#History SQL: {{history_sql}}#Rewritten Question: ","enable":false,"chatModelId":1},"S2SQL_CORRECTOR":{"name":"语义SQL修正","description":"通过大模型对解析S2SQL做二次修正","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and help correct it if necessary.\n#Rules: 1.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.2.DO NOT calculate date range using functions.3.SQL columns and values must be mentioned in the `#Schema`.\n#Question:{{question}} #Schema:{{schema}} #InputSQL:{{sql}} #Response:","enable":false,"chatModelId":1},"SMALL_TALK":{"name":"闲聊对话","description":"直接将原始输入透传大模型","prompt":"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: %s\n#Current Input: %s\n#Response: ","enable":false,"chatModelId":1},"DATA_INTERPRETER":{"name":"结果数据解读","description":"通过大模型对结果数据做提炼总结","prompt":"#Role: You are a data expert who communicates with business users everyday.\n#Task: Your will be provided with a question asked by a user and the relevant result data queried from the databases, please interpret the data and organize a brief answer.\n#Rules: \n1.ALWAYS respond in the use the same language as the `#Question`.\n2.ALWAYS reference some key data in the `#Answer`.\n#Question:{{question}} #Data:{{data}} #Answer:","enable":false,"chatModelId":1},"PHYSICAL_SQL_CORRECTOR":{"name":"物理SQL修正","description":"通过大模型对物理SQL做性能优化","prompt":"#Role: You are a senior database performance optimization expert experienced in SQL tuning.\n\n#Task: You will be provided with a user question and the corresponding physical SQL query, please analyze and optimize this SQL to improve query performance.\n\n#Rules:\n1. DO NOT add or introduce any new fields, columns, or aliases that are not in the original SQL.\n2. Push WHERE conditions into JOIN ON clauses when possible to reduce intermediate result sets.\n3. Optimize JOIN order by placing smaller tables or tables with selective conditions first.\n4. For date range conditions, ensure they are applied as early as possible in the query execution.\n5. Remove or comment out database-specific index hints (like USE INDEX) that may cause syntax errors.\n6. ONLY modify the structure and order of existing elements, do not change field names or add new ones.\n7. Ensure the optimized SQL is syntactically correct and logically equivalent to the original.\n\n#Question: {{question}}\n\n#OriginalSQL: {{sql}}","enable":false,"chatModelId":1},"S2SQL_PARSER":{"name":"语义SQL解析","description":"通过大模型做语义解析生成S2SQL","prompt":"#Role: You are a data analyst experienced in SQL languages.\n#Task: You will be provided with a natural language question asked by users,please convert it to a SQL query so that relevant data could be returned by executing the SQL query against underlying database.\n#Rules:\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate.\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`.\n4.DO NOT calculate date range using functions.\n5.ALWAYS use `with` statement if nested aggregation is needed.\n6.ALWAYS enclose alias declared by `AS` command in underscores.\n7.Alias created by `AS` command must be in the same language ast the `Question`.\n#Exemplars: {{exemplar}}\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}","enable":true,"chatModelId":1},"REWRITE_ERROR_MESSAGE":{"name":"异常提示改写","description":"通过大模型将异常信息改写为更友好和引导性的提示用语","prompt":"#Role: You are a data business partner who closely interacts with business people.\n#Task: Your will be provided with user input, system output and some examples, please respond shortly to teach user how to ask the right question, by using `Examples` as references.#Rules: ALWAYS respond with the same language as the `Input`.\n#Input: {{user_question}}\n#Output: {{system_message}}\n#Examples: {{examples}}\n#Response: ","enable":true,"chatModelId":1}}', '', 1, 0, 'admin', '2026-04-13 11:04:54.935', 'admin', '2026-04-13 11:04:54.935', '[]', '[]', 0, '[]', '[]');
INSERT INTO "heating_analytics"."s2_agent" VALUES (2, '艺人分析助手', '帮忙您对不同流派、区域的艺人做分析查询', '["国风流派歌手","港台歌手","周杰伦流派"]', 1, NULL, '{"tools":[{"dataSetIds":[3],"id":"1","type":"DATASET"}]}', NULL, '{"MEMORY_REVIEW":{"name":"记忆启用评估","description":"通过大模型对记忆做正确性评估以决定是否启用","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and give your opinion.\n#Rules: \n1.ALWAYS follow the output format: `opinion=(POSITIVE|NEGATIVE),comment=(your comment)`.\n2.NO NEED to check date filters as the junior engineer seldom makes mistakes in this regard.\n#Question: %s\n#Schema: %s\n#SideInfo: %s\n#SQL: %s\n#Response: ","enable":false,"chatModelId":1},"REWRITE_MULTI_TURN":{"name":"多轮对话改写","description":"通过大模型根据历史对话来改写本轮对话","prompt":"#Role: You are a data product manager experienced in data requirements.#Task: Your will be provided with current and history questions asked by a user,along with their mapped schema elements(metric, dimension and value),please try understanding the semantics and rewrite a question.#Rules: 1.ALWAYS keep relevant entities, metrics, dimensions, values and date ranges.2.ONLY respond with the rewritten question.#Current Question: {{current_question}}#Current Mapped Schema: {{current_schema}}#History Question: {{history_question}}#History Mapped Schema: {{history_schema}}#History SQL: {{history_sql}}#Rewritten Question: ","enable":false,"chatModelId":1},"S2SQL_CORRECTOR":{"name":"语义SQL修正","description":"通过大模型对解析S2SQL做二次修正","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and help correct it if necessary.\n#Rules: 1.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.2.DO NOT calculate date range using functions.3.SQL columns and values must be mentioned in the `#Schema`.\n#Question:{{question}} #Schema:{{schema}} #InputSQL:{{sql}} #Response:","enable":false,"chatModelId":1},"SMALL_TALK":{"name":"闲聊对话","description":"直接将原始输入透传大模型","prompt":"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: %s\n#Current Input: %s\n#Response: ","enable":false,"chatModelId":1},"DATA_INTERPRETER":{"name":"结果数据解读","description":"通过大模型对结果数据做提炼总结","prompt":"#Role: You are a data expert who communicates with business users everyday.\n#Task: Your will be provided with a question asked by a user and the relevant result data queried from the databases, please interpret the data and organize a brief answer.\n#Rules: \n1.ALWAYS respond in the use the same language as the `#Question`.\n2.ALWAYS reference some key data in the `#Answer`.\n#Question:{{question}} #Data:{{data}} #Answer:","enable":false,"chatModelId":1},"PHYSICAL_SQL_CORRECTOR":{"name":"物理SQL修正","description":"通过大模型对物理SQL做性能优化","prompt":"#Role: You are a senior database performance optimization expert experienced in SQL tuning.\n\n#Task: You will be provided with a user question and the corresponding physical SQL query, please analyze and optimize this SQL to improve query performance.\n\n#Rules:\n1. DO NOT add or introduce any new fields, columns, or aliases that are not in the original SQL.\n2. Push WHERE conditions into JOIN ON clauses when possible to reduce intermediate result sets.\n3. Optimize JOIN order by placing smaller tables or tables with selective conditions first.\n4. For date range conditions, ensure they are applied as early as possible in the query execution.\n5. Remove or comment out database-specific index hints (like USE INDEX) that may cause syntax errors.\n6. ONLY modify the structure and order of existing elements, do not change field names or add new ones.\n7. Ensure the optimized SQL is syntactically correct and logically equivalent to the original.\n\n#Question: {{question}}\n\n#OriginalSQL: {{sql}}","enable":false,"chatModelId":1},"S2SQL_PARSER":{"name":"语义SQL解析","description":"通过大模型做语义解析生成S2SQL","prompt":"#Role: You are a data analyst experienced in SQL languages.\n#Task: You will be provided with a natural language question asked by users,please convert it to a SQL query so that relevant data could be returned by executing the SQL query against underlying database.\n#Rules:\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate.\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`.\n4.DO NOT calculate date range using functions.\n5.ALWAYS use `with` statement if nested aggregation is needed.\n6.ALWAYS enclose alias declared by `AS` command in underscores.\n7.Alias created by `AS` command must be in the same language ast the `Question`.\n#Exemplars: {{exemplar}}\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}","enable":true,"chatModelId":1},"REWRITE_ERROR_MESSAGE":{"name":"异常提示改写","description":"通过大模型将异常信息改写为更友好和引导性的提示用语","prompt":"#Role: You are a data business partner who closely interacts with business people.\n#Task: Your will be provided with user input, system output and some examples, please respond shortly to teach user how to ask the right question, by using `Examples` as references.#Rules: ALWAYS respond with the same language as the `Input`.\n#Input: {{user_question}}\n#Output: {{system_message}}\n#Examples: {{examples}}\n#Response: ","enable":true,"chatModelId":1}}', '', 1, 0, 'admin', '2026-04-13 11:04:55.309', 'admin', '2026-04-13 11:04:55.309', '["alice"]', '[]', 0, '["tom","jack"]', '[]');
INSERT INTO "heating_analytics"."s2_agent" VALUES (3, '闲聊助手', '直接与大模型对话，验证连通性', '["如何才能变帅","如何才能赚更多钱","如何才能世界和平"]', 1, NULL, '{"tools":[],"simpleMode":false,"debugMode":true}', NULL, '{"MEMORY_REVIEW":{"name":"记忆启用评估","description":"通过大模型对记忆做正确性评估以决定是否启用","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and give your opinion.\n#Rules: \n1.ALWAYS follow the output format: `opinion=(POSITIVE|NEGATIVE),comment=(your comment)`.\n2.NO NEED to check date filters as the junior engineer seldom makes mistakes in this regard.\n#Question: %s\n#Schema: %s\n#SideInfo: %s\n#SQL: %s\n#Response: ","enable":false,"chatModelId":1},"REWRITE_MULTI_TURN":{"name":"多轮对话改写","description":"通过大模型根据历史对话来改写本轮对话","prompt":"#Role: You are a data product manager experienced in data requirements.#Task: Your will be provided with current and history questions asked by a user,along with their mapped schema elements(metric, dimension and value),please try understanding the semantics and rewrite a question.#Rules: 1.ALWAYS keep relevant entities, metrics, dimensions, values and date ranges.2.ONLY respond with the rewritten question.#Current Question: {{current_question}}#Current Mapped Schema: {{current_schema}}#History Question: {{history_question}}#History Mapped Schema: {{history_schema}}#History SQL: {{history_sql}}#Rewritten Question: ","enable":false,"chatModelId":1},"S2SQL_CORRECTOR":{"name":"语义SQL修正","description":"通过大模型对解析S2SQL做二次修正","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and help correct it if necessary.\n#Rules: 1.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.2.DO NOT calculate date range using functions.3.SQL columns and values must be mentioned in the `#Schema`.\n#Question:{{question}} #Schema:{{schema}} #InputSQL:{{sql}} #Response:","enable":false,"chatModelId":1},"SMALL_TALK":{"name":"闲聊对话","description":"直接将原始输入透传大模型","prompt":"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: %s\n#Current Input: %s\n#Response: ","enable":true,"chatModelId":2},"DATA_INTERPRETER":{"name":"结果数据解读","description":"通过大模型对结果数据做提炼总结","prompt":"#Role: You are a data expert who communicates with business users everyday.\n#Task: Your will be provided with a question asked by a user and the relevant result data queried from the databases, please interpret the data and organize a brief answer.\n#Rules: \n1.ALWAYS respond in the use the same language as the `#Question`.\n2.ALWAYS reference some key data in the `#Answer`.\n#Question:{{question}} #Data:{{data}} #Answer:","enable":false,"chatModelId":1},"PHYSICAL_SQL_CORRECTOR":{"name":"物理SQL修正","description":"通过大模型对物理SQL做性能优化","prompt":"#Role: You are a senior database performance optimization expert experienced in SQL tuning.\n\n#Task: You will be provided with a user question and the corresponding physical SQL query, please analyze and optimize this SQL to improve query performance.\n\n#Rules:\n1. DO NOT add or introduce any new fields, columns, or aliases that are not in the original SQL.\n2. Push WHERE conditions into JOIN ON clauses when possible to reduce intermediate result sets.\n3. Optimize JOIN order by placing smaller tables or tables with selective conditions first.\n4. For date range conditions, ensure they are applied as early as possible in the query execution.\n5. Remove or comment out database-specific index hints (like USE INDEX) that may cause syntax errors.\n6. ONLY modify the structure and order of existing elements, do not change field names or add new ones.\n7. Ensure the optimized SQL is syntactically correct and logically equivalent to the original.\n\n#Question: {{question}}\n\n#OriginalSQL: {{sql}}","enable":false,"chatModelId":1},"S2SQL_PARSER":{"name":"语义SQL解析","description":"通过大模型做语义解析生成S2SQL","prompt":"#Role: You are a data analyst experienced in SQL languages.\n#Task: You will be provided with a natural language question asked by users,please convert it to a SQL query so that relevant data could be returned by executing the SQL query against underlying database.\n#Rules:\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate.\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`.\n4.DO NOT calculate date range using functions.\n5.ALWAYS use `with` statement if nested aggregation is needed.\n6.ALWAYS enclose alias declared by `AS` command in underscores.\n7.Alias created by `AS` command must be in the same language ast the `Question`.\n#Exemplars: {{exemplar}}\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}","enable":false,"chatModelId":1},"REWRITE_ERROR_MESSAGE":{"name":"异常提示改写","description":"通过大模型将异常信息改写为更友好和引导性的提示用语","prompt":"#Role: You are a data business partner who closely interacts with business people.\n#Task: Your will be provided with user input, system output and some examples, please respond shortly to teach user how to ask the right question, by using `Examples` as references.#Rules: ALWAYS respond with the same language as the `Input`.\n#Input: {{user_question}}\n#Output: {{system_message}}\n#Examples: {{examples}}\n#Response: ","enable":true,"chatModelId":2}}', '', 0, 0, 'admin', '2026-04-13 11:04:55.325', 'admin', '2026-04-14 12:36:30.051', '["jack"]', '[]', 0, '["alice","tom"]', '[]');
INSERT INTO "heating_analytics"."s2_agent" VALUES (4, '收费分析师', '帮助用户对供热收费系统数据进行分析', '["哪个小区收费率高？"]', 1, NULL, '{"simpleMode":false,"debugMode":true,"tools":[{"id":"iJ7NbbsQ","type":"DATASET","name":"小区收费率","dataSetIds":[18,17,12,13,14,15],"exampleQuestions":[],"metricOptions":[]}]}', NULL, '{"MEMORY_REVIEW":{"name":"记忆启用评估","description":"通过大模型对记忆做正确性评估以决定是否启用","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and give your opinion.\n#Rules: \n1.ALWAYS follow the output format: `opinion=(POSITIVE|NEGATIVE),comment=(your comment)`.\n2.NO NEED to check date filters as the junior engineer seldom makes mistakes in this regard.\n#Question: %s\n#Schema: %s\n#SideInfo: %s\n#SQL: %s\n#Response: ","enable":true,"chatModelId":2},"REWRITE_MULTI_TURN":{"name":"多轮对话改写","description":"通过大模型根据历史对话来改写本轮对话","prompt":"#Role: You are a data product manager experienced in data requirements.#Task: Your will be provided with current and history questions asked by a user,along with their mapped schema elements(metric, dimension and value),please try understanding the semantics and rewrite a question.#Rules: 1.ALWAYS keep relevant entities, metrics, dimensions, values and date ranges.2.ONLY respond with the rewritten question.#Current Question: {{current_question}}#Current Mapped Schema: {{current_schema}}#History Question: {{history_question}}#History Mapped Schema: {{history_schema}}#History SQL: {{history_sql}}#Rewritten Question: ","enable":true,"chatModelId":2},"S2SQL_CORRECTOR":{"name":"语义SQL修正","description":"通过大模型对解析S2SQL做二次修正","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and help correct it if necessary.\n#Rules: 1.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.2.DO NOT calculate date range using functions.3.SQL columns and values must be mentioned in the `#Schema`.\n#Question:{{question}} #Schema:{{schema}} #InputSQL:{{sql}} #Response:","enable":false,"chatModelId":2},"SMALL_TALK":{"name":"闲聊对话","description":"直接将原始输入透传大模型","prompt":"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: %s\n#Current Input: %s\n#Response: ","enable":true,"chatModelId":2},"DATA_INTERPRETER":{"name":"结果数据解读","description":"通过大模型对结果数据做提炼总结","prompt":"#Role: You are a data expert who communicates with business users everyday.\n#Task: Your will be provided with a question asked by a user and the relevant result data queried from the databases, please interpret the data and organize a brief answer.\n#Rules: \n1.ALWAYS respond in the use the same language as the `#Question`.\n2.ALWAYS reference some key data in the `#Answer`.\n#Question:{{question}} #Data:{{data}} #Answer:","enable":true,"chatModelId":2},"PHYSICAL_SQL_CORRECTOR":{"name":"物理SQL修正","description":"通过大模型对物理SQL做性能优化","prompt":"#Role: You are a senior database performance optimization expert experienced in SQL tuning.\n\n#Task: You will be provided with a user question and the corresponding physical SQL query, please analyze and optimize this SQL to improve query performance.\n\n#Rules:\n1. DO NOT add or introduce any new fields, columns, or aliases that are not in the original SQL.\n2. Push WHERE conditions into JOIN ON clauses when possible to reduce intermediate result sets.\n3. Optimize JOIN order by placing smaller tables or tables with selective conditions first.\n4. For date range conditions, ensure they are applied as early as possible in the query execution.\n5. Remove or comment out database-specific index hints (like USE INDEX) that may cause syntax errors.\n6. ONLY modify the structure and order of existing elements, do not change field names or add new ones.\n7. Ensure the optimized SQL is syntactically correct and logically equivalent to the original.\n\n#Question: {{question}}\n\n#OriginalSQL: {{sql}}","enable":false,"chatModelId":2},"S2SQL_PARSER":{"name":"语义SQL解析","description":"通过大模型做语义解析生成S2SQL","prompt":"#Role: You are a data analyst experienced in SQL languages.\n#Task: You will be provided with a natural language question asked by users,please convert it to a SQL query so that relevant data could be returned by executing the SQL query against underlying database.\n#Rules:\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate.\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`.\n4.DO NOT calculate date range using functions.\n5.ALWAYS use `with` statement if nested aggregation is needed.\n6.ALWAYS enclose alias declared by `AS` command in underscores.\n7.Alias created by `AS` command must be in the same language ast the `Question`.\n#Exemplars: {{exemplar}}\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}","enable":true,"chatModelId":2},"REWRITE_ERROR_MESSAGE":{"name":"异常提示改写","description":"通过大模型将异常信息改写为更友好和引导性的提示用语","prompt":"#Role: You are a data business partner who closely interacts with business people.\n#Task: Your will be provided with user input, system output and some examples, please respond shortly to teach user how to ask the right question, by using `Examples` as references.#Rules: ALWAYS respond with the same language as the `Input`.\n#Input: {{user_question}}\n#Output: {{system_message}}\n#Examples: {{examples}}\n#Response: ","enable":true,"chatModelId":2}}', '', 1, 0, 'admin', '2026-04-13 22:24:04.295', 'admin', '2026-04-15 12:56:26.229', '["admin"]', '[]', 0, '["admin"]', '[]');

-- ----------------------------
-- Table structure for s2_app
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_app";
CREATE TABLE "heating_analytics"."s2_app" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_app_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "description" varchar(255) COLLATE "pg_catalog"."default",
  "status" int4,
  "config" text COLLATE "pg_catalog"."default",
  "end_date" timestamp(6),
  "qps" int4,
  "app_secret" varchar(255) COLLATE "pg_catalog"."default",
  "owner" varchar(255) COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "updated_at" timestamp(6),
  "created_by" varchar(255) COLLATE "pg_catalog"."default",
  "updated_by" varchar(255) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_app
-- ----------------------------

-- ----------------------------
-- Table structure for s2_auth_groups
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_auth_groups";
CREATE TABLE "heating_analytics"."s2_auth_groups" (
  "group_id" int4 NOT NULL,
  "config" varchar(2048) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_auth_groups
-- ----------------------------
INSERT INTO "heating_analytics"."s2_auth_groups" VALUES (1, '{"modelId":3,"name":"jack_column_permission","groupId":1,"authRules":[{"metrics":["stay_hours"],"dimensions":["page"]}],"authorizedUsers":["jack"],"authorizedDepartmentIds":[]}');
INSERT INTO "heating_analytics"."s2_auth_groups" VALUES (2, '{"modelId":3,"name":"tom_row_permission","groupId":2,"authRules":[],"dimensionFilters":["user_name \u003d \u0027tom\u0027"],"authorizedUsers":["tom"],"authorizedDepartmentIds":[]}');

-- ----------------------------
-- Table structure for s2_available_date_info
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_available_date_info";
CREATE TABLE "heating_analytics"."s2_available_date_info" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_available_date_info_id_seq'::regclass),
  "item_id" int4 NOT NULL,
  "type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "date_format" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "date_period" varchar(64) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "start_date" varchar(64) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "end_date" varchar(64) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "unavailable_date" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 DEFAULT 0
)
;

-- ----------------------------
-- Records of s2_available_date_info
-- ----------------------------
INSERT INTO "heating_analytics"."s2_available_date_info" VALUES (1, 1, 'dimension', 'yyyy-MM-dd', NULL, '2026-02-13 00:00:00', '2026-03-12 00:00:00', '[]', '2023-06-01 00:00:00', 'admin', '2023-06-01 00:00:00', 'admin', 0);
INSERT INTO "heating_analytics"."s2_available_date_info" VALUES (2, 2, 'dimension', 'yyyy-MM-dd', NULL, '2026-02-13 00:00:00', '2026-03-12 00:00:00', '[]', '2023-06-01 00:00:00', 'admin', '2023-06-01 00:00:00', 'admin', 0);
INSERT INTO "heating_analytics"."s2_available_date_info" VALUES (3, 3, 'dimension', 'yyyy-MM-dd', NULL, '2026-02-13 00:00:00', '2026-03-12 00:00:00', '[]', '2023-06-01 00:00:00', 'admin', '2023-06-01 00:00:00', 'admin', 0);

-- ----------------------------
-- Table structure for s2_canvas
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_canvas";
CREATE TABLE "heating_analytics"."s2_canvas" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_canvas_id_seq'::regclass),
  "domain_id" int8,
  "type" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "config" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "created_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of s2_canvas
-- ----------------------------
INSERT INTO "heating_analytics"."s2_canvas" VALUES (1, 1, 'modelEdgeRelation', '[{"source":"datasource-1","target":"datasource-3","type":"polyline","id":"edge-0.305251275235679741702883718912","style":{"active":{"stroke":"rgb(95, 149, 255)","lineWidth":1},"selected":{"stroke":"rgb(95, 149, 255)","lineWidth":2,"shadowColor":"rgb(95, 149, 255)","shadowBlur":10,"text-shape":{"fontWeight":500}},"highlight":{"stroke":"rgb(95, 149, 255)","lineWidth":2,"text-shape":{"fontWeight":500}},"inactive":{"stroke":"rgb(234, 234, 234)","lineWidth":1},"disable":{"stroke":"rgb(245, 245, 245)","lineWidth":1},"stroke":"#296df3","endArrow":true},"startPoint":{"x":-94,"y":-137.5,"anchorIndex":0,"id":"-94|||-137.5"},"endPoint":{"x":-234,"y":-45,"anchorIndex":1,"id":"-234|||-45"},"sourceAnchor":2,"targetAnchor":1,"label":"模型关系编辑"},{"source":"datasource-1","target":"datasource-2","type":"polyline","id":"edge-0.466237264629309141702883756359","style":{"active":{"stroke":"rgb(95, 149, 255)","lineWidth":1},"selected":{"stroke":"rgb(95, 149, 255)","lineWidth":2,"shadowColor":"rgb(95, 149, 255)","shadowBlur":10,"text-shape":{"fontWeight":500}},"highlight":{"stroke":"rgb(95, 149, 255)","lineWidth":2,"text-shape":{"fontWeight":500}},"inactive":{"stroke":"rgb(234, 234, 234)","lineWidth":1},"disable":{"stroke":"rgb(245, 245, 245)","lineWidth":1},"stroke":"#296df3","endArrow":true},"startPoint":{"x":-12,"y":-137.5,"anchorIndex":1,"id":"-12|||-137.5"},"endPoint":{"x":85,"y":31.5,"anchorIndex":0,"id":"85|||31.5"},"sourceAnchor":1,"targetAnchor":2,"label":"模型关系编辑"}]', '2023-06-01 00:00:00', 'admin', '2023-06-01 00:00:00', 'admin');

-- ----------------------------
-- Table structure for s2_chat
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat";
CREATE TABLE "heating_analytics"."s2_chat" (
  "chat_id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_chat_chat_id_seq'::regclass),
  "agent_id" int4,
  "chat_name" varchar(300) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "create_time" timestamp(6),
  "last_time" timestamp(6),
  "creator" varchar(30) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "last_question" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_delete" int2 DEFAULT 0,
  "is_top" int2 DEFAULT 0
)
;

-- ----------------------------
-- Records of s2_chat
-- ----------------------------
INSERT INTO "heating_analytics"."s2_chat" VALUES (1, 1, '新问答对话', '2026-04-13 15:17:03', '2026-04-13 15:17:03', 'admin', 'Hello, welcome to using supersonic', 0, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (2, 2, '新问答对话', '2026-04-13 15:26:34', '2026-04-13 15:26:34', 'admin', 'Hello, welcome to using supersonic', 0, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (3, 3, '新问答对话', '2026-04-13 15:26:36', '2026-04-13 23:16:42', 'admin', '你好，你是什么大模型？版本号？', 0, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (5, 3, '新问答对话', '2026-04-13 23:17:03', '2026-04-13 23:23:33', 'admin', '你好，你是什么大模型？版本号？', 0, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (4, 4, '新问答对话', '2026-04-13 22:25:26', '2026-04-13 22:25:26', 'admin', 'Hello, welcome to using supersonic', 1, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (6, 3, '新问答对话', '2026-04-14 12:24:20', '2026-04-14 13:23:22', 'admin', '如何才能变帅', 0, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (7, 4, '新问答对话', '2026-04-14 12:38:59', '2026-04-14 12:38:59', 'admin', 'Hello, welcome to using supersonic', 1, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (8, 4, '新问答对话', '2026-04-15 13:44:49', '2026-04-15 15:04:44', 'admin', '面积维度数据集查询面积数量最多的小区', 1, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (9, 4, '新问答对话', '2026-04-15 21:01:57', '2026-04-15 21:01:57', 'admin', 'Hello, welcome to using supersonic', 1, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (10, 4, '新问答对话', '2026-04-15 21:25:14', '2026-04-15 21:25:14', 'admin', 'Hello, welcome to using supersonic', 1, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (11, 4, '新问答对话', '2026-04-15 21:25:15', '2026-04-15 21:25:15', 'admin', 'Hello, welcome to using supersonic', 1, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (13, 4, '新问答对话', '2026-04-15 23:59:09', '2026-04-15 23:59:09', 'admin', 'Hello, welcome to using supersonic', 0, 0);
INSERT INTO "heating_analytics"."s2_chat" VALUES (12, 4, '新问答对话', '2026-04-15 23:57:08', '2026-04-15 23:57:08', 'admin', 'Hello, welcome to using supersonic', 1, 0);

-- ----------------------------
-- Table structure for s2_chat_config
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_config";
CREATE TABLE "heating_analytics"."s2_chat_config" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_chat_config_id_seq'::regclass),
  "model_id" int8,
  "chat_detail_config" text COLLATE "pg_catalog"."default",
  "chat_agg_config" text COLLATE "pg_catalog"."default",
  "recommended_questions" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 NOT NULL,
  "llm_examples" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_chat_config
-- ----------------------------
INSERT INTO "heating_analytics"."s2_chat_config" VALUES (1, 2, '{}', '{}', NULL, '2026-04-15 13:50:15.193215', '2026-04-15 13:50:15.193215', 'admin', 'admin', 1, NULL);

-- ----------------------------
-- Table structure for s2_chat_context
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_context";
CREATE TABLE "heating_analytics"."s2_chat_context" (
  "chat_id" int8 NOT NULL,
  "modified_at" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "query_user" varchar(64) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_text" text COLLATE "pg_catalog"."default",
  "semantic_parse" text COLLATE "pg_catalog"."default",
  "ext_data" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_chat_context
-- ----------------------------
INSERT INTO "heating_analytics"."s2_chat_context" VALUES (8, '2026-04-15 15:03:35.30646', NULL, NULL, '{"id":1,"queryMode":"METRIC_ORDERBY","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{}},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"建筑面积汇总","extInfo":{}},{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{}}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"}}],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"MAX","orders":[{"column":"建筑面积汇总","direction":"DESC"}],"limit":200,"score":7.666666666666667,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{}},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"isInherited":false,"llmMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{}},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","isInherited":false,"llmMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{}},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","isInherited":false,"llmMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{}},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"建筑面积汇总","frequency":100000,"isInherited":false,"llmMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{}},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"收费面积","isInherited":false,"llmMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{}},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"收费面积汇总","frequency":100000,"isInherited":false,"llmMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"}},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"面积id","isInherited":false,"llmMatched":false}],"sqlInfo":{"parsedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","correctedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","querySQL":"with t_14 as (SELECT `sfmj`, `id` AS `area_id`, `zdmj`\r\nFROM\r\narea\r\nWHERE `zf` \u003d 0)\nSELECT area_id, SUM(zdmj) AS zdmj, SUM(sfmj) AS sfmj FROM t_14 GROUP BY area_id ORDER BY SUM(zdmj) DESC LIMIT 200 OFFSET 0"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 建筑面积汇总,收费面积汇总 **维度:** 面积ID","sqlEvaluation":{},"properties":{}}', NULL);

-- ----------------------------
-- Table structure for s2_chat_memory
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_memory";
CREATE TABLE "heating_analytics"."s2_chat_memory" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_chat_memory_id_seq'::regclass),
  "question" varchar(655) COLLATE "pg_catalog"."default",
  "side_info" text COLLATE "pg_catalog"."default",
  "query_id" int8,
  "agent_id" int4,
  "db_schema" text COLLATE "pg_catalog"."default",
  "s2_sql" text COLLATE "pg_catalog"."default",
  "status" varchar(20) COLLATE "pg_catalog"."default",
  "llm_review" varchar(20) COLLATE "pg_catalog"."default",
  "llm_comment" text COLLATE "pg_catalog"."default",
  "human_review" varchar(20) COLLATE "pg_catalog"."default",
  "human_comment" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_chat_memory
-- ----------------------------

-- ----------------------------
-- Table structure for s2_chat_model
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_model";
CREATE TABLE "heating_analytics"."s2_chat_model" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_chat_model_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "config" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "admin" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "viewer" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_open" int2
)
;

-- ----------------------------
-- Records of s2_chat_model
-- ----------------------------
INSERT INTO "heating_analytics"."s2_chat_model" VALUES (2, 'MiniMax-M2.7', NULL, '{"apiKey":"sk-cp-FWl4LepeyUkDxZ0iE9NJ-SqVcTEW3yqPbLtwf4PeQlM3M_YgVfquhqH74XbqSF7mzfboj5gjtVbK8GrxTmsW6PPvhQ9ta2A416UxziM3kodzJdrOHYCDYKM","baseUrl":"https://api.minimaxi.com/v1","timeOut":120,"provider":"OPEN_AI","modelName":"MiniMax-M2.7","apiVersion":"2026-02-01","jsonFormat":false,"maxRetries":3,"logRequests":true,"temperature":0.0,"enableSearch":false,"logResponses":true,"jsonFormatType":"json_schema"}', '2026-04-13 15:22:23.755', 'admin', '2026-04-15 12:14:37.477', 'admin', 'admin', NULL, 0);
INSERT INTO "heating_analytics"."s2_chat_model" VALUES (1, 'OpenAI模型DEMO', '由langchain4j社区提供仅用于体验(单次请求最大token数1000), 正式使用请切换大模型', '{"apiKey":"sk-cp-esandboxdemo","baseUrl":"https://api.openai.com/v1","timeOut":60,"provider":"OPEN_AI","modelName":"gpt-4o-mini","apiVersion":"2024-02-01","jsonFormat":false,"maxRetries":3,"logRequests":false,"temperature":0.0,"enableSearch":false,"logResponses":false,"jsonFormatType":"json_schema"}', '2026-03-13 18:26:04.253', 'admin', '2026-03-13 18:26:04.253', 'admin', 'admin', NULL, NULL);
INSERT INTO "heating_analytics"."s2_chat_model" VALUES (3, 'deepseek', NULL, '{"provider":"OPEN_AI","baseUrl":"https://api.deepseek.com/v1","apiKey":"sk-6e3369766b8f4cf2b457abc8f1af854f","modelName":"deepseek-chat","apiVersion":"2026-02-01","temperature":0.0,"timeOut":60,"maxRetries":3,"logRequests":false,"logResponses":false,"enableSearch":false,"jsonFormat":false,"jsonFormatType":"json_schema"}', '2026-04-15 22:24:16.095', 'admin', '2026-04-15 22:24:33.501', 'admin', 'admin', NULL, 0);

-- ----------------------------
-- Table structure for s2_chat_parse
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_parse";
CREATE TABLE "heating_analytics"."s2_chat_parse" (
  "question_id" int8 NOT NULL,
  "chat_id" int4 NOT NULL,
  "parse_id" int4 NOT NULL,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "query_text" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "user_name" varchar(150) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "parse_info" text COLLATE "pg_catalog"."default" NOT NULL,
  "is_candidate" int4 DEFAULT 1
)
;

-- ----------------------------
-- Records of s2_chat_parse
-- ----------------------------
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (18, 6, 1, '2026-04-14 13:22:51.407', '如何才能变帅', 'admin', '{"id":1,"queryMode":"PLAIN_TEXT","metrics":[],"dimensions":[],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"NONE","orders":[],"limit":500,"score":0.0,"elementMatches":[],"sqlInfo":{},"sqlEvaluation":{},"properties":{},"detailLimit":500,"metricLimit":200}', 0);
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (47, 7, 1, '2026-04-15 09:22:36.117', '查询2025年收费率排名前10的小区', 'admin', '{"id":1,"queryMode":"METRIC_MODEL","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false}],"dimensions":[],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"NONE","orders":[],"limit":200,"score":7.666666666666667,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":18,"name":"应收金额","bizName":"应收金额","useCnt":0,"type":"TERM","alias":["应收费","应收热费"],"order":0.0,"isTag":0,"description":"应当收取的热费金额","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"应收热费","word":"应收热费","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":13,"name":"收费率","bizName":"收费率","useCnt":0,"type":"TERM","alias":["收缴率"],"order":0.0,"isTag":0,"description":"实际收取的热费与应收热费的比率，反映收费效率","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"收费率","word":"收费率","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":13,"name":"收费率","bizName":"收费率","useCnt":0,"type":"TERM","alias":["收缴率"],"order":0.33333333333333326,"isTag":0,"description":"实际收取的热费与应收热费的比率，反映收费效率","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"收费","word":"收费率","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"收费","word":"收费面积汇总","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":17,"name":"实收金额","bizName":"实收金额","useCnt":0,"type":"TERM","alias":["已收热费","收费金额"],"order":0.5,"isTag":0,"description":"实际收取的热费金额","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费金额","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":25,"name":"费用类别","bizName":"费用类别","useCnt":0,"type":"TERM","alias":["收费类型"],"order":0.5,"isTag":0,"description":"热费和其他费用的分类","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费类型","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":26,"name":"收费笔数","bizName":"收费笔数","useCnt":0,"type":"TERM","alias":["收费次数","交费笔数"],"order":0.5,"isTag":0,"description":"收费记录的数量","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费笔数","llmMatched":false,"inherited":false,"fullMatched":false}],"sqlInfo":{"parsedS2SQL":"(SELECT SUM(收费面积汇总) FROM `面积维度数据集` LIMIT 200 OFFSET 0)","correctedS2SQL":"(SELECT SUM(收费面积汇总) FROM `面积维度数据集` LIMIT 200 OFFSET 0)","querySQL":"with t_14 as (SELECT `sfmj`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT SUM(sfmj) AS sfmj FROM t_14 LIMIT 200 OFFSET 0"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 收费面积汇总","sqlEvaluation":{},"properties":{},"detailLimit":500,"metricLimit":200,"dataSetId":14}', 0);
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (54, 7, 1, '2026-04-15 12:55:16.093', '面积维度数据集查询面积数量最多的小区', 'admin', '{"id":1,"queryMode":"LLM_S2SQL","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"DETAIL","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false}],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"NONE","orders":[],"limit":500,"score":36.0,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"fullMatched":true,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"收费面积","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"收费面积汇总","frequency":100000,"llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"面积id","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"建筑面积汇总","frequency":100000,"llmMatched":false,"fullMatched":false,"inherited":false}],"sqlInfo":{"parsedS2SQL":"SELECT 面积ID AS _小区_\nFROM 面积维度数据集\nGROUP BY 面积ID\nORDER BY SUM(收费面积汇总) DESC\nLIMIT 1;","correctedS2SQL":"SELECT 面积ID AS _小区_\nFROM 面积维度数据集\nGROUP BY 面积ID\nORDER BY SUM(收费面积汇总) DESC\nLIMIT 1;","querySQL":"with t_14 as (SELECT `sfmj`, `id` AS `area_id`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT area_id AS `_小区_` FROM t_14 GROUP BY area_id ORDER BY SUM(sfmj) DESC LIMIT 1"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 收费面积汇总 **维度:** 面积ID","sqlEvaluation":{},"properties":{"sql_exemplar":{"question":"面积维度数据集查询面积数量最多的小区","sideInfo":"CurrentDate=[2026-04-15],DomainTerms=[<小区 COMMENT ''供热服务的小区或楼宇''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>,<采暖期 COMMENT ''供热季节周期，通常为当年11月至次年3月''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>]","dbSchema":"DatabaseType=[MYSQL], DatabaseVersion=[8.0], Table=[面积维度数据集], PartitionTimeField=[], PrimaryKeyField=[面积ID], Metrics=[<收费面积汇总 COMMENT ''收费面积汇总'' AGGREGATE ''SUM''>,<建筑面积汇总 COMMENT ''建筑面积汇总'' AGGREGATE ''SUM''>], Dimensions=[<面积ID DATATYPE ''BIGINT'' COMMENT ''面积ID''>], Values=[]","sql":"SELECT 面积ID AS _小区_\nFROM 面积维度数据集\nGROUP BY 面积ID\nORDER BY SUM(收费面积汇总) DESC\nLIMIT 1;","similarity":0.0},"type":"internal","CONTEXT":{"dataSetId":14,"llmReq":{"queryText":"面积维度数据集查询面积数量最多的小区","schema":{"databaseType":"MYSQL","databaseVersion":"8.0","dataSetId":14,"dataSetName":"面积维度数据集","metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false}],"values":[],"primaryKey":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false},"fieldNameList":["面积ID","建筑面积汇总","收费面积汇总"]},"terms":[{"name":"小区","description":"供热服务的小区或楼宇","alias":["楼宇","楼栋"]},{"name":"收费面积","description":"收取供热费用的建筑面积","alias":["供热面积","计费面积"]},{"name":"采暖期","description":"供热季节周期，通常为当年11月至次年3月","alias":["供暖季","供热季"]},{"name":"收费面积","description":"收取供热费用的建筑面积","alias":["供热面积","计费面积"]}],"currentDate":"2026-04-15","sqlGenType":"1_pass_self_consistency","chatAppConfig":{"MEMORY_REVIEW":{"name":"记忆启用评估","description":"通过大模型对记忆做正确性评估以决定是否启用","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and give your opinion.\n#Rules: \n1.ALWAYS follow the output format: `opinion=(POSITIVE|NEGATIVE),comment=(your comment)`.\n2.NO NEED to check date filters as the junior engineer seldom makes mistakes in this regard.\n#Question: %s\n#Schema: %s\n#SideInfo: %s\n#SQL: %s\n#Response: ","enable":true,"chatModelId":2},"REWRITE_MULTI_TURN":{"name":"多轮对话改写","description":"通过大模型根据历史对话来改写本轮对话","prompt":"#Role: You are a data product manager experienced in data requirements.#Task: Your will be provided with current and history questions asked by a user,along with their mapped schema elements(metric, dimension and value),please try understanding the semantics and rewrite a question.#Rules: 1.ALWAYS keep relevant entities, metrics, dimensions, values and date ranges.2.ONLY respond with the rewritten question.#Current Question: {{current_question}}#Current Mapped Schema: {{current_schema}}#History Question: {{history_question}}#History Mapped Schema: {{history_schema}}#History SQL: {{history_sql}}#Rewritten Question: ","enable":true,"chatModelId":2},"S2SQL_CORRECTOR":{"name":"语义SQL修正","description":"通过大模型对解析S2SQL做二次修正","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and help correct it if necessary.\n#Rules: 1.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.2.DO NOT calculate date range using functions.3.SQL columns and values must be mentioned in the `#Schema`.\n#Question:{{question}} #Schema:{{schema}} #InputSQL:{{sql}} #Response:","enable":true,"chatModelId":2},"SMALL_TALK":{"name":"闲聊对话","description":"直接将原始输入透传大模型","prompt":"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: %s\n#Current Input: %s\n#Response: ","enable":true,"chatModelId":2},"DATA_INTERPRETER":{"name":"结果数据解读","description":"通过大模型对结果数据做提炼总结","prompt":"#Role: You are a data expert who communicates with business users everyday.\n#Task: Your will be provided with a question asked by a user and the relevant result data queried from the databases, please interpret the data and organize a brief answer.\n#Rules: \n1.ALWAYS respond in the use the same language as the `#Question`.\n2.ALWAYS reference some key data in the `#Answer`.\n#Question:{{question}} #Data:{{data}} #Answer:","enable":true,"chatModelId":2},"PHYSICAL_SQL_CORRECTOR":{"name":"物理SQL修正","description":"通过大模型对物理SQL做性能优化","prompt":"#Role: You are a senior database performance optimization expert experienced in SQL tuning.\n\n#Task: You will be provided with a user question and the corresponding physical SQL query, please analyze and optimize this SQL to improve query performance.\n\n#Rules:\n1. DO NOT add or introduce any new fields, columns, or aliases that are not in the original SQL.\n2. Push WHERE conditions into JOIN ON clauses when possible to reduce intermediate result sets.\n3. Optimize JOIN order by placing smaller tables or tables with selective conditions first.\n4. For date range conditions, ensure they are applied as early as possible in the query execution.\n5. Remove or comment out database-specific index hints (like USE INDEX) that may cause syntax errors.\n6. ONLY modify the structure and order of existing elements, do not change field names or add new ones.\n7. Ensure the optimized SQL is syntactically correct and logically equivalent to the original.\n\n#Question: {{question}}\n\n#OriginalSQL: {{sql}}","enable":true,"chatModelId":2},"S2SQL_PARSER":{"name":"语义SQL解析","description":"通过大模型做语义解析生成S2SQL","prompt":"#Role: You are a data analyst experienced in SQL languages.\n#Task: You will be provided with a natural language question asked by users,please convert it to a SQL query so that relevant data could be returned by executing the SQL query against underlying database.\n#Rules:\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate.\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`.\n4.DO NOT calculate date range using functions.\n5.ALWAYS use `with` statement if nested aggregation is needed.\n6.ALWAYS enclose alias declared by `AS` command in underscores.\n7.Alias created by `AS` command must be in the same language ast the `Question`.\n#Exemplars: {{exemplar}}\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}","enable":true,"chatModelId":2},"REWRITE_ERROR_MESSAGE":{"name":"异常提示改写","description":"通过大模型将异常信息改写为更友好和引导性的提示用语","prompt":"#Role: You are a data business partner who closely interacts with business people.\n#Task: Your will be provided with user input, system output and some examples, please respond shortly to teach user how to ask the right question, by using `Examples` as references.#Rules: ALWAYS respond with the same language as the `Input`.\n#Input: {{user_question}}\n#Output: {{system_message}}\n#Examples: {{examples}}\n#Response: ","enable":true,"chatModelId":2}},"dynamicExemplars":[{"question":"过去半个月核心用户的访问次数","sideInfo":"CurrentDate=[2023-09-15],DomainTerms=[<核心用户 COMMENT ''用户为alice''>]","dbSchema":"DatabaseType=[h2], Table=[超音数产品], PartitionTimeField=[数据日期 FORMAT ''yyyy-MM-dd''], Metrics=[<访问次数 ALIAS ''pv'' COMMENT ''一段时间内用户的访问次数'' AGGREGATE ''SUM''>], Dimensions=[<部门>,<数据日期>], Values=[]","sql":"SELECT 用户,SUM(访问次数) FROM 超音数产品 WHERE 用户=''alice'' AND 数据日期 >= ''2023-09-01'' AND 数据日期 <= ''2023-09-15'' GROUP BY 用户","similarity":0.7444111448550921}]},"llmResp":{"query":"面积维度数据集查询面积数量最多的小区","sideInfo":"CurrentDate=[2026-04-15],DomainTerms=[<小区 COMMENT ''供热服务的小区或楼宇''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>,<采暖期 COMMENT ''供热季节周期，通常为当年11月至次年3月''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>]","dataSet":"面积维度数据集","schema":"DatabaseType=[MYSQL], DatabaseVersion=[8.0], Table=[面积维度数据集], PartitionTimeField=[], PrimaryKeyField=[面积ID], Metrics=[<收费面积汇总 COMMENT ''收费面积汇总'' AGGREGATE ''SUM''>,<建筑面积汇总 COMMENT ''建筑面积汇总'' AGGREGATE ''SUM''>], Dimensions=[<面积ID DATATYPE ''BIGINT'' COMMENT ''面积ID''>], Values=[]","sqlOutput":"SELECT 面积ID AS _小区_\nFROM 面积维度数据集\nGROUP BY 面积ID\nORDER BY SUM(收费面积汇总) DESC\nLIMIT 1;","sqlRespMap":{"SELECT 面积ID AS _小区_\nFROM 面积维度数据集\nGROUP BY 面积ID\nORDER BY SUM(收费面积汇总) DESC\nLIMIT 1;":{"sqlWeight":1.0,"fewShots":[{"question":"过去半个月核心用户的访问次数","sideInfo":"CurrentDate=[2023-09-15],DomainTerms=[<核心用户 COMMENT ''用户为alice''>]","dbSchema":"DatabaseType=[h2], Table=[超音数产品], PartitionTimeField=[数据日期 FORMAT ''yyyy-MM-dd''], Metrics=[<访问次数 ALIAS ''pv'' COMMENT ''一段时间内用户的访问次数'' AGGREGATE ''SUM''>], Dimensions=[<部门>,<数据日期>], Values=[]","sql":"SELECT 用户,SUM(访问次数) FROM 超音数产品 WHERE 用户=''alice'' AND 数据日期 >= ''2023-09-01'' AND 数据日期 <= ''2023-09-15'' GROUP BY 用户","similarity":0.7444111448550921}]}}}}},"dataSetId":14,"detailLimit":500,"metricLimit":200}', 0);
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (56, 7, 1, '2026-04-15 13:02:20.584', '面积维度数据集查询面积数量最多的小区', 'admin', '{"id":1,"queryMode":"METRIC_ORDERBY","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false}],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"MAX","orders":[{"column":"建筑面积汇总","direction":"DESC"}],"limit":200,"score":7.666666666666667,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"fullMatched":true,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"收费面积","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"收费面积汇总","frequency":100000,"llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"面积id","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"建筑面积汇总","frequency":100000,"llmMatched":false,"fullMatched":false,"inherited":false}],"sqlInfo":{"parsedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","correctedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","querySQL":"with t_14 as (SELECT `sfmj`, `id` AS `area_id`, `zdmj`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT area_id, SUM(zdmj) AS zdmj, SUM(sfmj) AS sfmj FROM t_14 GROUP BY area_id ORDER BY SUM(zdmj) DESC LIMIT 200 OFFSET 0"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 建筑面积汇总,收费面积汇总 **维度:** 面积ID","sqlEvaluation":{},"properties":{},"dataSetId":14,"detailLimit":500,"metricLimit":200}', 0);
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (58, 8, 1, '2026-04-15 13:47:51.232', '面积维度数据集查询面积数量最多的小区', 'admin', '{"id":1,"queryMode":"LLM_S2SQL","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"metrics":[],"dimensions":[],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"NONE","orders":[],"limit":500,"score":36.0,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"fullMatched":true,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"收费面积","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"收费面积汇总","frequency":100000,"llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"面积id","llmMatched":false,"fullMatched":false,"inherited":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"建筑面积汇总","frequency":100000,"llmMatched":false,"fullMatched":false,"inherited":false}],"sqlInfo":{"parsedS2SQL":"SELECT 小区, COUNT(面积ID) AS 面积数量\nFROM 面积维度数据集\nGROUP BY 小区\nORDER BY 面积数量 DESC\nLIMIT 1","correctedS2SQL":"SELECT 小区, COUNT(面积ID) AS 面积数量\nFROM 面积维度数据集\nGROUP BY 小区\nORDER BY 面积数量 DESC\nLIMIT 1","querySQL":"with t_14 as (SELECT `id` AS `area_id`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT 小区, COUNT(area_id) AS `面积数量` FROM t_14 GROUP BY 小区 ORDER BY `面积数量` DESC LIMIT 1"},"textInfo":"**数据集:** 面积维度数据集 ","sqlEvaluation":{},"properties":{"sql_exemplar":{"question":"面积维度数据集查询面积数量最多的小区","sideInfo":"CurrentDate=[2026-04-15],DomainTerms=[<小区 COMMENT ''供热服务的小区或楼宇''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>,<采暖期 COMMENT ''供热季节周期，通常为当年11月至次年3月''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>]","dbSchema":"DatabaseType=[MYSQL], DatabaseVersion=[8.0], Table=[面积维度数据集], PartitionTimeField=[], PrimaryKeyField=[面积ID], Metrics=[<收费面积汇总 COMMENT ''收费面积汇总'' AGGREGATE ''SUM''>,<建筑面积汇总 COMMENT ''建筑面积汇总'' AGGREGATE ''SUM''>], Dimensions=[<面积ID DATATYPE ''BIGINT'' COMMENT ''面积ID''>], Values=[]","sql":"SELECT 小区, COUNT(面积ID) AS 面积数量\nFROM 面积维度数据集\nGROUP BY 小区\nORDER BY 面积数量 DESC\nLIMIT 1","similarity":0.0},"type":"internal","CONTEXT":{"dataSetId":14,"llmReq":{"queryText":"面积维度数据集查询面积数量最多的小区","schema":{"databaseType":"MYSQL","databaseVersion":"8.0","dataSetId":14,"dataSetName":"面积维度数据集","metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false},{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","primaryKey":false,"partitionTime":false}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false}],"values":[],"primaryKey":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","primaryKey":true,"partitionTime":false},"fieldNameList":["面积ID","建筑面积汇总","收费面积汇总"]},"terms":[{"name":"小区","description":"供热服务的小区或楼宇","alias":["楼宇","楼栋"]},{"name":"收费面积","description":"收取供热费用的建筑面积","alias":["供热面积","计费面积"]},{"name":"采暖期","description":"供热季节周期，通常为当年11月至次年3月","alias":["供暖季","供热季"]},{"name":"收费面积","description":"收取供热费用的建筑面积","alias":["供热面积","计费面积"]}],"currentDate":"2026-04-15","sqlGenType":"1_pass_self_consistency","chatAppConfig":{"MEMORY_REVIEW":{"name":"记忆启用评估","description":"通过大模型对记忆做正确性评估以决定是否启用","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and give your opinion.\n#Rules: \n1.ALWAYS follow the output format: `opinion=(POSITIVE|NEGATIVE),comment=(your comment)`.\n2.NO NEED to check date filters as the junior engineer seldom makes mistakes in this regard.\n#Question: %s\n#Schema: %s\n#SideInfo: %s\n#SQL: %s\n#Response: ","enable":true,"chatModelId":2},"REWRITE_MULTI_TURN":{"name":"多轮对话改写","description":"通过大模型根据历史对话来改写本轮对话","prompt":"#Role: You are a data product manager experienced in data requirements.#Task: Your will be provided with current and history questions asked by a user,along with their mapped schema elements(metric, dimension and value),please try understanding the semantics and rewrite a question.#Rules: 1.ALWAYS keep relevant entities, metrics, dimensions, values and date ranges.2.ONLY respond with the rewritten question.#Current Question: {{current_question}}#Current Mapped Schema: {{current_schema}}#History Question: {{history_question}}#History Mapped Schema: {{history_schema}}#History SQL: {{history_sql}}#Rewritten Question: ","enable":true,"chatModelId":2},"S2SQL_CORRECTOR":{"name":"语义SQL修正","description":"通过大模型对解析S2SQL做二次修正","prompt":"#Role: You are a senior data engineer experienced in writing SQL.\n#Task: Your will be provided with a user question and the SQL written by a junior engineer,please take a review and help correct it if necessary.\n#Rules: 1.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.2.DO NOT calculate date range using functions.3.SQL columns and values must be mentioned in the `#Schema`.\n#Question:{{question}} #Schema:{{schema}} #InputSQL:{{sql}} #Response:","enable":false,"chatModelId":2},"SMALL_TALK":{"name":"闲聊对话","description":"直接将原始输入透传大模型","prompt":"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: %s\n#Current Input: %s\n#Response: ","enable":true,"chatModelId":2},"DATA_INTERPRETER":{"name":"结果数据解读","description":"通过大模型对结果数据做提炼总结","prompt":"#Role: You are a data expert who communicates with business users everyday.\n#Task: Your will be provided with a question asked by a user and the relevant result data queried from the databases, please interpret the data and organize a brief answer.\n#Rules: \n1.ALWAYS respond in the use the same language as the `#Question`.\n2.ALWAYS reference some key data in the `#Answer`.\n#Question:{{question}} #Data:{{data}} #Answer:","enable":true,"chatModelId":2},"PHYSICAL_SQL_CORRECTOR":{"name":"物理SQL修正","description":"通过大模型对物理SQL做性能优化","prompt":"#Role: You are a senior database performance optimization expert experienced in SQL tuning.\n\n#Task: You will be provided with a user question and the corresponding physical SQL query, please analyze and optimize this SQL to improve query performance.\n\n#Rules:\n1. DO NOT add or introduce any new fields, columns, or aliases that are not in the original SQL.\n2. Push WHERE conditions into JOIN ON clauses when possible to reduce intermediate result sets.\n3. Optimize JOIN order by placing smaller tables or tables with selective conditions first.\n4. For date range conditions, ensure they are applied as early as possible in the query execution.\n5. Remove or comment out database-specific index hints (like USE INDEX) that may cause syntax errors.\n6. ONLY modify the structure and order of existing elements, do not change field names or add new ones.\n7. Ensure the optimized SQL is syntactically correct and logically equivalent to the original.\n\n#Question: {{question}}\n\n#OriginalSQL: {{sql}}","enable":false,"chatModelId":2},"S2SQL_PARSER":{"name":"语义SQL解析","description":"通过大模型做语义解析生成S2SQL","prompt":"#Role: You are a data analyst experienced in SQL languages.\n#Task: You will be provided with a natural language question asked by users,please convert it to a SQL query so that relevant data could be returned by executing the SQL query against underlying database.\n#Rules:\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate.\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator.\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`.\n4.DO NOT calculate date range using functions.\n5.ALWAYS use `with` statement if nested aggregation is needed.\n6.ALWAYS enclose alias declared by `AS` command in underscores.\n7.Alias created by `AS` command must be in the same language ast the `Question`.\n#Exemplars: {{exemplar}}\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}","enable":true,"chatModelId":2},"REWRITE_ERROR_MESSAGE":{"name":"异常提示改写","description":"通过大模型将异常信息改写为更友好和引导性的提示用语","prompt":"#Role: You are a data business partner who closely interacts with business people.\n#Task: Your will be provided with user input, system output and some examples, please respond shortly to teach user how to ask the right question, by using `Examples` as references.#Rules: ALWAYS respond with the same language as the `Input`.\n#Input: {{user_question}}\n#Output: {{system_message}}\n#Examples: {{examples}}\n#Response: ","enable":true,"chatModelId":2}},"dynamicExemplars":[{"question":"过去半个月核心用户的访问次数","sideInfo":"CurrentDate=[2023-09-15],DomainTerms=[<核心用户 COMMENT ''用户为alice''>]","dbSchema":"DatabaseType=[h2], Table=[超音数产品], PartitionTimeField=[数据日期 FORMAT ''yyyy-MM-dd''], Metrics=[<访问次数 ALIAS ''pv'' COMMENT ''一段时间内用户的访问次数'' AGGREGATE ''SUM''>], Dimensions=[<部门>,<数据日期>], Values=[]","sql":"SELECT 用户,SUM(访问次数) FROM 超音数产品 WHERE 用户=''alice'' AND 数据日期 >= ''2023-09-01'' AND 数据日期 <= ''2023-09-15'' GROUP BY 用户","similarity":0.7444111448550921}]},"llmResp":{"query":"面积维度数据集查询面积数量最多的小区","sideInfo":"CurrentDate=[2026-04-15],DomainTerms=[<小区 COMMENT ''供热服务的小区或楼宇''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>,<采暖期 COMMENT ''供热季节周期，通常为当年11月至次年3月''>,<收费面积 COMMENT ''收取供热费用的建筑面积''>]","dataSet":"面积维度数据集","schema":"DatabaseType=[MYSQL], DatabaseVersion=[8.0], Table=[面积维度数据集], PartitionTimeField=[], PrimaryKeyField=[面积ID], Metrics=[<收费面积汇总 COMMENT ''收费面积汇总'' AGGREGATE ''SUM''>,<建筑面积汇总 COMMENT ''建筑面积汇总'' AGGREGATE ''SUM''>], Dimensions=[<面积ID DATATYPE ''BIGINT'' COMMENT ''面积ID''>], Values=[]","sqlOutput":"SELECT 小区, COUNT(面积ID) AS 面积数量\nFROM 面积维度数据集\nGROUP BY 小区\nORDER BY 面积数量 DESC\nLIMIT 1","sqlRespMap":{"SELECT 小区, COUNT(面积ID) AS 面积数量\nFROM 面积维度数据集\nGROUP BY 小区\nORDER BY 面积数量 DESC\nLIMIT 1":{"sqlWeight":1.0,"fewShots":[{"question":"过去半个月核心用户的访问次数","sideInfo":"CurrentDate=[2023-09-15],DomainTerms=[<核心用户 COMMENT ''用户为alice''>]","dbSchema":"DatabaseType=[h2], Table=[超音数产品], PartitionTimeField=[数据日期 FORMAT ''yyyy-MM-dd''], Metrics=[<访问次数 ALIAS ''pv'' COMMENT ''一段时间内用户的访问次数'' AGGREGATE ''SUM''>], Dimensions=[<部门>,<数据日期>], Values=[]","sql":"SELECT 用户,SUM(访问次数) FROM 超音数产品 WHERE 用户=''alice'' AND 数据日期 >= ''2023-09-01'' AND 数据日期 <= ''2023-09-15'' GROUP BY 用户","similarity":0.7444111448550921}]}}}}},"dataSetId":14,"detailLimit":500,"metricLimit":200}', 0);
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (59, 8, 1, '2026-04-15 15:04:37.666', '面积维度数据集查询面积数量最多的小区', 'admin', '{"id":1,"queryMode":"METRIC_ORDERBY","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","partitionTime":false,"primaryKey":true}],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"MAX","orders":[{"column":"建筑面积汇总","direction":"DESC"}],"limit":200,"score":7.666666666666667,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"建筑面积汇总","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"收费面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"收费面积汇总","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","partitionTime":false,"primaryKey":true},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"面积id","llmMatched":false,"inherited":false,"fullMatched":false}],"sqlInfo":{"parsedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","correctedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","querySQL":"with t_14 as (SELECT `sfmj`, `id` AS `area_id`, `zdmj`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT area_id, SUM(zdmj) AS zdmj, SUM(sfmj) AS sfmj FROM t_14 GROUP BY area_id ORDER BY SUM(zdmj) DESC LIMIT 200 OFFSET 0"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 建筑面积汇总,收费面积汇总 **维度:** 面积ID","sqlEvaluation":{},"properties":{},"detailLimit":500,"metricLimit":200,"dataSetId":14}', 0);
INSERT INTO "heating_analytics"."s2_chat_parse" VALUES (69, 13, 1, '2026-04-16 00:07:58.827', '哪个小区收费率高？', 'admin', '{"id":1,"queryMode":"METRIC_MODEL","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false}],"dimensions":[],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"NONE","orders":[],"limit":200,"score":2.666666666666667,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":18,"name":"应收金额","bizName":"应收金额","useCnt":0,"type":"TERM","alias":["应收费","应收热费"],"order":0.0,"isTag":0,"description":"应当收取的热费金额","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"应收热费","word":"应收热费","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":13,"name":"收费率","bizName":"收费率","useCnt":0,"type":"TERM","alias":["收缴率"],"order":0.0,"isTag":0,"description":"实际收取的热费与应收热费的比率，反映收费效率","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"收费率","word":"收费率","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":13,"name":"收费率","bizName":"收费率","useCnt":0,"type":"TERM","alias":["收缴率"],"order":0.33333333333333326,"isTag":0,"description":"实际收取的热费与应收热费的比率，反映收费效率","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"收费","word":"收费率","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":25,"name":"费用类别","bizName":"费用类别","useCnt":0,"type":"TERM","alias":["收费类型"],"order":0.5,"isTag":0,"description":"热费和其他费用的分类","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费类型","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":26,"name":"收费笔数","bizName":"收费笔数","useCnt":0,"type":"TERM","alias":["收费次数","交费笔数"],"order":0.5,"isTag":0,"description":"收费记录的数量","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费笔数","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"收费","word":"收费面积汇总","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":17,"name":"实收金额","bizName":"实收金额","useCnt":0,"type":"TERM","alias":["已收热费","收费金额"],"order":0.5,"isTag":0,"description":"实际收取的热费金额","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费金额","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTime":false,"partitionTimeFormat":"","primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"收费","word":"收费面积","llmMatched":false,"inherited":false,"fullMatched":false}],"sqlInfo":{"parsedS2SQL":"(SELECT SUM(收费面积汇总) FROM `面积维度数据集` LIMIT 200 OFFSET 0)","correctedS2SQL":"(SELECT SUM(收费面积汇总) FROM `面积维度数据集` LIMIT 200 OFFSET 0)","querySQL":"with t_14 as (SELECT `sfmj`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT SUM(sfmj) AS sfmj FROM t_14 LIMIT 200 OFFSET 0"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 收费面积汇总","sqlEvaluation":{},"properties":{},"metricLimit":200,"detailLimit":500,"dataSetId":14}', 0);

-- ----------------------------
-- Table structure for s2_chat_query
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_query";
CREATE TABLE "heating_analytics"."s2_chat_query" (
  "question_id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_chat_query_question_id_seq'::regclass),
  "agent_id" int4,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "query_text" text COLLATE "pg_catalog"."default",
  "user_name" varchar(150) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_state" int2,
  "chat_id" int8 NOT NULL,
  "query_result" text COLLATE "pg_catalog"."default",
  "score" int4 DEFAULT 0,
  "feedback" varchar(1024) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "similar_queries" varchar(1024) COLLATE "pg_catalog"."default" DEFAULT ''::character varying,
  "parse_time_cost" varchar(1024) COLLATE "pg_catalog"."default" DEFAULT ''::character varying
)
;

-- ----------------------------
-- Records of s2_chat_query
-- ----------------------------
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (1, 1, '2026-04-13 15:17:24.565', '各公司员工都有多少人', 'admin', 1, 1, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (2, 3, '2026-04-13 15:26:37.618', '如何才能变帅', 'admin', 1, 3, '{"queryMode":"PLAIN_TEXT","queryState":"SUCCESS","textResult":"变帅可以从多个方面入手哦！首先，保持良好的个人卫生和护理，比如定期洗头、修剪指甲和保持皮肤清洁。其次，选择适合自己的服装风格，穿着得体可以提升整体形象。此外，锻炼身体、保持健康的饮食习惯也能让你看起来更有精神。最后，自信的态度和微笑是最重要的哦！加油！"}', 0, '', '', '{"parseStartTime":1776065197625,"parseTime":4,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (3, 4, '2026-04-13 22:25:12.361', '哪个小区收费率高？', 'admin', 1, -1, '{}', 0, '', '[]', '{"parseStartTime":1776090312910,"parseTime":26913,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (4, 4, '2026-04-13 22:25:27.822', '哪个小区收费率高？', 'admin', 0, 4, '{}', 0, '', '[]', '{"parseStartTime":1776090327850,"parseTime":29249,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (5, 4, '2026-04-13 22:28:05.275', '哪个小区收费率高？', 'admin', 1, -1, '{}', 0, '', '[]', '{"parseStartTime":1776090485301,"parseTime":33735,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (6, 4, '2026-04-13 22:28:36.035', '哪个小区收费率高？', 'admin', 0, 4, '{}', 0, '', '[]', '{"parseStartTime":1776090516303,"parseTime":24917,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (7, 4, '2026-04-13 22:30:04.726', '哪个小区收费率高？', 'admin', 1, -1, '{}', 0, '', '[]', '{"parseStartTime":1776090604753,"parseTime":29398,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (8, 4, '2026-04-13 22:31:38.383', '哪个小区收费率高？', 'admin', 1, 4, '{}', 0, '', '[]', '{"parseStartTime":1776090707646,"parseTime":15431,"sqlTime":1241}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (9, 4, '2026-04-13 22:32:59.593', '2025年收费率前3的小区名称', 'admin', 1, 4, '{}', 0, '', '[]', '{"parseStartTime":1776090780046,"parseTime":14550,"sqlTime":335}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (10, 4, '2026-04-13 22:33:44.985', '2025年哪些小区收费率最高？', 'admin', 0, 4, '{}', 0, '', '[]', '{"parseStartTime":1776090839298,"parseTime":24235,"sqlTime":351}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (11, 3, '2026-04-13 23:15:25.689', '你好，你是什么模型？', 'admin', 1, 3, '{"queryMode":"PLAIN_TEXT","queryState":"SUCCESS","textResult":"你好！我是一个聊天模型，旨在帮助你解答问题和提供信息。有什么我可以帮你的吗？"}', 0, '', '[]', '{"parseStartTime":1776093325925,"parseTime":65,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (12, 3, '2026-04-13 23:16:28.273', '你好，你是什么大模型？版本号？', 'admin', 1, 3, '{"queryMode":"PLAIN_TEXT","queryState":"SUCCESS","textResult":"<think>\nThe user says: \"#Role: You are a nice person to talk to.\n#Task: Respond quickly and nicely to the user.\n#Rules: 1.ALWAYS use the same language as the `#Current Input`.\n#History Inputs: 如何才能变帅;你好，你是什么模型？,\n#Current Input: 你好，你是什么大模型？版本号？\"\n\nThus the user asks in Chinese: \"你好，你是什么大模型？版本号？\". They ask: \"Hello, what large model are you? Version number?\" We have to respond quickly and nicely, in Chinese. The user wants version number. As an assistant, we must answer based on the system. We have to follow the \"Policy\". There is no policy that prohibits us from disclosing model name and version. The system messages earlier: The developer said there is no developer message. So we can respond: \"你好！我是 MiniMax-M2.7 的大语言模型...\".\n\nWe should answer the question: The model is \"MiniMax-M2.7\". Is there any policy about version numbers? The developer message says \"You are a helpful assistant.\" There''s no rule restricting disclosure of model identity. The user is asking in Chinese. We respond in Chinese. Provide version number: likely \"M2.7\". Also mention details: it''s a large language model developed by MiniMax.\n\nWe should keep response short, friendly, in Chinese. The user wants the version number. So answer: \"我是 MiniMax-M2.7 版本\". Possibly include \"语言模型\" or \"大模型\". I might also ask if they need anything else.\n\nThus final answer: \"你好！我是 MiniMax-M2.7 大模型，当前版本号是 M2.7 ...\". Also maybe ask for other queries.\n\nWe have to ensure no extra info beyond what''s allowed. There''s no restriction.\n\nThus answer.\n</think>\n\n你好！我是 **MiniMax‑M2.7** 大语言模型，当前版本号就是 **M2.7**。如果你还有其他想了解的，随时告诉我哦！"}', 0, '', '[]', '{"parseStartTime":1776093388301,"parseTime":64,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (13, 3, '2026-04-13 23:17:14.768', '你好，你是什么大模型？版本号？', 'admin', 1, 5, '{"queryMode":"PLAIN_TEXT","queryState":"SUCCESS","textResult":"<think>\n用户用中文问我是什么大模型和版本号。根据我的系统提示，我是MiniMax-M2.7。我需要用中文回复，保持友好和快速。\n\n让我回应：\n1. 介绍自己是MiniMax-M2.7\n2. 保持友好语气\n3. 简洁回答\n</think>\n\n你好呀！😊\n\n我是 **MiniMax-M2.7**，是由 MiniMax 公司开发的 AI 助手～\n\n很高兴认识你！有什么我可以帮你的吗？🌟"}', 0, '', '[]', '{"parseStartTime":1776093434802,"parseTime":72,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (14, 3, '2026-04-13 23:23:24.607', '你好，你是什么大模型？版本号？', 'admin', 1, 5, '{"queryMode":"PLAIN_TEXT","queryState":"SUCCESS","textResult":"<think>\nThe user is speaking Chinese. The instructions: \"ALWAYS use the same language as the `#Current Input`.\" The current input is \"你好，你是什么大模型？版本号？\" So we must respond in Chinese.\n\nThe user asks: \"你好，你是什么大模型？版本号？\" They ask what big model am I? version number?\n\nWe need to respond accordingly. We need to identify as MiniMax-M3 (the system description says \"MiniMax-M2.7\"? Wait: The system says \"You are MiniMax-M2.7, a helpful AI assistant built by MiniMax. Knowledge cutoff: 2025-06.\" The assistant''s identity is MiniMax-M2.7. Actually the system says we are \"MiniMax-M2.7\". The user asks \"你是什么大模型？版本号？\". So answer: I''m MiniMax''s large language model, specifically the MiniMax-M2.7 version. Should mention we are a large language model built by MiniMax, with knowledge up to June 2025.\n\nMake response friendly, short.\n\nWe must follow the role: nice person to talk to. Respond quickly.\n\nThus answer: \"你好！我是 MiniMax 的大语言模型，版本号是 MiniMax-M2.7，训练数据截至 2025 年 6 月。有什么我可以帮你的吗？\"\n\nWe can optionally mention that we are a \"大模型\" and version. That is it.\n\nWe''ll be mindful not to mention policy or internal meta.\n\nWe should keep to Chinese. Use same language.\n\nProceed.\n</think>\n\n你好！我是 **MiniMax** 的大语言模型，版本号是 **MiniMax‑M2.7**，知识截止到 2025 年 6 月。有什么我可以帮你的吗？😊"}', 0, '', '[]', '{"parseStartTime":1776093804634,"parseTime":65,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (15, 4, '2026-04-13 23:31:43.859', '2025年哪些小区收费率最高？', 'admin', 0, 4, '{}', 0, '', '[]', '{"parseStartTime":1776094319849,"parseTime":14814,"sqlTime":628}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (16, 4, '2026-04-13 23:47:29.547', '2025年哪些小区收费率最高？', 'admin', 1, 4, '{}', 0, '', '[]', '{"parseStartTime":1776095265145,"parseTime":5957,"sqlTime":321}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (17, 4, '2026-04-13 23:48:32.986', '查询2025年收费率排名前10的小区，包括小区名称、收费率和收费总额', 'admin', 1, 4, '{}', 0, '', '[]', '{"parseStartTime":1776095313420,"parseTime":11928,"sqlTime":331}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (18, 3, '2026-04-14 13:22:50.949', '如何才能变帅', 'admin', 1, 6, '{"queryMode":"PLAIN_TEXT","queryState":"SUCCESS","textResult":"<think>\nThe user is speaking Chinese (Simplified) \"如何才能变帅\". They ask: \"How can I become more handsome?\" They likely want advice. The instruction is: always use the same language as #Current Input, which is Chinese (Simplified). So respond in Chinese, with nice tone, quick. Possibly give advice about grooming, fitness, style, confidence. We can talk about skincare, haircut, clothing, posture, exercise, diet, confidence, personality. Keep it friendly, supportive. Use Chinese.\n\nWe must comply with policy. There''s no disallowed content. It''s a general self-improvement advice. Fine. Provide suggestions.\n\nCheck for any hidden request for extremist, etc. No. Good.\n\nThe user says: \"如何才能变帅\". So respond with Chinese. We''ll include steps: skin care, hair, facial hair, dressing, posture, confidence, grooming habits, health, exercise, diet, sleep, maybe reading. Also mention that inner confidence and personality matter. Encourage positivity. Also mention that attractiveness is subjective. Offer supportive language.\n\nWe must respond quickly and nicely.\n\nThus: Provide bullet points or paragraphs. Use simple Chinese. Provide suggestions.\n\nMake sure it''s not too long but comprehensive. Good.\n\nNow produce answer.\n</think>\n\n想要让自己看起来更帅，可以从以下几个方面入手，既能提升外在形象，也能增强内在气质：\n\n### 1. 基础护理——皮肤与清洁\n- **每天洁面**：早晚用温和的洁面产品清洁面部，避免油脂堆积导致痘痘。\n- **保湿**：根据肤质选择合适的保湿霜，保持皮肤水润。\n- **防晒**：日常外出使用防晒霜，防止紫外线导致肤色暗沉和细纹。\n- **定期去角质**：每周1‑2次，帮助去除老废角质，让皮肤更光滑。\n\n### 2. 发型与发质\n- **找到适合自己的发型**：咨询专业理发师，依据脸型、发质选择合适的造型。\n- **保持头发健康**：定期修剪、使用护发素或发膜，避免使用过热的吹风机和直板夹。\n- **简洁自然**：不必追求过于复杂的造型，干净利落的短发或稍微打理的中长发往往更有精神。\n\n### 3. 面部护理与仪容\n- **眉毛**：保持眉毛整洁、形状清晰，可适当修整或使用眉笔填补。\n- **口腔护理**：每天刷牙、使用牙线，定期洗牙，保持清新口气。\n- **指甲**：修剪整齐，保持手部清洁，细节能体现整体品味。\n\n### 4. 穿衣打扮\n- **合体的剪裁**：衣服不必最贵，但一定要合身，尤其是肩线和腰线。\n- **基础单品**：白衬衫、黑色或深蓝色牛仔裤、简约皮鞋、干净的运动鞋都是百搭之选。\n- **颜色搭配**：避免过多花纹或过于花哨的颜色，保持简洁大方的配色即可。\n- **配饰**：适量的手表、皮带或简约的项链可以提升整体层次感，但不要过度。\n\n### 5. 体型与姿态\n- **规律运动**：每周进行3‑4次有氧（跑步、骑行）和力量训练，帮助塑形、提升气色。\n- **均衡饮食**：多摄入蛋白质、蔬菜水果，少吃高糖高脂食品，保持体重在健康范围。\n- **挺胸抬头**：站立和行走时保持背部挺直，肩部放松，给人自信的感觉。\n\n### 6. 内在气质\n- **自信**：自信是最好的“化妆品”。可以通过练习公开演讲、设定小目标并逐步完成来提升。\n- **微笑**：自然、温暖的微笑会让人觉得你更有亲和力。\n- **礼貌与尊重**：与人为善、倾听他人，展现良好的情商和教养，这些都会让你更有魅力。\n- **兴趣爱好**：培养一两项兴趣（阅读、运动、音乐等），让自己拥有丰富的谈资，提升个人魅力。\n\n### 7. 生活习惯\n- **充足睡眠**：每晚7‑9小时，保持皮肤恢复和精力充沛。\n- **多喝水**：每天约2‑3升水，帮助体内代谢，保持皮肤弹性。\n- **减少烟酒**：戒烟限酒对皮肤和整体健康都有显著改善。\n\n---\n\n**小贴士**：  \n- **持之以恒**：外在改变往往需要一段时间才能看到明显效果，保持良好的日常习惯才是关键。  \n- **不必追求完美**：每个人都有独特的魅力点，找到最适合自己的风格，而不是盲目模仿他人。  \n- **自我肯定**：帅不只在外表，内心的自信与积极向上的生活态度同样会为你加分。\n\n希望这些建议能帮助你从细节做起，逐步提升自己的整体形象和气质。祝你越来越有魅力！😊"}', 0, '', '[]', '{"parseStartTime":1776144171064,"parseTime":326,"sqlTime":0}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (19, 4, '2026-04-14 13:23:31.447', '哪个小区收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (20, 4, '2026-04-14 13:32:23.69', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (21, 4, '2026-04-14 13:32:32.152', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (22, 4, '2026-04-14 13:32:44.544', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (23, 4, '2026-04-14 13:32:46.788', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (24, 4, '2026-04-14 13:32:49.154', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (25, 4, '2026-04-14 13:32:51.445', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (26, 4, '2026-04-14 13:32:53.325', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (27, 4, '2026-04-14 13:32:55.324', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (28, 4, '2026-04-14 13:32:58.241', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (29, 4, '2026-04-14 13:33:00.14', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (30, 4, '2026-04-14 13:33:01.99', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (31, 4, '2026-04-14 13:33:31.892', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (32, 4, '2026-04-14 13:33:35.324', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (33, 4, '2026-04-14 13:33:37.944', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (34, 4, '2026-04-14 13:33:40.285', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (35, 4, '2026-04-14 13:33:42.118', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (36, 4, '2026-04-14 13:33:43.999', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (37, 4, '2026-04-14 13:33:45.822', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (38, 4, '2026-04-14 13:33:47.622', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (39, 4, '2026-04-14 13:33:49.443', '哪个分公司收费率高？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (40, 4, '2026-04-14 13:35:43.705', '收费总额是多少？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (41, 4, '2026-04-14 13:35:53.222', '收费总额是多少？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (42, 4, '2026-04-14 13:35:59.795', '收费总额是多少？', 'admin', 0, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (43, 4, '2026-04-14 13:36:09.823', '收费总额是多少？', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (44, 4, '2026-04-14 15:05:56.102', '查询2025年收费率排名前10的小区', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (45, 4, '2026-04-14 15:22:33.875', '查询2025年收费率排名前10的小区', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (46, 4, '2026-04-14 16:30:56.3', '查询2025年收费率排名前10的小区', 'admin', 1, 7, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (48, 4, '2026-04-15 09:18:16.635', '查询欠费金额最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776215902966,"parseTime":171902,"sqlTime":2231}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (55, 4, '2026-04-15 12:56:26.458', '哪个小区收费率高？', 'admin', 1, -1, '{}', 0, '', '[]', '{"parseStartTime":1776229000748,"parseTime":83381,"sqlTime":2227}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (47, 4, '2026-04-15 09:14:13.922', '查询2025年收费率排名前10的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776215686723,"parseTime":469393,"sqlTime":3267}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (60, 4, '2026-04-15 21:02:59.324', '用户维度数据集查询本采暖期缴费用户数量', 'admin', 1, 9, '{}', 0, '', '[]', '{"parseStartTime":1776258189932,"parseTime":131971,"sqlTime":2628}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (49, 4, '2026-04-15 10:47:40.622', '查询用户数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776221312495,"parseTime":138186,"sqlTime":2645}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (56, 4, '2026-04-15 12:56:44.5', '面积维度数据集查询面积数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776229108228,"parseTime":232356,"sqlTime":2245}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (50, 4, '2026-04-15 10:57:57.157', '查询用户数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776221950104,"parseTime":146240,"sqlTime":2694}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (51, 4, '2026-04-15 11:22:31.767', '查询用户数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776223402994,"parseTime":156062,"sqlTime":1969}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (52, 4, '2026-04-15 11:50:44.636', '查询用户数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776225084087,"parseTime":205853,"sqlTime":2598}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (57, 4, '2026-04-15 13:17:00.159', '面积维度数据集查询面积数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776230312197,"parseTime":165372,"sqlTime":2213}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (53, 4, '2026-04-15 12:42:21.143', '查询用户数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776228188136,"parseTime":273629,"sqlTime":3666}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (54, 4, '2026-04-15 12:48:29.838', '面积维度数据集查询面积数量最多的小区', 'admin', 1, 7, '{}', 0, '', '[]', '{"parseStartTime":1776228662597,"parseTime":253495,"sqlTime":3373}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (58, 4, '2026-04-15 13:44:57.48', '面积维度数据集查询面积数量最多的小区', 'admin', 1, 8, '{}', 0, '', '[]', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (61, 4, '2026-04-15 21:25:21.821', '用户维度数据集查询本采暖期缴费用户数量', 'admin', 1, 11, '{}', 0, '', '[]', '{"parseStartTime":1776259531119,"parseTime":212368,"sqlTime":3201}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (62, 4, '2026-04-15 21:37:14.86', '用户维度数据集查询本采暖期缴费用户数量', 'admin', 1, 11, '{}', 0, '', '', '');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (59, 4, '2026-04-15 15:02:50.655', '面积维度数据集查询面积数量最多的小区', 'admin', 1, 8, '{"queryId":59,"queryMode":"METRIC_ORDERBY","querySql":"with t_14 as (SELECT `sfmj`, `id` AS `area_id`, `zdmj`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT area_id, SUM(zdmj) AS zdmj, SUM(sfmj) AS sfmj FROM t_14 GROUP BY area_id ORDER BY SUM(zdmj) DESC LIMIT 200 OFFSET 0","queryState":"SUCCESS","queryColumns":[{"name":"面积ID","type":"BIGINT","bizName":"area_id","nameEn":"area_id","showType":"CATEGORY","authorized":true,"modelId":24},{"name":"建筑面积汇总","type":"DECIMAL","bizName":"zdmj","nameEn":"zdmj","showType":"NUMBER","authorized":true,"modelId":24},{"name":"收费面积汇总","type":"DECIMAL","bizName":"sfmj","nameEn":"sfmj","showType":"NUMBER","authorized":true,"modelId":24}],"chatContext":{"id":1,"queryMode":"METRIC_ORDERBY","queryConfig":{"detailTypeDefaultConfig":{"timeDefaultConfig":{"unit":1,"period":"DAY","timeMode":"LAST"},"limit":500},"aggregateTypeDefaultConfig":{"timeDefaultConfig":{"unit":7,"period":"DAY","timeMode":"RECENT"},"limit":200}},"queryType":"AGGREGATE","dataSet":{"dataSetId":14,"dataSetName":"面积维度数据集","id":14,"name":"面积维度数据集","bizName":"sf_dim_area_ds","type":"DATASET","order":0.0,"isTag":0,"description":"供热面积维度数据集","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"metrics":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.0,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false}],"dimensions":[{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.0,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","partitionTime":false,"primaryKey":true}],"dimensionFilters":[],"metricFilters":[],"filterType":"AND","aggType":"MAX","orders":[{"column":"建筑面积汇总","direction":"DESC"}],"limit":200,"score":7.666666666666667,"elementMatches":[{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":23,"name":"小区","bizName":"小区","useCnt":0,"type":"TERM","alias":["楼宇","楼栋"],"order":0.0,"isTag":0,"description":"供热服务的小区或楼宇","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":1.0,"detectWord":"小区","word":"小区","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":true},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"供热","word":"供热面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":15,"name":"采暖期","bizName":"采暖期","useCnt":0,"type":"TERM","alias":["供暖季","供热季"],"order":0.33333333333333326,"isTag":0,"description":"供热季节周期，通常为当年11月至次年3月","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.6666666666666667,"detectWord":"供热","word":"供热季","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":51,"name":"建筑面积汇总","bizName":"zdmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"建筑面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"建筑面积汇总","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":-1,"id":16,"name":"收费面积","bizName":"收费面积","useCnt":0,"type":"TERM","alias":["供热面积","计费面积"],"order":0.5,"isTag":0,"description":"收取供热费用的建筑面积","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"收费面积","llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":50,"name":"收费面积汇总","bizName":"sfmj","useCnt":0,"type":"METRIC","alias":[],"relatedSchemaElements":[],"defaultAgg":"SUM","order":0.6666666666666666,"isTag":0,"description":"收费面积汇总","extInfo":{},"partitionTimeFormat":"","partitionTime":false,"primaryKey":false},"offset":0.0,"similarity":0.33333333333333337,"detectWord":"面积","word":"收费面积汇总","frequency":100000,"llmMatched":false,"inherited":false,"fullMatched":false},{"element":{"dataSetId":14,"dataSetName":"面积维度数据集","model":24,"id":71,"name":"面积ID","bizName":"area_id","useCnt":0,"type":"DIMENSION","alias":[],"schemaValueMaps":[],"order":0.5,"isTag":0,"description":"面积ID","extInfo":{"dimension_type":"primary_key","dimension_data_type":"BIGINT"},"partitionTimeFormat":"","partitionTime":false,"primaryKey":true},"offset":0.0,"similarity":0.5,"detectWord":"面积","word":"面积id","llmMatched":false,"inherited":false,"fullMatched":false}],"sqlInfo":{"parsedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","correctedS2SQL":"(SELECT 面积ID, MAX(建筑面积汇总), MAX(收费面积汇总) FROM `面积维度数据集` GROUP BY 面积ID ORDER BY 建筑面积汇总 DESC LIMIT 200 OFFSET 0)","querySQL":"with t_14 as (SELECT `sfmj`, `id` AS `area_id`, `zdmj`\r\nFROM\r\narea\r\nWHERE `zf` = 0)\nSELECT area_id, SUM(zdmj) AS zdmj, SUM(sfmj) AS sfmj FROM t_14 GROUP BY area_id ORDER BY SUM(zdmj) DESC LIMIT 200 OFFSET 0"},"textInfo":"**数据集:** 面积维度数据集  **指标:** 建筑面积汇总,收费面积汇总 **维度:** 面积ID","sqlEvaluation":{},"properties":{},"detailLimit":500,"metricLimit":200,"dataSetId":14},"queryResults":[{"area_id":4669629171791941,"zdmj":4833.000,"sfmj":4833.000},{"area_id":4669629175992166,"zdmj":3500.000,"sfmj":3500.000},{"area_id":4669653494615049,"zdmj":3482.800,"sfmj":3482.800},{"area_id":4669653494615033,"zdmj":3302.350,"sfmj":3302.350},{"area_id":4669653494615041,"zdmj":3223.400,"sfmj":3223.400},{"area_id":4669626693134508,"zdmj":3000.000,"sfmj":3000.000},{"area_id":4669626693131685,"zdmj":2913.240,"sfmj":2913.240},{"area_id":4669629171791926,"zdmj":2184.000,"sfmj":2184.000},{"area_id":4669653494615064,"zdmj":2136.030,"sfmj":2136.030},{"area_id":4669653494615080,"zdmj":2116.250,"sfmj":2116.250},{"area_id":4669636419531852,"zdmj":1939.060,"sfmj":1939.060},{"area_id":4669626693134492,"zdmj":1800.000,"sfmj":1800.000},{"area_id":4669636419531843,"zdmj":1732.000,"sfmj":1732.000},{"area_id":4669625967475563,"zdmj":1698.640,"sfmj":1698.640},{"area_id":4669629175992184,"zdmj":1661.450,"sfmj":1661.450},{"area_id":4669625581562408,"zdmj":1533.750,"sfmj":1533.750},{"area_id":4669640085395335,"zdmj":1532.000,"sfmj":1021.340},{"area_id":4669625136936642,"zdmj":1500.000,"sfmj":1500.000},{"area_id":4669640089602101,"zdmj":1497.300,"sfmj":1497.300},{"area_id":4669626693134525,"zdmj":1125.000,"sfmj":1125.000},{"area_id":4669629171788075,"zdmj":1043.500,"sfmj":1043.500},{"area_id":4854922084614146,"zdmj":1043.500,"sfmj":1043.500},{"area_id":4963932402089989,"zdmj":1029.360,"sfmj":1029.360},{"area_id":1432819254578642944,"zdmj":1012.820,"sfmj":1012.820},{"area_id":4669636419531875,"zdmj":980.000,"sfmj":980.000},{"area_id":4669636419531834,"zdmj":964.320,"sfmj":964.320},{"area_id":4669636419531819,"zdmj":964.320,"sfmj":964.320},{"area_id":4838271444320260,"zdmj":946.050,"sfmj":946.050},{"area_id":4669624298057110,"zdmj":934.560,"sfmj":934.560},{"area_id":4838271641452554,"zdmj":923.190,"sfmj":923.190},{"area_id":4669653494614828,"zdmj":905.270,"sfmj":905.270},{"area_id":4971957519122551,"zdmj":816.000,"sfmj":816.000},{"area_id":4669627016130427,"zdmj":788.930,"sfmj":788.930},{"area_id":1046436913621237841,"zdmj":768.670,"sfmj":768.670},{"area_id":4669626693135450,"zdmj":737.560,"sfmj":737.560},{"area_id":4669626693135445,"zdmj":733.090,"sfmj":733.090},{"area_id":4669629171791957,"zdmj":730.000,"sfmj":730.000},{"area_id":4701258661494791,"zdmj":720.890,"sfmj":720.890},{"area_id":4704542549868568,"zdmj":708.490,"sfmj":708.490},{"area_id":4669626693134502,"zdmj":672.000,"sfmj":672.000},{"area_id":4669657303068731,"zdmj":664.670,"sfmj":624.790},{"area_id":4669657303068708,"zdmj":656.720,"sfmj":617.320},{"area_id":4669625967474568,"zdmj":641.640,"sfmj":603.140},{"area_id":4669625967474579,"zdmj":641.640,"sfmj":603.140},{"area_id":4701259336777740,"zdmj":627.630,"sfmj":627.630},{"area_id":4669627016130414,"zdmj":627.260,"sfmj":627.260},{"area_id":4669640089602061,"zdmj":565.000,"sfmj":565.000},{"area_id":4669657298849275,"zdmj":554.300,"sfmj":554.300},{"area_id":4669625581562514,"zdmj":543.070,"sfmj":543.070},{"area_id":4669657298853291,"zdmj":534.050,"sfmj":534.050},{"area_id":4669657298851540,"zdmj":532.460,"sfmj":532.460},{"area_id":4669640089616520,"zdmj":523.370,"sfmj":523.370},{"area_id":4669657303067646,"zdmj":523.070,"sfmj":523.070},{"area_id":4971263143706631,"zdmj":510.670,"sfmj":510.670},{"area_id":1046436913621237842,"zdmj":503.060,"sfmj":503.060},{"area_id":4669629175992196,"zdmj":497.100,"sfmj":497.100},{"area_id":4669625581562427,"zdmj":495.920,"sfmj":495.920},{"area_id":4669625967475581,"zdmj":488.930,"sfmj":488.930},{"area_id":4669640089615547,"zdmj":457.560,"sfmj":457.560},{"area_id":4669640089602202,"zdmj":454.000,"sfmj":454.000},{"area_id":4669626693131676,"zdmj":450.000,"sfmj":450.000},{"area_id":4669625136926636,"zdmj":438.120,"sfmj":438.120},{"area_id":1046436913617043527,"zdmj":427.070,"sfmj":427.070},{"area_id":4669657298853298,"zdmj":415.800,"sfmj":415.800},{"area_id":4669657298851553,"zdmj":414.560,"sfmj":414.560},{"area_id":4669640089615629,"zdmj":408.170,"sfmj":408.170},{"area_id":4669625581562423,"zdmj":400.640,"sfmj":400.640},{"area_id":4669626693124214,"zdmj":396.970,"sfmj":396.970},{"area_id":4669626693124208,"zdmj":396.970,"sfmj":396.970},{"area_id":4669627292961326,"zdmj":396.970,"sfmj":396.970},{"area_id":4669636419536467,"zdmj":396.970,"sfmj":396.970},{"area_id":4669640089602133,"zdmj":391.000,"sfmj":391.000},{"area_id":4669657303068718,"zdmj":366.100,"sfmj":344.100},{"area_id":4669622293123973,"zdmj":353.070,"sfmj":353.070},{"area_id":4669629171788091,"zdmj":336.000,"sfmj":336.000},{"area_id":4669640089615522,"zdmj":336.000,"sfmj":336.000},{"area_id":4669640089615539,"zdmj":332.400,"sfmj":332.400},{"area_id":4971957519122540,"zdmj":330.000,"sfmj":330.000},{"area_id":4669625581562436,"zdmj":329.980,"sfmj":329.980},{"area_id":4669626693131311,"zdmj":328.440,"sfmj":328.440},{"area_id":4669626693135460,"zdmj":327.270,"sfmj":327.270},{"area_id":4709622892199944,"zdmj":317.400,"sfmj":317.400},{"area_id":4669637862396373,"zdmj":314.400,"sfmj":264.580},{"area_id":4669626693131416,"zdmj":314.380,"sfmj":314.380},{"area_id":4669640089602081,"zdmj":312.000,"sfmj":312.000},{"area_id":4669640089616541,"zdmj":306.790,"sfmj":306.790},{"area_id":4669625585766831,"zdmj":301.830,"sfmj":283.720},{"area_id":4669625585766845,"zdmj":301.830,"sfmj":283.720},{"area_id":4669625585766884,"zdmj":301.830,"sfmj":283.720},{"area_id":4669625585766899,"zdmj":301.830,"sfmj":283.720},{"area_id":4669626693134554,"zdmj":300.000,"sfmj":300.000},{"area_id":4669637862396330,"zdmj":299.500,"sfmj":252.040},{"area_id":4669625585766720,"zdmj":299.300,"sfmj":281.300},{"area_id":4669625585766730,"zdmj":299.300,"sfmj":281.300},{"area_id":4669625585766749,"zdmj":299.300,"sfmj":281.300},{"area_id":4669625585766782,"zdmj":299.300,"sfmj":281.300},{"area_id":4669625585766800,"zdmj":299.300,"sfmj":281.300},{"area_id":4669626693134532,"zdmj":298.700,"sfmj":298.700},{"area_id":4669640089615363,"zdmj":293.080,"sfmj":293.080},{"area_id":4669640089615369,"zdmj":284.110,"sfmj":284.110},{"area_id":4669640089615355,"zdmj":284.110,"sfmj":284.110},{"area_id":4958123240718344,"zdmj":273.910,"sfmj":273.910},{"area_id":4669640089614605,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089614569,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089614548,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089614499,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089615033,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089615096,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089614431,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089615128,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089614473,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089615186,"zdmj":273.010,"sfmj":242.720},{"area_id":4669640089615269,"zdmj":272.870,"sfmj":242.720},{"area_id":4669640089615226,"zdmj":272.870,"sfmj":242.720},{"area_id":4699459158291027,"zdmj":270.100,"sfmj":270.100},{"area_id":4699459158290999,"zdmj":269.050,"sfmj":269.050},{"area_id":4669640089614601,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089614580,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089614537,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089614507,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089615048,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089615085,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089614443,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089614466,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089615141,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089615170,"zdmj":265.810,"sfmj":236.320},{"area_id":4669640089615261,"zdmj":265.680,"sfmj":236.320},{"area_id":4669640089615234,"zdmj":265.680,"sfmj":236.320},{"area_id":4669625585766854,"zdmj":265.500,"sfmj":249.570},{"area_id":4669625585766907,"zdmj":265.500,"sfmj":249.570},{"area_id":4669625585766808,"zdmj":263.300,"sfmj":247.500},{"area_id":4669640089615343,"zdmj":256.690,"sfmj":256.690},{"area_id":4669629171776100,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171776081,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171775945,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171775930,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171775810,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171775797,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171775685,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171775674,"zdmj":256.220,"sfmj":213.470},{"area_id":4669629171778162,"zdmj":256.180,"sfmj":213.470},{"area_id":4669629171778264,"zdmj":256.180,"sfmj":213.470},{"area_id":4669629171778274,"zdmj":256.180,"sfmj":213.470},{"area_id":4669629171778385,"zdmj":256.180,"sfmj":210.710},{"area_id":4669622611902756,"zdmj":255.000,"sfmj":255.000},{"area_id":4700460086984722,"zdmj":255.000,"sfmj":255.000},{"area_id":4700459944378382,"zdmj":255.000,"sfmj":255.000},{"area_id":4700459873075204,"zdmj":255.000,"sfmj":255.000},{"area_id":4669640089609009,"zdmj":253.120,"sfmj":253.120},{"area_id":4669629171778154,"zdmj":252.870,"sfmj":210.710},{"area_id":4669636419531865,"zdmj":251.000,"sfmj":251.000},{"area_id":1046436913617043520,"zdmj":249.700,"sfmj":249.700},{"area_id":1046436913621237839,"zdmj":249.700,"sfmj":249.700},{"area_id":4669640089614624,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089614587,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089614557,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089614513,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089615059,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089614457,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089615114,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089614493,"zdmj":249.600,"sfmj":221.900},{"area_id":4669640089615152,"zdmj":249.590,"sfmj":221.900},{"area_id":4669640089615214,"zdmj":249.590,"sfmj":221.900},{"area_id":4669640089615243,"zdmj":249.470,"sfmj":221.900},{"area_id":4669625967475549,"zdmj":246.530,"sfmj":231.740},{"area_id":4699459158290981,"zdmj":243.610,"sfmj":243.610},{"area_id":4669640089614612,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089614592,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089614550,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089614525,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089615075,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089615101,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089614461,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089614483,"zdmj":242.400,"sfmj":215.500},{"area_id":4669640089615157,"zdmj":242.390,"sfmj":215.500},{"area_id":4669640089615199,"zdmj":242.390,"sfmj":215.500},{"area_id":4669629171778440,"zdmj":242.340,"sfmj":209.130},{"area_id":4669629171778447,"zdmj":242.340,"sfmj":209.130},{"area_id":4669629171778514,"zdmj":242.340,"sfmj":209.130},{"area_id":4669629171778522,"zdmj":242.340,"sfmj":209.130},{"area_id":4669640089615276,"zdmj":242.270,"sfmj":215.500},{"area_id":4669640089615252,"zdmj":242.270,"sfmj":215.500},{"area_id":4669640089614693,"zdmj":242.200,"sfmj":215.600},{"area_id":4669640089614777,"zdmj":242.200,"sfmj":215.600},{"area_id":4669640089614820,"zdmj":242.190,"sfmj":215.600},{"area_id":4669640089614894,"zdmj":242.190,"sfmj":215.600},{"area_id":4669640089614941,"zdmj":242.190,"sfmj":215.600},{"area_id":4669640089615022,"zdmj":242.190,"sfmj":215.600},{"area_id":4699459158291057,"zdmj":242.000,"sfmj":242.000},{"area_id":4699459158291039,"zdmj":240.760,"sfmj":240.760},{"area_id":4669640089614701,"zdmj":240.660,"sfmj":214.240},{"area_id":4669640089614757,"zdmj":240.660,"sfmj":214.240},{"area_id":4669640089614824,"zdmj":240.660,"sfmj":214.240},{"area_id":4669640089614878,"zdmj":240.660,"sfmj":214.240},{"area_id":4669640089614946,"zdmj":240.660,"sfmj":214.240},{"area_id":4669640089615007,"zdmj":240.660,"sfmj":214.240},{"area_id":4699459158291007,"zdmj":239.950,"sfmj":239.950},{"area_id":4669625967475535,"zdmj":237.800,"sfmj":223.500},{"area_id":4669625967475523,"zdmj":237.000,"sfmj":223.000},{"area_id":4699459158291366,"zdmj":234.560,"sfmj":234.560}],"textResult":"| 面积ID | 建筑面积汇总 | 收费面积汇总 |\n|:---:|:---:|:---:|\n| 4669629171791941 | 4833.000 | 4833.000 |\n| 4669629175992166 | 3500.000 | 3500.000 |\n| 4669653494615049 | 3482.800 | 3482.800 |\n| 4669653494615033 | 3302.350 | 3302.350 |\n| 4669653494615041 | 3223.400 | 3223.400 |\n| 4669626693134508 | 3000.000 | 3000.000 |\n| 4669626693131685 | 2913.240 | 2913.240 |\n| 4669629171791926 | 2184.000 | 2184.000 |\n| 4669653494615064 | 2136.030 | 2136.030 |\n| 4669653494615080 | 2116.250 | 2116.250 |\n| 4669636419531852 | 1939.060 | 1939.060 |\n| 4669626693134492 | 1800.000 | 1800.000 |\n| 4669636419531843 | 1732.000 | 1732.000 |\n| 4669625967475563 | 1698.640 | 1698.640 |\n| 4669629175992184 | 1661.450 | 1661.450 |\n| 4669625581562408 | 1533.750 | 1533.750 |\n| 4669640085395335 | 1532.000 | 1021.340 |\n| 4669625136936642 | 1500.000 | 1500.000 |\n| 4669640089602101 | 1497.300 | 1497.300 |\n| 4669626693134525 | 1125.000 | 1125.000 |\n| 4669629171788075 | 1043.500 | 1043.500 |\n| 4854922084614146 | 1043.500 | 1043.500 |\n| 4963932402089989 | 1029.360 | 1029.360 |\n| 1432819254578642944 | 1012.820 | 1012.820 |\n| 4669636419531875 | 980.000 | 980.000 |\n| 4669636419531834 | 964.320 | 964.320 |\n| 4669636419531819 | 964.320 | 964.320 |\n| 4838271444320260 | 946.050 | 946.050 |\n| 4669624298057110 | 934.560 | 934.560 |\n| 4838271641452554 | 923.190 | 923.190 |\n| 4669653494614828 | 905.270 | 905.270 |\n| 4971957519122551 | 816.000 | 816.000 |\n| 4669627016130427 | 788.930 | 788.930 |\n| 1046436913621237841 | 768.670 | 768.670 |\n| 4669626693135450 | 737.560 | 737.560 |\n| 4669626693135445 | 733.090 | 733.090 |\n| 4669629171791957 | 730.000 | 730.000 |\n| 4701258661494791 | 720.890 | 720.890 |\n| 4704542549868568 | 708.490 | 708.490 |\n| 4669626693134502 | 672.000 | 672.000 |\n| 4669657303068731 | 664.670 | 624.790 |\n| 4669657303068708 | 656.720 | 617.320 |\n| 4669625967474568 | 641.640 | 603.140 |\n| 4669625967474579 | 641.640 | 603.140 |\n| 4701259336777740 | 627.630 | 627.630 |\n| 4669627016130414 | 627.260 | 627.260 |\n| 4669640089602061 | 565.000 | 565.000 |\n| 4669657298849275 | 554.300 | 554.300 |\n| 4669625581562514 | 543.070 | 543.070 |\n| 4669657298853291 | 534.050 | 534.050 |\n| 4669657298851540 | 532.460 | 532.460 |\n| 4669640089616520 | 523.370 | 523.370 |\n| 4669657303067646 | 523.070 | 523.070 |\n| 4971263143706631 | 510.670 | 510.670 |\n| 1046436913621237842 | 503.060 | 503.060 |\n| 4669629175992196 | 497.100 | 497.100 |\n| 4669625581562427 | 495.920 | 495.920 |\n| 4669625967475581 | 488.930 | 488.930 |\n| 4669640089615547 | 457.560 | 457.560 |\n| 4669640089602202 | 454.000 | 454.000 |\n| 4669626693131676 | 450.000 | 450.000 |\n| 4669625136926636 | 438.120 | 438.120 |\n| 1046436913617043527 | 427.070 | 427.070 |\n| 4669657298853298 | 415.800 | 415.800 |\n| 4669657298851553 | 414.560 | 414.560 |\n| 4669640089615629 | 408.170 | 408.170 |\n| 4669625581562423 | 400.640 | 400.640 |\n| 4669626693124214 | 396.970 | 396.970 |\n| 4669626693124208 | 396.970 | 396.970 |\n| 4669627292961326 | 396.970 | 396.970 |\n| 4669636419536467 | 396.970 | 396.970 |\n| 4669640089602133 | 391.000 | 391.000 |\n| 4669657303068718 | 366.100 | 344.100 |\n| 4669622293123973 | 353.070 | 353.070 |\n| 4669629171788091 | 336.000 | 336.000 |\n| 4669640089615522 | 336.000 | 336.000 |\n| 4669640089615539 | 332.400 | 332.400 |\n| 4971957519122540 | 330.000 | 330.000 |\n| 4669625581562436 | 329.980 | 329.980 |\n| 4669626693131311 | 328.440 | 328.440 |\n| 4669626693135460 | 327.270 | 327.270 |\n| 4709622892199944 | 317.400 | 317.400 |\n| 4669637862396373 | 314.400 | 264.580 |\n| 4669626693131416 | 314.380 | 314.380 |\n| 4669640089602081 | 312.000 | 312.000 |\n| 4669640089616541 | 306.790 | 306.790 |\n| 4669625585766831 | 301.830 | 283.720 |\n| 4669625585766845 | 301.830 | 283.720 |\n| 4669625585766884 | 301.830 | 283.720 |\n| 4669625585766899 | 301.830 | 283.720 |\n| 4669626693134554 | 300.000 | 300.000 |\n| 4669637862396330 | 299.500 | 252.040 |\n| 4669625585766720 | 299.300 | 281.300 |\n| 4669625585766730 | 299.300 | 281.300 |\n| 4669625585766749 | 299.300 | 281.300 |\n| 4669625585766782 | 299.300 | 281.300 |\n| 4669625585766800 | 299.300 | 281.300 |\n| 4669626693134532 | 298.700 | 298.700 |\n| 4669640089615363 | 293.080 | 293.080 |\n| 4669640089615369 | 284.110 | 284.110 |\n| 4669640089615355 | 284.110 | 284.110 |\n| 4958123240718344 | 273.910 | 273.910 |\n| 4669640089614605 | 273.010 | 242.720 |\n| 4669640089614569 | 273.010 | 242.720 |\n| 4669640089614548 | 273.010 | 242.720 |\n| 4669640089614499 | 273.010 | 242.720 |\n| 4669640089615033 | 273.010 | 242.720 |\n| 4669640089615096 | 273.010 | 242.720 |\n| 4669640089614431 | 273.010 | 242.720 |\n| 4669640089615128 | 273.010 | 242.720 |\n| 4669640089614473 | 273.010 | 242.720 |\n| 4669640089615186 | 273.010 | 242.720 |\n| 4669640089615269 | 272.870 | 242.720 |\n| 4669640089615226 | 272.870 | 242.720 |\n| 4699459158291027 | 270.100 | 270.100 |\n| 4699459158290999 | 269.050 | 269.050 |\n| 4669640089614601 | 265.810 | 236.320 |\n| 4669640089614580 | 265.810 | 236.320 |\n| 4669640089614537 | 265.810 | 236.320 |\n| 4669640089614507 | 265.810 | 236.320 |\n| 4669640089615048 | 265.810 | 236.320 |\n| 4669640089615085 | 265.810 | 236.320 |\n| 4669640089614443 | 265.810 | 236.320 |\n| 4669640089614466 | 265.810 | 236.320 |\n| 4669640089615141 | 265.810 | 236.320 |\n| 4669640089615170 | 265.810 | 236.320 |\n| 4669640089615261 | 265.680 | 236.320 |\n| 4669640089615234 | 265.680 | 236.320 |\n| 4669625585766854 | 265.500 | 249.570 |\n| 4669625585766907 | 265.500 | 249.570 |\n| 4669625585766808 | 263.300 | 247.500 |\n| 4669640089615343 | 256.690 | 256.690 |\n| 4669629171776100 | 256.220 | 213.470 |\n| 4669629171776081 | 256.220 | 213.470 |\n| 4669629171775945 | 256.220 | 213.470 |\n| 4669629171775930 | 256.220 | 213.470 |\n| 4669629171775810 | 256.220 | 213.470 |\n| 4669629171775797 | 256.220 | 213.470 |\n| 4669629171775685 | 256.220 | 213.470 |\n| 4669629171775674 | 256.220 | 213.470 |\n| 4669629171778162 | 256.180 | 213.470 |\n| 4669629171778264 | 256.180 | 213.470 |\n| 4669629171778274 | 256.180 | 213.470 |\n| 4669629171778385 | 256.180 | 210.710 |\n| 4669622611902756 | 255.000 | 255.000 |\n| 4700460086984722 | 255.000 | 255.000 |\n| 4700459944378382 | 255.000 | 255.000 |\n| 4700459873075204 | 255.000 | 255.000 |\n| 4669640089609009 | 253.120 | 253.120 |\n| 4669629171778154 | 252.870 | 210.710 |\n| 4669636419531865 | 251.000 | 251.000 |\n| 1046436913617043520 | 249.700 | 249.700 |\n| 1046436913621237839 | 249.700 | 249.700 |\n| 4669640089614624 | 249.600 | 221.900 |\n| 4669640089614587 | 249.600 | 221.900 |\n| 4669640089614557 | 249.600 | 221.900 |\n| 4669640089614513 | 249.600 | 221.900 |\n| 4669640089615059 | 249.600 | 221.900 |\n| 4669640089614457 | 249.600 | 221.900 |\n| 4669640089615114 | 249.600 | 221.900 |\n| 4669640089614493 | 249.600 | 221.900 |\n| 4669640089615152 | 249.590 | 221.900 |\n| 4669640089615214 | 249.590 | 221.900 |\n| 4669640089615243 | 249.470 | 221.900 |\n| 4669625967475549 | 246.530 | 231.740 |\n| 4699459158290981 | 243.610 | 243.610 |\n| 4669640089614612 | 242.400 | 215.500 |\n| 4669640089614592 | 242.400 | 215.500 |\n| 4669640089614550 | 242.400 | 215.500 |\n| 4669640089614525 | 242.400 | 215.500 |\n| 4669640089615075 | 242.400 | 215.500 |\n| 4669640089615101 | 242.400 | 215.500 |\n| 4669640089614461 | 242.400 | 215.500 |\n| 4669640089614483 | 242.400 | 215.500 |\n| 4669640089615157 | 242.390 | 215.500 |\n| 4669640089615199 | 242.390 | 215.500 |\n| 4669629171778440 | 242.340 | 209.130 |\n| 4669629171778447 | 242.340 | 209.130 |\n| 4669629171778514 | 242.340 | 209.130 |\n| 4669629171778522 | 242.340 | 209.130 |\n| 4669640089615276 | 242.270 | 215.500 |\n| 4669640089615252 | 242.270 | 215.500 |\n| 4669640089614693 | 242.200 | 215.600 |\n| 4669640089614777 | 242.200 | 215.600 |\n| 4669640089614820 | 242.190 | 215.600 |\n| 4669640089614894 | 242.190 | 215.600 |\n| 4669640089614941 | 242.190 | 215.600 |\n| 4669640089615022 | 242.190 | 215.600 |\n| 4699459158291057 | 242.000 | 242.000 |\n| 4699459158291039 | 240.760 | 240.760 |\n| 4669640089614701 | 240.660 | 214.240 |\n| 4669640089614757 | 240.660 | 214.240 |\n| 4669640089614824 | 240.660 | 214.240 |\n| 4669640089614878 | 240.660 | 214.240 |\n| 4669640089614946 | 240.660 | 214.240 |\n| 4669640089615007 | 240.660 | 214.240 |\n| 4699459158291007 | 239.950 | 239.950 |\n| 4669625967475535 | 237.800 | 223.500 |\n| 4669625967475523 | 237.000 | 223.000 |\n| 4699459158291366 | 234.560 | 234.560 |\n","queryTimeCost":4463,"recommendedDimensions":[],"aggregateInfo":{"metricInfos":[]}}', 0, '', '[]', '{"parseStartTime":1776236663052,"parseTime":14613,"sqlTime":2038}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (64, 4, '2026-04-15 22:25:31.933', '用户维度数据集查询本采暖期缴费用户数量', 'admin', 1, 11, '{}', 0, '', '[]', '{"parseStartTime":1776263138610,"parseTime":175386,"sqlTime":1148}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (63, 4, '2026-04-15 22:01:16.597', '用户维度数据集查询本采暖期缴费用户数量', 'admin', 1, 11, '{}', 0, '', '[]', '{"parseStartTime":1776261685419,"parseTime":474913,"sqlTime":2010}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (65, 4, '2026-04-15 23:50:39.784', '用户维度数据集查询本采暖期缴费用户数量', 'admin', 1, 11, '{}', 0, '', '[]', '{"parseStartTime":1776268244016,"parseTime":180357,"sqlTime":2272}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (66, 4, '2026-04-15 23:54:51.523', '查询本采暖期缴费用户数量', 'admin', 1, 11, '{}', 0, '', '[]', '{"parseStartTime":1776268494775,"parseTime":165795,"sqlTime":758}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (67, 4, '2026-04-15 23:57:12.633', '哪个小区收费率高？', 'admin', 1, 12, '{}', 0, '', '[]', '{"parseStartTime":1776268652704,"parseTime":146990,"sqlTime":720}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (68, 4, '2026-04-15 23:59:34.507', '总用户量多少？', 'admin', 1, 13, '{}', 0, '', '[]', '{"parseStartTime":1776268796062,"parseTime":162017,"sqlTime":700}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (69, 4, '2026-04-16 00:04:10.449', '哪个小区收费率高？', 'admin', 1, 13, '{}', 0, '', '', '{"parseStartTime":1776269069876,"parseTime":208950,"sqlTime":2138}');
INSERT INTO "heating_analytics"."s2_chat_query" VALUES (70, 4, '2026-04-16 09:23:24.811', '哪个小区收费率高？', 'admin', 1, 13, '{}', 0, '', '[]', '{"parseStartTime":1776302631753,"parseTime":76492,"sqlTime":2605}');

-- ----------------------------
-- Table structure for s2_chat_statistics
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_chat_statistics";
CREATE TABLE "heating_analytics"."s2_chat_statistics" (
  "question_id" int8 NOT NULL,
  "chat_id" int8 NOT NULL,
  "user_name" varchar(150) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_text" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "interface_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "cost" int4 DEFAULT 0,
  "type" int4,
  "create_time" timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of s2_chat_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for s2_collect
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_collect";
CREATE TABLE "heating_analytics"."s2_collect" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_collect_id_seq'::regclass),
  "type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "username" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "collect_id" int8 NOT NULL,
  "create_time" timestamp(6),
  "update_time" timestamp(6)
)
;

-- ----------------------------
-- Records of s2_collect
-- ----------------------------

-- ----------------------------
-- Table structure for s2_data_set
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_data_set";
CREATE TABLE "heating_analytics"."s2_data_set" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_data_set_id_seq'::regclass),
  "domain_id" int8,
  "name" varchar(255) COLLATE "pg_catalog"."default",
  "biz_name" varchar(255) COLLATE "pg_catalog"."default",
  "description" varchar(255) COLLATE "pg_catalog"."default",
  "status" int4,
  "alias" varchar(255) COLLATE "pg_catalog"."default",
  "data_set_detail" text COLLATE "pg_catalog"."default",
  "created_at" timestamp(6),
  "created_by" varchar(255) COLLATE "pg_catalog"."default",
  "updated_at" timestamp(6),
  "updated_by" varchar(255) COLLATE "pg_catalog"."default",
  "query_config" varchar(3000) COLLATE "pg_catalog"."default",
  "admin" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "admin_org" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_data_set
-- ----------------------------
INSERT INTO "heating_analytics"."s2_data_set" VALUES (1, 1, '超音数数据集', 's2', '包含超音数访问统计相关的指标和维度等', 1, NULL, '{"dataSetModelConfigs":[{"dimensions":[1,2],"id":1,"includesAll":false,"metrics":[]},{"dimensions":[5,7,6],"id":3,"includesAll":false,"metrics":[1]},{"dimensions":[3,4],"id":2,"includesAll":false,"metrics":[2,3,4]}]}', '2026-04-13 11:04:54.295', 'admin', '2026-04-13 11:04:54.295', 'admin', '{"aggregateTypeDefaultConfig":{"limit":200,"timeDefaultConfig":{"period":"DAY","timeMode":"RECENT","unit":7}},"detailTypeDefaultConfig":{"limit":500,"timeDefaultConfig":{"period":"DAY","timeMode":"LAST","unit":1}}}', 'admin', NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (2, 2, '企业数据集', 'CorporateData', '巨头公司核心经营数据', 1, NULL, '{"dataSetModelConfigs":[{"dimensions":[8,9,10,11,12,13],"id":4,"includesAll":false,"metrics":[5,6]},{"dimensions":[14,15,16,17,18],"id":5,"includesAll":false,"metrics":[7]},{"dimensions":[19,20],"id":6,"includesAll":false,"metrics":[8,9,10,11]}]}', '2026-04-13 11:04:54.922', 'admin', '2026-04-13 11:04:54.922', 'admin', '{"aggregateTypeDefaultConfig":{"limit":200,"timeDefaultConfig":{"period":"DAY","timeMode":"LAST","unit":1}},"detailTypeDefaultConfig":{"limit":500,"timeDefaultConfig":{"period":"DAY","timeMode":"LAST","unit":1}}}', 'admin', NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (3, 3, '歌手数据集', 'singer', '包含歌手相关标签和指标信息', 1, NULL, '{"dataSetModelConfigs":[{"dimensions":[21,22,23,24],"id":7,"includesAll":false,"metrics":[12,13,14]}]}', '2026-04-13 11:04:55.305', 'admin', '2026-04-13 11:04:55.305', 'admin', '{"aggregateTypeDefaultConfig":{"limit":200,"timeDefaultConfig":{"period":"DAY","timeMode":"RECENT","unit":7}},"detailTypeDefaultConfig":{"limit":500,"timeDefaultConfig":{"period":"DAY","timeMode":"LAST","unit":1}}}', 'admin,jack', NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (16, 10, '供热收费系统', 'heating_charge_ds', '供热收费系统', 1, '系统', '{"dataSetModelConfigs":[]}', '2026-04-14 03:47:52.574848', 'admin', '2026-04-14 03:47:52.574848', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (17, 12, '收费结算数据集', 'sf_rpt_charge_ds', '收费结算核心数据集', 1, '收费结算', '{"dataSetModelConfigs":[{"id": 26, "includesAll": true}]}', '2026-04-14 03:47:52.578604', 'admin', '2026-04-14 03:47:52.578604', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (18, 13, '收费明细数据集', 'sf_rpt_payment_ds', '收费明细数据集', 1, '收费明细', '{"dataSetModelConfigs":[{"id": 27, "includesAll": true}]}', '2026-04-14 03:47:52.586195', 'admin', '2026-04-14 03:47:52.586195', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (19, 14, '停供复供数据集', 'sf_fact_stop_restart_ds', '停供复供业务数据集', 1, '停供复供', '{"dataSetModelConfigs":[{"id": 28, "includesAll": true}]}', '2026-04-14 03:47:52.592332', 'admin', '2026-04-14 03:47:52.592332', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (20, 14, '采暖期收费汇总数据集', 'sf_rpt_cnq_charge_ds', '采暖期收费汇总数据集', 1, '采暖期汇总', '{"dataSetModelConfigs":[{"id": 29, "includesAll": true}]}', '2026-04-14 03:47:52.59568', 'admin', '2026-04-14 03:47:52.59568', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (13, 11, '组织维度数据集', 'sf_dim_org_ds', '组织架构维度数据集', 1, '组织架构', '{"dataSetModelConfigs":[{"id": 23, "includesAll": true}]}', '2026-04-14 03:47:08.771976', 'admin', '2026-04-14 03:47:08.771976', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (14, 11, '面积维度数据集', 'sf_dim_area_ds', '供热面积维度数据集', 1, '供热面积', '{"dataSetModelConfigs":[{"id": 24, "includesAll": true}]}', '2026-04-14 03:47:08.776166', 'admin', '2026-04-14 03:47:08.776166', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (15, 11, '时间维度数据集', 'sf_dim_time_ds', '时间维度数据集', 1, '时间维度', '{"dataSetModelConfigs":[{"id": 25, "includesAll": true}]}', '2026-04-14 03:47:08.779323', 'admin', '2026-04-14 03:47:08.779323', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (21, 15, '供热收费质量域', 'heating_quality_ds', '数据质量监控', 1, '质量', '{"dataSetModelConfigs":[{"id": 30, "includesAll": true}, {"id": 31, "includesAll": true}]}', '2026-04-14 03:47:52.599378', 'admin', '2026-04-14 03:47:52.599378', 'admin', NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_data_set" VALUES (12, 11, '用户维度数据集', 'sf_dim_customer_ds', '热用户基本信息数据集', 1, '用户信息', '{"dataSetModelConfigs":[{"id": 22, "includesAll": true}]}', '2026-04-14 03:47:08.764224', 'admin', '2026-04-14 03:47:08.764224', 'admin', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for s2_database
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_database";
CREATE TABLE "heating_analytics"."s2_database" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_database_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "version" varchar(64) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "config" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "admin" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "viewer" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_open" int2
)
;

-- ----------------------------
-- Records of s2_database
-- ----------------------------
INSERT INTO "heating_analytics"."s2_database" VALUES (1, 'S2数据库DEMO', '样例数据库实例仅用于体验', NULL, 'POSTGRESQL', '{"password":"oaKKyoiSoTPXxtRrDg1Y5A==","url":"jdbc:postgresql://192.168.1.10:5432/postgres?stringtype=unspecified","userName":"postgres"}', '2026-03-13 18:26:04.174', 'admin', '2026-03-13 18:26:04.174', 'admin', '', '', NULL);
INSERT INTO "heating_analytics"."s2_database" VALUES (2, 'mysql_sf_charge', '222', '8.0', 'MYSQL', '{"password":"oaKKyoiSoTPXxtRrDg1Y5A==","url":"jdbc:mysql://192.168.1.7:7001/charge_zbhx_20260303","userName":"root"}', '2026-04-13 15:35:22.069', 'admin', '2026-04-14 09:56:55.512', 'admin', '', '', 0);

-- ----------------------------
-- Table structure for s2_dictionary_conf
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_dictionary_conf";
CREATE TABLE "heating_analytics"."s2_dictionary_conf" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_dictionary_conf_id_seq'::regclass),
  "description" varchar(255) COLLATE "pg_catalog"."default",
  "type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "item_id" int4 NOT NULL,
  "config" text COLLATE "pg_catalog"."default",
  "status" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of s2_dictionary_conf
-- ----------------------------
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (1, NULL, 'DIMENSION', 1, '', 'ONLINE', '2026-04-13 11:04:53.709', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (2, NULL, 'DIMENSION', 2, '', 'ONLINE', '2026-04-13 11:04:54.187', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (3, NULL, 'DIMENSION', 8, '', 'ONLINE', '2026-04-13 11:04:54.464', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (4, NULL, 'DIMENSION', 11, '', 'ONLINE', '2026-04-13 11:04:54.571', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (5, NULL, 'DIMENSION', 12, '', 'ONLINE', '2026-04-13 11:04:54.638', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (6, NULL, 'DIMENSION', 14, '', 'ONLINE', '2026-04-13 11:04:54.777', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (7, NULL, 'DIMENSION', 21, '', 'ONLINE', '2026-04-13 11:04:55.002', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (8, NULL, 'DIMENSION', 23, '', 'ONLINE', '2026-04-13 11:04:55.093', 'admin');
INSERT INTO "heating_analytics"."s2_dictionary_conf" VALUES (9, NULL, 'DIMENSION', 24, '', 'ONLINE', '2026-04-13 11:04:55.233', 'admin');

-- ----------------------------
-- Table structure for s2_dictionary_task
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_dictionary_task";
CREATE TABLE "heating_analytics"."s2_dictionary_task" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_dictionary_task_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(255) COLLATE "pg_catalog"."default",
  "type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "item_id" int4 NOT NULL,
  "config" text COLLATE "pg_catalog"."default",
  "status" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "elapsed_ms" int4
)
;

-- ----------------------------
-- Records of s2_dictionary_task
-- ----------------------------

-- ----------------------------
-- Table structure for s2_dimension
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_dimension";
CREATE TABLE "heating_analytics"."s2_dimension" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_dimension_id_seq'::regclass),
  "model_id" int8,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "biz_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" NOT NULL,
  "status" int2 NOT NULL,
  "sensitive_level" int4,
  "type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "type_params" text COLLATE "pg_catalog"."default",
  "data_type" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "expr" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "semantic_type" varchar(20) COLLATE "pg_catalog"."default" NOT NULL,
  "alias" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "default_values" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "dim_value_maps" varchar(5000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_tag" int2,
  "ext" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_dimension
-- ----------------------------
INSERT INTO "heating_analytics"."s2_dimension" VALUES (1, 1, '部门', 'department', '部门', 1, 0, 'categorical', NULL, NULL, 'department', '2026-04-13 11:04:53.396', 'admin', '2026-04-13 11:04:53.396', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (2, 1, '用户名', 'user_name', '用户名', 1, 0, 'primary_key', NULL, NULL, 'user_name', '2026-04-13 11:04:53.398', 'admin', '2026-04-13 11:04:53.398', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (3, 2, '数据日期', 'imp_date', '数据日期', 1, 0, 'partition_time', '{"isPrimary":"true","timeGranularity":"day"}', NULL, 'imp_date', '2026-04-13 11:04:53.463', 'admin', '2026-04-13 11:04:53.463', 'admin', 'DATE', NULL, NULL, NULL, 0, '{"time_format":"yyyy-MM-dd"}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (4, 2, '用户名', 'user_name', '用户名', 1, 0, 'foreign_key', NULL, NULL, 'user_name', '2026-04-13 11:04:53.463', 'admin', '2026-04-13 11:04:53.463', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (5, 3, '数据日期', 'imp_date', '数据日期', 1, 0, 'partition_time', '{"isPrimary":"true","timeGranularity":"day"}', NULL, 'imp_date', '2026-04-13 11:04:53.491', 'admin', '2026-04-13 11:04:53.491', 'admin', 'DATE', NULL, NULL, NULL, 0, '{"time_format":"yyyy-MM-dd"}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (6, 3, '页面', 'page', '页面', 1, 1, 'categorical', NULL, NULL, 'page', '2026-04-13 11:04:53.491', 'admin', '2026-04-13 11:04:53.652', 'admin', 'CATEGORY', NULL, NULL, '[]', 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (7, 3, '用户名', 'user_name', '用户名', 1, 0, 'foreign_key', NULL, NULL, 'user_name', '2026-04-13 11:04:53.491', 'admin', '2026-04-13 11:04:53.491', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (8, 4, '公司名称', 'company_name', '公司名称', 1, 0, 'categorical', NULL, NULL, 'company_name', '2026-04-13 11:04:54.435', 'admin', '2026-04-13 11:04:54.435', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (9, 4, '总部地点', 'headquarter_address', '总部地点', 1, 0, 'categorical', NULL, NULL, 'headquarter_address', '2026-04-13 11:04:54.435', 'admin', '2026-04-13 11:04:54.435', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (10, 4, '成立时间', 'company_established_time', '成立时间', 1, 0, 'time', NULL, NULL, 'company_established_time', '2026-04-13 11:04:54.435', 'admin', '2026-04-13 11:04:54.435', 'admin', 'DATE', NULL, NULL, NULL, 0, '{"time_format":"yyyy-MM-dd"}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (11, 4, '创始人', 'founder', '创始人', 1, 0, 'categorical', NULL, NULL, 'founder', '2026-04-13 11:04:54.435', 'admin', '2026-04-13 11:04:54.435', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (12, 4, '首席执行官', 'ceo', '首席执行官', 1, 0, 'categorical', NULL, NULL, 'ceo', '2026-04-13 11:04:54.435', 'admin', '2026-04-13 11:04:54.435', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (13, 4, '公司id', 'company_id', '公司id', 1, 0, 'primary_key', NULL, NULL, 'company_id', '2026-04-13 11:04:54.435', 'admin', '2026-04-13 11:04:54.435', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (26, 4, '采暖期月份', 'cnq_month', '采暖期月份(11月=1,12月=2...)', 1, NULL, 'categorical', NULL, 'INT', 't.cnq_month', '2026-04-13 15:26:41.539917', 'admin', '2026-04-13 15:26:41.539917', 'admin', 'TIME', '采暖月', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (27, 4, '缴费季标识', 'is_payment_season', '是否缴费季(11月-次年3月)', 1, NULL, 'categorical', NULL, 'SMALLINT', 't.is_payment_season', '2026-04-13 15:26:41.56461', 'admin', '2026-04-13 15:26:41.56461', 'admin', 'COMMON', '缴费季', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (44, 1, '用户ID', 'customer_id', '用户唯一标识', 1, NULL, 'categorical', NULL, 'BIGINT', 'c.customer_id', '2026-04-14 03:02:29.08841', 'admin', '2026-04-14 03:02:29.08841', 'admin', 'ID', '["用户标识"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (45, 1, '用户编码', 'customer_code', '用户编码', 1, NULL, 'categorical', NULL, 'VARCHAR', 'c.customer_code', '2026-04-14 03:02:29.201924', 'admin', '2026-04-14 03:02:29.201924', 'admin', 'COMMON', '["编码"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (46, 1, '用户名称', 'customer_name', '用户名称', 1, NULL, 'categorical', NULL, 'VARCHAR', 'c.customer_name', '2026-04-14 03:02:29.308767', 'admin', '2026-04-14 03:02:29.308767', 'admin', 'COMMON', '["姓名"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (48, 1, '手机号码', 'mob_no', '手机号码', 1, NULL, 'categorical', NULL, 'VARCHAR', 'c.mob_no', '2026-04-14 03:02:29.668494', 'admin', '2026-04-14 03:02:29.668494', 'admin', 'PHONE', '["电话"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (49, 1, '入网日期', 'rwrq', '入网日期', 1, NULL, 'categorical', NULL, 'DATE', 'c.rwrq', '2026-04-14 03:02:29.779311', 'admin', '2026-04-14 03:02:29.779311', 'admin', 'TIME', '["入网时间"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (50, 1, '黑名单标识', 'kz_hmd', '是否黑名单:0-否 1-是', 1, NULL, 'categorical', NULL, 'SMALLINT', 'c.kz_hmd', '2026-04-14 03:02:30.098985', 'admin', '2026-04-14 03:02:30.098985', 'admin', 'COMMON', '["黑名单"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (51, 1, '允许收费标识', 'kz_sf', '是否允许收费:0-否 1-是', 1, NULL, 'categorical', NULL, 'SMALLINT', 'c.kz_sf', '2026-04-14 03:02:30.209909', 'admin', '2026-04-14 03:02:30.209909', 'admin', 'COMMON', '["可收费"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (52, 2, '组织ID', 'org_id', '组织唯一标识', 1, NULL, 'categorical', NULL, 'BIGINT', 'o.org_id', '2026-04-14 03:02:30.328752', 'admin', '2026-04-14 03:02:30.328752', 'admin', 'ID', '["组织标识"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (53, 2, '分公司', 'org_level1', '分公司名称', 1, NULL, 'categorical', NULL, 'VARCHAR', 'o.org_level1', '2026-04-14 03:02:30.458645', 'admin', '2026-04-14 03:02:30.458645', 'admin', 'COMMON', '分公司', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (54, 2, '热力站', 'org_level2', '热力站名称', 1, NULL, 'categorical', NULL, 'VARCHAR', 'o.org_level2', '2026-04-14 03:02:30.578306', 'admin', '2026-04-14 03:02:30.578306', 'admin', 'COMMON', '热力站', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (55, 2, '小区', 'org_level3', '小区名称', 1, NULL, 'categorical', NULL, 'VARCHAR', 'o.org_level3', '2026-04-14 03:02:30.694339', 'admin', '2026-04-14 03:02:30.694339', 'admin', 'COMMON', '小区', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (56, 2, '组织类型', 'org_type', '组织类型:分公司/热力站/小区', 1, NULL, 'categorical', NULL, 'VARCHAR', 'o.org_type', '2026-04-14 03:02:30.818314', 'admin', '2026-04-14 03:02:30.818314', 'admin', 'COMMON', '类型', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (57, 3, '面积ID', 'area_id', '面积唯一标识', 1, NULL, 'categorical', NULL, 'BIGINT', 'a.area_id', '2026-04-14 03:02:30.938695', 'admin', '2026-04-14 03:02:30.938695', 'admin', 'ID', '面积标识', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (58, 3, '面积类别', 'mjlb', '面积类别', 1, NULL, 'categorical', NULL, 'VARCHAR', 'a.mjlb', '2026-04-14 03:02:31.048858', 'admin', '2026-04-14 03:02:31.048858', 'admin', 'COMMON', '类别', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (59, 3, '单价类别', 'djlb', '单价类别:居民/非居民/困难户等', 1, NULL, 'categorical', NULL, 'VARCHAR', 'a.djlb', '2026-04-14 03:02:31.158566', 'admin', '2026-04-14 03:02:31.158566', 'admin', 'COMMON', '单价类别', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (60, 3, '结算方式', 'jsfs', '结算方式:按面积/计量/两部制', 1, NULL, 'categorical', NULL, 'VARCHAR', 'a.jsfs', '2026-04-14 03:02:31.278805', 'admin', '2026-04-14 03:02:31.278805', 'admin', 'COMMON', '结算方式', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (61, 3, '供暖状态', 'gnzt', '供暖状态:正常/停供/部分停供', 1, NULL, 'categorical', NULL, 'VARCHAR', 'a.gnzt', '2026-04-14 03:02:31.388235', 'admin', '2026-04-14 03:02:31.388235', 'admin', 'COMMON', '状态', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (62, 3, '阀门状态', 'fmzt', '阀门状态:开阀/关阀', 1, NULL, 'categorical', NULL, 'VARCHAR', 'a.fmzt', '2026-04-14 03:02:31.508378', 'admin', '2026-04-14 03:02:31.508378', 'admin', 'COMMON', '阀门', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (63, 4, '日期ID', 'date_id', '日期主键', 1, NULL, 'categorical', NULL, 'DATE', 't.date_id', '2026-04-14 03:02:31.619353', 'admin', '2026-04-14 03:02:31.619353', 'admin', 'TIME', '日期', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (64, 4, '年份', 'year', '年份', 1, NULL, 'categorical', NULL, 'INT', 't.year', '2026-04-14 03:02:31.732194', 'admin', '2026-04-14 03:02:31.732194', 'admin', 'TIME', '年', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (65, 4, '月份', 'month', '月份(1-12)', 1, NULL, 'categorical', NULL, 'INT', 't.month', '2026-04-14 03:02:31.848864', 'admin', '2026-04-14 03:02:31.848864', 'admin', 'TIME', '月', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (66, 4, '季度', 'quarter', '季度', 1, NULL, 'categorical', NULL, 'INT', 't.quarter', '2026-04-14 03:02:31.978463', 'admin', '2026-04-14 03:02:31.978463', 'admin', 'TIME', '季度', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (67, 4, '采暖期', 'cnq', '采暖期(如:2025-2026)', 1, NULL, 'categorical', NULL, 'VARCHAR', 't.cnq', '2026-04-14 03:02:32.091456', 'admin', '2026-04-14 03:02:32.091456', 'admin', 'TIME', '采暖期', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (68, 4, '采暖期年份', 'cnq_year', '采暖期起始年', 1, NULL, 'categorical', NULL, 'INT', 't.cnq_year', '2026-04-14 03:02:32.200614', 'admin', '2026-04-14 03:02:32.200614', 'admin', 'TIME', '采暖年', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (69, 4, '采暖期月份', 'cnq_month', '采暖期月份(11月=1,12月=2...)', 1, NULL, 'categorical', NULL, 'INT', 't.cnq_month', '2026-04-14 03:02:32.3288', 'admin', '2026-04-14 03:02:32.3288', 'admin', 'TIME', '采暖月', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (70, 4, '缴费季标识', 'is_payment_season', '是否缴费季(11月-次年3月)', 1, NULL, 'categorical', NULL, 'SMALLINT', 't.is_payment_season', '2026-04-14 03:02:32.440324', 'admin', '2026-04-14 03:02:32.440324', 'admin', 'COMMON', '缴费季', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (47, 1, '用户类型', 'yhlx', '用户类型:居民/单位', 1, NULL, 'categorical', NULL, 'VARCHAR', 'c.yhlx', '2026-04-14 03:02:29.439206', 'admin', '2026-04-14 03:02:29.439206', 'admin', 'COMMON', '["鐢ㄦ埛绫诲瀷", "鐢ㄧ儹绫诲瀷", "瀹㈡埛绫诲瀷"]', NULL, NULL, NULL, NULL);
INSERT INTO "heating_analytics"."s2_dimension" VALUES (71, 24, '面积ID', 'area_id', '面积ID', 1, 0, 'primary_key', NULL, NULL, 'area_id', '2026-04-14 12:08:47.563', 'admin', '2026-04-14 12:08:47.563', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (72, 23, '分公司', 'org_level1', '分公司', 1, 0, 'primary_key', NULL, NULL, 'org_level1', '2026-04-14 12:14:44.614', 'admin', '2026-04-14 12:14:44.614', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (73, 25, '日期', 'date_id', '日期', 1, 0, 'primary_key', NULL, NULL, 'date_id', '2026-04-14 12:15:02.56', 'admin', '2026-04-14 12:15:02.56', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (74, 26, '采暖期', 'cnq', '采暖期', 1, 0, 'primary_key', NULL, NULL, 'cnq', '2026-04-14 12:15:43.319', 'admin', '2026-04-14 12:15:43.319', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (75, 28, 'ID', 'id', 'ID', 1, 0, 'primary_key', NULL, NULL, 'id', '2026-04-14 12:21:18.352', 'admin', '2026-04-14 12:21:18.352', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (76, 29, '采暖期', 'cnq', '采暖期', 1, 0, 'categorical', NULL, NULL, 'cnq', '2026-04-14 13:07:05.906', 'admin', '2026-04-14 13:07:05.906', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');
INSERT INTO "heating_analytics"."s2_dimension" VALUES (77, 30, '采暖期', 'cnq', '采暖期', 1, 0, 'categorical', NULL, NULL, 'cnq', '2026-04-14 13:07:20.435', 'admin', '2026-04-14 13:07:20.435', 'admin', 'CATEGORY', NULL, NULL, NULL, 0, '{}');

-- ----------------------------
-- Table structure for s2_domain
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_domain";
CREATE TABLE "heating_analytics"."s2_domain" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_domain_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "biz_name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "parent_id" int8 DEFAULT 0,
  "status" int2 NOT NULL,
  "created_at" timestamp(6),
  "created_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "admin" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "admin_org" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_open" int2,
  "viewer" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "view_org" varchar(3000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "entity" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_domain
-- ----------------------------

-- ----------------------------
-- Table structure for s2_metric
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_metric";
CREATE TABLE "heating_analytics"."s2_metric" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_metric_id_seq'::regclass),
  "model_id" int8,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "biz_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "status" int2 NOT NULL,
  "sensitive_level" int2 NOT NULL,
  "type" varchar(50) COLLATE "pg_catalog"."default" NOT NULL,
  "type_params" text COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6) NOT NULL,
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "data_format_type" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "data_format" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "alias" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "classifications" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "relate_dimensions" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "ext" text COLLATE "pg_catalog"."default",
  "define_type" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_publish" int2
)
;

-- ----------------------------
-- Records of s2_metric
-- ----------------------------
INSERT INTO "heating_analytics"."s2_metric" VALUES (25, 1, '用户总数', 'USER_CNT', '用户总数', 1, 0, 'SIMPLE', '{"expr": "COUNT(DISTINCT c.customer_id)"}', '2026-04-14 03:02:34.379106', 'admin', '2026-04-14 03:02:34.379106', 'admin', NULL, NULL, '用户数', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (26, 1, '新增用户数', 'USER_NEW_CNT', '本期新增用户数', 1, 0, 'SIMPLE', '{"expr": "COUNT(DISTINCT c.customer_id) WHERE c.rwrq >= CURRENT_DATE - INTERVAL ''30 days''"}', '2026-04-14 03:02:34.488501', 'admin', '2026-04-14 03:02:34.488501', 'admin', NULL, NULL, '新增用户', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (27, 1, '黑名单用户数', 'USER_BLACK_CNT', '黑名单用户数', 1, 0, 'SIMPLE', '{"expr": "COUNT(DISTINCT c.customer_id) WHERE c.kz_hmd = 1"}', '2026-04-14 03:02:34.5988', 'admin', '2026-04-14 03:02:34.5988', 'admin', NULL, NULL, '黑名单数', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (28, 3, '收费面积汇总', 'AREA_SFMJ_SUM', '收费面积汇总', 1, 0, 'SIMPLE', '{"expr": "SUM(a.sfmj)"}', '2026-04-14 03:02:34.712853', 'admin', '2026-04-14 03:02:34.712853', 'admin', 'AREA', NULL, '收费面积', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (29, 3, '建筑面积汇总', 'AREA_ZDMJ_SUM', '建筑面积汇总', 1, 0, 'SIMPLE', '{"expr": "SUM(a.zdmj)"}', '2026-04-14 03:02:34.828461', 'admin', '2026-04-14 03:02:34.828461', 'admin', 'AREA', NULL, '建筑面积', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (30, 3, '在供面积数', 'AREA_ACTIVE_CNT', '在供面积数', 1, 0, 'SIMPLE', '{"expr": "COUNT(*) WHERE a.gnzt = ''正常''"}', '2026-04-14 03:02:34.939098', 'admin', '2026-04-14 03:02:34.939098', 'admin', NULL, NULL, '在供数', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (31, 5, '应收金额汇总', 'BILL_YSJE_SUM', '应收金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.ysje)"}', '2026-04-14 03:02:35.048888', 'admin', '2026-04-14 03:02:35.048888', 'admin', 'MONEY', NULL, '应收金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (32, 5, '基础应收汇总', 'BILL_JCYS_SUM', '基础应收汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.jcys)"}', '2026-04-14 03:02:35.158736', 'admin', '2026-04-14 03:02:35.158736', 'admin', 'MONEY', NULL, '基础应收', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (33, 5, '欠费金额汇总', 'BILL_QFJE_SUM', '欠费金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.qfje)"}', '2026-04-14 03:02:35.268075', 'admin', '2026-04-14 03:02:35.268075', 'admin', 'MONEY', NULL, '欠费金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (34, 5, '核减金额汇总', 'BILL_HJJE_SUM', '核减金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.hjje)"}', '2026-04-14 03:02:35.379186', 'admin', '2026-04-14 03:02:35.379186', 'admin', 'MONEY', NULL, '核减金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (35, 5, '折扣金额汇总', 'BILL_ZKJE_SUM', '折扣金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.zkje)"}', '2026-04-14 03:02:35.488707', 'admin', '2026-04-14 03:02:35.488707', 'admin', 'MONEY', NULL, '折扣金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (36, 5, '违约金额汇总', 'BILL_WYJE_SUM', '违约金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(m.wyje)"}', '2026-04-14 03:02:35.598834', 'admin', '2026-04-14 03:02:35.598834', 'admin', 'MONEY', NULL, '违约金', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (37, 6, '实收金额汇总', 'PAY_SFJE_SUM', '实收金额汇总', 1, 1, 'SIMPLE', '{"expr": "SUM(p.sfje)"}', '2026-04-14 03:02:35.708698', 'admin', '2026-04-14 03:02:35.708698', 'admin', 'MONEY', NULL, '实收金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (38, 6, '收费笔数', 'PAY_CNT', '收费笔数', 1, 0, 'SIMPLE', '{"expr": "COUNT(*)"}', '2026-04-14 03:02:35.820389', 'admin', '2026-04-14 03:02:35.820389', 'admin', NULL, NULL, '收费笔数', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (39, 6, '线上收费笔数', 'PAY_ONLINE_CNT', '线上收费笔数(微信/支付宝/网银)', 1, 0, 'SIMPLE', '{"expr": "COUNT(*) WHERE p.sffs IN (''微信'',''支付宝'',''网银'')"}', '2026-04-14 03:02:35.931837', 'admin', '2026-04-14 03:02:35.931837', 'admin', NULL, NULL, '线上笔数', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (40, 6, '线下收费笔数', 'PAY_OFFLINE_CNT', '线下收费笔数(现金/POS/转账)', 1, 0, 'SIMPLE', '{"expr": "COUNT(*) WHERE p.sffs IN (''现金'',''POS'',''转账'')"}', '2026-04-14 03:02:36.038715', 'admin', '2026-04-14 03:02:36.038715', 'admin', NULL, NULL, '线下笔数', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (41, 6, '线上收费金额', 'PAY_ONLINE_AMT', '线上收费金额', 1, 1, 'SIMPLE', '{"expr": "SUM(p.sfje) WHERE p.sffs IN (''微信'',''支付宝'',''网银'')"}', '2026-04-14 03:02:36.148363', 'admin', '2026-04-14 03:02:36.148363', 'admin', 'MONEY', NULL, '线上金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (42, 6, '线下收费金额', 'PAY_OFFLINE_AMT', '线下收费金额', 1, 1, 'SIMPLE', '{"expr": "SUM(p.sfje) WHERE p.sffs IN (''现金'',''POS'',''转账'')"}', '2026-04-14 03:02:36.2584', 'admin', '2026-04-14 03:02:36.2584', 'admin', 'MONEY', NULL, '线下金额', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (1, 3, '停留时长', 'stay_hours', '停留时长', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:53.513', 'admin', '2026-04-13 11:04:53.513', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (5, 4, '年营业额', 'annual_turnover', '年营业额', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.452', 'admin', '2026-04-13 11:04:54.452', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (6, 4, '员工数', 'employee_count', '员工数', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.452', 'admin', '2026-04-13 11:04:54.452', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (7, 5, '注册资本', 'registered_capital', '注册资本', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.753', 'admin', '2026-04-13 11:04:54.753', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (8, 6, '营收', 'revenue', '营收', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.877', 'admin', '2026-04-13 11:04:54.877', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (9, 6, '利润', 'profit', '利润', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.877', 'admin', '2026-04-13 11:04:54.877', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (10, 6, '营收同比增长', 'revenue_growth_year_on_year', '营收同比增长', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.877', 'admin', '2026-04-13 11:04:54.877', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (12, 7, '播放量', 'js_play_cnt', '播放量', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.983', 'admin', '2026-04-13 11:04:54.983', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (18, 6, '线下收费金额', 'PAY_OFFLINE_AMT', '线下收费金额', 1, 1, 'SIMPLE', '{}', '2026-04-13 15:26:42.352043', 'admin', '2026-04-13 15:26:42.352043', 'admin', 'MONEY', NULL, '[]', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (52, 26, '应收金额', 'ysje', '应收金额', 1, 0, 'ATOMIC', '{"expr":"ysje","measures":[{"agg":"SUM","bizName":"ysje","expr":"ysje","fieldName":"ysje","isCreateMetric":1,"name":"应收金额"}]}', '2026-04-14 12:15:44.52', 'admin', '2026-04-14 12:15:44.52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (53, 26, '实收金额', 'sfje', '实收金额', 1, 0, 'ATOMIC', '{"expr":"sfje","measures":[{"agg":"SUM","bizName":"sfje","expr":"sfje","fieldName":"sfje","isCreateMetric":1,"name":"实收金额"}]}', '2026-04-14 12:15:44.52', 'admin', '2026-04-14 12:15:44.52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (54, 26, '欠费金额', 'qfje', '欠费金额', 1, 0, 'ATOMIC', '{"expr":"qfje","measures":[{"agg":"SUM","bizName":"qfje","expr":"qfje","fieldName":"qfje","isCreateMetric":1,"name":"欠费金额"}]}', '2026-04-14 12:15:44.52', 'admin', '2026-04-14 12:15:44.52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (55, 26, '违约金额', 'wyje', '违约金额', 1, 0, 'ATOMIC', '{"expr":"wyje","measures":[{"agg":"SUM","bizName":"wyje","expr":"wyje","fieldName":"wyje","isCreateMetric":1,"name":"违约金额"}]}', '2026-04-14 12:15:44.52', 'admin', '2026-04-14 12:15:44.52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (56, 26, '折扣金额', 'zkje', '折扣金额', 1, 0, 'ATOMIC', '{"expr":"zkje","measures":[{"agg":"SUM","bizName":"zkje","expr":"zkje","fieldName":"zkje","isCreateMetric":1,"name":"折扣金额"}]}', '2026-04-14 12:15:44.52', 'admin', '2026-04-14 12:15:44.52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (49, 22, '用户总数', 'customer_id', '用户总数', 1, 0, 'ATOMIC', '{"expr":"customer_id","measures":[{"agg":"COUNT","bizName":"customer_id","expr":"customer_id","fieldName":"customer_id","isCreateMetric":1,"name":"用户总数"}]}', '2026-04-14 12:07:10.659', 'admin', '2026-04-14 12:07:10.659', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (57, 26, '核减金额', 'hjje', '核减金额', 1, 0, 'ATOMIC', '{"expr":"hjje","measures":[{"agg":"SUM","bizName":"hjje","expr":"hjje","fieldName":"hjje","isCreateMetric":1,"name":"核减金额"}]}', '2026-04-14 12:15:44.52', 'admin', '2026-04-14 12:15:44.52', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (58, 27, '收费笔数', 'id', '收费笔数', 1, 0, 'ATOMIC', '{"expr":"id","measures":[{"agg":"COUNT","bizName":"id","expr":"id","fieldName":"id","isCreateMetric":1,"name":"收费笔数"}]}', '2026-04-14 12:19:23.589', 'admin', '2026-04-14 12:19:23.589', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (59, 27, '实收金额', 'sfje', '实收金额', 1, 0, 'ATOMIC', '{"expr":"sfje","measures":[{"agg":"SUM","bizName":"sfje","expr":"sfje","fieldName":"sfje","isCreateMetric":1,"name":"实收金额"}]}', '2026-04-14 12:19:23.589', 'admin', '2026-04-14 12:19:23.589', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (64, 30, '总用户数', 'total_customers', '总用户数', 1, 0, 'ATOMIC', '{"expr":"total_customers","measures":[{"agg":"SUM","bizName":"total_customers","expr":"total_customers","fieldName":"total_customers","isCreateMetric":1,"name":"总用户数"}]}', '2026-04-14 13:07:21.315', 'admin', '2026-04-14 13:07:21.315', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (65, 30, '已缴费用户数', 'paid_customers', '已缴费用户数', 1, 0, 'ATOMIC', '{"expr":"paid_customers","measures":[{"agg":"SUM","bizName":"paid_customers","expr":"paid_customers","fieldName":"paid_customers","isCreateMetric":1,"name":"已缴费用户数"}]}', '2026-04-14 13:07:21.315', 'admin', '2026-04-14 13:07:21.315', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (66, 30, '欠费用户数', 'arrears_customers', '欠费用户数', 1, 0, 'ATOMIC', '{"expr":"arrears_customers","measures":[{"agg":"SUM","bizName":"arrears_customers","expr":"arrears_customers","fieldName":"arrears_customers","isCreateMetric":1,"name":"欠费用户数"}]}', '2026-04-14 13:07:21.315', 'admin', '2026-04-14 13:07:21.315', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (67, 30, '欠费总额', 'total_arrears', '欠费总额', 1, 0, 'ATOMIC', '{"expr":"total_arrears","measures":[{"agg":"SUM","bizName":"total_arrears","expr":"total_arrears","fieldName":"total_arrears","isCreateMetric":1,"name":"欠费总额"}]}', '2026-04-14 13:07:21.315', 'admin', '2026-04-14 13:07:21.315', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (43, 5, '收费率', 'PAY_RATE', '收费率:实收金额/应收金额*100%', 1, 0, 'DERIVED', '{"expr": "sfje_sum / ysje_sum * 100"}', '2026-04-14 03:02:36.368689', 'admin', '2026-04-14 03:02:36.368689', 'admin', 'PERCENT', NULL, '["收费率"]', NULL, NULL, NULL, 'METRIC', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (44, 5, '欠费率', 'ARREARS_RATE', '欠费率:欠费金额/应收金额*100%', 1, 0, 'DERIVED', '{"expr": "qfje_sum / ysje_sum * 100"}', '2026-04-14 03:02:36.479309', 'admin', '2026-04-14 03:02:36.479309', 'admin', 'PERCENT', NULL, '["欠费率"]', NULL, NULL, NULL, 'METRIC', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (45, 8, '户均热费', 'AVG_FEE', '户均热费:实收金额/用户数', 1, 0, 'DERIVED', '{"expr": "sfje_sum / customer_cnt"}', '2026-04-14 03:02:36.588494', 'admin', '2026-04-14 03:02:36.588494', 'admin', 'MONEY', NULL, '["户均"]', NULL, NULL, NULL, 'METRIC', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (46, 8, '单位面积热费', 'UNIT_PRICE', '单位面积热费:实收金额/收费面积', 1, 0, 'DERIVED', '{"expr": "sfje_sum / sfmj_sum"}', '2026-04-14 03:02:36.703374', 'admin', '2026-04-14 03:02:36.703374', 'admin', 'MONEY', NULL, '["单价"]', NULL, NULL, NULL, 'METRIC', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (4, 2, '人均访问次数', 'pv_avg', '每个用户平均访问的次数', 1, 2, 'DERIVED', '{}', '2026-04-13 11:04:53.685', 'admin', '2026-04-13 11:04:53.685', 'admin', NULL, NULL, NULL, '[]', '[]', NULL, 'METRIC', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (3, 2, '访问次数', 'pv', '一段时间内用户的访问次数', 1, 0, 'DERIVED', '{}', '2026-04-13 11:04:53.67', 'admin', '2026-04-13 11:04:53.67', 'admin', NULL, NULL, NULL, NULL, '[]', NULL, 'FIELD', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (2, 2, '访问用户数', 'uv', '访问的用户个数', 1, 0, 'DERIVED', '{}', '2026-04-13 11:04:53.614', 'admin', '2026-04-13 11:04:53.614', 'admin', NULL, NULL, '[]', NULL, '[]', NULL, 'FIELD', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (47, 8, '用户数', 'CUSTOMER_CNT', '用户数', 1, 0, 'SIMPLE', '{"expr": "SUM(sc.customer_cnt)"}', '2026-04-14 03:02:36.818381', 'admin', '2026-04-14 03:02:36.818381', 'admin', NULL, NULL, '["用户数"]', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (48, 8, '收费面积', 'SFMJ_SUM', '收费面积', 1, 0, 'SIMPLE', '{"expr": "SUM(sc.sfmj_sum)"}', '2026-04-14 03:02:36.93237', 'admin', '2026-04-14 03:02:36.93237', 'admin', 'AREA', NULL, '["面积"]', NULL, NULL, NULL, 'MEASURE', NULL);
INSERT INTO "heating_analytics"."s2_metric" VALUES (19, 5, '收费率', 'PAY_RATE', '收费率:实收金额/应收金额*100%', 1, 0, 'DERIVED', '{}', '2026-04-13 15:26:42.373091', 'admin', '2026-04-13 15:26:42.373091', 'admin', 'PERCENT', NULL, '[]', NULL, '[]', NULL, 'METRIC', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (11, 6, '利润同比增长', 'profit_growth_year_on_year', '利润同比增长', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.877', 'admin', '2026-04-13 11:04:54.877', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (13, 7, '下载量', 'down_cnt', '下载量', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.983', 'admin', '2026-04-13 11:04:54.983', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (14, 7, '收藏量', 'favor_cnt', '收藏量', 1, 0, 'ATOMIC', '{}', '2026-04-13 11:04:54.983', 'admin', '2026-04-13 11:04:54.983', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (15, 8, '供热户数', '供热户数', '供热户数', 1, 0, 'ATOMIC', '{}', '2026-04-13 22:22:57.702', 'admin', '2026-04-13 22:22:57.702', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (16, 8, '收费总额', '实收总额', '收费总额', 1, 0, 'ATOMIC', '{}', '2026-04-13 22:22:57.708', 'admin', '2026-04-13 22:22:57.708', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (20, 5, '欠费率', 'ARREARS_RATE', '欠费率:欠费金额/应收金额*100%', 1, 0, 'DERIVED', '{}', '2026-04-13 15:26:42.39867', 'admin', '2026-04-13 15:26:42.39867', 'admin', 'PERCENT', NULL, '[]', NULL, '[]', NULL, 'METRIC', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (50, 24, '收费面积汇总', 'sfmj', '收费面积汇总', 1, 0, 'ATOMIC', '{"expr":"sfmj","measures":[{"agg":"SUM","bizName":"sfmj","expr":"sfmj","fieldName":"sfmj","isCreateMetric":1,"name":"收费面积汇总"}]}', '2026-04-14 12:08:48.446', 'admin', '2026-04-14 12:08:48.446', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (51, 24, '建筑面积汇总', 'zdmj', '建筑面积汇总', 1, 0, 'ATOMIC', '{"expr":"zdmj","measures":[{"agg":"SUM","bizName":"zdmj","expr":"zdmj","fieldName":"zdmj","isCreateMetric":1,"name":"建筑面积汇总"}]}', '2026-04-14 12:08:48.446', 'admin', '2026-04-14 12:08:48.446', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (60, 29, '用户数', 'customer_cnt', '用户数', 1, 0, 'ATOMIC', '{"expr":"customer_cnt","measures":[{"agg":"SUM","bizName":"customer_cnt","expr":"customer_cnt","fieldName":"customer_cnt","isCreateMetric":1,"name":"用户数"}]}', '2026-04-14 13:07:06.795', 'admin', '2026-04-14 13:07:06.795', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (61, 29, '收费面积', 'sfmj_sum', '收费面积', 1, 0, 'ATOMIC', '{"expr":"sfmj_sum","measures":[{"agg":"SUM","bizName":"sfmj_sum","expr":"sfmj_sum","fieldName":"sfmj_sum","isCreateMetric":1,"name":"收费面积"}]}', '2026-04-14 13:07:06.806', 'admin', '2026-04-14 13:07:06.806', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (62, 29, '应收金额', 'ysje_sum', '应收金额', 1, 0, 'ATOMIC', '{"expr":"ysje_sum","measures":[{"agg":"SUM","bizName":"ysje_sum","expr":"ysje_sum","fieldName":"ysje_sum","isCreateMetric":1,"name":"应收金额"}]}', '2026-04-14 13:07:06.806', 'admin', '2026-04-14 13:07:06.806', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (63, 29, '实收金额', 'sfje_sum', '实收金额', 1, 0, 'ATOMIC', '{"expr":"sfje_sum","measures":[{"agg":"SUM","bizName":"sfje_sum","expr":"sfje_sum","fieldName":"sfje_sum","isCreateMetric":1,"name":"实收金额"}]}', '2026-04-14 13:07:06.806', 'admin', '2026-04-14 13:07:06.806', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (68, 31, '统计月份', 'stat_month', '统计月份', 1, 0, 'ATOMIC', '{"expr":"stat_month","measures":[{"agg":"sum","bizName":"stat_month","expr":"stat_month","fieldName":"stat_month","isCreateMetric":1,"name":"统计月份"}]}', '2026-04-14 13:07:42.275', 'admin', '2026-04-14 13:07:42.275', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (69, 31, '作废笔数', 'cancel_count', '作废笔数', 1, 0, 'ATOMIC', '{"expr":"cancel_count","measures":[{"agg":"SUM","bizName":"cancel_count","expr":"cancel_count","fieldName":"cancel_count","isCreateMetric":1,"name":"作废笔数"}]}', '2026-04-14 13:07:42.275', 'admin', '2026-04-14 13:07:42.275', 'admin', NULL, NULL, NULL, NULL, NULL, NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (17, 8, '收费率', '收费率', '收费率', 1, 0, 'ATOMIC', '{}', '2026-04-13 22:22:57.708', 'admin', '2026-04-13 22:53:03.768', 'admin', '', NULL, '[]', '[]', '[]', NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (23, 8, '用户数', 'CUSTOMER_CNT', '用户数', 1, 0, 'SIMPLE', '{}', '2026-04-13 15:26:42.464343', 'admin', '2026-04-13 15:26:42.464343', 'admin', NULL, NULL, '[]', NULL, '[]', NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (24, 8, '收费面积', 'SFMJ_SUM', '收费面积', 1, 0, 'SIMPLE', '{}', '2026-04-13 15:26:42.485321', 'admin', '2026-04-13 15:26:42.485321', 'admin', 'AREA', NULL, '[]', NULL, '[]', NULL, 'MEASURE', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (21, 8, '户均热费', 'AVG_FEE', '户均热费:实收金额/用户数', 1, 0, 'DERIVED', '{}', '2026-04-13 15:26:42.420293', 'admin', '2026-04-13 15:26:42.420293', 'admin', 'MONEY', NULL, '[]', NULL, '[]', NULL, 'METRIC', 1);
INSERT INTO "heating_analytics"."s2_metric" VALUES (22, 8, '单位面积热费', 'UNIT_PRICE', '单位面积热费:实收金额/收费面积', 1, 0, 'DERIVED', '{}', '2026-04-13 15:26:42.442298', 'admin', '2026-04-13 15:26:42.442298', 'admin', 'MONEY', NULL, '[]', NULL, '[]', NULL, 'METRIC', 1);

-- ----------------------------
-- Table structure for s2_metric_query_default_config
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_metric_query_default_config";
CREATE TABLE "heating_analytics"."s2_metric_query_default_config" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_metric_query_default_config_id_seq'::regclass),
  "metric_id" int8,
  "user_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "default_config" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6),
  "updated_at" timestamp(6),
  "created_by" varchar(100) COLLATE "pg_catalog"."default",
  "updated_by" varchar(100) COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_metric_query_default_config
-- ----------------------------

-- ----------------------------
-- Table structure for s2_model
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_model";
CREATE TABLE "heating_analytics"."s2_model" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_model_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "biz_name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "domain_id" int8,
  "alias" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "status" int2,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "viewer" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "view_org" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "admin" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "admin_org" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "is_open" int2,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "created_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "updated_at" timestamp(6),
  "entity" text COLLATE "pg_catalog"."default",
  "drill_down_dimensions" text COLLATE "pg_catalog"."default",
  "database_id" int4 NOT NULL,
  "model_detail" text COLLATE "pg_catalog"."default" NOT NULL,
  "source_type" varchar(128) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "depends" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "filter_sql" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "tag_object_id" int4 DEFAULT 0,
  "ext" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_model
-- ----------------------------
INSERT INTO "heating_analytics"."s2_model" VALUES (1, '用户部门', 'user_department', 1, NULL, 1, '用户部门信息', 'admin,tom,jack', '1', 'admin,alice', '', NULL, 'admin', '2026-04-13 11:04:53.333', 'admin', '2026-04-13 11:04:53.333', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"select * from s2_user_department","identifiers":[{"name":"用户名","type":"primary","bizName":"user_name","isCreateDimension":1,"fieldName":"user_name"}],"dimensions":[{"name":"部门","type":"categorical","expr":"department","isCreateDimension":1,"bizName":"department","description":"部门","fieldName":"department"},{"name":"用户名","type":"primary_key","expr":"user_name","bizName":"user_name","description":"用户名","fieldName":"user_name"}],"measures":[],"fields":[{"fieldName":"user_name","dataType":"Varchar"},{"fieldName":"department","dataType":"Varchar"}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (2, 'PVUV统计', 's2_pv_uv_statis', 1, NULL, 1, 'PVUV统计', 'admin,tom,jack', '1', 'admin', '', NULL, 'admin', '2026-04-13 11:04:53.456', 'admin', '2026-04-13 11:04:53.456', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"SELECT * FROM s2_pv_uv_statis","identifiers":[{"name":"用户名","type":"foreign","bizName":"user_name","isCreateDimension":1,"fieldName":"user_name"}],"dimensions":[{"name":"数据日期","type":"partition_time","expr":"imp_date","dateFormat":"yyyy-MM-dd","typeParams":{"isPrimary":"true","timeGranularity":"day"},"isCreateDimension":1,"bizName":"imp_date","description":"数据日期","fieldName":"imp_date"},{"name":"","type":"categorical","expr":"page","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"page","fieldName":"page"},{"name":"用户名","type":"foreign_key","expr":"user_name","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"user_name","description":"用户名","fieldName":"user_name"}],"measures":[],"fields":[{"fieldName":"user_name","dataType":"Varchar"},{"fieldName":"imp_date","dataType":"Date"},{"fieldName":"page","dataType":"Varchar"}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (3, '停留时长统计', 's2_stay_time_statis', 1, NULL, 1, '停留时长统计', 'admin,jack', '1', 'admin', '', NULL, 'admin', '2026-04-13 11:04:53.482', 'admin', '2026-04-13 11:04:53.482', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"select * from s2_stay_time_statis","identifiers":[{"name":"用户名","type":"foreign","bizName":"user_name","isCreateDimension":1,"fieldName":"user_name"}],"dimensions":[{"name":"数据日期","type":"partition_time","expr":"imp_date","dateFormat":"yyyy-MM-dd","typeParams":{"isPrimary":"true","timeGranularity":"day"},"isCreateDimension":1,"bizName":"imp_date","description":"数据日期","fieldName":"imp_date"},{"name":"页面","type":"categorical","expr":"page","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"visits_page","description":"页面","fieldName":"page"},{"name":"用户名","type":"foreign_key","expr":"user_name","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"user_name","description":"用户名","fieldName":"user_name"},{"name":"页面","type":"categorical","expr":"page","bizName":"page","description":"页面","fieldName":"page"}],"measures":[{"name":"停留时长","agg":"SUM","expr":"stay_hours","bizName":"stay_hours","isCreateMetric":1,"fieldName":"stay_hours"}],"fields":[{"fieldName":"user_name","dataType":"Varchar"},{"fieldName":"imp_date","dataType":"Date"},{"fieldName":"page","dataType":"Varchar"},{"fieldName":"stay_hours","dataType":"Double"},{"fieldName":"visits_page","dataType":""}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (4, '公司维度', 'company', 2, NULL, 1, NULL, 'admin,tom,jack', '1', 'admin', '', NULL, 'admin', '2026-04-13 11:04:54.431', 'admin', '2026-04-13 11:04:54.431', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"SELECT * FROM company","identifiers":[{"name":"公司id","type":"primary","bizName":"company_id","isCreateDimension":1,"fieldName":"company_id"}],"dimensions":[{"name":"公司名称","type":"categorical","expr":"company_name","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"company_name","description":"公司名称","fieldName":"company_name"},{"name":"总部地点","type":"categorical","expr":"headquarter_address","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"headquarter_address","description":"总部地点","fieldName":"headquarter_address"},{"name":"成立时间","type":"time","expr":"company_established_time","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"company_established_time","description":"成立时间","fieldName":"company_established_time"},{"name":"创始人","type":"categorical","expr":"founder","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"founder","description":"创始人","fieldName":"founder"},{"name":"首席执行官","type":"categorical","expr":"ceo","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"ceo","description":"首席执行官","fieldName":"ceo"},{"name":"公司id","type":"primary_key","expr":"company_id","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"company_id","description":"公司id","fieldName":"company_id"}],"measures":[{"name":"年营业额","agg":"SUM","expr":"annual_turnover","bizName":"annual_turnover","isCreateMetric":1,"fieldName":"annual_turnover"},{"name":"员工数","agg":"SUM","expr":"employee_count","bizName":"employee_count","isCreateMetric":1,"fieldName":"employee_count"}],"fields":[{"fieldName":"annual_turnover","dataType":""},{"fieldName":"employee_count","dataType":""},{"fieldName":"company_name","dataType":""},{"fieldName":"headquarter_address","dataType":""},{"fieldName":"company_established_time","dataType":""},{"fieldName":"founder","dataType":""},{"fieldName":"ceo","dataType":""},{"fieldName":"company_id","dataType":""}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (6, '品牌历年收入', 'brand_revenue', 2, NULL, 1, NULL, 'admin,tom,jack', '1', 'admin', '', NULL, 'admin', '2026-04-13 11:04:54.859', 'admin', '2026-04-13 11:04:54.859', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"SELECT * FROM brand_revenue","identifiers":[{"name":"品牌id","type":"foreign","bizName":"brand_id","isCreateDimension":1,"fieldName":"brand_id"}],"dimensions":[{"name":"财年","type":"time","expr":"year_time","dateFormat":"yyyy","typeParams":{"isPrimary":"false","timeGranularity":"year"},"isCreateDimension":1,"bizName":"year_time","description":"财年","fieldName":"year_time"},{"name":"品牌id","type":"foreign_key","expr":"brand_id","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"brand_id","description":"品牌id","fieldName":"brand_id"}],"measures":[{"name":"营收","agg":"SUM","expr":"revenue","bizName":"revenue","isCreateMetric":1,"fieldName":"revenue"},{"name":"利润","agg":"SUM","expr":"profit","bizName":"profit","isCreateMetric":1,"fieldName":"profit"},{"name":"营收同比增长","agg":"AVG","expr":"revenue_growth_year_on_year","bizName":"revenue_growth_year_on_year","isCreateMetric":1,"fieldName":"revenue_growth_year_on_year"},{"name":"利润同比增长","agg":"AVG","expr":"profit_growth_year_on_year","bizName":"profit_growth_year_on_year","isCreateMetric":1,"fieldName":"profit_growth_year_on_year"}],"fields":[{"fieldName":"revenue","dataType":""},{"fieldName":"profit","dataType":""},{"fieldName":"revenue_growth_year_on_year","dataType":""},{"fieldName":"profit_growth_year_on_year","dataType":""},{"fieldName":"year_time","dataType":""},{"fieldName":"brand_id","dataType":""}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (5, '品牌维度', 'brand', 2, NULL, 1, NULL, 'admin,tom,jack', '1', 'admin', '', NULL, 'admin', '2026-04-13 11:04:54.716', 'admin', '2026-04-13 11:04:54.716', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"SELECT * FROM brand","identifiers":[{"name":"品牌id","type":"primary","bizName":"brand_id","isCreateDimension":1,"fieldName":"brand_id"},{"name":"公司id","type":"foreign","bizName":"company_id","isCreateDimension":1,"fieldName":"company_id"}],"dimensions":[{"name":"品牌名称","type":"categorical","expr":"brand_name","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"brand_name","description":"品牌名称","fieldName":"brand_name"},{"name":"品牌成立时间","type":"time","expr":"brand_established_time","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"brand_established_time","description":"品牌成立时间","fieldName":"brand_established_time"},{"name":"法定代表人","type":"categorical","expr":"legal_representative","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"legal_representative","description":"法定代表人","fieldName":"legal_representative"},{"name":"品牌id","type":"primary_key","expr":"brand_id","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"brand_id","description":"品牌id","fieldName":"brand_id"},{"name":"公司id","type":"foreign_key","expr":"company_id","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"company_id","description":"公司id","fieldName":"company_id"}],"measures":[{"name":"注册资本","agg":"MAX","expr":"registered_capital","bizName":"registered_capital","isCreateMetric":1,"fieldName":"registered_capital"}],"fields":[{"fieldName":"registered_capital","dataType":""},{"fieldName":"brand_name","dataType":""},{"fieldName":"brand_established_time","dataType":""},{"fieldName":"legal_representative","dataType":""},{"fieldName":"brand_id","dataType":""},{"fieldName":"company_id","dataType":""}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (7, '歌手库', 'singer', 3, NULL, 1, '歌手库', 'admin,tom,jack', '1', 'admin', '', NULL, 'admin', '2026-04-13 11:04:54.965', 'admin', '2026-04-13 11:04:54.965', NULL, 'null', 1, '{"queryType":"sql_query","sqlQuery":"select singer_name, act_area, song_name, genre, js_play_cnt, down_cnt, favor_cnt from singer","identifiers":[{"name":"歌手名","type":"primary","bizName":"singer_name","isCreateDimension":1,"fieldName":"singer_name"}],"dimensions":[{"name":"活跃区域","type":"categorical","expr":"act_area","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"act_area","description":"活跃区域","fieldName":"act_area"},{"name":"代表作","type":"categorical","expr":"song_name","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"song_name","description":"代表作","fieldName":"song_name"},{"name":"流派","type":"categorical","expr":"genre","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"genre","description":"流派","fieldName":"genre"},{"name":"歌手名","type":"primary_key","expr":"singer_name","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"singer_name","description":"歌手名","fieldName":"singer_name"}],"measures":[{"name":"播放量","agg":"sum","expr":"js_play_cnt","bizName":"js_play_cnt","isCreateMetric":1,"fieldName":"js_play_cnt"},{"name":"下载量","agg":"sum","expr":"down_cnt","bizName":"down_cnt","isCreateMetric":1,"fieldName":"down_cnt"},{"name":"收藏量","agg":"sum","expr":"favor_cnt","bizName":"favor_cnt","isCreateMetric":1,"fieldName":"favor_cnt"}],"fields":[{"fieldName":"js_play_cnt","dataType":""},{"fieldName":"down_cnt","dataType":""},{"fieldName":"favor_cnt","dataType":""},{"fieldName":"act_area","dataType":""},{"fieldName":"song_name","dataType":""},{"fieldName":"genre","dataType":""},{"fieldName":"singer_name","dataType":""}],"sqlVariables":[]}', NULL, NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (24, '面积维度模型', 'sf_dim_area', 11, '供热面积', 1, '供热面积维度', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.29', 'admin', '2026-04-14 12:08:47.235', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT id as area_id, customer_id, mjlb, djlb, jsfs, sfmj, zdmj, symj FROM area WHERE zf = 0","tableQuery":"","identifiers":[{"name":"面积ID","type":"primary","bizName":"area_id","isCreateDimension":1,"fieldName":"area_id"}],"dimensions":[{"name":"面积类别","type":"categorical","expr":"mjlb","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"mjlb","fieldName":"mjlb"},{"name":"单价类别","type":"categorical","expr":"djlb","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"djlb","fieldName":"djlb"},{"name":"结算方式","type":"categorical","expr":"jsfs","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"jsfs","fieldName":"jsfs"},{"name":"面积ID","type":"primary_key","expr":"area_id","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"area_id","description":"面积ID","fieldName":"area_id"}],"measures":[{"name":"收费面积汇总","agg":"SUM","expr":"sfmj","bizName":"sfmj","isCreateMetric":1,"fieldName":"sfmj"},{"name":"建筑面积汇总","agg":"SUM","expr":"zdmj","bizName":"zdmj","isCreateMetric":1,"fieldName":"zdmj"}],"fields":[{"fieldName":"area_id","dataType":"BIGINT"},{"fieldName":"customer_id","dataType":"BIGINT"},{"fieldName":"mjlb","dataType":"VARCHAR"},{"fieldName":"djlb","dataType":"VARCHAR"},{"fieldName":"jsfs","dataType":"VARCHAR"},{"fieldName":"sfmj","dataType":"DECIMAL"},{"fieldName":"zdmj","dataType":"DECIMAL"},{"fieldName":"symj","dataType":"DECIMAL"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (26, '收费结算事实模型', 'sf_rpt_charge', 12, '收费结算', 1, '收费结算核心事实表', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.297', 'admin', '2026-04-14 13:06:32.575', NULL, '[]', 2, '{"queryType": "sql_query", "sqlQuery": "SELECT c.one as org_level1, c.two as org_level2, c.three as org_level3,\n        s.cnq, s.fylb, s.ysje, s.sfje, s.qfje, s.wyje, s.zkje, s.hjje\n        FROM sf_js_t s\n        LEFT JOIN customer c ON s.customer_id = c.id\n        WHERE s.zf = 0", "identifiers": [{"name": "采暖期", "type": "primary", "bizName": "cnq", "isCreateDimension": 1, "fieldName": "cnq"}], "dimensions": [{"name": "采暖期", "type": "categorical", "expr": "cnq", "bizName": "cnq", "fieldName": "cnq"}, {"name": "费用类别", "type": "categorical", "expr": "fylb", "bizName": "fylb", "fieldName": "fylb"}, {"name": "分公司", "type": "categorical", "expr": "org_level1", "bizName": "org_level1", "fieldName": "org_level1"}, {"name": "热力站", "type": "categorical", "expr": "org_level2", "bizName": "org_level2", "fieldName": "org_level2"}, {"name": "小区", "type": "categorical", "expr": "org_level3", "bizName": "org_level3", "fieldName": "org_level3"}], "measures": [{"name": "应收金额", "agg": "SUM", "expr": "ysje", "bizName": "ysje", "isCreateMetric": 1, "fieldName": "ysje"}, {"name": "实收金额", "agg": "SUM", "expr": "sfje", "bizName": "sfje", "isCreateMetric": 1, "fieldName": "sfje"}, {"name": "欠费金额", "agg": "SUM", "expr": "qfje", "bizName": "qfje", "isCreateMetric": 1, "fieldName": "qfje"}, {"name": "违约金额", "agg": "SUM", "expr": "wyje", "bizName": "wyje", "isCreateMetric": 1, "fieldName": "wyje"}, {"name": "折扣金额", "agg": "SUM", "expr": "zkje", "bizName": "zkje", "isCreateMetric": 1, "fieldName": "zkje"}, {"name": "核减金额", "agg": "SUM", "expr": "hjje", "bizName": "hjje", "isCreateMetric": 1, "fieldName": "hjje"}], "fields": [{"fieldName": "cnq", "dataType": "Varchar"}, {"fieldName": "fylb", "dataType": "Varchar"}, {"fieldName": "org_level1", "dataType": "Varchar"}, {"fieldName": "org_level2", "dataType": "Varchar"}, {"fieldName": "org_level3", "dataType": "Varchar"}, {"fieldName": "ysje", "dataType": "Decimal"}, {"fieldName": "sfje", "dataType": "Decimal"}, {"fieldName": "qfje", "dataType": "Decimal"}, {"fieldName": "wyje", "dataType": "Decimal"}, {"fieldName": "zkje", "dataType": "Decimal"}, {"fieldName": "hjje", "dataType": "Decimal"}], "sqlVariables": []}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (23, '组织维度模型', 'sf_dim_org', 11, '组织架构', 1, '组织架构维度', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.286', 'admin', '2026-04-14 12:14:44.601', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT DISTINCT one, two, three FROM customer WHERE zf = 0","tableQuery":"","identifiers":[{"name":"分公司","type":"primary","bizName":"org_level1","isCreateDimension":1,"fieldName":"org_level1"}],"dimensions":[{"name":"分公司","type":"categorical","expr":"one","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"one","fieldName":"one"},{"name":"热力站","type":"categorical","expr":"two","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"two","fieldName":"two"},{"name":"小区","type":"categorical","expr":"three","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"three","fieldName":"three"},{"name":"分公司","type":"primary_key","expr":"org_level1","bizName":"org_level1","description":"分公司","fieldName":"org_level1"}],"measures":[],"fields":[{"fieldName":"one","dataType":"VARCHAR"},{"fieldName":"two","dataType":"VARCHAR"},{"fieldName":"three","dataType":"VARCHAR"},{"fieldName":"org_level1","dataType":""}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (28, '停供复供事实模型', 'sf_fact_stop_restart', 14, '停供复供', 1, '停供复供业务事实表', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.41', 'admin', '2026-04-14 12:21:18.021', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT id, customer_id, cnq, type, cljg, fmzt, czsj FROM sf_ksgs_t WHERE zf = 0","tableQuery":"","identifiers":[{"name":"ID","type":"primary","bizName":"id","isCreateDimension":1,"fieldName":"id"}],"dimensions":[{"name":"申请日期","type":"time","expr":"czsj","dateFormat":"yyyy-MM-dd","typeParams":{"isPrimary":"true","timeGranularity":""},"isCreateDimension":0,"bizName":"czsj","fieldName":"czsj"},{"name":"采暖期","type":"categorical","expr":"cnq","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"cnq","fieldName":"cnq"},{"name":"业务类型","type":"categorical","expr":"type","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"type","fieldName":"type"},{"name":"处理结果","type":"categorical","expr":"cljg","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"cljg","fieldName":"cljg"},{"name":"阀门状态","type":"categorical","expr":"fmzt","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"fmzt","fieldName":"fmzt"},{"name":"ID","type":"primary_key","expr":"id","bizName":"id","description":"ID","fieldName":"id"}],"measures":[],"fields":[{"fieldName":"id","dataType":"BIGINT"},{"fieldName":"customer_id","dataType":"BIGINT"},{"fieldName":"cnq","dataType":"VARCHAR"},{"fieldName":"type","dataType":"VARCHAR"},{"fieldName":"cljg","dataType":"VARCHAR"},{"fieldName":"fmzt","dataType":"VARCHAR"},{"fieldName":"czsj","dataType":"DATETIME"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (31, '作废记录统计模型', 'sf_cancel_stat', 15, '作废统计', 1, '收费作废记录统计', '', '', '', '', NULL, 'admin', '2026-04-14 04:21:22.228', 'admin', '2026-04-14 13:07:41.832', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT DATE_FORMAT(created_time, ''%Y-%m'') as stat_month, COUNT(*) as cancel_count FROM pay_order WHERE zf = 1 GROUP BY DATE_FORMAT(created_time, ''%Y-%m'')","tableQuery":"","identifiers":[],"dimensions":[],"measures":[{"name":"统计月份","agg":"sum","expr":"stat_month","bizName":"stat_month","isCreateMetric":1,"fieldName":"stat_month"},{"name":"作废笔数","agg":"SUM","expr":"cancel_count","bizName":"cancel_count","isCreateMetric":1,"fieldName":"cancel_count"}],"fields":[{"fieldName":"stat_month","dataType":"Varchar"},{"fieldName":"cancel_count","dataType":"Bigint"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (27, '收费明细事实模型', 'sf_rpt_payment', 13, '收费明细', 1, '收费明细事实表', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.301', 'admin', '2026-04-14 12:19:23.139', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT id, customer_id, cnq, fylb, sfje, sfrq bill_date, sffs, zfqd source FROM sf_mjsf_t WHERE zf = 0 ","tableQuery":"","identifiers":[],"dimensions":[{"name":"收费日期","type":"time","expr":"bill_date","dateFormat":"yyyy-MM-dd","typeParams":{"isPrimary":"true","timeGranularity":""},"isCreateDimension":0,"bizName":"bill_date","fieldName":"bill_date"},{"name":"采暖期","type":"categorical","expr":"cnq","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"cnq","fieldName":"cnq"},{"name":"费用类别","type":"categorical","expr":"fylb","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"fylb","fieldName":"fylb"},{"name":"收费方式","type":"categorical","expr":"sffs","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"sffs","fieldName":"sffs"},{"name":"支付渠道","type":"categorical","expr":"source","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"source","fieldName":"source"}],"measures":[{"name":"收费笔数","agg":"COUNT","expr":"id","bizName":"id","isCreateMetric":1,"fieldName":"id"},{"name":"实收金额","agg":"SUM","expr":"sfje","bizName":"sfje","isCreateMetric":1,"fieldName":"sfje"}],"fields":[{"fieldName":"id","dataType":"BIGINT"},{"fieldName":"customer_id","dataType":"BIGINT"},{"fieldName":"cnq","dataType":"VARCHAR"},{"fieldName":"fylb","dataType":"VARCHAR"},{"fieldName":"sfje","dataType":"DECIMAL"},{"fieldName":"bill_date","dataType":"DATETIME"},{"fieldName":"sffs","dataType":"VARCHAR"},{"fieldName":"source","dataType":"VARCHAR"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (29, '采暖期收费汇总模型', 'sf_rpt_cnq_charge', 14, '采暖期汇总', 1, '采暖期收费汇总表', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.52', 'admin', '2026-04-14 13:07:05.57', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT cnq, COUNT(DISTINCT customer_id) as customer_cnt, SUM(ysje) as ysje_sum, SUM(sfje) as sfje_sum, SUM(sfmj) as sfmj_sum FROM sf_mj_t WHERE zf = 0 GROUP BY cnq","tableQuery":"","identifiers":[],"dimensions":[{"name":"采暖期","type":"categorical","expr":"cnq","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"cnq","description":"采暖期","fieldName":"cnq"}],"measures":[{"name":"用户数","agg":"SUM","expr":"customer_cnt","bizName":"customer_cnt","isCreateMetric":1,"fieldName":"customer_cnt"},{"name":"收费面积","agg":"SUM","expr":"sfmj_sum","bizName":"sfmj_sum","isCreateMetric":1,"fieldName":"sfmj_sum"},{"name":"应收金额","agg":"SUM","expr":"ysje_sum","bizName":"ysje_sum","isCreateMetric":1,"fieldName":"ysje_sum"},{"name":"实收金额","agg":"SUM","expr":"sfje_sum","bizName":"sfje_sum","isCreateMetric":1,"fieldName":"sfje_sum"}],"fields":[{"fieldName":"cnq","dataType":"Varchar"},{"fieldName":"customer_cnt","dataType":"Bigint"},{"fieldName":"sfmj_sum","dataType":"Decimal"},{"fieldName":"ysje_sum","dataType":"Decimal"},{"fieldName":"sfje_sum","dataType":"Decimal"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (30, '数据质量监控模型', 'sf_quality_monitor', 15, '质量监控', 1, '数据质量监控指标', '', '', '', '', NULL, 'admin', '2026-04-14 04:21:22.105', 'admin', '2026-04-14 13:07:20.095', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT cnq, COUNT(DISTINCT customer_id) as total_customers, SUM(CASE WHEN sfje > 0 THEN 1 ELSE 0 END) as paid_customers, SUM(CASE WHEN qfje > 0 THEN 1 ELSE 0 END) as arrears_customers, SUM(qfje) as total_arrears FROM sf_js_t WHERE zf = 0 GROUP BY cnq","tableQuery":"","identifiers":[],"dimensions":[{"name":"采暖期","type":"categorical","expr":"cnq","dateFormat":"yyyy-MM-dd","isCreateDimension":1,"bizName":"cnq","description":"采暖期","fieldName":"cnq"}],"measures":[{"name":"总用户数","agg":"SUM","expr":"total_customers","bizName":"total_customers","isCreateMetric":1,"fieldName":"total_customers"},{"name":"已缴费用户数","agg":"SUM","expr":"paid_customers","bizName":"paid_customers","isCreateMetric":1,"fieldName":"paid_customers"},{"name":"欠费用户数","agg":"SUM","expr":"arrears_customers","bizName":"arrears_customers","isCreateMetric":1,"fieldName":"arrears_customers"},{"name":"欠费总额","agg":"SUM","expr":"total_arrears","bizName":"total_arrears","isCreateMetric":1,"fieldName":"total_arrears"}],"fields":[{"fieldName":"cnq","dataType":"Varchar"},{"fieldName":"total_customers","dataType":"Bigint"},{"fieldName":"paid_customers","dataType":"Bigint"},{"fieldName":"arrears_customers","dataType":"Bigint"},{"fieldName":"total_arrears","dataType":"Decimal"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (25, '时间维度模型', 'sf_dim_time', 11, '时间维度', 1, '时间维度', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.294', 'admin', '2026-04-14 12:15:02.229', NULL, '[]', 2, '{"queryType":"sql_query","sqlQuery":"SELECT DATE_FORMAT(created_time, ''%Y-%m-%d'') as date_id, YEAR(created_time) as year_num, MONTH(created_time) as month_num, QUARTER(created_time) as quarter_num FROM sf_mj_t WHERE zf = 0 GROUP BY DATE_FORMAT(created_time, ''%Y-%m-%d''), YEAR(created_time), MONTH(created_time), QUARTER(created_time)","tableQuery":"","identifiers":[{"name":"日期","type":"primary","bizName":"date_id","isCreateDimension":1,"fieldName":"date_id"}],"dimensions":[{"name":"年份","type":"categorical","expr":"year_num","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"year_num","fieldName":"year_num"},{"name":"月份","type":"categorical","expr":"month_num","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"month_num","fieldName":"month_num"},{"name":"季度","type":"categorical","expr":"quarter_num","dateFormat":"yyyy-MM-dd","isCreateDimension":0,"bizName":"quarter_num","fieldName":"quarter_num"},{"name":"日期","type":"primary_key","expr":"date_id","bizName":"date_id","description":"日期","fieldName":"date_id"}],"measures":[],"fields":[{"fieldName":"date_id","dataType":"VARCHAR"},{"fieldName":"year_num","dataType":"INT"},{"fieldName":"month_num","dataType":"INT"},{"fieldName":"quarter_num","dataType":"INT"}],"sqlVariables":[]}', 'SQL', NULL, NULL, 0, NULL);
INSERT INTO "heating_analytics"."s2_model" VALUES (22, '用户维度模型', 'sf_dim_customer', 11, '用户信息', 1, '热用户基本信息', '', '', '', '', NULL, 'admin', '2026-04-14 03:47:08.28', 'admin', '2026-04-14 12:07:10.172', NULL, '[]', 2, '{"queryType": "sql_query", "sqlQuery": "SELECT id as customer_id, code as customer_code, name as customer_name, yhlx, mob_no, rwrq, kz_hmd, kz_sf, one, two, three, rlz_id FROM customer WHERE zf = 0", "identifiers": [{"name": "用户ID", "type": "primary", "bizName": "customer_id", "isCreateDimension": 1, "fieldName": "customer_id"}], "dimensions": [{"name": "用户ID", "type": "primary_key", "expr": "customer_id", "bizName": "customer_id", "fieldName": "customer_id"}, {"name": "用户编码", "type": "categorical", "expr": "customer_code", "bizName": "customer_code", "fieldName": "customer_code"}, {"name": "用户名称", "type": "categorical", "expr": "customer_name", "bizName": "customer_name", "fieldName": "customer_name"}, {"name": "用户类型", "type": "categorical", "expr": "yhlx", "bizName": "yhlx", "fieldName": "yhlx"}, {"name": "手机号码", "type": "categorical", "expr": "mob_no", "bizName": "mob_no", "fieldName": "mob_no"}, {"name": "入网日期", "type": "time", "expr": "rwrq", "bizName": "rwrq", "fieldName": "rwrq"}, {"name": "黑名单标识", "type": "categorical", "expr": "kz_hmd", "bizName": "kz_hmd", "fieldName": "kz_hmd"}, {"name": "允许收费标识", "type": "categorical", "expr": "kz_sf", "bizName": "kz_sf", "fieldName": "kz_sf"}, {"name": "分公司", "type": "categorical", "expr": "one", "bizName": "org_level1", "fieldName": "one"}, {"name": "热力站", "type": "categorical", "expr": "two", "bizName": "org_level2", "fieldName": "two"}, {"name": "小区", "type": "categorical", "expr": "three", "bizName": "org_level3", "fieldName": "three"}, {"name": "热力站ID", "type": "categorical", "expr": "rlz_id", "bizName": "rlz_id", "fieldName": "rlz_id"}], "measures": [{"name": "用户总数", "agg": "COUNT", "expr": "customer_id", "bizName": "USER_CNT", "isCreateMetric": 1, "fieldName": "customer_id"}], "fields": [{"fieldName": "customer_id", "dataType": "Bigint"}, {"fieldName": "customer_code", "dataType": "Varchar"}, {"fieldName": "customer_name", "dataType": "Varchar"}, {"fieldName": "yhlx", "dataType": "Varchar"}, {"fieldName": "mob_no", "dataType": "Varchar"}, {"fieldName": "rwrq", "dataType": "Date"}, {"fieldName": "kz_hmd", "dataType": "Smallint"}, {"fieldName": "kz_sf", "dataType": "Smallint"}, {"fieldName": "one", "dataType": "Varchar"}, {"fieldName": "two", "dataType": "Varchar"}, {"fieldName": "three", "dataType": "Varchar"}, {"fieldName": "rlz_id", "dataType": "Bigint"}], "sqlVariables": []}', 'SQL', NULL, NULL, 0, NULL);

-- ----------------------------
-- Table structure for s2_model_rela
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_model_rela";
CREATE TABLE "heating_analytics"."s2_model_rela" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_model_rela_id_seq'::regclass),
  "domain_id" int8,
  "from_model_id" int8,
  "to_model_id" int8,
  "join_type" varchar(255) COLLATE "pg_catalog"."default",
  "join_condition" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_model_rela
-- ----------------------------

-- ----------------------------
-- Table structure for s2_plugin
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_plugin";
CREATE TABLE "heating_analytics"."s2_plugin" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_plugin_id_seq'::regclass),
  "type" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "data_set" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "pattern" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "parse_mode" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "parse_mode_config" text COLLATE "pg_catalog"."default",
  "name" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "created_at" timestamp(6),
  "created_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "config" text COLLATE "pg_catalog"."default",
  "comment" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_plugin
-- ----------------------------
INSERT INTO "heating_analytics"."s2_plugin" VALUES (1, 'WEB_SERVICE', '-1', '用于分析超音数的流量概况，包含UV、PV等核心指标的追踪。P.S. 仅作为示例展示，无实际内容', NULL, '{"description":"用于分析超音数的流量概况，包含UV、PV等核心指标的追踪。P.S. 仅作为示例展示，无实际内容","examples":["tom最近访问超音数情况怎么样"],"name":"超音数流量分析小助手"}', '超音数流量分析小助手', '2026-04-13 11:04:54.353', 'admin', '2026-04-13 11:04:54.353', 'admin', '{"url":"http://localhost:9080/api/chat/plugin/pluginDemo","paramOptions":[],"params":[]}', NULL);

-- ----------------------------
-- Table structure for s2_pv_uv_statis
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_pv_uv_statis";
CREATE TABLE "heating_analytics"."s2_pv_uv_statis" (
  "imp_date" date NOT NULL,
  "user_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "page" varchar(200) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of s2_pv_uv_statis
-- ----------------------------
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-12', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-12', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-12', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-12', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-12', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-12', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-07', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-06', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'john', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'jack', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-11', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-22', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-30', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-05', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-14', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'jack', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'lucy', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-26', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'dean', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-23', 'alice', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-24', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'dean', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-04', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-27', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'tom', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'alice', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'tom', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'john', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-20', 'dean', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'lucy', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'tom', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-01', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-16', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-10', 'jack', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-21', 'jack', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-29', 'john', 'p2');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'tom', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'lucy', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-15', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-08', 'dean', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'lucy', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-18', 'jack', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-25', 'lucy', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-19', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-28', 'john', 'p1');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-03', 'alice', 'p3');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-09', 'alice', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-04-02', 'tom', 'p4');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-31', 'dean', 'p5');
INSERT INTO "heating_analytics"."s2_pv_uv_statis" VALUES ('2026-03-17', 'tom', 'p4');

-- ----------------------------
-- Table structure for s2_query_rule
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_query_rule";
CREATE TABLE "heating_analytics"."s2_query_rule" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_query_rule_id_seq'::regclass),
  "data_set_id" int8,
  "priority" int4 NOT NULL DEFAULT 1,
  "rule_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "biz_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "rule" text COLLATE "pg_catalog"."default",
  "action" text COLLATE "pg_catalog"."default",
  "status" int4 NOT NULL DEFAULT 1,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "ext" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_query_rule
-- ----------------------------

-- ----------------------------
-- Table structure for s2_query_stat_info
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_query_stat_info";
CREATE TABLE "heating_analytics"."s2_query_stat_info" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_query_stat_info_id_seq'::regclass),
  "trace_id" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "model_id" int8,
  "data_set_id" int8,
  "query_user" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "created_at" timestamp(6) DEFAULT CURRENT_TIMESTAMP,
  "query_type" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_type_back" int4 DEFAULT 0,
  "query_sql_cmd" text COLLATE "pg_catalog"."default",
  "sql_cmd_md5" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_struct_cmd" text COLLATE "pg_catalog"."default",
  "struct_cmd_md5" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_sql" text COLLATE "pg_catalog"."default",
  "sql_md5" varchar(200) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "query_engine" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "elapsed_ms" int8,
  "query_state" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "native_query" bool DEFAULT false,
  "start_date" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "end_date" varchar(50) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "dimensions" text COLLATE "pg_catalog"."default",
  "metrics" text COLLATE "pg_catalog"."default",
  "select_cols" text COLLATE "pg_catalog"."default",
  "agg_cols" text COLLATE "pg_catalog"."default",
  "filter_cols" text COLLATE "pg_catalog"."default",
  "group_by_cols" text COLLATE "pg_catalog"."default",
  "order_by_cols" text COLLATE "pg_catalog"."default",
  "use_result_cache" bool DEFAULT false,
  "use_sql_cache" bool DEFAULT false,
  "sql_cache_key" text COLLATE "pg_catalog"."default",
  "result_cache_key" text COLLATE "pg_catalog"."default",
  "query_opt_mode" varchar(20) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_query_stat_info
-- ----------------------------
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (1, '', 1, NULL, NULL, '2026-04-13 11:03:46.007308', 'SQL', 0, 'QuerySqlReq(sql=SELECT department, count(1) FROM (SELECT * FROM s2_user_department) AS t GROUP BY department ORDER BY count(1) DESC LIMIT 100000, limit=1000)', '75ebc4f1e1b160d2629faaad52289c27', NULL, NULL, NULL, NULL, NULL, 323, 'success', 'f', NULL, NULL, '["department"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:1:b0335ce340dc168ef5bf497b46acdd5e', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (2, '', 1, NULL, NULL, '2026-04-13 11:03:46.090012', 'SQL', 0, 'QuerySqlReq(sql=SELECT user_name, count(1) FROM (SELECT * FROM s2_user_department) AS t GROUP BY user_name ORDER BY count(1) DESC LIMIT 100000, limit=1000)', '3b616000dd5ba0c931637f1059e429b6', NULL, NULL, NULL, NULL, NULL, 9, 'success', 'f', NULL, NULL, '["user_name"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:1:02b3f24e438ccf6060f2821f7ccd9d1b', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (3, '', 4, NULL, NULL, '2026-04-13 11:03:46.402625', 'SQL', 0, 'QuerySqlReq(sql=SELECT company_name, count(1) FROM (SELECT * FROM company) AS t GROUP BY company_name ORDER BY count(1) DESC LIMIT 100000, limit=1000)', '38c583d766b25449eb5d8e6cbfe4318e', NULL, NULL, NULL, NULL, NULL, 36, 'success', 'f', NULL, NULL, '["company_name"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:4:dd33aaacd383b448ed5bfb63f0a2d2e9', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (4, '', 4, NULL, NULL, '2026-04-13 11:03:46.474853', 'SQL', 0, 'QuerySqlReq(sql=SELECT founder, count(1) FROM (SELECT * FROM company) AS t GROUP BY founder ORDER BY count(1) DESC LIMIT 100000, limit=1000)', 'f39f8e58ecf75551a566f08c368b6c99', NULL, NULL, NULL, NULL, NULL, 12, 'success', 'f', NULL, NULL, '["founder"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:4:d8482d789af694b52ebdd18d45e9bf70', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (5, '', 4, NULL, NULL, '2026-04-13 11:03:46.554292', 'SQL', 0, 'QuerySqlReq(sql=SELECT ceo, count(1) FROM (SELECT * FROM company) AS t GROUP BY ceo ORDER BY count(1) DESC LIMIT 100000, limit=1000)', 'f03290bbf84493c78d8f64a5b50e6943', NULL, NULL, NULL, NULL, NULL, 13, 'success', 'f', NULL, NULL, '["ceo"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:4:1ff2ab16625fbab93528838636f0e5e5', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (6, '', 5, NULL, NULL, '2026-04-13 11:03:46.695227', 'SQL', 0, 'QuerySqlReq(sql=SELECT brand_name, count(1) FROM (SELECT * FROM brand) AS t GROUP BY brand_name ORDER BY count(1) DESC LIMIT 100000, limit=1000)', 'e509386da08f181b11c384ec92538359', NULL, NULL, NULL, NULL, NULL, 28, 'success', 'f', NULL, NULL, '["brand_name"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:5:4193fff2f8584baf0a30c763dd60b6cb', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (7, '', 7, NULL, NULL, '2026-04-13 11:03:46.918587', 'SQL', 0, 'QuerySqlReq(sql=SELECT act_area, count(1) FROM (SELECT singer_name, act_area, song_name, genre, js_play_cnt, down_cnt, favor_cnt FROM singer) AS t GROUP BY act_area ORDER BY count(1) DESC LIMIT 100000, limit=1000)', '49d260f364887861547d52b2dc7f4e27', NULL, NULL, NULL, NULL, NULL, 26, 'success', 'f', NULL, NULL, '["js_play_cnt","singer_name","genre","down_cnt","song_name","favor_cnt","act_area"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:7:555aaba53eb08004a3f88e5912e10a91', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (8, '', 7, NULL, NULL, '2026-04-13 11:03:47.065982', 'SQL', 0, 'QuerySqlReq(sql=SELECT genre, count(1) FROM (SELECT singer_name, act_area, song_name, genre, js_play_cnt, down_cnt, favor_cnt FROM singer) AS t GROUP BY genre ORDER BY count(1) DESC LIMIT 100000, limit=1000)', '9a0b6ab6727bd5b436ea0c86f447acce', NULL, NULL, NULL, NULL, NULL, 18, 'success', 'f', NULL, NULL, '["js_play_cnt","singer_name","genre","down_cnt","song_name","favor_cnt","act_area"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:7:fd1b0943e8c0d0a56127b1b3a4d92205', NULL);
INSERT INTO "heating_analytics"."s2_query_stat_info" VALUES (9, '', 7, NULL, NULL, '2026-04-13 11:03:47.138128', 'SQL', 0, 'QuerySqlReq(sql=SELECT singer_name, count(1) FROM (SELECT singer_name, act_area, song_name, genre, js_play_cnt, down_cnt, favor_cnt FROM singer) AS t GROUP BY singer_name ORDER BY count(1) DESC LIMIT 100000, limit=1000)', 'a7be3f37858189c977bacf0a2dc65232', NULL, NULL, NULL, NULL, NULL, 12, 'success', 'f', NULL, NULL, '["js_play_cnt","singer_name","genre","down_cnt","song_name","favor_cnt","act_area"]', '["1"]', NULL, NULL, NULL, NULL, NULL, 'f', 't', NULL, 'supersonic:dev:0:7:7ae52bff620dde2cdb637b9ae7c2e064', NULL);

-- ----------------------------
-- Table structure for s2_stay_time_statis
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_stay_time_statis";
CREATE TABLE "heating_analytics"."s2_stay_time_statis" (
  "imp_date" date NOT NULL,
  "user_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "stay_hours" float8 NOT NULL,
  "page" varchar(200) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of s2_stay_time_statis
-- ----------------------------
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.7636857512911863, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'dean', 0.17663327393462436, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'alice', 0.38943688941552057, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'lucy', 0.2715819955225307, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'tom', 0.9358210273119568, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'alice', 0.9364586435510802, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.9707723036513162, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'tom', 0.8497763866782723, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'alice', 0.15504417761372413, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.9507563118298399, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'alice', 0.9746364180572994, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'dean', 0.12869214941133378, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'lucy', 0.3024970533288409, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'tom', 0.6639702099980812, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'lucy', 0.4929901454858626, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'lucy', 0.06853040276026445, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.8488086078299616, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'lucy', 0.8589111177125592, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'alice', 0.5576357066482228, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'john', 0.8047888670006846, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'john', 0.766944548494366, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'lucy', 0.5280072184505449, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'tom', 0.9693343356046343, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'dean', 0.12805203958456424, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'dean', 0.16963603387027637, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'alice', 0.5901202956521101, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'jack', 0.12710364646712236, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'tom', 0.6346530909156196, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'dean', 0.12461289103639872, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'john', 0.9863947334662437, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'alice', 0.48899961064192987, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'alice', 0.5382796792688207, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'dean', 0.3506568687014143, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'jack', 0.8633072449771709, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'tom', 0.13999135315363687, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'john', 0.07258740493845894, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'jack', 0.5244413940436958, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'john', 0.13258670732966138, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'john', 0.6015982054464575, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'lucy', 0.05513158944480323, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'alice', 0.6707121735296985, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'jack', 0.9330440339006469, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'dean', 0.5630674323371607, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'dean', 0.8720647566229917, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.8331899070546519, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'alice', 0.6712876436249856, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'alice', 0.6694409980332703, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'john', 0.3703307480606334, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'dean', 0.775368688472696, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'lucy', 0.9151205443267096, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'tom', 0.09543108823305857, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'dean', 0.7893992120771057, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'lucy', 0.5119923080070498, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'lucy', 0.49906724167974936, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'tom', 0.046258282700961884, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'dean', 0.44843595680103954, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'alice', 0.7743935471689718, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.5855299615656824, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'lucy', 0.9412963512379853, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'jack', 0.8383247587082538, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'lucy', 0.14517876867236124, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'john', 0.9327229861441061, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.19042326582894153, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'jack', 0.6029067818254513, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'jack', 0.21715964747214422, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'lucy', 0.34259842721045974, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'john', 0.7064419016593382, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'lucy', 0.5725636566517865, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'john', 0.22332539583809208, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'jack', 0.8049036189055911, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'alice', 0.6029674758974956, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'lucy', 0.11884976360561716, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'alice', 0.7124916829130662, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'jack', 0.5893693718556829, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'alice', 0.602073304496253, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'tom', 0.10491061160039927, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'dean', 0.9006548872378379, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'alice', 0.8545144244288455, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'jack', 0.16915384987875726, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'dean', 0.2271640700690446, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'alice', 0.7807518577160636, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'john', 0.8919859648888653, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'dean', 0.1564450687270359, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'jack', 0.5840549187653847, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'tom', 0.2213255596777869, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'tom', 0.07868261880306426, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'jack', 0.07710010861455818, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'jack', 0.5131249730162654, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.5035035055368601, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.8996978291173905, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'john', 0.057442290722216294, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'jack', 0.6443079066865616, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'lucy', 0.7398098480748726, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'dean', 0.9835694815034591, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'john', 0.9879213445635557, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'jack', 0.4020136688147111, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'lucy', 0.6698797170128024, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.17325132416789113, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'lucy', 0.5784229486763606, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'tom', 0.9185978183932058, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'jack', 0.5474783153973963, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'alice', 0.9730731954700215, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'tom', 0.5390873359288765, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'alice', 0.20522241320887713, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'alice', 0.4088233242325021, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'jack', 0.7608047695853417, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.2749731221085713, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'john', 0.06154055374702494, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.460668002022406, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'alice', 0.4474746325306228, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'alice', 0.5761666885467472, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'dean', 0.33233441360339655, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'alice', 0.7426534909874778, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'tom', 0.5841437875889118, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'alice', 0.2818296500094526, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'tom', 0.8670888843915217, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'alice', 0.5249294365740248, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'jack', 0.5483356748008438, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'dean', 0.7278566847412673, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.6779976902157362, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'lucy', 0.09995341651736978, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'jack', 0.4528538159233879, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'alice', 0.5870756885301056, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'tom', 0.9842091927290255, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'tom', 0.04580936015706816, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'alice', 0.8814678270145769, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'john', 0.06517379256096412, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'alice', 0.8769832364187129, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'dean', 0.584562279025023, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'john', 0.8102404090621375, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'john', 0.11481653429176686, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'jack', 0.43422888918962554, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'lucy', 0.0684414272594508, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'alice', 0.976546463969412, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.617906858141431, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'jack', 0.08663740247579998, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'lucy', 0.7124944606691416, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'alice', 0.1321700521239627, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'jack', 0.3078946609431664, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'alice', 0.6149442855237194, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'alice', 0.5963801306980994, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'lucy', 0.6999542038973406, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'john', 0.4599112653446624, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'dean', 0.20300901401048832, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'john', 0.39989705958717037, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'jack', 0.2486378364940327, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'john', 0.16880398079144077, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'tom', 0.73927288385526, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'john', 0.8645283506689198, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'alice', 0.3266940826759587, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'tom', 0.9195490073037541, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'lucy', 0.9452523036658287, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'john', 0.21269683438120535, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.7377502855387184, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'tom', 0.38981597634408716, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.7001799391999863, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'john', 0.6616720024008785, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'dean', 0.497721735058096, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'jack', 0.22255613760959603, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'jack', 0.05247640233319417, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'dean', 0.27237572107833363, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'alice', 0.9529452406380252, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'alice', 0.28243045060463157, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'lucy', 0.17880444250082506, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'john', 0.035050038002381156, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'lucy', 0.840803223728221, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.5318457377361356, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.9280332892460665, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'lucy', 0.752354382202208, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'dean', 0.1866528331789219, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'alice', 0.7016165545791373, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'john', 0.4191547989960899, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'john', 0.7025516699007639, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'john', 0.6160127317884274, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'alice', 0.91223094958137, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'tom', 0.4383056089013998, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'jack', 0.595750781166582, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'lucy', 0.9472349338730268, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'jack', 0.0519104588842193, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'alice', 0.48043983034526205, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'lucy', 0.14754707786497478, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'alice', 0.36124288370035695, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'dean', 0.21777919493494613, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'lucy', 0.22637666702475057, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'john', 0.9378215576942598, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'john', 0.3309229261144562, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'alice', 0.7602880453727515, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'alice', 0.9470462487873785, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.6770215935547629, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'john', 0.1586074803669385, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'lucy', 0.2754855564794071, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'tom', 0.8355347738454384, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'alice', 0.7251813505573811, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'jack', 0.006606625589642534, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'alice', 0.304832277753024, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.026368662837989554, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'tom', 0.6855977520602776, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'tom', 0.8193746826441749, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.021179295102459972, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'jack', 0.1533849522536005, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'alice', 0.18893553542301778, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.39870999343833624, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'john', 0.9985665103520182, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'john', 0.6961441157700171, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.9861933923851885, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'tom', 0.993076500099477, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'alice', 0.4320547269058953, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'lucy', 0.18441071030375877, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'jack', 0.1501504986117118, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'tom', 0.252021845734527, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'lucy', 0.24442701577183745, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.07563738855797564, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'john', 0.34247820646440985, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.9456979276862031, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'alice', 0.19494357263973816, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'alice', 0.9371493867882469, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'john', 0.6136241316589367, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'alice', 0.8922330760877784, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'dean', 0.9001986074661864, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'tom', 0.4889702884422866, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'tom', 0.2689551234431401, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'dean', 0.5223573993758465, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'tom', 0.05042295556527243, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'tom', 0.2717147121880483, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'john', 0.7397093309370814, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'dean', 0.157064341631733, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'lucy', 0.7213399784998017, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'tom', 0.764081440588005, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.7514070600074144, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'john', 0.611647412825278, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'tom', 0.6600796877195596, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'john', 0.8942204153751679, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.07398121085929721, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'dean', 0.1652506990439564, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.5849759516111703, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'tom', 0.1672502732600889, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'tom', 0.7836135556233219, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'dean', 0.26181269644936356, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'alice', 0.6577275876355586, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'tom', 0.3067293364197956, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'alice', 0.8608288543866495, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'john', 0.814283434116926, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'jack', 0.33993584425872936, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'john', 0.010812798859160089, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.5156558224263926, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'jack', 0.46320035330198406, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'lucy', 0.2651020283994786, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.42467241545664147, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'tom', 0.3695905136678498, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'tom', 0.15269122123348644, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'jack', 0.6755688670583248, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'jack', 0.39064306179528907, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'john', 0.36479296691952023, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'lucy', 0.5069249157662691, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'tom', 0.4785315495532231, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'dean', 0.7582526218052175, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.42064109605717914, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'dean', 0.5587757581237022, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'lucy', 0.3561686564964428, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.7101688305173135, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'dean', 0.6518061375522985, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.7564485884156583, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'tom', 0.36531347293134464, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'jack', 0.5201689359070235, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'john', 0.7138792929290383, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'tom', 0.9751003716333827, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'tom', 0.5281906318027629, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'tom', 0.6291356541485003, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'jack', 0.1938712974807698, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'john', 0.6267850210775459, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'tom', 0.4469970592043767, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'lucy', 0.7690659124175409, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'jack', 0.13335067838090386, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'jack', 0.2966621725922035, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'john', 0.5740481445089863, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'alice', 0.838028890036331, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'jack', 0.8094354537628714, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'alice', 0.5552924586108698, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'jack', 0.49150373927678315, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'dean', 0.7264346889377966, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'alice', 0.9292830287297702, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.3905616258240767, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.15912349648571666, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'alice', 0.6030082006630102, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'lucy', 0.8712354035243679, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.7685306377211826, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'john', 0.2869913942171415, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'john', 0.7142615166855639, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'tom', 0.5625978475154423, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'jack', 0.13611601734791123, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'alice', 0.6977333962685311, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'jack', 0.35140477709778295, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'john', 0.8805119222967716, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.7014124236538637, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'alice', 0.12759538003439375, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'john', 0.7515403792213445, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'lucy', 0.03700239289885987, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'tom', 0.31674618364630946, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'dean', 0.4491378834800146, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'tom', 0.6742764131652571, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'lucy', 0.5286362221140248, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'alice', 0.007890326473113496, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'alice', 0.8046560540950831, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.7198364371127147, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'tom', 0.7400546712169153, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'jack', 0.16859870460868698, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'lucy', 0.8462852684569557, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'john', 0.010211452005474353, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'alice', 0.8617802368201087, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'jack', 0.21667479046797633, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'john', 0.8667689615468714, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'jack', 0.16140709875863557, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.16713368182304666, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'lucy', 0.8957484629768053, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'tom', 0.457835758220534, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'jack', 0.9435170960198477, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'jack', 0.9699253608913104, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'john', 0.2309897429566834, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'lucy', 0.7879705066452681, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'john', 0.20795869239817255, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'dean', 0.4110352469382019, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'jack', 0.4979592772533561, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'dean', 0.18810865430947044, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'tom', 0.5001240246982048, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'jack', 0.08341934160029707, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'lucy', 0.04812784841651041, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'alice', 0.4655982693269717, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'dean', 0.8539357978460663, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'john', 0.9649541785823592, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'john', 0.8243635648047365, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'john', 0.929949719929735, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'john', 0.055983276861168996, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'tom', 0.07845430274829746, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'alice', 0.28257674222099116, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.1578419214960578, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'dean', 0.7853118484860825, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'lucy', 0.20790127125904156, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'tom', 0.8650538395535204, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.902116091225815, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'lucy', 0.48542770770171373, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'jack', 0.16725337150113984, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'lucy', 0.3157444453259486, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'tom', 0.565727220131555, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'jack', 0.2531688065358064, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'lucy', 0.9191434620980499, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'jack', 0.9224628853942058, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'jack', 0.3256288410730337, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'jack', 0.9709152566761661, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.9794173893522709, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'alice', 0.16582064407977237, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'alice', 0.2652519246960059, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'alice', 0.04092489871261762, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'jack', 0.3020444893927522, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'john', 0.4655412764350543, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'dean', 0.9226436424888846, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'jack', 0.4707663393012884, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'lucy', 0.3277970119243966, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'tom', 0.4730675479071551, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'jack', 0.10261940477901954, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'alice', 0.4148892373198616, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.2877219827348403, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'tom', 0.16212409974675845, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.9567425121214822, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'lucy', 0.19795350030679149, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'john', 0.6954199597749198, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'alice', 0.32884293488801164, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'john', 0.4789917995407148, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'lucy', 0.0698927593996298, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'john', 0.3352267723792438, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'tom', 0.8085116661598726, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'john', 0.17515060210353794, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.6006963088370202, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'alice', 0.8794167536704468, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.04091469320757368, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'tom', 0.6709116812690366, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'john', 0.4850646101328463, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'tom', 0.547488212623346, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'dean', 0.6301717145008927, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'lucy', 0.06123370093612068, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'alice', 0.2545600223228257, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'john', 0.28355287519210803, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.3231348374147818, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.4585172495754063, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'john', 0.7893945285152268, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'john', 0.6810596014794181, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'john', 0.7136031244915907, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'jack', 0.259734039051829, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'jack', 0.7759518703827996, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'john', 0.06288891046833589, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'dean', 0.8242980461154241, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'tom', 0.36590300307021595, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'lucy', 0.20254092528445444, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'tom', 0.5427356081880325, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.1467846603517391, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.8975527268892767, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'dean', 0.3483541520806722, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'alice', 0.6922544855316723, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.3690185253006011, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'tom', 0.7564541265683148, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'tom', 0.3634152133342695, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'tom', 0.33740378933701987, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'lucy', 0.7942640738315301, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'jack', 0.7894896778233523, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'jack', 0.7153281477198108, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'tom', 0.5546359859065261, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'john', 0.7727157385809087, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'dean', 0.8707097754747494, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'john', 0.3873936520764878, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'alice', 0.7590305068820566, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'john', 0.512826935863365, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'john', 0.19120284727846926, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'dean', 0.5382693105670825, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'john', 0.826241649014955, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'lucy', 0.6133080470571559, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'jack', 0.6452862617544055, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'lucy', 0.3025772179023586, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'lucy', 0.0004709864550322962, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'dean', 0.024816355013726588, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-06', 'alice', 0.8407500495605565, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'alice', 0.8420879584266481, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'lucy', 0.2719224735814776, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'tom', 0.8939712577294938, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'dean', 0.8086189323362379, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'tom', 0.6063415085381448, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'tom', 0.39783242658234674, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'tom', 0.6085577206028068, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'tom', 0.5154289424127074, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'john', 0.878436600887031, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'john', 0.5577906295015223, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'lucy', 0.1143260282925247, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'jack', 0.312756557275364, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'john', 0.05548807854726956, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'tom', 0.12140791431139175, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.23897628700410234, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'lucy', 0.22223137342481392, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'john', 0.12379891645900953, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'john', 0.33729146112854247, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.8816768640060831, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-22', 'jack', 0.6301700633426532, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-09', 'alice', 0.4566295223861714, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'john', 0.1777378523933678, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'tom', 0.8163769471165477, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'tom', 0.4380805149704541, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'alice', 0.2987018822475964, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'dean', 0.6726495645391617, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'alice', 0.8394327461109705, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'dean', 0.820512945501936, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'tom', 0.1580105370757261, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-23', 'jack', 0.9961450897279505, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-05', 'john', 0.6574891890500061, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'john', 0.5201205570085158, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'alice', 0.2445069633928285, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-26', 'john', 0.3155229654901067, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'jack', 0.3665971881269575, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'john', 0.5544977915912215, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'tom', 0.15978771803015113, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'lucy', 0.038128748344929186, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'tom', 0.49026304025118594, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.5166802080526571, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'alice', 0.22568230066042194, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-15', 'john', 0.9888634109849955, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'jack', 0.21022365182102054, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'john', 0.47052993358031114, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.25686122383263454, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.18929054223320718, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'jack', 0.7925339862375451, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-31', 'john', 0.12613308249498645, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.7381524971311578, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-08', 'alice', 0.08639585437319919, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-16', 'tom', 0.9519897106846164, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'jack', 0.33446548574801926, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'jack', 0.40667134603483324, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-02', 'jack', 0.17100718420628735, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-17', 'lucy', 0.4445585525686886, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'tom', 0.47372916928883013, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'john', 0.19826861093848824, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-30', 'john', 0.13679268112019338, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-19', 'tom', 0.9805515708224516, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'dean', 0.4738376165601095, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'dean', 0.5739441073158964, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'alice', 0.8428505498030564, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'lucy', 0.32655416551155336, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-29', 'tom', 0.7055736367780644, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-10', 'tom', 0.9621355090189875, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-03', 'jack', 0.9665339161730553, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'dean', 0.44309781869697995, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-25', 'tom', 0.8651220802537761, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'lucy', 0.6451892308277741, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-27', 'dean', 0.056797307451316725, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'lucy', 0.6847604118085596, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-20', 'jack', 0.13428051757364667, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-14', 'lucy', 0.9814797176951834, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-01', 'tom', 0.7386074051153445, 'p3');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-18', 'alice', 0.4825297824657663, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'alice', 0.06608870508231235, 'p5');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-21', 'lucy', 0.6278253028988848, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-11', 'alice', 0.6705580511822682, 'p1');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-24', 'alice', 0.8131712486302015, 'p2');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-03-28', 'lucy', 0.8124302447925607, 'p4');
INSERT INTO "heating_analytics"."s2_stay_time_statis" VALUES ('2026-04-04', 'lucy', 0.039935860913407284, 'p2');

-- ----------------------------
-- Table structure for s2_system_config
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_system_config";
CREATE TABLE "heating_analytics"."s2_system_config" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_system_config_id_seq'::regclass),
  "admin" varchar(500) COLLATE "pg_catalog"."default",
  "parameters" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_system_config
-- ----------------------------
INSERT INTO "heating_analytics"."s2_system_config" VALUES (1, 'admin', '[{"name": "s2.embedding.model.provider", "value": "OLLAMA", "module": "嵌入模型配置", "comment": "接口协议", "dataType": "list", "description": "", "defaultValue": "IN_MEMORY", "candidateValues": ["IN_MEMORY", "OPEN_AI", "OLLAMA"]}, {"name": "s2.embedding.model.base.url", "value": "http://192.168.1.10:11435", "module": "嵌入模型配置", "comment": "BaseUrl", "dataType": "string", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.model.provider", "show": {"includesValue": ["OPEN_AI", "OLLAMA"]}, "setDefaultValue": {"OLLAMA": "http://localhost:11434", "OPEN_AI": "https://api.openai.com/v1"}}]}, {"name": "s2.embedding.model.api.key", "value": "", "module": "嵌入模型配置", "comment": "ApiKey", "dataType": "password", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.model.provider", "show": {"includesValue": ["OPEN_AI"]}, "setDefaultValue": {"OPEN_AI": "demo"}}]}, {"name": "s2.embedding.model.secretKey", "value": "demo", "module": "嵌入模型配置", "comment": "SecretKey", "dataType": "password", "description": "", "defaultValue": "demo", "dependencies": [{"name": "s2.embedding.model.provider", "show": {"includesValue": ["OPEN_AI"]}, "setDefaultValue": {"OPEN_AI": "demo"}}]}, {"name": "s2.embedding.model.name", "value": "bge-m3:latest", "module": "嵌入模型配置", "comment": "ModelName", "dataType": "string", "description": "", "defaultValue": "bge-small-zh", "dependencies": [{"name": "s2.embedding.model.provider", "show": {"includesValue": ["IN_MEMORY", "OPEN_AI", "OLLAMA"]}, "setDefaultValue": {"OLLAMA": "all-minilm", "OPEN_AI": "text-embedding-ada-002", "IN_MEMORY": "bge-small-zh"}}]}, {"name": "s2.embedding.model.path", "value": "", "module": "嵌入模型配置", "comment": "模型路径", "dataType": "string", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.model.provider", "show": {"includesValue": ["IN_MEMORY"]}, "setDefaultValue": {"IN_MEMORY": ""}}]}, {"name": "s2.embedding.model.vocabulary.path", "value": "", "module": "嵌入模型配置", "comment": "词汇表路径", "dataType": "string", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.model.provider", "show": {"includesValue": ["IN_MEMORY"]}, "setDefaultValue": {"IN_MEMORY": ""}}]}, {"name": "s2.embedding.store.provider", "value": "IN_MEMORY", "module": "向量数据库配置", "comment": "向量库类型", "dataType": "list", "description": "目前支持四种类型：IN_MEMORY、MILVUS、CHROMA、PGVECTOR、OPENSEARCH", "defaultValue": "IN_MEMORY", "candidateValues": ["IN_MEMORY", "MILVUS", "CHROMA", "PGVECTOR", "OPENSEARCH"]}, {"name": "s2.embedding.store.base.url", "value": "192.168.1.7", "module": "向量数据库配置", "comment": "BaseUrl", "dataType": "string", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["MILVUS", "CHROMA", "PGVECTOR", "OPENSEARCH"]}, "setDefaultValue": {"CHROMA": "http://localhost:8000", "MILVUS": "http://localhost:19530", "PGVECTOR": "127.0.0.1", "OPENSEARCH": "http://localhost:9200"}}]}, {"name": "s2.embedding.store.port", "value": "54321", "module": "向量数据库配置", "comment": "端口", "dataType": "number", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["PGVECTOR"]}, "setDefaultValue": {"PGVECTOR": "54333"}}]}, {"name": "s2.embedding.store.user", "value": "postgres", "module": "向量数据库配置", "comment": "用户名", "dataType": "string", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["MILVUS", "PGVECTOR", "OPENSEARCH"]}, "setDefaultValue": {"MILVUS": "milvus", "PGVECTOR": "postgres", "OPENSEARCH": "opensearch"}}]}, {"name": "s2.embedding.store.password", "value": "Huilian1234", "module": "向量数据库配置", "comment": "密码", "dataType": "password", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["MILVUS", "PGVECTOR", "OPENSEARCH"]}, "setDefaultValue": {"MILVUS": "milvus", "PGVECTOR": "postgres", "OPENSEARCH": "opensearch"}}]}, {"name": "s2.embedding.store.api.key", "value": "", "module": "向量数据库配置", "comment": "ApiKey", "dataType": "password", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["MILVUS"]}, "setDefaultValue": {"MILVUS": "demo"}}]}, {"name": "s2.embedding.store.databaseName", "value": "postgres", "module": "向量数据库配置", "comment": "DatabaseName", "dataType": "string", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["MILVUS", "PGVECTOR", "OPENSEARCH"]}, "setDefaultValue": {"MILVUS": "", "PGVECTOR": "postgres", "OPENSEARCH": "ai_sql"}}]}, {"name": "s2.embedding.store.persist.path", "value": "", "module": "向量数据库配置", "comment": "持久化路径", "dataType": "string", "description": "默认不持久化，如需持久化请填写持久化路径。注意：如果变更了向量模型需删除该路径下已保存的文件或修改持久化路径", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["IN_MEMORY"]}, "setDefaultValue": {"IN_MEMORY": ""}}]}, {"name": "s2.embedding.store.timeout", "value": "60", "module": "向量数据库配置", "comment": "超时时间(秒)", "dataType": "number", "description": "", "defaultValue": "60"}, {"name": "s2.embedding.store.dimension", "value": "1024", "module": "向量数据库配置", "comment": "向量维度", "dataType": "number", "description": "", "defaultValue": "", "dependencies": [{"name": "s2.embedding.store.provider", "show": {"includesValue": ["MILVUS", "PGVECTOR", "OPENSEARCH"]}, "setDefaultValue": {"MILVUS": "384", "PGVECTOR": "512", "OPENSEARCH": "512"}}]}, {"name": "s2.query-optimizer.resultLimit", "value": "1000", "module": "语义翻译配置", "comment": "查询最大返回数据行数", "dataType": "number", "description": "为了前端展示性能考虑，请不要设置过大", "defaultValue": "1000"}, {"name": "s2.parser.linking.value.enable", "value": "true", "module": "语义解析配置", "comment": "是否将Mapper探测识别到的维度值提供给大模型", "dataType": "bool", "description": "为了数据安全考虑, 这里可进行开关选择", "defaultValue": "true"}, {"name": "s2.parser.rule.corrector.enable", "value": "false", "module": "语义解析配置", "comment": "是否开启规则修正器", "dataType": "bool", "description": "规则修正器灵活度有限，在大模型能力足够情况下，不必强制做规则修正", "defaultValue": "false"}, {"name": "s2.parser.few-shot.number", "value": "1", "module": "语义解析配置", "comment": "few-shot样例个数", "dataType": "number", "description": "样例越多效果可能越好，但token消耗越大", "defaultValue": "3"}, {"name": "s2.parser.self-consistency.number", "value": "1", "module": "语义解析配置", "comment": "self-consistency执行个数", "dataType": "number", "description": "执行越多效果可能越好，但token消耗越大", "defaultValue": "1"}, {"name": "s2.parser.show.count", "value": "3", "module": "语义解析配置", "comment": "解析结果展示个数", "dataType": "number", "description": "前端展示的解析个数", "defaultValue": "3"}, {"name": "s2.parser.field.count.threshold", "value": "3", "module": "语义解析配置", "comment": "语义字段个数阈值", "dataType": "number", "description": "如果映射字段小于该阈值，则将数据集所有字段输入LLM", "defaultValue": "0"}][{"name": "s2.parser.format.json-type", "type": "string", "value": "json_schema", "options": "json_schema,json_object", "category": "parser_config", "editable": true, "description": "LLM return JSON format", "defaultValue": ""}]');

-- ----------------------------
-- Table structure for s2_tag
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_tag";
CREATE TABLE "heating_analytics"."s2_tag" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_tag_id_seq'::regclass),
  "item_id" int4 NOT NULL,
  "type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "ext" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_tag
-- ----------------------------

-- ----------------------------
-- Table structure for s2_tag_object
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_tag_object";
CREATE TABLE "heating_analytics"."s2_tag_object" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_tag_object_id_seq'::regclass),
  "domain_id" int8,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "biz_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "status" int2 NOT NULL DEFAULT 1,
  "sensitive_level" int2 NOT NULL DEFAULT 0,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default",
  "ext" text COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of s2_tag_object
-- ----------------------------

-- ----------------------------
-- Table structure for s2_term
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_term";
CREATE TABLE "heating_analytics"."s2_term" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_term_id_seq'::regclass),
  "domain_id" int8,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "description" varchar(500) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "alias" varchar(1000) COLLATE "pg_catalog"."default" NOT NULL,
  "related_metrics" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "related_dimensions" varchar(1000) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "created_at" timestamp(6) NOT NULL,
  "created_by" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "updated_at" timestamp(6),
  "updated_by" varchar(100) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying
)
;

-- ----------------------------
-- Records of s2_term
-- ----------------------------
INSERT INTO "heating_analytics"."s2_term" VALUES (15, 11, '采暖期', '供热季节周期，通常为当年11月至次年3月', '["供暖季", "供热季"]', '[]', '[]', '2026-04-14 05:03:20.031751', 'admin', '2026-04-14 05:03:20.031751', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (21, 11, '分公司', '供热公司下属分公司或营业厅', '["营业厅", "分公司"]', '[]', '[]', '2026-04-14 05:03:20.258092', 'admin', '2026-04-14 05:03:20.258092', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (22, 11, '热力站', '供热热力站或换热站', '["换热站"]', '[]', '[]', '2026-04-14 05:03:20.368159', 'admin', '2026-04-14 05:03:20.368159', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (23, 11, '小区', '供热服务的小区或楼宇', '["楼宇", "楼栋"]', '[]', '[]', '2026-04-14 05:03:20.477774', 'admin', '2026-04-14 05:03:20.477774', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (24, 11, '用户类型', '热用户的类型分类', '["客户类型"]', '[]', '[]', '2026-04-14 05:03:20.587726', 'admin', '2026-04-14 05:03:20.587726', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (14, 11, '欠费率', '欠费金额占总应收金额的比例', '["欠费比例"]', '[]', '[]', '2026-04-14 05:03:20.028594', 'admin', '2026-04-14 05:03:20.028594', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (7, 3, '收费率', '实际收取的热费与应收热费的比率，反映收费效率', '["收缴率"]', '[]', '[]', '2026-04-14 03:02:37.708172', 'admin', '2026-04-14 03:02:37.708172', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (8, 3, '欠费', '用户未按时缴纳的热费金额', '["欠费金额"]', '[]', '[]', '2026-04-14 03:02:37.820986', 'admin', '2026-04-14 03:02:37.820986', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (11, 2, '在供用户', '正在享受供热服务的用户', '["正常供热"]', '[]', '[]', '2026-04-14 03:02:38.159186', 'admin', '2026-04-14 03:02:38.159186', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (1, 1, '近期', '指近10天', '["近一段时间"]', '[]', '[]', '2026-04-13 11:04:54.343', 'admin', '2026-04-13 11:04:54.343', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (2, 1, '核心用户', '用户为tom和lucy', '["VIP用户"]', '[]', '[]', '2026-04-13 11:04:54.347', 'admin', '2026-04-13 11:04:54.347', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (5, 2, '在供用户', '正在享受供热服务的用户', '["正常供热"]', '[]', '[]', '2026-04-13 15:26:42.767351', 'admin', '2026-04-13 15:26:42.767351', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (25, 11, '费用类别', '热费和其他费用的分类', '["收费类型"]', '[]', '[]', '2026-04-14 05:03:20.698823', 'admin', '2026-04-14 05:03:20.698823', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (26, 11, '收费笔数', '收费记录的数量', '["收费次数", "交费笔数"]', '[]', '[]', '2026-04-14 05:03:20.808191', 'admin', '2026-04-14 05:03:20.808191', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (27, 11, '折扣金额', '减免或优惠的热费金额', '["减免", "优惠"]', '[]', '[]', '2026-04-14 05:03:20.918736', 'admin', '2026-04-14 05:03:20.918736', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (28, 11, '核减金额', '核销或减免的热费金额', '["核销"]', '[]', '[]', '2026-04-14 05:03:21.028247', 'admin', '2026-04-14 05:03:21.028247', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (13, 11, '收费率', '实际收取的热费与应收热费的比率，反映收费效率', '["收缴率"]', '[]', '[]', '2026-04-14 05:03:20.023832', 'admin', '2026-04-14 05:03:20.023832', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (17, 11, '实收金额', '实际收取的热费金额', '["已收热费", "收费金额"]', '[]', '[]', '2026-04-14 05:03:20.038518', 'admin', '2026-04-14 05:03:20.038518', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (18, 11, '应收金额', '应当收取的热费金额', '["应收费", "应收热费"]', '[]', '[]', '2026-04-14 05:03:20.041425', 'admin', '2026-04-14 05:03:20.041425', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (19, 11, '欠费金额', '用户未按时缴纳的热费金额', '["欠费", "未收热费"]', '[]', '[]', '2026-04-14 05:03:20.044447', 'admin', '2026-04-14 05:03:20.044447', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (16, 11, '收费面积', '收取供热费用的建筑面积', '["供热面积", "计费面积"]', '[]', '[]', '2026-04-14 05:03:20.035286', 'admin', '2026-04-14 05:03:20.035286', 'admin');
INSERT INTO "heating_analytics"."s2_term" VALUES (20, 11, '用户数', '热用户数量', '["客户数", "户数"]', '[]', '[]', '2026-04-14 05:03:20.148251', 'admin', '2026-04-14 05:03:20.148251', 'admin');

-- ----------------------------
-- Table structure for s2_user
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_user";
CREATE TABLE "heating_analytics"."s2_user" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_user_id_seq'::regclass),
  "name" varchar(100) COLLATE "pg_catalog"."default" NOT NULL,
  "display_name" varchar(100) COLLATE "pg_catalog"."default",
  "password" varchar(256) COLLATE "pg_catalog"."default",
  "salt" varchar(256) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "email" varchar(100) COLLATE "pg_catalog"."default",
  "is_admin" int2,
  "last_login" timestamp(6)
)
;

-- ----------------------------
-- Records of s2_user
-- ----------------------------
INSERT INTO "heating_analytics"."s2_user" VALUES (2, 'jack', 'jack', 'c3VwZXJzb25pY0BiaWNvbWxGalmwa0h/trkh/3CWOYMDiku0Op1VmOfESIKmN0HG', 'MWERWefm/3hD6kYndF6JIg==', 'jack@xx.com', NULL, NULL);
INSERT INTO "heating_analytics"."s2_user" VALUES (3, 'tom', 'tom', 'c3VwZXJzb25pY0BiaWNvbVWv0CZ6HzeX8GRUpw0C8NSaQ+0hE/dAcmzRpCFwAqxK', '4WCPdcXXgT89QDHLML+3hg==', 'tom@xx.com', NULL, NULL);
INSERT INTO "heating_analytics"."s2_user" VALUES (4, 'lucy', 'lucy', 'c3VwZXJzb25pY0BiaWNvbc7Ychfu99lPL7rLmCkf/vgF4RASa4Z++Mxo1qlDCpci', '3Jnpqob6uDoGLP9eCAg5Fw==', 'lucy@xx.com', 1, NULL);
INSERT INTO "heating_analytics"."s2_user" VALUES (5, 'alice', 'alice', 'c3VwZXJzb25pY0BiaWNvbe9Z4F2/DVIfAJoN1HwUTuH1KgVuiusvfh7KkWYQSNHk', 'K9gGyX8OAK8aH8Myj6djqQ==', 'alice@xx.com', NULL, NULL);
INSERT INTO "heating_analytics"."s2_user" VALUES (1, 'admin', 'admin', 'c3VwZXJzb25pY0BiaWNvbdktJJYWw6A3rEmBUPzbn/6DNeYnD+y3mAwDKEMS3KVT', 'jGl25bVBBBW96Qi9Te4V3w==', 'admin@xx.com', 1, '2026-04-16 09:19:36.879');

-- ----------------------------
-- Table structure for s2_user_department
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_user_department";
CREATE TABLE "heating_analytics"."s2_user_department" (
  "user_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "department" varchar(200) COLLATE "pg_catalog"."default" NOT NULL
)
;

-- ----------------------------
-- Records of s2_user_department
-- ----------------------------
INSERT INTO "heating_analytics"."s2_user_department" VALUES ('jack', 'HR');
INSERT INTO "heating_analytics"."s2_user_department" VALUES ('tom', 'sales');
INSERT INTO "heating_analytics"."s2_user_department" VALUES ('lucy', 'marketing');
INSERT INTO "heating_analytics"."s2_user_department" VALUES ('john', 'strategy');
INSERT INTO "heating_analytics"."s2_user_department" VALUES ('alice', 'sales');
INSERT INTO "heating_analytics"."s2_user_department" VALUES ('dean', 'marketing');

-- ----------------------------
-- Table structure for s2_user_token
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."s2_user_token";
CREATE TABLE "heating_analytics"."s2_user_token" (
  "id" int4 NOT NULL DEFAULT nextval('"heating_analytics".s2_user_token_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "user_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "expire_time" int8 NOT NULL,
  "token" text COLLATE "pg_catalog"."default" NOT NULL,
  "salt" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
  "create_time" timestamp(6) NOT NULL,
  "create_by" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "update_time" timestamp(6),
  "update_by" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "expire_date_time" timestamp(6) NOT NULL
)
;

-- ----------------------------
-- Records of s2_user_token
-- ----------------------------

-- ----------------------------
-- Table structure for singer
-- ----------------------------
DROP TABLE IF EXISTS "heating_analytics"."singer";
CREATE TABLE "heating_analytics"."singer" (
  "singer_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "act_area" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "song_name" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "genre" varchar(200) COLLATE "pg_catalog"."default" NOT NULL,
  "js_play_cnt" int8,
  "down_cnt" int8,
  "favor_cnt" int8
)
;

-- ----------------------------
-- Records of singer
-- ----------------------------

-- ----------------------------
-- Primary Key structure for table brand
-- ----------------------------
ALTER TABLE "heating_analytics"."brand" ADD CONSTRAINT "brand_pkey" PRIMARY KEY ("brand_id");

-- ----------------------------
-- Primary Key structure for table brand_revenue
-- ----------------------------
ALTER TABLE "heating_analytics"."brand_revenue" ADD CONSTRAINT "brand_revenue_pkey" PRIMARY KEY ("year_time", "brand_id");

-- ----------------------------
-- Primary Key structure for table company
-- ----------------------------
ALTER TABLE "heating_analytics"."company" ADD CONSTRAINT "company_pkey" PRIMARY KEY ("company_id");

-- ----------------------------
-- Primary Key structure for table genre
-- ----------------------------
ALTER TABLE "heating_analytics"."genre" ADD CONSTRAINT "genre_pkey" PRIMARY KEY ("g_name");

-- ----------------------------
-- Primary Key structure for table s2_agent
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_agent" ADD CONSTRAINT "s2_agent_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_app
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_app" ADD CONSTRAINT "s2_app_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_auth_groups
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_auth_groups" ADD CONSTRAINT "s2_auth_groups_pkey" PRIMARY KEY ("group_id");

-- ----------------------------
-- Uniques structure for table s2_available_date_info
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_available_date_info" ADD CONSTRAINT "s2_available_date_info_item_id_type_key" UNIQUE ("item_id", "type");

-- ----------------------------
-- Primary Key structure for table s2_available_date_info
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_available_date_info" ADD CONSTRAINT "s2_available_date_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_canvas
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_canvas" ADD CONSTRAINT "s2_canvas_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_chat
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat" ADD CONSTRAINT "s2_chat_pkey" PRIMARY KEY ("chat_id");

-- ----------------------------
-- Primary Key structure for table s2_chat_config
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat_config" ADD CONSTRAINT "s2_chat_config_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_chat_context
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat_context" ADD CONSTRAINT "s2_chat_context_pkey" PRIMARY KEY ("chat_id");

-- ----------------------------
-- Primary Key structure for table s2_chat_memory
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat_memory" ADD CONSTRAINT "s2_chat_memory_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_chat_model
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat_model" ADD CONSTRAINT "s2_chat_model_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table s2_chat_parse
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat_parse" ADD CONSTRAINT "commonindex" UNIQUE ("question_id");

-- ----------------------------
-- Primary Key structure for table s2_chat_query
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_chat_query" ADD CONSTRAINT "s2_chat_query_pkey" PRIMARY KEY ("question_id");

-- ----------------------------
-- Primary Key structure for table s2_collect
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_collect" ADD CONSTRAINT "s2_collect_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_data_set
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_data_set" ADD CONSTRAINT "s2_data_set_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_database
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_database" ADD CONSTRAINT "s2_database_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_dictionary_conf
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_dictionary_conf" ADD CONSTRAINT "s2_dictionary_conf_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_dictionary_task
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_dictionary_task" ADD CONSTRAINT "s2_dictionary_task_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_dimension
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_dimension" ADD CONSTRAINT "s2_dimension_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_domain
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_domain" ADD CONSTRAINT "s2_domain_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_metric
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_metric" ADD CONSTRAINT "s2_metric_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_metric_query_default_config
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_metric_query_default_config" ADD CONSTRAINT "s2_metric_query_default_config_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_model
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_model" ADD CONSTRAINT "s2_model_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_model_rela
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_model_rela" ADD CONSTRAINT "s2_model_rela_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_plugin
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_plugin" ADD CONSTRAINT "s2_plugin_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_query_rule
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_query_rule" ADD CONSTRAINT "s2_query_rule_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_query_stat_info
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_query_stat_info" ADD CONSTRAINT "s2_query_stat_info_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_system_config
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_system_config" ADD CONSTRAINT "s2_system_config_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_tag
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_tag" ADD CONSTRAINT "s2_tag_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_tag_object
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_tag_object" ADD CONSTRAINT "s2_tag_object_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table s2_term
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_term" ADD CONSTRAINT "s2_term_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table s2_user
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_user" ADD CONSTRAINT "s2_user_name_key" UNIQUE ("name");

-- ----------------------------
-- Primary Key structure for table s2_user
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_user" ADD CONSTRAINT "s2_user_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table s2_user_token
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_user_token" ADD CONSTRAINT "s2_user_token_name_user_name_key" UNIQUE ("name", "user_name");

-- ----------------------------
-- Primary Key structure for table s2_user_token
-- ----------------------------
ALTER TABLE "heating_analytics"."s2_user_token" ADD CONSTRAINT "s2_user_token_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Foreign Keys structure for table brand
-- ----------------------------
ALTER TABLE "heating_analytics"."brand" ADD CONSTRAINT "fk_brand_company" FOREIGN KEY ("company_id") REFERENCES "heating_analytics"."company" ("company_id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- ----------------------------
-- Foreign Keys structure for table brand_revenue
-- ----------------------------
ALTER TABLE "heating_analytics"."brand_revenue" ADD CONSTRAINT "fk_brand_revenue_brand" FOREIGN KEY ("brand_id") REFERENCES "heating_analytics"."brand" ("brand_id") ON DELETE NO ACTION ON UPDATE NO ACTION;
