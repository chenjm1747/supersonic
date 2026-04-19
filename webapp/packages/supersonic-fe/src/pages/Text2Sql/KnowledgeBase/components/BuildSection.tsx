import React, { useRef } from 'react';
import { Input, Button, Checkbox, Space, Typography, Card, Tag, Select, Upload, message } from 'antd';
import { PlayCircleOutlined, FolderOpenOutlined, UploadOutlined } from '@ant-design/icons';
import type { TableSchema, DatabaseType } from '@/services/text2sql';

const { Text } = Typography;
const { TextArea } = Input;

const { Dragger } = Upload;

interface BuildSectionProps {
  sqlFilePath: string;
  databaseType: DatabaseType;
  sqlContent: string;
  onPathChange: (path: string) => void;
  onDatabaseTypeChange: (dbType: DatabaseType) => void;
  onSqlContentChange: (content: string) => void;
  onParse: () => void;
  availableTables: TableSchema[];
  selectedTables: string[];
  onSelectionChange: (tables: string[]) => void;
  onBuild: () => void;
  building: boolean;
  loading: boolean;
}

const DATABASE_OPTIONS = [
  { label: 'MySQL', value: 'MYSQL' },
  { label: 'PostgreSQL', value: 'POSTGRESQL' },
  { label: 'Oracle', value: 'ORACLE' },
  { label: 'SQL Server', value: 'SQLSERVER' },
  { label: 'SQLite', value: 'SQLITE' },
];

const BuildSection: React.FC<BuildSectionProps> = ({
  sqlFilePath,
  databaseType,
  sqlContent,
  onPathChange,
  onDatabaseTypeChange,
  onSqlContentChange,
  onParse,
  availableTables,
  selectedTables,
  onSelectionChange,
  onBuild,
  building,
  loading,
}) => {
  const fileInputRef = useRef<any>(null);

  const handleFileSelect = (file: File) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const content = e.target?.result as string;
      onSqlContentChange(content);
      onPathChange(file.name);
    };
    reader.readAsText(file);
    return false;
  };

  const handleUploadChange = (info: any) => {
    const file = info.file.originFileObj || info.file;
    if (file) {
      handleFileSelect(file);
    }
  };
  const handleSelectAll = () => {
    onSelectionChange(availableTables.map((t) => t.tableName));
  };

  const handleDeselectAll = () => {
    onSelectionChange([]);
  };

  const handleTableToggle = (tableName: string, checked: boolean) => {
    if (checked) {
      onSelectionChange([...selectedTables, tableName]);
    } else {
      onSelectionChange(selectedTables.filter((t) => t !== tableName));
    }
  };

  return (
    <Space direction="vertical" size="large" style={{ width: '100%' }}>
      <Card title="SQL 文件" size="small">
        <Space direction="vertical" size="middle" style={{ width: '100%' }}>
          <div>
            <Text strong>数据库类型:</Text>
            <Select
              style={{ marginTop: 8, width: '100%' }}
              value={databaseType}
              onChange={onDatabaseTypeChange}
              options={DATABASE_OPTIONS}
              placeholder="选择数据库类型"
            />
          </div>
          <div>
            <Text strong>选择 SQL 文件:</Text>
            <Dragger
              style={{ marginTop: 8 }}
              accept=".sql"
              showUploadList={false}
              beforeUpload={handleFileSelect}
              onChange={handleUploadChange}
            >
              <p className="ant-upload-drag-icon">
                <UploadOutlined />
              </p>
              <p className="ant-upload-text">点击或拖拽 SQL 文件到此处</p>
              <p className="ant-upload-hint">
                {sqlContent
                  ? `已选择: ${sqlFilePath}`
                  : '支持 MySQL、PostgreSQL 等数据库的 SQL 文件'}
              </p>
            </Dragger>
          </div>
          {sqlContent && (
            <div>
              <Text strong>或手动输入 SQL 内容:</Text>
              <TextArea
                style={{ marginTop: 8, fontFamily: 'monospace', maxHeight: 200 }}
                rows={6}
                placeholder="在此粘贴 SQL 内容..."
                value={sqlContent}
                onChange={(e) => onSqlContentChange(e.target.value)}
              />
            </div>
          )}
          <Button
            icon={<FolderOpenOutlined />}
            onClick={onParse}
            loading={loading}
            disabled={!sqlContent && !sqlFilePath}
          >
            解析文件
          </Button>
        </Space>
      </Card>

      {availableTables.length > 0 && (
        <Card
          title="目标表选择"
          size="small"
          extra={
            <Space>
              <Button size="small" onClick={handleSelectAll}>
                全选
              </Button>
              <Button size="small" onClick={handleDeselectAll}>
                取消全选
              </Button>
            </Space>
          }
        >
          <Checkbox.Group
            value={selectedTables}
            onChange={(values) => onSelectionChange(values as string[])}
            style={{ width: '100%' }}
          >
            <Space direction="vertical" size="small">
              {availableTables.map((table) => (
                <div key={table.tableName}>
                  <Checkbox value={table.tableName}>
                    <Space>
                      <Text strong>{table.tableName}</Text>
                      {table.tableComment && (
                        <Text type="secondary">({table.tableComment})</Text>
                      )}
                      <Tag color="blue">{table.columnCount} 列</Tag>
                    </Space>
                  </Checkbox>
                </div>
              ))}
            </Space>
          </Checkbox.Group>
        </Card>
      )}

      <Card size="small">
        <Space direction="vertical" size="middle">
          <Button
            type="primary"
            icon={<PlayCircleOutlined />}
            onClick={onBuild}
            loading={building}
            disabled={selectedTables.length === 0}
            size="large"
          >
            开始构建知识库
          </Button>
          <Text type="secondary">
            已选择 {selectedTables.length} 个表，共{' '}
            {availableTables
              .filter((t) => selectedTables.includes(t.tableName))
              .reduce((sum, t) => sum + t.columnCount, 0)}{' '}
            个字段
          </Text>
        </Space>
      </Card>
    </Space>
  );
};

export default BuildSection;
