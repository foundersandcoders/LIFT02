import { redirect } from '@sveltejs/kit';
import { dev } from '$app/environment';
import { getProfile } from '$lib/services/database/profiles';
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ locals: { getSession } }) => {
	const session = await getSession();

	// In production, require authentication
	// In dev mode, allow access for testing with test users
	if (!session && !dev) {
		throw redirect(303, '/');
	}

	// Load user profile if authenticated
	let profile = null;
	if (session?.user?.id) {
		console.log('🔍 Looking for profile with user_id:', session.user.id);
		console.log('📧 User email:', session.user.email);

		const result = await getProfile(session.user.id);
		console.log('📊 Profile query result:', result);

		if (result.data) {
			profile = {
				id: result.data.user_id,
				name: result.data.name,
				is_line_manager: result.data.is_line_manager,
				preferences: (result.data.preferences as import('$lib/types/appState').UserPreferences) || {}
			};
			console.log('✅ Profile loaded:', profile);
		} else if (result.error) {
			console.error('❌ Profile error:', result.error);
		}
	}

	return { session, profile };
};
