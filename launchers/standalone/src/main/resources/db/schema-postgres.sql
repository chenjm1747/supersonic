CREATE TABLE IF NOT EXISTS s2_agent (
    id SERIAL PRIMARY KEY,
    name varchar(100) DEFAULT NULL,
    description TEXT DEFAULT NULL,
    examples TEXT DEFAULT NULL,
    status smallint DEFAULT NULL,
    model varchar(100) DEFAULT NULL,
    tool_config varchar(6000) DEFAULT NULL,
    llm_config varchar(2000) DEFAULT NULL,
    chat_model_config text DEFAULT NULL,
    visual_config varchar(2000) DEFAULT NULL,
    enable_search smallint DEFAULT 1,
    enable_feedback smallint DEFAULT 1,
    created_by varchar(100) DEFAULT NULL,
    created_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL,
    updated_at timestamp DEFAULT NULL,
    admin varchar(3000) DEFAULT NULL,
    admin_org varchar(3000) DEFAULT NULL,
    is_open smallint DEFAULT NULL,
    viewer varchar(3000) DEFAULT NULL,
    view_org varchar(3000) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_auth_groups (
    group_id integer NOT NULL PRIMARY KEY,
    config varchar(2048) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_available_date_info (
    id SERIAL PRIMARY KEY,
    item_id integer NOT NULL,
    type varchar(255) NOT NULL,
    date_format varchar(64) NOT NULL,
    date_period varchar(64) DEFAULT NULL,
    start_date varchar(64) DEFAULT NULL,
    end_date varchar(64) DEFAULT NULL,
    unavailable_date text,
    created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by varchar(100) NOT NULL,
    updated_at timestamp NULL,
    updated_by varchar(100) NOT NULL,
    status smallint DEFAULT 0,
    UNIQUE(item_id, type)
);

CREATE TABLE IF NOT EXISTS s2_chat (
    chat_id SERIAL PRIMARY KEY,
    agent_id integer DEFAULT NULL,
    chat_name varchar(300) DEFAULT NULL,
    create_time timestamp DEFAULT NULL,
    last_time timestamp DEFAULT NULL,
    creator varchar(30) DEFAULT NULL,
    last_question varchar(200) DEFAULT NULL,
    is_delete smallint DEFAULT 0,
    is_top smallint DEFAULT 0
);

CREATE TABLE IF NOT EXISTS s2_chat_config (
    id SERIAL PRIMARY KEY,
    model_id bigint DEFAULT NULL,
    chat_detail_config text,
    chat_agg_config text,
    recommended_questions text,
    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_by varchar(100) NOT NULL,
    status smallint NOT NULL,
    llm_examples text
);

CREATE TABLE IF NOT EXISTS s2_chat_memory (
    id SERIAL PRIMARY KEY,
    question varchar(655),
    side_info TEXT,
    query_id bigint,
    agent_id INTEGER,
    db_schema TEXT,
    s2_sql TEXT,
    status varchar(20),
    llm_review varchar(20),
    llm_comment TEXT,
    human_review varchar(20),
    human_comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by varchar(100) DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_chat_context (
    chat_id bigint NOT NULL PRIMARY KEY,
    modified_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    query_user varchar(64) DEFAULT NULL,
    query_text text,
    semantic_parse text,
    ext_data text
);


CREATE TABLE IF NOT EXISTS s2_chat_parse (
    question_id bigint NOT NULL,
    chat_id integer NOT NULL,
    parse_id integer NOT NULL,
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    query_text varchar(500) DEFAULT NULL,
    user_name varchar(150) DEFAULT NULL,
    parse_info text NOT NULL,
    is_candidate integer DEFAULT 1,
    CONSTRAINT commonIndex UNIQUE (question_id)
);

CREATE TABLE IF NOT EXISTS s2_chat_query (
    question_id SERIAL PRIMARY KEY,
    agent_id integer DEFAULT NULL,
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    query_text text,
    user_name varchar(150) DEFAULT NULL,
    query_state smallint DEFAULT NULL,
    chat_id bigint NOT NULL,
    query_result text,
    score integer DEFAULT 0,
    feedback varchar(1024) DEFAULT '',
    similar_queries varchar(1024) DEFAULT '',
    parse_time_cost varchar(1024) DEFAULT ''
);

CREATE TABLE IF NOT EXISTS s2_chat_statistics (
    question_id bigint NOT NULL,
    chat_id bigint NOT NULL,
    user_name varchar(150) DEFAULT NULL,
    query_text varchar(200) DEFAULT NULL,
    interface_name varchar(100) DEFAULT NULL,
    cost integer DEFAULT 0,
    type integer DEFAULT NULL,
    create_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS s2_chat_model (
    id SERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    description varchar(500) DEFAULT NULL,
    config text NOT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp NOT NULL,
    updated_by varchar(100) NOT NULL,
    admin varchar(500) DEFAULT NULL,
    viewer varchar(500) DEFAULT NULL,
    is_open smallint DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_database (
    id SERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    description varchar(500) DEFAULT NULL,
    version varchar(64) DEFAULT NULL,
    type varchar(20) NOT NULL,
    config text NOT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp NOT NULL,
    updated_by varchar(100) NOT NULL,
    admin varchar(500) DEFAULT NULL,
    viewer varchar(500) DEFAULT NULL,
    is_open smallint DEFAULT NULL
);


CREATE TABLE IF NOT EXISTS s2_dictionary_conf (
    id SERIAL PRIMARY KEY,
    description varchar(255),
    type varchar(255) NOT NULL,
    item_id INTEGER NOT NULL,
    config text,
    status varchar(255) NOT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS s2_dictionary_task (
    id SERIAL PRIMARY KEY,
    name varchar(255) NOT NULL,
    description varchar(255),
    type varchar(255) NOT NULL,
    item_id INTEGER NOT NULL,
    config text,
    status varchar(255) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    created_by varchar(100) NOT NULL,
    elapsed_ms integer DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_dimension (
    id SERIAL PRIMARY KEY,
    model_id bigint DEFAULT NULL,
    name varchar(255) NOT NULL,
    biz_name varchar(255) NOT NULL,
    description varchar(500) NOT NULL,
    status smallint NOT NULL,
    sensitive_level integer DEFAULT NULL,
    type varchar(50) NOT NULL,
    type_params text,
    data_type varchar(50) DEFAULT NULL,
    expr text NOT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp NOT NULL,
    updated_by varchar(100) NOT NULL,
    semantic_type varchar(20) NOT NULL,
    alias varchar(500) DEFAULT NULL,
    default_values varchar(500) DEFAULT NULL,
    dim_value_maps varchar(5000) DEFAULT NULL,
    is_tag smallint DEFAULT NULL,
    ext varchar(1000) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_domain (
    id SERIAL PRIMARY KEY,
    name varchar(255) DEFAULT NULL,
    biz_name varchar(255) DEFAULT NULL,
    parent_id bigint DEFAULT 0,
    status smallint NOT NULL,
    created_at timestamp DEFAULT NULL,
    created_by varchar(100) DEFAULT NULL,
    updated_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL,
    admin varchar(3000) DEFAULT NULL,
    admin_org varchar(3000) DEFAULT NULL,
    is_open smallint DEFAULT NULL,
    viewer varchar(3000) DEFAULT NULL,
    view_org varchar(3000) DEFAULT NULL,
    entity varchar(500) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_metric (
    id SERIAL PRIMARY KEY,
    model_id bigint DEFAULT NULL,
    name varchar(255) NOT NULL,
    biz_name varchar(255) NOT NULL,
    description varchar(500) DEFAULT NULL,
    status smallint NOT NULL,
    sensitive_level smallint NOT NULL,
    type varchar(50) NOT NULL,
    type_params text NOT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp NOT NULL,
    updated_by varchar(100) NOT NULL,
    data_format_type varchar(50) DEFAULT NULL,
    data_format varchar(500) DEFAULT NULL,
    alias varchar(500) DEFAULT NULL,
    classifications varchar(500) DEFAULT NULL,
    relate_dimensions varchar(500) DEFAULT NULL,
    ext text DEFAULT NULL,
    define_type varchar(50) DEFAULT NULL,
    is_publish smallint DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_model (
    id SERIAL PRIMARY KEY,
    name varchar(100) DEFAULT NULL,
    biz_name varchar(100) DEFAULT NULL,
    domain_id bigint DEFAULT NULL,
    alias varchar(200) DEFAULT NULL,
    status smallint DEFAULT NULL,
    description varchar(500) DEFAULT NULL,
    viewer varchar(500) DEFAULT NULL,
    view_org varchar(500) DEFAULT NULL,
    admin varchar(500) DEFAULT NULL,
    admin_org varchar(500) DEFAULT NULL,
    is_open smallint DEFAULT NULL,
    created_by varchar(100) DEFAULT NULL,
    created_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL,
    updated_at timestamp DEFAULT NULL,
    entity text,
    drill_down_dimensions TEXT DEFAULT NULL,
    database_id INTEGER NOT NULL,
    model_detail text NOT NULL,
    source_type varchar(128) DEFAULT NULL,
    depends varchar(500) DEFAULT NULL,
    filter_sql varchar(1000) DEFAULT NULL,
    tag_object_id integer DEFAULT 0,
    ext varchar(1000) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_data_set (
    id SERIAL PRIMARY KEY,
    domain_id bigint,
    name varchar(255),
    biz_name varchar(255),
    description varchar(255),
    status integer,
    alias varchar(255),
    data_set_detail text,
    created_at timestamp,
    created_by varchar(255),
    updated_at timestamp,
    updated_by varchar(255),
    query_config varchar(3000),
    admin varchar(3000) DEFAULT NULL,
    admin_org varchar(3000) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_tag (
    id SERIAL PRIMARY KEY,
    item_id INTEGER NOT NULL,
    type varchar(255) NOT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL,
    ext text DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_tag_object (
    id SERIAL PRIMARY KEY,
    domain_id bigint DEFAULT NULL,
    name varchar(255) NOT NULL,
    biz_name varchar(255) NOT NULL,
    description varchar(500) DEFAULT NULL,
    status smallint NOT NULL DEFAULT 1,
    sensitive_level smallint NOT NULL DEFAULT 0,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp NULL,
    updated_by varchar(100) NULL,
    ext text DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_query_rule (
    id SERIAL PRIMARY KEY,
    data_set_id bigint,
    priority integer NOT NULL DEFAULT 1,
    rule_type varchar(255) NOT NULL,
    name varchar(255) NOT NULL,
    biz_name varchar(255) NOT NULL,
    description varchar(500) DEFAULT NULL,
    rule text DEFAULT NULL,
    action text DEFAULT NULL,
    status INTEGER NOT NULL DEFAULT 1,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL,
    ext text DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_term (
    id SERIAL PRIMARY KEY,
    domain_id bigint,
    name varchar(255) NOT NULL,
    description varchar(500) DEFAULT NULL,
    alias varchar(1000) NOT NULL,
    related_metrics varchar(1000) DEFAULT NULL,
    related_dimensions varchar(1000) DEFAULT NULL,
    created_at timestamp NOT NULL,
    created_by varchar(100) NOT NULL,
    updated_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_user_token (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    expire_time bigint NOT NULL,
    token text NOT NULL,
    salt VARCHAR(255) default NULL,
    create_time TIMESTAMP NOT NULL,
    create_by VARCHAR(255) NOT NULL,
    update_time TIMESTAMP default NULL,
    update_by VARCHAR(255) NOT NULL,
    expire_date_time TIMESTAMP NOT NULL,
    UNIQUE (name, user_name)
);

CREATE TABLE IF NOT EXISTS s2_app (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    status INTEGER,
    config TEXT,
    end_date timestamp,
    qps INTEGER,
    app_secret VARCHAR(255),
    owner VARCHAR(255),
    created_at timestamp NULL,
    updated_at timestamp NULL,
    created_by varchar(255) NULL,
    updated_by varchar(255) NULL
);

CREATE TABLE IF NOT EXISTS s2_plugin (
    id SERIAL PRIMARY KEY,
    type varchar(50) DEFAULT NULL,
    data_set varchar(100) DEFAULT NULL,
    pattern varchar(500) DEFAULT NULL,
    parse_mode varchar(100) DEFAULT NULL,
    parse_mode_config text,
    name varchar(100) DEFAULT NULL,
    created_at timestamp DEFAULT NULL,
    created_by varchar(100) DEFAULT NULL,
    updated_at timestamp DEFAULT NULL,
    updated_by varchar(100) DEFAULT NULL,
    config text,
    comment text
);

CREATE TABLE IF NOT EXISTS s2_query_stat_info (
    id SERIAL PRIMARY KEY,
    trace_id varchar(200) DEFAULT NULL,
    model_id bigint DEFAULT NULL,
    data_set_id bigint DEFAULT NULL,
    query_user varchar(200) DEFAULT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP,
    query_type varchar(200) DEFAULT NULL,
    query_type_back integer DEFAULT 0,
    query_sql_cmd text,
    sql_cmd_md5 varchar(200) DEFAULT NULL,
    query_struct_cmd text,
    struct_cmd_md5 varchar(200) DEFAULT NULL,
    query_sql text,
    sql_md5 varchar(200) DEFAULT NULL,
    query_engine varchar(20) DEFAULT NULL,
    elapsed_ms bigint DEFAULT NULL,
    query_state varchar(20) DEFAULT NULL,
    native_query boolean DEFAULT false,
    start_date varchar(50) DEFAULT NULL,
    end_date varchar(50) DEFAULT NULL,
    dimensions text,
    metrics text,
    select_cols text,
    agg_cols text,
    filter_cols text,
    group_by_cols text,
    order_by_cols text,
    use_result_cache boolean DEFAULT false,
    use_sql_cache boolean DEFAULT false,
    sql_cache_key text,
    result_cache_key text,
    query_opt_mode varchar(20) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS s2_canvas (
    id SERIAL PRIMARY KEY,
    domain_id bigint DEFAULT NULL,
    type varchar(20) DEFAULT NULL,
    config text,
    created_at timestamp DEFAULT NULL,
    created_by varchar(100) DEFAULT NULL,
    updated_at timestamp DEFAULT NULL,
    updated_by varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS s2_system_config (
    id SERIAL PRIMARY KEY,
    admin varchar(500),
    parameters text
);

CREATE TABLE IF NOT EXISTS s2_model_rela (
    id SERIAL PRIMARY KEY,
    domain_id bigint,
    from_model_id bigint,
    to_model_id bigint,
    join_type VARCHAR(255),
    join_condition text
);

CREATE TABLE IF NOT EXISTS s2_collect (
    id SERIAL PRIMARY KEY,
    type varchar(20) NOT NULL,
    username varchar(20) NOT NULL,
    collect_id bigint NOT NULL,
    create_time timestamp,
    update_time timestamp
);

CREATE TABLE IF NOT EXISTS s2_metric_query_default_config (
    id SERIAL PRIMARY KEY,
    metric_id bigint,
    user_name varchar(255) NOT NULL,
    default_config varchar(1000) NOT NULL,
    created_at timestamp NULL,
    updated_at timestamp NULL,
    created_by varchar(100) NULL,
    updated_by varchar(100) NULL
);

CREATE TABLE IF NOT EXISTS s2_user (
    id SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL,
    display_name varchar(100) NULL,
    password varchar(256) NULL,
    salt varchar(256) DEFAULT NULL,
    email varchar(100) NULL,
    is_admin smallint NULL,
    last_login timestamp NULL,
    UNIQUE(name)
);

-- Text-to-SQL Schema Knowledge 表 (需要 pgvector 扩展支持)
CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE IF NOT EXISTS s2_schema_knowledge (
    id BIGSERIAL PRIMARY KEY,
    table_name VARCHAR(64) NOT NULL,
    table_comment VARCHAR(255),
    column_name VARCHAR(64),
    column_comment VARCHAR(255),
    column_type VARCHAR(32),
    is_primary_key BOOLEAN DEFAULT FALSE,
    is_foreign_key BOOLEAN DEFAULT FALSE,
    fk_reference VARCHAR(128),
    knowledge_text TEXT NOT NULL,
    embedding VECTOR(1024),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_schema_embedding ON s2_schema_knowledge USING ivfflat (embedding vector_cosine_ops);
CREATE INDEX IF NOT EXISTS idx_table_name ON s2_schema_knowledge(table_name);

-- ============================================
-- LLM-SQL-Wiki 模块表结构
-- 创建时间: 2026-04-17
-- ============================================

CREATE TABLE IF NOT EXISTS s2_wiki_entity (
    id BIGSERIAL PRIMARY KEY,
    entity_id VARCHAR(128) NOT NULL UNIQUE,
    entity_type VARCHAR(32) NOT NULL,
    name VARCHAR(64) NOT NULL,
    display_name VARCHAR(128),
    description TEXT,
    properties JSONB,
    summary TEXT,
    tags TEXT[],
    version VARCHAR(32),
    parent_entity_id VARCHAR(128),
    topic_id VARCHAR(64),
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_entity_type ON s2_wiki_entity(entity_type);
CREATE INDEX IF NOT EXISTS idx_parent ON s2_wiki_entity(parent_entity_id);
CREATE INDEX IF NOT EXISTS idx_topic ON s2_wiki_entity(topic_id);
CREATE INDEX IF NOT EXISTS idx_entity_name ON s2_wiki_entity(name);
CREATE INDEX IF NOT EXISTS idx_entity_status ON s2_wiki_entity(status);

CREATE TABLE IF NOT EXISTS s2_wiki_entity_link (
    id BIGSERIAL PRIMARY KEY,
    source_entity_id VARCHAR(128) NOT NULL,
    target_entity_id VARCHAR(128) NOT NULL,
    link_type VARCHAR(32) NOT NULL,
    relation VARCHAR(64),
    description TEXT,
    bidirectional BOOLEAN DEFAULT FALSE,
    weight DECIMAL(3,2) DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_link_source FOREIGN KEY (source_entity_id) REFERENCES s2_wiki_entity(entity_id) ON DELETE CASCADE,
    CONSTRAINT fk_link_target FOREIGN KEY (target_entity_id) REFERENCES s2_wiki_entity(entity_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_link_source ON s2_wiki_entity_link(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_link_target ON s2_wiki_entity_link(target_entity_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_link_unique ON s2_wiki_entity_link(source_entity_id, target_entity_id, link_type);

-- Entity-Topic association table (many-to-many)
CREATE TABLE IF NOT EXISTS s2_wiki_entity_topic (
    id BIGSERIAL PRIMARY KEY,
    entity_id VARCHAR(64) NOT NULL,
    topic_id VARCHAR(64) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(entity_id, topic_id)
);

CREATE INDEX IF NOT EXISTS idx_entity_topic_entity ON s2_wiki_entity_topic(entity_id);
CREATE INDEX IF NOT EXISTS idx_entity_topic_topic ON s2_wiki_entity_topic(topic_id);

CREATE TABLE IF NOT EXISTS s2_wiki_knowledge_card (
    id BIGSERIAL PRIMARY KEY,
    card_id VARCHAR(128) NOT NULL UNIQUE,
    entity_id VARCHAR(128) NOT NULL,
    card_type VARCHAR(32) NOT NULL,
    title VARCHAR(256),
    content TEXT NOT NULL,
    extracted_from TEXT[],
    confidence DECIMAL(5,4) DEFAULT 1.0,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    tags TEXT[],
    embedding VECTOR(1024),
    version VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_card_entity FOREIGN KEY (entity_id) REFERENCES s2_wiki_entity(entity_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_card_entity ON s2_wiki_knowledge_card(entity_id);
CREATE INDEX IF NOT EXISTS idx_card_type ON s2_wiki_knowledge_card(card_type);
CREATE INDEX IF NOT EXISTS idx_card_status ON s2_wiki_knowledge_card(status);
CREATE INDEX IF NOT EXISTS idx_card_embedding ON s2_wiki_knowledge_card USING ivfflat (embedding vector_cosine_ops);

CREATE TABLE IF NOT EXISTS s2_wiki_topic_summary (
    id BIGSERIAL PRIMARY KEY,
    topic_id VARCHAR(64) NOT NULL UNIQUE,
    topic_name VARCHAR(128) NOT NULL,
    summary TEXT NOT NULL,
    member_entities TEXT[],
    relationships TEXT[],
    metrics JSONB,
    summary_version INT DEFAULT 1,
    llm_model VARCHAR(64),
    generated_at TIMESTAMP,
    status VARCHAR(16) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_topic_name ON s2_wiki_topic_summary(topic_name);
CREATE INDEX IF NOT EXISTS idx_topic_status ON s2_wiki_topic_summary(status);

CREATE TABLE IF NOT EXISTS s2_wiki_contradiction (
    id BIGSERIAL PRIMARY KEY,
    contradiction_id VARCHAR(128) NOT NULL UNIQUE,
    entity_id VARCHAR(128) NOT NULL,
    old_knowledge_card_id VARCHAR(128),
    conflict_type VARCHAR(32) NOT NULL,
    old_content TEXT,
    new_evidence TEXT,
    evidence_source VARCHAR(256),
    impact TEXT,
    resolution VARCHAR(16) DEFAULT 'PENDING',
    resolved_at TIMESTAMP,
    resolved_by VARCHAR(64),
    resolution_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_contradiction_entity ON s2_wiki_contradiction(entity_id);
CREATE INDEX IF NOT EXISTS idx_contradiction_status ON s2_wiki_contradiction(resolution);
CREATE INDEX IF NOT EXISTS idx_contradiction_type ON s2_wiki_contradiction(conflict_type);

CREATE TABLE IF NOT EXISTS s2_wiki_evidence (
    id BIGSERIAL PRIMARY KEY,
    evidence_id VARCHAR(128) NOT NULL UNIQUE,
    contradiction_id VARCHAR(128),
    source_entity_id VARCHAR(128),
    evidence_type VARCHAR(16) NOT NULL,
    content TEXT NOT NULL,
    source VARCHAR(256),
    confidence DECIMAL(5,4),
    impact VARCHAR(32),
    resolution VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_evidence_contradiction FOREIGN KEY (contradiction_id) REFERENCES s2_wiki_contradiction(contradiction_id) ON DELETE CASCADE,
    CONSTRAINT fk_evidence_entity FOREIGN KEY (source_entity_id) REFERENCES s2_wiki_entity(entity_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_evidence_contradiction ON s2_wiki_evidence(contradiction_id);
CREATE INDEX IF NOT EXISTS idx_evidence_type ON s2_wiki_evidence(evidence_type);

-- ============================================
-- 多轮对话上下文表
-- 创建时间: 2026-04-18
-- ============================================

CREATE TABLE IF NOT EXISTS s2_wiki_conversation_context (
    id BIGSERIAL PRIMARY KEY,
    conversation_id VARCHAR(64) NOT NULL,
    user_id VARCHAR(64) NOT NULL,
    data_set_id BIGINT NOT NULL,
    context_type VARCHAR(32) NOT NULL COMMENT '上下文类型: TIME_RANGE, ENTITY, FILTER, INTENT, SQL_RESULT',
    context_key VARCHAR(128) NOT NULL COMMENT '上下文键',
    context_value TEXT NOT NULL COMMENT '上下文值(JSON格式)',
    query_text TEXT COMMENT '产生此上下文的原始问题',
    generated_sql TEXT COMMENT '生成的SQL',
    referenced_entities TEXT[] COMMENT '引用的实体列表',
    referenced_cards TEXT[] COMMENT '引用的知识卡片列表',
    round_number INT DEFAULT 1 COMMENT '对话轮次',
    status VARCHAR(16) DEFAULT 'ACTIVE' COMMENT '状态: ACTIVE, EXPIRED, ARCHIVED',
    expires_at TIMESTAMP COMMENT '过期时间',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_conv_conversation_id ON s2_wiki_conversation_context(conversation_id);
CREATE INDEX IF NOT EXISTS idx_conv_user_id ON s2_wiki_conversation_context(user_id);
CREATE INDEX IF NOT EXISTS idx_conv_context_type ON s2_wiki_conversation_context(context_type);
CREATE INDEX IF NOT EXISTS idx_conv_round_number ON s2_wiki_conversation_context(round_number);
CREATE INDEX IF NOT EXISTS idx_conv_status ON s2_wiki_conversation_context(status);
CREATE INDEX IF NOT EXISTS idx_conv_expires_at ON s2_wiki_conversation_context(expires_at);
CREATE INDEX IF NOT EXISTS idx_conv_created_at ON s2_wiki_conversation_context(created_at);

-- ============================================
-- LLM-SQL-Wiki 健康巡检相关表
-- 创建时间: 2026-04-19
-- ============================================

-- 健康巡检报告表
CREATE TABLE IF NOT EXISTS s2_wiki_health_report (
    id BIGSERIAL PRIMARY KEY,
    report_id VARCHAR(128) NOT NULL UNIQUE,
    report_type VARCHAR(16) NOT NULL,
    checked_at TIMESTAMP NOT NULL,
    contradictions_found INT DEFAULT 0,
    outdated_cards INT DEFAULT 0,
    orphan_entities INT DEFAULT 0,
    missing_refs INT DEFAULT 0,
    status VARCHAR(32) DEFAULT 'PENDING_PROCESSED',
    report_content JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 知识卡片使用历史表
CREATE TABLE IF NOT EXISTS s2_wiki_card_usage_log (
    id BIGSERIAL PRIMARY KEY,
    card_id VARCHAR(128) NOT NULL,
    sql TEXT NOT NULL,
    result VARCHAR(16) NOT NULL,
    error_msg TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 研究方向表
CREATE TABLE IF NOT EXISTS s2_wiki_research_topic (
    id BIGSERIAL PRIMARY KEY,
    topic_id VARCHAR(128) NOT NULL UNIQUE,
    topic VARCHAR(512) NOT NULL,
    priority VARCHAR(16) DEFAULT 'MEDIUM',
    reason TEXT,
    status VARCHAR(32) DEFAULT 'PENDING',
    related_entity_ids TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    confirmed_at TIMESTAMP,
    confirmed_by VARCHAR(64)
);

CREATE INDEX IF NOT EXISTS idx_report_type ON s2_wiki_health_report(report_type);
CREATE INDEX IF NOT EXISTS idx_report_status ON s2_wiki_health_report(status);
CREATE INDEX IF NOT EXISTS idx_card_usage_card ON s2_wiki_card_usage_log(card_id);
CREATE INDEX IF NOT EXISTS idx_topic_status ON s2_wiki_research_topic(status);
CREATE INDEX IF NOT EXISTS idx_topic_priority ON s2_wiki_research_topic(priority);