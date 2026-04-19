import React, { useState, useEffect } from 'react';
import { Card, Tabs, message } from 'antd';
import { ProCard } from '@ant-design/pro-components';
import BuildSection from './components/BuildSection';
import SearchSection from './components/SearchSection';
import OverviewSection from './components/OverviewSection';
import {
  parseSqlFile,
  buildKnowledge,
  searchKnowledge,
  getKnowledgeStats,
  clearKnowledge,
  TableSchema,
  SchemaKnowledge,
  KnowledgeStats,
  DatabaseType,
} from '@/services/text2sql';

const { TabPane } = Tabs;

const KnowledgeBase: React.FC = () => {
  const [sqlFilePath, setSqlFilePath] = useState<string>('');
  const [databaseType, setDatabaseType] = useState<DatabaseType>('MYSQL');
  const [sqlContent, setSqlContent] = useState<string>('');
  const [availableTables, setAvailableTables] = useState<TableSchema[]>([]);
  const [selectedTables, setSelectedTables] = useState<string[]>([]);
  const [building, setBuilding] = useState(false);
  const [searchQuery, setSearchQuery] = useState<string>('');
  const [searchResults, setSearchResults] = useState<SchemaKnowledge[]>([]);
  const [stats, setStats] = useState<KnowledgeStats | null>(null);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    fetchStats();
  }, []);

  const fetchStats = async () => {
    try {
      const resp = await getKnowledgeStats();
      if (resp.success && resp.stats) {
        setStats({
          tableCount: resp.stats.table_count || 0,
          columnCount: resp.stats.column_count || 0,
          lastUpdate: resp.stats.last_update || '',
        });
      }
    } catch (error) {
      console.error('Failed to fetch stats:', error);
    }
  };

  const handleParseSqlFile = async () => {
    if (!sqlContent && !sqlFilePath) {
      message.warning('请选择 SQL 文件或输入 SQL 内容');
      return;
    }

    setLoading(true);
    try {
      const resp = await parseSqlFile(sqlFilePath, databaseType, sqlContent);
      if (resp.success && resp.tables) {
        setAvailableTables(resp.tables);
        setSelectedTables(resp.tables.map((t) => t.tableName));
        message.success(`成功解析 ${resp.tables.length} 个表`);
      } else {
        message.error(resp.message || '解析 SQL 文件失败');
      }
    } catch (error) {
      message.error('解析 SQL 文件失败');
    } finally {
      setLoading(false);
    }
  };

  const handleBuildKnowledge = async () => {
    if (selectedTables.length === 0) {
      message.warning('请选择至少一个表');
      return;
    }

    setBuilding(true);
    try {
      const resp = await buildKnowledge({
        sqlFilePath,
        databaseType,
        targetTables: selectedTables,
        sqlContent,
      });

      if (resp.success) {
        message.success(`知识库构建完成: ${resp.knowledgeCount} 个字段`);
        fetchStats();
      } else {
        message.error(resp.message || '构建知识库失败');
      }
    } catch (error) {
      message.error('构建知识库失败');
    } finally {
      setBuilding(false);
    }
  };

  const handleSearch = async () => {
    if (!searchQuery.trim()) {
      message.warning('请输入查询内容');
      return;
    }

    setLoading(true);
    try {
      const resp = await searchKnowledge({ query: searchQuery, topK: 10 });
      if (resp.success && resp.results) {
        setSearchResults(resp.results);
      } else {
        message.error(resp.message || '搜索失败');
      }
    } catch (error) {
      message.error('搜索失败');
    } finally {
      setLoading(false);
    }
  };

  const handleClearKnowledge = async () => {
    try {
      const resp = await clearKnowledge();
      if (resp.success) {
        message.success('知识库已清空');
        fetchStats();
        setSearchResults([]);
      } else {
        message.error(resp.message || '清空知识库失败');
      }
    } catch (error) {
      message.error('清空知识库失败');
    }
  };

  return (
    <ProCard>
      <Card title="Text2SQL 知识库管理">
        <Tabs defaultActiveKey="build">
          <TabPane tab="知识库构建" key="build">
            <BuildSection
              sqlFilePath={sqlFilePath}
              databaseType={databaseType}
              sqlContent={sqlContent}
              onPathChange={setSqlFilePath}
              onDatabaseTypeChange={setDatabaseType}
              onSqlContentChange={setSqlContent}
              onParse={handleParseSqlFile}
              availableTables={availableTables}
              selectedTables={selectedTables}
              onSelectionChange={setSelectedTables}
              onBuild={handleBuildKnowledge}
              building={building}
              loading={loading}
            />
          </TabPane>
          <TabPane tab="知识库查询" key="search">
            <SearchSection
              query={searchQuery}
              onQueryChange={setSearchQuery}
              onSearch={handleSearch}
              results={searchResults}
              loading={loading}
            />
          </TabPane>
          <TabPane tab="知识库概览" key="overview">
            <OverviewSection
              stats={stats}
              onRefresh={fetchStats}
              onClear={handleClearKnowledge}
              tableTreeData={availableTables}
            />
          </TabPane>
        </Tabs>
      </Card>
    </ProCard>
  );
};

export default KnowledgeBase;
