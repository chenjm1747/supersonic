package com.tencent.supersonic.headless.core.text2sql.service.impl;

import com.tencent.supersonic.headless.core.text2sql.dto.SchemaKnowledge;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;
import com.tencent.supersonic.headless.core.text2sql.dto.Text2SqlRequest;
import com.tencent.supersonic.headless.core.text2sql.dto.Text2SqlResponse;
import com.tencent.supersonic.headless.core.text2sql.service.SchemaKnowledgeService;
import com.tencent.supersonic.headless.core.text2sql.service.SqlGeneratorService;
import com.tencent.supersonic.headless.core.text2sql.utils.KnowledgeTextBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DefaultText2SqlService {
    private static final Logger log = LoggerFactory.getLogger(DefaultText2SqlService.class);

    @Autowired
    private SchemaKnowledgeService schemaService;

    @Autowired
    private SqlGeneratorService sqlGenerator;

    public Text2SqlResponse convert(Text2SqlRequest request) {
        try {
            String question = request.getQuestion();
            int topK = request.getTopK() != null ? request.getTopK() : 5;

            log.info("Converting question to SQL: {}", question);

            List<SchemaKnowledge> schemas = schemaService.retrieve(question, topK);

            String schemaContext = buildSchemaContext(schemas);

            String sql = sqlGenerator.generate(question, schemaContext);

            boolean valid = sql != null && !sql.startsWith("ERROR:");

            return Text2SqlResponse.builder().question(question).sql(sql).valid(valid)
                    .schemas(schemas).build();

        } catch (Exception e) {
            log.error("Failed to convert question to SQL", e);
            return Text2SqlResponse.builder().question(request.getQuestion()).error(e.getMessage())
                    .valid(false).build();
        }
    }

    private String buildSchemaContext(List<SchemaKnowledge> schemas) {
        if (schemas == null || schemas.isEmpty()) {
            return "无可用的表结构信息";
        }

        Map<String, List<SchemaKnowledge>> tableSchemas =
                schemas.stream().collect(Collectors.groupingBy(SchemaKnowledge::getTableName));

        StringBuilder context = new StringBuilder();
        for (Map.Entry<String, List<SchemaKnowledge>> entry : tableSchemas.entrySet()) {
            String tableName = entry.getKey();
            List<SchemaKnowledge> columns = entry.getValue();

            String tableComment = columns.get(0).getTableComment();

            String columnsText = columns.stream().map(col -> {
                StringBuilder sb = new StringBuilder();
                sb.append("`").append(col.getColumnName()).append("`");
                sb.append(" (").append(col.getColumnType()).append(")");
                if (col.getColumnComment() != null && !col.getColumnComment().isEmpty()) {
                    sb.append(" - ").append(col.getColumnComment());
                }
                if (Boolean.TRUE.equals(col.getIsPrimaryKey())) {
                    sb.append(" [主键]");
                }
                if (Boolean.TRUE.equals(col.getIsForeignKey())) {
                    sb.append(" [外键->").append(col.getFkReference()).append("]");
                }
                return sb.toString();
            }).collect(Collectors.joining("\n  "));

            context.append(
                    KnowledgeTextBuilder.buildSchemaContext(tableName, tableComment, columnsText));
            context.append("\n\n");
        }

        return context.toString();
    }
}
