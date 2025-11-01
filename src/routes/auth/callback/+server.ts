import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ url, locals: { supabase } }) => {
	const token_hash = url.searchParams.get('token_hash');
	const type = url.searchParams.get('type');
	const code = url.searchParams.get('code');

	console.log('🔐 Auth callback triggered');
	console.log('📝 URL params:', { token_hash: !!token_hash, type, code: !!code });

	// Handle PKCE flow (code)
	if (code) {
		const { data, error } = await supabase.auth.exchangeCodeForSession(code);
		console.log('🔄 PKCE exchange result:', { session: !!data.session, error });

		if (error) {
			console.error('❌ PKCE exchange error:', error);
			throw redirect(303, '/dashboard#error=' + error.message);
		}
	}
	// Handle magic link flow (token_hash)
	else if (token_hash && type) {
		const { data, error } = await supabase.auth.verifyOtp({
			token_hash,
			type: type as any
		});
		console.log('🔄 OTP verify result:', { session: !!data.session, error });

		if (error) {
			console.error('❌ OTP verify error:', error);
			throw redirect(303, `/dashboard#error=access_denied&error_code=${error.code || 'unknown'}&error_description=${encodeURIComponent(error.message)}`);
		}
	}

	console.log('✅ Redirecting to dashboard');
	throw redirect(303, '/dashboard');
};
