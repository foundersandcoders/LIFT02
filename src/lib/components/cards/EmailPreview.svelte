<script lang="ts">
	let emailContent = $state('Loading email preview...');
</script>

<div class="w-fill m-2 flex flex-col justify-around space-y-4 p-2">
	<header class="bg-base-100 mb-4 rounded-xl p-2 shadow">
		<h1 class="mb-2 text-center text-2xl">Email Preview</h1>
	</header>

	<div class="bg-base-100 rounded-xl p-4 shadow">
		<pre>{emailContent}</pre>
	</div>
</div>
