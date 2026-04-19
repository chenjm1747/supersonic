package com.tencent.supersonic.headless.chat.parser.llm;

import com.google.common.collect.Lists;
import com.tencent.supersonic.common.pojo.ChatApp;
import com.tencent.supersonic.common.pojo.ChatModelConfig;
import com.tencent.supersonic.common.pojo.Text2SQLExemplar;
import com.tencent.supersonic.common.pojo.enums.AppModule;
import com.tencent.supersonic.common.util.ChatAppManager;
import com.tencent.supersonic.headless.chat.parser.ParserConfig;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMReq;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMResp;
import dev.langchain4j.data.message.ChatMessage;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.model.input.Prompt;
import dev.langchain4j.model.input.PromptTemplate;
import dev.langchain4j.model.output.structured.Description;
import dev.langchain4j.service.AiServices;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.tuple.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import static com.tencent.supersonic.headless.chat.parser.ParserConfig.PARSER_FORMAT_JSON_TYPE;

@Service
@Slf4j
public class OnePassSCSqlGenStrategy extends SqlGenStrategy {

    private static final Logger keyPipelineLog = LoggerFactory.getLogger("keyPipeline");

    public static final String APP_KEY = "S2SQL_PARSER";

    @Autowired
    private ParserConfig parserConfig;

    public static final String INSTRUCTION =
            "#Role: You are a data analyst experienced in SQL languages."
                    + "\n#Task: You will be provided with a natural language question asked by users,"
                    + "please convert it to a SQL query so that relevant data could be returned "
                    + "by executing the SQL query against underlying database." + "\n#Rules:"
                    + "\n1.SQL columns and values must be mentioned in the `Schema`, DO NOT hallucinate."
                    + "\n2.ALWAYS specify time range using `>`,`<`,`>=`,`<=` operator."
                    + "\n3.DO NOT include time range in the where clause if not explicitly expressed in the `Question`."
                    + "\n4.DO NOT calculate date range using functions."
                    + "\n5.ALWAYS use `with` statement if nested aggregation is needed."
                    + "\n6.ALWAYS enclose alias declared by `AS` command in underscores."
                    + "\n7.Alias created by `AS` command must be in the same language ast the `Question`."
                    + "\n8.Output format: You MUST output a valid JSON object with exactly two fields: `thought` (a brief explanation) and `sql` (the SQL query). Example: {\"thought\":\"brief explanation\",\"sql\":\"SELECT ...\"}"
                    + "\n#Exemplars: {{exemplar}}"
                    + "\n#Query: Question:{{question}},Schema:{{schema}},SideInfo:{{information}}";

    public OnePassSCSqlGenStrategy() {
        ChatAppManager.register(APP_KEY, ChatApp.builder().prompt(INSTRUCTION).name("语义SQL解析")
                .appModule(AppModule.CHAT).description("通过大模型做语义解析生成S2SQL").enable(true).build());
    }

    @Data
    static class SemanticSql {
        @Description("thought or remarks to tell users about the sql, make it short.")
        private String thought;

        @Description("sql to generate")
        private String sql;
    }

    interface SemanticSqlExtractor {
        SemanticSql generateSemanticSql(String text);
    }

    @Override
    public LLMResp generate(LLMReq llmReq) {
        LLMResp llmResp = new LLMResp();
        llmResp.setQuery(llmReq.getQueryText());
        // 1.recall exemplars
        log.debug("OnePassSCSqlGenStrategy llmReq:\n{}", llmReq);
        List<List<Text2SQLExemplar>> exemplarsList = promptHelper.getFewShotExemplars(llmReq);

        // 2.generate sql generation prompt for each self-consistency inference
        ChatApp chatApp = llmReq.getChatAppConfig().get(APP_KEY);
        ChatModelConfig chatModelConfig = chatApp.getChatModelConfig();
        if (!StringUtils.isBlank(parserConfig.getParameterValue(PARSER_FORMAT_JSON_TYPE))) {
            chatModelConfig.setJsonFormat(true);
            chatModelConfig
                    .setJsonFormatType(parserConfig.getParameterValue(PARSER_FORMAT_JSON_TYPE));
        }
        ChatLanguageModel chatLanguageModel = getChatLanguageModel(chatModelConfig);

        Map<Prompt, List<Text2SQLExemplar>> prompt2Exemplar = new HashMap<>();
        for (List<Text2SQLExemplar> exemplars : exemplarsList) {
            llmReq.setDynamicExemplars(exemplars);
            Prompt prompt = generatePrompt(llmReq, llmResp, chatApp);
            prompt2Exemplar.put(prompt, exemplars);
        }

        // 3.perform multiple self-consistency inferences parallelly
        Map<String, Prompt> output2Prompt = new ConcurrentHashMap<>();
        prompt2Exemplar.keySet().parallelStream().forEach(prompt -> {
            SemanticSql s2Sql = generateSemanticSqlWithRetry(chatLanguageModel, prompt);
            output2Prompt.put(s2Sql.getSql(), prompt);
            keyPipelineLog.info("OnePassSCSqlGenStrategy modelReq:\n{} \nmodelResp:\n{}",
                    prompt.text(), s2Sql);
        });

        // 4.format response.
        Pair<String, Map<String, Double>> sqlMapPair =
                ResponseHelper.selfConsistencyVote(Lists.newArrayList(output2Prompt.keySet()));
        llmResp.setSqlOutput(sqlMapPair.getLeft());
        List<Text2SQLExemplar> usedExemplars =
                prompt2Exemplar.get(output2Prompt.get(sqlMapPair.getLeft()));
        llmResp.setSqlRespMap(ResponseHelper.buildSqlRespMap(usedExemplars, sqlMapPair.getRight()));

        return llmResp;
    }

    private SemanticSql generateSemanticSqlWithRetry(ChatLanguageModel chatLanguageModel,
            Prompt prompt) {
        SemanticSqlExtractor extractor =
                AiServices.create(SemanticSqlExtractor.class, chatLanguageModel);
        String rawResponse = chatLanguageModel.generate(prompt.toUserMessage().singleText());
        String cleanedResponse = cleanJsonResponse(rawResponse);
        try {
            return extractor.generateSemanticSql(cleanedResponse);
        } catch (Exception e) {
            log.warn("Failed to parse semantic SQL, trying with raw response", e);
            return extractor.generateSemanticSql(rawResponse);
        }
    }

    private String cleanJsonResponse(String response) {
        if (StringUtils.isBlank(response)) {
            return response;
        }
        String cleaned = response.trim();
        if (cleaned.startsWith("```")) {
            cleaned = cleaned.replaceAll("^```(?:json)?\\s*", "").replaceAll("\\s*```$", "");
        }
        int thinkEndIndex = cleaned.lastIndexOf("</think>");
        if (thinkEndIndex >= 0 && thinkEndIndex < cleaned.length() - 6) {
            cleaned = cleaned.substring(thinkEndIndex + 7).trim();
        }
        int jsonStart = cleaned.indexOf('{');
        int jsonEnd = cleaned.lastIndexOf('}');
        if (jsonStart >= 0 && jsonEnd > jsonStart) {
            cleaned = cleaned.substring(jsonStart, jsonEnd + 1);
        }
        return cleaned;
    }

    private Prompt generatePrompt(LLMReq llmReq, LLMResp llmResp, ChatApp chatApp) {
        StringBuilder exemplars = new StringBuilder();
        for (Text2SQLExemplar exemplar : llmReq.getDynamicExemplars()) {
            String exemplarStr = String.format("\nQuestion:%s,Schema:%s,SideInfo:%s,SQL:%s",
                    exemplar.getQuestion(), exemplar.getDbSchema(), exemplar.getSideInfo(),
                    exemplar.getSql());
            exemplars.append(exemplarStr);
        }
        String dataSemantics = promptHelper.buildSchemaStr(llmReq);

        // Use context-aware side information if conversation history exists
        String sideInformation;
        if (llmReq.getContextHistory() != null && !llmReq.getContextHistory().isEmpty()) {
            sideInformation = promptHelper.buildSideInformationWithContext(llmReq);
        } else if (llmReq.getParsedQuestion() != null || llmReq.getIntentResult() != null) {
            // Use enhanced side info with parsed question and intent
            sideInformation = promptHelper.buildEnhancedSideInfo(llmReq);
        } else {
            sideInformation = promptHelper.buildSideInformation(llmReq);
        }

        llmResp.setSchema(dataSemantics);
        llmResp.setSideInfo(sideInformation);

        Map<String, Object> variable = new HashMap<>();
        variable.put("exemplar", exemplars);
        variable.put("question", llmReq.getQueryText());
        variable.put("schema", dataSemantics);
        variable.put("information", sideInformation);

        // use custom prompt template if provided.
        String promptTemplate = chatApp.getPrompt();
        return PromptTemplate.from(promptTemplate).apply(variable);
    }

    @Override
    public void afterPropertiesSet() {
        SqlGenStrategyFactory
                .addSqlGenerationForFactory(LLMReq.SqlGenType.ONE_PASS_SELF_CONSISTENCY, this);
    }
}
