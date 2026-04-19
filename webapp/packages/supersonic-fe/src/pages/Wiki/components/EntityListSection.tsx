import React, { useState, useMemo } from 'react';
import {
  Table,
  Button,
  Space,
  Input,
  Select,
  Tag,
  Modal,
  Form,
  message,
  Popconfirm,
  Row,
  Col,
  Typography,
  Dropdown,
} from 'antd';
import { PlusOutlined, DeleteOutlined, EditOutlined, ReloadOutlined, TableOutlined, ColumnWidthOutlined, FolderOutlined } from '@ant-design/icons';
import type { MenuProps } from 'antd';
import {
  WikiEntity,
  createEntity,
  updateEntity,
  deleteEntity,
  addTopicToEntity,
  removeTopicFromEntity,
} from '@/services/wiki';

const { Option } = Select;
const { Text } = Typography;

interface EntityListSectionProps {
  entities: WikiEntity[];
  onRefresh: () => void;
}

const EntityListSection: React.FC<EntityListSectionProps> = ({ entities, onRefresh }) => {
  const [loading, setLoading] = useState(false);
  const [modalVisible, setModalVisible] = useState(false);
  const [topicModalVisible, setTopicModalVisible] = useState(false);
  const [assignModalVisible, setAssignModalVisible] = useState(false);
  const [editingEntity, setEditingEntity] = useState<WikiEntity | null>(null);
  const [form] = Form.useForm();
  const [topicForm] = Form.useForm();
  const [assignForm] = Form.useForm();
  const [selectedTable, setSelectedTable] = useState<WikiEntity | null>(null);
  const [searchText, setSearchText] = useState('');
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);

  // 分离表和字段
  const tables = useMemo(() => {
    return entities.filter(e => e.entityType === 'TABLE' && e.status === 'ACTIVE');
  }, [entities]);

  const topics = useMemo(() => {
    return entities.filter(e => e.entityType === 'TOPIC' && e.status === 'ACTIVE');
  }, [entities]);

  const columns = useMemo(() => {
    if (!selectedTable) return [];
    return entities.filter(
      e => e.entityType === 'COLUMN' && e.parentEntityId === selectedTable.entityId && e.status === 'ACTIVE'
    );
  }, [entities, selectedTable]);

  // 过滤表
  const filteredTables = useMemo(() => {
    if (!searchText) return tables;
    return tables.filter(t =>
      t.name?.toLowerCase().includes(searchText.toLowerCase()) ||
      t.displayName?.toLowerCase().includes(searchText.toLowerCase())
    );
  }, [tables, searchText]);

  // 批量选择的表对象
  const selectedTables = useMemo(() => {
    return tables.filter(t => selectedRowKeys.includes(t.entityId));
  }, [tables, selectedRowKeys]);

  const handleCreate = () => {
    setEditingEntity(null);
    form.resetFields();
    setModalVisible(true);
  };

  const handleEdit = (entity: WikiEntity) => {
    setEditingEntity(entity);
    form.setFieldsValue({
      ...entity,
      properties: entity.properties ? JSON.stringify(entity.properties, null, 2) : '{}',
      tags: entity.tags?.join(', '),
    });
    setModalVisible(true);
  };

  const handleDelete = async (entityId: string, entityType: string) => {
    try {
      const resp = await deleteEntity(entityId);
      if (resp.success) {
        message.success('删除成功');
        if (selectedTable?.entityId === entityId) {
          setSelectedTable(null);
        }
        onRefresh();
      } else {
        message.error(resp.message || '删除失败');
      }
    } catch (error) {
      message.error('删除失败');
    }
  };

  const handleBatchDelete = async () => {
    if (selectedRowKeys.length === 0) {
      message.warning('请先选择要删除的表');
      return;
    }
    try {
      let successCount = 0;
      let failCount = 0;
      for (const key of selectedRowKeys) {
        const resp = await deleteEntity(key as string);
        if (resp.success) {
          successCount++;
        } else {
          failCount++;
        }
      }
      if (failCount === 0) {
        message.success(`成功删除 ${successCount} 个表`);
      } else {
        message.warning(`成功删除 ${successCount} 个表，失败 ${failCount} 个`);
      }
      setSelectedRowKeys([]);
      onRefresh();
    } catch (error) {
      message.error('批量删除失败');
    }
  };

  // 创建主题
  const handleCreateTopic = async () => {
    try {
      const values = await topicForm.validateFields();
      const topic: WikiEntity = {
        entityType: 'TOPIC',
        name: values.name,
        displayName: values.displayName || values.name,
        description: values.description || '',
        status: 'ACTIVE',
      };
      const resp = await createEntity(topic);
      if (resp.success) {
        message.success('主题创建成功');
        setTopicModalVisible(false);
        topicForm.resetFields();
        // 如果有选中的表，自动关联到新主题
        if (selectedRowKeys.length > 0 && resp.data?.entityId) {
          await handleAssignTablesToTopic(resp.data.entityId);
        }
        onRefresh();
      } else {
        message.error(resp.message || '创建失败');
      }
    } catch (error) {
      if (error instanceof Error) {
        message.error(error.message);
      } else {
        message.error('创建失败');
      }
    }
  };

  // 将选中的表分配到主题（支持多主题多选）
  const handleAssignTablesToTopic = async (topicIds: string[]) => {
    try {
      if (!topicIds || topicIds.length === 0) {
        message.error('请选择至少一个主题');
        return;
      }

      for (const topicId of topicIds) {
        const topic = topics.find(t => t.entityId === topicId);
        for (const table of selectedTables) {
          await addTopicToEntity(table.entityId, topicId);
        }
        if (topic) {
          message.success(`已将 ${selectedTables.length} 个表添加到主题「${topic.displayName || topic.name}」`);
        }
      }
      setAssignModalVisible(false);
      setSelectedRowKeys([]);
      onRefresh();
    } catch (error) {
      message.error('分配失败');
    }
  };

  // 从主题移除表（支持多主题）
  const handleRemoveFromTopic = async (table: WikiEntity, topicId: string) => {
    try {
      const resp = await removeTopicFromEntity(table.entityId, topicId);
      if (resp.success) {
        message.success('已从主题移除');
        onRefresh();
      } else {
        message.error(resp.message || '操作失败');
      }
    } catch (error) {
      message.error('操作失败');
    }
  };

  const getDeleteConfirmTitle = (entity: WikiEntity) => {
    if (entity.entityType === 'TABLE') {
      return `确定删除表 "${entity.name}"？将同时删除该表下的所有字段`;
    }
    return `确定删除实体 "${entity.name}"？`;
  };

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields();
      const entity: WikiEntity = {
        ...values,
        properties: values.properties ? JSON.parse(values.properties) : {},
        tags: values.tags ? values.tags.split(',').map((t: string) => t.trim()) : [],
      };

      let resp;
      if (editingEntity) {
        resp = await updateEntity(editingEntity.entityId, entity);
      } else {
        resp = await createEntity(entity);
      }

      if (resp.success) {
        message.success(editingEntity ? '更新成功' : '创建成功');
        setModalVisible(false);
        onRefresh();
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

  // 主题下拉菜单
  const topicMenuItems: MenuProps['items'] = [
    {
      key: 'create',
      label: '创建新主题',
      icon: <FolderOutlined />,
      onClick: () => setTopicModalVisible(true),
    },
    { type: 'divider' },
    ...topics.map(topic => ({
      key: topic.entityId,
      label: topic.displayName || topic.name,
      onClick: () => {
        assignForm.setFieldsValue({ topicId: topic.entityId });
        setAssignModalVisible(true);
      },
    })),
  ];

  const tableColumns = [
    {
      title: '表名',
      dataIndex: 'name',
      key: 'name',
      render: (name: string, record: WikiEntity) => {
        // Support both topicIds (multiple) and topicId (single) for backwards compatibility
        const topicIdList = record.topicIds || (record.topicId ? [record.topicId] : []);
        const entityTopics = topics.filter(t => topicIdList.includes(t.entityId));
        return (
          <Space>
            <TableOutlined style={{ color: '#1890ff' }} />
            <Text strong>{name}</Text>
            {entityTopics.map(topic => (
              <Tag key={topic.entityId} color="orange" style={{ marginLeft: 4 }} icon={<FolderOutlined />}>
                {topic.displayName || topic.name}
              </Tag>
            ))}
          </Space>
        );
      },
    },
    {
      title: '显示名',
      dataIndex: 'displayName',
      key: 'displayName',
      ellipsis: true,
    },
    {
      title: '描述',
      dataIndex: 'description',
      key: 'description',
      ellipsis: true,
    },
    {
      title: '操作',
      key: 'action',
      width: 150,
      render: (_: any, record: WikiEntity) => (
        <Space>
          <Button type="link" size="small" icon={<EditOutlined />} onClick={() => handleEdit(record)}>
            编辑
          </Button>
          <Popconfirm
            title={getDeleteConfirmTitle(record)}
            onConfirm={() => handleDelete(record.entityId, record.entityType)}
            okText="确认"
            cancelText="取消"
          >
            <Button type="link" size="small" danger icon={<DeleteOutlined />}>
              删除
            </Button>
          </Popconfirm>
        </Space>
      ),
    },
  ];

  const columnColumns = [
    {
      title: '字段名',
      dataIndex: 'name',
      key: 'name',
      render: (name: string) => (
        <Space>
          <ColumnWidthOutlined style={{ color: '#52c41a' }} />
          <Text code>{name}</Text>
        </Space>
      ),
    },
    {
      title: '显示名',
      dataIndex: 'displayName',
      key: 'displayName',
    },
    {
      title: '类型',
      key: 'type',
      render: (_: any, record: WikiEntity) => {
        const type = record.properties?.columnType || '-';
        return <Tag>{type}</Tag>;
      },
    },
    {
      title: '描述',
      dataIndex: 'description',
      key: 'description',
      ellipsis: true,
    },
    {
      title: '操作',
      key: 'action',
      width: 100,
      render: (_: any, record: WikiEntity) => (
        <Space>
          <Button type="link" size="small" icon={<EditOutlined />} onClick={() => handleEdit(record)}>
            编辑
          </Button>
          <Popconfirm
            title={`确定删除字段 "${record.name}"？`}
            onConfirm={() => handleDelete(record.entityId, record.entityType)}
            okText="确认"
            cancelText="取消"
          >
            <Button type="link" size="small" danger icon={<DeleteOutlined />}>
              删除
            </Button>
          </Popconfirm>
        </Space>
      ),
    },
  ];

  return (
    <div>
      <div style={{ marginBottom: 16 }}>
        <Space>
          <Button type="primary" icon={<PlusOutlined />} onClick={handleCreate}>
            新建实体
          </Button>
          <Button icon={<ReloadOutlined />} onClick={onRefresh}>
            刷新
          </Button>
          {selectedRowKeys.length > 0 && (
            <>
              <Dropdown menu={{ items: topicMenuItems }} trigger={['click']}>
                <Button icon={<FolderOutlined />}>
                  添加到主题 ({selectedRowKeys.length})
                </Button>
              </Dropdown>
              <Popconfirm
                title={`确定删除选中的 ${selectedRowKeys.length} 个表？将同时删除每个表下的所有字段`}
                onConfirm={handleBatchDelete}
                okText="确认"
                cancelText="取消"
              >
                <Button danger icon={<DeleteOutlined />}>
                  批量删除 ({selectedRowKeys.length})
                </Button>
              </Popconfirm>
            </>
          )}
        </Space>
      </div>

      <Row gutter={16}>
        <Col span={12}>
          <div style={{ marginBottom: 8 }}>
            <Input.Search
              placeholder="搜索表名"
              allowClear
              value={searchText}
              onChange={(e) => setSearchText(e.target.value)}
              style={{ width: 200 }}
            />
            <Text type="secondary" style={{ marginLeft: 8 }}>
              共 {filteredTables.length} 个表
            </Text>
          </div>
          <Table
            columns={tableColumns}
            dataSource={filteredTables}
            rowKey="entityId"
            loading={loading}
            size="small"
            pagination={{ pageSize: 10 }}
            rowSelection={{
              selectedRowKeys,
              onChange: (keys) => setSelectedRowKeys(keys),
            }}
            rowClassName={(record) => selectedTable?.entityId === record.entityId ? 'ant-table-row-selected' : ''}
            onRow={(record) => ({
              onClick: () => setSelectedTable(record),
              style: { cursor: 'pointer' },
            })}
          />
        </Col>
        <Col span={12}>
          <div style={{ marginBottom: 8 }}>
            <Text type="secondary">
              {selectedTable ? (
                <>
                  <TableOutlined style={{ color: '#1890ff' }} />
                  {' '} {selectedTable.name} 的字段（共 {columns.length} 个）
                </>
              ) : (
                '请选择左侧表'
              )}
            </Text>
          </div>
          {selectedTable ? (
            <Table
              columns={columnColumns}
              dataSource={columns}
              rowKey="entityId"
              loading={loading}
              size="small"
              pagination={{ pageSize: 10 }}
            />
          ) : (
            <div style={{ padding: 50, textAlign: 'center', background: '#f5f5f5', borderRadius: 4 }}>
              <Text type="secondary">点击左侧表名查看其字段</Text>
            </div>
          )}
        </Col>
      </Row>

      {/* 新建实体弹窗 */}
      <Modal
        title={editingEntity ? '编辑实体' : '新建实体'}
        open={modalVisible}
        onOk={handleSubmit}
        onCancel={() => setModalVisible(false)}
        width={600}
      >
        <Form form={form} layout="vertical">
          <Form.Item
            name="entityType"
            label="实体类型"
            rules={[{ required: true, message: '请选择实体类型' }]}
          >
            <Select placeholder="请选择实体类型">
              <Option value="TABLE">表 (TABLE)</Option>
              <Option value="COLUMN">字段 (COLUMN)</Option>
              <Option value="TOPIC">主题 (TOPIC)</Option>
            </Select>
          </Form.Item>

          <Form.Item
            name="name"
            label="名称"
            rules={[{ required: true, message: '请输入名称' }]}
          >
            <Input placeholder="请输入名称" />
          </Form.Item>

          <Form.Item name="displayName" label="显示名称">
            <Input placeholder="请输入显示名称" />
          </Form.Item>

          <Form.Item name="description" label="描述">
            <Input.TextArea rows={3} placeholder="请输入描述" />
          </Form.Item>

          <Form.Item name="parentEntityId" label="父实体ID">
            <Input placeholder="请输入父实体ID（用于字段关联表）" />
          </Form.Item>

          <Form.Item name="topicId" label="主题ID">
            <Input placeholder="请输入主题ID" />
          </Form.Item>

          <Form.Item name="tags" label="标签">
            <Input placeholder="多个标签用逗号分隔" />
          </Form.Item>

          <Form.Item name="properties" label="属性 (JSON)">
            <Input.TextArea rows={4} placeholder='{"key": "value"}' />
          </Form.Item>
        </Form>
      </Modal>

      {/* 创建主题弹窗 */}
      <Modal
        title="创建主题"
        open={topicModalVisible}
        onOk={handleCreateTopic}
        onCancel={() => {
          setTopicModalVisible(false);
          topicForm.resetFields();
        }}
        width={500}
      >
        <Form form={topicForm} layout="vertical">
          <Form.Item
            name="name"
            label="主题名称"
            rules={[{ required: true, message: '请输入主题名称' }]}
          >
            <Input placeholder="请输入主题名称，如：用户主题、订单主题" />
          </Form.Item>

          <Form.Item name="displayName" label="显示名称">
            <Input placeholder="可选，显示名称" />
          </Form.Item>

          <Form.Item name="description" label="描述">
            <Input.TextArea rows={3} placeholder="请输入主题描述" />
          </Form.Item>
        </Form>
        {selectedRowKeys.length > 0 && (
          <div style={{ marginTop: 16, padding: 12, background: '#f5f5f5', borderRadius: 4 }}>
            <Text type="secondary">
              创建后，选中的 {selectedRowKeys.length} 个表将自动关联到此主题
            </Text>
          </div>
        )}
      </Modal>

      {/* 分配到主题弹窗 */}
      <Modal
        title="添加到主题"
        open={assignModalVisible}
        onCancel={() => {
          setAssignModalVisible(false);
          assignForm.resetFields();
        }}
        footer={[
          <Button key="cancel" onClick={() => setAssignModalVisible(false)}>
            取消
          </Button>,
          <Button key="create" icon={<FolderOutlined />} onClick={() => {
            setAssignModalVisible(false);
            setTopicModalVisible(true);
          }}>
            创建新主题
          </Button>,
          <Button key="assign" type="primary" onClick={async () => {
            const values = await assignForm.validateFields();
            await handleAssignTablesToTopic(values.topicIds);
          }}>
            确认添加
          </Button>,
        ]}
        width={500}
      >
        <Form form={assignForm} layout="vertical">
          <Form.Item
            name="topicIds"
            label="选择主题"
            rules={[{ required: true, message: '请选择至少一个主题' }]}
          >
            <Select mode="multiple" placeholder="请选择主题（可多选）">
              {topics.map(topic => (
                <Option key={topic.entityId} value={topic.entityId}>
                  {topic.displayName || topic.name}
                </Option>
              ))}
            </Select>
          </Form.Item>
        </Form>
        <div style={{ marginTop: 16, padding: 12, background: '#f5f5f5', borderRadius: 4 }}>
          <Text type="secondary">
            将把选中的 {selectedRowKeys.length} 个表添加到所选的 {assignForm.getFieldValue('topicIds')?.length || 0} 个主题
          </Text>
        </div>
      </Modal>
    </div>
  );
};

export default EntityListSection;
