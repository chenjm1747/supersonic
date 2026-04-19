package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class WikiHealthReport {
    private Long id;
    private String reportId;
    private String reportType;  // DAILY/WEEKLY
    private LocalDateTime checkedAt;
    private Integer contradictionsFound;
    private Integer outdatedCards;
    private Integer orphanEntities;
    private Integer missingRefs;
    private String status;  // PENDING_PROCESSED / PROCESSED
    private String reportContent;  // JSON
    private LocalDateTime createdAt;

    public enum ReportType {
        DAILY, WEEKLY
    }

    public enum ReportStatus {
        PENDING_PROCESSED, PROCESSED
    }
}
