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

 Date: 15/04/2026 23:12:43
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
