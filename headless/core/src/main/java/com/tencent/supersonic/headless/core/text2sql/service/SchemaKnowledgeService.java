package com.tencent.supersonic.headless.core.text2sql.service;

import com.tencent.supersonic.headless.core.text2sql.dto.SchemaKnowledge;
import com.tencent.supersonic.headless.core.text2sql.dto.TableSchema;

import java.util.List;

public interface SchemaKnowledgeService {

    void buildKnowledgeBase(String sqlFilePath, List<String> targetTables);

    List<SchemaKnowledge> retrieve(String question, int topK);

    List<TableSchema> getTableSchemas(List<String> tableNames);
}
