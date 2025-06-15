<script lang="ts">
	import { generateEmailPreview } from '$lib/services/emailBuilder';

	//Delete later --> for development only
	const user_id = '550e8400-e29b-41d4-a716-446655440005';

	let emailContent = $state('Loading email preview...');

	// Generate email content on component load
	generateEmailPreview(user_id).then((content) => {
		emailContent = content;
	});
</script>

<div class="w-fill m-2 flex flex-col justify-around space-y-4 p-2">
	<header class="bg-base-100 mb-4 rounded-xl p-2 shadow">
		<h1 class="mb-2 text-center text-2xl">Email Preview</h1>
	</header>

	<div class="bg-base-100 rounded-xl p-4 shadow">
		<pre>{emailContent}</pre>
	</div>
</div>
