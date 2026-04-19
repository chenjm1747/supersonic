package com.tencent.supersonic.headless.core.pojo;

import org.apache.commons.lang3.tuple.Triple;

import java.util.List;

public class JoinRelation {
    private Long id;
    private String left;
    private String right;
    private String joinType;
    private List<Triple<String, String, String>> joinCondition;

    public JoinRelation() {}

    public JoinRelation(Long id, String left, String right, String joinType,
            List<Triple<String, String, String>> joinCondition) {
        this.id = id;
        this.left = left;
        this.right = right;
        this.joinType = joinType;
        this.joinCondition = joinCondition;
    }

    public static JoinRelationBuilder builder() {
        return new JoinRelationBuilder();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLeft() {
        return left;
    }

    public void setLeft(String left) {
        this.left = left;
    }

    public String getRight() {
        return right;
    }

    public void setRight(String right) {
        this.right = right;
    }

    public String getJoinType() {
        return joinType;
    }

    public void setJoinType(String joinType) {
        this.joinType = joinType;
    }

    public List<Triple<String, String, String>> getJoinCondition() {
        return joinCondition;
    }

    public void setJoinCondition(List<Triple<String, String, String>> joinCondition) {
        this.joinCondition = joinCondition;
    }

    public static class JoinRelationBuilder {
        private Long id;
        private String left;
        private String right;
        private String joinType;
        private List<Triple<String, String, String>> joinCondition;

        public JoinRelationBuilder id(Long id) {
            this.id = id;
            return this;
        }

        public JoinRelationBuilder left(String left) {
            this.left = left;
            return this;
        }

        public JoinRelationBuilder right(String right) {
            this.right = right;
            return this;
        }

        public JoinRelationBuilder joinType(String joinType) {
            this.joinType = joinType;
            return this;
        }

        public JoinRelationBuilder joinCondition(
                List<Triple<String, String, String>> joinCondition) {
            this.joinCondition = joinCondition;
            return this;
        }

        public JoinRelation build() {
            return new JoinRelation(id, left, right, joinType, joinCondition);
        }
    }
}
