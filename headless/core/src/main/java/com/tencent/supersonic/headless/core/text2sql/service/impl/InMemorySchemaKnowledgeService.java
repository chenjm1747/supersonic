package com.tencent.supersonic.headless.core.text2sql.service.impl;

import com.tencent.supersonic.headless.core.text2sql.dto.ColumnSchema;
import com.tencent.supersonic.headless.core.text2sql.dto.SchemaKnowledge;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import com.tencent.supersonic.headless.core.text2sql.service.SchemaKnowledgeService;
import com.tencent.supersonic.headless.core.text2sql.service.TextEmbeddingService;
import com.tencent.supersonic.headless.core.text2sql.utils.KnowledgeTextBuilder;
import com.tencent.supersonic.headless.core.text2sql.utils.SqlFileParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Service
public class InMemorySchemaKnowledgeService implements SchemaKnowledgeService {
    private static final Logger log = LoggerFactory.getLogger(InMemorySchemaKnowledgeService.class);

    private final Map<String, List<SchemaKnowledge>> knowledgeStore = new ConcurrentHashMap<>();
    private final Map<String, TableSchema> tableSchemaMap = new ConcurrentHashMap<>();

    @Autowired
    private SqlFileParser sqlFileParser;

    @Autowired
    private TextEmbeddingService embeddingService;

    @Override
    public void buildKnowledgeBase(String sqlFilePath, List<String> targetTables) {
        try {
            log.info("Building knowledge base from: {}, target tables: {}", sqlFilePath,
                    targetTables);

            List<TableSchema> tables = sqlFileParser.parse(sqlFilePath);

            for (TableSchema table : tables) {
                if (targetTables != null && !targetTables.isEmpty()
                        && !targetTables.contains(table.getTableName())) {
                    continue;
                }

                tableSchemaMap.put(table.getTableName(), table);

                List<SchemaKnowledge> tableKnowledge = new ArrayList<>();
                for (ColumnSchema column : table.getColumns()) {
                    String knowledgeText = KnowledgeTextBuilder.build(table, column);

                    SchemaKnowledge knowledge = new SchemaKnowledge();
                    knowledge.setTableName(table.getTableName());
                    knowledge.setTableComment(table.getTableComment());
                    knowledge.setColumnName(column.getColumnName());
                    knowledge.setColumnComment(column.getColumnComment());
                    knowledge.setColumnType(column.getColumnType());
                    knowledge.setIsPrimaryKey(column.getIsPrimaryKey());
                    knowledge.setIsForeignKey(column.getIsForeignKey());
                    knowledge.setFkReference(column.getFkReference());
                    knowledge.setKnowledgeText(knowledgeText);

                    tableKnowledge.add(knowledge);
                }

                knowledgeStore.put(table.getTableName(), tableKnowledge);
            }

            log.info("Knowledge base built successfully, tables: {}", tableSchemaMap.keySet());

        } catch (Exception e) {
            log.error("Failed to build knowledge base", e);
            throw new RuntimeException("Failed to build knowledge base", e);
        }
    }

    @Override
    public List<SchemaKnowledge> retrieve(String question, int topK) {
        float[] questionEmbedding = embeddingService.embed(question);

        List<KnowledgeWithScore> scored = new ArrayList<>();

        for (List<SchemaKnowledge> tableKnowledge : knowledgeStore.values()) {
            for (SchemaKnowledge knowledge : tableKnowledge) {
                Float[] knowledgeEmbeddingArray = knowledge.getEmbedding();
                float[] knowledgeEmbedding = new float[knowledgeEmbeddingArray.length];
                for (int i = 0; i < knowledgeEmbeddingArray.length; i++) {
                    knowledgeEmbedding[i] = knowledgeEmbeddingArray[i];
                }
                double similarity = cosineSimilarity(questionEmbedding, knowledgeEmbedding);
                scored.add(new KnowledgeWithScore(knowledge, similarity));
            }
        }

        return scored.stream().sorted((a, b) -> Double.compare(b.similarity, a.similarity))
                .limit(topK).map(k -> k.knowledge).collect(Collectors.toList());
    }

    @Override
    public List<TableSchema> getTableSchemas(List<String> tableNames) {
        if (tableNames == null || tableNames.isEmpty()) {
            return new ArrayList<>(tableSchemaMap.values());
        }

        return tableNames.stream().map(tableSchemaMap::get).filter(Objects::nonNull)
                .collect(Collectors.toList());
    }

    private double cosineSimilarity(float[] vec1, float[] vec2) {
        if (vec1 == null || vec2 == null || vec1.length != vec2.length || vec1.length == 0) {
            return 0.0;
        }

        double dotProduct = 0.0;
        double norm1 = 0.0;
        double norm2 = 0.0;

        for (int i = 0; i < vec1.length; i++) {
            dotProduct += vec1[i] * vec2[i];
            norm1 += vec1[i] * vec1[i];
            norm2 += vec2[i] * vec2[i];
        }

        if (norm1 == 0 || norm2 == 0) {
            return 0.0;
        }

        return dotProduct / (Math.sqrt(norm1) * Math.sqrt(norm2));
    }

    private static class KnowledgeWithScore {
        SchemaKnowledge knowledge;
        double similarity;

        KnowledgeWithScore(SchemaKnowledge knowledge, double similarity) {
            this.knowledge = knowledge;
            this.similarity = similarity;
        }
    }
}
