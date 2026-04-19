package com.tencent.supersonic.text2sql;

import lombok.Data;

import java.util.List;

@Data
public class KnowledgeBuildReq {
    private String sqlFilePath;
    private String databaseType = "MYSQL";
    private List<String> targetTables;
    private String sqlContent;
}
