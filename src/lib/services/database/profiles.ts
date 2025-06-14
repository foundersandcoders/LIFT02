import { supabase } from '$lib/services/supabaseClient';
import type { DbResult as Result, DbResultMany as Results, Database } from './types';

type Profile = Database['public']['Tables']['profiles']['Row'];
type ProfileInsert = Database['public']['Tables']['profiles']['Insert'];
type ProfileUpdate = Database['public']['Tables']['profiles']['Update'];

/**
 * Get a user's profile by their user ID
 */
export async function getProfile(userId: string): Result<Profile> {
	const { data, error } = await supabase
		.from('profiles')
		.select('*')
		.eq('user_id', userId)
		.single();

	if (error) {
		return { data: null, error };
	}

	return { data, error: null };
}

/**
 * Create a new profile for a user
 */
export async function createProfile(userId: string, data: ProfileInsert): Result<Profile> {
	const { data: profile, error } = await supabase
		.from('profiles')
		.insert([{ ...data, user_id: userId }])
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	return { data: profile, error: null };
}

/**
 * Update a user's profile
 */
export async function updateProfile(userId: string, data: ProfileUpdate): Result<Profile> {
	const { data: profile, error } = await supabase
		.from('profiles')
		.update(data)
		.eq('user_id', userId)
		.select()
		.single();

	if (error) {
		return { data: null, error };
	}

	return { data: profile, error: null };
}

/**
 * Get all profiles (admin function)
 */
export async function getAllProfiles(): Results<Profile> {
	const { data, error } = await supabase.from('profiles').select('*');

	if (error) {
		return { data: null, error };
	}

	return { data, error: null };
}
