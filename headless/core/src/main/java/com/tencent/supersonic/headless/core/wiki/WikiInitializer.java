package com.tencent.supersonic.headless.core.wiki;

import com.tencent.supersonic.headless.core.wiki.dto.WikiEntity;
import com.tencent.supersonic.headless.core.wiki.dto.WikiLink;
import com.tencent.supersonic.headless.core.wiki.service.WikiEntityService;
import com.tencent.supersonic.headless.core.wiki.service.WikiLinkService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@Slf4j
public class WikiInitializer implements ApplicationRunner {

    private final WikiEntityService entityService;
    private final WikiLinkService linkService;

    public WikiInitializer(WikiEntityService entityService, WikiLinkService linkService) {
        this.entityService = entityService;
        this.linkService = linkService;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        log.info("Initializing LLM-SQL-Wiki module...");

        try {
            initializeDefaultEntities();

            log.info("LLM-SQL-Wiki module initialized successfully");
        } catch (Exception e) {
            log.error("Failed to initialize Wiki module", e);
        }
    }

    private void initializeDefaultEntities() {
        List<WikiEntity> existingEntities = entityService.getAllActiveEntities();
        if (!existingEntities.isEmpty()) {
            log.info("Wiki entities already exist, skipping initialization");
            return;
        }

        log.info("Creating default Wiki entities for demonstration...");

        WikiEntity customerEntity = new WikiEntity();
        customerEntity.setEntityType("TABLE");
        customerEntity.setName("customer");
        customerEntity.setDisplayName("用户信息表");
        customerEntity.setDescription("存储供热收费系统中的用户基本信息");
        Map<String, Object> customerProps = new HashMap<>();
        customerProps.put("database", "charge_zbhx_20260303");
        customerProps.put("recordCount", 100000);
        customerProps.put("primaryKey", "id");
        customerEntity.setProperties(customerProps);
        customerEntity.setTags(List.of("用户", "基本信息", "P0核心表"));
        customerEntity.setTopicId("topic:user");
        entityService.createEntity(customerEntity);

        WikiEntity sfJsTEntity = new WikiEntity();
        sfJsTEntity.setEntityType("TABLE");
        sfJsTEntity.setName("sf_js_t");
        sfJsTEntity.setDisplayName("收费结算表");
        sfJsTEntity.setDescription("存储用户采暖期的收费结算信息");
        Map<String, Object> sfJsTProps = new HashMap<>();
        sfJsTProps.put("database", "charge_zbhx_20260303");
        sfJsTProps.put("recordCount", 500000);
        sfJsTProps.put("primaryKey", "id");
        sfJsTEntity.setProperties(sfJsTProps);
        sfJsTEntity.setTags(List.of("收费", "结算", "P0核心表"));
        sfJsTEntity.setTopicId("topic:charging");
        entityService.createEntity(sfJsTEntity);

        WikiEntity payOrderEntity = new WikiEntity();
        payOrderEntity.setEntityType("TABLE");
        payOrderEntity.setName("pay_order");
        payOrderEntity.setDisplayName("缴费订单表");
        payOrderEntity.setDescription("存储用户的缴费订单信息");
        Map<String, Object> payOrderProps = new HashMap<>();
        payOrderProps.put("database", "charge_zbhx_20260303");
        payOrderProps.put("recordCount", 200000);
        payOrderProps.put("primaryKey", "id");
        payOrderEntity.setProperties(payOrderProps);
        payOrderEntity.setTags(List.of("订单", "缴费", "P1核心表"));
        payOrderEntity.setTopicId("topic:charging");
        entityService.createEntity(payOrderEntity);

        WikiEntity userTopicEntity = new WikiEntity();
        userTopicEntity.setEntityType("TOPIC");
        userTopicEntity.setName("user");
        userTopicEntity.setDisplayName("用户主题");
        userTopicEntity.setDescription("用户管理业务域");
        userTopicEntity.setTags(List.of("用户", "主题"));
        userTopicEntity.setTopicId("topic:user");
        entityService.createEntity(userTopicEntity);

        WikiEntity chargingTopicEntity = new WikiEntity();
        chargingTopicEntity.setEntityType("TOPIC");
        chargingTopicEntity.setName("charging");
        chargingTopicEntity.setDisplayName("收费管理主题");
        chargingTopicEntity.setDescription("供热收费全流程业务域");
        chargingTopicEntity.setTags(List.of("收费", "主题"));
        chargingTopicEntity.setTopicId("topic:charging");
        entityService.createEntity(chargingTopicEntity);

        WikiLink customerToSfJsTLink = new WikiLink();
        customerToSfJsTLink.setSourceEntityId("table:customer");
        customerToSfJsTLink.setTargetEntityId("table:sf_js_t");
        customerToSfJsTLink.setLinkType("FOREIGN_KEY");
        customerToSfJsTLink.setRelation("1:N");
        customerToSfJsTLink.setDescription("用户与收费结算为1:N关系，通过customer_id关联");
        customerToSfJsTLink.setBidirectional(true);
        linkService.createLink(customerToSfJsTLink);

        WikiLink customerToPayOrderLink = new WikiLink();
        customerToPayOrderLink.setSourceEntityId("table:customer");
        customerToPayOrderLink.setTargetEntityId("table:pay_order");
        customerToPayOrderLink.setLinkType("FOREIGN_KEY");
        customerToPayOrderLink.setRelation("1:N");
        customerToPayOrderLink.setDescription("用户与缴费订单为1:N关系，通过customer_id关联");
        customerToPayOrderLink.setBidirectional(true);
        linkService.createLink(customerToPayOrderLink);

        WikiLink userToCustomerLink = new WikiLink();
        userToCustomerLink.setSourceEntityId("topic:user");
        userToCustomerLink.setTargetEntityId("table:customer");
        userToCustomerLink.setLinkType("HAS_MEMBER");
        userToCustomerLink.setRelation("包含");
        userToCustomerLink.setDescription("用户主题包含用户信息表");
        userToCustomerLink.setBidirectional(false);
        linkService.createLink(userToCustomerLink);

        WikiLink chargingToSfJsTLink = new WikiLink();
        chargingToSfJsTLink.setSourceEntityId("topic:charging");
        chargingToSfJsTLink.setTargetEntityId("table:sf_js_t");
        chargingToSfJsTLink.setLinkType("HAS_MEMBER");
        chargingToSfJsTLink.setRelation("包含");
        chargingToSfJsTLink.setDescription("收费主题包含收费结算表");
        chargingToSfJsTLink.setBidirectional(false);
        linkService.createLink(chargingToSfJsTLink);

        WikiLink chargingToPayOrderLink = new WikiLink();
        chargingToPayOrderLink.setSourceEntityId("topic:charging");
        chargingToPayOrderLink.setTargetEntityId("table:pay_order");
        chargingToPayOrderLink.setLinkType("HAS_MEMBER");
        chargingToPayOrderLink.setRelation("包含");
        chargingToPayOrderLink.setDescription("收费主题包含缴费订单表");
        chargingToPayOrderLink.setBidirectional(false);
        linkService.createLink(chargingToPayOrderLink);

        log.info("Default Wiki entities created: 5 entities, 5 links");
    }
}
