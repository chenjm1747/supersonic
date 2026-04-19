package com.tencent.supersonic.headless.core.wiki.service;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

@Configuration
@ComponentScan(basePackages = "com.tencent.supersonic.headless.core.wiki")
public class WikiKnowledgeServiceTestConfiguration {

    @Bean
    @Primary
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("org.h2.Driver");
        dataSource.setUrl("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1;MODE=MySQL");
        dataSource.setUsername("sa");
        dataSource.setPassword("");
        return dataSource;
    }

    @Autowired
    public void initializeDatabase(DataSource dataSource) {
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        jdbcTemplate.execute("CREATE TABLE s2_wiki_knowledge_card (\n"
                + "  id BIGINT AUTO_INCREMENT PRIMARY KEY,\n" + "  card_id VARCHAR(255),\n"
                + "  entity_id VARCHAR(255),\n" + "  card_type VARCHAR(255),\n"
                + "  title VARCHAR(255),\n" + "  content TEXT,\n" + "  extracted_from TEXT,\n"
                + "  confidence DECIMAL(10,2),\n" + "  status VARCHAR(50),\n" + "  tags TEXT,\n"
                + "  embedding TEXT,\n" + "  version VARCHAR(50),\n" + "  created_at TIMESTAMP,\n"
                + "  updated_at TIMESTAMP\n" + ")");
    }
}
