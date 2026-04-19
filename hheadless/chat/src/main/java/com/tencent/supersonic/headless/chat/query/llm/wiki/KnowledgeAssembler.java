package com.tencent.supersonic.headless.chat.query.llm.wiki;

import com.tencent.supersonic.headless.core.wiki.dto.ConversationContext;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
public class KnowledgeAssembler {

    public String assemble(WikiRetrievalResult retrieval, IntentDetector.Intent intent) {
        StringBuilder sb = new StringBuilder();

        // 语义映射
        if (retrieval.getSemanticMappings() != null && !retrieval.getSemanticMappings().isEmpty()) {
            sb.append("### 业务术语映射\n");
            for (WikiRetrievalResult.SemanticMapping mapping : retrieval.getSemanticMappings()) {
                sb.append(String.format("- %s → %s (%s)\n",
                    mapping.getTerm(), mapping.getField(),
                    mapping.getTable() != null ? mapping.getTable() : ""));
            }
            sb.append("\n");
        }

        // 业务规则
        if (retrieval.getBusinessRules() != null && !retrieval.getBusinessRules().isEmpty()) {
            sb.append("### 业务规则\n");
            for (WikiRetrievalResult.BusinessRule rule : retrieval.getBusinessRules()) {
                sb.append(String.format("- %s: %s\n", rule.getMeaning(), rule.getCondition()));
            }
            sb.append("\n");
        }

        // 使用模式
        if (retrieval.getUsagePatterns() != null && !retrieval.getUsagePatterns().isEmpty()) {
            sb.append("### 常用查询模式\n");
            for (WikiRetrievalResult.UsagePattern pattern : retrieval.getUsagePatterns()) {
                sb.append(String.format("- %s: %s\n", pattern.getName(), pattern.getPattern()));
            }
            sb.append("\n");
        }

        // 指标定义
        if (retrieval.getMetricDefinitions() != null && !retrieval.getMetricDefinitions().isEmpty()) {
            sb.append("### 指标定义\n");
            for (WikiRetrievalResult.MetricDefinition metric : retrieval.getMetricDefinitions()) {
                sb.append(String.format("- %s = %s\n", metric.getMetric(), metric.getFormula()));
            }
            sb.append("\n");
        }

        return sb.toString();
    }

    public String buildConversationContext(ConversationContext ctx) {
        if (ctx == null) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("### 当前会话上下文\n");

        if (ctx.getTimeRange() != null) {
            sb.append(String.format("- 时间范围: %s\n", ctx.getTimeRange()));
        }
        if (ctx.getEntity() != null) {
            sb.append(String.format("- 当前实体: %s\n", ctx.getEntity()));
        }
        if (ctx.getFilters() != null && !ctx.getFilters().isEmpty()) {
            sb.append(String.format("- 筛选条件: %s\n",
                ctx.getFilters().stream().collect(Collectors.joining(", "))));
        }

        return sb.toString();
    }
}
