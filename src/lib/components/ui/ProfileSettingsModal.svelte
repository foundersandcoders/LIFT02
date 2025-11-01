<script lang="ts">
	import { getContext } from 'svelte';
	import type { Profile, UserPreferences } from '$lib/types/appState';
	import { updateProfile, getProfile } from '$lib/services/database/profiles';

	interface Props {
		show: boolean;
		onclose: () => void;
	}

	let { show, onclose }: Props = $props();

	const getProfileContext = getContext<() => Profile>('getProfile');
	const setProfile = getContext<(profile: Profile) => void>('setProfile');

	const currentProfile = $derived(getProfileContext());

	let name = $state('');
	let email = $state('');
	let lineManagerName = $state('');
	let lineManagerEmail = $state('');
	let loading = $state(false);
	let error = $state<string | null>(null);
	let successMessage = $state<string | null>(null);

	// Load current profile data when modal opens
	$effect(() => {
		if (show && currentProfile.id) {
			// Reload fresh profile data from database
			getProfile(currentProfile.id).then((result) => {
				if (result.data) {
					name = result.data.name || '';
					email = result.data.email || '';
					lineManagerName = result.data.line_manager_name || '';
					lineManagerEmail = result.data.line_manager_email || '';
				}
			});
		}
	});

	async function handleSubmit(e: Event) {
		e.preventDefault();
		loading = true;
		error = null;
		successMessage = null;

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
					preferences: (result.data.preferences as UserPreferences) || {}
				});
			}

			successMessage = 'Profile updated successfully!';

			// Close modal after short delay
			setTimeout(() => {
				onclose();
				successMessage = null;
			}, 1500);
		} catch (err: any) {
			error = err.message || 'Failed to update profile';
		} finally {
			loading = false;
		}
	}

	function handleCancel() {
		error = null;
		successMessage = null;
		onclose();
	}
</script>

{#if show}
	<div class="modal modal-open">
		<div class="modal-box modal-box-custom mx-auto">
			<h3 class="text-lg font-bold mb-4 text-center text-base-content">Profile Settings</h3>

			<form onsubmit={handleSubmit} class="space-y-4">
				<!-- Name (required) -->
				<div class="form-control">
					<label for="settings-name" class="label">
						<span class="label-text text-base-content">Your Name *</span>
					</label>
					<input
						id="settings-name"
						type="text"
						bind:value={name}
						placeholder="Enter your name"
						required
						disabled={loading}
						class="input input-bordered w-full text-base-content"
					/>
				</div>

				<!-- Email (read-only) -->
				<div class="form-control">
					<label for="settings-email" class="label">
						<span class="label-text text-base-content">Email (cannot be changed)</span>
					</label>
					<input
						id="settings-email"
						type="email"
						value={email}
						disabled
						class="input input-bordered w-full bg-base-200 cursor-not-allowed text-base-content"
					/>
				</div>

				<!-- Line Manager Name (optional) -->
				<div class="form-control">
					<label for="settings-line-manager-name" class="label">
						<span class="label-text text-base-content">Line Manager Name (optional)</span>
					</label>
					<input
						id="settings-line-manager-name"
						type="text"
						bind:value={lineManagerName}
						placeholder="Enter line manager's name"
						disabled={loading}
						class="input input-bordered w-full text-base-content"
					/>
				</div>

				<!-- Line Manager Email (optional) -->
				<div class="form-control">
					<label for="settings-line-manager-email" class="label">
						<span class="label-text text-base-content">Line Manager Email (optional)</span>
					</label>
					<input
						id="settings-line-manager-email"
						type="email"
						bind:value={lineManagerEmail}
						placeholder="manager@example.com"
						disabled={loading}
						class="input input-bordered w-full text-base-content"
					/>
				</div>

				{#if error}
					<div class="alert alert-error">
						<span>{error}</span>
					</div>
				{/if}

				{#if successMessage}
					<div class="alert alert-success">
						<span>{successMessage}</span>
					</div>
				{/if}

				<div class="modal-action">
					<button
						type="button"
						class="btn"
						onclick={handleCancel}
						disabled={loading}
					>
						Cancel
					</button>
					<button
						type="submit"
						class="btn btn-primary"
						disabled={loading || !name.trim()}
					>
						{#if loading}
							<span class="loading loading-spinner"></span>
							Saving...
						{:else}
							Save Changes
						{/if}
					</button>
				</div>
			</form>
		</div>
	</div>
{/if}
