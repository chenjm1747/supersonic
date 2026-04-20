package com.tencent.supersonic.headless.core.wiki.util;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;

import java.util.List;

public class KnowledgeCardPromptBuilder {

    public static String buildPrompt(String cardType, String title, WikiEntity entity,
            List<WikiEntity> childEntities, List<WikiEntity> relatedEntities) {
        StringBuilder prompt = new StringBuilder();
        prompt.append("你是一个知识卡片生成助手。请根据以下信息生成知识卡片内容。\n\n");

        // 实体信息
        prompt.append("## 实体信息\n");
        prompt.append("- 名称: ").append(entity.getName()).append("\n");
        prompt.append("- 中文名: ").append(nullSafe(entity.getDisplayName())).append("\n");
        prompt.append("- 描述: ").append(nullSafe(entity.getDescription())).append("\n\n");

        // 字段信息
        if (childEntities != null && !childEntities.isEmpty()) {
            prompt.append("## 字段信息\n");
            for (WikiEntity child : childEntities) {
                prompt.append("- ").append(child.getName());
                if (child.getProperties() != null && child.getProperties().containsKey("dataType")) {
                    prompt.append(" (").append(child.getProperties().get("dataType")).append(")");
                }
                prompt.append(": ").append(nullSafe(child.getDescription())).append("\n");
            }
            prompt.append("\n");
        }

        // 关联实体
        if (relatedEntities != null && !relatedEntities.isEmpty()) {
            prompt.append("## 关联实体\n");
            for (WikiEntity related : relatedEntities) {
                prompt.append("- ").append(related.getName())
                      .append(": ").append(nullSafe(related.getDescription())).append("\n");
            }
            prompt.append("\n");
        }

        // 用户输入
        prompt.append("## 卡片类型\n");
        prompt.append(cardType != null ? cardType : "待确定").append("\n\n");
        prompt.append("## 标题\n");
        prompt.append(title != null ? title : "待生成").append("\n\n");

        // 生成要求
        prompt.append("请生成一个知识卡片，内容包含：\n");
        prompt.append("1. title: 标题（可直接使用提供的标题）\n");
        prompt.append("2. cardType: 卡片类型\n");
        prompt.append("3. content: JSON格式，描述关系细节\n");
        prompt.append("4. confidence: 置信度 (0-1之间的小数)\n");
        prompt.append("5. tags: 标签列表（3-5个）\n");
        prompt.append("6. extractedFrom: 内容来源\n\n");
        prompt.append("只返回JSON格式，不要包含其他文字。\n");

        return prompt.toString();
    }

    private static String nullSafe(String str) {
        return str != null ? str : "";
    }
}