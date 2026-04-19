package com.tencent.supersonic.headless.chat.query.llm.wiki;

import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class IntentDetector {

    public Intent detect(QueryRequest request) {
        String queryText = request.getQueryText().toLowerCase();
        Intent intent = new Intent();
        List<String> entities = new ArrayList<>();
        List<String> metrics = new ArrayList<>();
        List<String> filters = new ArrayList<>();

        // 识别意图类型
        if (queryText.contains("多少") || queryText.contains("总计") || queryText.contains("sum")
                || queryText.contains("合计") || queryText.contains("总数")) {
            intent.setType("AGGREGATE");
        } else if (queryText.contains("查询") || queryText.contains("列出") || queryText.contains("显示")
                || queryText.contains("看看")) {
            intent.setType("SELECT");
        } else if (queryText.contains("超过") || queryText.contains("大于") || queryText.contains("小于")
                || queryText.contains("等于") || queryText.contains("不是")) {
            intent.setType("FILTER");
        } else if (queryText.contains("排名") || queryText.contains("排序") || queryText.contains("前")
                || queryText.contains("top")) {
            intent.setType("RANKING");
        } else if (queryText.contains("对比") || queryText.contains("比较") || queryText.contains("差异")) {
            intent.setType("COMPARISON");
        } else {
            intent.setType("SELECT");
        }

        // 识别指标
        if (queryText.contains("收入") || queryText.contains("金额") || queryText.contains("数量")
                || queryText.contains("总额") || queryText.contains("总计")) {
            metrics.add("order_amount");
        }
        if (queryText.contains("用户") || queryText.contains("客户")) {
            metrics.add("buyer_name");
        }

        // 识别筛选条件
        if (queryText.contains("本季度")) {
            filters.add("cnq=current_quarter");
        } else if (queryText.contains("上月") || queryText.contains("上个月")) {
            filters.add("cnq=last_month");
        } else if (queryText.contains("本周")) {
            filters.add("cnq=current_week");
        }

        if (queryText.contains("超过") || queryText.contains("大于")) {
            filters.add("threshold");
        }

        intent.setEntities(entities);
        intent.setMetrics(metrics);
        intent.setFilters(filters);

        return intent;
    }

    @Data
    public static class Intent {
        private String type;
        private List<String> entities;
        private List<String> metrics;
        private List<String> filters;
    }
}
