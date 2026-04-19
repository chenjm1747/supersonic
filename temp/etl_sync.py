"""
供热收费系统ETL数据同步脚本
Python版本 - 适用于跨平台部署

依赖安装:
pip install psycopg2-binary mysql-connector-python pandas schedule

作者: SuperSonic数据团队
创建日期: 2026-04-13
"""

import psycopg2
import mysql.connector
import pandas as pd
from datetime import datetime, timedelta
import schedule
import time
import logging
import os
import json

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('etl_sync.log', encoding='utf-8'),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)


class ETLSync:
    """ETL数据同步类"""
    
    def __init__(self, config_file='etl_config.json'):
        """初始化ETL同步器"""
        self.config = self._load_config(config_file)
        self.mysql_conn = None
        self.pg_conn = None
        self.last_sync_time = {}
        
    def _load_config(self, config_file):
        """加载配置文件"""
        if os.path.exists(config_file):
            with open(config_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        else:
            # 默认配置
            return {
                'mysql': {
                    'host': '192.168.1.7',
                    'port': 3306,
                    'database': 'charge_zbhx',
                    'user': 'root',
                    'password': ''
                },
                'postgresql': {
                    'host': '192.168.1.7',
                    'port': 54321,
                    'database': 'postgres',
                    'schema': 'heating_analytics',
                    'user': 'postgres',
                    'password': 'Huilian1234'
                }
            }
    
    def connect_mysql(self):
        """连接MySQL数据库"""
        try:
            self.mysql_conn = mysql.connector.connect(
                host=self.config['mysql']['host'],
                port=self.config['mysql']['port'],
                database=self.config['mysql']['database'],
                user=self.config['mysql']['user'],
                password=self.config['mysql']['password']
            )
            logger.info("MySQL连接成功")
            return True
        except Exception as e:
            logger.error(f"MySQL连接失败: {e}")
            return False
    
    def connect_postgresql(self):
        """连接PostgreSQL数据库"""
        try:
            self.pg_conn = psycopg2.connect(
                host=self.config['postgresql']['host'],
                port=self.config['postgresql']['port'],
                database=self.config['postgresql']['database'],
                user=self.config['postgresql']['user'],
                password=self.config['postgresql']['password'],
                options=f"-c search_path={self.config['postgresql']['schema']}"
            )
            logger.info("PostgreSQL连接成功")
            return True
        except Exception as e:
            logger.error(f"PostgreSQL连接失败: {e}")
            return False
    
    def close_connections(self):
        """关闭数据库连接"""
        if self.mysql_conn and self.mysql_conn.is_connected():
            self.mysql_conn.close()
            logger.info("MySQL连接已关闭")
        if self.pg_conn:
            self.pg_conn.close()
            logger.info("PostgreSQL连接已关闭")
    
    def sync_customer(self, full_sync=False):
        """同步用户数据"""
        table_name = 'sf_dim_customer'
        start_time = datetime.now()
        records_count = 0
        
        try:
            logger.info(f"开始同步{table_name}, 模式: {'全量' if full_sync else '增量'}")
            
            # 如果是全量同步，先清空目标表
            if full_sync:
                with self.pg_conn.cursor() as cur:
                    cur.execute(f"TRUNCATE {table_name} CASCADE")
                self.pg_conn.commit()
            
            # 从MySQL读取数据
            query = """
                SELECT 
                    id as customer_id,
                    code as customer_code,
                    name as customer_name,
                    id_number,
                    tel_no,
                    mob_no,
                    yhlx,
                    rwrq,
                    rwht_bh,
                    kzfs,
                    COALESCE(kz_hmd, 0) as kz_hmd,
                    COALESCE(kz_sf, 1) as kz_sf,
                    COALESCE(kz_yhsf, 1) as kz_yhsf,
                    COALESCE(kz_jcsh, 0) as kz_jcsh,
                    rlz_id,
                    zdfq_id,
                    zdfq_name,
                    hrq_zt,
                    xzcnq,
                    COALESCE(one, '') as org_level1,
                    COALESCE(two, '') as org_level2,
                    COALESCE(three, '') as org_level3,
                    COALESCE(zf, 0) as zf,
                    COALESCE(created_time, NOW()) as create_time,
                    COALESCE(updated_time, NOW()) as update_time
                FROM customer
                WHERE zf = 0
            """
            
            # 如果是增量同步，添加时间条件
            if not full_sync and 'customer' in self.last_sync_time:
                last_time = self.last_sync_time['customer']
                query += f" AND updated_time > '{last_time}'"
            
            df = pd.read_sql(query, self.mysql_conn)
            
            if len(df) > 0:
                # 使用UPSERT方式插入
                columns = df.columns.tolist()
                placeholders = ','.join(['%s'] * len(columns))
                update_set = ','.join([f"{col} = EXCLUDED.{col}" for col in columns if col != 'customer_id'])
                
                insert_sql = f"""
                    INSERT INTO {table_name} ({','.join(columns)})
                    VALUES ({placeholders})
                    ON CONFLICT (customer_id) DO UPDATE SET {update_set}
                """
                
                with self.pg_conn.cursor() as cur:
                    cur.executemany(insert_sql, df.values.tolist())
                self.pg_conn.commit()
                
                records_count = len(df)
            
            duration = (datetime.now() - start_time).total_seconds() * 1000
            logger.info(f"{table_name}同步完成, 记录数: {records_count}, 耗时: {duration}ms")
            
            # 更新同步时间
            self.last_sync_time['customer'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            
            return {'status': 'SUCCESS', 'records': records_count, 'duration': duration}
            
        except Exception as e:
            logger.error(f"{table_name}同步失败: {e}")
            self.pg_conn.rollback()
            return {'status': f'FAILED: {e}', 'records': 0, 'duration': 0}
    
    def sync_org(self):
        """同步组织数据"""
        table_name = 'sf_dim_org'
        start_time = datetime.now()
        records_count = 0
        
        try:
            logger.info(f"开始同步{table_name}")
            
            query = """
                SELECT 
                    id as org_id,
                    parent_id,
                    COALESCE(one, '') as org_level1,
                    COALESCE(two, '') as org_level2,
                    COALESCE(three, '') as org_level3,
                    CASE 
                        WHEN type = 0 THEN '分公司'
                        WHEN type = 1 THEN '热力站'
                        WHEN type = 2 THEN '小区'
                        ELSE '其他'
                    END as org_type,
                    address_prefix,
                    unit,
                    floor,
                    room,
                    address,
                    rlz_id,
                    name as rlz_name,
                    COALESCE(state, 1) as state,
                    jzmj,
                    COALESCE(zf, 0) as zf
                FROM sys_address
                WHERE zf = 0
            """
            
            df = pd.read_sql(query, self.mysql_conn)
            
            if len(df) > 0:
                columns = df.columns.tolist()
                placeholders = ','.join(['%s'] * len(columns))
                update_set = ','.join([f"{col} = EXCLUDED.{col}" for col in columns if col != 'org_id'])
                
                insert_sql = f"""
                    INSERT INTO {table_name} ({','.join(columns)})
                    VALUES ({placeholders})
                    ON CONFLICT (org_id) DO UPDATE SET {update_set}
                """
                
                with self.pg_conn.cursor() as cur:
                    cur.executemany(insert_sql, df.values.tolist())
                self.pg_conn.commit()
                
                records_count = len(df)
            
            duration = (datetime.now() - start_time).total_seconds() * 1000
            logger.info(f"{table_name}同步完成, 记录数: {records_count}, 耗时: {duration}ms")
            
            return {'status': 'SUCCESS', 'records': records_count, 'duration': duration}
            
        except Exception as e:
            logger.error(f"{table_name}同步失败: {e}")
            self.pg_conn.rollback()
            return {'status': f'FAILED: {e}', 'records': 0, 'duration': 0}
    
    def sync_charge(self, cnq=None):
        """同步收费结算数据"""
        table_name = 'sf_rpt_charge'
        start_time = datetime.now()
        records_count = 0
        
        try:
            logger.info(f"开始同步{table_name}, 采暖期: {cnq or '全部'}")
            
            query = f"""
                SELECT 
                    m.id,
                    m.cnq,
                    m.customer_id,
                    m.mj_id,
                    COALESCE(m.fylb, '采暖费') as fylb,
                    COALESCE(m.sfmj, 0) as sfmj,
                    COALESCE(m.sl, 0) as sl,
                    COALESCE(m.dj, 0) as dj,
                    COALESCE(m.ysje, 0) as ysje,
                    COALESCE(m.sfje, 0) as sfje,
                    COALESCE(m.qfje, 0) as qfje,
                    COALESCE(m.zkje, 0) as zkje,
                    COALESCE(m.wyje, 0) as wyje,
                    COALESCE(m.hjje, 0) as hjje,
                    COALESCE(m.tgce, 0) as tgce,
                    COALESCE(m.jcys, 0) as jcys,
                    COALESCE(m.jsfs, '按面积') as jsfs,
                    COALESCE(m.ybbm, '') as ybbm,
                    COALESCE(m.cbzt, 0) as cbzt,
                    COALESCE(m.jldj, 0) as jldj,
                    COALESCE(m.jlbs, 0) as jlbs,
                    COALESCE(m.djlb, '') as djlb,
                    COALESCE(m.jldjlb, '') as jldjlb,
                    COALESCE(m.gnsc, 0) as gnsc,
                    COALESCE(m.hrq_zt, '') as hrq_zt,
                    COALESCE(m.hrq_sl, 0) as hrq_sl,
                    COALESCE(m.gnzt, '正常') as gnzt,
                    COALESCE(m.event, '') as event,
                    COALESCE(m.business_id, 0) as business_id,
                    COALESCE(m.czy, '') as czy,
                    COALESCE(m.zf, 0) as zf,
                    COALESCE(m.created_time, NOW()) as create_time,
                    COALESCE(m.updated_time, NOW()) as update_time
                FROM sf_mjjs_t m
                WHERE m.zf = 0
            """
            
            if cnq:
                query += f" AND m.cnq = '{cnq}'"
            
            df = pd.read_sql(query, self.mysql_conn)
            
            if len(df) > 0:
                columns = df.columns.tolist()
                placeholders = ','.join(['%s'] * len(columns))
                update_set = ','.join([f"{col} = EXCLUDED.{col}" for col in columns if col != 'id'])
                
                insert_sql = f"""
                    INSERT INTO {table_name} ({','.join(columns)})
                    VALUES ({placeholders})
                    ON CONFLICT (id) DO UPDATE SET {update_set}
                """
                
                with self.pg_conn.cursor() as cur:
                    cur.executemany(insert_sql, df.values.tolist())
                self.pg_conn.commit()
                
                records_count = len(df)
            
            duration = (datetime.now() - start_time).total_seconds() * 1000
            logger.info(f"{table_name}同步完成, 记录数: {records_count}, 耗时: {duration}ms")
            
            return {'status': 'SUCCESS', 'records': records_count, 'duration': duration}
            
        except Exception as e:
            logger.error(f"{table_name}同步失败: {e}")
            self.pg_conn.rollback()
            return {'status': f'FAILED: {e}', 'records': 0, 'duration': 0}
    
    def sync_payment(self):
        """同步收费明细数据（增量）"""
        table_name = 'sf_rpt_payment'
        start_time = datetime.now()
        records_count = 0
        
        try:
            logger.info(f"开始同步{table_name} (增量)")
            
            # 获取当前最大ID
            with self.pg_conn.cursor() as cur:
                cur.execute(f"SELECT COALESCE(MAX(id), 0) FROM {table_name}")
                max_id = cur.fetchone()[0]
            
            query = f"""
                SELECT 
                    p.id,
                    p.cnq,
                    p.customer_id,
                    p.mjjs_id,
                    COALESCE(p.fylb, '采暖费') as fylb,
                    COALESCE(p.sfrq, NOW()) as sfrq,
                    COALESCE(p.sfje, 0) as sfje,
                    COALESCE(p.wyje, 0) as wyje,
                    COALESCE(p.zkje, 0) as zkje,
                    COALESCE(p.sl, 0) as sl,
                    COALESCE(p.dj, 0) as dj,
                    COALESCE(p.djlb, '') as djlb,
                    COALESCE(p.gnsc, 0) as gnsc,
                    COALESCE(p.sffs, '现金') as sffs,
                    COALESCE(p.fplb, '') as fplb,
                    COALESCE(p.fpdm, '') as fpdm,
                    COALESCE(p.fphm, '') as fphm,
                    COALESCE(p.zfqd, '公司自收') as zfqd,
                    COALESCE(p.yywd, '') as yywd,
                    COALESCE(p.lsh, '') as lsh,
                    COALESCE(p.dzzt, 0) as dzzt,
                    COALESCE(p.czy, '') as czy,
                    COALESCE(p.czbh, 0) as czbh,
                    COALESCE(p.term_sn, '') as term_sn,
                    COALESCE(p.bill_id, '') as bill_id,
                    COALESCE(p.zf, 0) as zf,
                    COALESCE(p.created_time, NOW()) as create_time,
                    COALESCE(p.updated_time, NOW()) as update_time
                FROM sf_mjsf_t p
                WHERE p.zf = 0 AND p.id > {max_id}
                ORDER BY p.id
                LIMIT 10000
            """
            
            df = pd.read_sql(query, self.mysql_conn)
            
            if len(df) > 0:
                columns = df.columns.tolist()
                placeholders = ','.join(['%s'] * len(columns))
                
                insert_sql = f"""
                    INSERT INTO {table_name} ({','.join(columns)})
                    VALUES ({placeholders})
                    ON CONFLICT (id) DO NOTHING
                """
                
                with self.pg_conn.cursor() as cur:
                    cur.executemany(insert_sql, df.values.tolist())
                self.pg_conn.commit()
                
                records_count = len(df)
            
            duration = (datetime.now() - start_time).total_seconds() * 1000
            logger.info(f"{table_name}同步完成, 记录数: {records_count}, 耗时: {duration}ms")
            
            return {'status': 'SUCCESS', 'records': records_count, 'duration': duration}
            
        except Exception as e:
            logger.error(f"{table_name}同步失败: {e}")
            self.pg_conn.rollback()
            return {'status': f'FAILED: {e}', 'records': 0, 'duration': 0}
    
    def refresh_summary(self, cnq='2025-2026'):
        """刷新汇总表"""
        try:
            logger.info(f"开始刷新汇总表, 采暖期: {cnq}")
            
            with self.pg_conn.cursor() as cur:
                # 刷新采暖期汇总
                cur.execute(f"SELECT sf_refresh_cnq_charge('{cnq}')")
                
                # 刷新月度汇总
                current_month = datetime.now().strftime('%Y-%m')
                cur.execute(f"SELECT sf_refresh_month_charge('{current_month}')")
                
                # 刷新每日汇总
                current_date = datetime.now().strftime('%Y-%m-%d')
                cur.execute(f"SELECT sf_refresh_daily_charge('{current_date}')")
                
                # 刷新欠费汇总
                cur.execute(f"SELECT sf_refresh_arrears('{cnq}')")
            
            self.pg_conn.commit()
            logger.info("汇总表刷新完成")
            
            return {'status': 'SUCCESS', 'records': 0, 'duration': 0}
            
        except Exception as e:
            logger.error(f"汇总表刷新失败: {e}")
            self.pg_conn.rollback()
            return {'status': f'FAILED: {e}', 'records': 0, 'duration': 0}
    
    def full_sync(self):
        """全量同步所有数据"""
        logger.info("=" * 50)
        logger.info("开始执行全量同步")
        logger.info("=" * 50)
        
        results = []
        
        # 连接数据库
        if not self.connect_mysql() or not self.connect_postgresql():
            return results
        
        try:
            # 步骤1: 同步用户数据
            results.append(('同步用户数据', self.sync_customer(full_sync=False)))
            
            # 步骤2: 同步组织数据
            results.append(('同步组织数据', self.sync_org()))
            
            # 步骤3: 同步收费结算
            results.append(('同步收费结算', self.sync_charge()))
            
            # 步骤4: 同步收费明细
            results.append(('同步收费明细', self.sync_payment()))
            
            # 步骤5: 刷新汇总表
            results.append(('刷新汇总表', self.refresh_summary()))
            
            # 记录同步日志
            self._log_sync('FULL_SYNC', results)
            
        finally:
            self.close_connections()
        
        logger.info("=" * 50)
        logger.info("全量同步完成")
        logger.info("=" * 50)
        
        return results
    
    def incremental_sync(self):
        """增量同步"""
        logger.info("开始执行增量同步")
        
        results = []
        
        if not self.connect_mysql() or not self.connect_postgresql():
            return results
        
        try:
            results.append(('同步收费明细', self.sync_payment()))
            self._log_sync('INCREMENTAL_SYNC', results)
            
        finally:
            self.close_connections()
        
        return results
    
    def _log_sync(self, sync_type, results):
        """记录同步日志"""
        try:
            with self.pg_conn.cursor() as cur:
                for step_name, result in results:
                    cur.execute("""
                        INSERT INTO sf_sync_log 
                        (sync_type, table_name, sync_status, records_processed, start_time, end_time, duration_ms)
                        VALUES (%s, %s, %s, %s, %s, %s, %s)
                    """, (
                        sync_type,
                        step_name,
                        result['status'],
                        result['records'],
                        datetime.now(),
                        datetime.now(),
                        result['duration']
                    ))
            self.pg_conn.commit()
        except Exception as e:
            logger.error(f"记录同步日志失败: {e}")


def main():
    """主函数"""
    etl = ETLSync()
    
    # 全量同步
    print("执行全量同步...")
    results = etl.full_sync()
    
    for step_name, result in results:
        print(f"  {step_name}: {result['status']}, 记录数: {result['records']}, 耗时: {result['duration']}ms")
    
    # 定时任务配置
    # schedule.every().day.at("02:00").do(etl.full_sync)  # 每天凌晨2点全量同步
    # schedule.every().hour.do(etl.incremental_sync)     # 每小时增量同步
    
    # while True:
    #     schedule.run_pending()
    #     time.sleep(60)


if __name__ == '__main__':
    main()
