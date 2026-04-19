package com.tencent.supersonic.text2sql;

import lombok.Data;

@Data
public class BaseResp<T> {
    private Boolean success;
    private String message;
    private T data;
}
