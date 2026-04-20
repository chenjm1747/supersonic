package com.tencent.supersonic.headless.core.wiki.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.tencent.supersonic.common.util.JsonUtil;
import com.tencent.supersonic.headless.core.wiki.dto.KnowledgeCardGenerateResp;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@UtilityClass
public class KnowledgeCardRespParser {

    public static KnowledgeCardGenerateResp parse(String jsonResponse) {
        KnowledgeCardGenerateResp resp = new KnowledgeCardGenerateResp();
        try {
            // 尝试去除 markdown 代码块
            String jsonStr = jsonResponse.trim();
            if (jsonStr.startsWith("```")) {
                int firstBrace = jsonStr.indexOf('{');
                int lastBrace = jsonStr.lastIndexOf('}');
                if (firstBrace >= 0 && lastBrace > firstBrace) {
                    jsonStr = jsonStr.substring(firstBrace, lastBrace + 1);
                }
            }

            JsonNode root = JsonUtil.readTree(jsonStr);

            if (root.has("title")) {
                resp.setTitle(root.get("title").asText());
            }
            if (root.has("cardType")) {
                resp.setCardType(root.get("cardType").asText());
            }
            if (root.has("content")) {
                resp.setContent(root.get("content").toString());
            }
            if (root.has("confidence")) {
                resp.setConfidence(new BigDecimal(root.get("confidence").asText()));
            }
            if (root.has("tags")) {
                List<String> tags = new ArrayList<>();
                root.get("tags").forEach(t -> tags.add(t.asText()));
                resp.setTags(tags);
            }
            if (root.has("extractedFrom")) {
                List<String> sources = new ArrayList<>();
                root.get("extractedFrom").forEach(s -> sources.add(s.asText()));
                resp.setExtractedFrom(sources);
            }
        } catch (Exception e) {
            log.warn("Failed to parse LLM response", e);
        }
        return resp;
    }
}