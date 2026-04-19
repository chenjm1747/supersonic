package com.tencent.supersonic.headless.core.text2sql.service.impl;

import com.tencent.supersonic.common.pojo.ChatModelConfig;
import com.tencent.supersonic.headless.core.text2sql.service.SqlGeneratorService;
import dev.langchain4j.model.chat.ChatLanguageModel;
import dev.langchain4j.provider.ModelProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class DefaultSqlGeneratorService implements SqlGeneratorService {
    private static final Logger log = LoggerFactory.getLogger(DefaultSqlGeneratorService.class);

    private static final String SQL_GENERATION_PROMPT = """
            你是专业的 SQL 生成专家，擅长根据表结构信息将自然语言转换为准确的 SQL 查询。

            ## 可用的表结构信息
            %s

            ## 当前时间
            %s

            ## 业务规则
            1. MySQL 数据库，SQL 语句使用标准语法
            2. 字段名和表名使用反引号包裹，如 `customer`.`name`
            3. 字符串值使用单引号，如 WHERE `yhlx` = '居民'
            4. 金额比较使用 DECIMAL 类型，注意精度
            5. 日期时间使用 'YYYY-MM-DD' 或 'YYYY-MM-DD HH:MI:SS' 格式
            6. 采暖期 cnq 格式为 '2025-2026' 这样的字符串

            ## 输出要求
            1. 只输出 SQL 语句，不要其他解释
            2. SQL 语句必须完整，可直接执行
            3. 使用合理的 JOIN 连接表
            4. 注意字段的类型匹配

            ## 用户问题
            %s

            ## 生成的 SQL
            """;

    @Override
    public String generate(String question, String schemaContext) {
        try {
            ChatModelConfig modelConfig = getChatModelConfig();
            ChatLanguageModel chatModel = ModelProvider.getChatModel(modelConfig);

            String prompt = String.format(SQL_GENERATION_PROMPT, schemaContext,
                    LocalDateTime.now().toString(), question);

            String response = chatModel.generate(prompt);
            return extractSql(response);
        } catch (Exception e) {
            log.error("Failed to generate SQL for question: {}", question, e);
            return "ERROR: " + e.getMessage();
        }
    }

    private ChatModelConfig getChatModelConfig() {
        try {
            return ChatModelConfig.builder().provider("OPEN_AI")
                    .baseUrl("https://api.minimaxi.com/v1").modelName("MiniMax-M2.7")
                    .temperature(0.0).timeOut(120L).build();
        } catch (Exception e) {
            log.warn("Failed to get ChatModelConfig, using default", e);
            return ChatModelConfig.builder().provider("OPEN_AI")
                    .baseUrl("https://api.minimaxi.com/v1").modelName("MiniMax-M2.7")
                    .temperature(0.0).timeOut(120L).build();
        }
    }

    private String extractSql(String response) {
        if (response == null || response.isEmpty()) {
            return "";
        }

        String trimmed = response.trim();

        if (trimmed.startsWith("```sql")) {
            trimmed = trimmed.substring(5);
        } else if (trimmed.startsWith("```")) {
            trimmed = trimmed.substring(3);
        }

        if (trimmed.endsWith("```")) {
            trimmed = trimmed.substring(0, trimmed.length() - 3);
        }

        trimmed = trimmed.trim();

        int semicolonIndex = trimmed.indexOf(';');
        if (semicolonIndex > 0 && semicolonIndex < trimmed.length() - 1) {
            trimmed = trimmed.substring(0, semicolonIndex + 1);
        }

        return trimmed;
    }
}
