package com.tencent.supersonic.text2sql;

import lombok.Data;

@Data
public class SchemaKnowledge {

    private Long id;
    private String tableName;
    private String tableComment;
    private String columnName;
    private String columnComment;
    private String columnType;
    private Boolean isPrimaryKey;
    private Boolean isForeignKey;
    private String fkReference;
    private Double similarity;
}
