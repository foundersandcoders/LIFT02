// Re-export commonly used types
export type { Database, Tables, TablesInsert, TablesUpdate } from '$lib/types/supabase';

// Common response types
export type DbResult<T> = Promise<{
	data: T | null;
	error: Error | null;
}>;

export type DbResultMany<T> = Promise<{
	data: T[] | null;
	error: Error | null;
}>;

// Common error types
export class DatabaseError extends Error {
	constructor(
		message: string,
		public code?: string
	) {
		super(message);
		this.name = 'DatabaseError';
	}
}

// Common query options
export interface QueryOptions {
	limit?: number;
	offset?: number;
	orderBy?: {
		column: string;
		ascending?: boolean;
	};
}

// Common filter options
export interface FilterOptions {
	status?: string;
	visibility?: 'public' | 'private';
	isLatest?: boolean;
}
