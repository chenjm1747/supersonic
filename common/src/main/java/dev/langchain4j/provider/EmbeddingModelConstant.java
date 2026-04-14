package dev.langchain4j.provider;

import dev.langchain4j.model.embedding.EmbeddingModel;
import dev.langchain4j.model.embedding.onnx.allminilml6v2q.AllMiniLmL6V2QuantizedEmbeddingModel;
import dev.langchain4j.model.embedding.onnx.bgesmallzh.BgeSmallZhEmbeddingModel;
import org.springframework.stereotype.Service;

@Service
public class EmbeddingModelConstant {

    public static final String BGE_SMALL_ZH = "bge-small-zh";
    public static final String ALL_MINILM_L6_V2 = "all-minilm-l6-v2-q";

    private volatile static EmbeddingModel bgeSmallZhModel;
    private volatile static EmbeddingModel allMiniLmL6V2Model;

    public static EmbeddingModel getBgeSmallZhModel() {
        if (bgeSmallZhModel == null) {
            synchronized (EmbeddingModelConstant.class) {
                if (bgeSmallZhModel == null) {
                    bgeSmallZhModel = new BgeSmallZhEmbeddingModel();
                }
            }
        }
        return bgeSmallZhModel;
    }

    public static EmbeddingModel getAllMiniLmL6V2Model() {
        if (allMiniLmL6V2Model == null) {
            synchronized (EmbeddingModelConstant.class) {
                if (allMiniLmL6V2Model == null) {
                    allMiniLmL6V2Model = new AllMiniLmL6V2QuantizedEmbeddingModel();
                }
            }
        }
        return allMiniLmL6V2Model;
    }
}
