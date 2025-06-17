<script lang="ts">
	import { generateEmailData, renderEmailToText } from '$lib/services/emailBuilder';
	import { getContext } from 'svelte';

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());
	const getProfileName = getContext<() => string | null>('getProfileName');
	let profileName = $derived(getProfileName());

	let emailContent = $state('Loading email preview...');

	// Generate email content when profileId is available
	$effect(() => {
		if (profileId) {
			generateEmailData(profileId, profileName).then((emailData) => {
				emailContent = renderEmailToText(emailData);
			});
		}
	});
</script>

<div class="w-fill m-2 flex flex-col justify-around space-y-4 p-2">
	<header class="bg-base-100 mb-4 rounded-xl p-2 shadow">
		<h1 class="mb-2 text-center text-2xl">Email Preview</h1>
	</header>

	<div class="bg-base-100 rounded-xl p-4 shadow">
		<div class="font-mono text-sm break-words whitespace-pre-wrap">{emailContent}</div>
	</div>
</div>
