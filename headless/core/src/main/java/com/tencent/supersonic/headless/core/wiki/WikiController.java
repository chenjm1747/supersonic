package com.tencent.supersonic.headless.core.wiki;

import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import com.tencent.supersonic.headless.core.wiki.dto.ChatMessage;
import com.tencent.supersonic.headless.core.wiki.dto.Contradiction;
import com.tencent.supersonic.headless.core.wiki.dto.DataSourceConfig;
import com.tencent.supersonic.headless.core.wiki.dto.Evidence;
import com.tencent.supersonic.headless.core.wiki.dto.TopicSummary;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.KnowledgeCardGenerateReq;
import com.tencent.supersonic.headless.core.wiki.dto.KnowledgeCardGenerateResp;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import com.tencent.supersonic.headless.core.wiki.dto.WikiLink;
import com.tencent.supersonic.headless.core.wiki.service.WikiChatService;
import com.tencent.supersonic.headless.core.wiki.service.WikiContradictionService;
import com.tencent.supersonic.headless.core.wiki.service.WikiDataSourceService;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiGraphQueryService;
import com.tencent.supersonic.headless.core.wiki.service.WikiGraphService;
import com.tencent.supersonic.headless.core.wiki.service.WikiKnowledgeService;
import com.tencent.supersonic.headless.core.wiki.service.WikiLinkService;
import com.tencent.supersonic.headless.core.wiki.service.WikiSqlValidationService;
import com.tencent.supersonic.headless.core.wiki.service.WikiSummaryService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/wiki")
@Slf4j
public class WikiController {

    private final WikiEntityService entityService;
    private final WikiKnowledgeService knowledgeService;
    private final WikiLinkService linkService;
    private final WikiGraphService graphService;
    private final WikiContradictionService contradictionService;
    private final WikiSummaryService summaryService;
    private final WikiDataSourceService dataSourceService;
    private final WikiGraphQueryService graphQueryService;
    private final WikiSqlValidationService sqlValidationService;
    private final WikiChatService chatService;

    public WikiController(WikiEntityService entityService, WikiKnowledgeService knowledgeService,
            WikiLinkService linkService, WikiGraphService graphService,
            WikiContradictionService contradictionService, WikiSummaryService summaryService,
            WikiDataSourceService dataSourceService, WikiGraphQueryService graphQueryService,
            WikiSqlValidationService sqlValidationService, WikiChatService chatService) {
        this.entityService = entityService;
        this.knowledgeService = knowledgeService;
        this.linkService = linkService;
        this.graphService = graphService;
        this.contradictionService = contradictionService;
        this.summaryService = summaryService;
        this.dataSourceService = dataSourceService;
        this.graphQueryService = graphQueryService;
        this.sqlValidationService = sqlValidationService;
        this.chatService = chatService;
    }

    @GetMapping("/graph/nodes")
    public BaseResp<List<WikiGraphService.GraphNode>> getGraphNodes() {
        BaseResp<List<WikiGraphService.GraphNode>> resp = new BaseResp<>();
        try {
            List<WikiGraphService.GraphNode> nodes = graphService.getGraphNodes();
            resp.setSuccess(true);
            resp.setData(nodes);
            resp.setMessage("Get graph nodes successfully");
        } catch (Exception e) {
            log.error("Failed to get graph nodes", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get graph nodes: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/graph/edges")
    public BaseResp<List<WikiGraphService.GraphEdge>> getGraphEdges() {
        BaseResp<List<WikiGraphService.GraphEdge>> resp = new BaseResp<>();
        try {
            List<WikiGraphService.GraphEdge> edges = graphService.getGraphEdges();
            resp.setSuccess(true);
            resp.setData(edges);
            resp.setMessage("Get graph edges successfully");
        } catch (Exception e) {
            log.error("Failed to get graph edges", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get graph edges: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/graph/nodes/lazy")
    public BaseResp<List<WikiGraphService.GraphNode>> getLazyNodes(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) String parentId) {
        BaseResp<List<WikiGraphService.GraphNode>> resp = new BaseResp<>();
        try {
            log.info("getLazyNodes called with type=[{}], parentId=[{}]", type, parentId);
            List<WikiGraphService.GraphNode> nodes = graphService.getChildNodes(type, parentId);
            log.info("getLazyNodes returning {} nodes", nodes.size());
            resp.setSuccess(true);
            resp.setData(nodes);
            resp.setMessage("Get lazy nodes successfully");
        } catch (Exception e) {
            log.error("Failed to get lazy nodes", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get lazy nodes: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/graph/edges/lazy")
    public BaseResp<List<WikiGraphService.GraphEdge>> getLazyEdges(
            @RequestParam(required = false) String nodeIds) {
        BaseResp<List<WikiGraphService.GraphEdge>> resp = new BaseResp<>();
        try {
            List<String> idList =
                    nodeIds != null && !nodeIds.isEmpty() ? Arrays.asList(nodeIds.split(","))
                            : new ArrayList<>();
            List<WikiGraphService.GraphEdge> edges = graphService.getEdgesByNodeIds(idList);
            resp.setSuccess(true);
            resp.setData(edges);
            resp.setMessage("Get lazy edges successfully");
        } catch (Exception e) {
            log.error("Failed to get lazy edges", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get lazy edges: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/graph/entity/{entityId}/neighbors")
    public BaseResp<Map<String, Object>> getEntityNeighbors(@PathVariable String entityId,
            @RequestParam(defaultValue = "1") int depth) {
        BaseResp<Map<String, Object>> resp = new BaseResp<>();
        try {
            Map<String, Object> graphData = graphService.getEntityGraphData(entityId);
            resp.setSuccess(true);
            resp.setData(graphData);
            resp.setMessage("Get entity neighbors successfully");
        } catch (Exception e) {
            log.error("Failed to get entity neighbors for entityId: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get entity neighbors: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/entities")
    public BaseResp<List<WikiEntity>> getEntities(@RequestParam(required = false) String type,
            @RequestParam(required = false) String topicId) {
        BaseResp<List<WikiEntity>> resp = new BaseResp<>();
        try {
            List<WikiEntity> entities;
            if (type != null && !type.isEmpty()) {
                entities = entityService.getEntitiesByType(type);
            } else if (topicId != null && !topicId.isEmpty()) {
                entities = entityService.getEntitiesByTopic(topicId);
            } else {
                entities = entityService.getAllActiveEntities();
            }
            resp.setSuccess(true);
            resp.setData(entities);
            resp.setMessage("Get entities successfully");
        } catch (Exception e) {
            log.error("Failed to get entities", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get entities: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/entities/{entityId}")
    public BaseResp<WikiEntity> getEntity(@PathVariable String entityId) {
        BaseResp<WikiEntity> resp = new BaseResp<>();
        try {
            WikiEntity entity = entityService.getEntityById(entityId);
            if (entity != null) {
                resp.setSuccess(true);
                resp.setData(entity);
                resp.setMessage("Get entity successfully");
            } else {
                resp.setSuccess(false);
                resp.setMessage("Entity not found: " + entityId);
            }
        } catch (Exception e) {
            log.error("Failed to get entity: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get entity: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/entities")
    public BaseResp<WikiEntity> createEntity(@RequestBody WikiEntity entity) {
        BaseResp<WikiEntity> resp = new BaseResp<>();
        try {
            WikiEntity created = entityService.createEntity(entity);
            resp.setSuccess(true);
            resp.setData(created);
            resp.setMessage("Create entity successfully");
        } catch (Exception e) {
            log.error("Failed to create entity", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to create entity: " + e.getMessage());
        }
        return resp;
    }

    @PutMapping("/entities/{entityId}")
    public BaseResp<WikiEntity> updateEntity(@PathVariable String entityId,
            @RequestBody WikiEntity entity) {
        BaseResp<WikiEntity> resp = new BaseResp<>();
        try {
            entity.setEntityId(entityId);
            WikiEntity updated = entityService.updateEntity(entity);
            resp.setSuccess(true);
            resp.setData(updated);
            resp.setMessage("Update entity successfully");
        } catch (Exception e) {
            log.error("Failed to update entity: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to update entity: " + e.getMessage());
        }
        return resp;
    }

    @DeleteMapping("/entities/{entityId}")
    public BaseResp<Void> deleteEntity(@PathVariable String entityId) {
        BaseResp<Void> resp = new BaseResp<>();
        try {
            // Cascade delete: first delete child entities (columns), then the parent (table)
            List<WikiEntity> childEntities = entityService.getChildEntities(entityId);
            for (WikiEntity child : childEntities) {
                knowledgeService.deleteCardsByEntityId(child.getEntityId());
                linkService.deleteLinksByEntityId(child.getEntityId());
                entityService.deleteEntity(child.getEntityId());
            }
            // Delete parent's knowledge cards and links
            knowledgeService.deleteCardsByEntityId(entityId);
            linkService.deleteLinksByEntityId(entityId);
            // Delete the entity itself
            entityService.deleteEntity(entityId);
            resp.setSuccess(true);
            resp.setMessage("Delete entity successfully");
        } catch (Exception e) {
            log.error("Failed to delete entity: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to delete entity: " + e.getMessage());
        }
        return resp;
    }

    // Entity-Topic association endpoints
    @PostMapping("/entities/{entityId}/topics/{topicId}")
    public BaseResp<Void> addTopicToEntity(@PathVariable String entityId,
            @PathVariable String topicId) {
        BaseResp<Void> resp = new BaseResp<>();
        try {
            entityService.addTopicToEntity(entityId, topicId);
            resp.setSuccess(true);
            resp.setMessage("Add topic to entity successfully");
        } catch (Exception e) {
            log.error("Failed to add topic to entity: {} - {}", entityId, topicId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to add topic to entity: " + e.getMessage());
        }
        return resp;
    }

    @DeleteMapping("/entities/{entityId}/topics/{topicId}")
    public BaseResp<Void> removeTopicFromEntity(@PathVariable String entityId,
            @PathVariable String topicId) {
        BaseResp<Void> resp = new BaseResp<>();
        try {
            entityService.removeTopicFromEntity(entityId, topicId);
            resp.setSuccess(true);
            resp.setMessage("Remove topic from entity successfully");
        } catch (Exception e) {
            log.error("Failed to remove topic from entity: {} - {}", entityId, topicId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to remove topic from entity: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/entities/{entityId}/children")
    public BaseResp<List<WikiEntity>> getEntityChildren(@PathVariable String entityId) {
        BaseResp<List<WikiEntity>> resp = new BaseResp<>();
        try {
            List<WikiEntity> children = entityService.getChildEntities(entityId);
            resp.setSuccess(true);
            resp.setData(children);
            resp.setMessage("Get entity children successfully");
        } catch (Exception e) {
            log.error("Failed to get entity children for entityId: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get entity children: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/entities/{entityId}/topics")
    public BaseResp<List<String>> getEntityTopics(@PathVariable String entityId) {
        BaseResp<List<String>> resp = new BaseResp<>();
        try {
            List<String> topicIds = entityService.getTopicIdsByEntityId(entityId);
            resp.setSuccess(true);
            resp.setData(topicIds);
            resp.setMessage("Get entity topics successfully");
        } catch (Exception e) {
            log.error("Failed to get entity topics: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get entity topics: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/knowledge")
    public BaseResp<Map<String, Object>> getKnowledgeCards(
            @RequestParam(required = false) String entityId,
            @RequestParam(required = false) String cardType,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(defaultValue = "10") int pageSize) {
        BaseResp<Map<String, Object>> resp = new BaseResp<>();
        try {
            List<WikiKnowledgeCard> cards;
            int total = 0;
            if (entityId != null && !entityId.isEmpty()) {
                total = knowledgeService.countCardsByEntityId(entityId);
                if (total > 0) {
                    cards = knowledgeService.getCardsByEntityIdPaginated(entityId, page, pageSize);
                } else {
                    cards = List.of();
                }
            } else if (cardType != null && !cardType.isEmpty()) {
                cards = knowledgeService.getCardsByType(cardType);
            } else {
                cards = List.of();
            }
            Map<String, Object> result = new HashMap<>();
            result.put("cards", cards);
            result.put("total", total);
            result.put("page", page);
            result.put("pageSize", pageSize);
            resp.setSuccess(true);
            resp.setData(result);
            resp.setMessage("Get knowledge cards successfully");
        } catch (Exception e) {
            log.error("Failed to get knowledge cards", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get knowledge cards: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/knowledge/{cardId}")
    public BaseResp<WikiKnowledgeCard> getKnowledgeCard(@PathVariable String cardId) {
        BaseResp<WikiKnowledgeCard> resp = new BaseResp<>();
        try {
            WikiKnowledgeCard card = knowledgeService.getCardById(cardId);
            if (card != null) {
                resp.setSuccess(true);
                resp.setData(card);
                resp.setMessage("Get knowledge card successfully");
            } else {
                resp.setSuccess(false);
                resp.setMessage("Knowledge card not found: " + cardId);
            }
        } catch (Exception e) {
            log.error("Failed to get knowledge card: {}", cardId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get knowledge card: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/knowledge")
    public BaseResp<WikiKnowledgeCard> createKnowledgeCard(@RequestBody WikiKnowledgeCard card) {
        BaseResp<WikiKnowledgeCard> resp = new BaseResp<>();
        try {
            WikiKnowledgeCard created = knowledgeService.createCard(card);
            resp.setSuccess(true);
            resp.setData(created);
            resp.setMessage("Create knowledge card successfully");
        } catch (Exception e) {
            log.error("Failed to create knowledge card", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to create knowledge card: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/knowledge/generate")
    public BaseResp<KnowledgeCardGenerateResp> generateKnowledgeCard(
            @RequestBody KnowledgeCardGenerateReq req) {
        BaseResp<KnowledgeCardGenerateResp> resp = new BaseResp<>();
        try {
            if (req.getEntityId() == null || req.getEntityId().isEmpty()) {
                resp.setSuccess(false);
                resp.setMessage("entityId is required");
                return resp;
            }
            KnowledgeCardGenerateResp result = knowledgeService.generateKnowledgeCard(req);
            if (result == null) {
                resp.setSuccess(false);
                resp.setMessage("Failed to generate knowledge card");
            } else {
                resp.setSuccess(true);
                resp.setData(result);
                resp.setMessage("Generate successfully");
            }
        } catch (Exception e) {
            log.error("Failed to generate knowledge card", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to generate knowledge card: " + e.getMessage());
        }
        return resp;
    }

    @PutMapping("/knowledge/{cardId}")
    public BaseResp<WikiKnowledgeCard> updateKnowledgeCard(@PathVariable String cardId,
            @RequestBody WikiKnowledgeCard card) {
        BaseResp<WikiKnowledgeCard> resp = new BaseResp<>();
        try {
            card.setCardId(cardId);
            WikiKnowledgeCard updated = knowledgeService.updateCard(card);
            resp.setSuccess(true);
            resp.setData(updated);
            resp.setMessage("Update knowledge card successfully");
        } catch (Exception e) {
            log.error("Failed to update knowledge card: {}", cardId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to update knowledge card: " + e.getMessage());
        }
        return resp;
    }

    @DeleteMapping("/knowledge/{cardId}")
    public BaseResp<Void> deleteKnowledgeCard(@PathVariable String cardId) {
        BaseResp<Void> resp = new BaseResp<>();
        try {
            knowledgeService.deleteCard(cardId);
            resp.setSuccess(true);
            resp.setMessage("Delete knowledge card successfully");
        } catch (Exception e) {
            log.error("Failed to delete knowledge card: {}", cardId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to delete knowledge card: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/links")
    public BaseResp<List<WikiLink>> getLinks(@RequestParam(required = false) String entityId) {
        BaseResp<List<WikiLink>> resp = new BaseResp<>();
        try {
            List<WikiLink> links;
            if (entityId != null && !entityId.isEmpty()) {
                links = linkService.getLinksByEntity(entityId);
            } else {
                links = linkService.getAllLinks();
            }
            resp.setSuccess(true);
            resp.setData(links);
            resp.setMessage("Get links successfully");
        } catch (Exception e) {
            log.error("Failed to get links", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get links: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/links")
    public BaseResp<WikiLink> createLink(@RequestBody WikiLink link) {
        BaseResp<WikiLink> resp = new BaseResp<>();
        try {
            WikiLink created = linkService.createLink(link);
            resp.setSuccess(true);
            resp.setData(created);
            resp.setMessage("Create link successfully");
        } catch (Exception e) {
            log.error("Failed to create link", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to create link: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/contradictions")
    public BaseResp<List<Contradiction>> getContradictions(
            @RequestParam(required = false) String entityId,
            @RequestParam(required = false) String status) {
        BaseResp<List<Contradiction>> resp = new BaseResp<>();
        try {
            List<Contradiction> contradictions;
            if (entityId != null && !entityId.isEmpty()) {
                contradictions = contradictionService.getContradictionsByEntityId(entityId);
            } else if (status != null && !status.isEmpty()) {
                contradictions = contradictionService.getContradictionsByStatus(status);
            } else {
                contradictions = contradictionService.getAllContradictions();
            }
            resp.setSuccess(true);
            resp.setData(contradictions);
            resp.setMessage("Get contradictions successfully");
        } catch (Exception e) {
            log.error("Failed to get contradictions", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get contradictions: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/contradictions/pending")
    public BaseResp<List<Contradiction>> getPendingContradictions() {
        BaseResp<List<Contradiction>> resp = new BaseResp<>();
        try {
            List<Contradiction> contradictions = contradictionService.getPendingContradictions();
            resp.setSuccess(true);
            resp.setData(contradictions);
            resp.setMessage("Get pending contradictions successfully");
        } catch (Exception e) {
            log.error("Failed to get pending contradictions", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get pending contradictions: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/contradictions/{contradictionId}")
    public BaseResp<Contradiction> getContradiction(@PathVariable String contradictionId) {
        BaseResp<Contradiction> resp = new BaseResp<>();
        try {
            Contradiction contradiction =
                    contradictionService.getContradictionById(contradictionId);
            if (contradiction != null) {
                resp.setSuccess(true);
                resp.setData(contradiction);
                resp.setMessage("Get contradiction successfully");
            } else {
                resp.setSuccess(false);
                resp.setMessage("Contradiction not found: " + contradictionId);
            }
        } catch (Exception e) {
            log.error("Failed to get contradiction: {}", contradictionId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get contradiction: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/contradictions")
    public BaseResp<Contradiction> createContradiction(@RequestBody Contradiction contradiction) {
        BaseResp<Contradiction> resp = new BaseResp<>();
        try {
            Contradiction created = contradictionService.createContradiction(contradiction);
            resp.setSuccess(true);
            resp.setData(created);
            resp.setMessage("Create contradiction successfully");
        } catch (Exception e) {
            log.error("Failed to create contradiction", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to create contradiction: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/contradictions/{contradictionId}/resolve")
    public BaseResp<Contradiction> resolveContradiction(@PathVariable String contradictionId,
            @RequestBody ResolveReq req) {
        BaseResp<Contradiction> resp = new BaseResp<>();
        try {
            Contradiction resolved = contradictionService.resolveContradiction(contradictionId,
                    req.getResolution(), req.getResolvedBy(), req.getResolutionNotes());
            resp.setSuccess(true);
            resp.setData(resolved);
            resp.setMessage("Contradiction resolved successfully");
        } catch (Exception e) {
            log.error("Failed to resolve contradiction: {}", contradictionId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to resolve contradiction: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/summaries")
    public BaseResp<List<TopicSummary>> getSummaries() {
        BaseResp<List<TopicSummary>> resp = new BaseResp<>();
        try {
            List<TopicSummary> summaries = summaryService.getAllActiveSummaries();
            resp.setSuccess(true);
            resp.setData(summaries);
            resp.setMessage("Get summaries successfully");
        } catch (Exception e) {
            log.error("Failed to get summaries", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get summaries: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/summaries/{topicId}")
    public BaseResp<TopicSummary> getSummary(@PathVariable String topicId) {
        BaseResp<TopicSummary> resp = new BaseResp<>();
        try {
            TopicSummary summary = summaryService.getSummaryByTopicId(topicId);
            if (summary != null) {
                resp.setSuccess(true);
                resp.setData(summary);
                resp.setMessage("Get summary successfully");
            } else {
                resp.setSuccess(false);
                resp.setMessage("Summary not found for topic: " + topicId);
            }
        } catch (Exception e) {
            log.error("Failed to get summary for topic: {}", topicId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get summary: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/summaries/{topicId}/history")
    public BaseResp<List<TopicSummary>> getSummaryHistory(@PathVariable String topicId) {
        BaseResp<List<TopicSummary>> resp = new BaseResp<>();
        try {
            List<TopicSummary> history = summaryService.getVersionHistory(topicId);
            resp.setSuccess(true);
            resp.setData(history);
            resp.setMessage("Get summary history successfully");
        } catch (Exception e) {
            log.error("Failed to get summary history for topic: {}", topicId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get summary history: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/summaries/{topicId}/refresh")
    public BaseResp<TopicSummary> refreshSummary(@PathVariable String topicId) {
        BaseResp<TopicSummary> resp = new BaseResp<>();
        try {
            TopicSummary summary = summaryService.generateSummary(topicId);
            if (summary != null) {
                resp.setSuccess(true);
                resp.setData(summary);
                resp.setMessage("Summary refreshed successfully");
            } else {
                resp.setSuccess(false);
                resp.setMessage("No entities found for topic: " + topicId);
            }
        } catch (Exception e) {
            log.error("Failed to refresh summary for topic: {}", topicId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to refresh summary: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/summaries/refresh-all")
    public BaseResp<List<TopicSummary>> refreshAllSummaries() {
        BaseResp<List<TopicSummary>> resp = new BaseResp<>();
        try {
            List<TopicSummary> summaries = summaryService.refreshAllSummaries();
            resp.setSuccess(true);
            resp.setData(summaries);
            resp.setMessage("All summaries refreshed successfully");
        } catch (Exception e) {
            log.error("Failed to refresh all summaries", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to refresh all summaries: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/datasources")
    public BaseResp<List<DataSourceConfig>> getDataSources() {
        BaseResp<List<DataSourceConfig>> resp = new BaseResp<>();
        try {
            List<DataSourceConfig> dataSources = dataSourceService.list();
            resp.setSuccess(true);
            resp.setData(dataSources);
            resp.setMessage("Get datasources successfully");
        } catch (Exception e) {
            log.error("Failed to get datasources", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get datasources: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/datasources/{id}")
    public BaseResp<DataSourceConfig> getDataSource(@PathVariable Long id) {
        BaseResp<DataSourceConfig> resp = new BaseResp<>();
        try {
            DataSourceConfig dataSource = dataSourceService.getById(id);
            if (dataSource != null) {
                resp.setSuccess(true);
                resp.setData(dataSource);
                resp.setMessage("Get datasource successfully");
            } else {
                resp.setSuccess(false);
                resp.setMessage("Datasource not found: " + id);
            }
        } catch (Exception e) {
            log.error("Failed to get datasource: {}", id, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get datasource: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/datasources")
    public BaseResp<DataSourceConfig> createDataSource(@RequestBody DataSourceConfig config) {
        BaseResp<DataSourceConfig> resp = new BaseResp<>();
        try {
            DataSourceConfig created = dataSourceService.create(config);
            resp.setSuccess(true);
            resp.setData(created);
            resp.setMessage("Create datasource successfully");
        } catch (Exception e) {
            log.error("Failed to create datasource", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to create datasource: " + e.getMessage());
        }
        return resp;
    }

    @PutMapping("/datasources/{id}")
    public BaseResp<DataSourceConfig> updateDataSource(@PathVariable Long id,
            @RequestBody DataSourceConfig config) {
        BaseResp<DataSourceConfig> resp = new BaseResp<>();
        try {
            config.setId(id);
            DataSourceConfig updated = dataSourceService.update(config);
            resp.setSuccess(true);
            resp.setData(updated);
            resp.setMessage("Update datasource successfully");
        } catch (Exception e) {
            log.error("Failed to update datasource: {}", id, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to update datasource: " + e.getMessage());
        }
        return resp;
    }

    @DeleteMapping("/datasources/{id}")
    public BaseResp<Void> deleteDataSource(@PathVariable Long id) {
        BaseResp<Void> resp = new BaseResp<>();
        try {
            dataSourceService.delete(id);
            resp.setSuccess(true);
            resp.setMessage("Delete datasource successfully");
        } catch (Exception e) {
            log.error("Failed to delete datasource: {}", id, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to delete datasource: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/datasources/{id}/test")
    public BaseResp<Boolean> testDataSource(@PathVariable Long id) {
        BaseResp<Boolean> resp = new BaseResp<>();
        try {
            boolean success = dataSourceService.testConnection(id);
            resp.setSuccess(true);
            resp.setData(success);
            resp.setMessage(success ? "Connection test successful" : "Connection test failed");
        } catch (Exception e) {
            log.error("Failed to test datasource: {}", id, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to test datasource: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/datasources/{id}/parse-schema")
    public BaseResp<List<TableSchema>> parseDataSourceSchema(@PathVariable Long id) {
        BaseResp<List<TableSchema>> resp = new BaseResp<>();
        try {
            List<TableSchema> tables = dataSourceService.parseSchemaFromSource(id);
            resp.setSuccess(true);
            resp.setData(tables);
            resp.setMessage("Parse schema successfully");
        } catch (Exception e) {
            log.error("Failed to parse datasource schema: {}", id, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to parse schema: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/graph/path")
    public BaseResp<WikiGraphQueryService.PathResult> findShortestPath(@RequestParam String from,
            @RequestParam String to) {
        BaseResp<WikiGraphQueryService.PathResult> resp = new BaseResp<>();
        try {
            WikiGraphQueryService.PathResult result = graphQueryService.findShortestPath(from, to);
            resp.setSuccess(true);
            resp.setData(result);
            resp.setMessage(result.getMessage());
        } catch (Exception e) {
            log.error("Failed to find shortest path from {} to {}", from, to, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to find path: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/graph/neighbors/{entityId}")
    public BaseResp<WikiGraphQueryService.NeighborResult> findNeighbors(
            @PathVariable String entityId, @RequestParam(defaultValue = "2") int depth) {
        BaseResp<WikiGraphQueryService.NeighborResult> resp = new BaseResp<>();
        try {
            WikiGraphQueryService.NeighborResult result =
                    graphQueryService.findNeighbors(entityId, depth);
            resp.setSuccess(true);
            resp.setData(result);
            resp.setMessage(result.getMessage());
        } catch (Exception e) {
            log.error("Failed to find neighbors for entity: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to find neighbors: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/graph/query")
    public BaseResp<WikiGraphQueryService.GraphQueryResult> executeGraphQuery(
            @RequestBody Map<String, String> request) {
        BaseResp<WikiGraphQueryService.GraphQueryResult> resp = new BaseResp<>();
        try {
            String query = request.get("query");
            WikiGraphQueryService.GraphQueryResult result = graphQueryService.query(query);
            resp.setSuccess(result.isSuccess());
            resp.setData(result);
            resp.setMessage(result.getMessage());
        } catch (Exception e) {
            log.error("Failed to execute graph query", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to execute graph query: " + e.getMessage());
        }
        return resp;
    }

    @PostMapping("/sql/validate")
    public BaseResp<WikiSqlValidationService.ValidationResult> validateSql(
            @RequestBody ValidateSqlReq req) {
        BaseResp<WikiSqlValidationService.ValidationResult> resp = new BaseResp<>();
        try {
            WikiSqlValidationService.ValidationResult result =
                    sqlValidationService.validate(req.getSql(), req.getEntityId());
            resp.setSuccess(true);
            resp.setData(result);
            resp.setMessage(result.getMessage());
        } catch (Exception e) {
            log.error("Failed to validate SQL", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to validate SQL: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/sql/history/{entityId}")
    public BaseResp<List<WikiSqlValidationService.ValidationResult>> getSqlValidationHistory(
            @PathVariable String entityId) {
        BaseResp<List<WikiSqlValidationService.ValidationResult>> resp = new BaseResp<>();
        try {
            List<WikiSqlValidationService.ValidationResult> history =
                    sqlValidationService.getHistory(entityId);
            resp.setSuccess(true);
            resp.setData(history);
            resp.setMessage("Get validation history successfully");
        } catch (Exception e) {
            log.error("Failed to get validation history for entity: {}", entityId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get validation history: " + e.getMessage());
        }
        return resp;
    }

    @Data
    public static class ResolveReq {
        private String resolution;
        private String resolvedBy;
        private String resolutionNotes;
    }

    @PostMapping("/chat")
    public BaseResp<WikiChatService.ChatResponse> chat(@RequestBody ChatReq req) {
        BaseResp<WikiChatService.ChatResponse> resp = new BaseResp<>();
        try {
            WikiChatService.ChatResponse chatResp =
                    chatService.chat(req.getUserId(), req.getMessage(), req.getConversationId());
            resp.setSuccess(true);
            resp.setData(chatResp);
            resp.setMessage("Chat processed successfully");
        } catch (Exception e) {
            log.error("Failed to process chat", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to process chat: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/chat/history/{conversationId}")
    public BaseResp<List<ChatMessage>> getChatHistory(@PathVariable String conversationId) {
        BaseResp<List<ChatMessage>> resp = new BaseResp<>();
        try {
            List<ChatMessage> history = chatService.getHistory(conversationId);
            resp.setSuccess(true);
            resp.setData(history);
            resp.setMessage("Get chat history successfully");
        } catch (Exception e) {
            log.error("Failed to get chat history for conversation: {}", conversationId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get chat history: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/chat/recent")
    public BaseResp<List<ChatMessage>> getRecentChats(@RequestParam String userId,
            @RequestParam(defaultValue = "10") int limit) {
        BaseResp<List<ChatMessage>> resp = new BaseResp<>();
        try {
            List<ChatMessage> history = chatService.getRecentHistory(userId, limit);
            resp.setSuccess(true);
            resp.setData(history);
            resp.setMessage("Get recent chats successfully");
        } catch (Exception e) {
            log.error("Failed to get recent chats for user: {}", userId, e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get recent chats: " + e.getMessage());
        }
        return resp;
    }

    // ==================== Knowledge Card Management ====================

    @GetMapping("/knowledge/search")
    public BaseResp<List<WikiKnowledgeCard>> searchKnowledge(@RequestParam String query,
            @RequestParam(defaultValue = "10") int topK) {
        BaseResp<List<WikiKnowledgeCard>> resp = new BaseResp<>();
        try {
            List<WikiKnowledgeCard> cards = knowledgeService.searchKnowledge(query, topK);
            resp.setSuccess(true);
            resp.setData(cards);
            resp.setMessage("Search knowledge cards successfully");
        } catch (Exception e) {
            log.error("Failed to search knowledge cards", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to search knowledge cards: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/knowledge/stats")
    public BaseResp<KnowledgeStats> getKnowledgeStats() {
        BaseResp<KnowledgeStats> resp = new BaseResp<>();
        try {
            KnowledgeStats stats = new KnowledgeStats();
            stats.setTotalCards(knowledgeService.countActiveCards());
            stats.setAvgConfidence(knowledgeService.getAvgConfidence());
            stats.setCardsByType(knowledgeService.countByType());
            resp.setSuccess(true);
            resp.setData(stats);
            resp.setMessage("Get knowledge stats successfully");
        } catch (Exception e) {
            log.error("Failed to get knowledge stats", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get knowledge stats: " + e.getMessage());
        }
        return resp;
    }

    @GetMapping("/knowledge/compounding-trend")
    public BaseResp<CompoundingTrend> getCompoundingTrend(
            @RequestParam(defaultValue = "30") int days) {
        BaseResp<CompoundingTrend> resp = new BaseResp<>();
        try {
            List<Map<String, Object>> rawTrend = knowledgeService.getCompoundingTrend(days);
            CompoundingTrend trend = new CompoundingTrend();
            trend.setDays(days);
            List<TrendPoint> points = new ArrayList<>();
            for (Map<String, Object> row : rawTrend) {
                TrendPoint point = new TrendPoint();
                point.setDate(row.get("date") != null ? row.get("date").toString() : "");
                Object successCount = row.get("success_count");
                point.setUsageCount(successCount != null ? ((Number) successCount).intValue() : 0);
                Object avgConf = row.get("avg_confidence");
                point.setAvgConfidence(avgConf != null ? ((Number) avgConf).doubleValue() : null);
                points.add(point);
            }
            trend.setTrendPoints(points);
            resp.setSuccess(true);
            resp.setData(trend);
            resp.setMessage("Get compounding trend successfully");
        } catch (Exception e) {
            log.error("Failed to get compounding trend", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get compounding trend: " + e.getMessage());
        }
        return resp;
    }

    @Data
    public static class KnowledgeStats {
        private Long totalCards;
        private Double avgConfidence;
        private Map<String, Long> cardsByType;
    }

    @Data
    public static class CompoundingTrend {
        private Integer days;
        private List<TrendPoint> trendPoints;
    }

    @Data
    public static class TrendPoint {
        private String date;
        private Integer usageCount;
        private Double avgConfidence;
    }

    @Data
    public static class ValidateSqlReq {
        private String sql;
        private String entityId;
    }

    @Data
    public static class ChatReq {
        private String userId;
        private String message;
        private String conversationId;
    }

    @Data
    public static class BaseResp<T> {
        private boolean success;
        private String message;
        private T data;

        public void setSuccess(boolean success) {
            this.success = success;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public void setData(T data) {
            this.data = data;
        }
    }
}
