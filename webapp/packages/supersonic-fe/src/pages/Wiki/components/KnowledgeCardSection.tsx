import React, { useState, useEffect } from 'react';
import {
  Card,
  List,
  Tag,
  Button,
  Space,
  Modal,
  Form,
  Input,
  Select,
  Slider,
  message,
  Popconfirm,
  Empty,
} from 'antd';
import { PlusOutlined, DeleteOutlined, EditOutlined, SaveOutlined } from '@ant-design/icons';
import {
  GraphNode,
  WikiKnowledgeCard,
  getKnowledgeCards,
  createKnowledgeCard,
  updateKnowledgeCard,
  deleteKnowledgeCard,
} from '@/services/wiki';

const { Option } = Select;
const { TextArea } = Input;

interface KnowledgeCardSectionProps {
  selectedEntity: GraphNode | null;
}

const cardTypes = [
  { value: 'RELATIONSHIP', label: '关系', color: 'blue' },
  { value: 'BUSINESS_RULE', label: '业务规则', color: 'green' },
  { value: 'DATA_PATTERN', label: '数据模式', color: 'purple' },
  { value: 'USAGE_PATTERN', label: '使用模式', color: 'orange' },
  { value: 'SEMANTIC_MAPPING', label: '语义映射', color: 'cyan' },
  { value: 'METRIC_DEFINITION', label: '指标定义', color: 'magenta' },
];

const KnowledgeCardSection: React.FC<KnowledgeCardSectionProps> = ({ selectedEntity }) => {
  const [cards, setCards] = useState<WikiKnowledgeCard[]>([]);
  const [loading, setLoading] = useState(false);
  const [modalVisible, setModalVisible] = useState(false);
  const [editingCard, setEditingCard] = useState<WikiKnowledgeCard | null>(null);
  const [form] = Form.useForm();

  useEffect(() => {
    if (selectedEntity) {
      fetchCards();
    } else {
      setCards([]);
    }
  }, [selectedEntity]);

  const fetchCards = async () => {
    if (!selectedEntity) return;

    setLoading(true);
    try {
      const resp = await getKnowledgeCards(selectedEntity.id);
      if (resp.success && resp.data) {
        setCards(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch knowledge cards:', error);
      message.error('获取知识卡片失败');
    } finally {
      setLoading(false);
    }
  };

  const handleCreate = () => {
    if (!selectedEntity) {
      message.warning('请先选择一个实体');
      return;
    }
    setEditingCard(null);
    form.resetFields();
    setModalVisible(true);
  };

  const handleEdit = (card: WikiKnowledgeCard) => {
    setEditingCard(card);
    form.setFieldsValue({
      ...card,
      confidence: card.confidence ? card.confidence * 100 : 90,
      tags: card.tags?.join(', '),
      extractedFrom: card.extractedFrom?.join(', '),
    });
    setModalVisible(true);
  };

  const handleDelete = async (cardId: string) => {
    try {
      const resp = await deleteKnowledgeCard(cardId);
      if (resp.success) {
        message.success('删除成功');
        fetchCards();
      } else {
        message.error(resp.message || '删除失败');
      }
    } catch (error) {
      message.error('删除失败');
    }
  };

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();
      const card: WikiKnowledgeCard = {
        ...values,
        entityId: selectedEntity?.id || editingCard?.entityId || '',
        confidence: values.confidence / 100,
        tags: values.tags ? values.tags.split(',').map((t: string) => t.trim()) : [],
        extractedFrom: values.extractedFrom
          ? values.extractedFrom.split(',').map((t: string) => t.trim())
          : [],
      };

      let resp;
      if (editingCard) {
        resp = await updateKnowledgeCard(editingCard.cardId, card);
      } else {
        resp = await createKnowledgeCard(card);
      }

      if (resp.success) {
        message.success(editingCard ? '更新成功' : '创建成功');
        setModalVisible(false);
        fetchCards();
      } else {
        message.error(resp.message || '操作失败');
      }
    } catch (error) {
      if (error instanceof Error) {
        message.error(error.message);
      } else {
        message.error('操作失败');
      }
    }
  };

  const getTypeColor = (type: string) => {
    const found = cardTypes.find((t) => t.value === type);
    return found?.color || 'default';
  };

  const getTypeLabel = (type: string) => {
    const found = cardTypes.find((t) => t.value === type);
    return found?.label || type;
  };

  return (
    <div>
      {!selectedEntity ? (
        <Empty
          description="请先在实体关系图中选择一个实体"
          image={Empty.PRESENTED_IMAGE_SIMPLE}
        />
      ) : (
        <>
          <div style={{ marginBottom: 16 }}>
            <Space>
              <Button
                type="primary"
                icon={<PlusOutlined />}
                onClick={handleCreate}
              >
                新建知识卡片
              </Button>
              <span>
                当前实体: <Tag color="blue">{selectedEntity.displayName || selectedEntity.name}</Tag>
              </span>
            </Space>
          </div>

          <List
            grid={{ gutter: 16, xs: 1, sm: 2, md: 2, lg: 3, xl: 3, xxl: 4 }}
            dataSource={cards}
            loading={loading}
            locale={{ emptyText: '暂无知识卡片' }}
            renderItem={(card) => (
              <List.Item>
                <Card
                  hoverable
                  title={
                    <Space>
                      <Tag color={getTypeColor(card.cardType)}>{getTypeLabel(card.cardType)}</Tag>
                      {card.title && <span>{card.title}</span>}
                    </Space>
                  }
                  actions={[
                    <Button
                      key="edit"
                      type="text"
                      icon={<EditOutlined />}
                      onClick={() => handleEdit(card)}
                    >
                      编辑
                    </Button>,
                    <Popconfirm
                      key="delete"
                      title="确认删除此卡片？"
                      onConfirm={() => handleDelete(card.cardId)}
                      okText="确认"
                      cancelText="取消"
                    >
                      <Button type="text" danger icon={<DeleteOutlined />}>
                        删除
                      </Button>
                    </Popconfirm>,
                  ]}
                >
                  <p style={{ height: 80, overflow: 'hidden', textOverflow: 'ellipsis' }}>
                    {card.content}
                  </p>
                  <div style={{ marginTop: 8 }}>
                    <Space>
                      <span style={{ fontSize: 12, color: '#666' }}>
                        置信度: {card.confidence ? Math.round(card.confidence * 100) : 0}%
                      </span>
                      {card.status === 'ACTIVE' && <Tag color="green">已确认</Tag>}
                      {card.status === 'CONFLICTED' && <Tag color="red">有冲突</Tag>}
                    </Space>
                  </div>
                  {card.tags && card.tags.length > 0 && (
                    <div style={{ marginTop: 8 }}>
                      {card.tags.map((tag) => (
                        <Tag key={tag} style={{ marginBottom: 4 }}>
                          {tag}
                        </Tag>
                      ))}
                    </div>
                  )}
                </Card>
              </List.Item>
            )}
          />
        </>
      )}

      <Modal
        title={editingCard ? '编辑知识卡片' : '新建知识卡片'}
        open={modalVisible}
        onOk={handleSubmit}
        onCancel={() => setModalVisible(false)}
        width={600}
      >
        <Form form={form} layout="vertical">
          <Form.Item
            name="cardType"
            label="卡片类型"
            rules={[{ required: true, message: '请选择卡片类型' }]}
          >
            <Select placeholder="请选择卡片类型">
              {cardTypes.map((type) => (
                <Option key={type.value} value={type.value}>
                  {type.label}
                </Option>
              ))}
            </Select>
          </Form.Item>

          <Form.Item
            name="title"
            label="标题"
            rules={[{ required: true, message: '请输入标题' }]}
          >
            <Input placeholder="请输入标题" />
          </Form.Item>

          <Form.Item
            name="content"
            label="内容"
            rules={[{ required: true, message: '请输入内容' }]}
          >
            <TextArea rows={4} placeholder="请输入知识内容" />
          </Form.Item>

          <Form.Item name="confidence" label="置信度">
            <Slider min={0} max={100} defaultValue={90} marks={{ 0: '0%', 50: '50%', 100: '100%' }} />
          </Form.Item>

          <Form.Item name="tags" label="标签">
            <Input placeholder="多个标签用逗号分隔" />
          </Form.Item>

          <Form.Item name="extractedFrom" label="来源">
            <Input placeholder="知识来源，如：表结构分析、业务文档等" />
          </Form.Item>
        </Form>
      </Modal>
    </div>
  );
};

export default KnowledgeCardSection;
