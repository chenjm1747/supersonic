package com.tencent.supersonic.headless.chat.parser.llm;

import com.google.common.collect.Lists;
import com.tencent.supersonic.common.pojo.Text2SQLExemplar;
import com.tencent.supersonic.common.pojo.enums.DataFormatTypeEnum;
import com.tencent.supersonic.common.pojo.enums.EngineType;
import com.tencent.supersonic.common.service.ExemplarService;
import com.tencent.supersonic.common.util.StringUtil;
import com.tencent.supersonic.headless.chat.parser.ParserConfig;
import com.tencent.supersonic.headless.chat.query.llm.s2sql.LLMReq;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.stream.Collectors;

import static com.tencent.supersonic.common.pojo.DimensionConstants.*;
import static com.tencent.supersonic.headless.chat.parser.ParserConfig.*;

@Component
@Slf4j
public class PromptHelper {

    @Autowired
    private ParserConfig parserConfig;

    @Autowired
    private ExemplarService exemplarService;

    public List<List<Text2SQLExemplar>> getFewShotExemplars(LLMReq llmReq) {
        int exemplarRecallNumber =
                Integer.parseInt(parserConfig.getParameterValue(PARSER_EXEMPLAR_RECALL_NUMBER));
        int fewShotNumber =
                Integer.parseInt(parserConfig.getParameterValue(PARSER_FEW_SHOT_NUMBER));
        int selfConsistencyNumber =
                Integer.parseInt(parserConfig.getParameterValue(PARSER_SELF_CONSISTENCY_NUMBER));

        List<Text2SQLExemplar> exemplars = Lists.newArrayList();
        exemplars.addAll(llmReq.getDynamicExemplars());

        int recallSize = exemplarRecallNumber - llmReq.getDynamicExemplars().size();
        if (recallSize > 0) {
            exemplars.addAll(exemplarService.recallExemplars(llmReq.getQueryText(), recallSize));
        }

        List<List<Text2SQLExemplar>> results = new ArrayList<>();
        // use random collection of exemplars for each self-consistency inference
        for (int i = 0; i < selfConsistencyNumber; i++) {
            List<Text2SQLExemplar> shuffledList = new ArrayList<>(exemplars);
            List<Text2SQLExemplar> same = shuffledList.stream() // 相似度极高的话，先找出来
                    .filter(e -> e.getSimilarity() > 0.989).collect(Collectors.toList());
            List<Text2SQLExemplar> noSame = shuffledList.stream()
                    .filter(e -> e.getSimilarity() <= 0.989).collect(Collectors.toList());
            if ((noSame.size() - same.size()) > fewShotNumber) {// 去除部分最低分
                noSame.sort(Comparator.comparingDouble(Text2SQLExemplar::getSimilarity));
                noSame = noSame.subList((noSame.size() - fewShotNumber) / 2, noSame.size());
            }
            Text2SQLExemplar mostSimilar = noSame.get(noSame.size() - 1);
            Collections.shuffle(noSame);
            List<Text2SQLExemplar> ts;
            if (same.size() > 0) {// 一样的话，必须作为提示语
                ts = new ArrayList<>();
                int needSize = Math.min(noSame.size() + same.size(), fewShotNumber);
                if (needSize > same.size()) {
                    ts.addAll(noSame.subList(0, needSize - same.size()));
                }
                ts.addAll(same);
            } else { // 至少要一个最像的
                ts = noSame.subList(0, Math.min(noSame.size(), fewShotNumber));
                if (!ts.contains(mostSimilar)) {
                    ts.remove(ts.size() - 1);
                    ts.add(mostSimilar);
                }
            }
            results.add(ts);
        }
        return results;
    }

    public String buildSideInformation(LLMReq llmReq) {
        String currentDate = llmReq.getCurrentDate();
        List<String> sideInfos = Lists.newArrayList();
        sideInfos.add(String.format("CurrentDate=[%s]", currentDate));

        if (StringUtils.isNotEmpty(llmReq.getPriorExts())) {
            sideInfos.add(String.format("PriorKnowledge=[%s]", llmReq.getPriorExts()));
        }

        LLMReq.LLMSchema schema = llmReq.getSchema();
        if (!isSupportWith(schema.getDatabaseType(), schema.getDatabaseVersion())) {
            sideInfos.add("[Database does not support with statement]");
        }

        String termStr = buildTermStr(llmReq);
        if (StringUtils.isNotEmpty(termStr)) {
            sideInfos.add(String.format("DomainTerms=[%s]", termStr));
        }

        return String.join(",", sideInfos);
    }

    /**
     * Build enhanced side information including parsed question details.
     */
    public String buildEnhancedSideInfo(LLMReq llmReq) {
        StringBuilder sideInfo = new StringBuilder();

        // Base side information
        sideInfo.append(buildSideInformation(llmReq));

        // Add parsed question details if available
        if (llmReq.getParsedQuestion() != null) {
            Object parsedQ = llmReq.getParsedQuestion();
            // Use reflection or cast to access parsed question details
            // For now, we add a generic enhancement marker
            sideInfo.append(",EnhancedParsing=[enabled]");
        }

        // Add intent-based guidance
        if (llmReq.getIntentResult() != null) {
            Object intentR = llmReq.getIntentResult();
            sideInfo.append(",IntentGuidance=[enabled]");
        }

        return sideInfo.toString();
    }

    public String buildSchemaStr(LLMReq llmReq) {
        String tableStr = llmReq.getSchema().getDataSetName();

        List<String> metrics = Lists.newArrayList();
        llmReq.getSchema().getMetrics().forEach(metric -> {
            StringBuilder metricStr = new StringBuilder();
            metricStr.append("<");
            metricStr.append(metric.getName());
            if (!CollectionUtils.isEmpty(metric.getAlias())) {
                StringBuilder alias = new StringBuilder();
                metric.getAlias().forEach(a -> alias.append(a).append(","));
                metricStr.append(" ALIAS '").append(alias).append("'");
            }
            if (StringUtils.isNotEmpty(metric.getDataFormatType())) {
                String dataFormatType = metric.getDataFormatType();
                if (DataFormatTypeEnum.DECIMAL.getName().equalsIgnoreCase(dataFormatType)
                        || DataFormatTypeEnum.PERCENT.getName().equalsIgnoreCase(dataFormatType)) {
                    metricStr.append(" FORMAT '").append(dataFormatType).append("'");
                }
            }
            if (StringUtils.isNotEmpty(metric.getDescription())) {
                metricStr.append(" COMMENT '").append(metric.getDescription()).append("'");
            }
            if (StringUtils.isNotEmpty(metric.getDefaultAgg())) {
                metricStr.append(" AGGREGATE '").append(metric.getDefaultAgg().toUpperCase())
                        .append("'");
            }
            metricStr.append(">");
            metrics.add(metricStr.toString());
        });

        List<String> dimensions = Lists.newArrayList();
        llmReq.getSchema().getDimensions().forEach(dimension -> {
            StringBuilder dimensionStr = new StringBuilder();
            dimensionStr.append("<");
            dimensionStr.append(dimension.getName());
            if (!CollectionUtils.isEmpty(dimension.getAlias())) {
                StringBuilder alias = new StringBuilder();
                dimension.getAlias().forEach(a -> alias.append(a).append(";"));
                dimensionStr.append(" ALIAS '").append(alias).append("'");
            }
            if (Objects.nonNull(dimension.getExtInfo().get(DIMENSION_DATA_TYPE))) {
                dimensionStr.append(" DATATYPE '")
                        .append(dimension.getExtInfo().get(DIMENSION_DATA_TYPE)).append("'");
            }
            if (StringUtils.isNotEmpty(dimension.getTimeFormat())) {
                dimensionStr.append(" FORMAT '").append(dimension.getTimeFormat()).append("'");
            }
            if (StringUtils.isNotEmpty(dimension.getDescription())) {
                dimensionStr.append(" COMMENT '").append(dimension.getDescription()).append("'");
            }
            dimensionStr.append(">");
            dimensions.add(dimensionStr.toString());
        });

        List<String> values = Lists.newArrayList();
        List<LLMReq.ElementValue> elementValueList = llmReq.getSchema().getValues();
        if (elementValueList != null) {
            elementValueList.forEach(value -> {
                StringBuilder valueStr = new StringBuilder();
                String fieldName = value.getFieldName();
                String fieldValue = value.getFieldValue();
                valueStr.append(String.format("<%s='%s'>", fieldName, fieldValue));
                values.add(valueStr.toString());
            });
        }

        String partitionTimeStr = "";
        if (llmReq.getSchema().getPartitionTime() != null) {
            partitionTimeStr =
                    String.format("%s FORMAT '%s'", llmReq.getSchema().getPartitionTime().getName(),
                            llmReq.getSchema().getPartitionTime().getTimeFormat());
        }

        String primaryKeyStr = "";
        if (llmReq.getSchema().getPrimaryKey() != null) {
            primaryKeyStr = String.format("%s", llmReq.getSchema().getPrimaryKey().getName());
        }

        String databaseTypeStr = "";
        if (llmReq.getSchema().getDatabaseType() != null) {
            databaseTypeStr = llmReq.getSchema().getDatabaseType();
        }
        String databaseVersionStr = "";
        if (llmReq.getSchema().getDatabaseVersion() != null) {
            databaseVersionStr = llmReq.getSchema().getDatabaseVersion();
        }

        String template =
                "DatabaseType=[%s], DatabaseVersion=[%s], Table=[%s], PartitionTimeField=[%s], PrimaryKeyField=[%s], "
                        + "Metrics=[%s], Dimensions=[%s], Values=[%s]";
        return String.format(template, databaseTypeStr, databaseVersionStr, tableStr,
                partitionTimeStr, primaryKeyStr, String.join(",", metrics),
                String.join(",", dimensions), String.join(",", values));
    }

    private String buildTermStr(LLMReq llmReq) {
        List<LLMReq.Term> terms = llmReq.getTerms();
        List<String> termStr = Lists.newArrayList();
        terms.forEach(term -> {
            StringBuilder termsDesc = new StringBuilder();
            String description = term.getDescription();
            termsDesc.append(String.format("<%s COMMENT '%s'>", term.getName(), description));
            termStr.add(termsDesc.toString());
        });
        String ret = "";
        if (!termStr.isEmpty()) {
            ret = String.join(",", termStr);
        }

        return ret;
    }

    public static boolean isSupportWith(String type, String version) {
        if (type.equalsIgnoreCase(EngineType.MYSQL.getName()) && Objects.nonNull(version)
                && StringUtil.compareVersion(version, "8.0") < 0) {
            return false;
        }
        if (type.equalsIgnoreCase(EngineType.CLICKHOUSE.getName()) && Objects.nonNull(version)
                && StringUtil.compareVersion(version, "20.4") < 0) {
            return false;
        }
        return true;
    }

    /**
     * Build contextual prompt from conversation history for multi-turn dialogue support. This
     * enables the LLM to understand references like "these users", "the same period", and maintain
     * context across multiple query rounds.
     */
    public String buildContextAwarePrompt(LLMReq llmReq) {
        List<LLMReq.ConversationHistory> history = llmReq.getContextHistory();
        if (CollectionUtils.isEmpty(history)) {
            return "";
        }

        StringBuilder prompt = new StringBuilder();
        prompt.append("\n## Conversation History (Multi-turn Context)\n");
        prompt.append(
                "Please understand the user's current question in the context of the conversation history below.\n");
        prompt.append(
                "If the current question refers to previous context (e.g., 'these users', 'the same period', 'continue'), ");
        prompt.append(
                "use the historical context to understand what entities or conditions are being referenced.\n\n");

        for (LLMReq.ConversationHistory ctx : history) {
            prompt.append(String.format("【Round %d】\n", ctx.getRoundNumber()));
            prompt.append(String.format("User: %s\n", ctx.getUserMessage()));
            if (StringUtils.isNotEmpty(ctx.getGeneratedSql())) {
                prompt.append(String.format("Generated SQL: %s\n", ctx.getGeneratedSql()));
            }
            if (StringUtils.isNotEmpty(ctx.getContextValue())) {
                prompt.append(String.format("Context: %s\n", ctx.getContextValue()));
            }
            if (ctx.getReferencedEntities() != null && !ctx.getReferencedEntities().isEmpty()) {
                prompt.append(String.format("Referenced Entities: %s\n",
                        String.join(", ", ctx.getReferencedEntities())));
            }
            prompt.append("\n");
        }

        prompt.append("Current Question: ").append(llmReq.getQueryText()).append("\n");
        prompt.append("---\n");
        prompt.append("Important: When generating SQL for the current question, ");
        prompt.append("consider the conversation history to resolve any implicit references.\n");

        return prompt.toString();
    }

    /**
     * Build complete side information including context-aware prompt.
     */
    public String buildSideInformationWithContext(LLMReq llmReq) {
        String baseSideInfo = buildSideInformation(llmReq);
        String contextPrompt = buildContextAwarePrompt(llmReq);

        if (StringUtils.isEmpty(contextPrompt)) {
            return baseSideInfo;
        }

        return baseSideInfo + contextPrompt;
    }

    // ==================== Wiki-SQL Prompt Methods ====================

    public static final String WIKI_SQL_PROMPT_TEMPLATE = """
        # Role: 你是数据分析师，擅长将自然语言转换为 SQL

        # Task: 根据用户的自然语言查询，结合提供的 Wiki 知识，生成准确的 SQL

        ## Wiki 知识上下文

        ### 业务术语映射
        {semantic_mappings}

        ### 业务规则
        {business_rules}

        ### 常用查询模式
        {usage_patterns}

        ### 指标定义
        {metric_definitions}

        ## 数据库表结构
        {schema_info}

        ## 当前会话上下文
        {conversation_context}

        # 用户查询
        {query_text}

        # 输出要求
        1. 只输出 SQL 语句，不要其他解释
        2. SQL 必须基于上述表结构
        3. 如需时间范围筛选，使用 cnq = '{default_time_range}'
        4. 如果 Wiki 知识与表结构冲突，以表结构为准
        5. 必须使用 Wiki 知识中的字段映射，不要自行推断字段名

        # SQL 生成
        """;

    public String buildWikiSqlPrompt(com.tencent.supersonic.headless.chat.query.llm.wiki.WikiRetrievalResult retrieval,
                                     com.tencent.supersonic.headless.core.wiki.dto.ConversationContext ctx,
                                     String queryText) {
        Map<String, String> placeholders = new HashMap<>();
        placeholders.put("semantic_mappings", buildSemanticMappings(retrieval));
        placeholders.put("business_rules", buildBusinessRules(retrieval));
        placeholders.put("usage_patterns", buildUsagePatterns(retrieval));
        placeholders.put("metric_definitions", buildMetricDefinitions(retrieval));
        placeholders.put("schema_info", buildSchemaInfo(retrieval));
        placeholders.put("conversation_context", buildConversationContext(ctx));
        placeholders.put("query_text", queryText);
        placeholders.put("default_time_range", getDefaultTimeRange());

        return interpolateTemplate(WIKI_SQL_PROMPT_TEMPLATE, placeholders);
    }

    private String buildSemanticMappings(com.tencent.supersonic.headless.chat.query.llm.wiki.WikiRetrievalResult retrieval) {
        if (retrieval == null || retrieval.getSemanticMappings() == null || retrieval.getSemanticMappings().isEmpty()) {
            return "无";
        }
        return retrieval.getSemanticMappings().stream()
            .map(m -> String.format("- %s → %s (%s)", m.getTerm(), m.getField(),
                m.getTable() != null ? m.getTable() : ""))
            .collect(Collectors.joining("\n"));
    }

    private String buildBusinessRules(com.tencent.supersonic.headless.chat.query.llm.wiki.WikiRetrievalResult retrieval) {
        if (retrieval == null || retrieval.getBusinessRules() == null || retrieval.getBusinessRules().isEmpty()) {
            return "无";
        }
        return retrieval.getBusinessRules().stream()
            .map(r -> String.format("- %s: %s", r.getMeaning(), r.getCondition()))
            .collect(Collectors.joining("\n"));
    }

    private String buildUsagePatterns(com.tencent.supersonic.headless.chat.query.llm.wiki.WikiRetrievalResult retrieval) {
        if (retrieval == null || retrieval.getUsagePatterns() == null || retrieval.getUsagePatterns().isEmpty()) {
            return "无";
        }
        return retrieval.getUsagePatterns().stream()
            .map(p -> String.format("- %s: %s", p.getName(), p.getPattern()))
            .collect(Collectors.joining("\n"));
    }

    private String buildMetricDefinitions(com.tencent.supersonic.headless.chat.query.llm.wiki.WikiRetrievalResult retrieval) {
        if (retrieval == null || retrieval.getMetricDefinitions() == null || retrieval.getMetricDefinitions().isEmpty()) {
            return "无";
        }
        return retrieval.getMetricDefinitions().stream()
            .map(m -> String.format("- %s = %s", m.getMetric(), m.getFormula()))
            .collect(Collectors.joining("\n"));
    }

    private String buildSchemaInfo(com.tencent.supersonic.headless.chat.query.llm.wiki.WikiRetrievalResult retrieval) {
        if (retrieval == null || retrieval.getEntities() == null || retrieval.getEntities().isEmpty()) {
            return "无表结构信息";
        }
        StringBuilder sb = new StringBuilder();
        for (com.tencent.supersonic.headless.core.wiki.dto.WikiEntity entity : retrieval.getEntities()) {
            if ("TABLE".equals(entity.getEntityType())) {
                sb.append(entity.getDisplayName()).append("(").append(entity.getName()).append(")\n");
                // Note: In a full implementation, we would fetch and display columns here
            }
        }
        return sb.length() > 0 ? sb.toString() : "无表结构信息";
    }

    private String buildConversationContext(com.tencent.supersonic.headless.core.wiki.dto.ConversationContext ctx) {
        if (ctx == null) {
            return "无";
        }
        StringBuilder sb = new StringBuilder();
        if (ctx.getTimeRange() != null) {
            sb.append(String.format("- 时间范围: %s\n", ctx.getTimeRange()));
        }
        if (ctx.getEntity() != null) {
            sb.append(String.format("- 当前实体: %s\n", ctx.getEntity()));
        }
        if (ctx.getFilters() != null && !ctx.getFilters().isEmpty()) {
            sb.append(String.format("- 筛选条件: %s\n", String.join(", ", ctx.getFilters())));
        }
        return sb.length() > 0 ? sb.toString() : "无";
    }

    private String interpolateTemplate(String template, Map<String, String> placeholders) {
        String result = template;
        for (Map.Entry<String, String> entry : placeholders.entrySet()) {
            result = result.replace("{" + entry.getKey() + "}", entry.getValue() != null ? entry.getValue() : "");
        }
        return result;
    }

    private String getDefaultTimeRange() {
        // Return current quarter as default
        return "2026Q1";
    }
}
