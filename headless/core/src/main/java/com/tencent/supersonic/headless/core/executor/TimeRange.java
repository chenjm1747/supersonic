package com.tencent.supersonic.headless.core.executor;

public class TimeRange {
    private String start;
    private String end;

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public static TimeRangeBuilder builder() {
        return new TimeRangeBuilder();
    }

    public static class TimeRangeBuilder {
        private String start;
        private String end;

        public TimeRangeBuilder start(String start) {
            this.start = start;
            return this;
        }

        public TimeRangeBuilder end(String end) {
            this.end = end;
            return this;
        }

        public TimeRange build() {
            TimeRange timeRange = new TimeRange();
            timeRange.setStart(start);
            timeRange.setEnd(end);
            return timeRange;
        }
    }
}
