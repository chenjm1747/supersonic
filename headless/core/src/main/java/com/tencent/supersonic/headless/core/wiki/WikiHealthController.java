package com.tencent.supersonic.headless.core.wiki;

import com.tencent.supersonic.headless.core.wiki.dto.WikiHealthReport;
import com.tencent.supersonic.headless.core.wiki.service.ContradictionDetectionService;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiHealthService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/wiki/health")
@RequiredArgsConstructor
@Slf4j
public class WikiHealthController {
    private final WikiHealthService healthService;
    private final ContradictionDetectionService contradictionService;
    private final WikiEntityService entityService;

    @GetMapping("/reports")
    public BaseResp<List<WikiHealthReport>> getReports(
            @RequestParam(defaultValue = "10") int limit,
            @RequestParam(defaultValue = "0") int offset) {
        try {
            List<WikiHealthReport> reports = healthService.getReports(limit, offset);
            return BaseResp.ok(reports);
        } catch (Exception e) {
            log.error("Failed to get reports", e);
            return BaseResp.fail("Failed to get reports: " + e.getMessage());
        }
    }

    @GetMapping("/reports/{reportId}")
    public BaseResp<WikiHealthReport> getReportDetail(@PathVariable String reportId) {
        try {
            WikiHealthReport report = healthService.getReportById(reportId);
            if (report != null) {
                return BaseResp.ok(report);
            } else {
                return BaseResp.fail("Report not found: " + reportId);
            }
        } catch (Exception e) {
            log.error("Failed to get report detail", e);
            return BaseResp.fail("Failed to get report: " + e.getMessage());
        }
    }

    @GetMapping("/stats")
    public BaseResp<HealthStats> getStats() {
        try {
            HealthStats stats = new HealthStats();
            stats.setPendingReports(healthService.countPendingReports());
            stats.setPendingContradictions(contradictionService.countPending());
            stats.setOrphanEntities(entityService.countOrphanEntities());
            return BaseResp.ok(stats);
        } catch (Exception e) {
            log.error("Failed to get stats", e);
            return BaseResp.fail("Failed to get stats: " + e.getMessage());
        }
    }

    @PostMapping("/trigger")
    public BaseResp<Void> triggerHealthCheck(@RequestParam(defaultValue = "FULL") String type) {
        try {
            if ("FULL".equals(type)) {
                WikiHealthReport report = healthService.generateDailyReport();
                return BaseResp.ok();
            }
            return BaseResp.fail("Unknown check type: " + type);
        } catch (Exception e) {
            log.error("Failed to trigger health check", e);
            return BaseResp.fail("Failed to trigger health check: " + e.getMessage());
        }
    }

    @Data
    public static class HealthStats {
        private Integer pendingReports;
        private Integer pendingContradictions;
        private Integer orphanEntities;
    }

    @Data
    public static class BaseResp<T> {
        private boolean success;
        private String message;
        private T data;

        public static <T> BaseResp<T> ok(T data) {
            BaseResp<T> resp = new BaseResp<>();
            resp.setSuccess(true);
            resp.setData(data);
            return resp;
        }

        public static <T> BaseResp<T> fail(String message) {
            BaseResp<T> resp = new BaseResp<>();
            resp.setSuccess(false);
            resp.setMessage(message);
            return resp;
        }
    }
}
