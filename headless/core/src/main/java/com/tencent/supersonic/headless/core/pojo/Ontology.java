package com.tencent.supersonic.headless.core.pojo;

import com.tencent.supersonic.common.pojo.enums.EngineType;
import com.tencent.supersonic.headless.api.pojo.response.DatabaseResp;
import com.tencent.supersonic.headless.api.pojo.response.DimSchemaResp;
import com.tencent.supersonic.headless.api.pojo.response.MetricSchemaResp;
import com.tencent.supersonic.headless.api.pojo.response.ModelResp;

import java.util.*;
import java.util.stream.Collectors;

public class Ontology {

    private DatabaseResp database;
    private Map<String, ModelResp> modelMap = new HashMap<>();
    private Map<String, List<MetricSchemaResp>> metricMap = new HashMap<>();
    private Map<String, List<DimSchemaResp>> dimensionMap = new HashMap<>();
    private List<JoinRelation> joinRelations;

    public List<MetricSchemaResp> getMetrics() {
        return metricMap.values().stream().flatMap(Collection::stream).collect(Collectors.toList());
    }

    public List<DimSchemaResp> getDimensions() {
        return dimensionMap.values().stream().flatMap(Collection::stream)
                .collect(Collectors.toList());
    }

    public EngineType getDatabaseType() {
        if (Objects.nonNull(database)) {
            return EngineType.fromString(database.getType().toUpperCase());
        }
        return null;
    }

    public String getDatabaseVersion() {
        if (Objects.nonNull(database)) {
            return database.getVersion();
        }
        return null;
    }

    public DatabaseResp getDatabase() {
        return database;
    }

    public void setDatabase(DatabaseResp database) {
        this.database = database;
    }

    public Map<String, ModelResp> getModelMap() {
        return modelMap;
    }

    public void setModelMap(Map<String, ModelResp> modelMap) {
        this.modelMap = modelMap;
    }

    public Map<String, List<MetricSchemaResp>> getMetricMap() {
        return metricMap;
    }

    public void setMetricMap(Map<String, List<MetricSchemaResp>> metricMap) {
        this.metricMap = metricMap;
    }

    public Map<String, List<DimSchemaResp>> getDimensionMap() {
        return dimensionMap;
    }

    public void setDimensionMap(Map<String, List<DimSchemaResp>> dimensionMap) {
        this.dimensionMap = dimensionMap;
    }

    public List<JoinRelation> getJoinRelations() {
        return joinRelations;
    }

    public void setJoinRelations(List<JoinRelation> joinRelations) {
        this.joinRelations = joinRelations;
    }
}
