package com.tencent.supersonic.text2sql;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/text2sql")
@Slf4j
public class Text2SqlController {

    @Autowired
    private Text2SqlService text2SqlService;

    @Autowired
    private SchemaKnowledgeService schemaKnowledgeService;

    @PostMapping("/convert")
    public Text2SqlResp convert(@RequestBody Text2SqlReq req) {
        log.info("Received Text-to-SQL request: {}", req.getQuestion());
        Text2SqlResp resp = text2SqlService.convert(req);
        log.info("Generated SQL: {}", resp.getSql());
        return resp;
    }

    @PostMapping("/knowledge/build")
    public KnowledgeBuildResp buildKnowledge(@RequestBody KnowledgeBuildReq req) {
        log.info("Received knowledge build request: {}", req);

        KnowledgeBuildResp resp = new KnowledgeBuildResp();
        try {
            int columnCount = schemaKnowledgeService.buildKnowledgeBase(req.getSqlFilePath(),
                    req.getTargetTables(), req.getDatabaseType(), req.getSqlContent());

            resp.setSuccess(true);
            resp.setKnowledgeCount(columnCount);
            resp.setMessage("Knowledge base built successfully");
            log.info("Knowledge base built successfully with {} columns", columnCount);
        } catch (Exception e) {
            log.error("Failed to build knowledge base", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to build knowledge base: " + e.getMessage());
        }

        return resp;
    }

    @PostMapping("/parse")
    public ParseSqlResp parseSqlFile(@RequestBody ParseSqlReq req) {
        log.info("Received parse SQL file request: {}, databaseType: {}", req.getSqlFilePath(),
                req.getDatabaseType());

        ParseSqlResp resp = new ParseSqlResp();
        try {
            List<SchemaKnowledgeService.TableSchemaInfo> tables =
                    schemaKnowledgeService.parseSqlFileOnly(req.getSqlFilePath(),
                            req.getDatabaseType(), req.getSqlContent());

            resp.setSuccess(true);
            resp.setTables(tables);
            resp.setDatabaseType(req.getDatabaseType());
            resp.setMessage("Parse successfully");
            log.info("Parse SQL file successfully, found {} tables", tables.size());
        } catch (Exception e) {
            log.error("Failed to parse SQL file", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to parse SQL file: " + e.getMessage());
        }

        return resp;
    }

    @PostMapping("/knowledge/search")
    public SearchKnowledgeResp searchKnowledge(@RequestBody SearchKnowledgeReq req) {
        log.info("Received search knowledge request: {}", req.getQuery());

        SearchKnowledgeResp resp = new SearchKnowledgeResp();
        try {
            List<SchemaKnowledge> results =
                    schemaKnowledgeService.searchSimilar(req.getQuery(), req.getTopK());

            resp.setSuccess(true);
            resp.setResults(results);
            resp.setMessage("Search successfully");
            log.info("Search knowledge successfully, found {} results", results.size());
        } catch (Exception e) {
            log.error("Failed to search knowledge", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to search knowledge: " + e.getMessage());
        }

        return resp;
    }

    @GetMapping("/knowledge/stats")
    public KnowledgeStatsResp getKnowledgeStats() {
        log.info("Received get knowledge stats request");

        KnowledgeStatsResp resp = new KnowledgeStatsResp();
        try {
            Map<String, Object> stats = schemaKnowledgeService.getKnowledgeStats();

            resp.setSuccess(true);
            resp.setStats(stats);
            resp.setMessage("Get stats successfully");
        } catch (Exception e) {
            log.error("Failed to get knowledge stats", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to get knowledge stats: " + e.getMessage());
        }

        return resp;
    }

    @DeleteMapping("/knowledge/clear")
    public BaseResp clearKnowledge() {
        log.info("Received clear knowledge request");

        BaseResp resp = new BaseResp();
        try {
            schemaKnowledgeService.clearKnowledge();

            resp.setSuccess(true);
            resp.setMessage("Knowledge base cleared successfully");
            log.info("Knowledge base cleared successfully");
        } catch (Exception e) {
            log.error("Failed to clear knowledge base", e);
            resp.setSuccess(false);
            resp.setMessage("Failed to clear knowledge base: " + e.getMessage());
        }

        return resp;
    }
}
