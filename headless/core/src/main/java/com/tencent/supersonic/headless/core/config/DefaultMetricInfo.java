package com.tencent.supersonic.headless.core.config;

import com.tencent.supersonic.common.pojo.enums.DatePeriodEnum;

public class DefaultMetricInfo {

    private Long metricId;

    private Integer unit = 1;

    private DatePeriodEnum period = DatePeriodEnum.DAY;

    @Override
    public String toString() {
        return "DefaultMetricInfo{" + "metricId=" + metricId + ", unit=" + unit + ", period="
                + period + '}';
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

    public DatePeriodEnum getPeriod() {
        return period;
    }

    public void setPeriod(DatePeriodEnum period) {
        this.period = period;
    }
}
