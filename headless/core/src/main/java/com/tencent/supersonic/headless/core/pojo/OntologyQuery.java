package com.tencent.supersonic.headless.core.pojo;

import com.google.common.collect.Maps;
import com.google.common.collect.Sets;
import com.tencent.supersonic.common.pojo.ColumnOrder;
import com.tencent.supersonic.headless.api.pojo.enums.AggOption;
import com.tencent.supersonic.headless.api.pojo.response.DimSchemaResp;
import com.tencent.supersonic.headless.api.pojo.response.MetricSchemaResp;
import com.tencent.supersonic.headless.api.pojo.response.ModelResp;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

public class OntologyQuery {

    private Map<String, ModelResp> modelMap = Maps.newHashMap();
    private Map<String, Set<MetricSchemaResp>> metricMap = Maps.newHashMap();
    private Map<String, Set<DimSchemaResp>> dimensionMap = Maps.newHashMap();
    private Set<String> fields = Sets.newHashSet();
    private Long limit;
    private List<ColumnOrder> order;
    private boolean nativeQuery = true;
    private AggOption aggOption = AggOption.NATIVE;
    private String sql;

    public Set<ModelResp> getModels() {
        return modelMap.values().stream().collect(Collectors.toSet());
    }

    public Set<DimSchemaResp> getDimensions() {
        Set<DimSchemaResp> dimensions = Sets.newHashSet();
        dimensionMap.entrySet().forEach(entry -> {
            dimensions.addAll(entry.getValue());
        });
        return dimensions;
    }

    public Set<MetricSchemaResp> getMetrics() {
        Set<MetricSchemaResp> metrics = Sets.newHashSet();
        metricMap.entrySet().forEach(entry -> {
            metrics.addAll(entry.getValue());
        });
        return metrics;
    }

    public Set<MetricSchemaResp> getMetricsByModel(String modelName) {
        return metricMap.get(modelName);
    }

    public Set<DimSchemaResp> getDimensionsByModel(String modelName) {
        return dimensionMap.get(modelName);
    }

    public Map<String, ModelResp> getModelMap() {
        return modelMap;
    }

    public void setModelMap(Map<String, ModelResp> modelMap) {
        this.modelMap = modelMap;
    }

    public Map<String, Set<MetricSchemaResp>> getMetricMap() {
        return metricMap;
    }

    public void setMetricMap(Map<String, Set<MetricSchemaResp>> metricMap) {
        this.metricMap = metricMap;
    }

    public Map<String, Set<DimSchemaResp>> getDimensionMap() {
        return dimensionMap;
    }

    public void setDimensionMap(Map<String, Set<DimSchemaResp>> dimensionMap) {
        this.dimensionMap = dimensionMap;
    }

    public Set<String> getFields() {
        return fields;
    }

    public void setFields(Set<String> fields) {
        this.fields = fields;
    }

    public Long getLimit() {
        return limit;
    }

    public void setLimit(Long limit) {
        this.limit = limit;
    }

    public List<ColumnOrder> getOrder() {
        return order;
    }

    public void setOrder(List<ColumnOrder> order) {
        this.order = order;
    }

    public boolean isNativeQuery() {
        return nativeQuery;
    }

    public void setNativeQuery(boolean nativeQuery) {
        this.nativeQuery = nativeQuery;
    }

    public AggOption getAggOption() {
        return aggOption;
    }

    public void setAggOption(AggOption aggOption) {
        this.aggOption = aggOption;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }
}
