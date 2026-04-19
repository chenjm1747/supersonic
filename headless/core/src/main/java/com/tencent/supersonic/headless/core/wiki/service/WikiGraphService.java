package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiLink;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class WikiGraphService {

    private final WikiEntityService entityService;
    private final WikiLinkService linkService;

    public WikiGraphService(WikiEntityService entityService, WikiLinkService linkService) {
        this.entityService = entityService;
        this.linkService = linkService;
    }

    public List<GraphNode> getGraphNodes() {
        List<WikiEntity> entities = entityService.getAllActiveEntities();
        List<GraphNode> nodes = new ArrayList<>();

        for (WikiEntity entity : entities) {
            GraphNode node = new GraphNode();
            node.setId(entity.getEntityId());
            node.setName(entity.getName());
            node.setDisplayName(entity.getDisplayName());
            node.setType(entity.getEntityType());
            node.setDescription(entity.getDescription());
            node.setProperties(entity.getProperties());
            node.setStatus(entity.getStatus());
            node.setTopicId(entity.getTopicId());
            // Get all topics from association table
            List<String> topicIds = entityService.getTopicIdsByEntityId(entity.getEntityId());
            node.setTopicIds(topicIds);
            nodes.add(node);
        }

        return nodes;
    }

    public List<GraphEdge> getGraphEdges() {
        List<WikiLink> links = linkService.getAllLinks();
        List<GraphEdge> edges = new ArrayList<>();

        for (WikiLink link : links) {
            GraphEdge edge = new GraphEdge();
            edge.setId(link.getId().toString());
            edge.setSource(link.getSourceEntityId());
            edge.setTarget(link.getTargetEntityId());
            edge.setType(link.getLinkType());
            edge.setLabel(link.getRelation());
            edge.setWeight(link.getWeight() != null ? link.getWeight().floatValue() : 1.0f);
            edge.setBidirectional(link.getBidirectional());
            edges.add(edge);

            if (Boolean.TRUE.equals(link.getBidirectional())) {
                GraphEdge reverseEdge = new GraphEdge();
                reverseEdge.setId(link.getId() + "-reverse");
                reverseEdge.setSource(link.getTargetEntityId());
                reverseEdge.setTarget(link.getSourceEntityId());
                reverseEdge.setType(link.getLinkType());
                reverseEdge.setLabel(link.getRelation());
                reverseEdge.setWeight(edge.getWeight());
                reverseEdge.setBidirectional(false);
                edges.add(reverseEdge);
            }
        }

        return edges;
    }

    public List<GraphNode> getChildNodes(String type, String parentId) {
        List<WikiEntity> entities;
        if (parentId != null && !parentId.isEmpty()) {
            entities = entityService.getChildEntitiesByType(type, parentId);
        } else {
            entities = entityService.getEntitiesByType(type);
        }
        List<GraphNode> nodes = new ArrayList<>();
        for (WikiEntity entity : entities) {
            nodes.add(convertToGraphNode(entity));
        }
        return nodes;
    }

    public List<GraphEdge> getEdgesByNodeIds(List<String> nodeIds) {
        List<WikiLink> links = linkService.getLinksByEntityIds(nodeIds);
        List<GraphEdge> edges = new ArrayList<>();
        for (WikiLink link : links) {
            edges.add(convertToGraphEdge(link));
        }
        return edges;
    }

    private GraphNode convertToGraphNode(WikiEntity entity) {
        GraphNode node = new GraphNode();
        node.setId(entity.getEntityId());
        node.setName(entity.getName());
        node.setDisplayName(entity.getDisplayName());
        node.setType(entity.getEntityType());
        node.setDescription(entity.getDescription());
        node.setProperties(entity.getProperties());
        node.setStatus(entity.getStatus());
        node.setTopicId(entity.getTopicId());
        List<String> topicIds = entityService.getTopicIdsByEntityId(entity.getEntityId());
        node.setTopicIds(topicIds);
        return node;
    }

    private GraphEdge convertToGraphEdge(WikiLink link) {
        GraphEdge edge = new GraphEdge();
        edge.setId(link.getId().toString());
        edge.setSource(link.getSourceEntityId());
        edge.setTarget(link.getTargetEntityId());
        edge.setType(link.getLinkType());
        edge.setLabel(link.getRelation());
        edge.setWeight(link.getWeight() != null ? link.getWeight().floatValue() : 1.0f);
        edge.setBidirectional(link.getBidirectional());
        return edge;
    }

    public List<GraphNode> getNeighborNodes(String entityId, int depth) {
        Map<String, Boolean> visited = new HashMap<>();
        List<GraphNode> result = new ArrayList<>();
        collectNeighborNodes(entityId, depth, visited, result);
        return result;
    }

    private void collectNeighborNodes(String entityId, int remainingDepth,
            Map<String, Boolean> visited, List<GraphNode> result) {
        if (visited.containsKey(entityId) || remainingDepth < 0) {
            return;
        }

        visited.put(entityId, true);

        WikiEntity entity = entityService.getEntityById(entityId);
        if (entity != null) {
            GraphNode node = new GraphNode();
            node.setId(entity.getEntityId());
            node.setName(entity.getName());
            node.setDisplayName(entity.getDisplayName());
            node.setType(entity.getEntityType());
            node.setDescription(entity.getDescription());
            node.setProperties(entity.getProperties());
            node.setDepth(remainingDepth);
            node.setTopicId(entity.getTopicId());
            List<String> topicIds = entityService.getTopicIdsByEntityId(entity.getEntityId());
            node.setTopicIds(topicIds);
            result.add(node);
        }

        List<WikiLink> links = linkService.getLinksByEntity(entityId);
        for (WikiLink link : links) {
            String neighborId = link.getSourceEntityId().equals(entityId) ? link.getTargetEntityId()
                    : link.getSourceEntityId();
            collectNeighborNodes(neighborId, remainingDepth - 1, visited, result);
        }
    }

    public Map<String, Object> getEntityGraphData(String entityId) {
        Map<String, Object> graphData = new HashMap<>();

        WikiEntity entity = entityService.getEntityById(entityId);
        if (entity != null) {
            GraphNode node = new GraphNode();
            node.setId(entity.getEntityId());
            node.setName(entity.getName());
            node.setDisplayName(entity.getDisplayName());
            node.setType(entity.getEntityType());
            node.setDescription(entity.getDescription());
            node.setProperties(entity.getProperties());
            node.setTopicId(entity.getTopicId());
            List<String> topicIds = entityService.getTopicIdsByEntityId(entity.getEntityId());
            node.setTopicIds(topicIds);
            graphData.put("centerNode", node);
        }

        List<WikiLink> links = linkService.getLinksByEntity(entityId);
        List<GraphNode> neighborNodes = new ArrayList<>();
        List<GraphEdge> edges = new ArrayList<>();

        for (WikiLink link : links) {
            String neighborId = link.getSourceEntityId().equals(entityId) ? link.getTargetEntityId()
                    : link.getSourceEntityId();

            WikiEntity neighbor = entityService.getEntityById(neighborId);
            if (neighbor != null) {
                GraphNode neighborNode = new GraphNode();
                neighborNode.setId(neighbor.getEntityId());
                neighborNode.setName(neighbor.getName());
                neighborNode.setDisplayName(neighbor.getDisplayName());
                neighborNode.setType(neighbor.getEntityType());
                neighborNode.setDescription(neighbor.getDescription());
                neighborNode.setProperties(neighbor.getProperties());
                neighborNode.setTopicId(neighbor.getTopicId());
                List<String> neighborTopicIds =
                        entityService.getTopicIdsByEntityId(neighbor.getEntityId());
                neighborNode.setTopicIds(neighborTopicIds);
                neighborNodes.add(neighborNode);
            }

            GraphEdge edge = new GraphEdge();
            edge.setId(link.getId().toString());
            edge.setSource(link.getSourceEntityId());
            edge.setTarget(link.getTargetEntityId());
            edge.setType(link.getLinkType());
            edge.setLabel(link.getRelation());
            edge.setWeight(link.getWeight() != null ? link.getWeight().floatValue() : 1.0f);
            edges.add(edge);
        }

        graphData.put("neighborNodes", neighborNodes);
        graphData.put("edges", edges);

        return graphData;
    }

    public static class GraphNode {
        private String id;
        private String name;
        private String displayName;
        private String type;
        private String description;
        private String status;
        private String topicId;
        private List<String> topicIds;
        private Map<String, Object> properties;
        private int depth = 0;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getDisplayName() {
            return displayName;
        }

        public void setDisplayName(String displayName) {
            this.displayName = displayName;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getDescription() {
            return description;
        }

        public void setDescription(String description) {
            this.description = description;
        }

        public Map<String, Object> getProperties() {
            return properties;
        }

        public void setProperties(Map<String, Object> properties) {
            this.properties = properties;
        }

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getTopicId() {
            return topicId;
        }

        public void setTopicId(String topicId) {
            this.topicId = topicId;
        }

        public List<String> getTopicIds() {
            return topicIds;
        }

        public void setTopicIds(List<String> topicIds) {
            this.topicIds = topicIds;
        }

        public int getDepth() {
            return depth;
        }

        public void setDepth(int depth) {
            this.depth = depth;
        }
    }

    public static class GraphEdge {
        private String id;
        private String source;
        private String target;
        private String type;
        private String label;
        private float weight = 1.0f;
        private Boolean bidirectional;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getSource() {
            return source;
        }

        public void setSource(String source) {
            this.source = source;
        }

        public String getTarget() {
            return target;
        }

        public void setTarget(String target) {
            this.target = target;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getLabel() {
            return label;
        }

        public void setLabel(String label) {
            this.label = label;
        }

        public float getWeight() {
            return weight;
        }

        public void setWeight(float weight) {
            this.weight = weight;
        }

        public Boolean getBidirectional() {
            return bidirectional;
        }

        public void setBidirectional(Boolean bidirectional) {
            this.bidirectional = bidirectional;
        }
    }
}
