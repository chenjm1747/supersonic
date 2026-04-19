package com.tencent.supersonic.text2sql;

import lombok.Data;

@Data
public class Text2SqlReq {
    private String question;
    private Integer topK = 5;
}
