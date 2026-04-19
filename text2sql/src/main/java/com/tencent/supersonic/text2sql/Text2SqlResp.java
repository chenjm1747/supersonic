package com.tencent.supersonic.text2sql;

import lombok.Data;

import java.util.List;

@Data
public class Text2SqlResp {
    private String question;
    private String sql;
    private List<SchemaKnowledge> schemas;
    private Boolean valid;
    private String errorMessage;
}
