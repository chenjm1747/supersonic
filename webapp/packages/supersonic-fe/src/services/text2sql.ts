import request from 'umi-request';

export type DatabaseType = 'MYSQL' | 'POSTGRESQL' | 'ORACLE' | 'SQLSERVER' | 'SQLITE';

export interface TableSchema {
  tableName: string;
  tableComment: string;
  columnCount: number;
  columns: ColumnSchema[];
}

export interface ColumnSchema {
  columnName: string;
  columnType: string;
  columnComment: string;
  isPrimaryKey: boolean;
  isForeignKey: boolean;
  fkReference?: string;
}

export interface SchemaKnowledge {
  id: number;
  tableName: string;
  tableComment: string;
  columnName: string;
  columnComment: string;
  columnType: string;
  isPrimaryKey: boolean;
  isForeignKey: boolean;
  fkReference?: string;
  similarity?: number;
}

export interface KnowledgeBuildReq {
  sqlFilePath?: string;
  databaseType: DatabaseType;
  targetTables: string[];
  sqlContent?: string;
}

export interface KnowledgeBuildResp {
  success: boolean;
  knowledgeCount: number;
  message: string;
}

export interface ParseSqlReq {
  sqlFilePath?: string;
  databaseType: DatabaseType;
  sqlContent?: string;
}

export interface ParseSqlResp {
  success: boolean;
  message: string;
  tables: TableSchema[];
  databaseType?: DatabaseType;
}

export interface SearchKnowledgeReq {
  query: string;
  topK?: number;
}

export interface SearchKnowledgeResp {
  success: boolean;
  message: string;
  results: SchemaKnowledge[];
}

export interface KnowledgeStats {
  tableCount: number;
  columnCount: number;
  lastUpdate: string;
}

export interface KnowledgeStatsResp {
  success: boolean;
  message: string;
  stats: {
    table_count: number;
    column_count: number;
    last_update: string;
  };
}

export interface BaseResp {
  success: boolean;
  message: string;
}

export async function parseSqlFile(
  sqlFilePath: string,
  databaseType: DatabaseType = 'MYSQL',
  sqlContent?: string
): Promise<ParseSqlResp> {
  return request('/api/text2sql/parse', {
    method: 'POST',
    data: { sqlFilePath, databaseType, sqlContent },
  });
}

export async function buildKnowledge(params: KnowledgeBuildReq): Promise<KnowledgeBuildResp> {
  return request('/api/text2sql/knowledge/build', {
    method: 'POST',
    data: params,
  });
}

export async function searchKnowledge(params: SearchKnowledgeReq): Promise<SearchKnowledgeResp> {
  return request('/api/text2sql/knowledge/search', {
    method: 'POST',
    data: params,
  });
}

export async function getKnowledgeStats(): Promise<KnowledgeStatsResp> {
  return request('/api/text2sql/knowledge/stats', {
    method: 'GET',
  });
}

export async function clearKnowledge(): Promise<BaseResp> {
  return request('/api/text2sql/knowledge/clear', {
    method: 'DELETE',
  });
}

export async function deleteEntity(entityId: string): Promise<BaseResp> {
  return request(`/api/wiki/entities/${entityId}`, {
    method: 'DELETE',
  });
}
