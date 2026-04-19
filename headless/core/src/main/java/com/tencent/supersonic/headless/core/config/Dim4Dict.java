package com.tencent.supersonic.headless.core.config;

import java.util.List;

public class Dim4Dict {

    private Long dimId;
    private String bizName;
    private List<String> blackList;
    private List<String> whiteList;
    private List<String> ruleList;

    public Dim4Dict() {}

    public Dim4Dict(Long dimId, String bizName, List<String> blackList, List<String> whiteList,
            List<String> ruleList) {
        this.dimId = dimId;
        this.bizName = bizName;
        this.blackList = blackList;
        this.whiteList = whiteList;
        this.ruleList = ruleList;
    }

    public Long getDimId() {
        return dimId;
    }

    public void setDimId(Long dimId) {
        this.dimId = dimId;
    }

    public String getBizName() {
        return bizName;
    }

    public void setBizName(String bizName) {
        this.bizName = bizName;
    }

    public List<String> getBlackList() {
        return blackList;
    }

    public void setBlackList(List<String> blackList) {
        this.blackList = blackList;
    }

    public List<String> getWhiteList() {
        return whiteList;
    }

    public void setWhiteList(List<String> whiteList) {
        this.whiteList = whiteList;
    }

    public List<String> getRuleList() {
        return ruleList;
    }

    public void setRuleList(List<String> ruleList) {
        this.ruleList = ruleList;
    }

    @Override
    public String toString() {
        return "Dim4Dict{" + "dimId=" + dimId + ", bizName='" + bizName + '\'' + ", blackList="
                + blackList + ", whiteList=" + whiteList + ", ruleList=" + ruleList + '}';
    }
}
