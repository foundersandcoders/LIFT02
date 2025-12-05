import { redirect } from '@sveltejs/kit';
import { dev } from '$app/environment';
import type { EmailOtpType } from '@supabase/supabase-js';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ url, locals: { supabase } }) => {
	const token_hash = url.searchParams.get('token_hash');
	const type = url.searchParams.get('type');
	const code = url.searchParams.get('code');

	if (dev) {
		console.log('🔐 Auth callback triggered');
		console.log('📝 URL params:', { token_hash: !!token_hash, type, code: !!code });
	}

	// Handle PKCE flow (code)
	if (code) {
		const { data, error } = await supabase.auth.exchangeCodeForSession(code);

		if (dev) {
			console.log('🔄 PKCE exchange result:', { session: !!data.session, error });
		}

		if (error) {
			if (dev) {
				console.error('❌ PKCE exchange error:', error);
			}
			throw redirect(303, '/dashboard#error=authentication_failed');
		}
	}
	// Handle magic link flow (token_hash)
	else if (token_hash && type) {
		// Validate OTP type from URL params
		const validOtpTypes: EmailOtpType[] = ['signup', 'invite', 'magiclink', 'recovery', 'email_change'];
		if (!validOtpTypes.includes(type as EmailOtpType)) {
			if (dev) {
				console.error('❌ Invalid OTP type:', type);
			}
			throw redirect(303, '/dashboard#error=authentication_failed');
		}

		const { data, error } = await supabase.auth.verifyOtp({
			token_hash,
			type: type as EmailOtpType
		});

		if (dev) {
			console.log('🔄 OTP verify result:', { session: !!data.session, error });
		}

		if (error) {
			if (dev) {
				console.error('❌ OTP verify error:', error);
			}
			throw redirect(303, '/dashboard#error=authentication_failed');
		}
	}

	if (dev) {
		console.log('✅ Redirecting to dashboard');
	}
	throw redirect(303, '/dashboard');
};
