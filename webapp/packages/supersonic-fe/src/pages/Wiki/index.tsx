import React, { useState, useEffect } from 'react';
import { Card, Tabs, message, Badge } from 'antd';
import { ProCard } from '@ant-design/pro-components';
import EntityGraph from './components/EntityGraph';
import KnowledgeCardSection from './components/KnowledgeCardSection';
import EntityListSection from './components/EntityListSection';
import ContradictionSection from './components/ContradictionSection';
import SummarySection from './components/SummarySection';
import HealthSection from './components/HealthSection';
import SchemaImportSection from './components/SchemaImportSection';
import {
  getGraphNodes,
  getGraphEdges,
  getEntities,
  getPendingContradictions,
  GraphNode,
  GraphEdge,
  WikiEntity,
  Contradiction,
} from '@/services/wiki';

const { TabPane } = Tabs;

const Wiki: React.FC = () => {
  const [graphNodes, setGraphNodes] = useState<GraphNode[]>([]);
  const [graphEdges, setGraphEdges] = useState<GraphEdge[]>([]);
  const [entities, setEntities] = useState<WikiEntity[]>([]);
  const [selectedEntity, setSelectedEntity] = useState<GraphNode | null>(null);
  const [loading, setLoading] = useState(false);
  const [graphLoading, setGraphLoading] = useState(false);
  const [pendingCount, setPendingCount] = useState(0);

  useEffect(() => {
    fetchGraphData();
    fetchEntities();
    fetchPendingCount();
  }, []);

  const fetchGraphData = async () => {
    setGraphLoading(true);
    try {
      const [nodesResp, edgesResp] = await Promise.all([getGraphNodes(), getGraphEdges()]);

      if (nodesResp.success && nodesResp.data) {
        setGraphNodes(nodesResp.data);
      }

      if (edgesResp.success && edgesResp.data) {
        setGraphEdges(edgesResp.data);
      }
    } catch (error) {
      console.error('Failed to fetch graph data:', error);
      message.error('获取图数据失败');
    } finally {
      setGraphLoading(false);
    }
  };

  const fetchEntities = async () => {
    try {
      const resp = await getEntities();
      if (resp.success && resp.data) {
        setEntities(resp.data);
      }
    } catch (error) {
      console.error('Failed to fetch entities:', error);
    }
  };

  const fetchPendingCount = async () => {
    try {
      const resp = await getPendingContradictions();
      if (resp.success && resp.data) {
        setPendingCount(resp.data.length);
      }
    } catch (error) {
      console.error('Failed to fetch pending contradictions:', error);
    }
  };

  const handleNodeClick = (node: GraphNode) => {
    setSelectedEntity(node);
  };

  const handleRefreshGraph = () => {
    fetchGraphData();
  };

  return (
    <ProCard>
      <Card title="LLM-SQL-Wiki 知识库">
        <Tabs defaultActiveKey="graph">
          <TabPane tab="实体关系图" key="graph">
            <EntityGraph
              nodes={graphNodes}
              edges={graphEdges}
              selectedNode={selectedEntity}
              onNodeClick={handleNodeClick}
              loading={graphLoading}
              onRefresh={handleRefreshGraph}
            />
          </TabPane>
          <TabPane tab="实体列表" key="entities">
            <EntityListSection
              entities={entities}
              onRefresh={fetchEntities}
            />
          </TabPane>
          <TabPane tab="知识卡片" key="knowledge">
            <KnowledgeCardSection
              selectedEntity={selectedEntity}
            />
          </TabPane>
          <TabPane
            tab={
              <span>
                矛盾处理
                {pendingCount > 0 && (
                  <Badge count={pendingCount} style={{ marginLeft: 8 }} />
                )}
              </span>
            }
            key="contradictions"
          >
            <ContradictionSection />
          </TabPane>
          <TabPane tab="主题摘要" key="summaries">
            <SummarySection />
          </TabPane>
          <TabPane tab="健康检查" key="health">
            <HealthSection />
          </TabPane>
          <TabPane tab="结构导入" key="schema">
            <SchemaImportSection />
          </TabPane>
        </Tabs>
      </Card>
    </ProCard>
  );
};

export default Wiki;
