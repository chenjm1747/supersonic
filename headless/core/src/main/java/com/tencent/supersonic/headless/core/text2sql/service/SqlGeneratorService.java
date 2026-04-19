package com.tencent.supersonic.headless.core.text2sql.service;

import com.tencent.supersonic.headless.core.text2sql.dto.Text2SqlRequest;

public interface SqlGeneratorService {

    String generate(String question, String schemaContext);
}
