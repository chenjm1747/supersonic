import React, { useEffect, useRef, useState } from 'react';
import { Button, Space, Drawer, Descriptions, Tag, Spin, Card, Row, Col, Typography, Segmented } from 'antd';
import { ReloadOutlined, TableOutlined, ApartmentOutlined, NodeIndexOutlined } from '@ant-design/icons';
import G6 from '@antv/g6';
import {
  GraphNode,
  GraphEdge,
  getEntityNeighbors,
} from '@/services/wiki';

interface EntityGraphProps {
  nodes: GraphNode[];
  edges: GraphEdge[];
  selectedNode: GraphNode | null;
  onNodeClick: (node: GraphNode) => void;
  loading: boolean;
  onRefresh: () => void;
}

const { Text } = Typography;

const EntityGraph: React.FC<EntityGraphProps> = ({
  nodes,
  edges,
  selectedNode,
  onNodeClick,
  loading,
  onRefresh,
}) => {
  const [showDrawer, setShowDrawer] = useState(false);
  const [neighborData, setNeighborData] = useState<{ nodes: GraphNode[]; edges: GraphEdge[] } | null>(null);
  const [viewMode, setViewMode] = useState<'card' | 'graph'>('card');
  const graphContainerRef = useRef<HTMLDivElement>(null);
  const graphRef = useRef<any>(null);

  // 只获取 TOPIC 和 TABLE 节点
  const topicNodes = nodes.filter((n) => n.type === 'TOPIC' && n.status === 'ACTIVE');
  const tableNodes = nodes.filter((n) => n.type === 'TABLE' && n.status === 'ACTIVE');

  // 构建 TOPIC -> TABLE 的映射（从节点的 topicIds 字段获取，支持多主题）
  const topicTableMap = new Map<string, GraphNode[]>();
  tableNodes.forEach((table) => {
    // Support both topicId (single) and topicIds (multiple) for backwards compatibility
    const topicIds = table.topicIds || (table.topicId ? [table.topicId] : []);
    const legacyTopicId = table.properties?.topicId;
    if (legacyTopicId && !topicIds.includes(legacyTopicId)) {
      topicIds.push(legacyTopicId);
    }
    topicIds.forEach((topicId) => {
      if (topicId) {
        const tables = topicTableMap.get(topicId) || [];
        if (!tables.find((t) => t.id === table.id)) {
          tables.push(table);
        }
        topicTableMap.set(topicId, tables);
      }
    });
  });

  // 没有 TOPIC 的 TABLE 也显示（归为"未分类"）
  const classifiedTableIds = new Set<string>();
  topicTableMap.forEach((tables) => {
    tables.forEach((t) => classifiedTableIds.add(t.id));
  });
  const unclassifiedTables = tableNodes.filter((t) => !classifiedTableIds.has(t.id));

  // 构建知识图谱数据 - 三层结构：主题(中心) -> 表(内圈) -> 字段(外圈)
  const buildGraphData = () => {
    const graphNodes: any[] = [];
    const graphEdges: any[] = [];

    // 画布中心
    const centerX = 400;
    const centerY = 300;

    // 获取字段节点（属于各个表的COLUMN）
    const columnNodes = nodes.filter((n) => n.type === 'COLUMN' && n.status === 'ACTIVE');

    // 构建 table -> columns 的映射
    const tableColumnMap = new Map<string, GraphNode[]>();
    columnNodes.forEach((col) => {
      const parentId = col.properties?.parentEntityId || col.parentEntityId;
      if (parentId) {
        const cols = tableColumnMap.get(parentId) || [];
        cols.push(col);
        tableColumnMap.set(parentId, cols);
      }
    });

    // 只处理有主题的表，无主题的表不显示
    const topicsWithTables = topicNodes.filter((topic) => {
      const tables = topicTableMap.get(topic.id) || [];
      return tables.length > 0;
    });

    if (topicsWithTables.length === 0) {
      return { nodes: [], edges: [] };
    }

    // 多个主题横向排列，单个主题居中
    const topicPositions: { topic: GraphNode; x: number; y: number; tables: GraphNode[] }[] = [];

    if (topicsWithTables.length === 1) {
      // 单个主题：居中
      const topic = topicsWithTables[0];
      const tables = topicTableMap.get(topic.id) || [];
      topicPositions.push({ topic, x: centerX, y: centerY, tables });
    } else {
      // 多个主题：横向排列
      const topicSpacing = 350;
      const totalWidth = topicsWithTables.length * topicSpacing;
      const startX = centerX - totalWidth / 2 + topicSpacing / 2;

      topicsWithTables.forEach((topic, topicIndex) => {
        const tables = topicTableMap.get(topic.id) || [];
        topicPositions.push({
          topic,
          x: startX + topicIndex * topicSpacing,
          y: 150,
          tables,
        });
      });
    }

    // 添加主题节点
    topicPositions.forEach(({ topic, x, y }) => {
      graphNodes.push({
        id: topic.id,
        label: topic.displayName || topic.name,
        type: 'topic-node',
        size: 120,
        x,
        y,
        style: { fill: '#ff7a45', stroke: '#ff7a45' },
        description: topic.description,
        nodeType: 'TOPIC',
      });
    });

    // 添加表节点（第一层圈）和字段节点（第二层圈）
    topicPositions.forEach(({ topic, x, y, tables }) => {
      const tableRadius = 160;
      const columnRadius = 280;

      tables.forEach((table, tableIndex) => {
        // 表在内圈围绕主题排列
        const tableAngle = (2 * Math.PI * tableIndex) / tables.length - Math.PI / 2;
        const tableX = x + tableRadius * Math.cos(tableAngle);
        const tableY = y + tableRadius * Math.sin(tableAngle);

        graphNodes.push({
          id: table.id,
          label: table.displayName || table.name,
          type: 'table-node',
          size: 90,
          x: tableX,
          y: tableY,
          style: { fill: '#1890ff', stroke: '#1890ff' },
          description: table.description,
          nodeType: 'TABLE',
        });

        // 主题到表的边
        graphEdges.push({
          source: topic.id,
          target: table.id,
          type: 'topic-table-edge',
          style: { stroke: '#ffd591', lineWidth: 2, opacity: 0.8 },
        });

        // 添加字段节点（第二层圈）
        const columns = tableColumnMap.get(table.id) || [];
        if (columns.length > 0) {
          // 字段围绕表排列
          const columnCount = columns.length;
          const columnArcSpan = Math.PI * 0.8; // 字段分布的弧度范围
          const columnStartAngle = tableAngle - columnArcSpan / 2;

          columns.forEach((col, colIndex) => {
            const colAngle = columnStartAngle + (columnArcSpan * colIndex) / Math.max(columnCount - 1, 1);
            const colX = tableX + columnRadius * Math.cos(colAngle);
            const colY = tableY + columnRadius * Math.sin(colAngle);

            graphNodes.push({
              id: col.id,
              label: col.displayName || col.name,
              type: 'column-node',
              size: 70,
              x: colX,
              y: colY,
              style: { fill: '#52c41a', stroke: '#52c41a' },
              description: col.description,
              nodeType: 'COLUMN',
            });

            // 表到字段的边
            graphEdges.push({
              source: table.id,
              target: col.id,
              type: 'table-column-edge',
              style: { stroke: '#b7eb8f', lineWidth: 1, opacity: 0.6 },
            });
          });
        }
      });
    });

    return { nodes: graphNodes, edges: graphEdges };
  };

  // 初始化G6图
  useEffect(() => {
    if (viewMode !== 'graph' || !graphContainerRef.current) return;

    // 销毁已有图实例
    if (graphRef.current) {
      graphRef.current.destroy();
      graphRef.current = null;
    }

    const graphData = buildGraphData();
    if (graphData.nodes.length === 0) return;

    // 注册主题节点
    G6.registerNode('topic-node', {
      draw(cfg: any, group: any) {
        const size = cfg.size || 120;
        // 背景
        group.addShape('rect', {
          attrs: {
            x: -size / 2,
            y: -size / 3,
            width: size,
            height: size / 1.5,
            fill: cfg.style?.fill || '#ff7a45',
            stroke: cfg.style?.stroke || '#ff7a45',
            radius: 8,
            shadowColor: 'rgba(0,0,0,0.1)',
            shadowBlur: 10,
            shadowOffsetY: 4,
          },
          name: 'background',
        });
        // 图标
        group.addShape('text', {
          attrs: {
            x: 0,
            y: -size / 5,
            text: '🏛',
            fontSize: 20,
            textAlign: 'center',
            textBaseline: 'middle',
          },
          name: 'icon',
        });
        // 标签
        group.addShape('text', {
          attrs: {
            x: 0,
            y: size / 8,
            text: cfg.label,
            fontSize: 12,
            fontWeight: 600,
            fill: '#fff',
            textAlign: 'center',
            textBaseline: 'middle',
          },
          name: 'label',
        });
        return group;
      },
      setState(name: string, value: boolean, item: any) {
        const group = item.getContainer();
        const background = group.find((e: any) => e.get('name') === 'background');
        if (name === 'hover') {
          background.animate(
            { shadowBlur: 20, shadowOffsetY: 8 },
            { duration: 200 }
          );
        }
      },
    });

    // 注册表节点
    G6.registerNode('table-node', {
      draw(cfg: any, group: any) {
        const size = cfg.size || 100;
        // 背景
        group.addShape('rect', {
          attrs: {
            x: -size / 2,
            y: -size / 3,
            width: size,
            height: size / 1.5,
            fill: cfg.style?.fill || '#1890ff',
            stroke: cfg.style?.stroke || '#1890ff',
            radius: 6,
            shadowColor: 'rgba(0,0,0,0.1)',
            shadowBlur: 8,
            shadowOffsetY: 3,
          },
          name: 'background',
        });
        // 图标
        group.addShape('text', {
          attrs: {
            x: 0,
            y: -size / 5,
            text: '📊',
            fontSize: 16,
            textAlign: 'center',
            textBaseline: 'middle',
          },
          name: 'icon',
        });
        // 标签
        group.addShape('text', {
          attrs: {
            x: 0,
            y: size / 8,
            text: cfg.label,
            fontSize: 11,
            fill: '#fff',
            textAlign: 'center',
            textBaseline: 'middle',
          },
          name: 'label',
        });
        return group;
      },
    });

    // 注册字段节点
    G6.registerNode('column-node', {
      draw(cfg: any, group: any) {
        const size = cfg.size || 70;
        // 圆角矩形背景
        group.addShape('rect', {
          attrs: {
            x: -size / 2,
            y: -size / 2.5,
            width: size,
            height: size / 1.25,
            fill: cfg.style?.fill || '#52c41a',
            stroke: cfg.style?.stroke || '#52c41a',
            radius: 4,
            shadowColor: 'rgba(0,0,0,0.08)',
            shadowBlur: 6,
            shadowOffsetY: 2,
          },
          name: 'background',
        });
        // 标签
        group.addShape('text', {
          attrs: {
            x: 0,
            y: 0,
            text: cfg.label,
            fontSize: 10,
            fill: '#fff',
            textAlign: 'center',
            textBaseline: 'middle',
          },
          name: 'label',
        });
        return group;
      },
    });

    // 注册主题到表的边
    G6.registerEdge('topic-table-edge', {
      draw(cfg: any, group: any) {
        const { startPoint, endPoint } = cfg;
        const path = [
          ['M', startPoint.x, startPoint.y],
          ['L', endPoint.x, endPoint.y],
        ];

        const line = group.addShape('path', {
          attrs: {
            path,
            stroke: cfg.style?.stroke || '#ffd591',
            lineWidth: cfg.style?.lineWidth || 2,
            opacity: cfg.style?.opacity || 0.8,
          },
          name: 'edge-path',
        });
        return line;
      },
    });

    // 注册表到字段的边
    G6.registerEdge('table-column-edge', {
      draw(cfg: any, group: any) {
        const { startPoint, endPoint } = cfg;
        const path = [
          ['M', startPoint.x, startPoint.y],
          ['L', endPoint.x, endPoint.y],
        ];

        const line = group.addShape('path', {
          attrs: {
            path,
            stroke: cfg.style?.stroke || '#b7eb8f',
            lineWidth: cfg.style?.lineWidth || 1,
            opacity: cfg.style?.opacity || 0.6,
          },
          name: 'edge-path',
        });
        return line;
      },
    });

    const graph = new G6.Graph({
      container: graphContainerRef.current,
      width: graphContainerRef.current.offsetWidth || 800,
      height: graphContainerRef.current.offsetHeight || 600,
      modes: {
        default: ['drag-canvas', 'zoom-canvas', 'drag-node'],
      },
      defaultNode: {
        type: 'rect',
      },
      defaultEdge: {
        type: 'topic-table-edge',
      },
      layout: {
        type: 'preset',
      },
      animate: true,
    });

    graph.data(graphData);
    graph.render();

    // 点击节点
    graph.on('node:click', (evt: any) => {
      const nodeData = evt.item.getModel();
      const node = nodes.find((n) => n.id === nodeData.id);
      if (node) {
        handleNodeClick(node);
      }
    });

    graph.on('canvas:click', () => {
      setShowDrawer(false);
    });

    graphRef.current = graph;

    return () => {
      if (graphRef.current) {
        graphRef.current.destroy();
        graphRef.current = null;
      }
    };
  }, [viewMode, nodes, topicNodes, topicTableMap, unclassifiedTables]);

  const fetchNeighborData = async (entityId: string) => {
    try {
      const resp = await getEntityNeighbors(entityId, 2);
      if (resp.success && resp.data) {
        setNeighborData({
          nodes: resp.data.neighborNodes || [],
          edges: resp.data.edges || [],
        });
      }
    } catch (error) {
      console.error('Failed to fetch neighbor data:', error);
    }
  };

  const handleNodeClick = (node: GraphNode) => {
    onNodeClick(node);
    setShowDrawer(true);
    fetchNeighborData(node.id);
  };

  const getTypeTagColor = (type: string) => {
    switch (type) {
      case 'TABLE':
        return 'blue';
      case 'COLUMN':
        return 'green';
      case 'TOPIC':
        return 'orange';
      default:
        return 'default';
    }
  };

  if (nodes.length === 0 && !loading) {
    return (
      <div style={{ padding: 50, textAlign: 'center' }}>
        <Text type="secondary">暂无实体数据，请先在知识库中添加表结构</Text>
      </div>
    );
  }

  return (
    <div>
      <div style={{ marginBottom: 16, display: 'flex', justifyContent: 'space-between' }}>
        <Space>
          <Button icon={<ReloadOutlined />} onClick={onRefresh} loading={loading}>
            刷新
          </Button>
        </Space>
        <Segmented
          value={viewMode}
          onChange={(value) => setViewMode(value as 'card' | 'graph')}
          options={[
            {
              value: 'card',
              icon: <ApartmentOutlined />,
              label: '卡片视图',
            },
            {
              value: 'graph',
              icon: <NodeIndexOutlined />,
              label: '知识图谱',
            },
          ]}
        />
      </div>

      {loading ? (
        <div style={{ padding: 100, textAlign: 'center' }}>
          <Spin size="large" />
        </div>
      ) : viewMode === 'graph' ? (
        <div>
          <div
            ref={graphContainerRef}
            style={{
              width: '100%',
              height: 600,
              background: '#fafafa',
              borderRadius: 8,
              border: '1px solid #e8e8e8',
            }}
          />
          <div style={{ marginTop: 12, padding: 8, background: '#f5f5f5', borderRadius: 4 }}>
            <Space split={<span style={{ color: '#d9d9d9' }}>|</span>}>
              <Text>
                <Tag color="orange">主题</Tag> {topicNodes.length}
              </Text>
              <Text>
                <Tag color="blue">表</Tag> {tableNodes.length}
              </Text>
              <Text type="secondary" style={{ fontSize: 12 }}>
                拖拽节点可调整位置，滚轮缩放画布
              </Text>
            </Space>
          </div>
        </div>
      ) : (
        <div style={{ maxHeight: 600, overflow: 'auto' }}>
          {/* 按主题分组展示 */}
          <Row gutter={[16, 16]}>
            {/* 未分类的表 */}
            {unclassifiedTables.length > 0 && (
              <Col span={24}>
                <Card
                  size="small"
                  title={
                    <Space>
                      <TableOutlined style={{ color: '#1890ff' }} />
                      <Text>未分类表</Text>
                      <Tag>{unclassifiedTables.length}</Tag>
                    </Space>
                  }
                >
                  <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
                    {unclassifiedTables.map((table) => (
                      <Tag
                        key={table.id}
                        color="blue"
                        style={{ padding: '4px 12px', cursor: 'pointer' }}
                        onClick={() => handleNodeClick(table)}
                      >
                        {table.displayName || table.name}
                      </Tag>
                    ))}
                  </div>
                </Card>
              </Col>
            )}

            {/* 按主题分组 */}
            {topicNodes.map((topic) => {
              const tables = topicTableMap.get(topic.id) || [];
              if (tables.length === 0) return null;

              return (
                <Col span={24} key={topic.id}>
                  <Card
                    size="small"
                    title={
                      <Space>
                        <Tag color="orange">TOPIC</Tag>
                        <Text strong>{topic.displayName || topic.name}</Text>
                        {topic.description && (
                          <Text type="secondary">- {topic.description}</Text>
                        )}
                        <Tag>{tables.length} 个表</Tag>
                      </Space>
                    }
                  >
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: 8 }}>
                      {tables.map((table) => (
                        <Tag
                          key={table.id}
                          color="blue"
                          style={{ padding: '4px 12px', cursor: 'pointer' }}
                          onClick={() => handleNodeClick(table)}
                        >
                          <Space>
                            <TableOutlined />
                            {table.displayName || table.name}
                          </Space>
                        </Tag>
                      ))}
                    </div>
                  </Card>
                </Col>
              );
            })}
          </Row>

          {/* 统计信息 */}
          <div style={{ marginTop: 16, padding: 12, background: '#f5f5f5', borderRadius: 4 }}>
            <Space split={<span style={{ color: '#d9d9d9' }}>|</span>}>
              <Text>
                <Tag color="orange">主题</Tag> {topicNodes.length}
              </Text>
              <Text>
                <Tag color="blue">表</Tag> {tableNodes.length}
              </Text>
            </Space>
          </div>
        </div>
      )}

      <Drawer
        title={selectedNode ? `表详情: ${selectedNode.displayName || selectedNode.name}` : '表详情'}
        placement="right"
        width={500}
        open={showDrawer}
        onClose={() => setShowDrawer(false)}
      >
        {selectedNode && (
          <Descriptions column={1} bordered size="small">
            <Descriptions.Item label="实体ID">{selectedNode.id}</Descriptions.Item>
            <Descriptions.Item label="名称">{selectedNode.name}</Descriptions.Item>
            <Descriptions.Item label="显示名称">{selectedNode.displayName || '-'}</Descriptions.Item>
            <Descriptions.Item label="类型">
              <Tag color={getTypeTagColor(selectedNode.type)}>{selectedNode.type}</Tag>
            </Descriptions.Item>
            <Descriptions.Item label="描述">{selectedNode.description || '暂无描述'}</Descriptions.Item>
          </Descriptions>
        )}

        {neighborData && neighborData.nodes.length > 0 && (
          <div style={{ marginTop: 24 }}>
            <h4>关联字段</h4>
            <div style={{ maxHeight: 300, overflow: 'auto' }}>
              {neighborData.nodes
                .filter((n) => n.type === 'COLUMN')
                .map((node) => (
                  <div
                    key={node.id}
                    style={{
                      padding: 8,
                      marginBottom: 8,
                      border: '1px solid #d9d9d9',
                      borderRadius: 4,
                    }}
                  >
                    <Tag color="green">{node.type}</Tag>
                    <span style={{ marginLeft: 8 }}>{node.displayName || node.name}</span>
                    {node.properties?.columnType && (
                      <Tag style={{ marginLeft: 8 }}>{node.properties.columnType}</Tag>
                    )}
                    {node.description && (
                      <p style={{ margin: '4px 0 0 0', fontSize: 12, color: '#666' }}>
                        {node.description}
                      </p>
                    )}
                  </div>
                ))}
            </div>
          </div>
        )}
      </Drawer>
    </div>
  );
};

export default EntityGraph;
