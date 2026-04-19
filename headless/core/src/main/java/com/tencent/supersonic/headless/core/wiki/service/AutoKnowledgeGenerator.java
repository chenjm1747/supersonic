package com.tencent.supersonic.headless.core.wiki.service;

import com.alibaba.fastjson.JSON;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
@RequiredArgsConstructor
public class AutoKnowledgeGenerator {
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService entityService;
    private final WikiLinkService linkService;

    public List<WikiKnowledgeCard> generateFromTableSchema(WikiEntity table) {
        List<WikiKnowledgeCard> cards = new ArrayList<>();

        try {
            List<WikiEntity> columns = entityService.getChildEntities(table.getEntityId());

            for (WikiEntity column : columns) {
                // 语义映射
                WikiKnowledgeCard mappingCard = generateSemanticMapping(table, column);
                if (mappingCard != null) {
                    cards.add(mappingCard);
                }

                // 业务规则
                WikiKnowledgeCard ruleCard = generateBusinessRule(table, column);
                if (ruleCard != null) {
                    cards.add(ruleCard);
                }

                // 使用模式
                WikiKnowledgeCard patternCard = generateUsagePattern(table, column);
                if (patternCard != null) {
                    cards.add(patternCard);
                }
            }

            // 指标定义
            cards.addAll(generateMetricDefinitions(table, columns));

        } catch (Exception e) {
            log.error("Error generating knowledge from table schema: {}", table.getEntityId(), e);
        }

        return cards;
    }

    private WikiKnowledgeCard generateSemanticMapping(WikiEntity table, WikiEntity column) {
        if (isMeaninglessField(column.getName())) {
            return null;
        }

        String term = column.getDisplayName();
        if (term == null || term.isEmpty()) {
            term = column.getName();
        }

        // Check if mapping already exists
        if (knowledgeService.existsMapping(table.getEntityId(), term, column.getName())) {
            return null;
        }

        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setCardId(generateCardId(table, column, "SEMANTIC_MAPPING"));
        card.setEntityId(table.getEntityId());
        card.setCardType("SEMANTIC_MAPPING");
        card.setTitle(term + " → " + column.getName() + " 映射");

        Map<String, String> content = new HashMap<>();
        content.put("term", term);
        content.put("field", column.getName());
        content.put("table", table.getName());
        if (column.getDescription() != null) {
            content.put("description", column.getDescription());
        }
        card.setContent(JSON.toJSONString(content));

        card.setConfidence(BigDecimal.valueOf(0.7));
        card.setStatus("AUTO_GENERATED");
        card.setExtractedFrom(List.of("AUTO_EXTRACTED"));

        return card;
    }

    private WikiKnowledgeCard generateBusinessRule(WikiEntity table, WikiEntity column) {
        Map<String, Object> properties = column.getProperties();
        if (properties == null) {
            return null;
        }

        Object businessNoteObj = properties.get("businessNote");
        if (businessNoteObj == null) {
            return null;
        }
        String businessNote = businessNoteObj.toString();
        if (businessNote == null || businessNote.isEmpty()) {
            return null;
        }

        BusinessRule rule = parseBusinessNote(businessNote);
        if (rule == null) {
            return null;
        }

        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setCardId(generateCardId(table, column, "BUSINESS_RULE"));
        card.setEntityId(table.getEntityId());
        card.setCardType("BUSINESS_RULE");
        card.setTitle(rule.getMeaning());

        Map<String, Object> content = new HashMap<>();
        content.put("condition", rule.getCondition());
        content.put("meaning", rule.getMeaning());
        content.put("priority", rule.getPriority());
        content.put("field", column.getName());
        card.setContent(JSON.toJSONString(content));

        card.setConfidence(BigDecimal.valueOf(0.8));
        card.setStatus("AUTO_GENERATED");
        card.setExtractedFrom(List.of("AUTO_EXTRACTED"));

        return card;
    }

    private WikiKnowledgeCard generateUsagePattern(WikiEntity table, WikiEntity column) {
        // Generate basic usage pattern based on data type
        Map<String, Object> props = column.getProperties();
        String dataType = props != null && props.get("dataType") != null ? props.get("dataType").toString() : null;
        if (dataType == null) {
            return null;
        }

        String patternName = null;
        String pattern = null;

        if (dataType.contains("VARCHAR") || dataType.contains("CHAR")) {
            patternName = "字符串精确匹配";
            pattern = "WHERE " + column.getName() + " = ?";
        } else if (dataType.contains("DATE") || dataType.contains("TIME")) {
            patternName = "日期范围查询";
            pattern = "WHERE " + column.getName() + " BETWEEN ? AND ?";
        } else if (dataType.contains("INT") || dataType.contains("DECIMAL") || dataType.contains("NUMERIC")) {
            patternName = "数值范围筛选";
            pattern = "WHERE " + column.getName() + " > ? AND " + column.getName() + " < ?";
        } else {
            return null;
        }

        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setCardId(generateCardId(table, column, "USAGE_PATTERN"));
        card.setEntityId(table.getEntityId());
        card.setCardType("USAGE_PATTERN");
        card.setTitle(patternName + " - " + column.getName());

        Map<String, String> content = new HashMap<>();
        content.put("pattern", pattern);
        content.put("field", column.getName());
        content.put("dataType", dataType);
        card.setContent(JSON.toJSONString(content));

        card.setConfidence(BigDecimal.valueOf(0.6));
        card.setStatus("AUTO_GENERATED");
        card.setExtractedFrom(List.of("AUTO_EXTRACTED"));

        return card;
    }

    private List<WikiKnowledgeCard> generateMetricDefinitions(WikiEntity table, List<WikiEntity> columns) {
        List<WikiKnowledgeCard> cards = new ArrayList<>();

        // Check if this table has amount-related columns
        for (WikiEntity column : columns) {
            String name = column.getName().toLowerCase();
            if (name.contains("amount") || name.contains("amt") || name.contains("金额") || name.contains("总额")) {
                WikiKnowledgeCard card = new WikiKnowledgeCard();
                card.setCardId(generateCardId(table, column, "METRIC_DEFINITION"));
                card.setEntityId(table.getEntityId());
                card.setCardType("METRIC_DEFINITION");
                card.setTitle(column.getDisplayName() + " 汇总");

                Map<String, String> content = new HashMap<>();
                content.put("metric", column.getDisplayName() + " 汇总");
                content.put("formula", "SUM(" + column.getName() + ")");
                content.put("field", column.getName());
                card.setContent(JSON.toJSONString(content));

                card.setConfidence(BigDecimal.valueOf(0.5));
                card.setStatus("AUTO_GENERATED");
                card.setExtractedFrom(List.of("AUTO_EXTRACTED"));

                cards.add(card);
            }
        }

        return cards;
    }

    private BusinessRule parseBusinessNote(String note) {
        // 解析 "qfje > 0 表示存在欠费"
        Pattern pattern = Pattern.compile("(.*?)\\s*>(>|<=)?\\s*(.*?)\\s*表示(.*)");
        Matcher matcher = pattern.matcher(note);
        if (matcher.matches()) {
            String field = matcher.group(1).trim();
            String operator = matcher.group(2) != null ? matcher.group(2) : ">";
            String value = matcher.group(3).trim();
            String meaning = matcher.group(4).trim();
            String condition = field + " " + operator + " " + value;

            return new BusinessRule(condition, meaning, 1);
        }

        // 尝试解析 "qfje = 0 表示已结清" 格式
        Pattern pattern2 = Pattern.compile("(.*?)\\s*=\\s*(.*?)\\s*表示(.*)");
        Matcher matcher2 = pattern2.matcher(note);
        if (matcher2.matches()) {
            String field = matcher2.group(1).trim();
            String value = matcher2.group(2).trim();
            String meaning = matcher2.group(3).trim();
            String condition = field + " = " + value;

            return new BusinessRule(condition, meaning, 1);
        }

        return null;
    }

    private boolean isMeaninglessField(String fieldName) {
        if (fieldName == null || fieldName.isEmpty()) {
            return true;
        }
        String lower = fieldName.toLowerCase();
        return lower.equals("id") || lower.equals("created_at") || lower.equals("updated_at")
            || lower.equals("create_time") || lower.equals("modify_time") || lower.equals("delete_flag");
    }

    private String generateCardId(WikiEntity table, WikiEntity column, String cardType) {
        return "kc:" + table.getEntityId() + ":" + cardType + ":" + column.getName();
    }

    private static class BusinessRule {
        private String condition;
        private String meaning;
        private Integer priority;

        public BusinessRule(String condition, String meaning, Integer priority) {
            this.condition = condition;
            this.meaning = meaning;
            this.priority = priority;
        }

        public String getCondition() {
            return condition;
        }

        public String getMeaning() {
            return meaning;
        }

        public Integer getPriority() {
            return priority;
        }
    }
}
