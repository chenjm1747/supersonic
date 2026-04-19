-- ============================================================
-- LLM-SQL-Wiki Database Schema
-- ============================================================

SET search_path TO heating_analytics;

-- 1. Entity Table
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

-- 2. Entity Link Table
CREATE TABLE IF NOT EXISTS s2_wiki_entity_link (
    id BIGSERIAL PRIMARY KEY,
    source_entity_id VARCHAR(128) NOT NULL,
    target_entity_id VARCHAR(128) NOT NULL,
    link_type VARCHAR(32) NOT NULL,
    relation VARCHAR(64),
    description TEXT,
    bidirectional BOOLEAN DEFAULT FALSE,
    weight DECIMAL(3,2) DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_link_source ON s2_wiki_entity_link(source_entity_id);
CREATE INDEX IF NOT EXISTS idx_link_target ON s2_wiki_entity_link(target_entity_id);

-- 3. Knowledge Card Table
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
    embedding TEXT,
    version VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_card_entity ON s2_wiki_knowledge_card(entity_id);
CREATE INDEX IF NOT EXISTS idx_card_type ON s2_wiki_knowledge_card(card_type);

-- 4. Topic Summary Table
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

-- 5. Contradiction Table
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

-- 6. Evidence Table
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_evidence_contradiction ON s2_wiki_evidence(contradiction_id);
CREATE INDEX IF NOT EXISTS idx_evidence_type ON s2_wiki_evidence(evidence_type);
