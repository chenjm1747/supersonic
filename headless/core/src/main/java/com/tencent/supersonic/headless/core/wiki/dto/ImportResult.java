package com.tencent.supersonic.headless.core.wiki.dto;

import lombok.Data;
import java.util.List;

@Data
public class ImportResult {
    private int successCount;
    private int skipCount;
    private int failCount;
    private List<String> failedTables;
}