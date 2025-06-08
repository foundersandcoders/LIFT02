<script lang="ts">
	import type { View } from "$lib/types/ui";
	import { getContext } from 'svelte';

	const setView = getContext<(view:View) => void>('setView');

	const onBackClick = () => { setView("list") };
</script>

<div class="dev">
	<div id="detail-header" class="dev flex flex-row justify-between">
		<h2 class="dev">Detail View</h2>

		<button onclick={onBackClick} class="dev button">
			Back
		</button>
	</div>

	<div id="detail-content" class="dev">
	</div>
</div>