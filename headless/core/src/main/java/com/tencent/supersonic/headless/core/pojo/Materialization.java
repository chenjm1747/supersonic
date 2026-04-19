package com.tencent.supersonic.headless.core.pojo;

import java.util.List;

public class Materialization {

    private String name;
    private Long id;
    private Long dataSetId;
    private List<String> columns;
    private List<String> partitions;
    private boolean isPartitioned;
    private String partitionName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getDataSetId() {
        return dataSetId;
    }

    public void setDataSetId(Long dataSetId) {
        this.dataSetId = dataSetId;
    }

    public List<String> getColumns() {
        return columns;
    }

    public void setColumns(List<String> columns) {
        this.columns = columns;
    }

    public List<String> getPartitions() {
        return partitions;
    }

    public void setPartitions(List<String> partitions) {
        this.partitions = partitions;
    }

    public boolean isPartitioned() {
        return isPartitioned;
    }

    public void setPartitioned(boolean partitioned) {
        isPartitioned = partitioned;
    }

    public String getPartitionName() {
        return partitionName;
    }

    public void setPartitionName(String partitionName) {
        this.partitionName = partitionName;
    }

    public static MaterializationBuilder builder() {
        return new MaterializationBuilder();
    }

    public static class MaterializationBuilder {
        private String name;
        private Long id;
        private Long dataSetId;
        private List<String> columns;
        private List<String> partitions;
        private boolean isPartitioned;
        private String partitionName;

        public MaterializationBuilder name(String name) {
            this.name = name;
            return this;
        }

        public MaterializationBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public MaterializationBuilder dataSetId(Long dataSetId) {
            this.dataSetId = dataSetId;
            return this;
        }

        public MaterializationBuilder columns(List<String> columns) {
            this.columns = columns;
            return this;
        }

        public MaterializationBuilder partitions(List<String> partitions) {
            this.partitions = partitions;
            return this;
        }

        public MaterializationBuilder isPartitioned(boolean isPartitioned) {
            this.isPartitioned = isPartitioned;
            return this;
        }

        public MaterializationBuilder partitionName(String partitionName) {
            this.partitionName = partitionName;
            return this;
        }

        public Materialization build() {
            Materialization materialization = new Materialization();
            materialization.setName(name);
            materialization.setId(id);
            materialization.setDataSetId(dataSetId);
            materialization.setColumns(columns);
            materialization.setPartitions(partitions);
            materialization.setPartitioned(isPartitioned);
            materialization.setPartitionName(partitionName);
            return materialization;
        }
    }
}
