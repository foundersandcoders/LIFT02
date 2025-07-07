<script lang="ts">
	import { generateEmailData, renderEmailToHTML } from '$lib/services/emailBuilder';
	import { getContext } from 'svelte';
	import type { ViewName } from '$lib/types/appState';
	import ViewHeader from '../layouts/ViewHeader.svelte';

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());
	const getProfileName = getContext<() => string | null>('getProfileName');
	let profileName = $derived(getProfileName());

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	let emailContent = $state('Loading email preview...');

	// Generate email content when profileId is available
	$effect(() => {
		if (!profileId) {
			emailContent = `
				<div class="alert alert-warning">
					<h3>No user session found</h3>
					<p>Please log in to view your email preview.</p>
				</div>
			`;
			return;
		}

		generateEmailData(profileId, profileName)
			.then((emailData) => {
				emailContent = renderEmailToHTML(emailData);
			})
			.catch((error) => {
				console.error('Failed to generate email preview:', error);
				emailContent = `
					<div class="alert alert-error">
						<h3>Unable to load email preview</h3>
						<p>There was an error generating your email preview. Please try again or contact support if the problem persists.</p>
						<details class="mt-2">
							<summary class="cursor-pointer">Technical details</summary>
							<p class="text-sm mt-1">${error.message || 'Unknown error'}</p>
						</details>
					</div>
				`;
			});
	});

	const onBackClick = () => {
		setViewName('dash');
	};

	const onSendClick = () => {
		// TODO: Implement send functionality
		console.log('Send email clicked - not implemented yet');
	};
</script>

<div class="flex h-full w-full flex-col overflow-hidden">
	<ViewHeader title="Email Preview" onclick={onBackClick} />

	<div class="m-2 flex-1 overflow-y-auto">
		<div class="card-content">
			{@html emailContent}
		</div>
	</div>

	<!-- Action Buttons -->
	<div class="m-2 flex flex-shrink-0 justify-around space-x-4">
		<button
			onclick={onSendClick}
			class="btn-submit"
			type="button"
			aria-label="Send email to line manager"
		>
			Send
		</button>
	</div>
</div>
