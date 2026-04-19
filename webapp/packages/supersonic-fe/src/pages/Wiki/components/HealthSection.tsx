import React, { useState, useEffect } from 'react';
import {
  Card,
  Row,
  Col,
  Statistic,
  Table,
  Button,
  Space,
  Tag,
  Modal,
  Descriptions,
  Alert,
  message,
  Timeline,
  Progress,
} from 'antd';
import {
  ReloadOutlined,
  SafetyCertificateOutlined,
  WarningOutlined,
  CheckCircleOutlined,
  ExclamationCircleOutlined,
  SyncOutlined,
} from '@ant-design/icons';
import {
  WikiHealthReport,
  HealthStats,
  getHealthReports,
  getHealthReportDetail,
  getHealthStats,
  triggerHealthCheck,
} from '@/services/wiki';

const reportTypeMap: Record<string, { label: string; color: string }> = {
  DAILY: { label: '每日检查', color: 'blue' },
  WEEKLY: { label: '每周检查', color: 'purple' },
  FULL: { label: '全面检查', color: 'cyan' },
};

const statusMap: Record<string, { label: string; color: string }> = {
  COMPLETED: { label: '已完成', color: 'green' },
  PENDING: { label: '待处理', color: 'orange' },
  FAILED: { label: '失败', color: 'red' },
};

const HealthSection: React.FC = () => {
  const [reports, setReports] = useState<WikiHealthReport[]>([]);
  const [stats, setStats] = useState<HealthStats | null>(null);
  const [loading, setLoading] = useState(false);
  const [statsLoading, setStatsLoading] = useState(false);
  const [detailVisible, setDetailVisible] = useState(false);
  const [selectedReport, setSelectedReport] = useState<WikiHealthReport | null>(null);
  const [triggering, setTriggering] = useState(false);

  useEffect(() => {
    fetchReports();
    fetchStats();
  }, []);

  const fetchReports = async () => {
    setLoading(true);
    try {
      const resp = await getHealthReports(10, 0);
      if (resp.success && resp.data) {
        setReports(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch health reports:', error);
      message.error('获取健康报告失败');
    } finally {
      setLoading(false);
    }
  };

  const fetchStats = async () => {
    setStatsLoading(true);
    try {
      const resp = await getHealthStats();
      if (resp.success && resp.data) {
        setStats(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch health stats:', error);
      message.error('获取健康统计失败');
    } finally {
      setStatsLoading(false);
    }
  };

  const handleViewDetail = async (report: WikiHealthReport) => {
    try {
      const resp = await getHealthReportDetail(report.reportId);
      if (resp.success && resp.data) {
        setSelectedReport(resp.data);
        setDetailVisible(true);
      }
    } catch (error) {
      message.error('获取报告详情失败');
    }
  };

  const handleTriggerCheck = async () => {
    setTriggering(true);
    try {
      const resp = await triggerHealthCheck('FULL');
      if (resp.success) {
        message.success('健康检查已触发');
        fetchReports();
        fetchStats();
      } else {
        message.error(resp.message || '触发失败');
      }
    } catch (error) {
      message.error('触发健康检查失败');
    } finally {
      setTriggering(false);
    }
  };

  const getHealthScore = (report: WikiHealthReport): number => {
    if (!report.metrics) return 100;
    const total = report.issuesFound || 0;
    const contradictions = report.contradictionsDetected || 0;
    const orphans = report.orphanEntities || 0;
    const outdated = report.outdatedCards || 0;
    const deductions = contradictions * 10 + orphans * 5 + outdated * 3 + total * 1;
    return Math.max(0, 100 - deductions);
  };

  const getHealthColor = (score: number): string => {
    if (score >= 90) return '#52c41a';
    if (score >= 70) return '#faad14';
    return '#f5222d';
  };

  const columns = [
    {
      title: '报告ID',
      dataIndex: 'reportId',
      key: 'reportId',
      width: 200,
      ellipsis: true,
    },
    {
      title: '报告类型',
      dataIndex: 'reportType',
      key: 'reportType',
      width: 100,
      render: (type: string) => (
        <Tag color={reportTypeMap[type]?.color || 'default'}>
          {reportTypeMap[type]?.label || type}
        </Tag>
      ),
    },
    {
      title: '健康评分',
      dataIndex: 'issuesFound',
      key: 'healthScore',
      width: 120,
      render: (_: any, record: WikiHealthReport) => {
        const score = getHealthScore(record);
        return (
          <Progress
            percent={score}
            size="small"
            strokeColor={getHealthColor(score)}
            format={() => `${score}`}
          />
        );
      },
    },
    {
      title: '发现问题',
      key: 'issues',
      width: 180,
      render: (_: any, record: WikiHealthReport) => (
        <Space direction="vertical" size={0}>
          {record.contradictionsDetected && record.contradictionsDetected > 0 && (
            <Tag color="orange" icon={<ExclamationCircleOutlined />}>
              矛盾 {record.contradictionsDetected}
            </Tag>
          )}
          {record.orphanEntities && record.orphanEntities > 0 && (
            <Tag color="red" icon={<WarningOutlined />}>
              孤儿实体 {record.orphanEntities}
            </Tag>
          )}
          {record.outdatedCards && record.outdatedCards > 0 && (
            <Tag color="purple">
              过时卡片 {record.outdatedCards}
            </Tag>
          )}
          {!record.contradictionsDetected && !record.orphanEntities && !record.outdatedCards && (
            <Tag color="green" icon={<CheckCircleOutlined />}>
              无问题
            </Tag>
          )}
        </Space>
      ),
    },
    {
      title: '状态',
      dataIndex: 'status',
      key: 'status',
      width: 100,
      render: (status: string) => (
        <Tag color={statusMap[status]?.color || 'default'}>
          {statusMap[status]?.label || status}
        </Tag>
      ),
    },
    {
      title: '生成时间',
      dataIndex: 'generatedAt',
      key: 'generatedAt',
      width: 160,
    },
    {
      title: '操作',
      key: 'action',
      width: 100,
      render: (_: any, record: WikiHealthReport) => (
        <Button type="link" size="small" onClick={() => handleViewDetail(record)}>
          详情
        </Button>
      ),
    },
  ];

  return (
    <div>
      <Row gutter={16} style={{ marginBottom: 16 }}>
        <Col span={6}>
          <Card loading={statsLoading}>
            <Statistic
              title="待处理报告"
              value={stats?.pendingReports || 0}
              prefix={<SafetyCertificateOutlined />}
              valueStyle={{ color: '#1890ff' }}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card loading={statsLoading}>
            <Statistic
              title="待处理矛盾"
              value={stats?.pendingContradictions || 0}
              prefix={<ExclamationCircleOutlined />}
              valueStyle={{ color: '#faad14' }}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card loading={statsLoading}>
            <Statistic
              title="孤儿实体"
              value={stats?.orphanEntities || 0}
              prefix={<WarningOutlined />}
              valueStyle={{ color: '#f5222d' }}
            />
          </Card>
        </Col>
        <Col span={6}>
          <Card>
            <Statistic
              title="最新健康评分"
              value={reports.length > 0 ? getHealthScore(reports[0]) : 100}
              suffix="/ 100"
              prefix={<SafetyCertificateOutlined />}
              valueStyle={{ color: getHealthColor(reports.length > 0 ? getHealthScore(reports[0]) : 100) }}
            />
          </Card>
        </Col>
      </Row>

      <div style={{ marginBottom: 16 }}>
        <Space>
          <Button
            type="primary"
            icon={<SyncOutlined />}
            onClick={handleTriggerCheck}
            loading={triggering}
          >
            触发健康检查
          </Button>
          <Button icon={<ReloadOutlined />} onClick={fetchReports} loading={loading}>
            刷新
          </Button>
        </Space>
      </div>

      <Alert
        message="健康检查说明"
        description="系统每天凌晨2点自动执行每日健康检查，每周日凌晨3点执行全面检查。您也可以手动触发健康检查来立即更新健康状态。"
        type="info"
        showIcon
        style={{ marginBottom: 16 }}
      />

      <Table
        columns={columns}
        dataSource={reports}
        rowKey="reportId"
        loading={loading}
        pagination={{ pageSize: 10 }}
      />

      <Modal
        title="健康报告详情"
        open={detailVisible}
        onCancel={() => setDetailVisible(false)}
        footer={[
          <Button key="close" onClick={() => setDetailVisible(false)}>
            关闭
          </Button>,
        ]}
        width={700}
      >
        {selectedReport && (
          <div>
            <Descriptions column={2} bordered style={{ marginBottom: 16 }}>
              <Descriptions.Item label="报告ID" span={2}>
                {selectedReport.reportId}
              </Descriptions.Item>
              <Descriptions.Item label="报告类型">
                <Tag color={reportTypeMap[selectedReport.reportType]?.color}>
                  {reportTypeMap[selectedReport.reportType]?.label}
                </Tag>
              </Descriptions.Item>
              <Descriptions.Item label="状态">
                <Tag color={statusMap[selectedReport.status]?.color}>
                  {statusMap[selectedReport.status]?.label}
                </Tag>
              </Descriptions.Item>
              <Descriptions.Item label="健康评分">
                <Progress
                  percent={getHealthScore(selectedReport)}
                  strokeColor={getHealthColor(getHealthScore(selectedReport))}
                />
              </Descriptions.Item>
              <Descriptions.Item label="发现问题数">
                {selectedReport.issuesFound || 0}
              </Descriptions.Item>
              <Descriptions.Item label="生成时间">
                {selectedReport.generatedAt}
              </Descriptions.Item>
            </Descriptions>

            {selectedReport.metrics && (
              <>
                <h4>详细指标</h4>
                <Row gutter={16}>
                  <Col span={6}>
                    <Statistic
                      title="矛盾检测"
                      value={selectedReport.contradictionsDetected || 0}
                      valueStyle={{ color: selectedReport.contradictionsDetected ? '#faad14' : '#52c41a' }}
                    />
                  </Col>
                  <Col span={6}>
                    <Statistic
                      title="孤儿实体"
                      value={selectedReport.orphanEntities || 0}
                      valueStyle={{ color: selectedReport.orphanEntities ? '#f5222d' : '#52c41a' }}
                    />
                  </Col>
                  <Col span={6}>
                    <Statistic
                      title="过时卡片"
                      value={selectedReport.outdatedCards || 0}
                      valueStyle={{ color: selectedReport.outdatedCards ? '#722ed1' : '#52c41a' }}
                    />
                  </Col>
                  <Col span={6}>
                    <Statistic
                      title="总问题数"
                      value={selectedReport.issuesFound || 0}
                    />
                  </Col>
                </Row>
              </>
            )}

            {selectedReport.recommendations && selectedReport.recommendations.length > 0 && (
              <>
                <h4>建议</h4>
                <Timeline
                  items={selectedReport.recommendations.map((rec, index) => ({
                    color: 'blue',
                    children: rec,
                  }))}
                />
              </>
            )}

            {selectedReport.summary && (
              <>
                <h4>摘要</h4>
                <Alert message={selectedReport.summary} type="info" />
              </>
            )}
          </div>
        )}
      </Modal>
    </div>
  );
};

export default HealthSection;
