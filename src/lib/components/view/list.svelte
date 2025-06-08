<script lang="ts">
	import { getListNum } from "$lib/components/logic/dev.svelte";
	import type { View } from "$lib/types/ui";
	import { getContext } from 'svelte';

	const setView = getContext<(view:View) => void>('setView');

	let entries = $state(getListNum());

	const onBackClick = () => { setView("dash") };
	const onListClick = () => { setView("detail") };
</script>

<div class="dev">
	<div id="list-header" class="dev flex flex-row justify-between">
		<h2 class="dev">List View</h2>

		<button onclick={onBackClick} class="dev button">
			Back
		</button>
	</div>

	<div id="list-items" class="dev flex flex-row justify-left">
		{#each [...Array(entries)] as _, i}
			<button onclick={onListClick} class="dev list">
				List Item {i + 1}
			</button>
		{/each}
	</div>
</div>