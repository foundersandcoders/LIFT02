<script lang="ts">
	import { generateEmailData, renderEmailToHTML } from '$lib/services/emailBuilder';
	import { getContext } from 'svelte';
	import type { ViewName } from '$lib/types/appState';

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());
	const getProfileName = getContext<() => string | null>('getProfileName');
	let profileName = $derived(getProfileName());

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	let emailContent = $state('Loading email preview...');

	// Generate email content when profileId is available
	$effect(() => {
		if (profileId) {
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
		}
	});

	const onBackClick = () => {
		setViewName('dash');
	};

	const onSendClick = () => {
		// TODO: Implement send functionality
		console.log('Send email clicked - not implemented yet');
	};
</script>

<div class="w-fill m-2 flex flex-col justify-around space-y-4 p-2">
	<header class="bg-base-100 mb-4 rounded-xl p-2 shadow">
		<h1 class="mb-2 text-center text-2xl">Email Preview</h1>
	</header>

	<div class="bg-base-100 rounded-xl p-4 shadow">
		{@html emailContent}
	</div>

	<!-- Action Buttons -->
	<div class="flex justify-around space-x-4 p-4">
		<button onclick={onBackClick} class="btn-nav" type="button" aria-label="Go back to dashboard">
			Back
		</button>
		<button onclick={onSendClick} class="btn-submit" type="button" aria-label="Send email to line manager">
			Send
		</button>
	</div>
</div>
