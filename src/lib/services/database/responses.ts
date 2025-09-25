import { supabase } from '$lib/services/supabaseClient';
import type { Response } from '$lib/types/tableMain';
import type {
	Database,
	FilterOptions,
	QueryOptions,
	DbResult as Result,
	DbResultMany as Results
} from './types';
type ResponseInsert = Database['public']['Tables']['responses']['Insert'];
type ResponseUpdate = Database['public']['Tables']['responses']['Update'];

/**
 * Get all responses for a user with optional filtering
 */
export async function getUserResponses(
	userId: string,
	options?: QueryOptions & FilterOptions
): Results<Response> {
	let query = supabase.from('responses').select('*').eq('user_id', userId);

	if (options?.visibility) {
		query = query.eq('visibility', options.visibility);
	}

	if (options?.orderBy) {
		query = query.order(options.orderBy.column, {
			ascending: options.orderBy.ascending ?? true
		});
	}

	// Execute the query first
	const { data, error } = await query;

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types
	let convertedData =
		data?.map((dbResponse) => ({
			id: dbResponse.id,
			user_id: dbResponse.user_id || '',
			question_id: dbResponse.question_id || '',
			response_text: dbResponse.response_text || undefined,
			status: dbResponse.status as 'answered' | 'skipped',
			visibility: dbResponse.visibility as 'public' | 'private',
			created_at: dbResponse.created_at || undefined,
			updated_at: dbResponse.updated_at || undefined
		})) || [];

	// Apply limit and offset after filtering
	if (options?.offset || options?.limit) {
		const offset = options.offset || 0;
		const limit = options.limit || 10;
		convertedData = convertedData.slice(offset, offset + limit);
	}

	return { data: convertedData, error: null };
}

/**
 * Get a single response by ID
 */
export async function getResponseById(id: string): Result<Response> {
	const { data, error } = await supabase.from('responses').select('*').eq('id', id).single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = data
		? {
				id: data.id,
				user_id: data.user_id || '',
				question_id: data.question_id || '',
				response_text: data.response_text || undefined,
				status: data.status as 'answered' | 'skipped',
				visibility: data.visibility as 'public' | 'private',
				created_at: data.created_at || undefined,
				updated_at: data.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get user's response for a specific question
 */
export async function getUserResponse(userId: string, questionId: string): Results<Response> {
	const { data, error } = await supabase
		.from('responses')
		.select('*')
		.eq('user_id', userId)
		.eq('question_id', questionId)
		.order('created_at', { ascending: false });

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types
	const convertedData =
		data?.map((dbResponse) => ({
			id: dbResponse.id,
			user_id: dbResponse.user_id || '',
			question_id: dbResponse.question_id || '',
			response_text: dbResponse.response_text || undefined,
			status: dbResponse.status as 'answered' | 'skipped',
			visibility: dbResponse.visibility as 'public' | 'private',
			created_at: dbResponse.created_at || undefined,
			updated_at: dbResponse.updated_at || undefined
		})) || null;

	return { data: convertedData, error: null };
}

/**
 * Create a new response
 */
export async function createResponse(
	userId: string,
	data: Omit<ResponseInsert, 'user_id'>
): Result<Response> {
	const insertData = {
		...data,
		user_id: userId
	};

	const { data: response, error } = await supabase
		.from('responses')
		.insert([insertData])
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = response
		? {
				id: response.id,
				user_id: response.user_id || '',
				question_id: response.question_id || '',
				response_text: response.response_text || undefined,
				status: response.status as 'answered' | 'skipped',
				visibility: response.visibility as 'public' | 'private',
				created_at: response.created_at || undefined,
				updated_at: response.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Update an existing response (simple update, no versioning)
 */
export async function updateResponse(
	userId: string,
	questionId: string,
	data: Partial<Omit<ResponseInsert, 'user_id' | 'question_id'>>
): Result<Response> {
	// Update the response directly
	const { data: updatedResponse, error } = await supabase
		.from('responses')
		.update(data)
		.eq('user_id', userId)
		.eq('question_id', questionId)
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = updatedResponse
		? {
				id: updatedResponse.id,
				user_id: updatedResponse.user_id || '',
				question_id: updatedResponse.question_id || '',
				response_text: updatedResponse.response_text || undefined,
				status: updatedResponse.status as 'answered' | 'skipped',
				visibility: updatedResponse.visibility as 'public' | 'private',
				created_at: updatedResponse.created_at || undefined,
				updated_at: updatedResponse.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Create or update a response (upsert pattern)
 */
export async function upsertResponse(
	userId: string,
	questionId: string,
	data: Omit<ResponseInsert, 'user_id' | 'question_id'>
): Result<Response> {
	// Try to update first
	const updateResult = await updateResponse(userId, questionId, data);

	if (updateResult.data) {
		// Update succeeded
		return updateResult;
	}

	// Update failed, try to create
	const createResult = await createResponse(userId, {
		...data,
		question_id: questionId
	});

	return createResult;
}

/**
 * Skip a question
 */
export async function skipQuestion(userId: string, questionId: string): Result<Response> {
	const { data, error } = await supabase
		.from('responses')
		.insert([
			{
				user_id: userId,
				question_id: questionId,
				status: 'skipped',
				visibility: 'private'
			}
		])
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	// Convert database type to tableMain type
	const convertedData = data
		? {
				id: data.id,
				user_id: data.user_id || '',
				question_id: data.question_id || '',
				response_text: data.response_text || undefined,
				status: data.status as 'answered' | 'skipped',
				visibility: data.visibility as 'public' | 'private',
				created_at: data.created_at || undefined,
				updated_at: data.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get latest responses for a user
 */
export async function getLatestResponses(userId: string): Results<Response> {
	const { data, error } = await supabase
		.from('responses')
		.select('*')
		.eq('user_id', userId)
		.order('created_at', { ascending: false });

	if (error) {
		return { data: null, error };
	}

	// Convert database types to tableMain types first
	const convertedData =
		data?.map((dbResponse) => ({
			id: dbResponse.id,
			user_id: dbResponse.user_id || '',
			question_id: dbResponse.question_id || '',
			response_text: dbResponse.response_text || undefined,
			status: dbResponse.status as 'answered' | 'skipped',
			visibility: dbResponse.visibility as 'public' | 'private',
			created_at: dbResponse.created_at || undefined,
			updated_at: dbResponse.updated_at || undefined
		})) || [];

	// Since we no longer have versioning, all responses are already the latest
	const latestResponses = convertedData;

	return { data: latestResponses, error: null };
}
