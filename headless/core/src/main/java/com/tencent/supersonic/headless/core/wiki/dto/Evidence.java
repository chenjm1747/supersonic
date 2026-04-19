package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class Evidence {

    private Long id;

    private String evidenceId;

    private String contradictionId;

    private String sourceEntityId;

    private String evidenceType;

    private String content;

    private String source;

    private BigDecimal confidence;

    private String impact;

    private String resolution;

    private LocalDateTime createdAt;

    public enum EvidenceType {
        SUPPORTS, REFUTES, NEUTRAL
    }

    public enum EvidenceResolution {
        PENDING, ACCEPTED, REJECTED, MERGED
    }
}
