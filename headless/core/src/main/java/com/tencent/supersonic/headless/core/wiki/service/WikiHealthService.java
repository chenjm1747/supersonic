package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.Contradiction;
import com.tencent.supersonic.headless.core.wiki.dto.WikiHealthReport;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class WikiHealthService {
    private final JdbcTemplate jdbcTemplate;
    private final WikiKnowledgeService knowledgeService;
    private final WikiEntityService entityService;
    private final ContradictionDetectionService contradictionDetection;

    private static final int DEFAULT_DAYS_THRESHOLD = 30;

    public WikiHealthReport generateDailyReport() {
        WikiHealthReport report = new WikiHealthReport();
        report.setReportId("RPT-" + LocalDateTime.now().format(DateTimeFormatter.BASIC_ISO_DATE) + "-001");
        report.setReportType("DAILY");
        report.setCheckedAt(LocalDateTime.now());

        try {
            // 矛盾检测
            List<Contradiction> contradictions = contradictionDetection.detectAll();
            report.setContradictionsFound(contradictions.size());

            // 过时卡片
            int outdatedCards = knowledgeService.countOutdatedCards(DEFAULT_DAYS_THRESHOLD);
            report.setOutdatedCards(outdatedCards);

            // 孤立实体
            int orphanEntities = entityService.countOrphanEntities();
            report.setOrphanEntities(orphanEntities);

            report.setMissingRefs(0);
            report.setStatus("PENDING_PROCESSED");

            saveReport(report);

            log.info("Daily health report generated: {} contradictions, {} outdated, {} orphans",
                report.getContradictionsFound(), report.getOutdatedCards(), report.getOrphanEntities());

        } catch (Exception e) {
            log.error("Error generating daily health report", e);
        }

        return report;
    }

    public List<WikiHealthReport> getReports(int limit, int offset) {
        String sql = "SELECT * FROM s2_wiki_health_report ORDER BY created_at DESC LIMIT ? OFFSET ?";
        return jdbcTemplate.query(sql, (rs, rowNum) -> {
            WikiHealthReport report = new WikiHealthReport();
            report.setId(rs.getLong("id"));
            report.setReportId(rs.getString("report_id"));
            report.setReportType(rs.getString("report_type"));
            report.setCheckedAt(rs.getTimestamp("checked_at") != null
                ? rs.getTimestamp("checked_at").toLocalDateTime() : null);
            report.setContradictionsFound(rs.getInt("contradictions_found"));
            report.setOutdatedCards(rs.getInt("outdated_cards"));
            report.setOrphanEntities(rs.getInt("orphan_entities"));
            report.setMissingRefs(rs.getInt("missing_refs"));
            report.setStatus(rs.getString("status"));
            report.setReportContent(rs.getString("report_content"));
            report.setCreatedAt(rs.getTimestamp("created_at") != null
                ? rs.getTimestamp("created_at").toLocalDateTime() : null);
            return report;
        }, limit, offset);
    }

    public WikiHealthReport getReportById(String reportId) {
        String sql = "SELECT * FROM s2_wiki_health_report WHERE report_id = ?";
        List<WikiHealthReport> results = jdbcTemplate.query(sql, (rs, rowNum) -> {
            WikiHealthReport report = new WikiHealthReport();
            report.setId(rs.getLong("id"));
            report.setReportId(rs.getString("report_id"));
            report.setReportType(rs.getString("report_type"));
            report.setCheckedAt(rs.getTimestamp("checked_at") != null
                ? rs.getTimestamp("checked_at").toLocalDateTime() : null);
            report.setContradictionsFound(rs.getInt("contradictions_found"));
            report.setOutdatedCards(rs.getInt("outdated_cards"));
            report.setOrphanEntities(rs.getInt("orphan_entities"));
            report.setMissingRefs(rs.getInt("missing_refs"));
            report.setStatus(rs.getString("status"));
            report.setReportContent(rs.getString("report_content"));
            return report;
        }, reportId);
        return results.isEmpty() ? null : results.get(0);
    }

    public int countPendingReports() {
        String sql = "SELECT COUNT(*) FROM s2_wiki_health_report WHERE status = 'PENDING_PROCESSED'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class);
        return count != null ? count : 0;
    }

    private void saveReport(WikiHealthReport report) {
        jdbcTemplate.update(
            "INSERT INTO s2_wiki_health_report (report_id, report_type, checked_at, "
            + "contradictions_found, outdated_cards, orphan_entities, missing_refs, status, created_at) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
            report.getReportId(), report.getReportType(), report.getCheckedAt(),
            report.getContradictionsFound(), report.getOutdatedCards(),
            report.getOrphanEntities(), report.getMissingRefs(), report.getStatus(), LocalDateTime.now()
        );
    }
}
