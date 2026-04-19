package com.tencent.supersonic.headless.core.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AggregatorConfig {
    @Value("${s2.metric.aggregator.ratio.enable:true}")
    private Boolean enableRatio;

    public Boolean getEnableRatio() {
        return enableRatio;
    }
}
