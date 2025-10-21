import { supabase } from '$lib/services/supabaseClient';
import type { Action } from '$lib/types/tableMain';
import type {
	Database,
	FilterOptions,
	QueryOptions,
	DbResult as Result,
	DbResultMany as Results
} from './types';
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
			status: dbAction.status as 'active' | 'archived',
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
				status: data.status as 'active' | 'archived',
				created_at: data.created_at || undefined,
				updated_at: data.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get actions for a specific response
 */
export async function getActionsByResponseId(userId: string, responseId: string): Results<Action> {
	const { data, error } = await supabase
		.from('actions')
		.select('*')
		.eq('user_id', userId)
		.eq('response_id', responseId)
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
			status: dbAction.status as 'active' | 'archived',
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
	data: Omit<ActionInsert, 'user_id' | 'status'>
): Result<Action> {
	const { data: action, error } = await supabase
		.from('actions')
		.insert([
			{
				...data,
				user_id: userId,
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
				status: action.status as 'active' | 'archived',
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
	data: Omit<ActionUpdate, 'status'>
): Result<Action> {
	const { data: updatedAction, error } = await supabase
		.from('actions')
		.update({
			...data,
			updated_at: new Date().toISOString()
		})
		.eq('id', id)
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = updatedAction
		? {
				id: updatedAction.id,
				user_id: updatedAction.user_id || '',
				response_id: updatedAction.response_id || undefined,
				type: updatedAction.type,
				description: updatedAction.description || undefined,
				status: updatedAction.status as 'active' | 'archived',
				created_at: updatedAction.created_at || undefined,
				updated_at: updatedAction.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Archive an action (set status to 'archived')
 */
export async function archiveAction(id: string): Result<Action> {
	return updateActionStatus(id, 'archived');
}

/**
 * Activate an action (set status to 'active')
 */
export async function activateAction(id: string): Result<Action> {
	return updateActionStatus(id, 'active');
}

/**
 * Update an action's status
 */
export async function updateActionStatus(
	id: string,
	newStatus: 'active' | 'archived'
): Result<Action> {
	const { data: updatedAction, error } = await supabase
		.from('actions')
		.update({
			status: newStatus,
			updated_at: new Date().toISOString()
		})
		.eq('id', id)
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = updatedAction
		? {
				id: updatedAction.id,
				user_id: updatedAction.user_id || '',
				response_id: updatedAction.response_id || undefined,
				type: updatedAction.type,
				description: updatedAction.description || undefined,
				status: updatedAction.status as 'active' | 'archived',
				created_at: updatedAction.created_at || undefined,
				updated_at: updatedAction.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get latest actions for a user
 */
export async function getLatestActions(
	userId: string,
	includeArchived: boolean = false
): Results<Action> {
	let query = supabase
		.from('actions')
		.select('*, responses!inner(question_id, questions!inner(preview))')
		.eq('user_id', userId);

	if (!includeArchived) {
		query = query.eq('status', 'active');
	}

	const { data, error } = await query.order('created_at', { ascending: false });

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
			status: dbAction.status as 'active' | 'archived',
			created_at: dbAction.created_at || undefined,
			updated_at: dbAction.updated_at || undefined,
			question_id: dbAction.responses?.question_id || '',
			question_preview: dbAction.responses?.questions?.preview || undefined
		})) || null;

	// Return all actions without filtering
	return { data: convertedData || [], error: null };
}

/**
 * Delete an action
 */
export async function deleteAction(id: string): Result<boolean> {
	const { error } = await supabase
		.from('actions')
		.delete()
		.eq('id', id);

	if (error) {
		return { data: null, error };
	}

	return { data: true, error: null };
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
		.eq('status', 'active')
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
			status: dbAction.status as 'active' | 'archived',
			created_at: dbAction.created_at || undefined,
			updated_at: dbAction.updated_at || undefined
		})) || [];

	return { data: convertedData, error: null };
}

/**
 * Get the first active action for a specific response
 */
export async function getFirstActiveActionByResponseId(responseId: string): Result<Action> {
	const { data, error } = await supabase
		.from('actions')
		.select('*')
		.eq('response_id', responseId)
		.eq('status', 'active')
		.order('created_at', { ascending: true })
		.limit(1);

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type (single action)
	const convertedData =
		data && data.length > 0
			? {
					id: data[0].id,
					user_id: data[0].user_id || '',
					response_id: data[0].response_id || undefined,
					type: data[0].type,
					description: data[0].description || undefined,
					status: data[0].status as 'active' | 'archived',
					created_at: data[0].created_at || undefined,
					updated_at: data[0].updated_at || undefined
				}
			: null;

	return { data: convertedData, error: null };
}

