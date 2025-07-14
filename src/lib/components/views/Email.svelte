<script lang="ts">
	import { generateEmailData, renderEmailToHTML } from '$lib/services/emailBuilder';
	import { getContext } from 'svelte';
	import type { ViewName } from '$lib/types/appState';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import ConfirmModal from '../ui/ConfirmModal.svelte';

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());
	const getProfileName = getContext<() => string | null>('getProfileName');
	let profileName = $derived(getProfileName());

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	let emailContent = $state('Loading email preview...');
	let showModal = $state(false);

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
		showModal = true;
	};

	const handleConfirmSend = async () => {
		// Simulate sending email
		await new Promise((resolve) => setTimeout(resolve, 2000));
		console.log('Email sent!');
	};

	const handleSendSuccess = () => {
		setViewName('dash');
	};
</script>

<div id="email-view" class="view">
	<ViewHeader title="Email Preview" onclick={onBackClick} />

	<div id="email-content" class="view-content">
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
</div>

<ConfirmModal
	show={showModal}
	title="Send Email"
	message="This will send the email to your line manager. This action cannot be undone."
	onConfirm={handleConfirmSend}
	onCancel={() => (showModal = false)}
	onSuccess={handleSendSuccess}
/>
