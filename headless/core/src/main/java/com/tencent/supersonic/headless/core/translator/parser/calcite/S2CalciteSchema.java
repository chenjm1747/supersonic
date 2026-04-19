package com.tencent.supersonic.headless.core.translator.parser.calcite;

import com.tencent.supersonic.headless.api.pojo.response.DimSchemaResp;
import com.tencent.supersonic.headless.api.pojo.response.MetricSchemaResp;
import com.tencent.supersonic.headless.api.pojo.response.ModelResp;
import com.tencent.supersonic.headless.core.pojo.JoinRelation;
import com.tencent.supersonic.headless.core.pojo.Ontology;
import com.tencent.supersonic.headless.core.translator.parser.RuntimeOptions;
import org.apache.calcite.schema.Schema;
import org.apache.calcite.schema.SchemaVersion;
import org.apache.calcite.schema.impl.AbstractSchema;

import java.util.List;
import java.util.Map;

public class S2CalciteSchema extends AbstractSchema {

    private String schemaKey;

    private Ontology ontology;

    private RuntimeOptions runtimeOptions;

    @Override
    public Schema snapshot(SchemaVersion version) {
        return this;
    }

    public Map<String, ModelResp> getDataModels() {
        return ontology.getModelMap();
    }

    public List<MetricSchemaResp> getMetrics() {
        return ontology.getMetrics();
    }

    public Map<String, List<DimSchemaResp>> getDimensions() {
        return ontology.getDimensionMap();
    }

    public List<JoinRelation> getJoinRelations() {
        return ontology.getJoinRelations();
    }

    public String getSchemaKey() {
        return schemaKey;
    }

    public void setSchemaKey(String schemaKey) {
        this.schemaKey = schemaKey;
    }

    public Ontology getOntology() {
        return ontology;
    }

    public void setOntology(Ontology ontology) {
        this.ontology = ontology;
    }

    public RuntimeOptions getRuntimeOptions() {
        return runtimeOptions;
    }

    public void setRuntimeOptions(RuntimeOptions runtimeOptions) {
        this.runtimeOptions = runtimeOptions;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static class Builder {
        private String schemaKey;
        private Ontology ontology;
        private RuntimeOptions runtimeOptions;

        public Builder schemaKey(String schemaKey) {
            this.schemaKey = schemaKey;
            return this;
        }

        public Builder ontology(Ontology ontology) {
            this.ontology = ontology;
            return this;
        }

        public Builder runtimeOptions(RuntimeOptions runtimeOptions) {
            this.runtimeOptions = runtimeOptions;
            return this;
        }

        public S2CalciteSchema build() {
            S2CalciteSchema schema = new S2CalciteSchema();
            schema.setSchemaKey(schemaKey);
            schema.setOntology(ontology);
            schema.setRuntimeOptions(runtimeOptions);
            return schema;
        }
    }
}
