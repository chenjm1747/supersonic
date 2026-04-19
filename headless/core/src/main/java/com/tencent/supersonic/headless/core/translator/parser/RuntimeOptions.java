package com.tencent.supersonic.headless.core.translator.parser;

import org.apache.commons.lang3.tuple.Triple;

public class RuntimeOptions {
    private Triple<String, String, String> minMaxTime;
    private Boolean enableOptimize;

    public RuntimeOptions() {}

    public RuntimeOptions(Triple<String, String, String> minMaxTime, Boolean enableOptimize) {
        this.minMaxTime = minMaxTime;
        this.enableOptimize = enableOptimize;
    }

    public Triple<String, String, String> getMinMaxTime() {
        return minMaxTime;
    }

    public void setMinMaxTime(Triple<String, String, String> minMaxTime) {
        this.minMaxTime = minMaxTime;
    }

    public Boolean getEnableOptimize() {
        return enableOptimize;
    }

    public void setEnableOptimize(Boolean enableOptimize) {
        this.enableOptimize = enableOptimize;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private Triple<String, String, String> minMaxTime;
        private Boolean enableOptimize;

        public Builder minMaxTime(Triple<String, String, String> minMaxTime) {
            this.minMaxTime = minMaxTime;
            return this;
        }

        public Builder enableOptimize(Boolean enableOptimize) {
            this.enableOptimize = enableOptimize;
            return this;
        }

        public RuntimeOptions build() {
            return new RuntimeOptions(minMaxTime, enableOptimize);
        }
    }
}
