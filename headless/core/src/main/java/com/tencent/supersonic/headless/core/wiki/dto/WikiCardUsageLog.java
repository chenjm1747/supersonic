package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class WikiCardUsageLog {
    private Long id;
    private String cardId;
    private String sql;
    private String result;  // SUCCESS/FAILURE
    private String errorMsg;
    private LocalDateTime createdAt;
}
