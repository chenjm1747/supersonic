import React, { useState, useEffect } from 'react';
import {
  Card,
  Button,
  Space,
  Modal,
  Form,
  Input,
  Select,
  Table,
  Tag,
  message,
  Alert,
  Divider,
  Typography,
  Tabs,
  Badge,
  Tooltip,
  Row,
  Col,
  Statistic,
} from 'antd';
import {
  UploadOutlined,
  DownloadOutlined,
  CheckCircleOutlined,
  WarningOutlined,
  FileTextOutlined,
  TableOutlined,
  ColumnWidthOutlined,
} from '@ant-design/icons';
import {
  ImportPreview,
  ImportResult,
  WikiKnowledgeCard,
  getSchemaImportTemplate,
  validateSchemaScript,
  executeSchemaImport,
  autoGenerateKnowledge,
  getEntities,
  WikiEntity,
  getImportPreview,
  importFromDataSource,
  getDataSources,
  TablePreviewItem,
  TableSelection,
} from '@/services/wiki';
import { Checkbox } from 'antd';

const { TextArea } = Input;
const { Option } = Select;
const { Text } = Typography;

const SchemaImportSection: React.FC = () => {
  const [template, setTemplate] = useState<string>('');
  const [sqlScript, setSqlScript] = useState<string>('');
  const [preview, setPreview] = useState<ImportPreview | null>(null);
  const [importResult, setImportResult] = useState<ImportResult | null>(null);
  const [loading, setLoading] = useState(false);
  const [templateLoading, setTemplateLoading] = useState(false);
  const [templateModalVisible, setTemplateModalVisible] = useState(false);
  const [activeTab, setActiveTab] = useState<string>('import');
  const [entities, setEntities] = useState<WikiEntity[]>([]);
  const [selectedEntity, setSelectedEntity] = useState<string | null>(null);
  const [generatedCards, setGeneratedCards] = useState<WikiKnowledgeCard[]>([]);
  const [generating, setGenerating] = useState(false);

  interface DataSource {
    id: number;
    name: string;
    type: string;
    databaseName: string;
  }

  const [dataSources, setDataSources] = useState<DataSource[]>([]);
  const [selectedDataSource, setSelectedDataSource] = useState<number | null>(null);
  const [importPreview, setImportPreview] = useState<ImportPreview | null>(null);
  const [selectedTables, setSelectedTables] = useState<string[]>([]);
  const [conflictModalVisible, setConflictModalVisible] = useState(false);
  const [conflictTables, setConflictTables] = useState<TablePreviewItem[]>([]);
  const [tableActions, setTableActions] = useState<Record<string, 'IMPORT' | 'SKIP'>>({});

  useEffect(() => {
    fetchTemplate();
    fetchEntities();
  }, []);

  useEffect(() => {
    fetchDataSources();
  }, []);

  const fetchDataSources = async () => {
    try {
      const resp = await getDataSources();
      if (resp.success && resp.data) {
        setDataSources(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch datasources:', error);
    }
  };

  const fetchTemplate = async () => {
    setTemplateLoading(true);
    try {
      const resp = await getSchemaImportTemplate();
      if (resp.success && resp.data) {
        setTemplate(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch template:', error);
      message.error('获取导入模板失败');
    } finally {
      setTemplateLoading(false);
    }
  };

  const fetchEntities = async () => {
    try {
      const resp = await getEntities('TABLE');
      if (resp.success && resp.data) {
        setEntities(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch entities:', error);
    }
  };

  const handleValidate = async () => {
    if (!sqlScript.trim()) {
      message.warning('请输入 SQL 脚本');
      return;
    }

    setLoading(true);
    try {
      const resp = await validateSchemaScript(sqlScript);
      if (resp.success && resp.data) {
        setPreview(resp.data);
        message.success('验证通过');
      } else {
        message.error(resp.message || '验证失败');
      }
    } catch (error) {
      message.error('验证失败');
    } finally {
      setLoading(false);
    }
  };

  const handleImport = async () => {
    if (!sqlScript.trim()) {
      message.warning('请输入 SQL 脚本');
      return;
    }

    Modal.confirm({
      title: '确认导入',
      content: '确定要执行导入吗？这将向数据库写入数据。',
      okText: '确认',
      cancelText: '取消',
      onOk: async () => {
        setLoading(true);
        try {
          const resp = await executeSchemaImport(sqlScript);
          if (resp.success && resp.data) {
            setImportResult(resp.data);
            setPreview(null);
            message.success(`导入完成：成功 ${resp.data.successCount} 条`);
          } else {
            message.error(resp.message || '导入失败');
          }
        } catch (error) {
          message.error('导入失败');
        } finally {
          setLoading(false);
        }
      },
    });
  };

  const handleDownloadTemplate = () => {
    const blob = new Blob([template], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'wiki_schema_import.sql';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  };

  const handleAutoGenerate = async () => {
    if (!selectedEntity) {
      message.warning('请选择一个实体');
      return;
    }

    setGenerating(true);
    try {
      const resp = await autoGenerateKnowledge(selectedEntity);
      if (resp.success && resp.data) {
        setGeneratedCards(resp.data);
        message.success(`成功生成 ${resp.data.length} 个知识卡片`);
      } else {
        message.error(resp.message || '生成失败');
      }
    } catch (error) {
      message.error('生成失败');
    } finally {
      setGenerating(false);
    }
  };

  const handleDataSourceChange = (value: number) => {
    setSelectedDataSource(value);
    setImportPreview(null);
    setSelectedTables([]);
  };

  const handleLoadPreview = async () => {
    if (!selectedDataSource) return;
    try {
      const resp = await getImportPreview(selectedDataSource);
      if (resp.success && resp.data) {
        setImportPreview(resp.data);
        const allTableNames = resp.data.tables.map((t: TablePreviewItem) => t.tableName);
        setSelectedTables(allTableNames);
      }
    } catch (error) {
      message.error('加载表结构失败');
    }
  };

  const handleTableSelect = (tableName: string, checked: boolean) => {
    if (checked) {
      setSelectedTables([...selectedTables, tableName]);
    } else {
      setSelectedTables(selectedTables.filter((t) => t !== tableName));
    }
  };

  const handleImportDataSource = async () => {
    const conflicts = importPreview?.tables.filter(
      (t: TablePreviewItem) => t.conflictStatus === 'EXISTS' && selectedTables.includes(t.tableName)
    );

    if (conflicts && conflicts.length > 0) {
      setConflictTables(conflicts);
      setConflictModalVisible(true);
      return;
    }

    await executeImport([]);
  };

  const executeImport = async (selections: TableSelection[]) => {
    if (!selectedDataSource) return;
    setLoading(true);
    try {
      const resp = await importFromDataSource(selectedDataSource, selections);
      if (resp.success && resp.data) {
        message.success(`导入完成: 成功 ${resp.data.successCount}, 跳过 ${resp.data.skipCount}`);
        if (resp.data.failCount > 0) {
          message.warning(`失败 ${resp.data.failCount} 个表`);
        }
        setConflictModalVisible(false);
      }
    } catch (error) {
      message.error('导入失败');
    } finally {
      setLoading(false);
    }
  };

  const previewColumns = [
    {
      title: '类型',
      dataIndex: 'type',
      key: 'type',
      render: (text: string, record: any) => {
        if (record.topicCount) return <Tag icon={<FileTextOutlined />} color="blue">主题</Tag>;
        if (record.tableCount) return <Tag icon={<TableOutlined />} color="green">表</Tag>;
        if (record.columnCount) return <Tag icon={<ColumnWidthOutlined />} color="purple">字段</Tag>;
        return text;
      },
    },
    {
      title: '数量',
      dataIndex: 'count',
      key: 'count',
      render: (count: number) => <Badge count={count} showZero color="blue" />,
    },
  ];

  const cardColumns = [
    {
      title: '卡片ID',
      dataIndex: 'cardId',
      key: 'cardId',
      ellipsis: true,
    },
    {
      title: '标题',
      dataIndex: 'title',
      key: 'title',
      ellipsis: true,
    },
    {
      title: '类型',
      dataIndex: 'cardType',
      key: 'cardType',
      render: (type: string) => <Tag>{type}</Tag>,
    },
    {
      title: '置信度',
      dataIndex: 'confidence',
      key: 'confidence',
      render: (conf: number) => `${Math.round((conf || 0) * 100)}%`,
    },
    {
      title: '状态',
      dataIndex: 'status',
      key: 'status',
      render: (status: string) => (
        <Tag color={status === 'AUTO_GENERATED' ? 'cyan' : 'default'}>{status}</Tag>
      ),
    },
  ];

  const ConflictModal = () => {
    if (!conflictTables.length) return null;

    const handleBatchAction = (action: 'IMPORT' | 'SKIP') => {
      const newActions = { ...tableActions };
      conflictTables.forEach((t: TablePreviewItem) => {
        newActions[t.tableName] = action;
      });
      setTableActions(newActions);
    };

    const handleConfirm = async () => {
      const selections: TableSelection[] = selectedTables.map((tableName) => ({
        tableName,
        action: tableActions[tableName] || 'IMPORT',
      }));
      await executeImport(selections);
    };

    return (
      <Modal
        title="以下表已存在，请选择处理方式"
        open={conflictModalVisible}
        onCancel={() => setConflictModalVisible(false)}
        onOk={handleConfirm}
      >
        <Table
          rowKey="tableName"
          columns={[
            { title: '表名', dataIndex: 'tableName' },
            { title: '操作', render: (_, record) => (
              <Space>
                <Button
                  size="small"
                  type={tableActions[record.tableName] === 'IMPORT' ? 'primary' : 'default'}
                  onClick={() => setTableActions({ ...tableActions, [record.tableName]: 'IMPORT' })}
                >
                  覆盖此表
                </Button>
                <Button
                  size="small"
                  type={tableActions[record.tableName] === 'SKIP' ? 'primary' : 'default'}
                  onClick={() => setTableActions({ ...tableActions, [record.tableName]: 'SKIP' })}
                >
                  跳过此表
                </Button>
              </Space>
            )},
          ]}
          dataSource={conflictTables}
          pagination={false}
          size="small"
        />
        <Space style={{ marginTop: 16 }}>
          <Button onClick={() => handleBatchAction('IMPORT')}>全部覆盖</Button>
          <Button onClick={() => handleBatchAction('SKIP')}>全部跳过</Button>
        </Space>
      </Modal>
    );
  };

  return (
    <div>
      <Tabs
        activeKey={activeTab}
        onChange={setActiveTab}
        items={[
          {
            key: 'import',
            label: (
              <span>
                <UploadOutlined />
                SQL脚本导入
              </span>
            ),
            children: (
              <div>
                <div style={{ marginBottom: 16 }}>
                  <Space>
                    <Button
                      icon={<DownloadOutlined />}
                      onClick={handleDownloadTemplate}
                      loading={templateLoading}
                    >
                      下载导入模板
                    </Button>
                    <Button onClick={() => {
                      fetchTemplate();
                      setTemplateModalVisible(true);
                    }} loading={templateLoading}>
                      查看模板
                    </Button>
                  </Space>
                </div>

                <Alert
                  message="导入说明"
                  description={
                    <ul style={{ marginBottom: 0 }}>
                      <li>使用 SQL INSERT 语句定义主题、表和字段结构</li>
                      <li>支持批量导入，建议先下载模板查看格式</li>
                      <li>导入前会先验证脚本格式是否正确</li>
                      <li>字段的 businessNote 属性会自动生成业务规则知识卡片</li>
                    </ul>
                  }
                  type="info"
                  showIcon
                  style={{ marginBottom: 16 }}
                />

                <Form layout="vertical">
                  <Form.Item label="SQL 脚本">
                    <TextArea
                      rows={15}
                      value={sqlScript}
                      onChange={(e) => {
                        setSqlScript(e.target.value);
                        setPreview(null);
                        setImportResult(null);
                      }}
                      placeholder="在此粘贴 SQL 导入脚本..."
                    />
                  </Form.Item>
                </Form>

                <div style={{ marginBottom: 16 }}>
                  <Space>
                    <Button
                      type="primary"
                      onClick={handleValidate}
                      loading={loading}
                      icon={<CheckCircleOutlined />}
                    >
                      验证脚本
                    </Button>
                    <Button
                      onClick={handleImport}
                      loading={loading}
                      disabled={!sqlScript.trim()}
                    >
                      执行导入
                    </Button>
                    <Button onClick={() => setSqlScript('')}>
                      清空
                    </Button>
                  </Space>
                </div>

                {preview && (
                  <Card title="导入预览" style={{ marginBottom: 16 }}>
                    <Space direction="vertical" size="large" style={{ width: '100%' }}>
                      <Row gutter={16}>
                        <Col span={8}>
                          <Statistic
                            title="主题数量"
                            value={preview.topicCount}
                            prefix={<FileTextOutlined />}
                          />
                        </Col>
                        <Col span={8}>
                          <Statistic
                            title="表数量"
                            value={preview.tableCount}
                            prefix={<TableOutlined />}
                          />
                        </Col>
                        <Col span={8}>
                          <Statistic
                            title="字段数量"
                            value={preview.columnCount}
                            prefix={<ColumnWidthOutlined />}
                          />
                        </Col>
                      </Row>
                    </Space>
                  </Card>
                )}

                {importResult && (
                  <Alert
                    message="导入结果"
                    description={
                      <Space direction="vertical">
                        <Text type="success">成功：{importResult.successCount} 条</Text>
                        {importResult.failCount > 0 && (
                          <Text type="danger">失败：{importResult.failCount} 条</Text>
                        )}
                      </Space>
                    }
                    type={importResult.failCount > 0 ? 'warning' : 'success'}
                    showIcon
                    icon={<CheckCircleOutlined />}
                  />
                )}
              </div>
            ),
          },
          {
            key: 'auto-generate',
            label: (
              <span>
                <UploadOutlined />
                自动生成知识
              </span>
            ),
            children: (
              <div>
                <Alert
                  message="自动生成说明"
                  description="基于选中的表结构自动生成知识卡片，包括语义映射、业务规则、使用模式和指标定义。"
                  type="info"
                  showIcon
                  style={{ marginBottom: 16 }}
                />

                <Space style={{ marginBottom: 16 }}>
                  <Select
                    placeholder="选择表实体"
                    style={{ width: 300 }}
                    onChange={setSelectedEntity}
                    value={selectedEntity}
                  >
                    {entities.map((entity) => (
                      <Option key={entity.entityId} value={entity.entityId}>
                        <Space>
                          <TableOutlined />
                          {entity.displayName || entity.name}
                        </Space>
                      </Option>
                    ))}
                  </Select>
                  <Button
                    type="primary"
                    onClick={handleAutoGenerate}
                    loading={generating}
                    disabled={!selectedEntity}
                    icon={<UploadOutlined />}
                  >
                    生成知识卡片
                  </Button>
                </Space>

                {generatedCards.length > 0 && (
                  <Card title={`生成的知识卡片 (${generatedCards.length})`}>
                    <Table
                      columns={cardColumns}
                      dataSource={generatedCards}
                      rowKey="cardId"
                      pagination={false}
                      size="small"
                    />
                  </Card>
                )}
              </div>
            ),
          },
          {
            key: 'datasource',
            label: (
              <span>
                <UploadOutlined />
                从数据源导入
              </span>
            ),
            children: (
              <div>
                <Space style={{ marginBottom: 16 }}>
                  <Select
                    placeholder="选择数据源"
                    style={{ width: 300 }}
                    onChange={handleDataSourceChange}
                    value={selectedDataSource}
                  >
                    {dataSources.map((ds) => (
                      <Option key={ds.id} value={ds.id}>
                        {ds.name} ({ds.type} - {ds.databaseName})
                      </Option>
                    ))}
                  </Select>
                  <Button
                    type="primary"
                    onClick={handleLoadPreview}
                    disabled={!selectedDataSource}
                  >
                    加载表结构
                  </Button>
                </Space>

                {importPreview && (
                  <Table
                    rowKey="tableName"
                    columns={[
                      { title: '选择', render: (_, record) => (
                        <Checkbox
                          checked={selectedTables.includes(record.tableName)}
                          onChange={(e) => handleTableSelect(record.tableName, e.target.checked)}
                        />
                      )},
                      { title: '表名', dataIndex: 'tableName' },
                      { title: '中文名', dataIndex: 'displayName' },
                      { title: '字段数', render: (_, record) => record.columns?.length || 0 },
                      { title: '状态', render: (_, record) => (
                        <Tag color={record.conflictStatus === 'NEW' ? 'green' : 'orange'}>
                          {record.conflictStatus === 'NEW' ? '新增' : '已存在'}
                        </Tag>
                      )},
                    ]}
                    dataSource={importPreview.tables}
                    pagination={false}
                    size="small"
                  />
                )}

                <Space style={{ marginTop: 16 }}>
                  <Button
                    type="primary"
                    onClick={handleImportDataSource}
                    disabled={selectedTables.length === 0}
                  >
                    导入选中表 ({selectedTables.length})
                  </Button>
                </Space>

                <ConflictModal />
              </div>
            ),
          },
        ]}
      />

      <Modal
        title="导入模板"
        open={templateModalVisible}
        onCancel={() => setTemplateModalVisible(false)}
        width={800}
        footer={[
          <Button key="close" onClick={() => setTemplateModalVisible(false)}>
            关闭
          </Button>,
          <Button
            key="copy"
            onClick={() => {
              navigator.clipboard.writeText(template);
              message.success('已复制到剪贴板');
            }}
          >
            复制模板
          </Button>,
        ]}
      >
        <TextArea rows={20} value={template} readOnly />
      </Modal>
    </div>
  );
};

export default SchemaImportSection;
