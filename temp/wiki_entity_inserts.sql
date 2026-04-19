-- ============================================================
-- LLM-SQL-Wiki Entity Data
-- Generated from charge_zbhx_20260303.sql
-- Date: 2026-04-17
-- ============================================================

SET search_path TO heating_analytics,public;

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:address',
    'TABLE',
    'address',
    'address',
    'address table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","one","two","three"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:app_menu',
    'TABLE',
    'app_menu',
    'app_menu',
    'app_menu table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","name","url","remark","sort","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:app_role_menu',
    'TABLE',
    'app_role_menu',
    'app_role_menu',
    'app_role_menu table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","menu_id","role_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:area',
    'TABLE',
    'area',
    'area',
    'area table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","name","sfmj","zdmj","symj","cgmj","cg","mjlb","djlb","jsfs","gnsc","ybbm","jldjlb","created_time","updated_time","bz","zf","czbh","generate"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:area_sh',
    'TABLE',
    'area_sh',
    'area_sh',
    'area_sh table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","name","sfmj","zdmj","symj","cgmj","cg","mjlb","djlb","jsfs","gnsc","ybbm","jldjlb","created_time","updated_time","bz","zf","czbh","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:contract_info',
    'TABLE',
    'contract_info',
    'contract_info',
    'contract_info table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","type","customer_id","cnq","operation_no","status","sign_name","zf","created_time","updated_time","file_path","file_type"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:crm_progress',
    'TABLE',
    'crm_progress',
    'crm_progress',
    'crm_progress table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","task_id","task_type","name","num","zt","czsj","czr","bz","delayd","delaydtime"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:crm_sms_template',
    'TABLE',
    'crm_sms_template',
    'crm_sms_template',
    'crm_sms_template table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","template_key","name","content","type_id","enable","level","czy","created_time","updated_time","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:crm_smssend',
    'TABLE',
    'crm_smssend',
    'crm_smssend',
    'crm_smssend table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","s_phone","s_sender","s_department","s_type","s_state","s_sendtime","s_template_id","s_endtime","s_content","s_inputtime","s_error","s_linkid","s_yhid","s_name","s_dz","progress_id","priority","s_cnq"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:crm_variable',
    'TABLE',
    'crm_variable',
    'crm_variable',
    'crm_variable table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","czy","lrsj","name","code","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:crm_wxsend',
    'TABLE',
    'crm_wxsend',
    'crm_wxsend',
    'crm_wxsend table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","pmsg_id","content","cnq","type","open_id","bz","state","created_time","created_by","update_time","update_by"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:customer',
    'TABLE',
    'customer',
    'customer',
    'customer table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","code","yhkh","name","id_number","tel_no","mob_no","ry","jz","one","two","three","address_prefix","unit","floor","room","mp","address","yhlx","rwrq","rwht_bh","kzfs","created_time","updated_time","bz","zf","kz_hmd","kz_hmd_reason","kz_sf","kz_sf_reason","kz_yhsf","kz_jcsh","kz_jcsh_reason","czbh","glh","fmzt","fmzt_ing","fmzt_res","xzcnq","temperature","rlz_id","zdfq_id","zdfq_name","hrq_zt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:customer_2026_01_26_bak',
    'TABLE',
    'customer_2026_01_26_bak',
    'customer_2026_01_26_bak',
    'customer_2026_01_26_bak table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","code","yhkh","name","id_number","tel_no","mob_no","ry","jz","one","two","three","address_prefix","unit","floor","room","mp","address","yhlx","rwrq","rwht_bh","kzfs","created_time","updated_time","bz","zf","kz_hmd","kz_hmd_reason","kz_sf","kz_sf_reason","kz_yhsf","kz_jcsh","kz_jcsh_reason","czbh","glh","fmzt","fmzt_ing","fmzt_res","xzcnq","temperature","rlz_id","zdfq_id","zdfq_name","hrq_zt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:customer_no',
    'TABLE',
    'customer_no',
    'customer_no',
    'customer_no table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:customer_sh',
    'TABLE',
    'customer_sh',
    'customer_sh',
    'customer_sh table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","code","yhkh","name","id_number","tel_no","mob_no","ry","one","two","three","address_prefix","unit","floor","room","address","yhlx","rwrq","kzfs","created_time","updated_time","bz","zf","kz_hmd","kz_sf","kz_sf_reason","kz_yhsf","czbh","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_cbsh',
    'TABLE',
    'ds_cbsh',
    'ds_cbsh',
    'ds_cbsh table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","czy","sqr","zf","ybbm","cnq","cblx","xgq_bds","xgq_tjyl","xgq_bjyl","xgq_sjyl","bds","bjyl","tjyl","sjyl","cbrq","jsrq","sqrq","shzt","customer_id","cbxx_id","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_cbxg',
    'TABLE',
    'ds_cbxg',
    'ds_cbxg',
    'ds_cbxg table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","xgnr","cbxx_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_cbxx',
    'TABLE',
    'ds_cbxx',
    'ds_cbxx',
    'ds_cbxx table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","customer_id","ybbm","cbrq","bds","bjyl","tjyl","sjyl","dj","ylje","czy","cbqje","ye","bz","jsrq","cnq"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_customer',
    'TABLE',
    'ds_customer',
    'ds_customer',
    'ds_customer table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","code","gsmc","gssh","gsdz","cylxr","phone","ssrw","sfmj","ybbm","bz","txyz","czr","parent_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_djxg',
    'TABLE',
    'ds_djxg',
    'ds_djxg',
    'ds_djxg table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","customer_id","dqjg","ysjg","effective_date","sxlx","sxzt","czr"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_khbgjl',
    'TABLE',
    'ds_khbgjl',
    'ds_khbgjl',
    'ds_khbgjl table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","customer_id","czy","bgnr","opearte_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ds_zhcz',
    'TABLE',
    'ds_zhcz',
    'ds_zhcz',
    'ds_zhcz table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","customer_id","czlx","czje","czrq","bz","cnq"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:ebz_cbxx_t',
    'TABLE',
    'ebz_cbxx_t',
    'ebz_cbxx_t',
    'ebz_cbxx_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","area_id","mj_id","mjjs_id","ybbm","cnq","qsbs","zzbs","bjyl","tjyl","sjyl","cbrq","cbr","czy","czbh","zf","created_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_candidate_user',
    'TABLE',
    'jc_candidate_user',
    'jc_candidate_user',
    'jc_candidate_user table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","task_id","task_type","candidate_user","operator_id","event_type","event_reason"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_check_feedback',
    'TABLE',
    'jc_check_feedback',
    'jc_check_feedback',
    'jc_check_feedback table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","plan_detail_id","status","fmzt_gs","fmzt_hs","fqh_gs","fqh_hs","error_type","error_description","check_user","check_time","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_check_feedback_sh',
    'TABLE',
    'jc_check_feedback_sh',
    'jc_check_feedback_sh',
    'jc_check_feedback_sh table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","czy","zf","auditor","audit_time","audit_result","audit_remark","check_id","hand_status"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_end_feedback',
    'TABLE',
    'jc_end_feedback',
    'jc_end_feedback',
    'jc_end_feedback table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","plan_detail_id","service_fee","end_result","end_description","end_user","end_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_handle_feedback',
    'TABLE',
    'jc_handle_feedback',
    'jc_handle_feedback',
    'jc_handle_feedback table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","plan_detail_id","fmzt_gs","fmzt_hs","fqh_gs","fqh_hs","handle_result","handle_description","handle_user","handle_time","handle_user_name","crm_task_id","crm_status","kz_jcsh_update_time","kz_jcsh_czy","kz_jcsh_reason","kz_jcsh"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_plan',
    'TABLE',
    'jc_plan',
    'jc_plan',
    'jc_plan table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","cnq","name","status","start_type","start_time","end_time","role_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:jc_plan_detail',
    'TABLE',
    'jc_plan_detail',
    'jc_plan_detail',
    'jc_plan_detail table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","cnq","plan_id","customer_id","status"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:message_error_log',
    'TABLE',
    'message_error_log',
    'message_error_log',
    'message_error_log table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","type","business_type","content","error_message","created_time","updated_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:mysql_backup',
    'TABLE',
    'mysql_backup',
    'mysql_backup',
    'mysql_backup table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","mysql_ip","mysql_port","database_name","mysql_backup_cmd","mysql_rollback_cmd","backup_name","backup_path","operation","status","zf","xt_name","create_by","create_time","recovery_by","recovery_time","delete_by","delete_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:pay_device_bind',
    'TABLE',
    'pay_device_bind',
    'pay_device_bind',
    'pay_device_bind table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","pid","cashsn","termsn","cashvendor","opid","branchcode","termactiveno","version","zf","created_time","updated_time","czy","enable"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:pay_order',
    'TABLE',
    'pay_order',
    'pay_order',
    'pay_order table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","cnq","fylb","sfje","wyje","zkje","bill_no","bank_order","bill_date","pay_date","created_time","updated_time","trace_no","merchant_no","terminal_no","reference_no","source","sfzt","yywd","czy","zf","term_sn"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:pl_ssgl_t',
    'TABLE',
    'pl_ssgl_t',
    'pl_ssgl_t',
    'pl_ssgl_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","rate","type","czy","created_time","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:role_address',
    'TABLE',
    'role_address',
    'role_address',
    'role_address table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","role_id","one","two","three"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:rw_area',
    'TABLE',
    'rw_area',
    'rw_area',
    'rw_area table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","name","sfmj","djlb","mjlb","created_time","bz","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:rw_customer',
    'TABLE',
    'rw_customer',
    'rw_customer',
    'rw_customer table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","name","code","one","two","three","tel_no","mob_no","address","rwrq","created_time","bz","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:rw_mjjs_t',
    'TABLE',
    'rw_mjjs_t',
    'rw_mjjs_t',
    'rw_mjjs_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","area_id","fylb","ysje","sfje","qfje","sl","dj","mjlb","djlb","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:rw_mjsf_t',
    'TABLE',
    'rw_mjsf_t',
    'rw_mjsf_t',
    'rw_mjsf_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","fylb","sfrq","sfje","sffs","sl","dj","fplb","fpdm","fphm","czy","czbh","bz","zf","created_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sanwangronghe_temp',
    'TABLE',
    'sanwangronghe_temp',
    'sanwangronghe_temp',
    'sanwangronghe_temp table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"user_id","one_id","two_id_pid","two_name","fq_id","fq_name","status"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_audit',
    'TABLE',
    'sf_audit',
    'sf_audit',
    'sf_audit table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","user_id","user_code","user_name","one","two","three","address_prefix","unit","floor","room","address","audit_cnq","audit_time","audit_problem","audit_situation","audit_person","audit_process_time","audit_process_result","audit_process_situation","audit_process_person","audit_accessory_id","audit_process_status","audit_status","audit_memo","create_by","create_time","update_by","update_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_audit_accessory',
    'TABLE',
    'sf_audit_accessory',
    'sf_audit_accessory',
    'sf_audit_accessory table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","audit_id","audit_name","audit_type","audit_path","audit_uuid","audit_source","audit_accessory_type","audit_memo","create_by","create_time","update_by","update_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_audit_jfmx',
    'TABLE',
    'sf_audit_jfmx',
    'sf_audit_jfmx',
    'sf_audit_jfmx table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","audit_id","user_code","jcjfje","jcjfrq","jcwt","jcqk","jcjg","cnq","zf","create_by","create_time","update_by","update_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_config_t',
    'TABLE',
    'sf_config_t',
    'sf_config_t',
    'sf_config_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","type","titel","fwlj","zjlj","bz","flag"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_cqbl_t',
    'TABLE',
    'sf_cqbl_t',
    'sf_cqbl_t',
    'sf_cqbl_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","cnq","fylb","ysje","sl","djlb","mjlb","gnsc","created_time","bz","zf","czy","czbh"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_fgshz_t',
    'TABLE',
    'sf_fgshz_t',
    'sf_fgshz_t',
    'sf_fgshz_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"cjyf","one","cnq","zdmj","sfmj","tghs","tgmj","cwhs","cwmj","hs","ysje","ssje","ssmj","sfhs","sfhs_part","qfje","qfmj","qfhs","qfhs_part","yjje","yjhs","hjje","hjhs","zrhs","zrmj","zrys"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_fpgm_t',
    'TABLE',
    'sf_fpgm_t',
    'sf_fpgm_t',
    'sf_fpgm_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","ywlx","fplb","fpdm","ks_fphm","js_fphm","fpws","sl","thsl","lrsj","lyr","czy","czbh","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_fply_t',
    'TABLE',
    'sf_fply_t',
    'sf_fply_t',
    'sf_fply_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","fpgm_id","fplb","fpdm","fphm","lyr","syzt","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_fpxx_t',
    'TABLE',
    'sf_fpxx_t',
    'sf_fpxx_t',
    'sf_fpxx_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","fplb","fpdm","fphm","kpr","kprq","jshj","hjje","hjse","sl","yywd","gmf_bm","gmf_mc","gmf_sh","gmf_dzdh","gmf_yhzh","bz","created_time","zf","yfpdm","yfphm","email","phone","tsfs","pj_url","fpqqlsh","status","invoice_line","invoice_type","order_no","bill_uuid","bill_no"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_glh_t',
    'TABLE',
    'sf_glh_t',
    'sf_glh_t',
    'sf_glh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","yh_id","glh_id","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_gmgh_t',
    'TABLE',
    'sf_gmgh_t',
    'sf_gmgh_t',
    'sf_gmgh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","cnq","name","old_name","id_number","tel_no","mob_no","czy","czbh","created_time","shzt","zf","third_type","third_id","mini_third_id","old_id_number","old_mob_no","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_jcgl_t',
    'TABLE',
    'sf_jcgl_t',
    'sf_jcgl_t',
    'sf_jcgl_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","cnq","sfmj","djlb","gnzt","gnrq","jclx","jcrq","jcr","jcwt","clrq","clr","clzt","cljg","wyje","sfje","qfje","czy","bz","kz_jcsh","zf","created_time","updated_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_jcjh_t',
    'TABLE',
    'sf_jcjh_t',
    'sf_jcjh_t',
    'sf_jcjh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","cnq","jcz","jcr","clr","czy","jcjg","jcwt","jcrq","bz","zf","created_time","updated_time","code","yhkh","name","id_number","tel_no","mob_no","other_no","one","two","three","address"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_jcsf_t',
    'TABLE',
    'sf_jcsf_t',
    'sf_jcsf_t',
    'sf_jcsf_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","jcgl_id","cnq","fylb","sfrq","sfje","sffs","fplb","fpdm","fphm","czy","czbh","bz","zf","created_time","updated_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_js_t',
    'TABLE',
    'sf_js_t',
    'sf_js_t',
    'sf_js_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","cnq","zdmj","cgmj","sfmj","cwmj","tgmj","ysje","sfje","qfje","wyje","zkje","hjje","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_ksgs_log_t',
    'TABLE',
    'sf_ksgs_log_t',
    'sf_ksgs_log_t',
    'sf_ksgs_log_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","task_id","created_time","updated_time","zf","customer_id","area_id","cnq","event_type","event_time","czy","business_key","content","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_ksgs_t',
    'TABLE',
    'sf_ksgs_t',
    'sf_ksgs_t',
    'sf_ksgs_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","customer_id","code","cnq","type","cljg","fmzt","czy","czsj","bz","task_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_ksgs_task_t',
    'TABLE',
    'sf_ksgs_task_t',
    'sf_ksgs_task_t',
    'sf_ksgs_task_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","customer_id","area_id","cnq","jfzt_old","gnzt_old","fmzt_old","jfzt","sfrq","gnzt","fmzt","fmbh","rwlx","rwzt","crm_task_id","crm_task_create_time","crm_task_operator","crm_task_department","crm_task_handle_time","crm_task_result"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mj_t',
    'TABLE',
    'sf_mj_t',
    'sf_mj_t',
    'sf_mj_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","area_id","customer_id","cnq","gnzt","name","ce_cnf","ce_jbcnf","tgmj","cwmj","grmj","sfmj","zdmj","symj","cgmj","cg","mjlb","djlb","jsfs","gnsc","ybbm","jldjlb","created_time","updated_time","bz","zf","generate","fmzt","fmzt_gs","fmzt_hs","fqh_gs","fqh_hs","czy","event","business_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjbg_t',
    'TABLE',
    'sf_mjbg_t',
    'sf_mjbg_t',
    'sf_mjbg_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","area_id","cnq","bgnr","bgnrs","lrsj","czy","czbh","shzt","zf","mob_no","third_type","third_id","mini_third_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjcw_t',
    'TABLE',
    'sf_mjcw_t',
    'sf_mjcw_t',
    'sf_mjcw_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","area_id","mj_id","cnq","cwmj","dj","cwyy","cw_cwrq","cw_sqrq","cw_czy","cw_czbh","hf_hfrq","hf_sqrq","hf_czy","hf_czbh","bz","cwzt","created_time","updated_time","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjhj_t',
    'TABLE',
    'sf_mjhj_t',
    'sf_mjhj_t',
    'sf_mjhj_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","cnq","fylb","hjje","hjrq","hjlx","hjfs","hjxs","czy","czbh","bz","created_time","updated_time","shzt","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjjs_t',
    'TABLE',
    'sf_mjjs_t',
    'sf_mjjs_t',
    'sf_mjjs_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mj_id","cnq","fylb","ysje","sfje","wyje","zkje","qfje","hjje","tgce","sl","dj","jcys","jsfs","ybbm","cbzt","jldj","jlbs","djlb","jldjlb","gnsc","created_time","updated_time","zf","czy","event","business_id","hrq_zt","hrq_sl"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjsf_sh_t',
    'TABLE',
    'sf_mjsf_sh_t',
    'sf_mjsf_sh_t',
    'sf_mjsf_sh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","cnq","fylb","sfrq","sfje","wyje","zkje","sffs","sl","dj","djlb","gnsc","fplb","fpdm","fphm","czy","czbh","bz","zf","created_time","updated_time","zfqd","yywd","lsh","dzzt","fpqqlsh","bill_id","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjsf_t',
    'TABLE',
    'sf_mjsf_t',
    'sf_mjsf_t',
    'sf_mjsf_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","cnq","fylb","sfrq","sfje","wyje","zkje","sffs","sl","dj","djlb","gnsc","fplb","fpdm","fphm","czy","czbh","bz","zf","created_time","updated_time","zfqd","yywd","lsh","dzzt","fpqqlsh","bill_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjtg_sh_t',
    'TABLE',
    'sf_mjtg_sh_t',
    'sf_mjtg_sh_t',
    'sf_mjtg_sh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","customer_id","cnq","type","mob_no","name","address","id_number","third_type","third_id","mini_third_id","tgyy","bz","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjtg_t',
    'TABLE',
    'sf_mjtg_t',
    'sf_mjtg_t',
    'sf_mjtg_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","area_id","mj_id","cnq","ywlx","tgmj","djlb","dj","gnsc","tgyy","tglx","tgbl","ksrq","jsrq","sqrq","czy","czbh","bz","created_time","updated_time","ce_cnf","ce_jbcnf","kgszt","shzt","zf","parent_id","sh_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_mjyk_t',
    'TABLE',
    'sf_mjyk_t',
    'sf_mjyk_t',
    'sf_mjyk_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","fylb","cnq","ykrq","sfje","wyje","zkje","sl","dj","djlb","gnsc","fplb","fpdm","fphm","czy","czbh","bz","ykzt","created_time","zf","fpqqlsh","bill_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_plan_msg_t',
    'TABLE',
    'sf_plan_msg_t',
    'sf_plan_msg_t',
    'sf_plan_msg_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","zf","czy","cnq","customer_id","wx_count","sms_count","next_time","state","plan_sfl_id","name","mob_no","tel_no","qfzt","sfje","ysje","qfje","dh_count","xq"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_plan_sfl_t',
    'TABLE',
    'sf_plan_sfl_t',
    'sf_plan_sfl_t',
    'sf_plan_sfl_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","create_by","update_by","update_time","create_time","ysje","sjsfl","cnq","ssje","hjje","qfje","jhsfl","ksrq","jzrq","fgs","rlz","xq","status","oldsfl"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_pzslsx_t',
    'TABLE',
    'sf_pzslsx_t',
    'sf_pzslsx_t',
    'sf_pzslsx_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","type","end_time","state","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_pzwyj_t',
    'TABLE',
    'sf_pzwyj_t',
    'sf_pzwyj_t',
    'sf_pzwyj_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","cnq","ksrq","jsrq","bl","czy","created_time","zf","remark"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_pzzk_t',
    'TABLE',
    'sf_pzzk_t',
    'sf_pzzk_t',
    'sf_pzzk_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","cnq","ksrq","jsrq","bl","czy","created_time","zf","remark"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwhj_t',
    'TABLE',
    'sf_rwhj_t',
    'sf_rwhj_t',
    'sf_rwhj_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","rwht_id","rwjs_id","cnq","fylb","hjje","hjrq","hjlx","czy","czbh","bz","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwht_t',
    'TABLE',
    'sf_rwht_t',
    'sf_rwht_t',
    'sf_rwht_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","gcmc","htbh","htmc","khmc","qdrq","qdfzr","lxrmc","lxdh","gcdj","gcmj","rwdj","rwmj","created_time","updated_time","bz","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwjs_t',
    'TABLE',
    'sf_rwjs_t',
    'sf_rwjs_t',
    'sf_rwjs_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","rwht_id","cnq","fylb","ysje","sfje","qfje","hjje","sl","dj","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwmj_t',
    'TABLE',
    'sf_rwmj_t',
    'sf_rwmj_t',
    'sf_rwmj_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","rwyh_id","czbh","czy","zf","name","sfmj","zdmj","symj","cgmj","cg","mjlb","djlb","jsfs","gnsc","ybbm","jldjlb","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwsf_t',
    'TABLE',
    'sf_rwsf_t',
    'sf_rwsf_t',
    'sf_rwsf_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","rwht_id","rwjs_id","cnq","fylb","sl","dj","sfje","sffs","sfrq","fplb","fpdm","fphm","czy","czbh","bz","lsh","zfqd","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwsh_t',
    'TABLE',
    'sf_rwsh_t',
    'sf_rwsh_t',
    'sf_rwsh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","czbh","czy","zf","cnq","name","mob_no","id_number","address","one","two","three","address_prefix","unit","floor","room","jzmj","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_rwyh_t',
    'TABLE',
    'sf_rwyh_t',
    'sf_rwyh_t',
    'sf_rwyh_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","updated_time","czbh","czy","zf","rwht_bh","code","yhkh","name","id_number","tel_no","mob_no","ry","one","two","three","address_prefix","unit","floor","room","mp","address","yhlx","rwrq","kzfs","bz","kz_hmd","kz_sf","kz_sf_reason","kz_yhsf","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_ssgl_t',
    'TABLE',
    'sf_ssgl_t',
    'sf_ssgl_t',
    'sf_ssgl_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","reason","state","name","date","type","court","result","czy","czbh","created_time","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_yhbg_t',
    'TABLE',
    'sf_yhbg_t',
    'sf_yhbg_t',
    'sf_yhbg_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","cnq","bgnr","bgnrs","lrsj","czy","czbh","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sf_ystz_t',
    'TABLE',
    'sf_ystz_t',
    'sf_ystz_t',
    'sf_ystz_t table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","mjjs_id","cnq","ysje_old","ysje_new","czbh","czy","created_time","bz","zf","shzt"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sjcs_address',
    'TABLE',
    'sjcs_address',
    'sjcs_address',
    'sjcs_address table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","one","two","three","address_prefix","created_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sync_rlz_zdfq',
    'TABLE',
    'sync_rlz_zdfq',
    'sync_rlz_zdfq',
    'sync_rlz_zdfq table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","third_id","name","state","third_parent_id","path","id_path","sort","czy","created_time","updated_time","type","zf","code","data_from"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'TABLE',
    'sync_rlz_zdfq_2026_01_26_bak',
    'sync_rlz_zdfq_2026_01_26_bak',
    'sync_rlz_zdfq_2026_01_26_bak table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","third_id","name","state","third_parent_id","path","id_path","sort","czy","created_time","updated_time","type","zf","code","data_from"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_address',
    'TABLE',
    'sys_address',
    'sys_address',
    'sys_address table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","name","type","grade","zf","jzmj","code","created_time","updated_time","state"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_address_2026_01_26_bak',
    'TABLE',
    'sys_address_2026_01_26_bak',
    'sys_address_2026_01_26_bak',
    'sys_address_2026_01_26_bak table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","name","type","grade","zf","jzmj","code","created_time","updated_time","state"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_address_change_record',
    'TABLE',
    'sys_address_change_record',
    'sys_address_change_record',
    'sys_address_change_record table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","sys_address_id","old_name","name","czy","created_time","updated_time","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_department',
    'TABLE',
    'sys_department',
    'sys_department',
    'sys_department table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","name","remark","sort","zf"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_log',
    'TABLE',
    'sys_log',
    'sys_log',
    'sys_log table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","operation","params","czy","time","created_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_log_error',
    'TABLE',
    'sys_log_error',
    'sys_log_error',
    'sys_log_error table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","created_time","created_by","business_type","request_url","request_method","request_param","method","exception_detail"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_menu',
    'TABLE',
    'sys_menu',
    'sys_menu',
    'sys_menu table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","name","icon","url","component","remark","type","sort"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_param',
    'TABLE',
    'sys_param',
    'sys_param',
    'sys_param table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","parent_id","year","name","value","remark","level"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_role',
    'TABLE',
    'sys_role',
    'sys_role',
    'sys_role table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","name"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_role_menu',
    'TABLE',
    'sys_role_menu',
    'sys_role_menu',
    'sys_role_menu table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","menu_id","role_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_schedule',
    'TABLE',
    'sys_schedule',
    'sys_schedule',
    'sys_schedule table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","name","cron","class_name","is_open","created_time","czy","is_lock"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_upload',
    'TABLE',
    'sys_upload',
    'sys_upload',
    'sys_upload table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","file_name","temp_name","url","czy","created_time","business_id","business_type","cnq"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_user',
    'TABLE',
    'sys_user',
    'sys_user',
    'sys_user table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","username","password","empno","real_name","locked","department_id","reamrk","mob_no"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_user_department',
    'TABLE',
    'sys_user_department',
    'sys_user_department',
    'sys_user_department table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","user_id","department_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:sys_user_role',
    'TABLE',
    'sys_user_role',
    'sys_user_role',
    'sys_user_role table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","user_id","role_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:table_config',
    'TABLE',
    'table_config',
    'table_config',
    'table_config table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","key_id","user_id","table_id","sort","title","icon","col_width","state","bz"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:wechat_bind',
    'TABLE',
    'wechat_bind',
    'wechat_bind',
    'wechat_bind table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","customer_id","pwd","phone","email","created_time","updated_time"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:zfpt_accept',
    'TABLE',
    'zfpt_accept',
    'zfpt_accept',
    'zfpt_accept table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","projid","accept_man","hander_deptname","hander_deptid","areacode","accept_time","promisevalue","promisetype","promise_etime","belongsystem","create_time","sync_status","dataversion","accept_user_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:zfpt_attr',
    'TABLE',
    'zfpt_attr',
    'zfpt_attr',
    'zfpt_attr table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","unid","projid","taketype","istake","amount","attrname","attrid","is_need","create_time","dataversion","source","file_path"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:zfpt_baseinfo',
    'TABLE',
    'zfpt_baseinfo',
    'zfpt_baseinfo',
    'zfpt_baseinfo table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","projid","projpwd","servicecode","service_deptid","deptid","deptname","ss_orgcode","serviceversion","servicename","projectname","infotype","bus_type","rel_bus_id","apply_type","applyname","apply_cardtype","apply_cardnumber","contactman","telphone","receive_useid","receive_name","applyfrom","approve_type","apply_propertiy","receivetime","areacode","datastate","belongsystem","create_time","sync_status","blzt","dataversion","memo","blms","bjrq","cjrq","fsrq","source"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, status)
VALUES (
    'table:zfpt_transact',
    'TABLE',
    'zfpt_transact',
    'zfpt_transact',
    'zfpt_transact table',
    jsonb_build_object(
        'database', 'charge_zbhx_20260303',
        'columns', '{"id","projid","transact_user","hander_deptname","hander_deptid","areacode","transact_time","transact_result","transact_describe","result","result_code","belongsystem","create_time","sync_status","dataversion","transact_user_id"}'::text[],
        'primaryKey', NULL
    ),
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:address.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:address.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:address.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:address.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_menu.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:app_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_menu.name',
    'COLUMN',
    'name',
    '菜单名称',
    '菜单名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:app_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_menu.url',
    'COLUMN',
    'url',
    '菜单访问路径',
    '菜单访问路径 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:app_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_menu.remark',
    'COLUMN',
    'remark',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:app_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_menu.sort',
    'COLUMN',
    'sort',
    '排序，支持小数',
    '排序，支持小数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:app_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_menu.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:app_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_role_menu.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:app_role_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_role_menu.menu_id',
    'COLUMN',
    'menu_id',
    '菜单主键',
    '菜单主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:app_role_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:app_role_menu.role_id',
    'COLUMN',
    'role_id',
    '角色主键',
    '角色主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:app_role_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.name',
    'COLUMN',
    'name',
    '面积名称',
    '面积名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.zdmj',
    'COLUMN',
    'zdmj',
    '建筑面积',
    '建筑面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.symj',
    'COLUMN',
    'symj',
    '使用面积',
    '使用面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.cgmj',
    'COLUMN',
    'cgmj',
    '超高面积',
    '超高面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.cg',
    'COLUMN',
    'cg',
    '层高',
    '层高 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.jsfs',
    'COLUMN',
    'jsfs',
    '结算方式',
    '结算方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.jldjlb',
    'COLUMN',
    'jldjlb',
    '计量单价类别',
    '计量单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(125)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area.generate',
    'COLUMN',
    'generate',
    '是否生成账单： 0-不生成 1-生成',
    '是否生成账单： 0-不生成 1-生成 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.name',
    'COLUMN',
    'name',
    '面积名称',
    '面积名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.zdmj',
    'COLUMN',
    'zdmj',
    '建筑面积',
    '建筑面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.symj',
    'COLUMN',
    'symj',
    '使用面积',
    '使用面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.cgmj',
    'COLUMN',
    'cgmj',
    '超高面积',
    '超高面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.cg',
    'COLUMN',
    'cg',
    '层高',
    '层高 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.jsfs',
    'COLUMN',
    'jsfs',
    '结算方式',
    '结算方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.jldjlb',
    'COLUMN',
    'jldjlb',
    '计量单价类别',
    '计量单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(125)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:area_sh.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:area_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.type',
    'COLUMN',
    'type',
    '预留字段 类型 1：供暖合同 ',
    '预留字段 类型 1：供暖合同  column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.customer_id',
    'COLUMN',
    'customer_id',
    '用户id',
    '用户id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.cnq',
    'COLUMN',
    'cnq',
    'cnq',
    'cnq column',
    jsonb_build_object(
        'dataType', 'char(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.operation_no',
    'COLUMN',
    'operation_no',
    '编号供暖季开始年度+户号',
    '编号供暖季开始年度+户号 column',
    jsonb_build_object(
        'dataType', 'char(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.status',
    'COLUMN',
    'status',
    '1：生效中、2：已作废、3：已过期',
    '1：生效中、2：已作废、3：已过期 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.sign_name',
    'COLUMN',
    'sign_name',
    '签字人（签署合同时的热用户姓名）',
    '签字人（签署合同时的热用户姓名） column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.zf',
    'COLUMN',
    'zf',
    '是否作废 0不作废 1：作废',
    '是否作废 0不作废 1：作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.file_path',
    'COLUMN',
    'file_path',
    '文件路径',
    '文件路径 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:contract_info.file_type',
    'COLUMN',
    'file_type',
    '预留字段，暂时默认1文件类型 1：pdf 2：图片 ',
    '预留字段，暂时默认1文件类型 1：pdf 2：图片  column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:contract_info',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.task_id',
    'COLUMN',
    'task_id',
    '任务id',
    '任务id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.task_type',
    'COLUMN',
    'task_type',
    '任务类型',
    '任务类型 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.name',
    'COLUMN',
    'name',
    '短信主题',
    '短信主题 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.num',
    'COLUMN',
    'num',
    '短信条数',
    '短信条数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.zt',
    'COLUMN',
    'zt',
    '0是发送中1是发送成功-1是发送失败',
    '0是发送中1是发送成功-1是发送失败 column',
    jsonb_build_object(
        'dataType', 'varchar(2)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.czsj',
    'COLUMN',
    'czsj',
    '操作时间',
    '操作时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.czr',
    'COLUMN',
    'czr',
    '操作人',
    '操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.delayd',
    'COLUMN',
    'delayd',
    '是否定时发生： 0-否 1-是',
    '是否定时发生： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_progress.delaydtime',
    'COLUMN',
    'delaydtime',
    '定时发送时间',
    '定时发送时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_progress',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.template_key',
    'COLUMN',
    'template_key',
    '短信平台配置的短信模板唯一标识',
    '短信平台配置的短信模板唯一标识 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.name',
    'COLUMN',
    'name',
    '模板名称',
    '模板名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.content',
    'COLUMN',
    'content',
    '模板内容',
    '模板内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1024)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.type_id',
    'COLUMN',
    'type_id',
    '模板类型主键',
    '模板类型主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.enable',
    'COLUMN',
    'enable',
    '是否启用： 0-禁用 1-启用',
    '是否启用： 0-禁用 1-启用 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.level',
    'COLUMN',
    'level',
    '排序优先级别',
    '排序优先级别 column',
    jsonb_build_object(
        'dataType', 'int(3)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_sms_template.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_sms_template',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.id',
    'COLUMN',
    'id',
    'ID',
    'ID column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_phone',
    'COLUMN',
    's_phone',
    '手机号码',
    '手机号码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_sender',
    'COLUMN',
    's_sender',
    '发送人',
    '发送人 column',
    jsonb_build_object(
        'dataType', 'varchar(16)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_department',
    'COLUMN',
    's_department',
    '发送部门',
    '发送部门 column',
    jsonb_build_object(
        'dataType', 'varchar(32)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_type',
    'COLUMN',
    's_type',
    '发送类型',
    '发送类型 column',
    jsonb_build_object(
        'dataType', 'varchar(16)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_state',
    'COLUMN',
    's_state',
    '发送状态 0待发送 1已送达 3已提交 -1失败 4已停止',
    '发送状态 0待发送 1已送达 3已提交 -1失败 4已停止 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_sendtime',
    'COLUMN',
    's_sendtime',
    '开始时间',
    '开始时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_template_id',
    'COLUMN',
    's_template_id',
    '短信模版id',
    '短信模版id column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_endtime',
    'COLUMN',
    's_endtime',
    '过期时间',
    '过期时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_content',
    'COLUMN',
    's_content',
    '短信内容',
    '短信内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1024)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_inputtime',
    'COLUMN',
    's_inputtime',
    '录入时间',
    '录入时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_error',
    'COLUMN',
    's_error',
    '失败原因',
    '失败原因 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_linkid',
    'COLUMN',
    's_linkid',
    '发送标识=ID+子账户ID',
    '发送标识=ID+子账户ID column',
    jsonb_build_object(
        'dataType', 'varchar(32)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_yhid',
    'COLUMN',
    's_yhid',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_name',
    'COLUMN',
    's_name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_dz',
    'COLUMN',
    's_dz',
    '用户地址',
    '用户地址 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.progress_id',
    'COLUMN',
    'progress_id',
    'crm_progress主键',
    'crm_progress主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.priority',
    'COLUMN',
    'priority',
    '优先级 1>2>3',
    '优先级 1>2>3 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_smssend.s_cnq',
    'COLUMN',
    's_cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_smssend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_variable.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_variable',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_variable.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_variable',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_variable.lrsj',
    'COLUMN',
    'lrsj',
    'lrsj',
    'lrsj column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_variable',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_variable.name',
    'COLUMN',
    'name',
    'name',
    'name column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_variable',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_variable.code',
    'COLUMN',
    'code',
    'code',
    'code column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_variable',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_variable.bz',
    'COLUMN',
    'bz',
    'bz',
    'bz column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_variable',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.customer_id',
    'COLUMN',
    'customer_id',
    '用户id',
    '用户id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.pmsg_id',
    'COLUMN',
    'pmsg_id',
    '智能催费的消息主键',
    '智能催费的消息主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.content',
    'COLUMN',
    'content',
    '发送内容',
    '发送内容 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(32)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.type',
    'COLUMN',
    'type',
    '分类',
    '分类 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.open_id',
    'COLUMN',
    'open_id',
    '微信的opid',
    '微信的opid column',
    jsonb_build_object(
        'dataType', 'varchar(1024)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.state',
    'COLUMN',
    'state',
    '是否已发送微信消息',
    '是否已发送微信消息 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.created_by',
    'COLUMN',
    'created_by',
    '创建人',
    '创建人 column',
    jsonb_build_object(
        'dataType', 'varchar(32)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.update_time',
    'COLUMN',
    'update_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:crm_wxsend.update_by',
    'COLUMN',
    'update_by',
    '更新人',
    '更新人 column',
    jsonb_build_object(
        'dataType', 'varchar(32)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:crm_wxsend',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.yhkh',
    'COLUMN',
    'yhkh',
    '用户卡号',
    '用户卡号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.ry',
    'COLUMN',
    'ry',
    '热源',
    '热源 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.jz',
    'COLUMN',
    'jz',
    '机组',
    '机组 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.address_prefix',
    'COLUMN',
    'address_prefix',
    '地址前缀',
    '地址前缀 column',
    jsonb_build_object(
        'dataType', 'varchar(35)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.unit',
    'COLUMN',
    'unit',
    '单元',
    '单元 column',
    jsonb_build_object(
        'dataType', 'varchar(15)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.floor',
    'COLUMN',
    'floor',
    '楼层',
    '楼层 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.room',
    'COLUMN',
    'room',
    '房间',
    '房间 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.mp',
    'COLUMN',
    'mp',
    '门牌号',
    '门牌号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.yhlx',
    'COLUMN',
    'yhlx',
    '用户类型：居民/单位',
    '用户类型：居民/单位 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.rwrq',
    'COLUMN',
    'rwrq',
    '入网日期',
    '入网日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.rwht_bh',
    'COLUMN',
    'rwht_bh',
    '入网合同编号',
    '入网合同编号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kzfs',
    'COLUMN',
    'kzfs',
    '控制方式： 分户 未分户',
    '控制方式： 分户 未分户 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_hmd',
    'COLUMN',
    'kz_hmd',
    '用户控制-是否黑名单： 0-否 1-是',
    '用户控制-是否黑名单： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_hmd_reason',
    'COLUMN',
    'kz_hmd_reason',
    '用户控制-是否黑名单-原因',
    '用户控制-是否黑名单-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_sf',
    'COLUMN',
    'kz_sf',
    '用户控制-是否允许收费： 0-否 1-是',
    '用户控制-是否允许收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_sf_reason',
    'COLUMN',
    'kz_sf_reason',
    '用户控制-是否允许收费-原因',
    '用户控制-是否允许收费-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_yhsf',
    'COLUMN',
    'kz_yhsf',
    '用户控制-是否允许银行收费： 0-否 1-是',
    '用户控制-是否允许银行收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_jcsh',
    'COLUMN',
    'kz_jcsh',
    '用户控制-稽查锁户： 0-否 1-是',
    '用户控制-稽查锁户： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.kz_jcsh_reason',
    'COLUMN',
    'kz_jcsh_reason',
    '用户控制-稽查锁户-原因',
    '用户控制-稽查锁户-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.glh',
    'COLUMN',
    'glh',
    '关联号',
    '关联号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.fmzt',
    'COLUMN',
    'fmzt',
    '阀门状态',
    '阀门状态 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.fmzt_ing',
    'COLUMN',
    'fmzt_ing',
    '阀门执行状态',
    '阀门执行状态 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.fmzt_res',
    'COLUMN',
    'fmzt_res',
    '阀门处理状态',
    '阀门处理状态 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.xzcnq',
    'COLUMN',
    'xzcnq',
    '新增采暖期',
    '新增采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.temperature',
    'COLUMN',
    'temperature',
    '室内温度',
    '室内温度 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.rlz_id',
    'COLUMN',
    'rlz_id',
    '热力站主键',
    '热力站主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.zdfq_id',
    'COLUMN',
    'zdfq_id',
    '站点分区主键',
    '站点分区主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.zdfq_name',
    'COLUMN',
    'zdfq_name',
    '站点分区名称',
    '站点分区名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer.hrq_zt',
    'COLUMN',
    'hrq_zt',
    '换热器状态',
    '换热器状态 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.yhkh',
    'COLUMN',
    'yhkh',
    '用户卡号',
    '用户卡号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.ry',
    'COLUMN',
    'ry',
    '热源',
    '热源 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.jz',
    'COLUMN',
    'jz',
    '机组',
    '机组 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.address_prefix',
    'COLUMN',
    'address_prefix',
    '地址前缀',
    '地址前缀 column',
    jsonb_build_object(
        'dataType', 'varchar(35)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.unit',
    'COLUMN',
    'unit',
    '单元',
    '单元 column',
    jsonb_build_object(
        'dataType', 'varchar(15)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.floor',
    'COLUMN',
    'floor',
    '楼层',
    '楼层 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.room',
    'COLUMN',
    'room',
    '房间',
    '房间 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.mp',
    'COLUMN',
    'mp',
    '门牌号',
    '门牌号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.yhlx',
    'COLUMN',
    'yhlx',
    '用户类型：居民/单位',
    '用户类型：居民/单位 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.rwrq',
    'COLUMN',
    'rwrq',
    '入网日期',
    '入网日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.rwht_bh',
    'COLUMN',
    'rwht_bh',
    '入网合同编号',
    '入网合同编号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kzfs',
    'COLUMN',
    'kzfs',
    '控制方式： 分户 未分户',
    '控制方式： 分户 未分户 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_hmd',
    'COLUMN',
    'kz_hmd',
    '用户控制-是否黑名单： 0-否 1-是',
    '用户控制-是否黑名单： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_hmd_reason',
    'COLUMN',
    'kz_hmd_reason',
    '用户控制-是否黑名单-原因',
    '用户控制-是否黑名单-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_sf',
    'COLUMN',
    'kz_sf',
    '用户控制-是否允许收费： 0-否 1-是',
    '用户控制-是否允许收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_sf_reason',
    'COLUMN',
    'kz_sf_reason',
    '用户控制-是否允许收费-原因',
    '用户控制-是否允许收费-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_yhsf',
    'COLUMN',
    'kz_yhsf',
    '用户控制-是否允许银行收费： 0-否 1-是',
    '用户控制-是否允许银行收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_jcsh',
    'COLUMN',
    'kz_jcsh',
    '用户控制-稽查锁户： 0-否 1-是',
    '用户控制-稽查锁户： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.kz_jcsh_reason',
    'COLUMN',
    'kz_jcsh_reason',
    '用户控制-稽查锁户-原因',
    '用户控制-稽查锁户-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.glh',
    'COLUMN',
    'glh',
    '关联号',
    '关联号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.fmzt',
    'COLUMN',
    'fmzt',
    '阀门状态',
    '阀门状态 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.fmzt_ing',
    'COLUMN',
    'fmzt_ing',
    '阀门执行状态',
    '阀门执行状态 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.fmzt_res',
    'COLUMN',
    'fmzt_res',
    '阀门处理状态',
    '阀门处理状态 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.xzcnq',
    'COLUMN',
    'xzcnq',
    '新增采暖期',
    '新增采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.temperature',
    'COLUMN',
    'temperature',
    '室内温度',
    '室内温度 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.rlz_id',
    'COLUMN',
    'rlz_id',
    '热力站主键',
    '热力站主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.zdfq_id',
    'COLUMN',
    'zdfq_id',
    '站点分区主键',
    '站点分区主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.zdfq_name',
    'COLUMN',
    'zdfq_name',
    '站点分区名称',
    '站点分区名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_2026_01_26_bak.hrq_zt',
    'COLUMN',
    'hrq_zt',
    '换热器状态',
    '换热器状态 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_no.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_no',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_no.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_no',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.yhkh',
    'COLUMN',
    'yhkh',
    '用户卡号',
    '用户卡号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.ry',
    'COLUMN',
    'ry',
    '热源',
    '热源 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.address_prefix',
    'COLUMN',
    'address_prefix',
    '地址前缀',
    '地址前缀 column',
    jsonb_build_object(
        'dataType', 'varchar(35)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.unit',
    'COLUMN',
    'unit',
    '单元',
    '单元 column',
    jsonb_build_object(
        'dataType', 'varchar(15)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.floor',
    'COLUMN',
    'floor',
    '楼层',
    '楼层 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.room',
    'COLUMN',
    'room',
    '房间',
    '房间 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(55)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.yhlx',
    'COLUMN',
    'yhlx',
    '用户类型：居民/单位',
    '用户类型：居民/单位 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.rwrq',
    'COLUMN',
    'rwrq',
    '入网日期',
    '入网日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.kzfs',
    'COLUMN',
    'kzfs',
    '控制方式： 分户 未分户',
    '控制方式： 分户 未分户 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.kz_hmd',
    'COLUMN',
    'kz_hmd',
    '用户控制-是否黑名单： 0-否 1-是',
    '用户控制-是否黑名单： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.kz_sf',
    'COLUMN',
    'kz_sf',
    '用户控制-是否允许收费： 0-否 1-是',
    '用户控制-是否允许收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.kz_sf_reason',
    'COLUMN',
    'kz_sf_reason',
    '用户控制-是否允许收费-原因',
    '用户控制-是否允许收费-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.kz_yhsf',
    'COLUMN',
    'kz_yhsf',
    '用户控制-是否允许银行收费： 0-否 1-是',
    '用户控制-是否允许银行收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:customer_sh.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:customer_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.sqr',
    'COLUMN',
    'sqr',
    '申请人',
    '申请人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.ybbm',
    'COLUMN',
    'ybbm',
    '计量表编码',
    '计量表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.cblx',
    'COLUMN',
    'cblx',
    '抄表类型',
    '抄表类型 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.xgq_bds',
    'COLUMN',
    'xgq_bds',
    '修改前表读数',
    '修改前表读数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.xgq_tjyl',
    'COLUMN',
    'xgq_tjyl',
    '修改前调节用量',
    '修改前调节用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.xgq_bjyl',
    'COLUMN',
    'xgq_bjyl',
    '修改前表计用量',
    '修改前表计用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.xgq_sjyl',
    'COLUMN',
    'xgq_sjyl',
    '修改前实际用量',
    '修改前实际用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.bds',
    'COLUMN',
    'bds',
    '表读数',
    '表读数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.bjyl',
    'COLUMN',
    'bjyl',
    '表计用量',
    '表计用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.tjyl',
    'COLUMN',
    'tjyl',
    '调节用量',
    '调节用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.sjyl',
    'COLUMN',
    'sjyl',
    '实际用量',
    '实际用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.cbrq',
    'COLUMN',
    'cbrq',
    '抄表日期',
    '抄表日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.jsrq',
    'COLUMN',
    'jsrq',
    '结算日期',
    '结算日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.sqrq',
    'COLUMN',
    'sqrq',
    '申请日期',
    '申请日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.shzt',
    'COLUMN',
    'shzt',
    '审核状态',
    '审核状态 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.customer_id',
    'COLUMN',
    'customer_id',
    '客户主键',
    '客户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.cbxx_id',
    'COLUMN',
    'cbxx_id',
    '抄表信息主键',
    '抄表信息主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbsh.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbsh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.czy',
    'COLUMN',
    'czy',
    '操作人',
    '操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.xgnr',
    'COLUMN',
    'xgnr',
    '修改内容',
    '修改内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxg.cbxx_id',
    'COLUMN',
    'cbxx_id',
    '抄表id',
    '抄表id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.customer_id',
    'COLUMN',
    'customer_id',
    '客户主键',
    '客户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.cbrq',
    'COLUMN',
    'cbrq',
    '抄表日期',
    '抄表日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.bds',
    'COLUMN',
    'bds',
    '表读数',
    '表读数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.bjyl',
    'COLUMN',
    'bjyl',
    '表计用量',
    '表计用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.tjyl',
    'COLUMN',
    'tjyl',
    '调节用量',
    '调节用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.sjyl',
    'COLUMN',
    'sjyl',
    '实际用量',
    '实际用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.ylje',
    'COLUMN',
    'ylje',
    '用量金额',
    '用量金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.cbqje',
    'COLUMN',
    'cbqje',
    '抄表前金额',
    '抄表前金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.ye',
    'COLUMN',
    'ye',
    '抄表后金额（余额）',
    '抄表后金额（余额） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.jsrq',
    'COLUMN',
    'jsrq',
    '结算日期',
    '结算日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_cbxx.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_cbxx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.gsmc',
    'COLUMN',
    'gsmc',
    '公司名称',
    '公司名称 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.gssh',
    'COLUMN',
    'gssh',
    '公司税号',
    '公司税号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.gsdz',
    'COLUMN',
    'gsdz',
    '公司地址',
    '公司地址 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.cylxr',
    'COLUMN',
    'cylxr',
    '常用联系人',
    '常用联系人 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.phone',
    'COLUMN',
    'phone',
    '手机号码',
    '手机号码 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.ssrw',
    'COLUMN',
    'ssrw',
    '所属热网',
    '所属热网 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.ybbm',
    'COLUMN',
    'ybbm',
    '计量表编码',
    '计量表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.txyz',
    'COLUMN',
    'txyz',
    '提醒阈值',
    '提醒阈值 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.czr',
    'COLUMN',
    'czr',
    '操作人',
    '操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_customer.parent_id',
    'COLUMN',
    'parent_id',
    '父级公司主键',
    '父级公司主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.customer_id',
    'COLUMN',
    'customer_id',
    '客户主键',
    '客户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.dqjg',
    'COLUMN',
    'dqjg',
    '当前价格',
    '当前价格 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.ysjg',
    'COLUMN',
    'ysjg',
    '预设价格',
    '预设价格 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.effective_date',
    'COLUMN',
    'effective_date',
    '生效日期',
    '生效日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.sxlx',
    'COLUMN',
    'sxlx',
    '生效类型：1-即时生效，2-定时生效',
    '生效类型：1-即时生效，2-定时生效 column',
    jsonb_build_object(
        'dataType', 'varchar(2)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.sxzt',
    'COLUMN',
    'sxzt',
    '生效状态：0-未生效，1-已生效',
    '生效状态：0-未生效，1-已生效 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_djxg.czr',
    'COLUMN',
    'czr',
    '操作人',
    '操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_djxg',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.czy',
    'COLUMN',
    'czy',
    '操作人',
    '操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.bgnr',
    'COLUMN',
    'bgnr',
    '变更内容',
    '变更内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_khbgjl.opearte_time',
    'COLUMN',
    'opearte_time',
    '操作时间',
    '操作时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_khbgjl',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.czlx',
    'COLUMN',
    'czlx',
    '操作类型：1-充值，2-调账',
    '操作类型：1-充值，2-调账 column',
    jsonb_build_object(
        'dataType', 'varchar(2)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.czje',
    'COLUMN',
    'czje',
    '充值金额',
    '充值金额 column',
    jsonb_build_object(
        'dataType', 'decimal(12,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.czrq',
    'COLUMN',
    'czrq',
    '充值日期',
    '充值日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ds_zhcz.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ds_zhcz',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.mj_id',
    'COLUMN',
    'mj_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.qsbs',
    'COLUMN',
    'qsbs',
    '起始表数',
    '起始表数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.zzbs',
    'COLUMN',
    'zzbs',
    '终止表数',
    '终止表数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.bjyl',
    'COLUMN',
    'bjyl',
    '表计用量',
    '表计用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.tjyl',
    'COLUMN',
    'tjyl',
    '调节用量',
    '调节用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.sjyl',
    'COLUMN',
    'sjyl',
    '实际用量',
    '实际用量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.cbrq',
    'COLUMN',
    'cbrq',
    '抄表日期',
    '抄表日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.cbr',
    'COLUMN',
    'cbr',
    '抄表人',
    '抄表人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:ebz_cbxx_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:ebz_cbxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.task_id',
    'COLUMN',
    'task_id',
    '任务节点主键',
    '任务节点主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.task_type',
    'COLUMN',
    'task_type',
    '任务节点类型',
    '任务节点类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.candidate_user',
    'COLUMN',
    'candidate_user',
    '候选人主键',
    '候选人主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.operator_id',
    'COLUMN',
    'operator_id',
    '操作员主键',
    '操作员主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.event_type',
    'COLUMN',
    'event_type',
    '事件类型：同意/退回/转派',
    '事件类型：同意/退回/转派 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_candidate_user.event_reason',
    'COLUMN',
    'event_reason',
    '事件原因',
    '事件原因 column',
    jsonb_build_object(
        'dataType', 'varchar(500)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_candidate_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.plan_detail_id',
    'COLUMN',
    'plan_detail_id',
    '计划详情主键',
    '计划详情主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.status',
    'COLUMN',
    'status',
    '稽查结果：正常/异常',
    '稽查结果：正常/异常 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.fmzt_gs',
    'COLUMN',
    'fmzt_gs',
    '阀门状态-供水阀：开/关/断管',
    '阀门状态-供水阀：开/关/断管 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.fmzt_hs',
    'COLUMN',
    'fmzt_hs',
    '阀门状态-回水阀：开/关/断管',
    '阀门状态-回水阀：开/关/断管 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.fqh_gs',
    'COLUMN',
    'fqh_gs',
    '封签号-供水阀',
    '封签号-供水阀 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.fqh_hs',
    'COLUMN',
    'fqh_hs',
    '封签号-回水阀',
    '封签号-回水阀 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.error_type',
    'COLUMN',
    'error_type',
    '稽查问题',
    '稽查问题 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.error_description',
    'COLUMN',
    'error_description',
    '问题描述',
    '问题描述 column',
    jsonb_build_object(
        'dataType', 'varchar(550)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.check_user',
    'COLUMN',
    'check_user',
    '稽查人主键',
    '稽查人主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.check_time',
    'COLUMN',
    'check_time',
    '稽查时间',
    '稽查时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback.shzt',
    'COLUMN',
    'shzt',
    '审核状态：正常/退回',
    '审核状态：正常/退回 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.zf',
    'COLUMN',
    'zf',
    '是否作废:0-正常，1-作废',
    '是否作废:0-正常，1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.auditor',
    'COLUMN',
    'auditor',
    '审核人',
    '审核人 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.audit_time',
    'COLUMN',
    'audit_time',
    '审核时间',
    '审核时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.audit_result',
    'COLUMN',
    'audit_result',
    '审核结果：通过/退回',
    '审核结果：通过/退回 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.audit_remark',
    'COLUMN',
    'audit_remark',
    '审核备注',
    '审核备注 column',
    jsonb_build_object(
        'dataType', 'varchar(600)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.check_id',
    'COLUMN',
    'check_id',
    '反馈记录主键',
    '反馈记录主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_check_feedback_sh.hand_status',
    'COLUMN',
    'hand_status',
    '处理状态：未处理/已处理',
    '处理状态：未处理/已处理 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_check_feedback_sh',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.plan_detail_id',
    'COLUMN',
    'plan_detail_id',
    '计划详情主键',
    '计划详情主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.service_fee',
    'COLUMN',
    'service_fee',
    '管道恢复费(服务费)',
    '管道恢复费(服务费) column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.end_result',
    'COLUMN',
    'end_result',
    '闭环结果：字典项控制',
    '闭环结果：字典项控制 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.end_description',
    'COLUMN',
    'end_description',
    '闭环备注',
    '闭环备注 column',
    jsonb_build_object(
        'dataType', 'varchar(500)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.end_user',
    'COLUMN',
    'end_user',
    '闭环人主键',
    '闭环人主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_end_feedback.end_time',
    'COLUMN',
    'end_time',
    '闭环时间',
    '闭环时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_end_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.plan_detail_id',
    'COLUMN',
    'plan_detail_id',
    '计划详情主键',
    '计划详情主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.fmzt_gs',
    'COLUMN',
    'fmzt_gs',
    '阀门状态-供水阀：开/关/断管',
    '阀门状态-供水阀：开/关/断管 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.fmzt_hs',
    'COLUMN',
    'fmzt_hs',
    '阀门状态-回水阀：开/关/断管',
    '阀门状态-回水阀：开/关/断管 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.fqh_gs',
    'COLUMN',
    'fqh_gs',
    '封签号-供水阀',
    '封签号-供水阀 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.fqh_hs',
    'COLUMN',
    'fqh_hs',
    '封签号-回水阀',
    '封签号-回水阀 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.handle_result',
    'COLUMN',
    'handle_result',
    '处理结果：字典项控制',
    '处理结果：字典项控制 column',
    jsonb_build_object(
        'dataType', 'varchar(512)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.handle_description',
    'COLUMN',
    'handle_description',
    '处理备注',
    '处理备注 column',
    jsonb_build_object(
        'dataType', 'varchar(500)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.handle_user',
    'COLUMN',
    'handle_user',
    '处理人主键',
    '处理人主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.handle_time',
    'COLUMN',
    'handle_time',
    '处理时间',
    '处理时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.handle_user_name',
    'COLUMN',
    'handle_user_name',
    '处理人名称',
    '处理人名称 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.crm_task_id',
    'COLUMN',
    'crm_task_id',
    '客服对应工单id',
    '客服对应工单id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.crm_status',
    'COLUMN',
    'crm_status',
    '客服工单状态 已处理 处结 删除',
    '客服工单状态 已处理 处结 删除 column',
    jsonb_build_object(
        'dataType', 'varchar(16)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.kz_jcsh_update_time',
    'COLUMN',
    'kz_jcsh_update_time',
    '稽查锁户操作时间',
    '稽查锁户操作时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.kz_jcsh_czy',
    'COLUMN',
    'kz_jcsh_czy',
    '用户控制-稽查锁户-操作人',
    '用户控制-稽查锁户-操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.kz_jcsh_reason',
    'COLUMN',
    'kz_jcsh_reason',
    '用户控制-是否黑名单-原因',
    '用户控制-是否黑名单-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_handle_feedback.kz_jcsh',
    'COLUMN',
    'kz_jcsh',
    '用户控制-稽查锁户： 0-否 1-是',
    '用户控制-稽查锁户： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_handle_feedback',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.name',
    'COLUMN',
    'name',
    '计划名称',
    '计划名称 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.status',
    'COLUMN',
    'status',
    '计划状态：待派发/已派发/已终止',
    '计划状态：待派发/已派发/已终止 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.start_type',
    'COLUMN',
    'start_type',
    '下发方式：立即下发/手动下发/定时下发',
    '下发方式：立即下发/手动下发/定时下发 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.start_time',
    'COLUMN',
    'start_time',
    '下发时间',
    '下发时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.end_time',
    'COLUMN',
    'end_time',
    '截止时间',
    '截止时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan.role_id',
    'COLUMN',
    'role_id',
    '稽查组：角色id',
    '稽查组：角色id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.plan_id',
    'COLUMN',
    'plan_id',
    '稽查计划主键',
    '稽查计划主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.customer_id',
    'COLUMN',
    'customer_id',
    '用户信息主键',
    '用户信息主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:jc_plan_detail.status',
    'COLUMN',
    'status',
    '稽查状态：待派发/待稽查/待审核（稽查）/待安排/待处理/待审核（处理）/未闭环/已闭环',
    '稽查状态：待派发/待稽查/待审核（稽查）/待安排/待处理/待审核（处理）/未闭环/已闭环 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:jc_plan_detail',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.type',
    'COLUMN',
    'type',
    '类型，1：微信公众号 2：短信 3：app push ',
    '类型，1：微信公众号 2：短信 3：app push  column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.business_type',
    'COLUMN',
    'business_type',
    '推送的消息类型 0101：面积停供提交 0102：面积停供审核通过 0103：面积停供审核不通过  0201：面积复供提交 0202：面积复供审核通过 0203：面积复供审核不通过  0301：更名过户提交 0302：更名过户审核通过 0303：更名过户审核不通过 0403：缴费成功通知',
    '推送的消息类型 0101：面积停供提交 0102：面积停供审核通过 0103：面积停供审核不通过  0201：面积复供提交 0202：面积复供审核通过 0203：面积复供审核不通过  0301：更名过户提交 0302：更名过户审核通过 0303：更名过户审核不通过 0403：缴费成功通知 column',
    jsonb_build_object(
        'dataType', 'char(4)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.content',
    'COLUMN',
    'content',
    '推送内容',
    '推送内容 column',
    jsonb_build_object(
        'dataType', 'varchar(512)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.error_message',
    'COLUMN',
    'error_message',
    '错误信息，超出部分进行截取',
    '错误信息，超出部分进行截取 column',
    jsonb_build_object(
        'dataType', 'varchar(512)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:message_error_log.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:message_error_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.mysql_ip',
    'COLUMN',
    'mysql_ip',
    'MySQL服务器IP地址',
    'MySQL服务器IP地址 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.mysql_port',
    'COLUMN',
    'mysql_port',
    'MySQL服务器端口号',
    'MySQL服务器端口号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.database_name',
    'COLUMN',
    'database_name',
    '数据库名称',
    '数据库名称 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.mysql_backup_cmd',
    'COLUMN',
    'mysql_backup_cmd',
    'MySQL备份指令',
    'MySQL备份指令 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.mysql_rollback_cmd',
    'COLUMN',
    'mysql_rollback_cmd',
    'MySQL还原指令',
    'MySQL还原指令 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.backup_name',
    'COLUMN',
    'backup_name',
    '备份文件名称',
    '备份文件名称 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.backup_path',
    'COLUMN',
    'backup_path',
    '备份路径',
    '备份路径 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.operation',
    'COLUMN',
    'operation',
    '操作次数',
    '操作次数 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.status',
    'COLUMN',
    'status',
    '数据状态',
    '数据状态 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.zf',
    'COLUMN',
    'zf',
    '作废， 0 正常，1 作废',
    '作废， 0 正常，1 作废 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.xt_name',
    'COLUMN',
    'xt_name',
    '备份系统名称',
    '备份系统名称 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.create_by',
    'COLUMN',
    'create_by',
    '备份人',
    '备份人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.create_time',
    'COLUMN',
    'create_time',
    '备份时间（创建时间）',
    '备份时间（创建时间） column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.recovery_by',
    'COLUMN',
    'recovery_by',
    '恢复人',
    '恢复人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.recovery_time',
    'COLUMN',
    'recovery_time',
    '恢复时间',
    '恢复时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.delete_by',
    'COLUMN',
    'delete_by',
    '删除人',
    '删除人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:mysql_backup.delete_time',
    'COLUMN',
    'delete_time',
    '删除时间',
    '删除时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:mysql_backup',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.pid',
    'COLUMN',
    'pid',
    '收银机编号',
    '收银机编号 column',
    jsonb_build_object(
        'dataType', 'varchar(19)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.cashsn',
    'COLUMN',
    'cashsn',
    '收银软件唯一机器码SN',
    '收银软件唯一机器码SN column',
    jsonb_build_object(
        'dataType', 'varchar(31)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.termsn',
    'COLUMN',
    'termsn',
    '终端设备唯一机器码',
    '终端设备唯一机器码 column',
    jsonb_build_object(
        'dataType', 'varchar(31)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.cashvendor',
    'COLUMN',
    'cashvendor',
    '收银机厂商简称',
    '收银机厂商简称 column',
    jsonb_build_object(
        'dataType', 'varchar(99)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.opid',
    'COLUMN',
    'opid',
    '收银员编号',
    '收银员编号 column',
    jsonb_build_object(
        'dataType', 'varchar(6)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.branchcode',
    'COLUMN',
    'branchcode',
    '分支机构编号',
    '分支机构编号 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.termactiveno',
    'COLUMN',
    'termactiveno',
    '激活码',
    '激活码 column',
    jsonb_build_object(
        'dataType', 'varchar(32)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.version',
    'COLUMN',
    'version',
    '版本号',
    '版本号 column',
    jsonb_build_object(
        'dataType', 'varchar(31)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_device_bind.enable',
    'COLUMN',
    'enable',
    '是否启用，0：启用，1：停用',
    '是否启用，0：启用，1：停用 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_device_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.zkje',
    'COLUMN',
    'zkje',
    '折扣金额',
    '折扣金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.bill_no',
    'COLUMN',
    'bill_no',
    '商户订单号-业务订单号',
    '商户订单号-业务订单号 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.bank_order',
    'COLUMN',
    'bank_order',
    '银商订单号-平台订单号',
    '银商订单号-平台订单号 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.bill_date',
    'COLUMN',
    'bill_date',
    '订单时间',
    '订单时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.pay_date',
    'COLUMN',
    'pay_date',
    '支付时间',
    '支付时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.trace_no',
    'COLUMN',
    'trace_no',
    '凭证号-部分应用撤销和查询用',
    '凭证号-部分应用撤销和查询用 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.merchant_no',
    'COLUMN',
    'merchant_no',
    '终端号',
    '终端号 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.terminal_no',
    'COLUMN',
    'terminal_no',
    '批次号',
    '批次号 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.reference_no',
    'COLUMN',
    'reference_no',
    '交易参考号',
    '交易参考号 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.source',
    'COLUMN',
    'source',
    '来源-渠道唯一标识',
    '来源-渠道唯一标识 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.sfzt',
    'COLUMN',
    'sfzt',
    '收费状态： 0-未收费 1-收费',
    '收费状态： 0-未收费 1-收费 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.yywd',
    'COLUMN',
    'yywd',
    '营业网点',
    '营业网点 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pay_order.term_sn',
    'COLUMN',
    'term_sn',
    '终端设备唯一机器码,Pos机编码',
    '终端设备唯一机器码,Pos机编码 column',
    jsonb_build_object(
        'dataType', 'varchar(31)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:pay_order',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pl_ssgl_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pl_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pl_ssgl_t.rate',
    'COLUMN',
    'rate',
    '完成度',
    '完成度 column',
    jsonb_build_object(
        'dataType', 'decimal(5,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pl_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pl_ssgl_t.type',
    'COLUMN',
    'type',
    '业务类型',
    '业务类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pl_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pl_ssgl_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pl_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pl_ssgl_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pl_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:pl_ssgl_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:pl_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:role_address.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:role_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:role_address.role_id',
    'COLUMN',
    'role_id',
    '角色主键',
    '角色主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:role_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:role_address.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:role_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:role_address.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:role_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:role_address.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:role_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.name',
    'COLUMN',
    'name',
    '面积名称',
    '面积名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_area.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_area',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.code',
    'COLUMN',
    'code',
    '合同编号',
    '合同编号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.rwrq',
    'COLUMN',
    'rwrq',
    '入网日期',
    '入网日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_customer.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_customer',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjjs_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.sfrq',
    'COLUMN',
    'sfrq',
    '收费日期',
    '收费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.sffs',
    'COLUMN',
    'sffs',
    '收费方式',
    '收费方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:rw_mjsf_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:rw_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.user_id',
    'COLUMN',
    'user_id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.one_id',
    'COLUMN',
    'one_id',
    '上级id',
    '上级id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.two_id_pid',
    'COLUMN',
    'two_id_pid',
    '热力站名称或者站点分区名称',
    '热力站名称或者站点分区名称 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.two_name',
    'COLUMN',
    'two_name',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.fq_id',
    'COLUMN',
    'fq_id',
    '上级的第三方id',
    '上级的第三方id column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.fq_name',
    'COLUMN',
    'fq_name',
    '站点路径',
    '站点路径 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sanwangronghe_temp.status',
    'COLUMN',
    'status',
    '状态，默认1',
    '状态，默认1 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sanwangronghe_temp',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.user_id',
    'COLUMN',
    'user_id',
    '用户编号',
    '用户编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.user_code',
    'COLUMN',
    'user_code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.user_name',
    'COLUMN',
    'user_name',
    '用户姓名',
    '用户姓名 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.one',
    'COLUMN',
    'one',
    '分公司',
    '分公司 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.two',
    'COLUMN',
    'two',
    '热力站',
    '热力站 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.three',
    'COLUMN',
    'three',
    '小区',
    '小区 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.address_prefix',
    'COLUMN',
    'address_prefix',
    '楼号（地址前缀）',
    '楼号（地址前缀） column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.unit',
    'COLUMN',
    'unit',
    '单元',
    '单元 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.floor',
    'COLUMN',
    'floor',
    '楼层',
    '楼层 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.room',
    'COLUMN',
    'room',
    '房间',
    '房间 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_cnq',
    'COLUMN',
    'audit_cnq',
    '稽查采暖期',
    '稽查采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_time',
    'COLUMN',
    'audit_time',
    '稽查日期(与创建日期)',
    '稽查日期(与创建日期) column',
    jsonb_build_object(
        'dataType', 'datetime(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_problem',
    'COLUMN',
    'audit_problem',
    '稽查问题',
    '稽查问题 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_situation',
    'COLUMN',
    'audit_situation',
    '稽查情况',
    '稽查情况 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_person',
    'COLUMN',
    'audit_person',
    '稽查人',
    '稽查人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_process_time',
    'COLUMN',
    'audit_process_time',
    '稽查处理日期',
    '稽查处理日期 column',
    jsonb_build_object(
        'dataType', 'datetime(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_process_result',
    'COLUMN',
    'audit_process_result',
    '稽查处理结果',
    '稽查处理结果 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_process_situation',
    'COLUMN',
    'audit_process_situation',
    '稽查处理情况',
    '稽查处理情况 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_process_person',
    'COLUMN',
    'audit_process_person',
    '稽查处理人',
    '稽查处理人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_accessory_id',
    'COLUMN',
    'audit_accessory_id',
    '稽查上传附件编号',
    '稽查上传附件编号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_process_status',
    'COLUMN',
    'audit_process_status',
    '稽查处理状态：0、未处理，1、已处理',
    '稽查处理状态：0、未处理，1、已处理 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_status',
    'COLUMN',
    'audit_status',
    '稽查结果：0、计划 1，正常，2，存在问题',
    '稽查结果：0、计划 1，正常，2，存在问题 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.audit_memo',
    'COLUMN',
    'audit_memo',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.create_by',
    'COLUMN',
    'create_by',
    '创建人',
    '创建人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.create_time',
    'COLUMN',
    'create_time',
    '创建日期',
    '创建日期 column',
    jsonb_build_object(
        'dataType', 'datetime(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.update_by',
    'COLUMN',
    'update_by',
    '更新人',
    '更新人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit.update_time',
    'COLUMN',
    'update_time',
    '更新日期',
    '更新日期 column',
    jsonb_build_object(
        'dataType', 'datetime(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_id',
    'COLUMN',
    'audit_id',
    '稽查主键（id）',
    '稽查主键（id） column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_name',
    'COLUMN',
    'audit_name',
    '附件名称',
    '附件名称 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_type',
    'COLUMN',
    'audit_type',
    '附件类型',
    '附件类型 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_path',
    'COLUMN',
    'audit_path',
    '上传路径',
    '上传路径 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_uuid',
    'COLUMN',
    'audit_uuid',
    '文件编号',
    '文件编号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_source',
    'COLUMN',
    'audit_source',
    '附件来源',
    '附件来源 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_accessory_type',
    'COLUMN',
    'audit_accessory_type',
    '附件类型：录音，图片，文件',
    '附件类型：录音，图片，文件 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.audit_memo',
    'COLUMN',
    'audit_memo',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.create_by',
    'COLUMN',
    'create_by',
    '创建人',
    '创建人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.create_time',
    'COLUMN',
    'create_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.update_by',
    'COLUMN',
    'update_by',
    '更新人',
    '更新人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_accessory.update_time',
    'COLUMN',
    'update_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_accessory',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.audit_id',
    'COLUMN',
    'audit_id',
    '稽查表主键',
    '稽查表主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.user_code',
    'COLUMN',
    'user_code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.jcjfje',
    'COLUMN',
    'jcjfje',
    '稽查缴费金额',
    '稽查缴费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.jcjfrq',
    'COLUMN',
    'jcjfrq',
    '稽查缴费日期',
    '稽查缴费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.jcwt',
    'COLUMN',
    'jcwt',
    '稽查问题',
    '稽查问题 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.jcqk',
    'COLUMN',
    'jcqk',
    '稽查情况',
    '稽查情况 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.jcjg',
    'COLUMN',
    'jcjg',
    '稽查结果：0，计划；1，正常，2，存在问题',
    '稽查结果：0，计划；1，正常，2，存在问题 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.create_by',
    'COLUMN',
    'create_by',
    '创建人',
    '创建人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.create_time',
    'COLUMN',
    'create_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.update_by',
    'COLUMN',
    'update_by',
    '更新人',
    '更新人 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_audit_jfmx.update_time',
    'COLUMN',
    'update_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_audit_jfmx',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.type',
    'COLUMN',
    'type',
    '类型',
    '类型 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.titel',
    'COLUMN',
    'titel',
    '标题',
    '标题 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.fwlj',
    'COLUMN',
    'fwlj',
    '服务路径',
    '服务路径 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.zjlj',
    'COLUMN',
    'zjlj',
    '组件路径',
    '组件路径 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_config_t.flag',
    'COLUMN',
    'flag',
    '是否启用 1:启用0:不启用',
    '是否启用 1:启用0:不启用 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_config_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_cqbl_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_cqbl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.cjyf',
    'COLUMN',
    'cjyf',
    'cjyf',
    'cjyf column',
    jsonb_build_object(
        'dataType', 'varchar(7)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.zdmj',
    'COLUMN',
    'zdmj',
    'zdmj',
    'zdmj column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.sfmj',
    'COLUMN',
    'sfmj',
    'sfmj',
    'sfmj column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.tghs',
    'COLUMN',
    'tghs',
    'tghs',
    'tghs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.tgmj',
    'COLUMN',
    'tgmj',
    'tgmj',
    'tgmj column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.cwhs',
    'COLUMN',
    'cwhs',
    'cwhs',
    'cwhs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.cwmj',
    'COLUMN',
    'cwmj',
    'cwmj',
    'cwmj column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.hs',
    'COLUMN',
    'hs',
    'hs',
    'hs column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.ysje',
    'COLUMN',
    'ysje',
    'ysje',
    'ysje column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.ssje',
    'COLUMN',
    'ssje',
    'ssje',
    'ssje column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.ssmj',
    'COLUMN',
    'ssmj',
    'ssmj',
    'ssmj column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.sfhs',
    'COLUMN',
    'sfhs',
    'sfhs',
    'sfhs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.sfhs_part',
    'COLUMN',
    'sfhs_part',
    'sfhs_part',
    'sfhs_part column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.qfje',
    'COLUMN',
    'qfje',
    'qfje',
    'qfje column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.qfmj',
    'COLUMN',
    'qfmj',
    'qfmj',
    'qfmj column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.qfhs',
    'COLUMN',
    'qfhs',
    'qfhs',
    'qfhs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.qfhs_part',
    'COLUMN',
    'qfhs_part',
    'qfhs_part',
    'qfhs_part column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.yjje',
    'COLUMN',
    'yjje',
    'yjje',
    'yjje column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.yjhs',
    'COLUMN',
    'yjhs',
    'yjhs',
    'yjhs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.hjje',
    'COLUMN',
    'hjje',
    'hjje',
    'hjje column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.hjhs',
    'COLUMN',
    'hjhs',
    'hjhs',
    'hjhs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.zrhs',
    'COLUMN',
    'zrhs',
    'zrhs',
    'zrhs column',
    jsonb_build_object(
        'dataType', 'decimal(23,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.zrmj',
    'COLUMN',
    'zrmj',
    'zrmj',
    'zrmj column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fgshz_t.zrys',
    'COLUMN',
    'zrys',
    'zrys',
    'zrys column',
    jsonb_build_object(
        'dataType', 'decimal(32,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fgshz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.ywlx',
    'COLUMN',
    'ywlx',
    '业务类型：购买/退还',
    '业务类型：购买/退还 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.ks_fphm',
    'COLUMN',
    'ks_fphm',
    '发票号码-开始票号',
    '发票号码-开始票号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.js_fphm',
    'COLUMN',
    'js_fphm',
    '发票号码-结束票号',
    '发票号码-结束票号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.fpws',
    'COLUMN',
    'fpws',
    '发票位数',
    '发票位数 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.thsl',
    'COLUMN',
    'thsl',
    '退还数量',
    '退还数量 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.lrsj',
    'COLUMN',
    'lrsj',
    '录入时间',
    '录入时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.lyr',
    'COLUMN',
    'lyr',
    '领用人',
    '领用人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpgm_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpgm_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.fpgm_id',
    'COLUMN',
    'fpgm_id',
    '发票购买主键',
    '发票购买主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.lyr',
    'COLUMN',
    'lyr',
    '领用人',
    '领用人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.syzt',
    'COLUMN',
    'syzt',
    '使用状态： 0-未使用 1-已使用',
    '使用状态： 0-未使用 1-已使用 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fply_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fply_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.kpr',
    'COLUMN',
    'kpr',
    '开票人',
    '开票人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.kprq',
    'COLUMN',
    'kprq',
    '开票日期',
    '开票日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.jshj',
    'COLUMN',
    'jshj',
    '价税合计',
    '价税合计 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.hjje',
    'COLUMN',
    'hjje',
    '合计金额',
    '合计金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.hjse',
    'COLUMN',
    'hjse',
    '合计税额',
    '合计税额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.sl',
    'COLUMN',
    'sl',
    '税率',
    '税率 column',
    jsonb_build_object(
        'dataType', 'decimal(5,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.yywd',
    'COLUMN',
    'yywd',
    '营业网点',
    '营业网点 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.gmf_bm',
    'COLUMN',
    'gmf_bm',
    '购买方-编码',
    '购买方-编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.gmf_mc',
    'COLUMN',
    'gmf_mc',
    '购买方-名称',
    '购买方-名称 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.gmf_sh',
    'COLUMN',
    'gmf_sh',
    '购买方-税号',
    '购买方-税号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.gmf_dzdh',
    'COLUMN',
    'gmf_dzdh',
    '购买方-地址电话',
    '购买方-地址电话 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.gmf_yhzh',
    'COLUMN',
    'gmf_yhzh',
    '购买方-银行账户',
    '购买方-银行账户 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.yfpdm',
    'COLUMN',
    'yfpdm',
    '原发票代码',
    '原发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.yfphm',
    'COLUMN',
    'yfphm',
    '原发票号码',
    '原发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.email',
    'COLUMN',
    'email',
    '邮箱账号',
    '邮箱账号 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.phone',
    'COLUMN',
    'phone',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.tsfs',
    'COLUMN',
    'tsfs',
    '推送方式：-1,不推送;0,邮箱;1,手机;2,邮箱、手机',
    '推送方式：-1,不推送;0,邮箱;1,手机;2,邮箱、手机 column',
    jsonb_build_object(
        'dataType', 'varchar(2)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.pj_url',
    'COLUMN',
    'pj_url',
    '票据地址',
    '票据地址 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.fpqqlsh',
    'COLUMN',
    'fpqqlsh',
    '发票请求流水号',
    '发票请求流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.status',
    'COLUMN',
    'status',
    '1-申请开票2-开票中3-开票成功4-开票失败5-红冲待销方确认',
    '1-申请开票2-开票中3-开票成功4-开票失败5-红冲待销方确认 column',
    jsonb_build_object(
        'dataType', 'varchar(8)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.invoice_line',
    'COLUMN',
    'invoice_line',
    'pc:电子发票bs：电子发票（增值税专用发票）-即数电专票（电子）',
    'pc:电子发票bs：电子发票（增值税专用发票）-即数电专票（电子） column',
    jsonb_build_object(
        'dataType', 'varchar(16)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.invoice_type',
    'COLUMN',
    'invoice_type',
    '开票类型：1-蓝票 2-红票',
    '开票类型：1-蓝票 2-红票 column',
    jsonb_build_object(
        'dataType', 'varchar(8)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.order_no',
    'COLUMN',
    'order_no',
    '发票订单号',
    '发票订单号 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.bill_uuid',
    'COLUMN',
    'bill_uuid',
    '红冲uuid',
    '红冲uuid column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_fpxx_t.bill_no',
    'COLUMN',
    'bill_no',
    '确认单编号',
    '确认单编号 column',
    jsonb_build_object(
        'dataType', 'varchar(128)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_fpxx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_glh_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_glh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_glh_t.yh_id',
    'COLUMN',
    'yh_id',
    '用户id',
    '用户id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_glh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_glh_t.glh_id',
    'COLUMN',
    'glh_id',
    '关联户id',
    '关联户id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_glh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_glh_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_glh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.old_name',
    'COLUMN',
    'old_name',
    '原用户名称',
    '原用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.third_type',
    'COLUMN',
    'third_type',
    '第三方渠道',
    '第三方渠道 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.third_id',
    'COLUMN',
    'third_id',
    '微信公众号openId',
    '微信公众号openId column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.mini_third_id',
    'COLUMN',
    'mini_third_id',
    '微信小程序openId',
    '微信小程序openId column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.old_id_number',
    'COLUMN',
    'old_id_number',
    '原身份证号',
    '原身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.old_mob_no',
    'COLUMN',
    'old_mob_no',
    '原手机号',
    '原手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_gmgh_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_gmgh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.gnzt',
    'COLUMN',
    'gnzt',
    '供暖状态',
    '供暖状态 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.gnrq',
    'COLUMN',
    'gnrq',
    '开始供暖日期',
    '开始供暖日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.jclx',
    'COLUMN',
    'jclx',
    '稽查类型',
    '稽查类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.jcrq',
    'COLUMN',
    'jcrq',
    '稽查日期',
    '稽查日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.jcr',
    'COLUMN',
    'jcr',
    '稽查人',
    '稽查人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.jcwt',
    'COLUMN',
    'jcwt',
    '稽查问题',
    '稽查问题 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.clrq',
    'COLUMN',
    'clrq',
    '处理日期',
    '处理日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.clr',
    'COLUMN',
    'clr',
    '处理人',
    '处理人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.clzt',
    'COLUMN',
    'clzt',
    '处理状态',
    '处理状态 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.cljg',
    'COLUMN',
    'cljg',
    '处理结果',
    '处理结果 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.kz_jcsh',
    'COLUMN',
    'kz_jcsh',
    '用户控制-稽查锁户： 0-否 1-是',
    '用户控制-稽查锁户： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcgl_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.jcz',
    'COLUMN',
    'jcz',
    '稽查组',
    '稽查组 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.jcr',
    'COLUMN',
    'jcr',
    '稽查人',
    '稽查人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.clr',
    'COLUMN',
    'clr',
    '处理人',
    '处理人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.jcjg',
    'COLUMN',
    'jcjg',
    '稽查结果',
    '稽查结果 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.jcwt',
    'COLUMN',
    'jcwt',
    '稽查问题',
    '稽查问题 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.jcrq',
    'COLUMN',
    'jcrq',
    '稽查日期',
    '稽查日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.yhkh',
    'COLUMN',
    'yhkh',
    '用户卡号',
    '用户卡号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.other_no',
    'COLUMN',
    'other_no',
    '其他号码',
    '其他号码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcjh_t.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(55)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcjh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.jcgl_id',
    'COLUMN',
    'jcgl_id',
    '稽查管理主键',
    '稽查管理主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.sfrq',
    'COLUMN',
    'sfrq',
    '收费日期',
    '收费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.sffs',
    'COLUMN',
    'sffs',
    '收费方式',
    '收费方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_jcsf_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_jcsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.zdmj',
    'COLUMN',
    'zdmj',
    '占地面积',
    '占地面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.cgmj',
    'COLUMN',
    'cgmj',
    '超高面积',
    '超高面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.cwmj',
    'COLUMN',
    'cwmj',
    '拆网面积',
    '拆网面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.tgmj',
    'COLUMN',
    'tgmj',
    '停供面积',
    '停供面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.zkje',
    'COLUMN',
    'zkje',
    '折扣金额',
    '折扣金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.hjje',
    'COLUMN',
    'hjje',
    '核减金额',
    '核减金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_js_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_js_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.task_id',
    'COLUMN',
    'task_id',
    'sf_ksgs_task_t主表id',
    'sf_ksgs_task_t主表id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.event_type',
    'COLUMN',
    'event_type',
    '事件类型',
    '事件类型 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.event_time',
    'COLUMN',
    'event_time',
    '事件通过时间',
    '事件通过时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.czy',
    'COLUMN',
    'czy',
    '操作人',
    '操作人 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.business_key',
    'COLUMN',
    'business_key',
    '业务编号（工单编号/缴费编号/停供编号）',
    '业务编号（工单编号/缴费编号/停供编号） column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.content',
    'COLUMN',
    'content',
    '变更内容',
    '变更内容 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_log_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(500)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_log_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.type',
    'COLUMN',
    'type',
    '业务类型：开阀/关阀',
    '业务类型：开阀/关阀 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.cljg',
    'COLUMN',
    'cljg',
    '处理结果：已处理/无法处理',
    '处理结果：已处理/无法处理 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.fmzt',
    'COLUMN',
    'fmzt',
    '阀门状态：开阀/关阀',
    '阀门状态：开阀/关阀 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.czsj',
    'COLUMN',
    'czsj',
    '操作时间',
    '操作时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_t.task_id',
    'COLUMN',
    'task_id',
    '工单编号',
    '工单编号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.jfzt_old',
    'COLUMN',
    'jfzt_old',
    '上年缴费状态：已缴费/未缴费',
    '上年缴费状态：已缴费/未缴费 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.gnzt_old',
    'COLUMN',
    'gnzt_old',
    '上年供暖状态：正常/停供/部分停供',
    '上年供暖状态：正常/停供/部分停供 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.fmzt_old',
    'COLUMN',
    'fmzt_old',
    '上年阀门状态：开阀/关阀',
    '上年阀门状态：开阀/关阀 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.jfzt',
    'COLUMN',
    'jfzt',
    '缴费状态：已缴费/未缴费',
    '缴费状态：已缴费/未缴费 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.sfrq',
    'COLUMN',
    'sfrq',
    '缴费日期',
    '缴费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.gnzt',
    'COLUMN',
    'gnzt',
    '供暖状态：正常/停供/部分停供',
    '供暖状态：正常/停供/部分停供 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.fmzt',
    'COLUMN',
    'fmzt',
    '阀门状态：开阀/关阀',
    '阀门状态：开阀/关阀 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.fmbh',
    'COLUMN',
    'fmbh',
    '阀门编号',
    '阀门编号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.rwlx',
    'COLUMN',
    'rwlx',
    '任务类型:开阀/关阀',
    '任务类型:开阀/关阀 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.rwzt',
    'COLUMN',
    'rwzt',
    '任务状态：待处理/处理中/已处理',
    '任务状态：待处理/处理中/已处理 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.crm_task_id',
    'COLUMN',
    'crm_task_id',
    '工单编号',
    '工单编号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.crm_task_create_time',
    'COLUMN',
    'crm_task_create_time',
    '工单创建时间',
    '工单创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.crm_task_operator',
    'COLUMN',
    'crm_task_operator',
    '工单处理人',
    '工单处理人 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.crm_task_department',
    'COLUMN',
    'crm_task_department',
    '工单处理部门',
    '工单处理部门 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.crm_task_handle_time',
    'COLUMN',
    'crm_task_handle_time',
    '工单处理时间',
    '工单处理时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ksgs_task_t.crm_task_result',
    'COLUMN',
    'crm_task_result',
    '工单处理结果',
    '工单处理结果 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ksgs_task_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.gnzt',
    'COLUMN',
    'gnzt',
    '供暖状态',
    '供暖状态 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.name',
    'COLUMN',
    'name',
    '面积名称',
    '面积名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.ce_cnf',
    'COLUMN',
    'ce_cnf',
    '采暖费差额',
    '采暖费差额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.ce_jbcnf',
    'COLUMN',
    'ce_jbcnf',
    '基本采暖费差额',
    '基本采暖费差额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.tgmj',
    'COLUMN',
    'tgmj',
    '停供面积',
    '停供面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.cwmj',
    'COLUMN',
    'cwmj',
    '拆网面积',
    '拆网面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.grmj',
    'COLUMN',
    'grmj',
    '供热面积',
    '供热面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.zdmj',
    'COLUMN',
    'zdmj',
    '建筑面积',
    '建筑面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.symj',
    'COLUMN',
    'symj',
    '使用面积',
    '使用面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.cgmj',
    'COLUMN',
    'cgmj',
    '超高面积',
    '超高面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.cg',
    'COLUMN',
    'cg',
    '层高',
    '层高 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.jsfs',
    'COLUMN',
    'jsfs',
    '结算方式',
    '结算方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.jldjlb',
    'COLUMN',
    'jldjlb',
    '计量单价类别',
    '计量单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(125)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.generate',
    'COLUMN',
    'generate',
    '是否生成账单： 0-不生成 1-生成',
    '是否生成账单： 0-不生成 1-生成 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.fmzt',
    'COLUMN',
    'fmzt',
    '阀门状态 开阀/关阀',
    '阀门状态 开阀/关阀 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.fmzt_gs',
    'COLUMN',
    'fmzt_gs',
    '阀门状态-供水阀：开/关/断管',
    '阀门状态-供水阀：开/关/断管 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.fmzt_hs',
    'COLUMN',
    'fmzt_hs',
    '阀门状态-回水阀：开/关/断管',
    '阀门状态-回水阀：开/关/断管 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.fqh_gs',
    'COLUMN',
    'fqh_gs',
    '封签号-供水阀',
    '封签号-供水阀 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.fqh_hs',
    'COLUMN',
    'fqh_hs',
    '封签号-回水阀',
    '封签号-回水阀 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.event',
    'COLUMN',
    'event',
    '事件名称',
    '事件名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mj_t.business_id',
    'COLUMN',
    'business_id',
    '业务事件ID 面积变更主键',
    '业务事件ID 面积变更主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.bgnr',
    'COLUMN',
    'bgnr',
    '变更内容',
    '变更内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.bgnrs',
    'COLUMN',
    'bgnrs',
    '详细变更内容',
    '详细变更内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.lrsj',
    'COLUMN',
    'lrsj',
    '录入时间',
    '录入时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号码',
    '手机号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.third_type',
    'COLUMN',
    'third_type',
    '第三方渠道',
    '第三方渠道 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.third_id',
    'COLUMN',
    'third_id',
    '微信公众号openId',
    '微信公众号openId column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjbg_t.mini_third_id',
    'COLUMN',
    'mini_third_id',
    '微信小程序openId',
    '微信小程序openId column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.mj_id',
    'COLUMN',
    'mj_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cwmj',
    'COLUMN',
    'cwmj',
    '拆网面积',
    '拆网面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cwyy',
    'COLUMN',
    'cwyy',
    '拆网原因',
    '拆网原因 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cw_cwrq',
    'COLUMN',
    'cw_cwrq',
    '拆网日期',
    '拆网日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cw_sqrq',
    'COLUMN',
    'cw_sqrq',
    '拆网申请日期',
    '拆网申请日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cw_czy',
    'COLUMN',
    'cw_czy',
    '拆网操作员',
    '拆网操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cw_czbh',
    'COLUMN',
    'cw_czbh',
    '拆网操作编号',
    '拆网操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.hf_hfrq',
    'COLUMN',
    'hf_hfrq',
    '恢复日期',
    '恢复日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.hf_sqrq',
    'COLUMN',
    'hf_sqrq',
    '恢复申请日期',
    '恢复申请日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.hf_czy',
    'COLUMN',
    'hf_czy',
    '恢复操作员',
    '恢复操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.hf_czbh',
    'COLUMN',
    'hf_czbh',
    '恢复操作编号',
    '恢复操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.cwzt',
    'COLUMN',
    'cwzt',
    '拆网状态： 0-已恢复 1-已停供',
    '拆网状态： 0-已恢复 1-已停供 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjcw_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjcw_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.hjje',
    'COLUMN',
    'hjje',
    '核减金额',
    '核减金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.hjrq',
    'COLUMN',
    'hjrq',
    '核减日期',
    '核减日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.hjlx',
    'COLUMN',
    'hjlx',
    '核减类型',
    '核减类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.hjfs',
    'COLUMN',
    'hjfs',
    '核减方式: 金额/天数/面积/比例',
    '核减方式: 金额/天数/面积/比例 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.hjxs',
    'COLUMN',
    'hjxs',
    '核减系数（单位：元/天/平方米/百分比）',
    '核减系数（单位：元/天/平方米/百分比） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(300)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjhj_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.mj_id',
    'COLUMN',
    'mj_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.zkje',
    'COLUMN',
    'zkje',
    '折扣金额',
    '折扣金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.hjje',
    'COLUMN',
    'hjje',
    '核减金额',
    '核减金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.tgce',
    'COLUMN',
    'tgce',
    '停供差额',
    '停供差额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.jcys',
    'COLUMN',
    'jcys',
    '基础应收',
    '基础应收 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.jsfs',
    'COLUMN',
    'jsfs',
    '结算方式',
    '结算方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.cbzt',
    'COLUMN',
    'cbzt',
    '是否抄表： 0-未抄表 1-已抄表',
    '是否抄表： 0-未抄表 1-已抄表 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.jldj',
    'COLUMN',
    'jldj',
    '计量单价',
    '计量单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.jlbs',
    'COLUMN',
    'jlbs',
    '计量表数',
    '计量表数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.jldjlb',
    'COLUMN',
    'jldjlb',
    '计量单价类别',
    '计量单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.event',
    'COLUMN',
    'event',
    '业务事件',
    '业务事件 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.business_id',
    'COLUMN',
    'business_id',
    '业务事件ID',
    '业务事件ID column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.hrq_zt',
    'COLUMN',
    'hrq_zt',
    '换热器状态：有设备/无设备',
    '换热器状态：有设备/无设备 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjjs_t.hrq_sl',
    'COLUMN',
    'hrq_sl',
    '换热器数量',
    '换热器数量 column',
    jsonb_build_object(
        'dataType', 'decimal(5,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.sfrq',
    'COLUMN',
    'sfrq',
    '收费日期',
    '收费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.zkje',
    'COLUMN',
    'zkje',
    '折扣金额',
    '折扣金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.sffs',
    'COLUMN',
    'sffs',
    '收费方式',
    '收费方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.zfqd',
    'COLUMN',
    'zfqd',
    '支付渠道：公司自收/银行代收',
    '支付渠道：公司自收/银行代收 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.yywd',
    'COLUMN',
    'yywd',
    '营业网点',
    '营业网点 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.lsh',
    'COLUMN',
    'lsh',
    '第三方支付-流水号',
    '第三方支付-流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.dzzt',
    'COLUMN',
    'dzzt',
    '第三方支付-对账状态',
    '第三方支付-对账状态 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.fpqqlsh',
    'COLUMN',
    'fpqqlsh',
    '发票请求流水号',
    '发票请求流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.bill_id',
    'COLUMN',
    'bill_id',
    '红冲申请单编号',
    '红冲申请单编号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_sh_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.sfrq',
    'COLUMN',
    'sfrq',
    '收费日期',
    '收费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.zkje',
    'COLUMN',
    'zkje',
    '折扣金额',
    '折扣金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.sffs',
    'COLUMN',
    'sffs',
    '收费方式',
    '收费方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.zfqd',
    'COLUMN',
    'zfqd',
    '支付渠道：公司自收/银行代收',
    '支付渠道：公司自收/银行代收 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.yywd',
    'COLUMN',
    'yywd',
    '营业网点',
    '营业网点 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.lsh',
    'COLUMN',
    'lsh',
    '第三方支付-流水号',
    '第三方支付-流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.dzzt',
    'COLUMN',
    'dzzt',
    '第三方支付-对账状态',
    '第三方支付-对账状态 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.fpqqlsh',
    'COLUMN',
    'fpqqlsh',
    '发票请求流水号',
    '发票请求流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjsf_t.bill_id',
    'COLUMN',
    'bill_id',
    '红冲申请单编号',
    '红冲申请单编号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.type',
    'COLUMN',
    'type',
    '类型：停供/复供',
    '类型：停供/复供 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.address',
    'COLUMN',
    'address',
    '用户地址',
    '用户地址 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.third_type',
    'COLUMN',
    'third_type',
    '第三方渠道',
    '第三方渠道 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.third_id',
    'COLUMN',
    'third_id',
    '微信公众号openId',
    '微信公众号openId column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.mini_third_id',
    'COLUMN',
    'mini_third_id',
    '微信小程序openId',
    '微信小程序openId column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.tgyy',
    'COLUMN',
    'tgyy',
    '停供原因',
    '停供原因 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_sh_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_sh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.area_id',
    'COLUMN',
    'area_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.mj_id',
    'COLUMN',
    'mj_id',
    '面积主键',
    '面积主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.ywlx',
    'COLUMN',
    'ywlx',
    '停供/复供',
    '停供/复供 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.tgmj',
    'COLUMN',
    'tgmj',
    '停供面积',
    '停供面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.tgyy',
    'COLUMN',
    'tgyy',
    '停供原因',
    '停供原因 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.tglx',
    'COLUMN',
    'tglx',
    '停供类型',
    '停供类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.tgbl',
    'COLUMN',
    'tgbl',
    '停供比率',
    '停供比率 column',
    jsonb_build_object(
        'dataType', 'decimal(5,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.ksrq',
    'COLUMN',
    'ksrq',
    '停供开始日期',
    '停供开始日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.jsrq',
    'COLUMN',
    'jsrq',
    '复供结算日期',
    '复供结算日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.sqrq',
    'COLUMN',
    'sqrq',
    '申请日期',
    '申请日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.ce_cnf',
    'COLUMN',
    'ce_cnf',
    '采暖费差额',
    '采暖费差额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.ce_jbcnf',
    'COLUMN',
    'ce_jbcnf',
    '基本采暖费差额',
    '基本采暖费差额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.kgszt',
    'COLUMN',
    'kgszt',
    '开关栓状态 0-关栓 1-开栓',
    '开关栓状态 0-关栓 1-开栓 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.parent_id',
    'COLUMN',
    'parent_id',
    '复供对应的停供主键',
    '复供对应的停供主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjtg_t.sh_id',
    'COLUMN',
    'sh_id',
    '审核材料主键',
    '审核材料主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjtg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户信息主键',
    '用户信息主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.ykrq',
    'COLUMN',
    'ykrq',
    '预开日期',
    '预开日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.wyje',
    'COLUMN',
    'wyje',
    '违约金额',
    '违约金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.zkje',
    'COLUMN',
    'zkje',
    '折扣金额',
    '折扣金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.ykzt',
    'COLUMN',
    'ykzt',
    '预开状态： 0-已回款 1-预开中',
    '预开状态： 0-已回款 1-预开中 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.fpqqlsh',
    'COLUMN',
    'fpqqlsh',
    '发票请求流水号',
    '发票请求流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_mjyk_t.bill_id',
    'COLUMN',
    'bill_id',
    '红冲确认申请编号',
    '红冲确认申请编号 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_mjyk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'timestamp(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'timestamp(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'bit(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.wx_count',
    'COLUMN',
    'wx_count',
    '微信总数',
    '微信总数 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.sms_count',
    'COLUMN',
    'sms_count',
    '短信总数',
    '短信总数 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.next_time',
    'COLUMN',
    'next_time',
    '下次发送时间',
    '下次发送时间 column',
    jsonb_build_object(
        'dataType', 'timestamp(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.state',
    'COLUMN',
    'state',
    '是否催费： 0-否 1-是',
    '是否催费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'bit(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.plan_sfl_id',
    'COLUMN',
    'plan_sfl_id',
    '催费计划主键',
    '催费计划主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.name',
    'COLUMN',
    'name',
    '用户姓名',
    '用户姓名 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.qfzt',
    'COLUMN',
    'qfzt',
    '欠费状态',
    '欠费状态 column',
    jsonb_build_object(
        'dataType', 'bit(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.dh_count',
    'COLUMN',
    'dh_count',
    '电话总数',
    '电话总数 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_msg_t.xq',
    'COLUMN',
    'xq',
    '用户所属小区',
    '用户所属小区 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_msg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.create_by',
    'COLUMN',
    'create_by',
    '创建人',
    '创建人 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.update_by',
    'COLUMN',
    'update_by',
    '更新人',
    '更新人 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.update_time',
    'COLUMN',
    'update_time',
    '更新日期',
    '更新日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.create_time',
    'COLUMN',
    'create_time',
    '创建日期',
    '创建日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.sjsfl',
    'COLUMN',
    'sjsfl',
    '实际收费率',
    '实际收费率 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.ssje',
    'COLUMN',
    'ssje',
    '实收金额',
    '实收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.hjje',
    'COLUMN',
    'hjje',
    '核减金额',
    '核减金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.jhsfl',
    'COLUMN',
    'jhsfl',
    '计划收费率',
    '计划收费率 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.ksrq',
    'COLUMN',
    'ksrq',
    '开始日期',
    '开始日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.jzrq',
    'COLUMN',
    'jzrq',
    '截止日期',
    '截止日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.fgs',
    'COLUMN',
    'fgs',
    '分公司',
    '分公司 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.rlz',
    'COLUMN',
    'rlz',
    '热力站',
    '热力站 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.xq',
    'COLUMN',
    'xq',
    '小区',
    '小区 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.status',
    'COLUMN',
    'status',
    '是否启用',
    '是否启用 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_plan_sfl_t.oldsfl',
    'COLUMN',
    'oldsfl',
    '上年收费率',
    '上年收费率 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_plan_sfl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.type',
    'COLUMN',
    'type',
    '业务类型：停供/复供',
    '业务类型：停供/复供 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.end_time',
    'COLUMN',
    'end_time',
    '业务受理截止日期',
    '业务受理截止日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.state',
    'COLUMN',
    'state',
    '状态： 0-禁用 1-启用',
    '状态： 0-禁用 1-启用 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzslsx_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzslsx_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.ksrq',
    'COLUMN',
    'ksrq',
    '开始日期',
    '开始日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.jsrq',
    'COLUMN',
    'jsrq',
    '结束日期',
    '结束日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.bl',
    'COLUMN',
    'bl',
    '比率',
    '比率 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzwyj_t.remark',
    'COLUMN',
    'remark',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_pzwyj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.ksrq',
    'COLUMN',
    'ksrq',
    '开始日期',
    '开始日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.jsrq',
    'COLUMN',
    'jsrq',
    '结束日期',
    '结束日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.bl',
    'COLUMN',
    'bl',
    '比率',
    '比率 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_pzzk_t.remark',
    'COLUMN',
    'remark',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_pzzk_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.rwht_id',
    'COLUMN',
    'rwht_id',
    '入网合同主键',
    '入网合同主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.rwjs_id',
    'COLUMN',
    'rwjs_id',
    '入网结算主键',
    '入网结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.hjje',
    'COLUMN',
    'hjje',
    '核减金额',
    '核减金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.hjrq',
    'COLUMN',
    'hjrq',
    '核减日期',
    '核减日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.hjlx',
    'COLUMN',
    'hjlx',
    '核减类型',
    '核减类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwhj_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwhj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.gcmc',
    'COLUMN',
    'gcmc',
    '工程名称',
    '工程名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.htbh',
    'COLUMN',
    'htbh',
    '合同编号',
    '合同编号 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.htmc',
    'COLUMN',
    'htmc',
    '合同名称',
    '合同名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.khmc',
    'COLUMN',
    'khmc',
    '客户名称',
    '客户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.qdrq',
    'COLUMN',
    'qdrq',
    '签订日期',
    '签订日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.qdfzr',
    'COLUMN',
    'qdfzr',
    '签订负责人',
    '签订负责人 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.lxrmc',
    'COLUMN',
    'lxrmc',
    '联系人名称',
    '联系人名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.lxdh',
    'COLUMN',
    'lxdh',
    '联系电话',
    '联系电话 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.gcdj',
    'COLUMN',
    'gcdj',
    '工程单价',
    '工程单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.gcmj',
    'COLUMN',
    'gcmj',
    '工程面积',
    '工程面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.rwdj',
    'COLUMN',
    'rwdj',
    '入网单价',
    '入网单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.rwmj',
    'COLUMN',
    'rwmj',
    '入网面积',
    '入网面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwht_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwht_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.rwht_id',
    'COLUMN',
    'rwht_id',
    '入网合同主键',
    '入网合同主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.ysje',
    'COLUMN',
    'ysje',
    '应收金额',
    '应收金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.qfje',
    'COLUMN',
    'qfje',
    '欠费金额',
    '欠费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.hjje',
    'COLUMN',
    'hjje',
    '核减金额',
    '核减金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwjs_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwjs_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.rwyh_id',
    'COLUMN',
    'rwyh_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.name',
    'COLUMN',
    'name',
    '面积名称',
    '面积名称 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.sfmj',
    'COLUMN',
    'sfmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.zdmj',
    'COLUMN',
    'zdmj',
    '建筑面积',
    '建筑面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.symj',
    'COLUMN',
    'symj',
    '使用面积',
    '使用面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.cgmj',
    'COLUMN',
    'cgmj',
    '超高面积',
    '超高面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.cg',
    'COLUMN',
    'cg',
    '层高',
    '层高 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.mjlb',
    'COLUMN',
    'mjlb',
    '面积类别',
    '面积类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.djlb',
    'COLUMN',
    'djlb',
    '单价类别',
    '单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.jsfs',
    'COLUMN',
    'jsfs',
    '结算方式',
    '结算方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.gnsc',
    'COLUMN',
    'gnsc',
    '供暖时长 (天，月，季）',
    '供暖时长 (天，月，季） column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.ybbm',
    'COLUMN',
    'ybbm',
    '仪表编码',
    '仪表编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.jldjlb',
    'COLUMN',
    'jldjlb',
    '计量单价类别',
    '计量单价类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwmj_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(125)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwmj_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.rwht_id',
    'COLUMN',
    'rwht_id',
    '入网合同主键',
    '入网合同主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.rwjs_id',
    'COLUMN',
    'rwjs_id',
    '入网结算主键',
    '入网结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.fylb',
    'COLUMN',
    'fylb',
    '费用类别',
    '费用类别 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.sl',
    'COLUMN',
    'sl',
    '数量',
    '数量 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.dj',
    'COLUMN',
    'dj',
    '单价',
    '单价 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.sfje',
    'COLUMN',
    'sfje',
    '收费金额',
    '收费金额 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.sffs',
    'COLUMN',
    'sffs',
    '收费方式',
    '收费方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.sfrq',
    'COLUMN',
    'sfrq',
    '收费日期',
    '收费日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.fplb',
    'COLUMN',
    'fplb',
    '发票类别',
    '发票类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.fpdm',
    'COLUMN',
    'fpdm',
    '发票代码',
    '发票代码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.fphm',
    'COLUMN',
    'fphm',
    '发票号码',
    '发票号码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.lsh',
    'COLUMN',
    'lsh',
    '第三方支付-流水号',
    '第三方支付-流水号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.zfqd',
    'COLUMN',
    'zfqd',
    '支付渠道：公司自收/银行代收',
    '支付渠道：公司自收/银行代收 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsf_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsf_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(55)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.address_prefix',
    'COLUMN',
    'address_prefix',
    '地址前缀',
    '地址前缀 column',
    jsonb_build_object(
        'dataType', 'varchar(35)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.unit',
    'COLUMN',
    'unit',
    '单元',
    '单元 column',
    jsonb_build_object(
        'dataType', 'varchar(15)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.floor',
    'COLUMN',
    'floor',
    '楼层',
    '楼层 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.room',
    'COLUMN',
    'room',
    '房间',
    '房间 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.jzmj',
    'COLUMN',
    'jzmj',
    '收费面积',
    '收费面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwsh_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwsh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.rwht_bh',
    'COLUMN',
    'rwht_bh',
    '入网合同编号',
    '入网合同编号 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.code',
    'COLUMN',
    'code',
    '用户编码',
    '用户编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.yhkh',
    'COLUMN',
    'yhkh',
    '用户卡号',
    '用户卡号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.name',
    'COLUMN',
    'name',
    '用户名称',
    '用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.id_number',
    'COLUMN',
    'id_number',
    '身份证号',
    '身份证号 column',
    jsonb_build_object(
        'dataType', 'varchar(80)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.tel_no',
    'COLUMN',
    'tel_no',
    '座机号',
    '座机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.mob_no',
    'COLUMN',
    'mob_no',
    '手机号',
    '手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.ry',
    'COLUMN',
    'ry',
    '热源',
    '热源 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.one',
    'COLUMN',
    'one',
    '一级-地区等级名称',
    '一级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.two',
    'COLUMN',
    'two',
    '二级-地区等级名称',
    '二级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.three',
    'COLUMN',
    'three',
    '三级-地区等级名称',
    '三级-地区等级名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.address_prefix',
    'COLUMN',
    'address_prefix',
    '地址前缀',
    '地址前缀 column',
    jsonb_build_object(
        'dataType', 'varchar(35)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.unit',
    'COLUMN',
    'unit',
    '单元',
    '单元 column',
    jsonb_build_object(
        'dataType', 'varchar(15)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.floor',
    'COLUMN',
    'floor',
    '楼层',
    '楼层 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.room',
    'COLUMN',
    'room',
    '房间',
    '房间 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.mp',
    'COLUMN',
    'mp',
    '门牌号',
    '门牌号 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.address',
    'COLUMN',
    'address',
    '地址',
    '地址 column',
    jsonb_build_object(
        'dataType', 'varchar(55)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.yhlx',
    'COLUMN',
    'yhlx',
    '用户类型：居民/单位',
    '用户类型：居民/单位 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.rwrq',
    'COLUMN',
    'rwrq',
    '入网日期',
    '入网日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.kzfs',
    'COLUMN',
    'kzfs',
    '控制方式： 分户 未分户',
    '控制方式： 分户 未分户 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(150)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.kz_hmd',
    'COLUMN',
    'kz_hmd',
    '用户控制-是否黑名单： 0-否 1-是',
    '用户控制-是否黑名单： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.kz_sf',
    'COLUMN',
    'kz_sf',
    '用户控制-是否允许收费： 0-否 1-是',
    '用户控制-是否允许收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.kz_sf_reason',
    'COLUMN',
    'kz_sf_reason',
    '用户控制-是否允许收费-原因',
    '用户控制-是否允许收费-原因 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.kz_yhsf',
    'COLUMN',
    'kz_yhsf',
    '用户控制-是否允许银行收费： 0-否 1-是',
    '用户控制-是否允许银行收费： 0-否 1-是 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_rwyh_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态：审核中/通过/未通过',
    '审核状态：审核中/通过/未通过 column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_rwyh_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.reason',
    'COLUMN',
    'reason',
    '诉讼原因',
    '诉讼原因 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.state',
    'COLUMN',
    'state',
    '诉讼状态',
    '诉讼状态 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.name',
    'COLUMN',
    'name',
    '案件名称',
    '案件名称 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.date',
    'COLUMN',
    'date',
    '立案日期',
    '立案日期 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.type',
    'COLUMN',
    'type',
    '立案类别',
    '立案类别 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.court',
    'COLUMN',
    'court',
    '立案法院',
    '立案法院 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.result',
    'COLUMN',
    'result',
    '案件结果',
    '案件结果 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ssgl_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ssgl_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.bgnr',
    'COLUMN',
    'bgnr',
    '变更内容',
    '变更内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.bgnrs',
    'COLUMN',
    'bgnrs',
    '详细变更内容',
    '详细变更内容 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.lrsj',
    'COLUMN',
    'lrsj',
    '录入时间',
    '录入时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_yhbg_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_yhbg_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.mjjs_id',
    'COLUMN',
    'mjjs_id',
    '面积结算主键',
    '面积结算主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.ysje_old',
    'COLUMN',
    'ysje_old',
    '应收金额-调整前',
    '应收金额-调整前 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.ysje_new',
    'COLUMN',
    'ysje_new',
    '应收金额-调整后',
    '应收金额-调整后 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.czbh',
    'COLUMN',
    'czbh',
    '操作编号',
    '操作编号 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sf_ystz_t.shzt',
    'COLUMN',
    'shzt',
    '审核状态',
    '审核状态 column',
    jsonb_build_object(
        'dataType', 'char(5)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sf_ystz_t',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sjcs_address.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sjcs_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sjcs_address.one',
    'COLUMN',
    'one',
    '分公司名称',
    '分公司名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sjcs_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sjcs_address.two',
    'COLUMN',
    'two',
    '热力站',
    '热力站 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sjcs_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sjcs_address.three',
    'COLUMN',
    'three',
    '小区',
    '小区 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sjcs_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sjcs_address.address_prefix',
    'COLUMN',
    'address_prefix',
    '楼栋',
    '楼栋 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sjcs_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sjcs_address.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'date',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sjcs_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.parent_id',
    'COLUMN',
    'parent_id',
    '上级id',
    '上级id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.third_id',
    'COLUMN',
    'third_id',
    '生产的id',
    '生产的id column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.name',
    'COLUMN',
    'name',
    '热力站名称或者站点分区名称',
    '热力站名称或者站点分区名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.state',
    'COLUMN',
    'state',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.third_parent_id',
    'COLUMN',
    'third_parent_id',
    '上级的第三方id',
    '上级的第三方id column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.path',
    'COLUMN',
    'path',
    '站点路径',
    '站点路径 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.id_path',
    'COLUMN',
    'id_path',
    '父子级别id的path',
    '父子级别id的path column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.sort',
    'COLUMN',
    'sort',
    '排序',
    '排序 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.type',
    'COLUMN',
    'type',
    '站点类型，1：热力站 2：分区站点',
    '站点类型，1：热力站 2：分区站点 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.code',
    'COLUMN',
    'code',
    'code',
    'code column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq.data_from',
    'COLUMN',
    'data_from',
    '数据来源方，1：生产同步 2：收费系统自己生产',
    '数据来源方，1：生产同步 2：收费系统自己生产 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.parent_id',
    'COLUMN',
    'parent_id',
    '上级id',
    '上级id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.third_id',
    'COLUMN',
    'third_id',
    '生产的id',
    '生产的id column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.name',
    'COLUMN',
    'name',
    '热力站名称或者站点分区名称',
    '热力站名称或者站点分区名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.state',
    'COLUMN',
    'state',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.third_parent_id',
    'COLUMN',
    'third_parent_id',
    '上级的第三方id',
    '上级的第三方id column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.path',
    'COLUMN',
    'path',
    '站点路径',
    '站点路径 column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.id_path',
    'COLUMN',
    'id_path',
    '父子级别id的path',
    '父子级别id的path column',
    jsonb_build_object(
        'dataType', 'varchar(60)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.sort',
    'COLUMN',
    'sort',
    '排序',
    '排序 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.type',
    'COLUMN',
    'type',
    '站点类型，1：热力站 2：分区站点',
    '站点类型，1：热力站 2：分区站点 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.code',
    'COLUMN',
    'code',
    'code',
    'code column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sync_rlz_zdfq_2026_01_26_bak.data_from',
    'COLUMN',
    'data_from',
    '数据来源方，1：生产同步 2：收费系统自己生产',
    '数据来源方，1：生产同步 2：收费系统自己生产 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sync_rlz_zdfq_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.parent_id',
    'COLUMN',
    'parent_id',
    '父级主键',
    '父级主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.name',
    'COLUMN',
    'name',
    '地址名称',
    '地址名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.type',
    'COLUMN',
    'type',
    '菜单类型:0-公司名称，1-热力站，2-小区',
    '菜单类型:0-公司名称，1-热力站，2-小区 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.grade',
    'COLUMN',
    'grade',
    '性质',
    '性质 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.jzmj',
    'COLUMN',
    'jzmj',
    '建筑面积',
    '建筑面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.code',
    'COLUMN',
    'code',
    '地址编码',
    '地址编码 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address.state',
    'COLUMN',
    'state',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.parent_id',
    'COLUMN',
    'parent_id',
    '父级主键',
    '父级主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.name',
    'COLUMN',
    'name',
    '地址名称',
    '地址名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.type',
    'COLUMN',
    'type',
    '菜单类型:0-公司名称，1-热力站，2-小区',
    '菜单类型:0-公司名称，1-热力站，2-小区 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.grade',
    'COLUMN',
    'grade',
    '性质',
    '性质 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.jzmj',
    'COLUMN',
    'jzmj',
    '建筑面积',
    '建筑面积 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.code',
    'COLUMN',
    'code',
    '地址编码',
    '地址编码 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_2026_01_26_bak.state',
    'COLUMN',
    'state',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁',
    '站点分区状态 0:待投运 1：已投运 2：停运 3：销毁 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_2026_01_26_bak',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.sys_address_id',
    'COLUMN',
    'sys_address_id',
    '地址id',
    '地址id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.old_name',
    'COLUMN',
    'old_name',
    '之前的名称',
    '之前的名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.name',
    'COLUMN',
    'name',
    '现在的名称',
    '现在的名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_address_change_record.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_address_change_record',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_department.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_department.parent_id',
    'COLUMN',
    'parent_id',
    '父级主键',
    '父级主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_department.name',
    'COLUMN',
    'name',
    '部门名称',
    '部门名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_department.remark',
    'COLUMN',
    'remark',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_department.sort',
    'COLUMN',
    'sort',
    '排序，支持小数',
    '排序，支持小数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_department.zf',
    'COLUMN',
    'zf',
    '是否作废： 0-正常 1-作废',
    '是否作废： 0-正常 1-作废 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log.operation',
    'COLUMN',
    'operation',
    '操作类型',
    '操作类型 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log.params',
    'COLUMN',
    'params',
    '请求参数',
    '请求参数 column',
    jsonb_build_object(
        'dataType', 'varchar(5000)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log.time',
    'COLUMN',
    'time',
    '耗时',
    '耗时 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log.created_time',
    'COLUMN',
    'created_time',
    '操作时间',
    '操作时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.created_by',
    'COLUMN',
    'created_by',
    '创建人',
    '创建人 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.business_type',
    'COLUMN',
    'business_type',
    '业务类型',
    '业务类型 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.request_url',
    'COLUMN',
    'request_url',
    '请求路径',
    '请求路径 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.request_method',
    'COLUMN',
    'request_method',
    '请求方式',
    '请求方式 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.request_param',
    'COLUMN',
    'request_param',
    '请求参数',
    '请求参数 column',
    jsonb_build_object(
        'dataType', 'varchar(5000)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.method',
    'COLUMN',
    'method',
    '方法名称',
    '方法名称 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_log_error.exception_detail',
    'COLUMN',
    'exception_detail',
    '异常详细',
    '异常详细 column',
    jsonb_build_object(
        'dataType', 'mediumtext',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_log_error',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.parent_id',
    'COLUMN',
    'parent_id',
    '父级主键',
    '父级主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.name',
    'COLUMN',
    'name',
    '菜单名称',
    '菜单名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.icon',
    'COLUMN',
    'icon',
    '菜单图标',
    '菜单图标 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.url',
    'COLUMN',
    'url',
    '菜单访问路径',
    '菜单访问路径 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.component',
    'COLUMN',
    'component',
    '菜单组件名称',
    '菜单组件名称 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.remark',
    'COLUMN',
    'remark',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.type',
    'COLUMN',
    'type',
    '菜单类型:0-分类菜单，1-导航菜单，2-按钮',
    '菜单类型:0-分类菜单，1-导航菜单，2-按钮 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_menu.sort',
    'COLUMN',
    'sort',
    '排序，支持小数',
    '排序，支持小数 column',
    jsonb_build_object(
        'dataType', 'decimal(10,',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.parent_id',
    'COLUMN',
    'parent_id',
    '父级主键',
    '父级主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.year',
    'COLUMN',
    'year',
    '年度',
    '年度 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.name',
    'COLUMN',
    'name',
    '参数名称',
    '参数名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.value',
    'COLUMN',
    'value',
    '参数值',
    '参数值 column',
    jsonb_build_object(
        'dataType', 'varchar(1000)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.remark',
    'COLUMN',
    'remark',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_param.level',
    'COLUMN',
    'level',
    '参数优先级别',
    '参数优先级别 column',
    jsonb_build_object(
        'dataType', 'int(3)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_param',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_role.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_role',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_role.name',
    'COLUMN',
    'name',
    '角色名称',
    '角色名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_role',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_role_menu.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_role_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_role_menu.menu_id',
    'COLUMN',
    'menu_id',
    '菜单主键',
    '菜单主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_role_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_role_menu.role_id',
    'COLUMN',
    'role_id',
    '角色主键',
    '角色主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_role_menu',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.name',
    'COLUMN',
    'name',
    '任务名称',
    '任务名称 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.cron',
    'COLUMN',
    'cron',
    '时间表达式',
    '时间表达式 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.class_name',
    'COLUMN',
    'class_name',
    '调度任务类名',
    '调度任务类名 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.is_open',
    'COLUMN',
    'is_open',
    '是否启动：0-关闭 1-启动',
    '是否启动：0-关闭 1-启动 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_schedule.is_lock',
    'COLUMN',
    'is_lock',
    '状态锁：0-空闲 1-执行中',
    '状态锁：0-空闲 1-执行中 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_schedule',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.file_name',
    'COLUMN',
    'file_name',
    '文件名称（含扩展名）',
    '文件名称（含扩展名） column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.temp_name',
    'COLUMN',
    'temp_name',
    '文件别名（防止存放磁盘时重名）',
    '文件别名（防止存放磁盘时重名） column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.url',
    'COLUMN',
    'url',
    '文件路径',
    '文件路径 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.czy',
    'COLUMN',
    'czy',
    '操作员',
    '操作员 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.created_time',
    'COLUMN',
    'created_time',
    '上传日期',
    '上传日期 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.business_id',
    'COLUMN',
    'business_id',
    '业务主键',
    '业务主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.business_type',
    'COLUMN',
    'business_type',
    '业务类别',
    '业务类别 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_upload.cnq',
    'COLUMN',
    'cnq',
    '采暖期',
    '采暖期 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_upload',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.username',
    'COLUMN',
    'username',
    '登录名称',
    '登录名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.password',
    'COLUMN',
    'password',
    '登录密码',
    '登录密码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.empno',
    'COLUMN',
    'empno',
    '用户工号',
    '用户工号 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.real_name',
    'COLUMN',
    'real_name',
    '真实姓名',
    '真实姓名 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.locked',
    'COLUMN',
    'locked',
    '是否锁户： 0-正常 1-锁户',
    '是否锁户： 0-正常 1-锁户 column',
    jsonb_build_object(
        'dataType', 'tinyint(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.department_id',
    'COLUMN',
    'department_id',
    '部门主键',
    '部门主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.reamrk',
    'COLUMN',
    'reamrk',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user.mob_no',
    'COLUMN',
    'mob_no',
    '用户手机号',
    '用户手机号 column',
    jsonb_build_object(
        'dataType', 'varchar(11)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user_department.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user_department.user_id',
    'COLUMN',
    'user_id',
    '系统用户主键',
    '系统用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user_department.department_id',
    'COLUMN',
    'department_id',
    '系统部门主键',
    '系统部门主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user_department',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user_role.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:sys_user_role',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user_role.user_id',
    'COLUMN',
    'user_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_user_role',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:sys_user_role.role_id',
    'COLUMN',
    'role_id',
    '角色主键',
    '角色主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:sys_user_role',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.id',
    'COLUMN',
    'id',
    '主键ID',
    '主键ID column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.key_id',
    'COLUMN',
    'key_id',
    '标识key',
    '标识key column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.user_id',
    'COLUMN',
    'user_id',
    '用户ID',
    '用户ID column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.table_id',
    'COLUMN',
    'table_id',
    '表ID',
    '表ID column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.sort',
    'COLUMN',
    'sort',
    '排序',
    '排序 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.title',
    'COLUMN',
    'title',
    '标题',
    '标题 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.icon',
    'COLUMN',
    'icon',
    '图标',
    '图标 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.col_width',
    'COLUMN',
    'col_width',
    '列宽',
    '列宽 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.state',
    'COLUMN',
    'state',
    '0停用/1启用',
    '0停用/1启用 column',
    jsonb_build_object(
        'dataType', 'tinyint(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:table_config.bz',
    'COLUMN',
    'bz',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:table_config',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.customer_id',
    'COLUMN',
    'customer_id',
    '用户主键',
    '用户主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.pwd',
    'COLUMN',
    'pwd',
    '微信预留密码',
    '微信预留密码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.phone',
    'COLUMN',
    'phone',
    '微信预留手机',
    '微信预留手机 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.email',
    'COLUMN',
    'email',
    '微信预留邮箱',
    '微信预留邮箱 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.created_time',
    'COLUMN',
    'created_time',
    '创建时间',
    '创建时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:wechat_bind.updated_time',
    'COLUMN',
    'updated_time',
    '更新时间',
    '更新时间 column',
    jsonb_build_object(
        'dataType', 'datetime(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:wechat_bind',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.projid',
    'COLUMN',
    'projid',
    '申报号',
    '申报号 column',
    jsonb_build_object(
        'dataType', 'varchar(25)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.accept_man',
    'COLUMN',
    'accept_man',
    '受理人员名称',
    '受理人员名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.hander_deptname',
    'COLUMN',
    'hander_deptname',
    '受理部门名称',
    '受理部门名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.hander_deptid',
    'COLUMN',
    'hander_deptid',
    '受理人员所属部门编码',
    '受理人员所属部门编码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.areacode',
    'COLUMN',
    'areacode',
    '受理人员所属部门的所在行政区划编码',
    '受理人员所属部门的所在行政区划编码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.accept_time',
    'COLUMN',
    'accept_time',
    '受理时间',
    '受理时间 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.promisevalue',
    'COLUMN',
    'promisevalue',
    '承诺期限',
    '承诺期限 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.promisetype',
    'COLUMN',
    'promisetype',
    '承诺期限单位',
    '承诺期限单位 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.promise_etime',
    'COLUMN',
    'promise_etime',
    '承诺办结时间',
    '承诺办结时间 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.belongsystem',
    'COLUMN',
    'belongsystem',
    '所属系统',
    '所属系统 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.create_time',
    'COLUMN',
    'create_time',
    '数据产生时间',
    '数据产生时间 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.sync_status',
    'COLUMN',
    'sync_status',
    '同步状态',
    '同步状态 column',
    jsonb_build_object(
        'dataType', 'varchar(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.dataversion',
    'COLUMN',
    'dataversion',
    '版本号',
    '版本号 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_accept.accept_user_id',
    'COLUMN',
    'accept_user_id',
    '受理人Id',
    '受理人Id column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_accept',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.unid',
    'COLUMN',
    'unid',
    'UNID',
    'UNID column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.projid',
    'COLUMN',
    'projid',
    'PROJID',
    'PROJID column',
    jsonb_build_object(
        'dataType', 'varchar(22)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.taketype',
    'COLUMN',
    'taketype',
    'TAKETYPE',
    'TAKETYPE column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.istake',
    'COLUMN',
    'istake',
    'ISTAKE',
    'ISTAKE column',
    jsonb_build_object(
        'dataType', 'varchar(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.amount',
    'COLUMN',
    'amount',
    'AMOUNT',
    'AMOUNT column',
    jsonb_build_object(
        'dataType', 'varchar(5)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.attrname',
    'COLUMN',
    'attrname',
    'ATTRNAME',
    'ATTRNAME column',
    jsonb_build_object(
        'dataType', 'varchar(500)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.attrid',
    'COLUMN',
    'attrid',
    'ATTRID',
    'ATTRID column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.is_need',
    'COLUMN',
    'is_need',
    'IS_NEED',
    'IS_NEED column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.create_time',
    'COLUMN',
    'create_time',
    '数据产生时间',
    '数据产生时间 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.dataversion',
    'COLUMN',
    'dataversion',
    '版本号 默认值=1，如果有信息变更，则版本号递增。',
    '版本号 默认值=1，如果有信息变更，则版本号递增。 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.source',
    'COLUMN',
    'source',
    '来源',
    '来源 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_attr.file_path',
    'COLUMN',
    'file_path',
    '下载路径',
    '下载路径 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_attr',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.id',
    'COLUMN',
    'id',
    '主键',
    '主键 column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.projid',
    'COLUMN',
    'projid',
    '申报号',
    '申报号 column',
    jsonb_build_object(
        'dataType', 'varchar(22)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.projpwd',
    'COLUMN',
    'projpwd',
    '查询密码',
    '查询密码 column',
    jsonb_build_object(
        'dataType', 'varchar(6)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.servicecode',
    'COLUMN',
    'servicecode',
    '权力事项编码',
    '权力事项编码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.service_deptid',
    'COLUMN',
    'service_deptid',
    '事项终审部门编码',
    '事项终审部门编码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.deptid',
    'COLUMN',
    'deptid',
    '收件部门编码',
    '收件部门编码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.deptname',
    'COLUMN',
    'deptname',
    '收件部门名称',
    '收件部门名称 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.ss_orgcode',
    'COLUMN',
    'ss_orgcode',
    '实施机构组织机构代码',
    '实施机构组织机构代码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.serviceversion',
    'COLUMN',
    'serviceversion',
    '权力事项版本号',
    '权力事项版本号 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.servicename',
    'COLUMN',
    'servicename',
    '权力事项名称',
    '权力事项名称 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.projectname',
    'COLUMN',
    'projectname',
    '申报名称',
    '申报名称 column',
    jsonb_build_object(
        'dataType', 'varchar(200)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.infotype',
    'COLUMN',
    'infotype',
    '办件类型',
    '办件类型 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.bus_type',
    'COLUMN',
    'bus_type',
    '业务类型',
    '业务类型 column',
    jsonb_build_object(
        'dataType', 'varchar(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.rel_bus_id',
    'COLUMN',
    'rel_bus_id',
    '关联业务标识',
    '关联业务标识 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.apply_type',
    'COLUMN',
    'apply_type',
    '申请人类型',
    '申请人类型 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.applyname',
    'COLUMN',
    'applyname',
    '申报者名称',
    '申报者名称 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.apply_cardtype',
    'COLUMN',
    'apply_cardtype',
    '申报者证件类型',
    '申报者证件类型 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.apply_cardnumber',
    'COLUMN',
    'apply_cardnumber',
    '申报者证件号码',
    '申报者证件号码 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.contactman',
    'COLUMN',
    'contactman',
    '联系人/代理人姓名',
    '联系人/代理人姓名 column',
    jsonb_build_object(
        'dataType', 'varchar(100)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.telphone',
    'COLUMN',
    'telphone',
    '联系人手机号码',
    '联系人手机号码 column',
    jsonb_build_object(
        'dataType', 'varchar(13)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.receive_useid',
    'COLUMN',
    'receive_useid',
    '创建用户标识',
    '创建用户标识 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.receive_name',
    'COLUMN',
    'receive_name',
    '创建用户名称',
    '创建用户名称 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.applyfrom',
    'COLUMN',
    'applyfrom',
    '申报来源',
    '申报来源 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.approve_type',
    'COLUMN',
    'approve_type',
    '审批类型',
    '审批类型 column',
    jsonb_build_object(
        'dataType', 'varchar(2)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.apply_propertiy',
    'COLUMN',
    'apply_propertiy',
    '项目性质',
    '项目性质 column',
    jsonb_build_object(
        'dataType', 'varchar(2)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.receivetime',
    'COLUMN',
    'receivetime',
    '申报时间',
    '申报时间 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.areacode',
    'COLUMN',
    'areacode',
    '收件部门所属行政区划编码',
    '收件部门所属行政区划编码 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.datastate',
    'COLUMN',
    'datastate',
    '数据状态',
    '数据状态 column',
    jsonb_build_object(
        'dataType', 'varchar(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.belongsystem',
    'COLUMN',
    'belongsystem',
    '所属系统',
    '所属系统 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.create_time',
    'COLUMN',
    'create_time',
    '数据产生时间',
    '数据产生时间 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.sync_status',
    'COLUMN',
    'sync_status',
    '同步状态 插入：I，更新：U，删除：D，已同步：S。',
    '同步状态 插入：I，更新：U，删除：D，已同步：S。 column',
    jsonb_build_object(
        'dataType', 'varchar(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.blzt',
    'COLUMN',
    'blzt',
    '办理状态',
    '办理状态 column',
    jsonb_build_object(
        'dataType', 'varchar(10)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.dataversion',
    'COLUMN',
    'dataversion',
    '版本号 默认值=1，如果有信息变更，则版本号递增。',
    '版本号 默认值=1，如果有信息变更，则版本号递增。 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.memo',
    'COLUMN',
    'memo',
    '备注',
    '备注 column',
    jsonb_build_object(
        'dataType', 'varchar(500)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.blms',
    'COLUMN',
    'blms',
    '办理描述',
    '办理描述 column',
    jsonb_build_object(
        'dataType', 'varchar(255)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.bjrq',
    'COLUMN',
    'bjrq',
    '办结日期',
    '办结日期 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.cjrq',
    'COLUMN',
    'cjrq',
    '创建日期',
    '创建日期 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.fsrq',
    'COLUMN',
    'fsrq',
    '发送日期',
    '发送日期 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_baseinfo.source',
    'COLUMN',
    'source',
    '分发来源',
    '分发来源 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_baseinfo',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.id',
    'COLUMN',
    'id',
    'id',
    'id column',
    jsonb_build_object(
        'dataType', 'bigint(0)',
        'nullable', false,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.projid',
    'COLUMN',
    'projid',
    '申报号',
    '申报号 column',
    jsonb_build_object(
        'dataType', 'varchar(25)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.transact_user',
    'COLUMN',
    'transact_user',
    '办结人员名称',
    '办结人员名称 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.hander_deptname',
    'COLUMN',
    'hander_deptname',
    '办结部门名称',
    '办结部门名称 column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.hander_deptid',
    'COLUMN',
    'hander_deptid',
    '办结人员所属部门编码',
    '办结人员所属部门编码 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.areacode',
    'COLUMN',
    'areacode',
    '办结人员所属部门的所在行政区划编码',
    '办结人员所属部门的所在行政区划编码 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.transact_time',
    'COLUMN',
    'transact_time',
    '办结时间',
    '办结时间 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.transact_result',
    'COLUMN',
    'transact_result',
    '办结结果',
    '办结结果 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.transact_describe',
    'COLUMN',
    'transact_describe',
    '办结结果描述',
    '办结结果描述 column',
    jsonb_build_object(
        'dataType', 'varchar(30)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.result',
    'COLUMN',
    'result',
    '办理结果是否通过',
    '办理结果是否通过 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.result_code',
    'COLUMN',
    'result_code',
    '结果编号',
    '结果编号 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.belongsystem',
    'COLUMN',
    'belongsystem',
    '所属系统',
    '所属系统 column',
    jsonb_build_object(
        'dataType', 'varchar(50)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.create_time',
    'COLUMN',
    'create_time',
    '数据产生时间',
    '数据产生时间 column',
    jsonb_build_object(
        'dataType', 'varchar(20)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.sync_status',
    'COLUMN',
    'sync_status',
    '同步状态',
    '同步状态 column',
    jsonb_build_object(
        'dataType', 'varchar(1)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.dataversion',
    'COLUMN',
    'dataversion',
    '版本号',
    '版本号 column',
    jsonb_build_object(
        'dataType', 'int(0)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);

INSERT INTO s2_wiki_entity (entity_id, entity_type, name, display_name, description, properties, parent_entity_id, status)
VALUES (
    'column:zfpt_transact.transact_user_id',
    'COLUMN',
    'transact_user_id',
    '办结人Id',
    '办结人Id column',
    jsonb_build_object(
        'dataType', 'varchar(40)',
        'nullable', true,
        'isPrimaryKey', false
    ),
    'table:zfpt_transact',
    'ACTIVE'
);