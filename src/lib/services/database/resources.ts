import { supabase } from '$lib/services/supabaseClient';
import type { Resource } from '$lib/types/tableMain';
import type { DbResult as Result, DbResultMany as Results } from './types';

/**
 * Get all resources
 */
export async function getResources(): Results<Resource> {
	const { data, error } = await supabase.from('resources').select('*');
	if (error) {
		return { data: null, error };
	}
	return { data: data || [], error: null };
}

/**
 * Get a single resource by ID
 */
export async function getResource(id: string): Result<Resource> {
	const { data, error } = await supabase.from('resources').select('*').eq('id', id).single();
	if (error) {
		return { data: null, error };
	}
	return { data, error: null };
}
