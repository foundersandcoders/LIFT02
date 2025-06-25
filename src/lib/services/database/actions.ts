import { supabase } from '$lib/services/supabaseClient';
import type {
	Database,
	FilterOptions,
	QueryOptions,
	DbResult as Result,
	DbResultMany as Results
} from './types';
import { filterLatestActions } from '$lib/utils/versionFilter';
import type { Action } from '$lib/types/tableMain';
type ActionInsert = Database['public']['Tables']['actions']['Insert'];
type ActionUpdate = Database['public']['Tables']['actions']['Update'];

/**
 * Get all actions for a user with optional filtering
 */
export async function getUserActions(
	userId: string,
	options?: QueryOptions & FilterOptions
): Results<Action> {
	let query = supabase.from('actions').select('*').eq('user_id', userId);

	if (options?.status) {
		query = query.eq('status', options.status);
	}

	if (options?.orderBy) {
		query = query.order(options.orderBy.column, {
			ascending: options.orderBy.ascending ?? true
		});
	}

	if (options?.limit) {
		query = query.limit(options.limit);
	}

	if (options?.offset) {
		query = query.range(options.offset, options.offset + (options.limit ?? 10) - 1);
	}

	const { data, error } = await query;

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types
	const convertedData =
		data?.map((dbAction) => ({
			id: dbAction.id,
			user_id: dbAction.user_id || '',
			response_id: dbAction.response_id || undefined,
			type: dbAction.type,
			description: dbAction.description || undefined,
			version: dbAction.version || 1,
			status: dbAction.status as 'draft' | 'active' | 'archived',
			created_at: dbAction.created_at || undefined,
			updated_at: dbAction.updated_at || undefined
		})) || null;

	return { data: convertedData, error: null };
}

/**
 * Get a single action by ID

 */
export async function getActionById(id: string): Result<Action> {
	const { data, error } = await supabase.from('actions').select('*').eq('id', id).single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = data
		? {
				id: data.id,
				user_id: data.user_id || '',
				response_id: data.response_id || undefined,
				type: data.type,
				description: data.description || undefined,
				version: data.version || 1,
				status: data.status as 'draft' | 'active' | 'archived',
				created_at: data.created_at || undefined,
				updated_at: data.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get action history for a specific response
 */
export async function getActionHistory(userId: string, responseId: string): Results<Action> {
	const { data, error } = await supabase
		.from('actions')
		.select('*')
		.eq('user_id', userId)
		.eq('response_id', responseId)
		.order('version', { ascending: false });

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types
	const convertedData =
		data?.map((dbAction) => ({
			id: dbAction.id,
			user_id: dbAction.user_id || '',
			response_id: dbAction.response_id || undefined,
			type: dbAction.type,
			description: dbAction.description || undefined,
			version: dbAction.version || 1,
			status: dbAction.status as 'draft' | 'active' | 'archived',
			created_at: dbAction.created_at || undefined,
			updated_at: dbAction.updated_at || undefined
		})) || null;

	return { data: convertedData, error: null };
}

/**
 * Create a new action
 */
export async function createAction(
	userId: string,
	data: Omit<ActionInsert, 'user_id' | 'version' | 'status'>
): Result<Action> {
	const { data: action, error } = await supabase
		.from('actions')
		.insert([
			{
				...data,
				user_id: userId,
				version: 1,
				status: 'active'
			}
		])
		.select()
		.single();

	if (error) {
		console.error(error);
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = action
		? {
				id: action.id,
				user_id: action.user_id || '',
				response_id: action.response_id || undefined,
				type: action.type,
				description: action.description || undefined,
				version: action.version || 1,
				status: action.status as 'draft' | 'active' | 'archived',
				created_at: action.created_at || undefined,
				updated_at: action.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Update an existing action
 */
export async function updateAction(
	id: string,
	data: Omit<ActionUpdate, 'version' | 'status'>
): Result<Action> {
	// First, get the current action to get its version
	const { data: currentAction, error: fetchError } = await supabase
		.from('actions')
		.select('*')
		.eq('id', id)
		.single();

	if (fetchError) {
		return { data: null, error: fetchError };
	}

	// Create a new version
	const { data: newAction, error: insertError } = await supabase
		.from('actions')
		.insert([
			{
				...currentAction,
				...data,
				id: undefined, // Let Supabase generate a new ID
				version: currentAction.version + 1,
				status: currentAction.status // Preserve the status
			}
		])
		.select()
		.single();

	if (insertError) {
		return { data: null, error: insertError };
	}

	// Convert database type to tableMain type
	const convertedData = newAction
		? {
				id: newAction.id,
				user_id: newAction.user_id || '',
				response_id: newAction.response_id || undefined,
				type: newAction.type,
				description: newAction.description || undefined,
				version: newAction.version || 1,
				status: newAction.status as 'draft' | 'active' | 'archived',
				created_at: newAction.created_at || undefined,
				updated_at: newAction.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Archive an action
 */
export async function archiveAction(id: string): Result<Action> {
	// First, get the current action
	const { data: currentAction, error: fetchError } = await supabase
		.from('actions')
		.select('*')
		.eq('id', id)
		.single();

	if (fetchError) {
		return { data: null, error: fetchError };
	}

	// Create a new version with archived status
	const { data: newAction, error: insertError } = await supabase
		.from('actions')
		.insert([
			{
				...currentAction,
				id: undefined, // Let Supabase generate a new ID
				version: currentAction.version + 1,
				status: 'archived'
			}
		])
		.select()
		.single();

	if (insertError) {
		return { data: null, error: insertError };
	}

	// Convert database type to tableMain type
	const convertedData = newAction
		? {
				id: newAction.id,
				user_id: newAction.user_id || '',
				response_id: newAction.response_id || undefined,
				type: newAction.type,
				description: newAction.description || undefined,
				version: newAction.version || 1,
				status: newAction.status as 'draft' | 'active' | 'archived',
				created_at: newAction.created_at || undefined,
				updated_at: newAction.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get latest actions for a user
 */
export async function getLatestActions(userId: string): Results<Action> {
	const { data, error } = await supabase
		.from('actions')
		.select('*')
		.eq('user_id', userId)
		.order('created_at', { ascending: false });

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types
	const convertedData =
		data?.map((dbAction) => ({
			id: dbAction.id,
			user_id: dbAction.user_id || '',
			response_id: dbAction.response_id || undefined,
			type: dbAction.type,
			description: dbAction.description || undefined,
			version: dbAction.version || 1,
			status: dbAction.status as 'draft' | 'active' | 'archived',
			created_at: dbAction.created_at || undefined,
			updated_at: dbAction.updated_at || undefined
		})) || null;

	// Use utility function to get latest versions
	const latestActions = filterLatestActions(convertedData || []);

	return { data: latestActions, error: null };
}

/**
 * Get actions for multiple responses in a single query
 */
export async function getActionsByResponseIds(responseIds: string[]): Results<Action> {
	if (responseIds.length === 0) {
		return { data: [], error: null };
	}

	const { data, error } = await supabase
		.from('actions')
		.select('*')
		.in('response_id', responseIds)
		.order('version', { ascending: false });

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types
	const convertedData = data?.map((dbAction) => ({
		id: dbAction.id,
		user_id: dbAction.user_id || '',
		response_id: dbAction.response_id || undefined,
		type: dbAction.type,
		description: dbAction.description || undefined,
		version: dbAction.version || 1,
		status: dbAction.status as 'draft' | 'active' | 'archived',
		created_at: dbAction.created_at || undefined,
		updated_at: dbAction.updated_at || undefined
	})) || [];

	return { data: convertedData, error: null };
}

/**
 * Get the latest action for a specific response
 * 
 * Note: This function uses database-level filtering (.limit(1)) for efficiency
 * instead of the filterLatestActions utility. This is intentional for single-item
 * queries where database filtering is more performant than client-side filtering.
 * For batch operations, use getActionsByResponseIds + filterLatestActions instead.
 */
export async function getLatestActionByResponseId(responseId: string): Result<Action> {
	const { data, error } = await supabase
		.from('actions')
		.select('*')
		.eq('response_id', responseId)
		.order('version', { ascending: false })
		.limit(1); // Database-level filtering for efficiency

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type (single action)
	const convertedData = data && data.length > 0 
		? {
			id: data[0].id,
			user_id: data[0].user_id || '',
			response_id: data[0].response_id || undefined,
			type: data[0].type,
			description: data[0].description || undefined,
			version: data[0].version || 1,
			status: data[0].status as 'draft' | 'active' | 'archived',
			created_at: data[0].created_at || undefined,
			updated_at: data[0].updated_at || undefined
		}
		: null;

	return { data: convertedData, error: null };
}
