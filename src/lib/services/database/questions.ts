import { supabase } from '$lib/services/supabaseClient';
import type { DbResult as Result, DbResultMany as Results, Database, QueryOptions } from './types';

type Question = Database['public']['Tables']['questions']['Row'];
type QuestionInsert = Database['public']['Tables']['questions']['Insert'];
type QuestionUpdate = Database['public']['Tables']['questions']['Update'];

/**
 * Get all questions with optional filtering and pagination
 */
export async function getQuestions(options?: QueryOptions): Results<Question> {
	let query = supabase.from('questions').select('*');

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

	return { data, error: null };
}

/**
 * Get questions by category
 */
export async function getQuestionsByCategory(category: string): Results<Question> {
	const { data, error } = await supabase
		.from('questions')
		.select('*')
		.eq('category', category)
		.order('order', { ascending: true });

	if (error) {
		return { data: null, error };
	}

	return { data, error: null };
}

/**
 * Get a single question by ID
 */
export async function getQuestionById(id: string): Result<Question> {
	const { data, error } = await supabase.from('questions').select('*').eq('id', id).single();

	if (error) {
		return { data: null, error };
	}

	return { data, error: null };
}

/**
 * Create a new question
 */
export async function createQuestion(data: QuestionInsert): Result<Question> {
	const { data: question, error } = await supabase
		.from('questions')
		.insert([data])
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	return { data: question, error: null };
}

/**
 * Update an existing question
 */
export async function updateQuestion(id: string, data: QuestionUpdate): Result<Question> {
	const { data: question, error } = await supabase
		.from('questions')
		.update(data)
		.eq('id', id)
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	return { data: question, error: null };
}

/**
 * Delete a question
 */
export async function deleteQuestion(id: string): Result<void> {
	const { error } = await supabase.from('questions').delete().eq('id', id);

	if (error) {
		return { data: null, error };
	}

	return { data: undefined, error: null };
}
