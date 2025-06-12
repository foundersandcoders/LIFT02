<script lang="ts">
	import { getContext } from 'svelte';
	import Dash from "$lib/components/views/Dash.svelte";
	import List from "$lib/components/views/List.svelte";
	import Detail from "$lib/components/views/Detail.svelte";
	import type { ViewName } from "$lib/types/appState";

	const getViewName = getContext<() => ViewName>('getViewName');

	let view = $derived(getViewName());
</script>

<main id="view" class="dev dev-div">
	{#if view === "dash"}
		<Dash />
	{:else if view === "list"}
		<List />
	{:else if view === "detail"}
		<Detail />
	{:else}
		<div>No view selected</div>
	{/if}
</main>