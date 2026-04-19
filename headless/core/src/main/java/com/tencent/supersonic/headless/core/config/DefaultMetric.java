package com.tencent.supersonic.headless.core.config;

public class DefaultMetric {

    private Long metricId;

    private Integer unit;

    private String period;

    private String bizName;
    private String name;

    public DefaultMetric() {}

    public DefaultMetric(Long metricId, Integer unit, String period) {
        this.metricId = metricId;
        this.unit = unit;
        this.period = period;
    }

    public DefaultMetric(String bizName, Integer unit, String period) {
        this.bizName = bizName;
        this.unit = unit;
        this.period = period;
    }

    public Long getMetricId() {
        return metricId;
    }

    public void setMetricId(Long metricId) {
        this.metricId = metricId;
    }

    public Integer getUnit() {
        return unit;
    }

    public void setUnit(Integer unit) {
        this.unit = unit;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }

    public String getBizName() {
        return bizName;
    }

    public void setBizName(String bizName) {
        this.bizName = bizName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
