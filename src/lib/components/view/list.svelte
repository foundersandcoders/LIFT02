<script lang="ts">
	import { setView } from "$lib/components/logic/view.svelte";
	import { getListNum } from "$lib/components/logic/dev.svelte";

	let entries = $state(getListNum());

	const onBackClick = () => {
		setView("dash");
	};

	const onListClick = () => {
		setView("detail");
	};
</script>

<div class="dev">
	<h1>view/list</h1>

	<button onclick={onBackClick} class="dev button">
		Back
	</button>

	<p>There should be {entries} List Items</p>

	{#each [...Array(entries)] as _, i}
		<button onclick={onListClick} class="dev list">
			List Item {i + 1}
		</button>
	{/each}
</div>