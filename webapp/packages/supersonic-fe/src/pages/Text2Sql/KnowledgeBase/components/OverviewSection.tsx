import React from 'react';
import { Card, Statistic, Row, Col, Button, Tree, Space, Typography, Popconfirm, Empty, message } from 'antd';
import {
  TableOutlined,
  ColumnWidthOutlined,
  DeleteOutlined,
  ReloadOutlined,
  KeyOutlined,
} from '@ant-design/icons';
import type { KnowledgeStats, TableSchema } from '@/services/text2sql';
import { deleteEntity } from '@/services/text2sql';
import type { DataNode } from 'antd/es/tree';

const { Text } = Typography;

interface OverviewSectionProps {
  stats: KnowledgeStats | null;
  onRefresh: () => void;
  onClear: () => void;
  tableTreeData: TableSchema[];
}

const OverviewSection: React.FC<OverviewSectionProps> = ({
  stats,
  onRefresh,
  onClear,
  tableTreeData,
}) => {
  const handleDeleteTable = async (tableName: string) => {
    const entityId = `table:${tableName}`;
    try {
      const resp = await deleteEntity(entityId);
      if (resp.success) {
        message.success(`表 ${tableName} 已删除`);
        onRefresh();
      } else {
        message.error(`删除失败: ${resp.message}`);
      }
    } catch (error) {
      message.error(`删除失败: ${error}`);
    }
  };

  const buildTreeData = (): DataNode[] => {
    if (!tableTreeData || tableTreeData.length === 0) {
      return [];
    }

    return tableTreeData.map((table) => ({
      key: table.tableName,
      title: (
        <Space>
          <TableOutlined />
          <Text strong>{table.tableName}</Text>
          {table.tableComment && (
            <Text type="secondary">({table.tableComment})</Text>
          )}
          <Popconfirm
            title={`确定删除表 ${table.tableName}？将同时删除 ${table.columnCount} 个字段`}
            onConfirm={(e) => {
              e?.stopPropagation();
              handleDeleteTable(table.tableName);
            }}
            onCancel={(e) => e?.stopPropagation()}
            okText="确定"
            cancelText="取消"
          >
            <Button
              type="text"
              danger
              icon={<DeleteOutlined />}
              size="small"
              onClick={(e) => e.stopPropagation()}
            />
          </Popconfirm>
        </Space>
      ),
      children: table.columns?.map((column) => ({
        key: `${table.tableName}.${column.columnName}`,
        title: (
          <Space>
            {column.isPrimaryKey && <KeyOutlined style={{ color: '#faad14' }} />}
            <Text code>{column.columnName}</Text>
            <Text type="secondary">({column.columnType})</Text>
            {column.columnComment && (
              <Text type="secondary">- {column.columnComment}</Text>
            )}
          </Space>
        ),
      })),
    }));
  };

  return (
    <Row gutter={16}>
      <Col span={8}>
        <Card title="统计信息" size="small">
          <Statistic
            title="表数量"
            value={stats?.tableCount || 0}
            prefix={<TableOutlined />}
          />
          <Statistic
            title="字段数量"
            value={stats?.columnCount || 0}
            prefix={<ColumnWidthOutlined />}
            style={{ marginTop: 16 }}
          />
          <Statistic
            title="最后更新"
            value={stats?.lastUpdate || '从未更新'}
            style={{ marginTop: 16 }}
          />
          <Space style={{ marginTop: 16 }}>
            <Button icon={<ReloadOutlined />} onClick={onRefresh}>
              刷新
            </Button>
          </Space>
        </Card>

        <Card title="操作" size="small" style={{ marginTop: 16 }}>
          <Space direction="vertical">
            <Popconfirm
              title="确定要清空知识库吗？此操作不可恢复。"
              onConfirm={onClear}
            >
              <Button icon={<DeleteOutlined />} danger>
                清空知识库
              </Button>
            </Popconfirm>
          </Space>
        </Card>
      </Col>

      <Col span={16}>
        <Card title="知识库内容" size="small">
          {tableTreeData && tableTreeData.length > 0 ? (
            <Tree
              showIcon
              treeData={buildTreeData()}
              defaultExpandAll
              style={{ maxHeight: 500, overflow: 'auto' }}
            />
          ) : (
            <Empty description="暂无知识库内容，请先构建知识库" />
          )}
        </Card>
      </Col>
    </Row>
  );
};

export default OverviewSection;
