<script lang="ts">
	let { devMode, profileId } = $props();
</script>

<footer class="sticky bottom-0 z-50 w-full border-t border-gray-200 bg-white">
	<div id="dev-info" class="flex flex-row justify-between">
		<div class="dev dev-div"></div>

		<div class="dev dev-div">
			{#if profileId}
				<p>Profile ID: {profileId}</p>
			{:else}
				<p>Not Logged In</p>
			{/if}
		</div>

		<div class="dev dev-div">
			<p>Dev Mode: {devMode}</p>
		</div>
	</div>
</footer>
