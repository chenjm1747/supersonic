package com.tencent.supersonic.headless.core.text2sql;

import com.tencent.supersonic.headless.core.text2sql.dto.Text2SqlRequest;
import com.tencent.supersonic.headless.core.text2sql.dto.Text2SqlResponse;
import com.tencent.supersonic.headless.core.text2sql.service.impl.DefaultText2SqlService;
import com.tencent.supersonic.headless.core.text2sql.service.impl.InMemorySchemaKnowledgeService;
import com.tencent.supersonic.headless.core.text2sql.utils.SqlFileParser;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

@Slf4j
public class Text2SqlServiceTest {

    private InMemorySchemaKnowledgeService schemaService;
    private DefaultText2SqlService text2SqlService;

    @BeforeEach
    public void setUp() {
        schemaService = new InMemorySchemaKnowledgeService();
        text2SqlService = new DefaultText2SqlService();

        String sqlFilePath = "e:\\trae\\supersonic\\sql\\charge_zbhx_20260303.sql";
        List<String> targetTables = Arrays.asList("customer", "sf_js_t", "pay_order");

        log.info("Initializing schema knowledge from: {}", sqlFilePath);
        schemaService.buildKnowledgeBase(sqlFilePath, targetTables);
        log.info("Schema knowledge initialized successfully");
    }

    @Test
    public void testConvertQuery() {
        String question = "查询本采暖期欠费用户有哪些？";

        Text2SqlRequest request = new Text2SqlRequest();
        request.setQuestion(question);
        request.setTopK(5);

        Text2SqlResponse response = text2SqlService.convert(request);

        log.info("Question: {}", response.getQuestion());
        log.info("Generated SQL: {}", response.getSql());
        log.info("Valid: {}", response.getValid());
        if (response.getSchemas() != null) {
            log.info("Retrieved schemas count: {}", response.getSchemas().size());
        }
        if (response.getError() != null) {
            log.error("Error: {}", response.getError());
        }
    }

    @Test
    public void testQueryResidents() {
        String question = "查询所有居民用户";

        Text2SqlRequest request = new Text2SqlRequest();
        request.setQuestion(question);
        request.setTopK(3);

        Text2SqlResponse response = text2SqlService.convert(request);

        log.info("Question: {}", response.getQuestion());
        log.info("Generated SQL: {}", response.getSql());
        log.info("Valid: {}", response.getValid());
    }

    @Test
    public void testQueryPaymentRecords() {
        String question = "查询某个用户的缴费记录";

        Text2SqlRequest request = new Text2SqlRequest();
        request.setQuestion(question);
        request.setTopK(3);

        Text2SqlResponse response = text2SqlService.convert(request);

        log.info("Question: {}", response.getQuestion());
        log.info("Generated SQL: {}", response.getSql());
        log.info("Valid: {}", response.getValid());
    }
}
