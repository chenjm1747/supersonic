package com.tencent.supersonic.headless.core.wiki.scheduler;

import com.tencent.supersonic.headless.core.wiki.dto.TopicSummary;
import com.tencent.supersonic.headless.core.wiki.dto.WikiHealthReport;
import com.tencent.supersonic.headless.core.wiki.service.WikiHealthService;
import com.tencent.supersonic.headless.core.wiki.service.WikiSummaryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@EnableScheduling
@Slf4j
public class WikiScheduler {

    private final WikiSummaryService summaryService;
    private final WikiHealthService healthService;

    public WikiScheduler(WikiSummaryService summaryService, WikiHealthService healthService) {
        this.summaryService = summaryService;
        this.healthService = healthService;
    }

    @Scheduled(cron = "0 0 2 * * ?")
    public void scheduledSummaryRefresh() {
        log.info("Starting scheduled summary refresh...");

        try {
            List<TopicSummary> summaries = summaryService.refreshAllSummaries();
            log.info("Scheduled summary refresh completed: {} summaries refreshed",
                    summaries.size());
        } catch (Exception e) {
            log.error("Scheduled summary refresh failed", e);
        }
    }

    @Scheduled(cron = "0 0 3 * * ?")
    public void scheduledContradictionCheck() {
        log.info("Starting scheduled health check...");

        try {
            WikiHealthReport report = healthService.generateDailyReport();
            log.info("Scheduled health check completed: {} contradictions, {} outdated, {} orphans",
                report.getContradictionsFound(), report.getOutdatedCards(), report.getOrphanEntities());
        } catch (Exception e) {
            log.error("Scheduled health check failed", e);
        }
    }
}
