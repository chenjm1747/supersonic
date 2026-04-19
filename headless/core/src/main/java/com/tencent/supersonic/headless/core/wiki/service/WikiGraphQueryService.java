package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiLink;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
@Slf4j
public class WikiGraphQueryService {

    private final JdbcTemplate jdbcTemplate;
    private final WikiEntityService entityService;
    private final WikiLinkService linkService;

    private static final String FIND_SHORTEST_PATH_SQL = """
            WITH RECURSIVE path AS (
                SELECT
                    source_entity_id,
                    target_entity_id,
                    link_type,
                    relation,
                    ARRAY[source_entity_id, target_entity_id] as path,
                    1 as depth
                FROM s2_wiki_entity_link
                WHERE source_entity_id = ?

                UNION ALL

                SELECT
                    l.source_entity_id,
                    l.target_entity_id,
                    l.link_type,
                    l.relation,
                    p.path || l.target_entity_id,
                    p.depth + 1
                FROM s2_wiki_entity_link l
                INNER JOIN path p ON l.source_entity_id = p.target_entity_id
                WHERE NOT l.target_entity_id = ANY(p.path) AND p.depth < 10
            )
            SELECT * FROM path WHERE target_entity_id = ?
            ORDER BY depth ASC
            LIMIT 1
            """;

    private static final String FIND_ALL_PATHS_SQL = """
            WITH RECURSIVE path AS (
                SELECT
                    source_entity_id,
                    target_entity_id,
                    link_type,
                    relation,
                    ARRAY[source_entity_id, target_entity_id] as path,
                    1 as depth
                FROM s2_wiki_entity_link
                WHERE source_entity_id = ?

                UNION ALL

                SELECT
                    l.source_entity_id,
                    l.target_entity_id,
                    l.link_type,
                    l.relation,
                    p.path || l.target_entity_id,
                    p.depth + 1
                FROM s2_wiki_entity_link l
                INNER JOIN path p ON l.source_entity_id = p.target_entity_id
                WHERE NOT l.target_entity_id = ANY(p.path) AND p.depth < 10
            )
            SELECT * FROM path WHERE target_entity_id = ?
            ORDER BY depth ASC
            """;

    private static final String FIND_NEIGHBORS_SQL = """
            WITH RECURSIVE neighbors AS (
                SELECT
                    target_entity_id as entity_id,
                    1 as depth,
                    ARRAY[source_entity_id, target_entity_id] as path
                FROM s2_wiki_entity_link
                WHERE source_entity_id = ?

                UNION ALL

                SELECT
                    l.target_entity_id,
                    n.depth + 1,
                    n.path || l.target_entity_id
                FROM s2_wiki_entity_link l
                INNER JOIN neighbors n ON l.source_entity_id = n.entity_id
                WHERE NOT l.target_entity_id = ANY(n.path) AND n.depth < ?
            )
            SELECT DISTINCT entity_id, MIN(depth) as depth
            FROM neighbors
            GROUP BY entity_id
            ORDER BY depth ASC
            """;

    public WikiGraphQueryService(DataSource dataSource, WikiEntityService entityService,
            WikiLinkService linkService) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.entityService = entityService;
        this.linkService = linkService;
    }

    public PathResult findShortestPath(String fromEntityId, String toEntityId) {
        log.info("Finding shortest path from {} to {}", fromEntityId, toEntityId);

        PathResult result = new PathResult();
        result.setFromEntityId(fromEntityId);
        result.setToEntityId(toEntityId);

        try {
            List<Map<String, Object>> rows =
                    jdbcTemplate.queryForList(FIND_SHORTEST_PATH_SQL, fromEntityId, toEntityId);

            if (rows.isEmpty()) {
                result.setFound(false);
                result.setMessage("No path found between the two entities");
                return result;
            }

            Map<String, Object> row = rows.get(0);
            Object pathArray = row.get("path");
            List<String> path = parsePathArray(pathArray);
            int depth = ((Number) row.get("depth")).intValue();

            result.setFound(true);
            result.setDepth(depth);
            result.setPath(path);
            result.setMessage("Shortest path found with " + depth + " hops");

            List<WikiLink> links = new ArrayList<>();
            for (int i = 0; i < path.size() - 1; i++) {
                String source = path.get(i);
                String target = path.get(i + 1);
                WikiLink link = findLinkBetween(source, target);
                if (link != null) {
                    links.add(link);
                }
            }
            result.setLinks(links);

        } catch (Exception e) {
            log.error("Error finding shortest path", e);
            result.setFound(false);
            result.setMessage("Error finding path: " + e.getMessage());
        }

        return result;
    }

    public List<PathResult> findAllPaths(String fromEntityId, String toEntityId) {
        log.info("Finding all paths from {} to {}", fromEntityId, toEntityId);

        List<PathResult> results = new ArrayList<>();

        try {
            List<Map<String, Object>> rows =
                    jdbcTemplate.queryForList(FIND_ALL_PATHS_SQL, fromEntityId, toEntityId);

            Map<Integer, PathResult> pathMap = new HashMap<>();

            for (Map<String, Object> row : rows) {
                Object pathArray = row.get("path");
                List<String> path = parsePathArray(pathArray);
                int depth = ((Number) row.get("depth")).intValue();

                if (!pathMap.containsKey(depth)) {
                    PathResult result = new PathResult();
                    result.setFromEntityId(fromEntityId);
                    result.setToEntityId(toEntityId);
                    result.setFound(true);
                    result.setDepth(depth);
                    result.setPath(path);
                    result.setMessage("Path found with " + depth + " hops");
                    results.add(result);
                    pathMap.put(depth, result);
                }
            }

            if (results.isEmpty()) {
                PathResult result = new PathResult();
                result.setFromEntityId(fromEntityId);
                result.setToEntityId(toEntityId);
                result.setFound(false);
                result.setMessage("No path found");
                results.add(result);
            }

        } catch (Exception e) {
            log.error("Error finding all paths", e);
            PathResult result = new PathResult();
            result.setFromEntityId(fromEntityId);
            result.setToEntityId(toEntityId);
            result.setFound(false);
            result.setMessage("Error finding paths: " + e.getMessage());
            results.add(result);
        }

        return results;
    }

    public NeighborResult findNeighbors(String entityId, int maxDepth) {
        log.info("Finding neighbors of {} within {} hops", entityId, maxDepth);

        NeighborResult result = new NeighborResult();
        result.setCenterEntityId(entityId);
        result.setMaxDepth(maxDepth);

        try {
            List<Map<String, Object>> rows =
                    jdbcTemplate.queryForList(FIND_NEIGHBORS_SQL, entityId, maxDepth);

            List<NeighborNode> neighbors = new ArrayList<>();
            Set<String> processedIds = new HashSet<>();
            processedIds.add(entityId);

            for (Map<String, Object> row : rows) {
                String neighborId = (String) row.get("entity_id");
                int depth = ((Number) row.get("depth")).intValue();

                if (!processedIds.contains(neighborId)) {
                    WikiEntity entity = entityService.getEntityById(neighborId);
                    if (entity != null) {
                        NeighborNode node = new NeighborNode();
                        node.setEntityId(neighborId);
                        node.setName(entity.getName());
                        node.setDisplayName(entity.getDisplayName());
                        node.setType(entity.getEntityType());
                        node.setDepth(depth);
                        neighbors.add(node);
                        processedIds.add(neighborId);
                    }
                }
            }

            result.setNeighbors(neighbors);
            result.setMessage("Found " + neighbors.size() + " neighbors");
            result.setFound(true);

        } catch (Exception e) {
            log.error("Error finding neighbors", e);
            result.setFound(false);
            result.setMessage("Error finding neighbors: " + e.getMessage());
        }

        return result;
    }

    public GraphQueryResult query(String query) {
        log.info("Executing graph query: {}", query);

        GraphQueryResult result = new GraphQueryResult();
        result.setQuery(query);

        try {
            if (query.toLowerCase().contains("shortest path")) {
                String[] parts = extractEntityIds(query);
                if (parts.length >= 2) {
                    PathResult pathResult = findShortestPath(parts[0], parts[1]);
                    result.addResult("shortestPath", pathResult);
                }
            } else if (query.toLowerCase().contains("neighbors")) {
                String[] parts = extractEntityIds(query);
                int depth = extractDepth(query);
                if (parts.length >= 1) {
                    NeighborResult neighborResult = findNeighbors(parts[0], depth);
                    result.addResult("neighbors", neighborResult);
                }
            } else {
                result.setSuccess(false);
                result.setMessage("Unsupported query type. Supported: shortest path, neighbors");
            }

            result.setSuccess(true);

        } catch (Exception e) {
            log.error("Error executing graph query", e);
            result.setSuccess(false);
            result.setMessage("Error executing query: " + e.getMessage());
        }

        return result;
    }

    private WikiLink findLinkBetween(String source, String target) {
        List<WikiLink> links = linkService.getLinksByEntity(source);
        for (WikiLink link : links) {
            if (link.getTargetEntityId().equals(target)) {
                return link;
            }
        }
        return null;
    }

    private List<String> parsePathArray(Object pathArray) {
        List<String> path = new ArrayList<>();
        if (pathArray == null) {
            return path;
        }

        String str = pathArray.toString();
        str = str.replace("{", "").replace("}", "");
        String[] parts = str.split(",");

        for (String part : parts) {
            String trimmed = part.trim().replace("\"", "");
            if (!trimmed.isEmpty()) {
                path.add(trimmed);
            }
        }

        return path;
    }

    private String[] extractEntityIds(String query) {
        List<String> ids = new ArrayList<>();
        String[] words = query.split("\\s+");
        for (String word : words) {
            if (word.startsWith("table:") || word.startsWith("column:") || word.startsWith("topic:")
                    || word.contains(":")) {
                ids.add(word.replace(",", "").replace(".", ":"));
            }
        }
        return ids.toArray(new String[0]);
    }

    private int extractDepth(String query) {
        String[] words = query.split("\\s+");
        for (int i = 0; i < words.length - 1; i++) {
            if (words[i].equalsIgnoreCase("depth") || words[i].equalsIgnoreCase("within")) {
                try {
                    return Integer.parseInt(words[i + 1].replace(",", ""));
                } catch (NumberFormatException ignored) {
                }
            }
        }
        return 2;
    }

    @Data
    public static class PathResult {
        private String fromEntityId;
        private String toEntityId;
        private boolean found;
        private List<String> path;
        private List<WikiLink> links;
        private int depth;
        private String message;
    }

    @Data
    public static class NeighborResult {
        private String centerEntityId;
        private int maxDepth;
        private boolean found;
        private List<NeighborNode> neighbors;
        private String message;
    }

    @Data
    public static class NeighborNode {
        private String entityId;
        private String name;
        private String displayName;
        private String type;
        private int depth;
    }

    @Data
    public static class GraphQueryResult {
        private String query;
        private boolean success;
        private String message;
        private Map<String, Object> results = new HashMap<>();

        public void addResult(String key, Object value) {
            results.put(key, value);
        }
    }
}
