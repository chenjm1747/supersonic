package com.tencent.supersonic.text2sql;

import com.tencent.supersonic.common.pojo.ChatModelConfig;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.provider.ModelProvider;
import dev.langchain4j.service.AiServices;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.LocalDate;

@Service
@Slf4j
public class SqlGenerationService {

    private static final String SQL_GENERATION_PROMPT =
            """
                    # Role: You are a professional SQL generation expert, experienced in heating fee management systems.

                    ## Available Schema Information
                    %s

                    ## Database Type
                    MySQL (version 8.0)

                    ## Business Rules
                    1. Field names and table names should be wrapped with backticks, e.g., `customer`.`name`
                    2. String values should use single quotes, e.g., WHERE `yhlx` = '居民'
                    3. Decimal comparisons should account for precision
                    4. Date/time format: 'YYYY-MM-DD' or 'YYYY-MM-DD HH:MI:SS'

                    ## Important Notes
                    - Only use tables and columns that are mentioned in the schema above
                    - Always join tables using proper foreign key relationships
                    - Use appropriate aggregate functions (SUM, COUNT, AVG, etc.) when needed
                    - Filter out invalid records (zf = 0) by default

                    ## Current Date
                    %s

                    ## User Question
                    %s

                    ## Generated SQL
                    """;

    @Value("${text2sql.llm.provider:OPEN_AI}")
    private String provider;

    @Value("${text2sql.llm.base-url:https://api.minimaxi.com/v1}")
    private String baseUrl;

    @Value("${text2sql.llm.model-name:MiniMax-M2.7}")
    private String modelName;

    @Value("${text2sql.llm.api-key:}")
    private String apiKey;

    @Value("${text2sql.llm.temperature:0.0}")
    private Double temperature;

    @Value("${text2sql.llm.timeout:120}")
    private Long timeout;

    @Data
    static class SqlResponse {
        private String thought;
        private String sql;
    }

    interface SqlExtractor {
        SqlResponse extractSql(String text);
    }

    public String generateSql(String question, int topK,
            SchemaKnowledgeService schemaKnowledgeService) {
        try {
            var schemas = schemaKnowledgeService.searchSimilar(question, topK);
            if (schemas.isEmpty()) {
                log.warn("No similar schema found for question: {}", question);
                return "-- No relevant schema found for the question";
            }

            String schemaContext = schemaKnowledgeService.buildSchemaContext(schemas);
            String currentDate = LocalDate.now().toString();

            String prompt =
                    String.format(SQL_GENERATION_PROMPT, schemaContext, currentDate, question);

            log.debug("Generated SQL prompt for question: {}", question);
            log.debug("Schema context: {}", schemaContext);

            ChatModelConfig chatModelConfig = getChatModelConfig();
            ChatLanguageModel chatLanguageModel = ModelProvider.getChatModel(chatModelConfig);

            SqlExtractor extractor = AiServices.builder(SqlExtractor.class)
                    .chatLanguageModel(chatLanguageModel).build();

            SqlResponse response = extractor.extractSql(prompt);

            if (response == null || response.getSql() == null) {
                log.error("Failed to generate SQL for question: {}", question);
                return "-- Failed to generate SQL";
            }

            String sql = response.getSql().trim();
            if (sql.startsWith("```sql")) {
                sql = sql.substring(6);
            }
            if (sql.endsWith("```")) {
                sql = sql.substring(0, sql.length() - 3);
            }

            log.info("Generated SQL for question '{}': {}", question, sql);
            return sql.trim();

        } catch (Exception e) {
            log.error("Error generating SQL for question: {}", question, e);
            return "-- Error generating SQL: " + e.getMessage();
        }
    }

    private ChatModelConfig getChatModelConfig() {
        return ChatModelConfig.builder().provider(provider).baseUrl(baseUrl).apiKey(apiKey)
                .modelName(modelName).temperature(temperature).timeOut(timeout).maxRetries(3)
                .logRequests(true).logResponses(true).build();
    }
}
