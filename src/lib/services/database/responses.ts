import { supabase } from '$lib/services/supabaseClient';
import type {
	DbResult as Result,
	DbResultMany as Results,
	Database,
	QueryOptions,
	FilterOptions
} from './types';
import { filterLatestResponses }  from '$lib/utils/versionFilter';

import type { Response } from '$lib/types/tableMain';
// import type { Response } from 
// type Response = Database['public']['Tables']['responses']['Row'];
// XXXXXREVIEW THESE TYPESXXXXXX
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

	let filteredResponses = data || [];


	// Apply limit and offset after filtering
	if (options?.offset || options?.limit) {
		const offset = options.offset || 0;
		const limit = options.limit || 10;
		filteredResponses = filteredResponses.slice(offset, offset + limit);
	}

	return { data: filteredResponses, error: null };
}

/**
 * Get a single response by ID
 */
export async function getResponseById(id: string): Result<Response> {
	const { data, error } = await supabase.from('responses').select('*').eq('id', id).single();

	if (error) {
		return { data: null, error };
	}

	return { data, error: null };
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

	return { data, error: null };
}

/**
 * Create a new response
 */
export async function createResponse(
	userId: string,
	data: Omit<ResponseInsert, 'user_id' | 'version'>
): Result<Response> {
	const { data: response, error } = await supabase
		.from('responses')
		.insert([
			{
				...data,
				user_id: userId,
				version: 1
			}
		])
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	return { data: response, error: null };
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

	return { data: newResponse, error: null };
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

	return { data, error: null };
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

	// Use utility function to get latest versions
	const latestResponses = filterLatestResponses(data || []);

	return { data: latestResponses, error: null };
}
