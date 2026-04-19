package com.tencent.supersonic.headless.core.pojo;

import com.tencent.supersonic.common.pojo.Aggregator;
import com.tencent.supersonic.common.pojo.DateConf;
import com.tencent.supersonic.common.pojo.Filter;
import com.tencent.supersonic.common.pojo.Order;
import com.tencent.supersonic.common.pojo.enums.QueryType;
import com.tencent.supersonic.headless.api.pojo.Param;

import java.util.ArrayList;
import java.util.List;

public class StructQuery {
    private List<String> groups = new ArrayList();
    private List<Aggregator> aggregators = new ArrayList();
    private List<Order> orders = new ArrayList();
    private List<Filter> dimensionFilters = new ArrayList();
    private List<Filter> metricFilters = new ArrayList();
    private DateConf dateInfo;
    private Long limit = 2000L;
    private Long offset = 0L;
    private QueryType queryType;
    private List<Param> params = new ArrayList<>();

    public List<String> getGroups() {
        return groups;
    }

    public void setGroups(List<String> groups) {
        this.groups = groups;
    }

    public List<Aggregator> getAggregators() {
        return aggregators;
    }

    public void setAggregators(List<Aggregator> aggregators) {
        this.aggregators = aggregators;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<Filter> getDimensionFilters() {
        return dimensionFilters;
    }

    public void setDimensionFilters(List<Filter> dimensionFilters) {
        this.dimensionFilters = dimensionFilters;
    }

    public List<Filter> getMetricFilters() {
        return metricFilters;
    }

    public void setMetricFilters(List<Filter> metricFilters) {
        this.metricFilters = metricFilters;
    }

    public DateConf getDateInfo() {
        return dateInfo;
    }

    public void setDateInfo(DateConf dateInfo) {
        this.dateInfo = dateInfo;
    }

    public Long getLimit() {
        return limit;
    }

    public void setLimit(Long limit) {
        this.limit = limit;
    }

    public Long getOffset() {
        return offset;
    }

    public void setOffset(Long offset) {
        this.offset = offset;
    }

    public QueryType getQueryType() {
        return queryType;
    }

    public void setQueryType(QueryType queryType) {
        this.queryType = queryType;
    }

    public List<Param> getParams() {
        return params;
    }

    public void setParams(List<Param> params) {
        this.params = params;
    }
}
