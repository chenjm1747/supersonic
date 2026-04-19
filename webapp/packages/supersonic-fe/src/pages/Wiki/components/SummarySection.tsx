import React, { useState, useEffect } from 'react';
import {
  List,
  Card,
  Button,
  Space,
  Tag,
  message,
  Drawer,
  Timeline,
  Spin,
  Modal,
  Empty,
  Divider,
} from 'antd';
import {
  ReloadOutlined,
  HistoryOutlined,
  EditOutlined,
  FileTextOutlined,
} from '@ant-design/icons';
import {
  TopicSummary,
  getSummaries,
  getSummary,
  getSummaryHistory,
  refreshSummary,
  refreshAllSummaries,
} from '@/services/wiki';

const SummarySection: React.FC = () => {
  const [summaries, setSummaries] = useState<TopicSummary[]>([]);
  const [loading, setLoading] = useState(false);
  const [refreshing, setRefreshing] = useState(false);
  const [detailVisible, setDetailVisible] = useState(false);
  const [historyVisible, setHistoryVisible] = useState(false);
  const [selectedSummary, setSelectedSummary] = useState<TopicSummary | null>(null);
  const [summaryHistory, setSummaryHistory] = useState<TopicSummary[]>([]);
  const [historyLoading, setHistoryLoading] = useState(false);

  useEffect(() => {
    fetchSummaries();
  }, []);

  const fetchSummaries = async () => {
    setLoading(true);
    try {
      const resp = await getSummaries();
      if (resp.success && resp.data) {
        setSummaries(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch summaries:', error);
      message.error('获取摘要列表失败');
    } finally {
      setLoading(false);
    }
  };

  const handleViewDetail = async (summary: TopicSummary) => {
    setSelectedSummary(summary);
    setDetailVisible(true);
  };

  const handleViewHistory = async (summary: TopicSummary) => {
    setSelectedSummary(summary);
    setHistoryVisible(true);
    setHistoryLoading(true);

    try {
      const resp = await getSummaryHistory(summary.topicId);
      if (resp.success && resp.data) {
        setSummaryHistory(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch summary history:', error);
      message.error('获取摘要历史失败');
    } finally {
      setHistoryLoading(false);
    }
  };

  const handleRefreshSingle = async (topicId: string) => {
    try {
      const resp = await refreshSummary(topicId);
      if (resp.success) {
        message.success('摘要已刷新');
        fetchSummaries();
      } else {
        message.error(resp.message || '刷新失败');
      }
    } catch (error) {
      message.error('刷新失败');
    }
  };

  const handleRefreshAll = async () => {
    setRefreshing(true);
    try {
      const resp = await refreshAllSummaries();
      if (resp.success) {
        message.success(`已刷新 ${resp.data?.length || 0} 个摘要`);
        fetchSummaries();
      } else {
        message.error(resp.message || '刷新失败');
      }
    } catch (error) {
      message.error('刷新失败');
    } finally {
      setRefreshing(false);
    }
  };

  return (
    <div>
      <div style={{ marginBottom: 16 }}>
        <Space>
          <Button
            type="primary"
            icon={<ReloadOutlined />}
            onClick={handleRefreshAll}
            loading={refreshing}
          >
            刷新全部摘要
          </Button>
          <Button icon={<ReloadOutlined />} onClick={fetchSummaries} loading={loading}>
            刷新列表
          </Button>
        </Space>
      </div>

      {summaries.length === 0 && !loading ? (
        <Empty
          description="暂无主题摘要"
          image={Empty.PRESENTED_IMAGE_SIMPLE}
        >
          <Button type="primary" onClick={handleRefreshAll}>
            立即生成摘要
          </Button>
        </Empty>
      ) : (
        <List
          grid={{ gutter: 16, xs: 1, sm: 2, md: 2, lg: 3, xl: 3, xxl: 4 }}
          dataSource={summaries}
          loading={loading}
          renderItem={(summary) => (
            <List.Item>
              <Card
                hoverable
                title={
                  <Space>
                    <FileTextOutlined />
                    <span>{summary.topicName || summary.topicId}</span>
                  </Space>
                }
                actions={[
                  <Button
                    key="detail"
                    type="text"
                    icon={<EditOutlined />}
                    onClick={() => handleViewDetail(summary)}
                  >
                    查看
                  </Button>,
                  <Button
                    key="refresh"
                    type="text"
                    icon={<ReloadOutlined />}
                    onClick={() => handleRefreshSingle(summary.topicId)}
                  >
                    刷新
                  </Button>,
                  <Button
                    key="history"
                    type="text"
                    icon={<HistoryOutlined />}
                    onClick={() => handleViewHistory(summary)}
                  >
                    历史
                  </Button>,
                ]}
              >
                <p style={{ height: 60, overflow: 'hidden', textOverflow: 'ellipsis' }}>
                  {summary.summary?.substring(0, 100) || '暂无摘要内容'}...
                </p>
                <div style={{ marginTop: 8 }}>
                  <Space wrap>
                    <Tag color="blue">版本 {summary.summaryVersion || 1}</Tag>
                    {summary.memberEntities && (
                      <Tag>{summary.memberEntities.length} 个实体</Tag>
                    )}
                    {summary.status === 'ACTIVE' && <Tag color="green">活跃</Tag>}
                  </Space>
                </div>
                {summary.generatedAt && (
                  <div style={{ marginTop: 8, fontSize: 12, color: '#666' }}>
                    生成时间: {new Date(summary.generatedAt).toLocaleString()}
                  </div>
                )}
              </Card>
            </List.Item>
          )}
        />
      )}

      <Drawer
        title={`摘要详情: ${selectedSummary?.topicName || selectedSummary?.topicId}`}
        placement="right"
        width={700}
        open={detailVisible}
        onClose={() => setDetailVisible(false)}
      >
        {selectedSummary && (
          <div>
            <div style={{ marginBottom: 16 }}>
              <Space wrap>
                <Tag color="blue">版本 {selectedSummary.summaryVersion || 1}</Tag>
                <Tag>{selectedSummary.llmModel || '自动生成'}</Tag>
                {selectedSummary.memberEntities && (
                  <Tag>{selectedSummary.memberEntities.length} 个实体</Tag>
                )}
              </Space>
            </div>

            {selectedSummary.generatedAt && (
              <div style={{ marginBottom: 16, color: '#666' }}>
                生成时间: {new Date(selectedSummary.generatedAt).toLocaleString()}
              </div>
            )}

            {selectedSummary.memberEntities && selectedSummary.memberEntities.length > 0 && (
              <div style={{ marginBottom: 16 }}>
                <h4>包含的实体</h4>
                <Space wrap>
                  {selectedSummary.memberEntities.map((entity) => (
                    <Tag key={entity}>{entity}</Tag>
                  ))}
                </Space>
              </div>
            )}

            {selectedSummary.relationships && selectedSummary.relationships.length > 0 && (
              <div style={{ marginBottom: 16 }}>
                <h4>关键关系</h4>
                <ul>
                  {selectedSummary.relationships.map((rel, index) => (
                    <li key={index}>{rel}</li>
                  ))}
                </ul>
              </div>
            )}

            <Divider />

            <h4>摘要内容</h4>
            <div
              style={{
                whiteSpace: 'pre-wrap',
                backgroundColor: '#f5f5f5',
                padding: 16,
                borderRadius: 4,
                maxHeight: 400,
                overflow: 'auto',
              }}
            >
              {selectedSummary.summary}
            </div>

            <div style={{ marginTop: 16 }}>
              <Button
                type="primary"
                icon={<ReloadOutlined />}
                onClick={() => {
                  handleRefreshSingle(selectedSummary.topicId);
                  setDetailVisible(false);
                }}
              >
                刷新此摘要
              </Button>
            </div>
          </div>
        )}
      </Drawer>

      <Modal
        title="摘要历史版本"
        open={historyVisible}
        onCancel={() => setHistoryVisible(false)}
        footer={null}
        width={600}
      >
        {historyLoading ? (
          <div style={{ textAlign: 'center', padding: 32 }}>
            <Spin />
          </div>
        ) : (
          <Timeline
            items={summaryHistory.map((item) => ({
              color: item.summaryVersion === summaryHistory[0]?.summaryVersion ? 'blue' : 'gray',
              children: (
                <div>
                  <Space>
                    <Tag color="blue">版本 {item.summaryVersion}</Tag>
                    {item.generatedAt && (
                      <span style={{ color: '#666', fontSize: 12 }}>
                        {new Date(item.generatedAt).toLocaleString()}
                      </span>
                    )}
                  </Space>
                  <p style={{ marginTop: 8, marginBottom: 0 }}>
                    {item.summary?.substring(0, 100)}...
                  </p>
                </div>
              ),
            }))}
          />
        )}
      </Modal>
    </div>
  );
};

export default SummarySection;
