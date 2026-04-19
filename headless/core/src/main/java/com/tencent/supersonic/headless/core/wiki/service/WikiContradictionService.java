package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.Contradiction;
import com.tencent.supersonic.headless.core.wiki.dto.Evidence;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class WikiContradictionService {

    private final JdbcTemplate jdbcTemplate;

    private static final String INSERT_CONTRADICTION_SQL =
            """
                    INSERT INTO s2_wiki_contradiction
                    (contradiction_id, entity_id, old_knowledge_card_id, conflict_type, old_content, new_evidence,
                     evidence_source, impact, resolution, created_at, updated_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """;

    private static final String INSERT_EVIDENCE_SQL = """
            INSERT INTO s2_wiki_evidence
            (evidence_id, contradiction_id, source_entity_id, evidence_type, content, source,
             confidence, impact, resolution, created_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;

    private static final String SELECT_BY_ENTITY_SQL = """
            SELECT * FROM s2_wiki_contradiction WHERE entity_id = ?
            """;

    private static final String SELECT_BY_STATUS_SQL = """
            SELECT * FROM s2_wiki_contradiction WHERE resolution = ?
            """;

    private static final String SELECT_ALL_SQL = """
            SELECT * FROM s2_wiki_contradiction ORDER BY created_at DESC
            """;

    private static final String SELECT_BY_ID_SQL = """
            SELECT * FROM s2_wiki_contradiction WHERE contradiction_id = ?
            """;

    private static final String UPDATE_CONTRADICTION_SQL =
            """
                    UPDATE s2_wiki_contradiction
                    SET resolution = ?, resolved_at = ?, resolved_by = ?, resolution_notes = ?, updated_at = ?
                    WHERE contradiction_id = ?
                    """;

    private static final String SELECT_EVIDENCE_BY_CONTRADICTION_SQL = """
            SELECT * FROM s2_wiki_evidence WHERE contradiction_id = ?
            """;

    private static final String DELETE_CONTRADICTION_SQL = """
            DELETE FROM s2_wiki_contradiction WHERE contradiction_id = ?
            """;

    public WikiContradictionService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Transactional
    public Contradiction createContradiction(Contradiction contradiction) {
        if (contradiction.getContradictionId() == null
                || contradiction.getContradictionId().isEmpty()) {
            contradiction.setContradictionId("ct:" + UUID.randomUUID().toString());
        }
        contradiction.setCreatedAt(LocalDateTime.now());
        contradiction.setUpdatedAt(LocalDateTime.now());
        if (contradiction.getResolution() == null) {
            contradiction.setResolution("PENDING");
        }

        log.info("Creating contradiction: {} for entity: {}", contradiction.getContradictionId(),
                contradiction.getEntityId());

        jdbcTemplate.update(INSERT_CONTRADICTION_SQL, contradiction.getContradictionId(),
                contradiction.getEntityId(), contradiction.getOldKnowledgeCardId(),
                contradiction.getConflictType(), contradiction.getOldContent(),
                contradiction.getNewEvidence(), contradiction.getEvidenceSource(),
                contradiction.getImpact(), contradiction.getResolution(),
                contradiction.getCreatedAt(), contradiction.getUpdatedAt());

        if (contradiction.getEvidence() != null) {
            createEvidence(contradiction.getContradictionId(), contradiction.getEvidence());
        }

        return contradiction;
    }

    @Transactional
    public Evidence createEvidence(String contradictionId, Evidence evidence) {
        if (evidence.getEvidenceId() == null || evidence.getEvidenceId().isEmpty()) {
            evidence.setEvidenceId("ev:" + UUID.randomUUID().toString());
        }
        evidence.setContradictionId(contradictionId);
        evidence.setCreatedAt(LocalDateTime.now());

        jdbcTemplate.update(INSERT_EVIDENCE_SQL, evidence.getEvidenceId(),
                evidence.getContradictionId(), evidence.getSourceEntityId(),
                evidence.getEvidenceType(), evidence.getContent(), evidence.getSource(),
                evidence.getConfidence(), evidence.getImpact(), evidence.getResolution(),
                evidence.getCreatedAt());

        return evidence;
    }

    public List<Contradiction> getContradictionsByEntityId(String entityId) {
        return jdbcTemplate.query(SELECT_BY_ENTITY_SQL, new ContradictionRowMapper(), entityId);
    }

    public List<Contradiction> getContradictionsByStatus(String status) {
        return jdbcTemplate.query(SELECT_BY_STATUS_SQL, new ContradictionRowMapper(), status);
    }

    public List<Contradiction> getAllContradictions() {
        return jdbcTemplate.query(SELECT_ALL_SQL, new ContradictionRowMapper());
    }

    public Contradiction getContradictionById(String contradictionId) {
        List<Contradiction> results =
                jdbcTemplate.query(SELECT_BY_ID_SQL, new ContradictionRowMapper(), contradictionId);
        if (results.isEmpty()) {
            return null;
        }
        Contradiction contradiction = results.get(0);
        List<Evidence> evidences = getEvidencesByContradictionId(contradictionId);
        if (!evidences.isEmpty()) {
            contradiction.setEvidence(evidences.get(0));
        }
        return contradiction;
    }

    public List<Evidence> getEvidencesByContradictionId(String contradictionId) {
        return jdbcTemplate.query(SELECT_EVIDENCE_BY_CONTRADICTION_SQL, new EvidenceRowMapper(),
                contradictionId);
    }

    @Transactional
    public Contradiction resolveContradiction(String contradictionId, String resolution,
            String resolvedBy, String resolutionNotes) {
        log.info("Resolving contradiction: {} with resolution: {}", contradictionId, resolution);

        Contradiction contradiction = getContradictionById(contradictionId);
        if (contradiction == null) {
            throw new RuntimeException("Contradiction not found: " + contradictionId);
        }

        LocalDateTime now = LocalDateTime.now();
        jdbcTemplate.update(UPDATE_CONTRADICTION_SQL, resolution, now, resolvedBy, resolutionNotes,
                now, contradictionId);

        contradiction.setResolution(resolution);
        contradiction.setResolvedAt(now);
        contradiction.setResolvedBy(resolvedBy);
        contradiction.setResolutionNotes(resolutionNotes);

        return contradiction;
    }

    @Transactional
    public void deleteContradiction(String contradictionId) {
        log.info("Deleting contradiction: {}", contradictionId);
        jdbcTemplate.update(DELETE_CONTRADICTION_SQL, contradictionId);
    }

    public List<Contradiction> getPendingContradictions() {
        return getContradictionsByStatus("PENDING");
    }

    public List<Contradiction> getResolvedContradictions() {
        return jdbcTemplate.query(
                "SELECT * FROM s2_wiki_contradiction WHERE resolution != 'PENDING' ORDER BY resolved_at DESC",
                new ContradictionRowMapper());
    }

    private static class ContradictionRowMapper implements RowMapper<Contradiction> {
        @Override
        public Contradiction mapRow(ResultSet rs, int rowNum) throws SQLException {
            Contradiction c = new Contradiction();
            c.setId(rs.getLong("id"));
            c.setContradictionId(rs.getString("contradiction_id"));
            c.setEntityId(rs.getString("entity_id"));
            c.setOldKnowledgeCardId(rs.getString("old_knowledge_card_id"));
            c.setConflictType(rs.getString("conflict_type"));
            c.setOldContent(rs.getString("old_content"));
            c.setNewEvidence(rs.getString("new_evidence"));
            c.setEvidenceSource(rs.getString("evidence_source"));
            c.setImpact(rs.getString("impact"));
            c.setResolution(rs.getString("resolution"));
            c.setResolvedAt(rs.getTimestamp("resolved_at") != null
                    ? rs.getTimestamp("resolved_at").toLocalDateTime()
                    : null);
            c.setResolvedBy(rs.getString("resolved_by"));
            c.setResolutionNotes(rs.getString("resolution_notes"));
            c.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            c.setUpdatedAt(rs.getTimestamp("updated_at") != null
                    ? rs.getTimestamp("updated_at").toLocalDateTime()
                    : null);
            return c;
        }
    }

    private static class EvidenceRowMapper implements RowMapper<Evidence> {
        @Override
        public Evidence mapRow(ResultSet rs, int rowNum) throws SQLException {
            Evidence e = new Evidence();
            e.setId(rs.getLong("id"));
            e.setEvidenceId(rs.getString("evidence_id"));
            e.setContradictionId(rs.getString("contradiction_id"));
            e.setSourceEntityId(rs.getString("source_entity_id"));
            e.setEvidenceType(rs.getString("evidence_type"));
            e.setContent(rs.getString("content"));
            e.setSource(rs.getString("source"));
            e.setConfidence(rs.getBigDecimal("confidence"));
            e.setImpact(rs.getString("impact"));
            e.setResolution(rs.getString("resolution"));
            e.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            return e;
        }
    }
}
