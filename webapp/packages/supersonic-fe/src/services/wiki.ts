import { request } from 'umi';

export interface GraphNode {
  id: string;
  name: string;
  displayName: string;
  type: string;
  description: string;
  status?: string;
  topicId?: string;
  topicIds?: string[];
  properties?: Record<string, any>;
  depth?: number;
}

export interface GraphEdge {
  id: string;
  source: string;
  target: string;
  type: string;
  label: string;
  weight: number;
  bidirectional?: boolean;
}

export interface WikiEntity {
  id?: number;
  entityId: string;
  entityType: string;
  name: string;
  displayName?: string;
  description?: string;
  properties?: Record<string, any>;
  summary?: string;
  tags?: string[];
  version?: string;
  parentEntityId?: string;
  topicId?: string;
  topicIds?: string[];
  status?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface WikiKnowledgeCard {
  id?: number;
  cardId: string;
  entityId: string;
  cardType: string;
  title?: string;
  content: string;
  extractedFrom?: string[];
  confidence?: number;
  status?: string;
  tags?: string[];
  version?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface WikiLink {
  id?: number;
  sourceEntityId: string;
  targetEntityId: string;
  linkType: string;
  relation?: string;
  description?: string;
  bidirectional?: boolean;
  weight?: number;
  createdAt?: string;
}

export interface ApiResponse<T> {
  success: boolean;
  message: string;
  data?: T;
}

export const getGraphNodes = async (): Promise<ApiResponse<GraphNode[]>> => {
  return request('/api/wiki/graph/nodes', {
    method: 'GET',
  });
};

export const getGraphEdges = async (): Promise<ApiResponse<GraphEdge[]>> => {
  return request('/api/wiki/graph/edges', {
    method: 'GET',
  });
};

export const getEntityNeighbors = async (
  entityId: string,
  depth: number = 1,
): Promise<ApiResponse<{ centerNode: GraphNode; neighborNodes: GraphNode[]; edges: GraphEdge[] }>> => {
  return request(`/api/wiki/graph/entity/${entityId}/neighbors`, {
    method: 'GET',
    params: { depth },
  });
};

export const getEntities = async (
  type?: string,
  topicId?: string,
): Promise<ApiResponse<WikiEntity[]>> => {
  return request('/api/wiki/entities', {
    method: 'GET',
    params: { type, topicId },
  });
};

export const getEntity = async (entityId: string): Promise<ApiResponse<WikiEntity>> => {
  return request(`/api/wiki/entities/${entityId}`, {
    method: 'GET',
  });
};

export const createEntity = async (
  entity: WikiEntity,
): Promise<ApiResponse<WikiEntity>> => {
  return request('/api/wiki/entities', {
    method: 'POST',
    data: entity,
  });
};

export const updateEntity = async (
  entityId: string,
  entity: WikiEntity,
): Promise<ApiResponse<WikiEntity>> => {
  return request(`/api/wiki/entities/${entityId}`, {
    method: 'PUT',
    data: entity,
  });
};

export const deleteEntity = async (entityId: string): Promise<ApiResponse<void>> => {
  return request(`/api/wiki/entities/${entityId}`, {
    method: 'DELETE',
  });
};

export const addTopicToEntity = async (
  entityId: string,
  topicId: string,
): Promise<ApiResponse<void>> => {
  return request(`/api/wiki/entities/${entityId}/topics/${topicId}`, {
    method: 'POST',
  });
};

export const removeTopicFromEntity = async (
  entityId: string,
  topicId: string,
): Promise<ApiResponse<void>> => {
  return request(`/api/wiki/entities/${entityId}/topics/${topicId}`, {
    method: 'DELETE',
  });
};

export const getEntityTopics = async (
  entityId: string,
): Promise<ApiResponse<string[]>> => {
  return request(`/api/wiki/entities/${entityId}/topics`, {
    method: 'GET',
  });
};

export const getKnowledgeCards = async (
  entityId?: string,
  cardType?: string,
): Promise<ApiResponse<WikiKnowledgeCard[]>> => {
  return request('/api/wiki/knowledge', {
    method: 'GET',
    params: { entityId, cardType },
  });
};

export const getKnowledgeCard = async (
  cardId: string,
): Promise<ApiResponse<WikiKnowledgeCard>> => {
  return request(`/api/wiki/knowledge/${cardId}`, {
    method: 'GET',
  });
};

export const createKnowledgeCard = async (
  card: WikiKnowledgeCard,
): Promise<ApiResponse<WikiKnowledgeCard>> => {
  return request('/api/wiki/knowledge', {
    method: 'POST',
    data: card,
  });
};

export const updateKnowledgeCard = async (
  cardId: string,
  card: WikiKnowledgeCard,
): Promise<ApiResponse<WikiKnowledgeCard>> => {
  return request(`/api/wiki/knowledge/${cardId}`, {
    method: 'PUT',
    data: card,
  });
};

export const deleteKnowledgeCard = async (
  cardId: string,
): Promise<ApiResponse<void>> => {
  return request(`/api/wiki/knowledge/${cardId}`, {
    method: 'DELETE',
  });
};

export const getLinks = async (
  entityId?: string,
): Promise<ApiResponse<WikiLink[]>> => {
  return request('/api/wiki/links', {
    method: 'GET',
    params: { entityId },
  });
};

export const createLink = async (
  link: WikiLink,
): Promise<ApiResponse<WikiLink>> => {
  return request('/api/wiki/links', {
    method: 'POST',
    data: link,
  });
};

export interface Contradiction {
  id?: number;
  contradictionId: string;
  entityId: string;
  oldKnowledgeCardId?: string;
  conflictType: string;
  oldContent?: string;
  newEvidence?: string;
  evidenceSource?: string;
  impact?: string;
  resolution: string;
  resolvedAt?: string;
  resolvedBy?: string;
  resolutionNotes?: string;
  evidence?: Evidence;
  createdAt?: string;
  updatedAt?: string;
}

export interface Evidence {
  id?: number;
  evidenceId: string;
  contradictionId?: string;
  sourceEntityId?: string;
  evidenceType: string;
  content: string;
  source?: string;
  confidence?: number;
  impact?: string;
  resolution?: string;
  createdAt?: string;
}

export interface TopicSummary {
  id?: number;
  topicId: string;
  topicName: string;
  summary: string;
  memberEntities?: string[];
  relationships?: string[];
  metrics?: Record<string, any>;
  summaryVersion?: number;
  llmModel?: string;
  generatedAt?: string;
  status?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface ResolveReq {
  resolution: string;
  resolvedBy?: string;
  resolutionNotes?: string;
}

export const getContradictions = async (
  entityId?: string,
  status?: string,
): Promise<ApiResponse<Contradiction[]>> => {
  return request('/api/wiki/contradictions', {
    method: 'GET',
    params: { entityId, status },
  });
};

export const getPendingContradictions = async (): Promise<ApiResponse<Contradiction[]>> => {
  return request('/api/wiki/contradictions/pending', {
    method: 'GET',
  });
};

export const getContradiction = async (
  contradictionId: string,
): Promise<ApiResponse<Contradiction>> => {
  return request(`/api/wiki/contradictions/${contradictionId}`, {
    method: 'GET',
  });
};

export const createContradiction = async (
  contradiction: Contradiction,
): Promise<ApiResponse<Contradiction>> => {
  return request('/api/wiki/contradictions', {
    method: 'POST',
    data: contradiction,
  });
};

export const resolveContradiction = async (
  contradictionId: string,
  req: ResolveReq,
): Promise<ApiResponse<Contradiction>> => {
  return request(`/api/wiki/contradictions/${contradictionId}/resolve`, {
    method: 'POST',
    data: req,
  });
};

export const getSummaries = async (): Promise<ApiResponse<TopicSummary[]>> => {
  return request('/api/wiki/summaries', {
    method: 'GET',
  });
};

export const getSummary = async (
  topicId: string,
): Promise<ApiResponse<TopicSummary>> => {
  return request(`/api/wiki/summaries/${topicId}`, {
    method: 'GET',
  });
};

export const getSummaryHistory = async (
  topicId: string,
): Promise<ApiResponse<TopicSummary[]>> => {
  return request(`/api/wiki/summaries/${topicId}/history`, {
    method: 'GET',
  });
};

export const refreshSummary = async (
  topicId: string,
): Promise<ApiResponse<TopicSummary>> => {
  return request(`/api/wiki/summaries/${topicId}/refresh`, {
    method: 'POST',
  });
};

export const refreshAllSummaries = async (): Promise<ApiResponse<TopicSummary[]>> => {
  return request('/api/wiki/summaries/refresh-all', {
    method: 'POST',
  });
};

// ==================== Wiki Health APIs ====================

export interface WikiHealthReport {
  id?: number;
  reportId: string;
  reportType: string;
  status: string;
  summary: string;
  metrics?: Record<string, any>;
  issuesFound?: number;
  contradictionsDetected?: number;
  orphanEntities?: number;
  outdatedCards?: number;
  recommendations?: string[];
  generatedAt?: string;
  createdAt?: string;
  updatedAt?: string;
}

export interface HealthStats {
  pendingReports?: number;
  pendingContradictions?: number;
  orphanEntities?: number;
}

export interface ImportPreview {
  topicCount: number;
  tableCount: number;
  columnCount: number;
}

export interface ImportResult {
  successCount: number;
  failCount: number;
}

export const getHealthReports = async (
  limit: number = 10,
  offset: number = 0,
): Promise<ApiResponse<WikiHealthReport[]>> => {
  return request('/api/wiki/health/reports', {
    method: 'GET',
    params: { limit, offset },
  });
};

export const getHealthReportDetail = async (
  reportId: string,
): Promise<ApiResponse<WikiHealthReport>> => {
  return request(`/api/wiki/health/reports/${reportId}`, {
    method: 'GET',
  });
};

export const getHealthStats = async (): Promise<ApiResponse<HealthStats>> => {
  return request('/api/wiki/health/stats', {
    method: 'GET',
  });
};

export const triggerHealthCheck = async (
  type: string = 'FULL',
): Promise<ApiResponse<void>> => {
  return request('/api/wiki/health/trigger', {
    method: 'POST',
    params: { type },
  });
};

// ==================== Schema Import APIs ====================

export const getSchemaImportTemplate = async (): Promise<ApiResponse<string>> => {
  return request('/api/wiki/schema/template', {
    method: 'GET',
  });
};

export const validateSchemaScript = async (
  sqlScript: string,
): Promise<ApiResponse<ImportPreview>> => {
  return request('/api/wiki/schema/validate', {
    method: 'POST',
    data: sqlScript,
  });
};

export const executeSchemaImport = async (
  sqlScript: string,
): Promise<ApiResponse<ImportResult>> => {
  return request('/api/wiki/schema/import', {
    method: 'POST',
    data: sqlScript,
  });
};

export const autoGenerateKnowledge = async (
  entityId: string,
): Promise<ApiResponse<WikiKnowledgeCard[]>> => {
  return request(`/api/wiki/schema/auto-generate/${entityId}`, {
    method: 'POST',
  });
};

// ==================== Self Enhancement APIs ====================

export interface SelfEnhancementTrend {
  date: string;
  successCount: number;
  failureCount: number;
  totalQueries: number;
  successRate: number;
}

export interface KnowledgeCompoundingStats {
  totalCards: number;
  activeCards: number;
  supersededCards: number;
  recommendedCards: number;
  averageConfidence: number;
  topBoostedCards: WikiKnowledgeCard[];
  topPenalizedCards: WikiKnowledgeCard[];
  recentTrends: SelfEnhancementTrend[];
}

export const getCompoundingStats = async (): Promise<ApiResponse<KnowledgeCompoundingStats>> => {
  return request('/api/wiki/enhancement/stats', {
    method: 'GET',
  });
};

export const getEnhancementTrends = async (
  days: number = 7,
): Promise<ApiResponse<SelfEnhancementTrend[]>> => {
  return request('/api/wiki/enhancement/trends', {
    method: 'GET',
    params: { days },
  });
};
