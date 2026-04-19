import React from 'react';
import { Input, Button, Card, Tag, Space, Typography, Empty, Spin } from 'antd';
import { SearchOutlined } from '@ant-design/icons';
import type { SchemaKnowledge } from '@/services/text2sql';

const { Text } = Typography;

interface SearchSectionProps {
  query: string;
  onQueryChange: (query: string) => void;
  onSearch: () => void;
  results: SchemaKnowledge[];
  loading: boolean;
}

const SearchSection: React.FC<SearchSectionProps> = ({
  query,
  onQueryChange,
  onSearch,
  results,
  loading,
}) => {
  return (
    <Space direction="vertical" size="large" style={{ width: '100%' }}>
      <Card size="small">
        <Space direction="vertical" size="middle" style={{ width: '100%' }}>
          <div>
            <Text strong>搜索知识库:</Text>
            <Input
              style={{ marginTop: 8 }}
              placeholder="例如: 查询用户信息、缴费记录等"
              value={query}
              onChange={(e) => onQueryChange(e.target.value)}
              onPressEnter={onSearch}
              suffix={
                <Button
                  type="primary"
                  icon={<SearchOutlined />}
                  onClick={onSearch}
                  loading={loading}
                  size="small"
                >
                  搜索
                </Button>
              }
            />
          </div>
        </Space>
      </Card>

      <Spin spinning={loading}>
        <Card size="small" title="搜索结果">
          {results.length > 0 ? (
            <Space direction="vertical" size="middle" style={{ width: '100%' }}>
              <Text type="secondary">找到 {results.length} 个相关知识条目</Text>
              {results.map((item, index) => (
                <Card
                  key={`${item.tableName}-${item.columnName}-${index}`}
                  size="small"
                  bordered
                >
                  <Space direction="vertical" size="small" style={{ width: '100%' }}>
                    <div>
                      <Tag color="blue">{item.tableName}</Tag>
                      <Text strong>{item.tableComment || item.tableName}</Text>
                    </div>
                    <div>
                      <Text>字段: </Text>
                      <Text code>{item.columnName}</Text>
                      <Text type="secondary"> ({item.columnType})</Text>
                      {item.columnComment && (
                        <Text type="secondary"> - {item.columnComment}</Text>
                      )}
                    </div>
                    <div>
                      {item.isPrimaryKey && <Tag color="gold">主键</Tag>}
                      {item.isForeignKey && <Tag color="purple">外键</Tag>}
                      {item.similarity !== undefined && (
                        <Text type="success">
                          相似度: {(item.similarity * 100).toFixed(1)}%
                        </Text>
                      )}
                    </div>
                  </Space>
                </Card>
              ))}
            </Space>
          ) : query ? (
            <Empty description="未找到相关知识条目" />
          ) : (
            <Empty description="输入查询内容开始搜索" />
          )}
        </Card>
      </Spin>
    </Space>
  );
};

export default SearchSection;
