import { supabase } from '$lib/services/supabaseClient';
import type { Response } from '$lib/types/tableMain';
import { filterLatestResponses } from '$lib/utils/versionFilter';
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
			version: dbResponse.version || 1,
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
				version: data.version || 1,
				created_at: data.created_at || undefined,
				updated_at: data.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
}

/**
 * Get response history for a specific question
 */
export async function getResponseHistory(userId: string, questionId: string): Results<Response> {
	const { data, error } = await supabase
		.from('responses')
		.select('*')
		.eq('user_id', userId)
		.eq('question_id', questionId)
		.order('version', { ascending: false });

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
			version: dbResponse.version || 1,
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
	data: Omit<ResponseInsert, 'user_id' | 'version'>
): Result<Response> {
	console.groupCollapsed('🗄️ Database: createResponse');
	console.log('📥 Input parameters:', {
		userId,
		data
	});

	const insertData = {
		...data,
		user_id: userId,
		version: 1
	};

	console.log('📤 Sending to Supabase:', insertData);

	const { data: response, error } = await supabase
		.from('responses')
		.insert([insertData])
		.select()
		.single();

	if (error) {
		console.error('❌ Database error:', error);
		console.groupEnd();
		return { data: null, error };
	}

	console.log('✅ Raw database response:', response);

	// Convert database type to tableMain type
	const convertedData = response
		? {
				id: response.id,
				user_id: response.user_id || '',
				question_id: response.question_id || '',
				response_text: response.response_text || undefined,
				status: response.status as 'answered' | 'skipped',
				visibility: response.visibility as 'public' | 'private',
				version: response.version || 1,
				created_at: response.created_at || undefined,
				updated_at: response.updated_at || undefined
			}
		: null;

	console.log('🔄 Converted response data:', convertedData);
	console.groupEnd();

	return { data: convertedData, error: null };
}

/**
 * Update an existing response
 */
export async function updateResponse(
	id: string,
	data: Omit<ResponseUpdate, 'version'>
): Result<Response> {
	// First, get the current response to get its version
	const { data: currentResponse, error: fetchError } = await supabase
		.from('responses')
		.select('*')
		.eq('id', id)
		.single();

	if (fetchError) {
		return { data: null, error: fetchError };
	}

	// Create a new version
	const { data: newResponse, error: insertError } = await supabase
		.from('responses')
		.insert([
			{
				...currentResponse,
				...data,
				id: undefined, // Let Supabase generate a new ID
				version: currentResponse.version + 1
			}
		])
		.select()
		.single();

	if (insertError) {
		return { data: null, error: insertError };
	}

	// Convert database type to tableMain type
	const convertedData = newResponse
		? {
				id: newResponse.id,
				user_id: newResponse.user_id || '',
				question_id: newResponse.question_id || '',
				response_text: newResponse.response_text || undefined,
				status: newResponse.status as 'answered' | 'skipped',
				visibility: newResponse.visibility as 'public' | 'private',
				version: newResponse.version || 1,
				created_at: newResponse.created_at || undefined,
				updated_at: newResponse.updated_at || undefined
			}
		: null;

	return { data: convertedData, error: null };
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
				visibility: 'private',
				version: 1
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
				version: data.version || 1,
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
			version: dbResponse.version || 1,
			created_at: dbResponse.created_at || undefined,
			updated_at: dbResponse.updated_at || undefined
		})) || [];

	// Use utility function to get latest versions
	const latestResponses = filterLatestResponses(convertedData);

	return { data: latestResponses, error: null };
}
