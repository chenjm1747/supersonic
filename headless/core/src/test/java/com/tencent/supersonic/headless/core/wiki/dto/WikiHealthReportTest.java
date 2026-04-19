package com.tencent.supersonic.headless.core.wiki.dto;

import org.junit.jupiter.api.Test;
import java.time.LocalDateTime;
import static org.junit.jupiter.api.Assertions.*;

class WikiHealthReportTest {

    @Test
    void testReportCreation() {
        WikiHealthReport report = new WikiHealthReport();
        report.setReportId("RPT-20260419-001");
        report.setReportType("DAILY");
        report.setStatus("PENDING_PROCESSED");
        assertEquals("RPT-20260419-001", report.getReportId());
        assertEquals("DAILY", report.getReportType());
    }

    @Test
    void testReportTypeEnum() {
        assertNotNull(WikiHealthReport.ReportType.DAILY);
        assertNotNull(WikiHealthReport.ReportType.WEEKLY);
    }

    @Test
    void testReportStatusEnum() {
        assertNotNull(WikiHealthReport.ReportStatus.PENDING_PROCESSED);
        assertNotNull(WikiHealthReport.ReportStatus.PROCESSED);
    }

    @Test
    void testSetCheckedAt() {
        WikiHealthReport report = new WikiHealthReport();
        LocalDateTime now = LocalDateTime.now();
        report.setCheckedAt(now);
        assertEquals(now, report.getCheckedAt());
    }

    @Test
    void testSetContradictionsFound() {
        WikiHealthReport report = new WikiHealthReport();
        report.setContradictionsFound(5);
        assertEquals(5, report.getContradictionsFound());
    }
}
