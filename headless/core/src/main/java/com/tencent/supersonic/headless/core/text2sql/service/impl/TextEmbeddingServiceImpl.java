package com.tencent.supersonic.headless.core.text2sql.service.impl;

import com.tencent.supersonic.common.service.EmbeddingService;
import com.tencent.supersonic.headless.core.text2sql.service.TextEmbeddingService;
import dev.langchain4j.data.embedding.Embedding;
import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.provider.ModelProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TextEmbeddingServiceImpl implements TextEmbeddingService {
    private static final Logger log = LoggerFactory.getLogger(TextEmbeddingServiceImpl.class);

    @Autowired
    private EmbeddingService embeddingService;

    @Override
    public float[] embed(String text) {
        try {
            EmbeddingModel embeddingModel = ModelProvider.getEmbeddingModel();
            Embedding embedding = embeddingModel.embed(text).content();
            float[] result = new float[embedding.vector().length];
            for (int i = 0; i < embedding.vector().length; i++) {
                result[i] = (float) embedding.vector()[i];
            }
            return result;
        } catch (Exception e) {
            log.error("Failed to embed text: {}", text, e);
            return new float[0];
        }
    }
}
