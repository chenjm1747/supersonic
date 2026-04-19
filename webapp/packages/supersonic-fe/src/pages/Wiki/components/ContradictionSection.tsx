import React, { useState, useEffect } from 'react';
import {
  Table,
  Button,
  Space,
  Tag,
  Modal,
  Form,
  Select,
  Input,
  message,
  Drawer,
  Descriptions,
  Alert,
  Divider,
} from 'antd';
import {
  ReloadOutlined,
  EyeOutlined,
  CheckCircleOutlined,
  ExclamationCircleOutlined,
} from '@ant-design/icons';
import {
  Contradiction,
  getContradictions,
  getPendingContradictions,
  resolveContradiction,
} from '@/services/wiki';

const { Option } = Select;
const { TextArea } = Input;

const conflictTypes = [
  { value: 'SCHEMA_CONFLICT', label: 'Schema 冲突', color: 'red' },
  { value: 'SEMANTIC_CONFLICT', label: '语义冲突', color: 'orange' },
  { value: 'RELATIONSHIP_CONFLICT', label: '关系冲突', color: 'purple' },
  { value: 'RULE_CONFLICT', label: '规则冲突', color: 'blue' },
];

const resolutions = [
  { value: 'ACCEPT_NEW', label: '接受新知识', color: 'green' },
  { value: 'KEEP_OLD', label: '保留旧知识', color: 'default' },
  { value: 'MERGE', label: '合并两者', color: 'cyan' },
  { value: 'DISMISS', label: '忽略', color: 'gray' },
];

const ContradictionSection: React.FC = () => {
  const [contradictions, setContradictions] = useState<Contradiction[]>([]);
  const [loading, setLoading] = useState(false);
  const [filterStatus, setFilterStatus] = useState<string>('PENDING');
  const [detailVisible, setDetailVisible] = useState(false);
  const [resolveVisible, setResolveVisible] = useState(false);
  const [selectedContradiction, setSelectedContradiction] = useState<Contradiction | null>(null);
  const [form] = Form.useForm();

  useEffect(() => {
    fetchContradictions();
  }, [filterStatus]);

  const fetchContradictions = async () => {
    setLoading(true);
    try {
      let resp;
      if (filterStatus === 'ALL') {
        resp = await getContradictions();
      } else {
        resp = await getContradictions(undefined, filterStatus);
      }
      if (resp.success && resp.data) {
        setContradictions(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch contradictions:', error);
      message.error('获取矛盾列表失败');
    } finally {
      setLoading(false);
    }
  };

  const handleViewDetail = (record: Contradiction) => {
    setSelectedContradiction(record);
    setDetailVisible(true);
  };

  const handleResolve = (record: Contradiction) => {
    setSelectedContradiction(record);
    form.resetFields();
    setResolveVisible(true);
  };

  const handleResolveSubmit = async () => {
    try {
      const values = await form.validateFields();
      if (!selectedContradiction) return;

      const resp = await resolveContradiction(selectedContradiction.contradictionId, {
        resolution: values.resolution,
        resolvedBy: values.resolvedBy,
        resolutionNotes: values.resolutionNotes,
      });

      if (resp.success) {
        message.success('矛盾已解决');
        setResolveVisible(false);
        fetchContradictions();
      } else {
        message.error(resp.message || '解决矛盾失败');
      }
    } catch (error) {
      message.error('解决矛盾失败');
    }
  };

  const getConflictTypeColor = (type: string) => {
    const found = conflictTypes.find((t) => t.value === type);
    return found?.color || 'default';
  };

  const getConflictTypeLabel = (type: string) => {
    const found = conflictTypes.find((t) => t.value === type);
    return found?.label || type;
  };

  const getResolutionColor = (resolution: string) => {
    const found = resolutions.find((r) => r.value === resolution);
    return found?.color || 'default';
  };

  const getResolutionLabel = (resolution: string) => {
    const found = resolutions.find((r) => r.value === resolution);
    return found?.label || resolution;
  };

  const columns = [
    {
      title: '矛盾ID',
      dataIndex: 'contradictionId',
      key: 'contradictionId',
      width: 200,
      ellipsis: true,
    },
    {
      title: '实体ID',
      dataIndex: 'entityId',
      key: 'entityId',
      width: 180,
      ellipsis: true,
    },
    {
      title: '冲突类型',
      dataIndex: 'conflictType',
      key: 'conflictType',
      width: 120,
      render: (type: string) => (
        <Tag color={getConflictTypeColor(type)}>{getConflictTypeLabel(type)}</Tag>
      ),
    },
    {
      title: '影响',
      dataIndex: 'impact',
      key: 'impact',
      ellipsis: true,
    },
    {
      title: '状态',
      dataIndex: 'resolution',
      key: 'resolution',
      width: 100,
      render: (resolution: string) => {
        if (resolution === 'PENDING') {
          return <Tag icon={<ExclamationCircleOutlined />} color="warning">待处理</Tag>;
        }
        return <Tag icon={<CheckCircleOutlined />} color={getResolutionColor(resolution)}>{getResolutionLabel(resolution)}</Tag>;
      },
    },
    {
      title: '检测时间',
      dataIndex: 'createdAt',
      key: 'createdAt',
      width: 160,
    },
    {
      title: '操作',
      key: 'action',
      width: 150,
      render: (_: any, record: Contradiction) => (
        <Space>
          <Button type="link" size="small" icon={<EyeOutlined />} onClick={() => handleViewDetail(record)}>
            详情
          </Button>
          {record.resolution === 'PENDING' && (
            <Button type="link" size="small" onClick={() => handleResolve(record)}>
              解决
            </Button>
          )}
        </Space>
      ),
    },
  ];

  return (
    <div>
      <div style={{ marginBottom: 16 }}>
        <Space>
          <Select value={filterStatus} onChange={setFilterStatus} style={{ width: 150 }}>
            <Option value="PENDING">待处理</Option>
            <Option value="ACCEPT_NEW">已接受新知识</Option>
            <Option value="KEEP_OLD">已保留旧知识</Option>
            <Option value="MERGE">已合并</Option>
            <Option value="DISMISS">已忽略</Option>
            <Option value="ALL">全部</Option>
          </Select>
          <Button icon={<ReloadOutlined />} onClick={fetchContradictions} loading={loading}>
            刷新
          </Button>
        </Space>
      </div>

      <Alert
        message="矛盾处理说明"
        description="当新的表结构分析与现有知识卡片存在冲突时，系统会自动创建矛盾记录。您需要审核这些矛盾并做出决策：接受新知识、保留旧知识、合并两者或忽略。"
        type="info"
        showIcon
        style={{ marginBottom: 16 }}
      />

      <Table
        columns={columns}
        dataSource={contradictions}
        rowKey="contradictionId"
        loading={loading}
        pagination={{ pageSize: 10 }}
      />

      <Drawer
        title="矛盾详情"
        placement="right"
        width={600}
        open={detailVisible}
        onClose={() => setDetailVisible(false)}
      >
        {selectedContradiction && (
          <div>
            <Descriptions column={1} bordered>
              <Descriptions.Item label="矛盾ID">{selectedContradiction.contradictionId}</Descriptions.Item>
              <Descriptions.Item label="实体ID">{selectedContradiction.entityId}</Descriptions.Item>
              <Descriptions.Item label="冲突类型">
                <Tag color={getConflictTypeColor(selectedContradiction.conflictType)}>
                  {getConflictTypeLabel(selectedContradiction.conflictType)}
                </Tag>
              </Descriptions.Item>
              <Descriptions.Item label="影响">{selectedContradiction.impact || '暂无'}</Descriptions.Item>
              <Descriptions.Item label="状态">
                <Tag color={getResolutionColor(selectedContradiction.resolution)}>
                  {getResolutionLabel(selectedContradiction.resolution)}
                </Tag>
              </Descriptions.Item>
              {selectedContradiction.resolvedBy && (
                <Descriptions.Item label="解决人">{selectedContradiction.resolvedBy}</Descriptions.Item>
              )}
              {selectedContradiction.resolvedAt && (
                <Descriptions.Item label="解决时间">{selectedContradiction.resolvedAt}</Descriptions.Item>
              )}
            </Descriptions>

            <Divider>旧知识</Divider>
            <Alert
              message="现有知识卡片内容"
              description={selectedContradiction.oldContent || '暂无内容'}
              type="warning"
            />

            <Divider>新证据</Divider>
            <Alert
              message="新发现的证据"
              description={selectedContradiction.newEvidence || '暂无内容'}
              type="info"
            />

            {selectedContradiction.resolutionNotes && (
              <>
                <Divider>解决备注</Divider>
                <p>{selectedContradiction.resolutionNotes}</p>
              </>
            )}

            {selectedContradiction.resolution === 'PENDING' && (
              <div style={{ marginTop: 16 }}>
                <Button type="primary" onClick={() => {
                  setDetailVisible(false);
                  handleResolve(selectedContradiction);
                }}>
                  解决此矛盾
                </Button>
              </div>
            )}
          </div>
        )}
      </Drawer>

      <Modal
        title="解决矛盾"
        open={resolveVisible}
        onOk={handleResolveSubmit}
        onCancel={() => setResolveVisible(false)}
        width={500}
      >
        <Alert
          message="请选择解决方式"
          description={
            <ul style={{ marginBottom: 0 }}>
              <li><strong>接受新知识</strong>：使用新发现的证据更新知识卡片</li>
              <li><strong>保留旧知识</strong>：忽略新证据，保持现有知识不变</li>
              <li><strong>合并两者</strong>：将新旧知识合并为统一的结论</li>
              <li><strong>忽略</strong>：此矛盾不成立，标记为已忽略</li>
            </ul>
          }
          type="info"
          showIcon
          style={{ marginBottom: 16 }}
        />

        <Form form={form} layout="vertical">
          <Form.Item
            name="resolution"
            label="解决方式"
            rules={[{ required: true, message: '请选择解决方式' }]}
          >
            <Select placeholder="请选择解决方式">
              {resolutions.map((r) => (
                <Option key={r.value} value={r.value}>{r.label}</Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item name="resolvedBy" label="解决人">
            <Input placeholder="请输入解决人姓名" />
          </Form.Item>

          <Form.Item name="resolutionNotes" label="备注">
            <TextArea rows={4} placeholder="请输入解决备注，说明解决理由" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default ContradictionSection;
