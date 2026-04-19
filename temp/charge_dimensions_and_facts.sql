-- ============================================================
-- 供热收费系统分析模型 - PostgreSQL DDL
-- 数据源: charge_zbhx MySQL数据库
-- 创建日期: 2026-04-13
-- 适用范围: SuperSonic 供热收费客服智能分析平台
-- ============================================================

-- ============================================================
-- 维度表 (Dimension Tables)
-- ============================================================

-- 1. 用户维度表
CREATE TABLE sf_dim_customer (
    customer_id BIGINT PRIMARY KEY,
    customer_code VARCHAR(20) NOT NULL,
    customer_name VARCHAR(40),
    id_number VARCHAR(80),
    tel_no VARCHAR(50),
    mob_no VARCHAR(200),
    yhlx VARCHAR(10) NOT NULL,
    rwrq DATE,
    rwht_bh VARCHAR(30),
    kzfs VARCHAR(10),
    kz_hmd SMALLINT DEFAULT 0,
    kz_sf SMALLINT DEFAULT 1,
    kz_yhsf SMALLINT DEFAULT 1,
    kz_jcsh SMALLINT DEFAULT 0,
    rlz_id BIGINT,
    zdfq_id BIGINT,
    zdfq_name VARCHAR(30),
    hrq_zt VARCHAR(10),
    xzcnq VARCHAR(10),
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sf_dim_customer IS '用户维度表 - 来源:customer';
COMMENT ON COLUMN sf_dim_customer.customer_id IS '用户主键';
COMMENT ON COLUMN sf_dim_customer.customer_code IS '用户编码';
COMMENT ON COLUMN sf_dim_customer.customer_name IS '用户名称';
COMMENT ON COLUMN sf_dim_customer.id_number IS '身份证号';
COMMENT ON COLUMN sf_dim_customer.tel_no IS '座机号';
COMMENT ON COLUMN sf_dim_customer.mob_no IS '手机号';
COMMENT ON COLUMN sf_dim_customer.yhlx IS '用户类型:居民/单位';
COMMENT ON COLUMN sf_dim_customer.rwrq IS '入网日期';
COMMENT ON COLUMN sf_dim_customer.rwht_bh IS '入网合同编号';
COMMENT ON COLUMN sf_dim_customer.kzfs IS '控制方式:分户/未分户';
COMMENT ON COLUMN sf_dim_customer.kz_hmd IS '是否黑名单:0-否 1-是';
COMMENT ON COLUMN sf_dim_customer.kz_sf IS '是否允许收费:0-否 1-是';
COMMENT ON COLUMN sf_dim_customer.kz_yhsf IS '是否允许银行收费:0-否 1-是';
COMMENT ON COLUMN sf_dim_customer.kz_jcsh IS '稽查锁户:0-否 1-是';
COMMENT ON COLUMN sf_dim_customer.rlz_id IS '热力站主键';
COMMENT ON COLUMN sf_dim_customer.zdfq_id IS '站点分区主键';
COMMENT ON COLUMN sf_dim_customer.zdfq_name IS '站点分区名称';
COMMENT ON COLUMN sf_dim_customer.hrq_zt IS '换热器状态';
COMMENT ON COLUMN sf_dim_customer.xzcnq IS '新增采暖期';
COMMENT ON COLUMN sf_dim_customer.zf IS '是否作废:0-正常 1-作废';
COMMENT ON COLUMN sf_dim_customer.create_time IS '创建时间';
COMMENT ON COLUMN sf_dim_customer.update_time IS '更新时间';

-- 2. 组织维度表
CREATE TABLE sf_dim_org (
    org_id BIGINT PRIMARY KEY,
    parent_id BIGINT DEFAULT 0,
    org_level1 VARCHAR(20) NOT NULL,
    org_level2 VARCHAR(20),
    org_level3 VARCHAR(30),
    org_type VARCHAR(10),
    address_prefix VARCHAR(35),
    unit VARCHAR(15),
    floor VARCHAR(10),
    room VARCHAR(10),
    address VARCHAR(100),
    rlz_id BIGINT,
    rlz_name VARCHAR(30),
    state INT DEFAULT 0,
    jzmj DECIMAL(10,3),
    zf SMALLINT DEFAULT 0
);

COMMENT ON TABLE sf_dim_org IS '组织维度表 - 来源:sys_address/customer';
COMMENT ON COLUMN sf_dim_org.org_id IS '组织主键';
COMMENT ON COLUMN sf_dim_org.parent_id IS '父级组织主键';
COMMENT ON COLUMN sf_dim_org.org_level1 IS '分公司';
COMMENT ON COLUMN sf_dim_org.org_level2 IS '热力站';
COMMENT ON COLUMN sf_dim_org.org_level3 IS '小区';
COMMENT ON COLUMN sf_dim_org.org_type IS '组织类型:分公司/热力站/小区';
COMMENT ON COLUMN sf_dim_org.address_prefix IS '楼栋';
COMMENT ON COLUMN sf_dim_org.unit IS '单元';
COMMENT ON COLUMN sf_dim_org.floor IS '楼层';
COMMENT ON COLUMN sf_dim_org.room IS '房间';
COMMENT ON COLUMN sf_dim_org.address IS '完整地址';
COMMENT ON COLUMN sf_dim_org.rlz_id IS '热力站主键';
COMMENT ON COLUMN sf_dim_org.rlz_name IS '热力站名称';
COMMENT ON COLUMN sf_dim_org.state IS '状态:0-待投运 1-已投运 2-停运 3-销毁';
COMMENT ON COLUMN sf_dim_org.jzmj IS '建筑面积';
COMMENT ON COLUMN sf_dim_org.zf IS '是否作废';

-- 3. 面积维度表
CREATE TABLE sf_dim_area (
    area_id BIGINT PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    area_name VARCHAR(60),
    sfmj DECIMAL(10,3) NOT NULL DEFAULT 0,
    zdmj DECIMAL(10,3) DEFAULT 0,
    symj DECIMAL(10,3) DEFAULT 0,
    cgmj DECIMAL(10,3),
    cg DECIMAL(10,3) DEFAULT 0,
    mjlb VARCHAR(40) NOT NULL,
    djlb VARCHAR(40) NOT NULL,
    jsfs VARCHAR(10) NOT NULL,
    gnsc DECIMAL(10,3) NOT NULL,
    ybbm VARCHAR(20),
    jldjlb VARCHAR(10),
    gnzt VARCHAR(5) DEFAULT '正常',
    fmzt VARCHAR(10),
    generate SMALLINT,
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sf_dim_area IS '面积维度表 - 来源:area/sf_mj_t';
COMMENT ON COLUMN sf_dim_area.area_id IS '面积主键';
COMMENT ON COLUMN sf_dim_area.customer_id IS '用户主键';
COMMENT ON COLUMN sf_dim_area.area_name IS '面积名称';
COMMENT ON COLUMN sf_dim_area.sfmj IS '收费面积(平方米)';
COMMENT ON COLUMN sf_dim_area.zdmj IS '建筑面积(平方米)';
COMMENT ON COLUMN sf_dim_area.symj IS '使用面积(平方米)';
COMMENT ON COLUMN sf_dim_area.cgmj IS '超高面积(平方米)';
COMMENT ON COLUMN sf_dim_area.cg IS '层高(米)';
COMMENT ON COLUMN sf_dim_area.mjlb IS '面积类别';
COMMENT ON COLUMN sf_dim_area.djlb IS '单价类别';
COMMENT ON COLUMN sf_dim_area.jsfs IS '结算方式:按面积/计量/两部制';
COMMENT ON COLUMN sf_dim_area.gnsc IS '供暖时长(天/月/季)';
COMMENT ON COLUMN sf_dim_area.ybbm IS '仪表编码';
COMMENT ON COLUMN sf_dim_area.jldjlb IS '计量单价类别';
COMMENT ON COLUMN sf_dim_area.gnzt IS '供暖状态:正常/停供/部分停供';
COMMENT ON COLUMN sf_dim_area.fmzt IS '阀门状态:开阀/关阀';
COMMENT ON COLUMN sf_dim_area.generate IS '是否生成账单:0-不生成 1-生成';
COMMENT ON COLUMN sf_dim_area.zf IS '是否作废:0-正常 1-作废';
COMMENT ON COLUMN sf_dim_area.create_time IS '创建时间';
COMMENT ON COLUMN sf_dim_area.update_time IS '更新时间';

-- 4. 时间维度表
CREATE TABLE sf_dim_time (
    date_id DATE PRIMARY KEY,
    year INT NOT NULL,
    month INT NOT NULL,
    quarter INT,
    month_name VARCHAR(20),
    day_of_week INT,
    day_name VARCHAR(20),
    cnq VARCHAR(10),
    cnq_year INT,
    cnq_month INT,
    is_cnq_start SMALLINT DEFAULT 0,
    is_cnq_end SMALLINT DEFAULT 0,
    is_payment_season SMALLINT DEFAULT 0,
    is_weekend SMALLINT DEFAULT 0,
    fiscal_year INT
);

COMMENT ON TABLE sf_dim_time IS '时间维度表';
COMMENT ON COLUMN sf_dim_time.date_id IS '日期主键';
COMMENT ON COLUMN sf_dim_time.year IS '年';
COMMENT ON COLUMN sf_dim_time.month IS '月';
COMMENT ON COLUMN sf_dim_time.quarter IS '季度';
COMMENT ON COLUMN sf_dim_time.month_name IS '月份名称';
COMMENT ON COLUMN sf_dim_time.day_of_week IS '星期几';
COMMENT ON COLUMN sf_dim_time.day_name IS '星期名称';
COMMENT ON COLUMN sf_dim_time.cnq IS '采暖期(格式:2025-2026)';
COMMENT ON COLUMN sf_dim_time.cnq_year IS '采暖期起始年';
COMMENT ON COLUMN sf_dim_time.cnq_month IS '采暖期月份(11月=1,12月=2...)';
COMMENT ON COLUMN sf_dim_time.is_cnq_start IS '是否采暖期开始月(11月)';
COMMENT ON COLUMN sf_dim_time.is_cnq_end IS '是否采暖期结束月(3月)';
COMMENT ON COLUMN sf_dim_time.is_payment_season IS '是否缴费季(11月-次年3月)';
COMMENT ON COLUMN sf_dim_time.is_weekend IS '是否周末';
COMMENT ON COLUMN sf_dim_time.fiscal_year IS '财年';

-- 5. 费用类别维度表
CREATE TABLE sf_dim_fee (
    fee_type_id SERIAL PRIMARY KEY,
    fylb VARCHAR(20) NOT NULL,
    fylb_name VARCHAR(40) NOT NULL,
    djlb VARCHAR(40),
    djlb_name VARCHAR(60),
    dj DECIMAL(10,3),
    is_base_fee SMALLINT DEFAULT 0,
    is_measure_fee SMALLINT DEFAULT 0,
    jsfs VARCHAR(10)
);

COMMENT ON TABLE sf_dim_fee IS '费用类别维度表 - 来源:sf_mjjs_t';
COMMENT ON COLUMN sf_dim_fee.fee_type_id IS '费用类别主键';
COMMENT ON COLUMN sf_dim_fee.fylb IS '费用类别代码';
COMMENT ON COLUMN sf_dim_fee.fylb_name IS '费用类别名称';
COMMENT ON COLUMN sf_dim_fee.djlb IS '单价类别';
COMMENT ON COLUMN sf_dim_fee.djlb_name IS '单价类别名称';
COMMENT ON COLUMN sf_dim_fee.dj IS '单价(元/平方米或元/吉焦)';
COMMENT ON COLUMN sf_dim_fee.is_base_fee IS '是否基础费';
COMMENT ON COLUMN sf_dim_fee.is_measure_fee IS '是否计量费';
COMMENT ON COLUMN sf_dim_fee.jsfs IS '适用结算方式';

-- 6. 支付方式维度表
CREATE TABLE sf_dim_payment_method (
    method_id SERIAL PRIMARY KEY,
    sffs VARCHAR(20) NOT NULL,
    sffs_name VARCHAR(40) NOT NULL,
    sffs_type VARCHAR(10),
    zfqd VARCHAR(20),
    is_online SMALLINT DEFAULT 0,
    is_third_party SMALLINT DEFAULT 0
);

COMMENT ON TABLE sf_dim_payment_method IS '支付方式维度表';
COMMENT ON COLUMN sf_dim_payment_method.method_id IS '支付方式主键';
COMMENT ON COLUMN sf_dim_payment_method.sffs IS '收费方式代码';
COMMENT ON COLUMN sf_dim_payment_method.sffs_name IS '收费方式名称';
COMMENT ON COLUMN sf_dim_payment_method.sffs_type IS '线上/线下';
COMMENT ON COLUMN sf_dim_payment_method.zfqd IS '支付渠道';
COMMENT ON COLUMN sf_dim_payment_method.is_online IS '是否线上支付';
COMMENT ON COLUMN sf_dim_payment_method.is_third_party IS '是否第三方支付';

-- ============================================================
-- 事实表 (Fact Tables)
-- ============================================================

-- 7. 收费结算事实表（核心事实表）
CREATE TABLE sf_rpt_charge (
    id BIGINT PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    customer_id BIGINT NOT NULL,
    mj_id BIGINT,
    fylb VARCHAR(20) NOT NULL,
    sfmj DECIMAL(10,3) DEFAULT 0,
    sl DECIMAL(10,3) DEFAULT 0,
    dj DECIMAL(10,3) DEFAULT 0,
    ysje DECIMAL(10,2) NOT NULL DEFAULT 0,
    sfje DECIMAL(10,2) DEFAULT 0,
    qfje DECIMAL(10,2) DEFAULT 0,
    zkje DECIMAL(10,2) DEFAULT 0,
    wyje DECIMAL(10,2) DEFAULT 0,
    hjje DECIMAL(10,2) DEFAULT 0,
    tgce DECIMAL(10,2) DEFAULT 0,
    jcys DECIMAL(10,2) DEFAULT 0,
    jsfs VARCHAR(10) NOT NULL,
    ybbm VARCHAR(20),
    cbzt SMALLINT DEFAULT 0,
    jldj DECIMAL(10,3),
    jlbs DECIMAL(10,2) DEFAULT 0,
    djlb VARCHAR(10),
    jldjlb VARCHAR(10),
    gnsc DECIMAL(10,3) DEFAULT 0,
    hrq_zt VARCHAR(10),
    hrq_sl DECIMAL(5,3),
    gnzt VARCHAR(5),
    event VARCHAR(20),
    business_id BIGINT,
    czy VARCHAR(10),
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sf_rpt_charge_fk_customer FOREIGN KEY (customer_id) REFERENCES sf_dim_customer(customer_id)
);

COMMENT ON TABLE sf_rpt_charge IS '收费结算事实表 - 来源:sf_mjjs_t';
COMMENT ON COLUMN sf_rpt_charge.id IS '主键';
COMMENT ON COLUMN sf_rpt_charge.cnq IS '采暖期';
COMMENT ON COLUMN sf_rpt_charge.customer_id IS '用户主键';
COMMENT ON COLUMN sf_rpt_charge.mj_id IS '面积主键';
COMMENT ON COLUMN sf_rpt_charge.fylb IS '费用类别';
COMMENT ON COLUMN sf_rpt_charge.sfmj IS '收费面积';
COMMENT ON COLUMN sf_rpt_charge.sl IS '数量';
COMMENT ON COLUMN sf_rpt_charge.dj IS '单价';
COMMENT ON COLUMN sf_rpt_charge.ysje IS '应收金额(元)';
COMMENT ON COLUMN sf_rpt_charge.sfje IS '实收金额(元)';
COMMENT ON COLUMN sf_rpt_charge.qfje IS '欠费金额(元)';
COMMENT ON COLUMN sf_rpt_charge.zkje IS '折扣金额(元)';
COMMENT ON COLUMN sf_rpt_charge.wyje IS '违约金额(元)';
COMMENT ON COLUMN sf_rpt_charge.hjje IS '核减金额(元)';
COMMENT ON COLUMN sf_rpt_charge.tgce IS '停供差额(元)';
COMMENT ON COLUMN sf_rpt_charge.jcys IS '基础应收(元)';
COMMENT ON COLUMN sf_rpt_charge.jsfs IS '结算方式';
COMMENT ON COLUMN sf_rpt_charge.ybbm IS '仪表编码';
COMMENT ON COLUMN sf_rpt_charge.cbzt IS '抄表状态:0-未抄表 1-已抄表';
COMMENT ON COLUMN sf_rpt_charge.jldj IS '计量单价';
COMMENT ON COLUMN sf_rpt_charge.jlbs IS '计量表数';
COMMENT ON COLUMN sf_rpt_charge.djlb IS '单价类别';
COMMENT ON COLUMN sf_rpt_charge.jldjlb IS '计量单价类别';
COMMENT ON COLUMN sf_rpt_charge.gnsc IS '供暖时长';
COMMENT ON COLUMN sf_rpt_charge.hrq_zt IS '换热器状态';
COMMENT ON COLUMN sf_rpt_charge.hrq_sl IS '换热器数量';
COMMENT ON COLUMN sf_rpt_charge.gnzt IS '供暖状态';
COMMENT ON COLUMN sf_rpt_charge.event IS '业务事件:面积变更/停供/复供';
COMMENT ON COLUMN sf_rpt_charge.business_id IS '业务事件ID';
COMMENT ON COLUMN sf_rpt_charge.czy IS '操作员';
COMMENT ON COLUMN sf_rpt_charge.zf IS '是否作废';
COMMENT ON COLUMN sf_rpt_charge.create_time IS '创建时间';
COMMENT ON COLUMN sf_rpt_charge.update_time IS '更新时间';

CREATE INDEX sf_idx_charge_cnq ON sf_rpt_charge(cnq);
CREATE INDEX sf_idx_charge_customer ON sf_rpt_charge(customer_id);
CREATE INDEX sf_idx_charge_fylb ON sf_rpt_charge(fylb);
CREATE INDEX sf_idx_charge_gnzt ON sf_rpt_charge(gnzt);

-- 8. 收费明细事实表
CREATE TABLE sf_rpt_payment (
    id BIGINT PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    customer_id BIGINT NOT NULL,
    mjjs_id BIGINT NOT NULL,
    fylb VARCHAR(10) NOT NULL,
    sfrq TIMESTAMP NOT NULL,
    sfje DECIMAL(10,2) NOT NULL DEFAULT 0,
    wyje DECIMAL(10,2) DEFAULT 0,
    zkje DECIMAL(10,2) DEFAULT 0,
    sl DECIMAL(10,3) NOT NULL,
    dj DECIMAL(10,3) NOT NULL,
    djlb VARCHAR(10),
    gnsc DECIMAL(10,3) DEFAULT 0,
    sffs VARCHAR(10) NOT NULL,
    fplb VARCHAR(10),
    fpdm VARCHAR(20),
    fphm VARCHAR(20),
    zfqd VARCHAR(10) DEFAULT '公司自收',
    yywd VARCHAR(20),
    lsh VARCHAR(30),
    dzzt SMALLINT DEFAULT 0,
    czy VARCHAR(50) NOT NULL,
    czbh BIGINT NOT NULL,
    term_sn VARCHAR(31),
    bill_id VARCHAR(255) DEFAULT '',
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sf_rpt_payment_fk_customer FOREIGN KEY (customer_id) REFERENCES sf_dim_customer(customer_id)
);

COMMENT ON TABLE sf_rpt_payment IS '收费明细事实表 - 来源:sf_mjsf_t';
COMMENT ON COLUMN sf_rpt_payment.id IS '主键';
COMMENT ON COLUMN sf_rpt_payment.cnq IS '采暖期';
COMMENT ON COLUMN sf_rpt_payment.customer_id IS '用户主键';
COMMENT ON COLUMN sf_rpt_payment.mjjs_id IS '结算主键';
COMMENT ON COLUMN sf_rpt_payment.fylb IS '费用类别';
COMMENT ON COLUMN sf_rpt_payment.sfrq IS '收费日期';
COMMENT ON COLUMN sf_rpt_payment.sfje IS '收费金额(元)';
COMMENT ON COLUMN sf_rpt_payment.wyje IS '违约金额(元)';
COMMENT ON COLUMN sf_rpt_payment.zkje IS '折扣金额(元)';
COMMENT ON COLUMN sf_rpt_payment.sl IS '数量';
COMMENT ON COLUMN sf_rpt_payment.dj IS '单价';
COMMENT ON COLUMN sf_rpt_payment.djlb IS '单价类别';
COMMENT ON COLUMN sf_rpt_payment.gnsc IS '供暖时长';
COMMENT ON COLUMN sf_rpt_payment.sffs IS '收费方式';
COMMENT ON COLUMN sf_rpt_payment.fplb IS '发票类别';
COMMENT ON COLUMN sf_rpt_payment.fpdm IS '发票代码';
COMMENT ON COLUMN sf_rpt_payment.fphm IS '发票号码';
COMMENT ON COLUMN sf_rpt_payment.zfqd IS '支付渠道';
COMMENT ON COLUMN sf_rpt_payment.yywd IS '营业网点';
COMMENT ON COLUMN sf_rpt_payment.lsh IS '第三方流水号';
COMMENT ON COLUMN sf_rpt_payment.dzzt IS '对账状态';
COMMENT ON COLUMN sf_rpt_payment.czy IS '操作员';
COMMENT ON COLUMN sf_rpt_payment.czbh IS '操作编号';
COMMENT ON COLUMN sf_rpt_payment.term_sn IS '终端设备编码';
COMMENT ON COLUMN sf_rpt_payment.bill_id IS '红冲申请单编号';
COMMENT ON COLUMN sf_rpt_payment.zf IS '是否作废';
COMMENT ON COLUMN sf_rpt_payment.create_time IS '创建时间';
COMMENT ON COLUMN sf_rpt_payment.update_time IS '更新时间';

CREATE INDEX sf_idx_payment_cnq ON sf_rpt_payment(cnq);
CREATE INDEX sf_idx_payment_customer ON sf_rpt_payment(customer_id);
CREATE INDEX sf_idx_payment_sfrq ON sf_rpt_payment(sfrq);
CREATE INDEX sf_idx_payment_sffs ON sf_rpt_payment(sffs);

-- 9. 停供复供事实表
CREATE TABLE sf_fact_stop_restart (
    id BIGINT PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    customer_id BIGINT NOT NULL,
    area_id BIGINT,
    mj_id BIGINT,
    ywlx VARCHAR(5) NOT NULL,
    tgmj DECIMAL(10,3) NOT NULL,
    djlb VARCHAR(10) NOT NULL,
    dj DECIMAL(10,2) NOT NULL,
    tgbl DECIMAL(5,4) DEFAULT 0,
    tgce DECIMAL(10,2) DEFAULT 0,
    ce_cnf DECIMAL(10,2) DEFAULT 0,
    ce_jbcnf DECIMAL(10,2) DEFAULT 0,
    tgyy VARCHAR(60),
    tglx VARCHAR(10),
    ksrq DATE,
    jsrq DATE,
    sqrq TIMESTAMP,
    kgszt SMALLINT DEFAULT 1,
    shzt VARCHAR(5) NOT NULL,
    parent_id BIGINT,
    sh_id BIGINT,
    czr VARCHAR(10),
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sf_fact_stop_restart IS '停供复供事实表 - 来源:sf_mjtg_t';
COMMENT ON COLUMN sf_fact_stop_restart.id IS '主键';
COMMENT ON COLUMN sf_fact_stop_restart.cnq IS '采暖期';
COMMENT ON COLUMN sf_fact_stop_restart.customer_id IS '用户主键';
COMMENT ON COLUMN sf_fact_stop_restart.area_id IS '面积主键';
COMMENT ON COLUMN sf_fact_stop_restart.mj_id IS '面积记录主键';
COMMENT ON COLUMN sf_fact_stop_restart.ywlx IS '业务类型:停供/复供';
COMMENT ON COLUMN sf_fact_stop_restart.tgmj IS '停供面积';
COMMENT ON COLUMN sf_fact_stop_restart.djlb IS '单价类别';
COMMENT ON COLUMN sf_fact_stop_restart.dj IS '单价';
COMMENT ON COLUMN sf_fact_stop_restart.tgbl IS '停供比率';
COMMENT ON COLUMN sf_fact_stop_restart.tgce IS '停供差额';
COMMENT ON COLUMN sf_fact_stop_restart.ce_cnf IS '采暖费差额';
COMMENT ON COLUMN sf_fact_stop_restart.ce_jbcnf IS '基本采暖费差额';
COMMENT ON COLUMN sf_fact_stop_restart.tgyy IS '停供原因';
COMMENT ON COLUMN sf_fact_stop_restart.tglx IS '停供类型';
COMMENT ON COLUMN sf_fact_stop_restart.ksrq IS '开始日期';
COMMENT ON COLUMN sf_fact_stop_restart.jsrq IS '结束日期';
COMMENT ON COLUMN sf_fact_stop_restart.sqrq IS '申请日期';
COMMENT ON COLUMN sf_fact_stop_restart.kgszt IS '开关栓状态:0-关栓 1-开栓';
COMMENT ON COLUMN sf_fact_stop_restart.shzt IS '审核状态:审核中/通过/未通过';
COMMENT ON COLUMN sf_fact_stop_restart.parent_id IS '复供对应的停供主键';
COMMENT ON COLUMN sf_fact_stop_restart.sh_id IS '审核材料主键';
COMMENT ON COLUMN sf_fact_stop_restart.czr IS '操作员';
COMMENT ON COLUMN sf_fact_stop_restart.zf IS '是否作废';
COMMENT ON COLUMN sf_fact_stop_restart.create_time IS '创建时间';
COMMENT ON COLUMN sf_fact_stop_restart.update_time IS '更新时间';

CREATE INDEX sf_idx_stop_cnq ON sf_fact_stop_restart(cnq);
CREATE INDEX sf_idx_stop_customer ON sf_fact_stop_restart(customer_id);
CREATE INDEX sf_idx_stop_type ON sf_fact_stop_restart(ywlx);
CREATE INDEX sf_idx_stop_status ON sf_fact_stop_restart(shzt);

-- 10. 更名过户事实表
CREATE TABLE sf_fact_name_transfer (
    id BIGINT PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    customer_id BIGINT NOT NULL,
    old_name VARCHAR(60),
    new_name VARCHAR(40) NOT NULL,
    old_id_number VARCHAR(20),
    new_id_number VARCHAR(20),
    old_mob_no VARCHAR(20),
    new_mob_no VARCHAR(20),
    third_type VARCHAR(40),
    third_id VARCHAR(40),
    mini_third_id VARCHAR(40),
    shzt VARCHAR(5) NOT NULL,
    czr VARCHAR(10) NOT NULL,
    czbh BIGINT NOT NULL,
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sf_fact_name_transfer IS '更名过户事实表 - 来源:sf_gmgh_t';
COMMENT ON COLUMN sf_fact_name_transfer.id IS '主键';
COMMENT ON COLUMN sf_fact_name_transfer.cnq IS '采暖期';
COMMENT ON COLUMN sf_fact_name_transfer.customer_id IS '用户主键';
COMMENT ON COLUMN sf_fact_name_transfer.old_name IS '原用户名称';
COMMENT ON COLUMN sf_fact_name_transfer.new_name IS '新用户名称';
COMMENT ON COLUMN sf_fact_name_transfer.old_id_number IS '原身份证号';
COMMENT ON COLUMN sf_fact_name_transfer.new_id_number IS '新身份证号';
COMMENT ON COLUMN sf_fact_name_transfer.old_mob_no IS '原手机号';
COMMENT ON COLUMN sf_fact_name_transfer.new_mob_no IS '新手机号';
COMMENT ON COLUMN sf_fact_name_transfer.third_type IS '第三方渠道';
COMMENT ON COLUMN sf_fact_name_transfer.third_id IS '微信公众号openId';
COMMENT ON COLUMN sf_fact_name_transfer.mini_third_id IS '微信小程序openId';
COMMENT ON COLUMN sf_fact_name_transfer.shzt IS '审核状态';
COMMENT ON COLUMN sf_fact_name_transfer.czr IS '操作员';
COMMENT ON COLUMN sf_fact_name_transfer.czbh IS '操作编号';
COMMENT ON COLUMN sf_fact_name_transfer.zf IS '是否作废';
COMMENT ON COLUMN sf_fact_name_transfer.create_time IS '创建时间';

-- 11. 面积变更事实表
CREATE TABLE sf_fact_area_change (
    id BIGINT PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    customer_id BIGINT NOT NULL,
    area_id BIGINT NOT NULL,
    bgnr VARCHAR(1000) NOT NULL,
    bgnrs VARCHAR(1000) NOT NULL,
    mob_no VARCHAR(20),
    third_type VARCHAR(40),
    third_id VARCHAR(40),
    mini_third_id VARCHAR(40),
    shzt VARCHAR(5) NOT NULL,
    czr VARCHAR(10) NOT NULL,
    czbh BIGINT NOT NULL,
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sf_fact_area_change IS '面积变更事实表 - 来源:sf_mjbg_t';
COMMENT ON COLUMN sf_fact_area_change.id IS '主键';
COMMENT ON COLUMN sf_fact_area_change.cnq IS '采暖期';
COMMENT ON COLUMN sf_fact_area_change.customer_id IS '用户主键';
COMMENT ON COLUMN sf_fact_area_change.area_id IS '面积主键';
COMMENT ON COLUMN sf_fact_area_change.bgnr IS '变更内容';
COMMENT ON COLUMN sf_fact_area_change.bgnrs IS '详细变更内容';
COMMENT ON COLUMN sf_fact_area_change.mob_no IS '手机号码';
COMMENT ON COLUMN sf_fact_area_change.third_type IS '第三方渠道';
COMMENT ON COLUMN sf_fact_area_change.third_id IS '微信公众号openId';
COMMENT ON COLUMN sf_fact_area_change.mini_third_id IS '微信小程序openId';
COMMENT ON COLUMN sf_fact_area_change.shzt IS '审核状态';
COMMENT ON COLUMN sf_fact_area_change.czr IS '操作员';
COMMENT ON COLUMN sf_fact_area_change.czbh IS '操作编号';
COMMENT ON COLUMN sf_fact_area_change.zf IS '是否作废';
COMMENT ON COLUMN sf_fact_area_change.create_time IS '创建时间';

-- 12. 稽查事实表
CREATE TABLE sf_fact_inspection (
    id BIGINT PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    customer_id BIGINT NOT NULL,
    plan_id BIGINT,
    status VARCHAR(10) NOT NULL,
    jcz VARCHAR(10),
    jcr VARCHAR(10),
    clr VARCHAR(10),
    jcrq TIMESTAMP,
    jcjg VARCHAR(10),
    jcwt VARCHAR(50),
    fmzt_gs VARCHAR(10),
    fmzt_hs VARCHAR(10),
    error_type VARCHAR(40),
    error_description VARCHAR(550),
    handle_result VARCHAR(512),
    service_fee DECIMAL(10,2),
    wyje DECIMAL(10,2) DEFAULT 0,
    sfje DECIMAL(10,2) DEFAULT 0,
    qfje DECIMAL(10,2) DEFAULT 0,
    crm_task_id BIGINT,
    czr VARCHAR(10),
    zf SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE sf_fact_inspection IS '稽查事实表 - 来源:jc_plan_detail/jc_check_feedback';
COMMENT ON COLUMN sf_fact_inspection.id IS '主键';
COMMENT ON COLUMN sf_fact_inspection.cnq IS '采暖期';
COMMENT ON COLUMN sf_fact_inspection.customer_id IS '用户主键';
COMMENT ON COLUMN sf_fact_inspection.plan_id IS '稽查计划主键';
COMMENT ON COLUMN sf_fact_inspection.status IS '稽查状态';
COMMENT ON COLUMN sf_fact_inspection.jcz IS '稽查组';
COMMENT ON COLUMN sf_fact_inspection.jcr IS '稽查人';
COMMENT ON COLUMN sf_fact_inspection.clr IS '处理人';
COMMENT ON COLUMN sf_fact_inspection.jcrq IS '稽查日期';
COMMENT ON COLUMN sf_fact_inspection.jcjg IS '稽查结果';
COMMENT ON COLUMN sf_fact_inspection.jcwt IS '稽查问题';
COMMENT ON COLUMN sf_fact_inspection.fmzt_gs IS '供水阀状态';
COMMENT ON COLUMN sf_fact_inspection.fmzt_hs IS '回水阀状态';
COMMENT ON COLUMN sf_fact_inspection.error_type IS '稽查问题类型';
COMMENT ON COLUMN sf_fact_inspection.error_description IS '问题描述';
COMMENT ON COLUMN sf_fact_inspection.handle_result IS '处理结果';
COMMENT ON COLUMN sf_fact_inspection.service_fee IS '服务费(管道恢复费)';
COMMENT ON COLUMN sf_fact_inspection.wyje IS '违约金额';
COMMENT ON COLUMN sf_fact_inspection.sfje IS '收费金额';
COMMENT ON COLUMN sf_fact_inspection.qfje IS '欠费金额';
COMMENT ON COLUMN sf_fact_inspection.crm_task_id IS '客服工单ID';
COMMENT ON COLUMN sf_fact_inspection.czr IS '操作员';
COMMENT ON COLUMN sf_fact_inspection.zf IS '是否作废';
COMMENT ON COLUMN sf_fact_inspection.create_time IS '创建时间';
COMMENT ON COLUMN sf_fact_inspection.update_time IS '更新时间';

CREATE INDEX sf_idx_inspection_cnq ON sf_fact_inspection(cnq);
CREATE INDEX sf_idx_inspection_customer ON sf_fact_inspection(customer_id);
CREATE INDEX sf_idx_inspection_status ON sf_fact_inspection(status);

-- ============================================================
-- 汇总表 (Aggregate Tables)
-- ============================================================

-- 13. 采暖期收费汇总表
CREATE TABLE sf_rpt_cnq_charge (
    id BIGSERIAL PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    fylb VARCHAR(20),
    gnzt VARCHAR(5),
    yhlx VARCHAR(10),
    djlb VARCHAR(40),
    org_level1 VARCHAR(20),
    org_level2 VARCHAR(20),
    org_level3 VARCHAR(30),
    customer_cnt INT DEFAULT 0,
    area_cnt INT DEFAULT 0,
    sfmj_sum DECIMAL(15,3) DEFAULT 0,
    ysje_sum DECIMAL(15,2) DEFAULT 0,
    sfje_sum DECIMAL(15,2) DEFAULT 0,
    qfje_sum DECIMAL(15,2) DEFAULT 0,
    zkje_sum DECIMAL(15,2) DEFAULT 0,
    wyje_sum DECIMAL(15,2) DEFAULT 0,
    hjje_sum DECIMAL(15,2) DEFAULT 0,
    pay_cnt INT DEFAULT 0,
    pay_rate DECIMAL(5,2),
    unit_price DECIMAL(10,2),
    avg_fee DECIMAL(10,2),
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(cnq, fylb, gnzt, yhlx, djlb, org_level1, org_level2, org_level3)
);

COMMENT ON TABLE sf_rpt_cnq_charge IS '采暖期收费汇总表';
COMMENT ON COLUMN sf_rpt_cnq_charge.id IS '主键';
COMMENT ON COLUMN sf_rpt_cnq_charge.cnq IS '采暖期';
COMMENT ON COLUMN sf_rpt_cnq_charge.fylb IS '费用类别';
COMMENT ON COLUMN sf_rpt_cnq_charge.gnzt IS '供暖状态';
COMMENT ON COLUMN sf_rpt_cnq_charge.yhlx IS '用户类型';
COMMENT ON COLUMN sf_rpt_cnq_charge.djlb IS '单价类别';
COMMENT ON COLUMN sf_rpt_cnq_charge.org_level1 IS '分公司';
COMMENT ON COLUMN sf_rpt_cnq_charge.org_level2 IS '热力站';
COMMENT ON COLUMN sf_rpt_cnq_charge.org_level3 IS '小区';
COMMENT ON COLUMN sf_rpt_cnq_charge.customer_cnt IS '用户数';
COMMENT ON COLUMN sf_rpt_cnq_charge.area_cnt IS '面积数';
COMMENT ON COLUMN sf_rpt_cnq_charge.sfmj_sum IS '收费面积合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.ysje_sum IS '应收金额合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.sfje_sum IS '实收金额合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.qfje_sum IS '欠费金额合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.zkje_sum IS '折扣金额合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.wyje_sum IS '违约金额合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.hjje_sum IS '核减金额合计';
COMMENT ON COLUMN sf_rpt_cnq_charge.pay_cnt IS '收费笔数';
COMMENT ON COLUMN sf_rpt_cnq_charge.pay_rate IS '收费率(%)';
COMMENT ON COLUMN sf_rpt_cnq_charge.unit_price IS '单位面积热费(元/平方米)';
COMMENT ON COLUMN sf_rpt_cnq_charge.avg_fee IS '户均热费(元/户)';
COMMENT ON COLUMN sf_rpt_cnq_charge.update_time IS '更新时间';

CREATE INDEX sf_idx_cnq_charge_cnq ON sf_rpt_cnq_charge(cnq);
CREATE INDEX sf_idx_cnq_charge_org ON sf_rpt_cnq_charge(org_level1, org_level2, org_level3);

-- 14. 月度收费汇总表
CREATE TABLE sf_rpt_month_charge (
    id BIGSERIAL PRIMARY KEY,
    stat_month VARCHAR(7) NOT NULL,
    cnq VARCHAR(10),
    sffs VARCHAR(10),
    zfqd VARCHAR(20),
    org_level1 VARCHAR(20),
    org_level2 VARCHAR(20),
    customer_cnt INT DEFAULT 0,
    pay_cnt INT DEFAULT 0,
    sfje_sum DECIMAL(15,2) DEFAULT 0,
    wyje_sum DECIMAL(15,2) DEFAULT 0,
    zkje_sum DECIMAL(15,2) DEFAULT 0,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(stat_month, sffs, zfqd, org_level1, org_level2)
);

COMMENT ON TABLE sf_rpt_month_charge IS '月度收费汇总表';
COMMENT ON COLUMN sf_rpt_month_charge.id IS '主键';
COMMENT ON COLUMN sf_rpt_month_charge.stat_month IS '统计月份(YYYY-MM)';
COMMENT ON COLUMN sf_rpt_month_charge.cnq IS '采暖期';
COMMENT ON COLUMN sf_rpt_month_charge.sffs IS '收费方式';
COMMENT ON COLUMN sf_rpt_month_charge.zfqd IS '支付渠道';
COMMENT ON COLUMN sf_rpt_month_charge.org_level1 IS '分公司';
COMMENT ON COLUMN sf_rpt_month_charge.org_level2 IS '热力站';
COMMENT ON COLUMN sf_rpt_month_charge.customer_cnt IS '缴费用户数';
COMMENT ON COLUMN sf_rpt_month_charge.pay_cnt IS '收费笔数';
COMMENT ON COLUMN sf_rpt_month_charge.sfje_sum IS '收费金额合计';
COMMENT ON COLUMN sf_rpt_month_charge.wyje_sum IS '违约金额合计';
COMMENT ON COLUMN sf_rpt_month_charge.zkje_sum IS '折扣金额合计';
COMMENT ON COLUMN sf_rpt_month_charge.update_time IS '更新时间';

CREATE INDEX sf_idx_month_charge_month ON sf_rpt_month_charge(stat_month);
CREATE INDEX sf_idx_month_charge_sffs ON sf_rpt_month_charge(sffs);

-- 15. 每日收费汇总表
CREATE TABLE sf_rpt_daily_charge (
    id BIGSERIAL PRIMARY KEY,
    stat_date DATE NOT NULL,
    cnq VARCHAR(10),
    stat_month VARCHAR(7),
    sffs VARCHAR(10),
    org_level1 VARCHAR(20),
    customer_cnt INT DEFAULT 0,
    pay_cnt INT DEFAULT 0,
    sfje_sum DECIMAL(15,2) DEFAULT 0,
    wyje_sum DECIMAL(15,2) DEFAULT 0,
    zkje_sum DECIMAL(15,2) DEFAULT 0,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(stat_date, sffs, org_level1)
);

COMMENT ON TABLE sf_rpt_daily_charge IS '每日收费汇总表';
COMMENT ON COLUMN sf_rpt_daily_charge.id IS '主键';
COMMENT ON COLUMN sf_rpt_daily_charge.stat_date IS '统计日期';
COMMENT ON COLUMN sf_rpt_daily_charge.cnq IS '采暖期';
COMMENT ON COLUMN sf_rpt_daily_charge.stat_month IS '统计月份';
COMMENT ON COLUMN sf_rpt_daily_charge.sffs IS '收费方式';
COMMENT ON COLUMN sf_rpt_daily_charge.org_level1 IS '分公司';
COMMENT ON COLUMN sf_rpt_daily_charge.customer_cnt IS '缴费用户数';
COMMENT ON COLUMN sf_rpt_daily_charge.pay_cnt IS '收费笔数';
COMMENT ON COLUMN sf_rpt_daily_charge.sfje_sum IS '收费金额合计';
COMMENT ON COLUMN sf_rpt_daily_charge.wyje_sum IS '违约金额合计';
COMMENT ON COLUMN sf_rpt_daily_charge.zkje_sum IS '折扣金额合计';
COMMENT ON COLUMN sf_rpt_daily_charge.update_time IS '更新时间';

CREATE INDEX sf_idx_daily_charge_date ON sf_rpt_daily_charge(stat_date);

-- 16. 欠费分析汇总表
CREATE TABLE sf_rpt_arrears (
    id BIGSERIAL PRIMARY KEY,
    cnq VARCHAR(10) NOT NULL,
    arrears_level VARCHAR(10),
    yhlx VARCHAR(10),
    org_level1 VARCHAR(20),
    org_level2 VARCHAR(20),
    org_level3 VARCHAR(30),
    customer_cnt INT DEFAULT 0,
    area_cnt INT DEFAULT 0,
    sfmj_sum DECIMAL(15,3) DEFAULT 0,
    ysje_sum DECIMAL(15,2) DEFAULT 0,
    sfje_sum DECIMAL(15,2) DEFAULT 0,
    qfje_sum DECIMAL(15,2) DEFAULT 0,
    arrears_rate DECIMAL(5,2),
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(cnq, arrears_level, yhlx, org_level1, org_level2, org_level3)
);

COMMENT ON TABLE sf_rpt_arrears IS '欠费分析汇总表';
COMMENT ON COLUMN sf_rpt_arrears.id IS '主键';
COMMENT ON COLUMN sf_rpt_arrears.cnq IS '采暖期';
COMMENT ON COLUMN sf_rpt_arrears.arrears_level IS '欠费等级:重大欠费/一般欠费/轻微欠费';
COMMENT ON COLUMN sf_rpt_arrears.yhlx IS '用户类型';
COMMENT ON COLUMN sf_rpt_arrears.org_level1 IS '分公司';
COMMENT ON COLUMN sf_rpt_arrears.org_level2 IS '热力站';
COMMENT ON COLUMN sf_rpt_arrears.org_level3 IS '小区';
COMMENT ON COLUMN sf_rpt_arrears.customer_cnt IS '欠费用户数';
COMMENT ON COLUMN sf_rpt_arrears.area_cnt IS '欠费面积数';
COMMENT ON COLUMN sf_rpt_arrears.sfmj_sum IS '收费面积';
COMMENT ON COLUMN sf_rpt_arrears.ysje_sum IS '应收金额';
COMMENT ON COLUMN sf_rpt_arrears.sfje_sum IS '实收金额';
COMMENT ON COLUMN sf_rpt_arrears.qfje_sum IS '欠费金额';
COMMENT ON COLUMN sf_rpt_arrears.arrears_rate IS '欠费率(%)';
COMMENT ON COLUMN sf_rpt_arrears.update_time IS '更新时间';

CREATE INDEX sf_idx_arrears_cnq ON sf_rpt_arrears(cnq);
CREATE INDEX sf_idx_arrears_level ON sf_rpt_arrears(arrears_level);

-- ============================================================
-- ETL数据同步函数
-- ============================================================

-- 从MySQL同步用户数据到PostgreSQL
CREATE OR REPLACE FUNCTION sf_sync_customer_from_mysql()
RETURNS void AS $$
BEGIN
    INSERT INTO sf_dim_customer
    SELECT 
        id,
        code,
        name,
        id_number,
        tel_no,
        mob_no,
        yhlx,
        rwrq,
        rwht_bh,
        kzfs,
        kz_hmd,
        kz_sf,
        kz_yhsf,
        kz_jcsh,
        rlz_id,
        zdfq_id,
        zdfq_name,
        hrq_zt,
        xzcnq,
        zf,
        created_time,
        updated_time
    FROM mysql_linked_server.customer
    WHERE zf = 0
    ON CONFLICT (customer_id) DO UPDATE SET
        customer_name = EXCLUDED.customer_name,
        mob_no = EXCLUDED.mob_no,
        kz_hmd = EXCLUDED.kz_hmd,
        update_time = CURRENT_TIMESTAMP;

    RAISE NOTICE 'sf_dim_customer 同步完成';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_sync_customer_from_mysql() IS '从MySQL同步用户数据到sf_dim_customer';

-- 从MySQL同步组织数据到PostgreSQL
CREATE OR REPLACE FUNCTION sf_sync_org_from_mysql()
RETURNS void AS $$
BEGIN
    INSERT INTO sf_dim_org
    SELECT 
        id,
        parent_id,
        one,
        two,
        three,
        CASE 
            WHEN type = 0 THEN '分公司'
            WHEN type = 1 THEN '热力站'
            WHEN type = 2 THEN '小区'
            ELSE '其他'
        END,
        address_prefix,
        unit,
        floor,
        room,
        address,
        rlz_id,
        name,
        state,
        jzmj,
        zf
    FROM mysql_linked_server.sys_address
    WHERE zf = 0
    ON CONFLICT (org_id) DO UPDATE SET
        org_level3 = EXCLUDED.org_level3,
        rlz_name = EXCLUDED.rlz_name,
        state = EXCLUDED.state;

    RAISE NOTICE 'sf_dim_org 同步完成';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_sync_org_from_mysql() IS '从MySQL同步组织数据到sf_dim_org';

-- 从MySQL同步收费结算数据到PostgreSQL
CREATE OR REPLACE FUNCTION sf_sync_charge_from_mysql()
RETURNS void AS $$
BEGIN
    INSERT INTO sf_rpt_charge
    SELECT 
        id,
        cnq,
        customer_id,
        mj_id,
        fylb,
        sfmj,
        sl,
        dj,
        ysje,
        sfje,
        qfje,
        zkje,
        wyje,
        hjje,
        tgce,
        jcys,
        jsfs,
        ybbm,
        cbzt,
        jldj,
        jlbs,
        djlb,
        jldjlb,
        gnsc,
        hrq_zt,
        hrq_sl,
        gnzt,
        event,
        business_id,
        czy,
        zf,
        created_time,
        updated_time
    FROM mysql_linked_server.sf_mjjs_t
    WHERE zf = 0
    ON CONFLICT (id) DO UPDATE SET
        sfje = EXCLUDED.sfje,
        qfje = EXCLUDED.qfje,
        update_time = CURRENT_TIMESTAMP;

    RAISE NOTICE 'sf_rpt_charge 同步完成';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_sync_charge_from_mysql() IS '从MySQL同步收费结算数据到sf_rpt_charge';

-- 从MySQL同步收费明细数据到PostgreSQL
CREATE OR REPLACE FUNCTION sf_sync_payment_from_mysql()
RETURNS void AS $$
BEGIN
    INSERT INTO sf_rpt_payment
    SELECT 
        id,
        cnq,
        customer_id,
        mjjs_id,
        fylb,
        sfrq,
        sfje,
        wyje,
        zkje,
        sl,
        dj,
        djlb,
        gnsc,
        sffs,
        fplb,
        fpdm,
        fphm,
        zfqd,
        yywd,
        lsh,
        dzzt,
        czy,
        czbh,
        term_sn,
        bill_id,
        zf,
        created_time,
        updated_time
    FROM mysql_linked_server.sf_mjsf_t
    WHERE zf = 0
    ON CONFLICT (id) DO UPDATE SET
        sfje = EXCLUDED.sfje,
        update_time = CURRENT_TIMESTAMP;

    RAISE NOTICE 'sf_rpt_payment 同步完成';
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_sync_payment_from_mysql() IS '从MySQL同步收费明细数据到sf_rpt_payment';

-- ============================================================
-- 汇总表刷新存储过程
-- ============================================================

-- 刷新采暖期收费汇总表
CREATE OR REPLACE FUNCTION sf_refresh_cnq_charge(p_cnq VARCHAR)
RETURNS void AS $$
BEGIN
    DELETE FROM sf_rpt_cnq_charge WHERE cnq = p_cnq;

    INSERT INTO sf_rpt_cnq_charge (
        cnq, fylb, gnzt, yhlx, djlb, 
        org_level1, org_level2, org_level3,
        customer_cnt, area_cnt, sfmj_sum,
        ysje_sum, sfje_sum, qfje_sum,
        zkje_sum, wyje_sum, hjje_sum,
        pay_cnt, pay_rate, unit_price, avg_fee
    )
    SELECT 
        m.cnq,
        m.fylb,
        m.gnzt,
        c.yhlx,
        m.djlb,
        c.org_level1,
        c.org_level2,
        c.zdfq_name,
        COUNT(DISTINCT m.customer_id),
        COUNT(*),
        SUM(m.sfmj),
        SUM(m.ysje),
        SUM(m.sfje),
        SUM(m.qfje),
        SUM(m.zkje),
        SUM(m.wyje),
        SUM(m.hjje),
        0,
        CASE WHEN SUM(m.ysje) > 0 
             THEN ROUND(SUM(m.sfje) / SUM(m.ysje) * 100, 2)
             ELSE 0 END,
        CASE WHEN SUM(m.sfmj) > 0 
             THEN ROUND(SUM(m.sfje) / SUM(m.sfmj), 2)
             ELSE 0 END,
        CASE WHEN COUNT(DISTINCT m.customer_id) > 0 
             THEN ROUND(SUM(m.sfje) / COUNT(DISTINCT m.customer_id), 2)
             ELSE 0 END
    FROM sf_rpt_charge m
    LEFT JOIN sf_dim_customer c ON m.customer_id = c.customer_id
    WHERE m.cnq = p_cnq AND m.zf = 0
    GROUP BY m.cnq, m.fylb, m.gnzt, c.yhlx, m.djlb, c.org_level1, c.org_level2, c.zdfq_name;

    RAISE NOTICE '采暖期 % 汇总刷新完成', p_cnq;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_refresh_cnq_charge(VARCHAR) IS '刷新sf_rpt_cnq_charge汇总表';

-- 刷新月度收费汇总表
CREATE OR REPLACE FUNCTION sf_refresh_month_charge(p_month VARCHAR)
RETURNS void AS $$
BEGIN
    DELETE FROM sf_rpt_month_charge WHERE stat_month = p_month;

    INSERT INTO sf_rpt_month_charge (
        stat_month, cnq, sffs, zfqd, org_level1, org_level2,
        customer_cnt, pay_cnt, sfje_sum, wyje_sum, zkje_sum
    )
    SELECT 
        TO_CHAR(p.sfrq, 'YYYY-MM'),
        p.cnq,
        p.sffs,
        p.zfqd,
        c.org_level1,
        c.org_level2,
        COUNT(DISTINCT p.customer_id),
        COUNT(*),
        SUM(p.sfje),
        SUM(p.wyje),
        SUM(p.zkje)
    FROM sf_rpt_payment p
    LEFT JOIN sf_dim_customer c ON p.customer_id = c.customer_id
    WHERE TO_CHAR(p.sfrq, 'YYYY-MM') = p_month AND p.zf = 0
    GROUP BY TO_CHAR(p.sfrq, 'YYYY-MM'), p.cnq, p.sffs, p.zfqd, c.org_level1, c.org_level2;

    RAISE NOTICE '月份 % 汇总刷新完成', p_month;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_refresh_month_charge(VARCHAR) IS '刷新sf_rpt_month_charge汇总表';

-- 刷新每日收费汇总表
CREATE OR REPLACE FUNCTION sf_refresh_daily_charge(p_date DATE)
RETURNS void AS $$
BEGIN
    DELETE FROM sf_rpt_daily_charge WHERE stat_date = p_date;

    INSERT INTO sf_rpt_daily_charge (
        stat_date, cnq, stat_month, sffs, org_level1,
        customer_cnt, pay_cnt, sfje_sum, wyje_sum, zkje_sum
    )
    SELECT 
        p.sfrq::DATE,
        p.cnq,
        TO_CHAR(p.sfrq, 'YYYY-MM'),
        p.sffs,
        c.org_level1,
        COUNT(DISTINCT p.customer_id),
        COUNT(*),
        SUM(p.sfje),
        SUM(p.wyje),
        SUM(p.zkje)
    FROM sf_rpt_payment p
    LEFT JOIN sf_dim_customer c ON p.customer_id = c.customer_id
    WHERE p.sfrq::DATE = p_date AND p.zf = 0
    GROUP BY p.sfrq::DATE, p.cnq, TO_CHAR(p.sfrq, 'YYYY-MM'), p.sffs, c.org_level1;

    RAISE NOTICE '日期 % 汇总刷新完成', p_date;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_refresh_daily_charge(DATE) IS '刷新sf_rpt_daily_charge汇总表';

-- 刷新欠费分析汇总表
CREATE OR REPLACE FUNCTION sf_refresh_arrears(p_cnq VARCHAR)
RETURNS void AS $$
BEGIN
    DELETE FROM sf_rpt_arrears WHERE cnq = p_cnq;

    INSERT INTO sf_rpt_arrears (
        cnq, arrears_level, yhlx, org_level1, org_level2, org_level3,
        customer_cnt, area_cnt, sfmj_sum,
        ysje_sum, sfje_sum, qfje_sum, arrears_rate
    )
    SELECT 
        m.cnq,
        CASE 
            WHEN SUM(m.qfje) >= 10000 THEN '重大欠费'
            WHEN SUM(m.qfje) >= 1000 THEN '一般欠费'
            ELSE '轻微欠费'
        END,
        c.yhlx,
        c.org_level1,
        c.org_level2,
        c.zdfq_name,
        COUNT(DISTINCT m.customer_id),
        COUNT(*),
        SUM(m.sfmj),
        SUM(m.ysje),
        SUM(m.sfje),
        SUM(m.qfje),
        CASE WHEN SUM(m.ysje) > 0 
             THEN ROUND(SUM(m.qfje) / SUM(m.ysje) * 100, 2)
             ELSE 0 END
    FROM sf_rpt_charge m
    LEFT JOIN sf_dim_customer c ON m.customer_id = c.customer_id
    WHERE m.cnq = p_cnq AND m.zf = 0 AND m.qfje > 0
    GROUP BY m.cnq, c.yhlx, c.org_level1, c.org_level2, c.zdfq_name;

    RAISE NOTICE '欠费分析 % 汇总刷新完成', p_cnq;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sf_refresh_arrears(VARCHAR) IS '刷新sf_rpt_arrears汇总表';

-- ============================================================
-- 索引优化
-- ============================================================

-- 维度表索引
CREATE INDEX sf_idx_dim_customer_yhlx ON sf_dim_customer(yhlx);
CREATE INDEX sf_idx_dim_customer_org ON sf_dim_customer(org_level1, org_level2, zdfq_name);
CREATE INDEX sf_idx_dim_customer_hmd ON sf_dim_customer(kz_hmd);

CREATE INDEX sf_idx_dim_area_customer ON sf_dim_area(customer_id);
CREATE INDEX sf_idx_dim_area_mjlb ON sf_dim_area(mjlb);
CREATE INDEX sf_idx_dim_area_djlb ON sf_dim_area(djlb);

CREATE INDEX sf_idx_dim_org_level1 ON sf_dim_org(org_level1);
CREATE INDEX sf_idx_dim_org_level2 ON sf_dim_org(org_level2);
CREATE INDEX sf_idx_dim_org_level3 ON sf_dim_org(org_level3);

CREATE INDEX sf_idx_dim_time_year ON sf_dim_time(year);
CREATE INDEX sf_idx_dim_time_cnq ON sf_dim_time(cnq);

CREATE INDEX sf_idx_dim_fee_fylb ON sf_dim_fee(fylb);
CREATE INDEX sf_idx_dim_fee_jsfs ON sf_dim_fee(jsfs);

CREATE INDEX sf_idx_dim_payment_method_sffs ON sf_dim_payment_method(sffs);
CREATE INDEX sf_idx_dim_payment_method_is_online ON sf_dim_payment_method(is_online);

-- 事实表索引
CREATE INDEX sf_idx_rpt_charge_mj_id ON sf_rpt_charge(mj_id);
CREATE INDEX sf_idx_rpt_charge_fylb ON sf_rpt_charge(fylb);
CREATE INDEX sf_idx_rpt_charge_jsfs ON sf_rpt_charge(jsfs);

CREATE INDEX sf_idx_rpt_payment_mjjs_id ON sf_rpt_payment(mjjs_id);
CREATE INDEX sf_idx_rpt_payment_fplb ON sf_rpt_payment(fplb);

-- 汇总表索引
CREATE INDEX sf_idx_rpt_cnq_charge_fylb ON sf_rpt_cnq_charge(fylb);
CREATE INDEX sf_idx_rpt_cnq_charge_yhlx ON sf_rpt_cnq_charge(yhlx);

CREATE INDEX sf_idx_rpt_month_charge_cnq ON sf_rpt_month_charge(cnq);
CREATE INDEX sf_idx_rpt_month_charge_zfqd ON sf_rpt_month_charge(zfqd);

CREATE INDEX sf_idx_rpt_daily_charge_cnq ON sf_rpt_daily_charge(cnq);
CREATE INDEX sf_idx_rpt_daily_charge_stat_month ON sf_rpt_daily_charge(stat_month);

CREATE INDEX sf_idx_rpt_arrears_yhlx ON sf_rpt_arrears(yhlx);
CREATE INDEX sf_idx_rpt_arrears_org ON sf_rpt_arrears(org_level1, org_level2, org_level3);

-- ============================================================
-- 统计信息更新
-- ============================================================

ANALYZE sf_dim_customer;
ANALYZE sf_dim_area;
ANALYZE sf_dim_org;
ANALYZE sf_dim_time;
ANALYZE sf_dim_fee;
ANALYZE sf_dim_payment_method;
ANALYZE sf_rpt_charge;
ANALYZE sf_rpt_payment;
ANALYZE sf_rpt_cnq_charge;
ANALYZE sf_rpt_month_charge;
ANALYZE sf_rpt_daily_charge;
ANALYZE sf_rpt_arrears;

-- ============================================================
-- 权限设置（根据实际需求调整）
-- ============================================================

-- GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;
-- GRANT INSERT, UPDATE, DELETE ON sf_rpt_charge TO etl_user;
-- GRANT INSERT, UPDATE, DELETE ON sf_rpt_payment TO etl_user;
-- GRANT INSERT, UPDATE, DELETE ON sf_rpt_cnq_charge TO etl_user;

-- ============================================================
-- 文档说明
-- ============================================================

-- 表名前缀说明:
--   sf_dim_   - 维度表 (Dimension)
--   sf_fact_  - 事实表 (Fact)
--   sf_rpt_   - 报表/汇总表 (Report)

-- 数据来源对应:
--   customer        -> sf_dim_customer
--   area/sf_mj_t    -> sf_dim_area
--   sys_address     -> sf_dim_org
--   sf_mjjs_t       -> sf_rpt_charge
--   sf_mjsf_t       -> sf_rpt_payment
--   sf_mjtg_t       -> sf_fact_stop_restart
--   sf_gmgh_t       -> sf_fact_name_transfer
--   sf_mjbg_t       -> sf_fact_area_change
--   jc_plan_detail  -> sf_fact_inspection

-- 函数命名规范:
--   sf_sync_*_from_mysql  - 数据同步函数
--   sf_refresh_*         - 汇总刷新函数
