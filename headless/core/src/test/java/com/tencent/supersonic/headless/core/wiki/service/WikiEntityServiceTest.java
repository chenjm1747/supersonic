package com.tencent.supersonic.headless.core.wiki.service;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest(classes = WikiEntityServiceTestConfiguration.class)
class WikiEntityServiceTest {

    @Autowired
    private WikiEntityService entityService;

    @Test
    void testSearchEntities() {
        List<WikiEntity> results = entityService.searchEntities("收入");
        assertNotNull(results);
    }
}
