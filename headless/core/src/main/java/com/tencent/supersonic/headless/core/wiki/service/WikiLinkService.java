package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.WikiLink;
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

@Service
@Slf4j
public class WikiLinkService {

    private final JdbcTemplate jdbcTemplate;

    private static final String INSERT_LINK_SQL =
            """
                    INSERT INTO s2_wiki_entity_link
                    (source_entity_id, target_entity_id, link_type, relation, description, bidirectional, weight, created_at)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?)
                    """;

    private static final String SELECT_BY_SOURCE_SQL =
            "SELECT * FROM s2_wiki_entity_link WHERE source_entity_id = ?";

    private static final String SELECT_BY_TARGET_SQL =
            "SELECT * FROM s2_wiki_entity_link WHERE target_entity_id = ?";

    private static final String SELECT_BY_ENTITY_SQL = """
            SELECT * FROM s2_wiki_entity_link
            WHERE source_entity_id = ? OR target_entity_id = ?
            """;

    private static final String SELECT_ALL_LINKS_SQL = "SELECT * FROM s2_wiki_entity_link";

    private static final String DELETE_LINK_SQL =
            "DELETE FROM s2_wiki_entity_link WHERE source_entity_id = ? AND target_entity_id = ? AND link_type = ?";

    private static final String DELETE_LINKS_BY_ENTITY_SQL =
            "DELETE FROM s2_wiki_entity_link WHERE source_entity_id = ? OR target_entity_id = ?";

    public WikiLinkService(DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Transactional
    public WikiLink createLink(WikiLink link) {
        link.setCreatedAt(LocalDateTime.now());
        if (link.getWeight() == null) {
            link.setWeight(BigDecimal.valueOf(1.0));
        }
        if (link.getBidirectional() == null) {
            link.setBidirectional(false);
        }

        log.info("Creating wiki link: {} -> {} ({})", link.getSourceEntityId(),
                link.getTargetEntityId(), link.getLinkType());

        jdbcTemplate.update(INSERT_LINK_SQL, link.getSourceEntityId(), link.getTargetEntityId(),
                link.getLinkType(), link.getRelation(), link.getDescription(),
                link.getBidirectional(), link.getWeight(), link.getCreatedAt());

        return link;
    }

    public List<WikiLink> getLinksBySource(String sourceEntityId) {
        return jdbcTemplate.query(SELECT_BY_SOURCE_SQL, new WikiLinkRowMapper(), sourceEntityId);
    }

    public List<WikiLink> getLinksByTarget(String targetEntityId) {
        return jdbcTemplate.query(SELECT_BY_TARGET_SQL, new WikiLinkRowMapper(), targetEntityId);
    }

    public List<WikiLink> getLinksByEntity(String entityId) {
        return jdbcTemplate.query(SELECT_BY_ENTITY_SQL, new WikiLinkRowMapper(), entityId,
                entityId);
    }

    public List<WikiLink> getAllLinks() {
        return jdbcTemplate.query(SELECT_ALL_LINKS_SQL, new WikiLinkRowMapper());
    }

    @Transactional
    public void deleteLink(String sourceEntityId, String targetEntityId, String linkType) {
        log.info("Deleting wiki link: {} -> {} ({})", sourceEntityId, targetEntityId, linkType);
        jdbcTemplate.update(DELETE_LINK_SQL, sourceEntityId, targetEntityId, linkType);
    }

    @Transactional
    public void deleteLinksByEntityId(String entityId) {
        log.info("Deleting wiki links for entity: {}", entityId);
        jdbcTemplate.update(DELETE_LINKS_BY_ENTITY_SQL, entityId, entityId);
    }

    private static class WikiLinkRowMapper implements RowMapper<WikiLink> {
        @Override
        public WikiLink mapRow(ResultSet rs, int rowNum) throws SQLException {
            WikiLink link = new WikiLink();
            link.setId(rs.getLong("id"));
            link.setSourceEntityId(rs.getString("source_entity_id"));
            link.setTargetEntityId(rs.getString("target_entity_id"));
            link.setLinkType(rs.getString("link_type"));
            link.setRelation(rs.getString("relation"));
            link.setDescription(rs.getString("description"));
            link.setBidirectional(rs.getBoolean("bidirectional"));
            link.setWeight(rs.getBigDecimal("weight"));
            link.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            return link;
        }
    }
}
