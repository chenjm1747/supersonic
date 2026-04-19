package com.tencent.supersonic.headless.core.text2sql.service;

public interface TextEmbeddingService {

    float[] embed(String text);
}
