<script lang="ts">
	import { getContext, onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import type { Profile } from '$lib/types/appState';
	import ProfileCompletionModal from '$lib/components/ui/ProfileCompletionModal.svelte';

	let { data, children } = $props();

	const setProfile = getContext<(profile: Profile) => void>('setProfile');
	const getProfile = getContext<() => Profile>('getProfile');

	let authError = $state<{ code: string; description: string } | null>(null);
	let showProfileModal = $state(false);

	// Check for auth errors in URL hash
	onMount(() => {
		console.log('🔧 Dashboard layout mounted');
		console.log('📦 Data from server:', data);

		const hash = window.location.hash.substring(1);
		const params = new URLSearchParams(hash);

		if (params.get('error')) {
			console.log('❌ Auth error found in URL hash');
			authError = {
				code: params.get('error_code') || params.get('error') || 'unknown',
				description: params.get('error_description') || 'Authentication failed'
			};
			// Clear the hash from URL
			window.history.replaceState(null, '', window.location.pathname);
			return;
		}

		// Set profile from server data if no error
		if (data.profile) {
			console.log('✅ Setting profile from server data:', data.profile);
			setProfile(data.profile);

			// Check if profile needs completion (name is empty or whitespace)
			if (!data.profile.name || data.profile.name.trim() === '') {
				showProfileModal = true;
			}
		} else {
			console.warn('⚠️ No profile data from server');
			console.log('Session:', data.session);
		}
	});

	function handleRetryLogin() {
		goto('/');
	}

	function handleCloseProfileModal() {
		showProfileModal = false;
	}

	const currentProfile = $derived(getProfile());
</script>

{#if authError}
	<div class="flex items-center justify-center h-full p-4">
		<div class="card bg-base-100 shadow-xl max-w-md w-full">
			<div class="card-body">
				<h2 class="card-title text-error">Authentication Error</h2>
				<p class="text-base-content/70">
					{#if authError.code === 'otp_expired'}
						Your magic link has expired. Magic links are only valid for 1 hour.
					{:else if authError.code === 'access_denied'}
						Access was denied. The link may be invalid or has already been used.
					{:else}
						{authError.description.replace(/\+/g, ' ')}
					{/if}
				</p>
				<div class="card-actions justify-end mt-4">
					<button class="btn btn-primary" onclick={handleRetryLogin}>
						Return to Login
					</button>
				</div>
			</div>
		</div>
	</div>
{:else}
	{@render children()}
	<ProfileCompletionModal
		show={showProfileModal}
		onclose={handleCloseProfileModal}
		currentProfile={currentProfile}
	/>
{/if}
