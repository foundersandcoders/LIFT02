<script lang="ts">
	import { generateEmailPreview } from '$lib/services/emailBuilder';
	import { getContext } from 'svelte';

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());

	let emailContent = $state('Loading email preview...');

	// Generate email content when profileId is available
	$effect(() => {
		if (profileId) {
			generateEmailPreview(profileId).then((content) => {
				emailContent = content;
			});
		}
	});
</script>

<div class="w-fill m-2 flex flex-col justify-around space-y-4 p-2">
	<header class="bg-base-100 mb-4 rounded-xl p-2 shadow">
		<h1 class="mb-2 text-center text-2xl">Email Preview</h1>
	</header>

	<div class="bg-base-100 rounded-xl p-4 shadow">
		<div class="whitespace-pre-wrap break-words font-mono text-sm">{emailContent}</div>
	</div>
</div>
