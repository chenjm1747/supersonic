package com.tencent.supersonic.text2sql;

import lombok.Data;

@Data
public class ParseSqlReq {
    private String sqlFilePath;
    private String databaseType = "MYSQL";
    private String sqlContent;
}
