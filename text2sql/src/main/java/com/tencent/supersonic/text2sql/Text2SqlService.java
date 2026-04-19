package com.tencent.supersonic.text2sql;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class Text2SqlService {

    @Autowired
    private SchemaKnowledgeService schemaKnowledgeService;

    @Autowired
    private SqlGenerationService sqlGenerationService;

    public Text2SqlResp convert(Text2SqlReq req) {
        Text2SqlResp resp = new Text2SqlResp();
        resp.setQuestion(req.getQuestion());

        int topK = req.getTopK() != null ? req.getTopK() : 5;

        try {
            List<SchemaKnowledge> schemas =
                    schemaKnowledgeService.searchSimilar(req.getQuestion(), topK);
            resp.setSchemas(schemas);

            if (schemas.isEmpty()) {
                resp.setValid(false);
                resp.setErrorMessage("No relevant schema found for the question");
                resp.setSql("-- No relevant schema found");
                return resp;
            }

            String sql = sqlGenerationService.generateSql(req.getQuestion(), topK,
                    schemaKnowledgeService);
            resp.setSql(sql);

            if (sql.startsWith("--")) {
                resp.setValid(false);
                resp.setErrorMessage(sql);
            } else {
                resp.setValid(true);
            }

        } catch (Exception e) {
            log.error("Error converting question to SQL: {}", req.getQuestion(), e);
            resp.setValid(false);
            resp.setErrorMessage("Error: " + e.getMessage());
            resp.setSql("-- Error: " + e.getMessage());
        }

        return resp;
    }
}
