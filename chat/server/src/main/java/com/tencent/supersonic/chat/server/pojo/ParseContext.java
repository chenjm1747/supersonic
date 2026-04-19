package com.tencent.supersonic.chat.server.pojo;

import com.tencent.supersonic.chat.api.pojo.request.ChatParseReq;
import com.tencent.supersonic.chat.api.pojo.response.ChatParseResp;
import com.tencent.supersonic.chat.server.agent.Agent;
import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiKnowledgeCard;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Data
public class ParseContext {
    private ChatParseReq request;
    private ChatParseResp response;
    private Agent agent;
    private List<WikiEntity> wikiEntities = new ArrayList<>();
    private List<WikiKnowledgeCard> wikiKnowledgeCards = new ArrayList<>();

    public ParseContext(ChatParseReq request, ChatParseResp response) {
        this.request = request;
        this.response = response;
    }

    public boolean enableNL2SQL() {
        return Objects.nonNull(agent) && agent.containsDatasetTool()
                && response.getSelectedParses().size() == 0;
    }

    public boolean enableLLM() {
        return !request.isDisableLLM();
    }

    public boolean needFeedback() {
        return agent.enableFeedback() && (Objects.isNull(request.getSelectedParse())
                && response.getSelectedParses().size() > 1);
    }

    public boolean needLLMParse() {
        return enableLLM() && (Objects.nonNull(request.getSelectedParse())
                || !response.getSelectedParses().isEmpty());
    }
}
