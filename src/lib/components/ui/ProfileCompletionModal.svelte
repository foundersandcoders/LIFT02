<script lang="ts">
	import { getContext } from 'svelte';
	import type { Profile } from '$lib/types/appState';
	import { updateProfile } from '$lib/services/database/profiles';

	interface Props {
		show: boolean;
		onclose: () => void;
		currentProfile: Profile;
	}

	let { show, onclose, currentProfile }: Props = $props();

	const setProfile = getContext<(profile: Profile) => void>('setProfile');

	let name = $state(currentProfile.name || '');
	let lineManagerName = $state('');
	let lineManagerEmail = $state('');
	let loading = $state(false);
	let error = $state<string | null>(null);

	async function handleSubmit(e: Event) {
		e.preventDefault();
		loading = true;
		error = null;

		try {
			if (!currentProfile.id) {
				throw new Error('Profile ID is missing');
			}

			const result = await updateProfile(currentProfile.id, {
				name,
				line_manager_name: lineManagerName || null,
				line_manager_email: lineManagerEmail || null
			});

			if (result.error) {
				throw new Error(result.error.message);
			}

			if (result.data) {
				// Update the app state with new profile data
				setProfile({
					id: result.data.user_id,
					name: result.data.name,
					is_line_manager: result.data.is_line_manager,
					preferences: result.data.preferences || {}
				});
			}

			onclose();
		} catch (err: any) {
			error = err.message || 'Failed to update profile';
		} finally {
			loading = false;
		}
	}
</script>

{#if show}
	<div class="modal modal-open">
		<div class="modal-box max-w-md">
			<h3 class="text-lg font-bold mb-4">Complete Your Profile</h3>
			<p class="text-sm opacity-70 mb-4">
				Welcome! Please provide your name and optionally your line manager's details.
			</p>

			<form onsubmit={handleSubmit} class="space-y-4">
				<!-- Name (required) -->
				<div class="form-control">
					<label for="name" class="label">
						<span class="label-text">Your Name *</span>
					</label>
					<input
						id="name"
						type="text"
						bind:value={name}
						placeholder="Enter your name"
						required
						disabled={loading}
						class="input input-bordered w-full"
					/>
				</div>

				<!-- Line Manager Name (optional) -->
				<div class="form-control">
					<label for="lineManagerName" class="label">
						<span class="label-text">Line Manager Name (optional)</span>
					</label>
					<input
						id="lineManagerName"
						type="text"
						bind:value={lineManagerName}
						placeholder="Enter line manager's name"
						disabled={loading}
						class="input input-bordered w-full"
					/>
				</div>

				<!-- Line Manager Email (optional) -->
				<div class="form-control">
					<label for="lineManagerEmail" class="label">
						<span class="label-text">Line Manager Email (optional)</span>
					</label>
					<input
						id="lineManagerEmail"
						type="email"
						bind:value={lineManagerEmail}
						placeholder="manager@example.com"
						disabled={loading}
						class="input input-bordered w-full"
					/>
				</div>

				{#if error}
					<div class="alert alert-error">
						<span>{error}</span>
					</div>
				{/if}

				<div class="modal-action">
					<button type="submit" class="btn btn-primary" disabled={loading || !name.trim()}>
						{#if loading}
							<span class="loading loading-spinner"></span>
							Saving...
						{:else}
							Save Profile
						{/if}
					</button>
				</div>
			</form>
		</div>
	</div>
{/if}
