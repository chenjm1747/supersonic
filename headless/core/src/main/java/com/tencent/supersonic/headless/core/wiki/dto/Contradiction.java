package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Contradiction {

    private Long id;

    private String contradictionId;

    private String entityId;

    private String oldKnowledgeCardId;

    private String conflictType;

    private String oldContent;

    private String newEvidence;

    private String evidenceSource;

    private String impact;

    private String resolution;

    private LocalDateTime resolvedAt;

    private String resolvedBy;

    private String resolutionNotes;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private Evidence evidence;

    public enum ConflictType {
        SCHEMA_CONFLICT, SEMANTIC_CONFLICT, RELATIONSHIP_CONFLICT, RULE_CONFLICT
    }

    public enum Resolution {
        PENDING, ACCEPT_NEW, KEEP_OLD, MERGE, DISMISS
    }
}
