package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class WikiLink {

    private Long id;

    private String sourceEntityId;

    private String targetEntityId;

    private String linkType;

    private String relation;

    private String description;

    private Boolean bidirectional;

    private BigDecimal weight;

    private LocalDateTime createdAt;

    public enum LinkType {
        FOREIGN_KEY, SEMANTIC, BELONGS_TO, REFERENCES, HAS_MEMBER
    }
}
