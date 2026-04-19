package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import com.tencent.supersonic.headless.core.wiki.dto.ChatMessage;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class WikiChatService {

    private final JdbcTemplate jdbcTemplate;
    private final WikiEntityService entityService;
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService linkService;

    private static final String INSERT_MESSAGE_SQL = """
            INSERT INTO s2_wiki_chat_history
            (conversation_id, user_id, message, intent, response, created_at)
            VALUES (?, ?, ?, ?, ?, ?)
            """;

    private static final String SELECT_BY_CONVERSATION_SQL = """
            SELECT * FROM s2_wiki_chat_history
            WHERE conversation_id = ?
            ORDER BY created_at ASC
            """;

    private static final String SELECT_RECENT_SQL = """
            SELECT * FROM s2_wiki_chat_history
            WHERE user_id = ?
            ORDER BY created_at DESC
            LIMIT ?
            """;

    public WikiChatService(DataSource dataSource, WikiEntityService entityService,
            WikiKnowledgeService knowledgeService) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
        this.entityService = entityService;
        this.knowledgeService = knowledgeService;
        this.linkService = entityService;
    }

    public ChatResponse chat(String userId, String message, String conversationId) {
        log.info("Processing chat message from user {}: {}", userId, message);

        if (conversationId == null || conversationId.isEmpty()) {
            conversationId = UUID.randomUUID().toString();
        }

        ChatResponse response = new ChatResponse();
        response.setConversationId(conversationId);

        try {
            IntentResult intentResult = recognizeIntent(message);
            response.setIntent(intentResult.getIntent().name());

            ChatMessage chatMessage = new ChatMessage();
            chatMessage.setConversationId(conversationId);
            chatMessage.setUserId(userId);
            chatMessage.setMessage(message);
            chatMessage.setIntent(intentResult.getIntent().name());
            chatMessage.setCreatedAt(LocalDateTime.now());
            chatMessage.setStatus("SUCCESS");

            switch (intentResult.getIntent()) {
                case CREATE_CARD:
                    response = handleCreateCard(intentResult, response);
                    chatMessage.setAction("CREATE_CARD");
                    break;
                case UPDATE_CARD:
                    response = handleUpdateCard(intentResult, response);
                    chatMessage.setAction("UPDATE_CARD");
                    break;
                case DELETE_CARD:
                    response = handleDeleteCard(intentResult, response);
                    chatMessage.setAction("DELETE_CARD");
                    break;
                case QUERY_KNOWLEDGE:
                    response = handleQueryKnowledge(intentResult, response);
                    chatMessage.setAction("QUERY");
                    break;
                case EXPLAIN_ENTITY:
                    response = handleExplainEntity(intentResult, response);
                    chatMessage.setAction("EXPLAIN");
                    break;
                default:
                    response.setMessage(
                            "抱歉，我无法理解您的意图。请尝试以下表达方式：\n" + "- 创建知识卡片：创建一张关于[表名]的[类型]卡片，内容是[内容]\n"
                                    + "- 查询知识：告诉我关于[表名]的信息\n" + "- 删除卡片：删除[表名]的[类型]卡片");
                    response.setStatus("UNKNOWN_INTENT");
                    chatMessage.setAction("UNKNOWN");
            }

            chatMessage.setResponse(response.getMessage());
            saveMessage(chatMessage);

        } catch (Exception e) {
            log.error("Error processing chat message", e);
            response.setMessage("处理消息时发生错误: " + e.getMessage());
            response.setStatus("ERROR");
        }

        return response;
    }

    private IntentResult recognizeIntent(String message) {
        IntentResult result = new IntentResult();
        result.setIntent(ChatMessage.Intent.UNKNOWN);

        String lowerMessage = message.toLowerCase();

        if (lowerMessage.contains("创建") || lowerMessage.contains("新建")
                || lowerMessage.contains("添加")) {
            if (lowerMessage.contains("卡片") || lowerMessage.contains("知识")) {
                result.setIntent(ChatMessage.Intent.CREATE_CARD);
            }
        } else if (lowerMessage.contains("修改") || lowerMessage.contains("更新")
                || lowerMessage.contains("编辑")) {
            if (lowerMessage.contains("卡片") || lowerMessage.contains("知识")) {
                result.setIntent(ChatMessage.Intent.UPDATE_CARD);
            }
        } else if (lowerMessage.contains("删除") || lowerMessage.contains("移除")) {
            if (lowerMessage.contains("卡片") || lowerMessage.contains("知识")) {
                result.setIntent(ChatMessage.Intent.DELETE_CARD);
            }
        } else if (lowerMessage.contains("告诉") || lowerMessage.contains("查询")
                || lowerMessage.contains("什么") || lowerMessage.contains("怎样")
                || lowerMessage.contains("如何")) {
            result.setIntent(ChatMessage.Intent.QUERY_KNOWLEDGE);
        } else if (lowerMessage.contains("解释") || lowerMessage.contains("说明")
                || lowerMessage.contains("介绍")) {
            result.setIntent(ChatMessage.Intent.EXPLAIN_ENTITY);
        } else if (lowerMessage.contains("关系") || lowerMessage.contains("关联")
                || lowerMessage.contains("联系")) {
            result.setIntent(ChatMessage.Intent.SUGGEST_RELATION);
        }

        extractEntities(message, result);

        return result;
    }

    private void extractEntities(String message, IntentResult result) {
        Map<String, Object> entities = new HashMap<>();

        Pattern tablePattern = Pattern.compile("(customer|sf_js_t|pay_order|表|表名)");
        Matcher tableMatcher = tablePattern.matcher(message);
        List<String> tables = new ArrayList<>();
        while (tableMatcher.find()) {
            String found = tableMatcher.group();
            if (found.equals("表") || found.equals("表名")) {
                continue;
            }
            tables.add(found);
        }
        if (!tables.isEmpty()) {
            entities.put("tables", tables);
        }

        Pattern cardTypePattern = Pattern.compile("(关系|业务规则|数据模式|使用模式|语义映射|指标定义)");
        Matcher typeMatcher = cardTypePattern.matcher(message);
        List<String> cardTypes = new ArrayList<>();
        while (typeMatcher.find()) {
            cardTypes.add(typeMatcher.group());
        }
        if (!cardTypes.isEmpty()) {
            entities.put("cardTypes", cardTypes);
        }

        Pattern contentPattern = Pattern.compile("内容是[^\n，。,]+");
        Matcher contentMatcher = contentPattern.matcher(message);
        if (contentMatcher.find()) {
            entities.put("content", contentMatcher.group().replace("内容是", ""));
        }

        result.setExtractedEntities(entities);
    }

    private ChatResponse handleCreateCard(IntentResult intentResult, ChatResponse response) {
        Map<String, Object> entities = intentResult.getExtractedEntities();

        if (entities == null || !entities.containsKey("tables")) {
            response.setMessage("请告诉我您想为哪个表创建知识卡片？");
            return response;
        }

        List<String> tables = (List<String>) entities.get("tables");
        String tableName = tables.get(0);
        String entityId = "table:" + tableName;

        WikiEntity entity = entityService.getEntityById(entityId);
        if (entity == null) {
            response.setMessage("找不到表 " + tableName + "，请确认表名是否正确");
            return response;
        }

        String cardType = "BUSINESS_RULE";
        if (entities.containsKey("cardTypes")) {
            List<String> types = (List<String>) entities.get("cardTypes");
            cardType = mapCardType(types.get(0));
        }

        String content = "用户通过对话创建的知识卡片";
        if (entities.containsKey("content")) {
            content = (String) entities.get("content");
        }

        WikiKnowledgeCard card = new WikiKnowledgeCard();
        card.setEntityId(entityId);
        card.setCardType(cardType);
        card.setTitle("对话创建 - " + tableName);
        card.setContent(content);
        card.setConfidence(BigDecimal.valueOf(0.8));

        try {
            WikiKnowledgeCard created = knowledgeService.createCard(card);
            response.setMessage("已为表 " + tableName + " 创建知识卡片！\n" + "- 卡片ID: " + created.getCardId()
                    + "\n" + "- 类型: " + cardType + "\n" + "- 内容: " + content);
            response.setStatus("SUCCESS");
        } catch (Exception e) {
            response.setMessage("创建知识卡片失败: " + e.getMessage());
            response.setStatus("FAILED");
        }

        return response;
    }

    private ChatResponse handleUpdateCard(IntentResult intentResult, ChatResponse response) {
        response.setMessage("更新知识卡片功能正在开发中...");
        return response;
    }

    private ChatResponse handleDeleteCard(IntentResult intentResult, ChatResponse response) {
        response.setMessage("删除知识卡片功能正在开发中...");
        return response;
    }

    private ChatResponse handleQueryKnowledge(IntentResult intentResult, ChatResponse response) {
        Map<String, Object> entities = intentResult.getExtractedEntities();

        if (entities != null && entities.containsKey("tables")) {
            List<String> tables = (List<String>) entities.get("tables");
            String tableName = tables.get(0);
            String entityId = "table:" + tableName;

            WikiEntity entity = entityService.getEntityById(entityId);
            if (entity != null) {
                List<WikiKnowledgeCard> cards = knowledgeService.getCardsByEntityId(entityId);

                StringBuilder sb = new StringBuilder();
                sb.append("关于表 ").append(tableName).append(" 的信息：\n\n");
                sb.append("- 显示名称: ").append(entity.getDisplayName()).append("\n");
                sb.append("- 描述: ")
                        .append(entity.getDescription() != null ? entity.getDescription() : "暂无")
                        .append("\n");
                sb.append("- 类型: ").append(entity.getEntityType()).append("\n\n");

                if (!cards.isEmpty()) {
                    sb.append("知识卡片（共").append(cards.size()).append("个）：\n");
                    for (WikiKnowledgeCard card : cards) {
                        sb.append("- [").append(card.getCardType()).append("] ")
                                .append(card.getContent()).append("\n");
                    }
                } else {
                    sb.append("暂无关联的知识卡片");
                }

                response.setMessage(sb.toString());
                response.setStatus("SUCCESS");
            } else {
                response.setMessage("找不到表 " + tableName);
                response.setStatus("NOT_FOUND");
            }
        } else {
            List<WikiEntity> allEntities = entityService.getAllActiveEntities();
            StringBuilder sb = new StringBuilder("以下是可用的表：\n");
            for (WikiEntity entity : allEntities) {
                if ("TABLE".equals(entity.getEntityType())) {
                    sb.append("- ").append(entity.getName());
                    if (entity.getDisplayName() != null) {
                        sb.append(" (").append(entity.getDisplayName()).append(")");
                    }
                    sb.append("\n");
                }
            }
            sb.append("\n请告诉我您想了解哪个表的信息？");
            response.setMessage(sb.toString());
            response.setStatus("SUCCESS");
        }

        return response;
    }

    private ChatResponse handleExplainEntity(IntentResult intentResult, ChatResponse response) {
        return handleQueryKnowledge(intentResult, response);
    }

    private String mapCardType(String type) {
        switch (type) {
            case "关系":
                return "RELATIONSHIP";
            case "业务规则":
                return "BUSINESS_RULE";
            case "数据模式":
                return "DATA_PATTERN";
            case "使用模式":
                return "USAGE_PATTERN";
            case "语义映射":
                return "SEMANTIC_MAPPING";
            case "指标定义":
                return "METRIC_DEFINITION";
            default:
                return "BUSINESS_RULE";
        }
    }

    private void saveMessage(ChatMessage message) {
        jdbcTemplate.update(INSERT_MESSAGE_SQL, message.getConversationId(), message.getUserId(),
                message.getMessage(), message.getIntent(), message.getResponse(),
                message.getCreatedAt());
    }

    public List<ChatMessage> getHistory(String conversationId) {
        return jdbcTemplate.query(SELECT_BY_CONVERSATION_SQL, new ChatMessageRowMapper(),
                conversationId);
    }

    public List<ChatMessage> getRecentHistory(String userId, int limit) {
        return jdbcTemplate.query(SELECT_RECENT_SQL, new ChatMessageRowMapper(), userId, limit);
    }

    @Data
    public static class IntentResult {
        private ChatMessage.Intent intent;
        private Map<String, Object> extractedEntities;
    }

    @Data
    public static class ChatResponse {
        private String conversationId;
        private String intent;
        private String message;
        private String status;
        private Object data;
    }

    private static class ChatMessageRowMapper implements RowMapper<ChatMessage> {
        @Override
        public ChatMessage mapRow(ResultSet rs, int rowNum) throws SQLException {
            ChatMessage msg = new ChatMessage();
            msg.setId(rs.getLong("id"));
            msg.setConversationId(rs.getString("conversation_id"));
            msg.setUserId(rs.getString("user_id"));
            msg.setMessage(rs.getString("message"));
            msg.setIntent(rs.getString("intent"));
            msg.setResponse(rs.getString("response"));
            msg.setCreatedAt(rs.getTimestamp("created_at") != null
                    ? rs.getTimestamp("created_at").toLocalDateTime()
                    : null);
            return msg;
        }
    }
}
