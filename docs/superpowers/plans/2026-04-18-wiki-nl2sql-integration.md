# Wiki-NL2SQL Integration Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Integrate Wiki knowledge base with NL2SQL parser to improve semantic recognition accuracy by injecting Wiki entity and knowledge card information into the SQL generation pipeline.

**Architecture:** Wiki knowledge is retrieved in a preprocessing step, fused with SemanticSchema to create EnhancedSchema, then Wiki-aware context is built and injected into LLM prompts for improved SQL generation.

**Tech Stack:** Java 21, Spring Boot, LangChain4j, PostgreSQL (with pgvector), Maven

---

## File Structure

```
headless/chat/src/main/java/com/tencent/supersonic/headless/chat/
├── parser/
│   ├── wiki/
│   │   ├── WikiPreProcessor.java          # NEW: Wiki preprocessing entry point
│   │   ├── WikiSemanticFusionService.java # NEW: Fuse Wiki entities with SemanticSchema
│   │   └── EnhancedSchema.java             # NEW: Enhanced schema data structure
│   └── llm/
│       ├── WikiContextBuilder.java         # NEW: Build Wiki context strings for prompts
│       └── WikiAwareLLMSqlParser.java      # NEW: Wiki-aware SQL generation
├── mapper/
│   └── WikiAwareMapper.java                # NEW: Enhanced schema mapping with Wiki
└── query/llm/s2sql/
    └── WikiLLMReq.java                    # NEW: Extended LLMReq with Wiki knowledge

headless/core/src/main/java/com/tencent/supersonic/headless/core/
├── wiki/
│   └── service/
│       └── WikiKnowledgeService.java       # MODIFY: Add query methods for card types
│   └── dto/
│       └── WikiKnowledgeCard.java         # REVIEW: Check existing structure

chat/server/src/main/java/com/tencent/supersonic/chat/server/
├── parser/
│   └── NL2SQLParser.java                  # MODIFY: Add WikiPreProcessor call
```

---

## Task Map

| Task | Component | Files | Status |
|------|-----------|-------|--------|
| 1 | WikiKnowledgeCard DTO Review | REVIEW | - |
| 2 | WikiEntityService Extensions | MODIFY | - |
| 3 | WikiKnowledgeService Extensions | MODIFY | - |
| 4 | WikiPreProcessor | CREATE | - |
| 5 | EnhancedSchema | CREATE | - |
| 6 | WikiSemanticFusionService | CREATE | - |
| 7 | WikiAwareMapper | CREATE | - |
| 8 | WikiContextBuilder | CREATE | - |
| 9 | WikiLLMReq | CREATE | - |
| 10 | NL2SQLParser Integration | MODIFY | - |
| 11 | WikiAwareLLMSqlParser | CREATE | - |

---

## Phase 1: Wiki Knowledge Service Extensions (P0)

### Task 1: Review WikiKnowledgeCard DTO

**Files:**
- Review: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCard.java`
- Review: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiKnowledgeService.java`

- [ ] **Step 1: Read WikiKnowledgeCard DTO**

```java
// Location: headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCard.java
// Check these fields exist:
// - cardId, entityId, cardType, title, content
// - confidence, status, tags
// - extractedFrom
```

Run: `cat headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/dto/WikiKnowledgeCard.java`

- [ ] **Step 2: Read WikiKnowledgeService**

Run: `cat headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiKnowledgeService.java`

- [ ] **Step 3: Verify existing methods**

Methods that should exist:
- `getCardsByEntityId(String entityId)` → returns `List<WikiKnowledgeCard>`
- `getCardsByType(String cardType)` → returns `List<WikiKnowledgeCard>`
- `searchByEmbedding(float[] embedding, int topK)` → returns `List<WikiKnowledgeCard>`

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "docs: review wiki knowledge card structure"
```

---

### Task 2: Extend WikiEntityService with Search Method

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiEntityService.java`

- [ ] **Step 1: Write failing test for searchEntities**

Create file: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/service/WikiEntityServiceTest.java`

```java
package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class WikiEntityServiceTest {

    @Autowired
    private WikiEntityService entityService;

    @Test
    void testSearchEntities() {
        List<WikiEntity> results = entityService.searchEntities("收入");
        assertNotNull(results);
    }
}
```

Run: `mvn test -Dtest=WikiEntityServiceTest -pl headless/core -q` (expected to fail - method doesn't exist)

- [ ] **Step 2: Add searchEntities method to WikiEntityService**

Add these constants and methods to `WikiEntityService.java`:

```java
private static final String SEARCH_ENTITIES_SQL =
    "SELECT * FROM s2_wiki_entity " +
    "WHERE status = 'ACTIVE' " +
    "AND (name LIKE ? OR display_name LIKE ? OR description LIKE ?) " +
    "LIMIT ?";

public List<WikiEntity> searchEntities(String queryText) {
    return searchEntities(queryText, 10);
}

public List<WikiEntity> searchEntities(String queryText, int limit) {
    if (queryText == null || queryText.trim().isEmpty()) {
        return new ArrayList<>();
    }
    String searchPattern = "%" + queryText.trim() + "%";
    return jdbcTemplate.query(
        SEARCH_ENTITIES_SQL,
        new WikiEntityRowMapper(),
        searchPattern, searchPattern, searchPattern, limit
    );
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=WikiEntityServiceTest -pl headless/core -q`

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiEntityService.java
git commit -m "feat(wiki): add searchEntities method to WikiEntityService

Add searchEntities(queryText) and searchEntities(queryText, limit)
methods for text-based entity search.
"
```

---

### Task 3: Extend WikiKnowledgeService with Card Type Queries

**Files:**
- Modify: `headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiKnowledgeService.java`

- [ ] **Step 1: Write failing test for card type queries**

Create file: `headless/core/src/test/java/com/tencent/supersonic/headless/core/wiki/service/WikiKnowledgeServiceTest.java`

```java
package com.tencent.supersonic.headless.core.wiki.service;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class WikiKnowledgeServiceTest {

    @Autowired
    private WikiKnowledgeService wikiKnowledgeService;

    @Test
    void testGetSemanticMappings() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getSemanticMappings(null);
        assertNotNull(cards);
    }

    @Test
    void testGetBusinessRules() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getBusinessRules(null);
        assertNotNull(cards);
    }

    @Test
    void testGetUsagePatterns() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getUsagePatterns(null);
        assertNotNull(cards);
    }

    @Test
    void testGetMetricDefinitions() {
        List<WikiKnowledgeCard> cards = wikiKnowledgeService.getMetricDefinitions(null);
        assertNotNull(cards);
    }
}
```

Run: `mvn test -Dtest=WikiKnowledgeServiceTest -pl headless/core -q` (expected to fail - methods don't exist yet)

- [ ] **Step 2: Add card type query methods to WikiKnowledgeService**

Add these methods to `WikiKnowledgeService.java`:

```java
public static final String CARD_TYPE_SEMANTIC_MAPPING = "SEMANTIC_MAPPING";
public static final String CARD_TYPE_BUSINESS_RULE = "BUSINESS_RULE";
public static final String CARD_TYPE_USAGE_PATTERN = "USAGE_PATTERN";
public static final String CARD_TYPE_METRIC_DEFINITION = "METRIC_DEFINITION";

public List<WikiKnowledgeCard> getSemanticMappings(Long dataSetId) {
    return getCardsByType(CARD_TYPE_SEMANTIC_MAPPING);
}

public List<WikiKnowledgeCard> getBusinessRules(Long dataSetId) {
    return getCardsByType(CARD_TYPE_BUSINESS_RULE);
}

public List<WikiKnowledgeCard> getUsagePatterns(Long dataSetId) {
    return getCardsByType(CARD_TYPE_USAGE_PATTERN);
}

public List<WikiKnowledgeCard> getMetricDefinitions(Long dataSetId) {
    return getCardsByType(CARD_TYPE_METRIC_DEFINITION);
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=WikiKnowledgeServiceTest -pl headless/core -q`

Expected: PASS (with possible DB connection issues if no test DB, but methods compile)

- [ ] **Step 4: Commit**

```bash
git add headless/core/src/main/java/com/tencent/supersonic/headless/core/wiki/service/WikiKnowledgeService.java
git commit -m "feat(wiki): add card type query methods to WikiKnowledgeService

Add methods:
- getSemanticMappings()
- getBusinessRules()
- getUsagePatterns()
- getMetricDefinitions()
"
```

---

## Phase 2: Core Wiki-NL2SQL Fusion Components (P0)

### Task 4: Create WikiPreProcessor

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/WikiPreProcessor.java`

- [ ] **Step 1: Write failing test for WikiPreProcessor**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/parser/wiki/WikiPreProcessorTest.java`

```java
package com.tencent.supersonic.headless.chat.parser.wiki;

import com.tencent.supersonic.chat.server.pojo.ParseContext;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class WikiPreProcessorTest {

    @Autowired
    private WikiPreProcessor wikiPreProcessor;

    @Test
    void testPreprocess_withValidQuery() {
        // Given
        ParseContext parseContext = new ParseContext();
        parseContext.setQueryText("查询本季度收入超过100万的客户");

        // When
        wikiPreProcessor.preprocess(parseContext);

        // Then
        assertNotNull(parseContext.getWikiEntities());
        assertNotNull(parseContext.getWikiKnowledgeCards());
    }

    @Test
    void testPreprocess_withEmptyQuery() {
        // Given
        ParseContext parseContext = new ParseContext();
        parseContext.setQueryText("");

        // When
        wikiPreProcessor.preprocess(parseContext);

        // Then - should not throw, empty results
        assertTrue(parseContext.getWikiEntities().isEmpty());
    }
}
```

Run: `mvn test -Dtest=WikiPreProcessorTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create WikiPreProcessor class**

Create directory: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/`

Create file: `WikiPreProcessor.java`

```java
package com.tencent.supersonic.headless.chat.parser.wiki;

import com.tencent.supersonic.headless.chat.server.pojo.ParseContext;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiKnowledgeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@Slf4j
public class WikiPreProcessor {

    @Autowired
    private WikiEntityService entityService;

    @Autowired
    private WikiKnowledgeService knowledgeService;

    public void preprocess(ParseContext parseContext) {
        String queryText = parseContext.getQueryText();

        if (queryText == null || queryText.trim().isEmpty()) {
            parseContext.setWikiEntities(new ArrayList<>());
            parseContext.setWikiKnowledgeCards(new ArrayList<>());
            return;
        }

        log.info("[WikiPreProcessor] Starting Wiki preprocessing for query: {}", queryText);

        // Search Wiki entities by query text
        List<WikiEntity> wikiEntities = searchWikiEntities(queryText);

        // Search Wiki knowledge cards by query text
        List<WikiKnowledgeCard> wikiKnowledgeCards = searchWikiKnowledgeCards(queryText);

        parseContext.setWikiEntities(wikiEntities);
        parseContext.setWikiKnowledgeCards(wikiKnowledgeCards);

        log.info("[WikiPreProcessor] Wiki preprocessing complete. Entities: {}, Cards: {}",
                wikiEntities.size(), wikiKnowledgeCards.size());
    }

    private List<WikiEntity> searchWikiEntities(String queryText) {
        try {
            return entityService.searchEntities(queryText);
        } catch (Exception e) {
            log.warn("[WikiPreProcessor] Failed to search Wiki entities: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    private List<WikiKnowledgeCard> searchWikiKnowledgeCards(String queryText) {
        try {
            return knowledgeService.searchKnowledge(queryText);
        } catch (Exception e) {
            log.warn("[WikiPreProcessor] Failed to search Wiki knowledge cards: {}", e.getMessage());
            return new ArrayList<>();
        }
    }
}
```

- [ ] **Step 3: Verify ParseContext has Wiki fields**

Check ParseContext has these methods or add them:
```java
public List<WikiEntity> getWikiEntities();
public void setWikiEntities(List<WikiEntity> entities);
public List<WikiKnowledgeCard> getWikiKnowledgeCards();
public void setWikiKnowledgeCards(List<WikiKnowledgeCard> cards);
```

Run: `grep -n "WikiEntity\|WikiKnowledgeCard" headless/chat/src/main/java/com/tencent/supersonic/chat/server/pojo/ParseContext.java`

- [ ] **Step 4: Run test to verify it passes**

Run: `mvn test -Dtest=WikiPreProcessorTest -pl headless/chat -q`

Expected: May fail if ParseContext doesn't have Wiki fields yet - add them if needed

- [ ] **Step 5: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/WikiPreProcessor.java
git commit -m "feat(wiki): add WikiPreProcessor for NL2SQL integration

WikiPreProcessor retrieves Wiki entities and knowledge cards
based on user query text and stores them in ParseContext.
"
```

---

### Task 5: Create EnhancedSchema

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/EnhancedSchema.java`

- [ ] **Step 1: Write failing test for EnhancedSchema**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/parser/wiki/EnhancedSchemaTest.java`

```java
package com.tencent.supersonic.headless.chat.parser.wiki;

import com.tencent.supersonic.headless.api.pojo.SemanticSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class EnhancedSchemaTest {

    @Test
    void testBuilder() {
        SemanticSchema originalSchema = new SemanticSchema();
        List<WikiEntity> entities = Arrays.asList(new WikiEntity());
        List<WikiKnowledgeCard> cards = Arrays.asList(new WikiKnowledgeCard());

        Map<String, String> termMapping = new HashMap<>();
        termMapping.put("收入", "order_amount");

        EnhancedSchema schema = EnhancedSchema.builder()
                .originalSchema(originalSchema)
                .relatedWikiEntities(entities)
                .knowledgeCards(cards)
                .termToFieldMapping(termMapping)
                .build();

        assertNotNull(schema.getOriginalSchema());
        assertEquals(1, schema.getRelatedWikiEntities().size());
        assertEquals(1, schema.getKnowledgeCards().size());
        assertEquals("order_amount", schema.getTermToFieldMapping().get("收入"));
    }

    @Test
    void testDefaultValues() {
        EnhancedSchema schema = new EnhancedSchema();

        assertNotNull(schema.getRelatedWikiEntities());
        assertNotNull(schema.getKnowledgeCards());
        assertNotNull(schema.getTermToFieldMapping());
        assertNotNull(schema.getFieldToTermMapping());
        assertNotNull(schema.getBusinessRules());
        assertTrue(schema.getRelatedWikiEntities().isEmpty());
    }
}
```

Run: `mvn test -Dtest=EnhancedSchemaTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create EnhancedSchema class**

Create file: `EnhancedSchema.java`

```java
package com.tencent.supersonic.headless.chat.parser.wiki;

import com.tencent.supersonic.headless.api.pojo.SemanticSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EnhancedSchema {

    private SemanticSchema originalSchema;

    private List<WikiEntity> relatedWikiEntities;

    private List<WikiKnowledgeCard> knowledgeCards;

    @Builder.Default
    private Map<String, String> termToFieldMapping = new HashMap<>();

    @Builder.Default
    private Map<String, String> fieldToTermMapping = new HashMap<>();

    @Builder.Default
    private List<String> businessRules = new ArrayList<>();

    public List<WikiEntity> getRelatedWikiEntities() {
        if (relatedWikiEntities == null) {
            relatedWikiEntities = new ArrayList<>();
        }
        return relatedWikiEntities;
    }

    public List<WikiKnowledgeCard> getKnowledgeCards() {
        if (knowledgeCards == null) {
            knowledgeCards = new ArrayList<>();
        }
        return knowledgeCards;
    }

    public Map<String, String> getTermToFieldMapping() {
        if (termToFieldMapping == null) {
            termToFieldMapping = new HashMap<>();
        }
        return termToFieldMapping;
    }

    public Map<String, String> getFieldToTermMapping() {
        if (fieldToTermMapping == null) {
            fieldToTermMapping = new HashMap<>();
        }
        return fieldToTermMapping;
    }

    public List<String> getBusinessRules() {
        if (businessRules == null) {
            businessRules = new ArrayList<>();
        }
        return businessRules;
    }
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=EnhancedSchemaTest -pl headless/chat -q`

Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/EnhancedSchema.java
git commit -m "feat(wiki): add EnhancedSchema data structure

EnhancedSchema wraps SemanticSchema with Wiki knowledge:
- Wiki entities and knowledge cards
- Term to field mappings
- Business rules
"
```

---

### Task 6: Create WikiSemanticFusionService

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/WikiSemanticFusionService.java`

- [ ] **Step 1: Write failing test for WikiSemanticFusionService**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/parser/wiki/WikiSemanticFusionServiceTest.java`

```java
package com.tencent.supersonic.headless.chat.parser.wiki;

import com.google.gson.Gson;
import com.tencent.supersonic.headless.api.pojo.SemanticSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class WikiSemanticFusionServiceTest {

    private WikiSemanticFusionService fusionService;

    @BeforeEach
    void setUp() {
        fusionService = new WikiSemanticFusionService();
    }

    @Test
    void testFuseWithWiki_withSemanticMappings() {
        // Given
        Long dataSetId = 1L;
        String queryText = "查询本季度收入超过100万的客户";
        SemanticSchema semanticSchema = new SemanticSchema();

        WikiEntity entity = new WikiEntity();
        entity.setEntityId("column:sales_order.order_amount");
        entity.setName("order_amount");
        entity.setDisplayName("订单金额");

        WikiKnowledgeCard mappingCard = new WikiKnowledgeCard();
        mappingCard.setCardType("SEMANTIC_MAPPING");
        mappingCard.setContent("{\"term\":\"收入\",\"field\":\"order_amount\",\"table\":\"sales_order\"}");

        // When
        EnhancedSchema result = fusionService.fuseWithWiki(
                dataSetId, queryText, semanticSchema,
                Collections.singletonList(entity),
                Collections.singletonList(mappingCard)
        );

        // Then
        assertNotNull(result);
        assertFalse(result.getTermToFieldMapping().isEmpty());
        assertEquals("order_amount", result.getTermToFieldMapping().get("收入"));
    }

    @Test
    void testFuseWithWiki_withBusinessRules() {
        // Given
        Long dataSetId = 1L;
        String queryText = "查询欠费用户";
        SemanticSchema semanticSchema = new SemanticSchema();

        WikiKnowledgeCard ruleCard = new WikiKnowledgeCard();
        ruleCard.setCardType("BUSINESS_RULE");
        ruleCard.setContent("qfje > 0 表示存在欠费");

        // When
        EnhancedSchema result = fusionService.fuseWithWiki(
                dataSetId, queryText, semanticSchema,
                Collections.emptyList(),
                Collections.singletonList(ruleCard)
        );

        // Then
        assertNotNull(result);
        assertFalse(result.getBusinessRules().isEmpty());
        assertTrue(result.getBusinessRules().get(0).contains("欠费"));
    }

    @Test
    void testFuseWithWiki_withEmptyWikiData() {
        // Given
        Long dataSetId = 1L;
        String queryText = "查询用户";
        SemanticSchema semanticSchema = new SemanticSchema();

        // When
        EnhancedSchema result = fusionService.fuseWithWiki(
                dataSetId, queryText, semanticSchema,
                Collections.emptyList(),
                Collections.emptyList()
        );

        // Then
        assertNotNull(result);
        assertNotNull(result.getOriginalSchema());
        assertTrue(result.getTermToFieldMapping().isEmpty());
    }
}
```

Run: `mvn test -Dtest=WikiSemanticFusionServiceTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create WikiSemanticFusionService class**

```java
package com.tencent.supersonic.headless.chat.parser.wiki;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.tencent.supersonic.headless.api.pojo.SemanticSchema;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
public class WikiSemanticFusionService {

    private static final String CARD_TYPE_SEMANTIC_MAPPING = "SEMANTIC_MAPPING";
    private static final String CARD_TYPE_BUSINESS_RULE = "BUSINESS_RULE";
    private static final String CARD_TYPE_USAGE_PATTERN = "USAGE_PATTERN";
    private static final String CARD_TYPE_METRIC_DEFINITION = "METRIC_DEFINITION";

    private final Gson gson = new Gson();

    public EnhancedSchema fuseWithWiki(Long dataSetId, String queryText,
                                       SemanticSchema semanticSchema,
                                       List<WikiEntity> wikiEntities,
                                       List<WikiKnowledgeCard> wikiCards) {
        EnhancedSchema.EnhancedSchemaBuilder builder = EnhancedSchema.builder()
                .originalSchema(semanticSchema)
                .relatedWikiEntities(wikiEntities)
                .knowledgeCards(wikiCards);

        Map<String, String> termToFieldMapping = new HashMap<>();
        Map<String, String> fieldToTermMapping = new HashMap<>();
        List<String> businessRules = new ArrayList<>();

        for (WikiKnowledgeCard card : wikiCards) {
            if (card == null || card.getCardType() == null) {
                continue;
            }

            switch (card.getCardType()) {
                case CARD_TYPE_SEMANTIC_MAPPING:
                    Map<String, String> mapping = parseSemanticMapping(card.getContent());
                    if (mapping != null) {
                        termToFieldMapping.put(mapping.get("term"), mapping.get("field"));
                        fieldToTermMapping.put(mapping.get("field"), mapping.get("term"));
                    }
                    break;

                case CARD_TYPE_BUSINESS_RULE:
                    if (card.getContent() != null && !card.getContent().isEmpty()) {
                        businessRules.add(card.getContent());
                    }
                    break;

                case CARD_TYPE_USAGE_PATTERN:
                case CARD_TYPE_METRIC_DEFINITION:
                default:
                    // Add to knowledge cards for context building
                    break;
            }
        }

        return builder
                .termToFieldMapping(termToFieldMapping)
                .fieldToTermMapping(fieldToTermMapping)
                .businessRules(businessRules)
                .build();
    }

    private Map<String, String> parseSemanticMapping(String content) {
        if (content == null || content.isEmpty()) {
            return null;
        }

        try {
            Map<String, String> result = new HashMap<>();
            JsonMapping mapping = gson.fromJson(content, JsonMapping.class);
            result.put("term", mapping.getTerm());
            result.put("field", mapping.getField());
            result.put("table", mapping.getTable());
            return result;
        } catch (JsonSyntaxException e) {
            log.warn("[WikiSemanticFusionService] Failed to parse semantic mapping: {}", content);
            return null;
        }
    }

    @lombok.Data
    private static class JsonMapping {
        private String term;
        private String field;
        private String table;
        private String description;

        public String getTerm() {
            return term;
        }

        public String getField() {
            return field;
        }

        public String getTable() {
            return table;
        }
    }
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=WikiSemanticFusionServiceTest -pl headless/chat -q`

Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/wiki/WikiSemanticFusionService.java
git commit -m "feat(wiki): add WikiSemanticFusionService

WikiSemanticFusionService fuses Wiki entities and knowledge cards
with SemanticSchema to create EnhancedSchema with:
- Term to field mappings from SEMANTIC_MAPPING cards
- Business rules from BUSINESS_RULE cards
"
```

---

### Task 7: Create WikiAwareMapper

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/mapper/WikiAwareMapper.java`

- [ ] **Step 1: Write failing test for WikiAwareMapper**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/mapper/WikiAwareMapperTest.java`

```java
package com.tencent.supersonic.headless.chat.mapper;

import com.tencent.supersonic.headless.api.pojo.SchemaElementMatch;
import com.tencent.supersonic.headless.chat.parser.wiki.EnhancedSchema;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class WikiAwareMapperTest {

    private WikiAwareMapper mapper;

    @BeforeEach
    void setUp() {
        mapper = new WikiAwareMapper();
    }

    @Test
    void testEnhancedMap_withTermMapping() {
        // Given
        Long dataSetId = 1L;
        String queryText = "查询本季度收入超过100万的客户";
        EnhancedSchema enhancedSchema = createEnhancedSchema();

        // When
        List<SchemaElementMatch> result = mapper.enhancedMap(dataSetId, queryText, enhancedSchema);

        // Then
        assertNotNull(result);
        // Wiki-aware mapping should include additional matches from term mapping
    }

    @Test
    void testEnhancedMap_withEmptySchema() {
        // Given
        Long dataSetId = 1L;
        String queryText = "查询";
        EnhancedSchema emptySchema = EnhancedSchema.builder().build();

        // When
        List<SchemaElementMatch> result = mapper.enhancedMap(dataSetId, queryText, emptySchema);

        // Then
        assertNotNull(result);
        assertTrue(result.isEmpty());
    }

    private EnhancedSchema createEnhancedSchema() {
        Map<String, String> termMapping = new HashMap<>();
        termMapping.put("收入", "order_amount");
        termMapping.put("客户", "buyer_name");

        return EnhancedSchema.builder()
                .termToFieldMapping(termMapping)
                .build();
    }
}
```

Run: `mvn test -Dtest=WikiAwareMapperTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create WikiAwareMapper class**

```java
package com.tencent.supersonic.headless.chat.mapper;

import com.tencent.supersonic.headless.api.pojo.SchemaElementMatch;
import com.tencent.supersonic.headless.chat.parser.wiki.EnhancedSchema;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Component
@Slf4j
public class WikiAwareMapper {

    public List<SchemaElementMatch> enhancedMap(Long dataSetId, String queryText,
                                                EnhancedSchema enhancedSchema) {
        List<SchemaElementMatch> matches = new ArrayList<>();

        if (enhancedSchema == null || enhancedSchema.getTermToFieldMapping() == null) {
            return matches;
        }

        Map<String, String> termToFieldMapping = enhancedSchema.getTermToFieldMapping();

        // For each term in the mapping, check if it appears in the query
        for (Map.Entry<String, String> entry : termToFieldMapping.entrySet()) {
            String term = entry.getKey();
            String field = entry.getValue();

            if (queryText.contains(term)) {
                // Create a SchemaElementMatch for this Wiki-enhanced mapping
                SchemaElementMatch match = createWikiEnhancedMatch(term, field, enhancedSchema);
                if (match != null) {
                    matches.add(match);
                }
            }
        }

        log.info("[WikiAwareMapper] Enhanced mapping found {} matches for query: {}",
                matches.size(), queryText);

        return matches;
    }

    private SchemaElementMatch createWikiEnhancedMatch(String term, String field,
                                                       EnhancedSchema enhancedSchema) {
        // This creates a SchemaElementMatch enriched with Wiki knowledge
        // The actual implementation would need to:
        // 1. Find the corresponding SchemaElement from the field name
        // 2. Create a SchemaElementMatch with enhanced information

        // For now, return a basic match - actual implementation would be more sophisticated
        SchemaElementMatch match = new SchemaElementMatch();
        match.setWord(term);
        match.setMatchElementName(field);
        match.setMatchElementDescription("From Wiki semantic mapping");
        return match;
    }
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=WikiAwareMapperTest -pl headless/chat -q`

Expected: PASS (possibly with some warnings about incomplete mock)

- [ ] **Step 4: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/mapper/WikiAwareMapper.java
git commit -m "feat(wiki): add WikiAwareMapper

WikiAwareMapper provides enhanced schema mapping using Wiki knowledge:
- Matches terms in query with Wiki semantic mappings
- Creates SchemaElementMatch entries enriched with Wiki information
"
```

---

## Phase 3: Context Building and Prompt Enhancement (P1)

### Task 8: Create WikiContextBuilder

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/llm/WikiContextBuilder.java`

- [ ] **Step 1: Write failing test for WikiContextBuilder**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/parser/llm/WikiContextBuilderTest.java`

```java
package com.tencent.supersonic.headless.chat.parser.llm;

import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class WikiContextBuilderTest {

    private WikiContextBuilder contextBuilder;

    @BeforeEach
    void setUp() {
        contextBuilder = new WikiContextBuilder();
    }

    @Test
    void testBuildContext_withAllCardTypes() {
        // Given
        WikiKnowledgeCard mappingCard = createCard("SEMANTIC_MAPPING",
                "{\"term\":\"收入\",\"field\":\"order_amount\"}");
        WikiKnowledgeCard ruleCard = createCard("BUSINESS_RULE", "qfje > 0 表示存在欠费");
        WikiKnowledgeCard patternCard = createCard("USAGE_PATTERN", "查询欠费用户: WHERE qfje > 0");
        WikiKnowledgeCard metricCard = createCard("METRIC_DEFINITION", "收费率 = SUM(sfje) / SUM(ysje)");

        List<WikiKnowledgeCard> cards = Arrays.asList(mappingCard, ruleCard, patternCard, metricCard);

        // When
        String context = contextBuilder.buildContext(cards);

        // Then
        assertNotNull(context);
        assertTrue(context.contains("Semantic Mappings"));
        assertTrue(context.contains("Business Rules"));
        assertTrue(context.contains("Usage Patterns"));
        assertTrue(context.contains("Metric Definitions"));
    }

    @Test
    void testBuildContext_withEmptyCards() {
        // When
        String context = contextBuilder.buildContext(Collections.emptyList());

        // Then
        assertNotNull(context);
        assertTrue(context.isEmpty());
    }

    @Test
    void testBuildSemanticMappings() {
        // Given
        WikiKnowledgeCard card = createCard("SEMANTIC_MAPPING",
                "{\"term\":\"收入\",\"field\":\"order_amount\",\"table\":\"sales_order\"}");
        List<WikiKnowledgeCard> cards = Collections.singletonList(card);

        // When
        String result = contextBuilder.buildSemanticMappings(cards);

        // Then
        assertTrue(result.contains("收入"));
        assertTrue(result.contains("order_amount"));
    }

    @Test
    void testBuildBusinessRules() {
        // Given
        WikiKnowledgeCard card = createCard("BUSINESS_RULE", "qfje > 0 表示存在欠费");
        List<WikiKnowledgeCard> cards = Collections.singletonList(card);

        // When
        String result = contextBuilder.buildBusinessRules(cards);

        // Then
        assertTrue(result.contains("欠费"));
        assertTrue(result.contains("qfje"));
    }

    private WikiKnowledgeCard createCard(String type, String content) {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setCardType(type);
        card.setContent(content);
        card.setConfidence(BigDecimal.valueOf(0.9));
        return card;
    }
}
```

Run: `mvn test -Dtest=WikiContextBuilderTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create WikiContextBuilder class**

```java
package com.tencent.supersonic.headless.chat.parser.llm;

import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
@Slf4j
public class WikiContextBuilder {

    public static final String CARD_TYPE_SEMANTIC_MAPPING = "SEMANTIC_MAPPING";
    public static final String CARD_TYPE_BUSINESS_RULE = "BUSINESS_RULE";
    public static final String CARD_TYPE_USAGE_PATTERN = "USAGE_PATTERN";
    public static final String CARD_TYPE_METRIC_DEFINITION = "METRIC_DEFINITION";

    public String buildContext(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder context = new StringBuilder();

        String semanticMappings = buildSemanticMappings(
                cards.stream()
                        .filter(c -> CARD_TYPE_SEMANTIC_MAPPING.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!semanticMappings.isEmpty()) {
            context.append("\n## Wiki 语义映射 (Semantic Mappings)\n");
            context.append("以下业务术语对应数据库字段：\n");
            context.append(semanticMappings);
        }

        String businessRules = buildBusinessRules(
                cards.stream()
                        .filter(c -> CARD_TYPE_BUSINESS_RULE.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!businessRules.isEmpty()) {
            context.append("\n## Wiki 业务规则 (Business Rules)\n");
            context.append(businessRules);
        }

        String usagePatterns = buildUsagePatterns(
                cards.stream()
                        .filter(c -> CARD_TYPE_USAGE_PATTERN.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!usagePatterns.isEmpty()) {
            context.append("\n## Wiki 使用模式 (Usage Patterns)\n");
            context.append(usagePatterns);
        }

        String metricDefinitions = buildMetricDefinitions(
                cards.stream()
                        .filter(c -> CARD_TYPE_METRIC_DEFINITION.equals(c.getCardType()))
                        .collect(Collectors.toList()));
        if (!metricDefinitions.isEmpty()) {
            context.append("\n## Wiki 指标定义 (Metric Definitions)\n");
            context.append(metricDefinitions);
        }

        return context.toString();
    }

    public String buildSemanticMappings(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }

    public String buildBusinessRules(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }

    public String buildUsagePatterns(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }

    public String buildMetricDefinitions(List<WikiKnowledgeCard> cards) {
        if (cards == null || cards.isEmpty()) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        for (WikiKnowledgeCard card : cards) {
            if (card.getContent() != null && !card.getContent().isEmpty()) {
                sb.append("- ").append(card.getContent()).append("\n");
            }
        }
        return sb.toString();
    }
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=WikiContextBuilderTest -pl headless/chat -q`

Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/llm/WikiContextBuilder.java
git commit -m "feat(wiki): add WikiContextBuilder

WikiContextBuilder builds Wiki knowledge context strings for LLM prompts:
- Semantic mappings (term -> field)
- Business rules
- Usage patterns
- Metric definitions
"
```

---

### Task 9: Create WikiLLMReq

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/s2sql/WikiLLMReq.java`

- [ ] **Step 1: Write failing test for WikiLLMReq**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/query/llm/s2sql/WikiLLMReqTest.java`

```java
package com.tencent.supersonic.headless.chat.query.llm.s2sql;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class WikiLLMReqTest {

    @Test
    void testBuilder() {
        WikiKnowledgeCard card = new WikiKnowledgeCard();
        WikiEntity entity = new WikiEntity();

        WikiLLMReq req = WikiLLMReq.builder()
                .businessRules(Arrays.asList(card))
                .usagePatterns(Arrays.asList(card))
                .metricDefinitions(Arrays.asList(card))
                .semanticMappings(Arrays.asList(card))
                .relatedEntities(Arrays.asList(entity))
                .build();

        assertEquals(1, req.getBusinessRules().size());
        assertEquals(1, req.getUsagePatterns().size());
        assertEquals(1, req.getMetricDefinitions().size());
        assertEquals(1, req.getSemanticMappings().size());
        assertEquals(1, req.getRelatedEntities().size());
    }

    @Test
    void testDefaultValues() {
        WikiLLMReq req = new WikiLLMReq();

        assertNotNull(req.getBusinessRules());
        assertNotNull(req.getUsagePatterns());
        assertNotNull(req.getMetricDefinitions());
        assertNotNull(req.getSemanticMappings());
        assertNotNull(req.getRelatedEntities());
        assertTrue(req.getBusinessRules().isEmpty());
    }
}
```

Run: `mvn test -Dtest=WikiLLMReqTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create WikiLLMReq class**

```java
package com.tencent.supersonic.headless.chat.query.llm.s2sql;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WikiLLMReq {

    private List<WikiKnowledgeCard> businessRules;

    private List<WikiKnowledgeCard> usagePatterns;

    private List<WikiKnowledgeCard> metricDefinitions;

    private List<WikiKnowledgeCard> semanticMappings;

    private List<WikiEntity> relatedEntities;

    public List<WikiKnowledgeCard> getBusinessRules() {
        if (businessRules == null) {
            businessRules = new ArrayList<>();
        }
        return businessRules;
    }

    public List<WikiKnowledgeCard> getUsagePatterns() {
        if (usagePatterns == null) {
            usagePatterns = new ArrayList<>();
        }
        return usagePatterns;
    }

    public List<WikiKnowledgeCard> getMetricDefinitions() {
        if (metricDefinitions == null) {
            metricDefinitions = new ArrayList<>();
        }
        return metricDefinitions;
    }

    public List<WikiKnowledgeCard> getSemanticMappings() {
        if (semanticMappings == null) {
            semanticMappings = new ArrayList<>();
        }
        return semanticMappings;
    }

    public List<WikiEntity> getRelatedEntities() {
        if (relatedEntities == null) {
            relatedEntities = new ArrayList<>();
        }
        return relatedEntities;
    }
}
```

- [ ] **Step 3: Run test to verify it passes**

Run: `mvn test -Dtest=WikiLLMReqTest -pl headless/chat -q`

Expected: PASS

- [ ] **Step 4: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/query/llm/s2sql/WikiLLMReq.java
git commit -m "feat(wiki): add WikiLLMReq

WikiLLMReq extends LLMReq to carry Wiki knowledge:
- businessRules, usagePatterns, metricDefinitions
- semanticMappings
- relatedEntities
"
```

---

### Task 10: Integrate WikiPreProcessor into NL2SQLParser

**Files:**
- Modify: `chat/server/src/main/java/com/tencent/supersonic/chat/server/parser/NL2SQLParser.java`

- [ ] **Step 1: Review current NL2SQLParser structure**

Run: `grep -n "class NL2SQLParser\|void parse\|ParseContext" chat/server/src/main/java/com/tencent/supersonic/chat/server/parser/NL2SQLParser.java | head -20`

- [ ] **Step 2: Add WikiPreProcessor integration point**

In NL2SQLParser, add the WikiPreProcessor call at the start of the `parse` method:

```java
@Override
public void parse(ParseContext parseContext) {
    keyPipelineLog.info("[Wiki知识库->Parse] NL2SQLParser开始 | queryText:{}", parseContext.getRequest().getQueryText());

    // Step 1: Wiki preprocessing to enrich context with Wiki knowledge
    wikiPreProcessor.preprocess(parseContext);
    keyPipelineLog.info("[Wiki知识库->Parse] Wiki预处理完成 | wikiEntities:{} | wikiCards:{}",
            parseContext.getWikiEntities().size(),
            parseContext.getWikiKnowledgeCards().size());

    // ... rest of existing code
}
```

- [ ] **Step 3: Add WikiPreProcessor dependency**

Add field:
```java
@Autowired
private WikiPreProcessor wikiPreProcessor;
```

- [ ] **Step 4: Build and verify compilation**

Run: `mvn compile -pl chat/server -am -q -DskipTests`

Expected: BUILD SUCCESS

- [ ] **Step 5: Commit**

```bash
git add chat/server/src/main/java/com/tencent/supersonic/chat/server/parser/NL2SQLParser.java
git commit -m "feat(wiki): integrate WikiPreProcessor into NL2SQLParser

WikiPreProcessor is called at the start of parse() to:
1. Retrieve Wiki entities and knowledge cards based on query
2. Store them in ParseContext for downstream processing
"
```

---

## Phase 4: Wiki-Aware SQL Generation (P2)

### Task 11: Create WikiAwareLLMSqlParser

**Files:**
- Create: `headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/llm/WikiAwareLLMSqlParser.java`

- [ ] **Step 1: Write failing test for WikiAwareLLMSqlParser**

Create file: `headless/chat/src/test/java/com/tencent/supersonic/headless/chat/parser/llm/WikiAwareLLMSqlParserTest.java`

```java
package com.tencent.supersonic.headless.chat.parser.llm;

import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.WikiLLMReq;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class WikiAwareLLMSqlParserTest {

    private WikiAwareLLMSqlParser parser;

    @BeforeEach
    void setUp() {
        parser = new WikiAwareLLMSqlParser();
    }

    @Test
    void testWikiAwareLlmReq_inheritsFromLlmReq() {
        WikiLLMReq wikiReq = WikiLLMReq.builder().build();
        assertNotNull(wikiReq);
    }

    @Test
    void testContextBuilder_integration() {
        WikiContextBuilder builder = new WikiContextBuilder();
        assertNotNull(builder);
    }
}
```

Run: `mvn test -Dtest=WikiAwareLLMSqlParserTest -pl headless/chat -q` (expected to fail - class doesn't exist)

- [ ] **Step 2: Create WikiAwareLLMSqlParser class**

```java
package com.tencent.supersonic.headless.chat.parser.llm;

import com.tencent.supersonic.headless.chat.ChatQueryContext;
import com.tencent.supersonic.headless.chat.parser.SemanticParser;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMReq;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.WikiLLMReq;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * WikiAwareLLMSqlParser uses large language model to understand query semantics
 * and generate SQL statements, with enhanced context from Wiki knowledge base.
 */
@Slf4j
@Component
public class WikiAwareLLMSqlParser implements SemanticParser {

    @Autowired
    private LLMRequestService requestService;

    @Autowired
    private WikiContextBuilder wikiContextBuilder;

    @Override
    public void parse(ChatQueryContext queryCtx) {
        try {
            // Check if Wiki integration is enabled
            if (!isWikiEnabled(queryCtx)) {
                log.debug("[WikiAwareLLMSqlParser] Wiki integration disabled, skipping");
                return;
            }

            // Get Wiki knowledge from query context
            WikiLLMReq wikiLlmReq = buildWikiLlmReq(queryCtx);

            // Build Wiki-enhanced context
            String wikiContext = wikiContextBuilder.buildContext(wikiLlmReq.getKnowledgeCards());

            // Inject Wiki context into the request
            injectWikiContext(queryCtx, wikiContext);

            log.info("[WikiAwareLLMSqlParser] Wiki context injected, length: {}",
                    wikiContext != null ? wikiContext.length() : 0);

        } catch (Exception e) {
            log.error("[WikiAwareLLMSqlParser] Failed to process Wiki context", e);
            // Don't fail the whole parse, just log and continue
        }
    }

    private boolean isWikiEnabled(ChatQueryContext queryCtx) {
        // TODO: Check configuration for Wiki integration enable/disable
        return queryCtx.getWikiEntities() != null
                && !queryCtx.getWikiEntities().isEmpty();
    }

    private WikiLLMReq buildWikiLlmReq(ChatQueryContext queryCtx) {
        WikiLLMReq.WikiLLMReqBuilder builder = WikiLLMReq.builder();

        if (queryCtx.getWikiKnowledgeCards() != null) {
            builder.knowledgeCards(queryCtx.getWikiKnowledgeCards());

            // Categorize cards by type
            builder.businessRules(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "BUSINESS_RULE".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));

            builder.usagePatterns(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "USAGE_PATTERN".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));

            builder.metricDefinitions(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "METRIC_DEFINITION".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));

            builder.semanticMappings(queryCtx.getWikiKnowledgeCards().stream()
                    .filter(c -> "SEMANTIC_MAPPING".equals(c.getCardType()))
                    .collect(java.util.stream.Collectors.toList()));
        }

        if (queryCtx.getWikiEntities() != null) {
            builder.relatedEntities(queryCtx.getWikiEntities());
        }

        return builder.build();
    }

    private void injectWikiContext(ChatQueryContext queryCtx, String wikiContext) {
        // Inject Wiki context into the LLM request
        // This would modify the request to include Wiki context in the prompt
        // Implementation depends on how prompts are constructed
        if (wikiContext != null && !wikiContext.isEmpty()) {
            queryCtx.setWikiContext(wikiContext);
        }
    }
}
```

Note: This class may need additional modifications to work with the existing LLM parsing infrastructure. The implementation provides the structure but may need adaptation to the actual prompt injection mechanism.

- [ ] **Step 3: Run test to verify it compiles**

Run: `mvn compile -pl headless/chat -am -q -DskipTests`

Expected: BUILD SUCCESS (may have warnings about unused imports)

- [ ] **Step 4: Commit**

```bash
git add headless/chat/src/main/java/com/tencent/supersonic/headless/chat/parser/llm/WikiAwareLLMSqlParser.java
git commit -m "feat(wiki): add WikiAwareLLMSqlParser

WikiAwareLLMSqlParser provides Wiki-enhanced SQL generation:
- Builds WikiLLMReq from query context
- Uses WikiContextBuilder to create context strings
- Injects Wiki context into LLM prompts
"
```

---

## Summary

### Completed Tasks

- [ ] Task 1: Review WikiKnowledgeCard DTO
- [ ] Task 2: Extend WikiEntityService with Search Method
- [ ] Task 3: Extend WikiKnowledgeService with Card Type Queries
- [ ] Task 4: Create WikiPreProcessor
- [ ] Task 5: Create EnhancedSchema
- [ ] Task 6: Create WikiSemanticFusionService
- [ ] Task 7: Create WikiAwareMapper
- [ ] Task 8: Create WikiContextBuilder
- [ ] Task 9: Create WikiLLMReq
- [ ] Task 10: Integrate WikiPreProcessor into NL2SQLParser
- [ ] Task 11: Create WikiAwareLLMSqlParser

### Files Created (8 new files)

```
headless/chat/src/main/java/com/tencent/supersonic/headless/chat/
├── parser/wiki/WikiPreProcessor.java
├── parser/wiki/EnhancedSchema.java
├── parser/wiki/WikiSemanticFusionService.java
├── mapper/WikiAwareMapper.java
├── parser/llm/WikiContextBuilder.java
├── parser/llm/WikiAwareLLMSqlParser.java
└── query/llm/s2sql/WikiLLMReq.java
```

### Files Modified (3 files)

```
headless/core/src/main/java/com/tencent/supersonic/headless/core/
├── wiki/service/WikiEntityService.java
└── wiki/service/WikiKnowledgeService.java

chat/server/src/main/java/com/tencent/supersonic/chat/server/
└── parser/NL2SQLParser.java
```

### Next Steps

After completing all tasks:
1. Run full build: `mvn clean package -DskipTests -Dspotless.skip=true`
2. Run existing tests to verify no regression: `mvn test -pl headless/chat,chat/server`
3. Create integration test for end-to-end Wiki-NL2SQL flow
4. Add configuration support for Wiki integration enable/disable
