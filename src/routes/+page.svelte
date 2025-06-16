<script lang="ts">
	import { getContext } from 'svelte';
	import type { ViewName } from "$lib/types/appState";
	import Dash from "$lib/components/views/Dash.svelte";
	import Detail from "$lib/components/views/Detail.svelte";
	import List from "$lib/components/views/List.svelte";

	const getViewName = getContext<() => ViewName>('getViewName');

	let view = $derived(getViewName());
</script>

<main id="view" class="">
	{#if view === "dash"}
		<Dash />
	{:else if view === 'list'}
		<List />
	{:else if view === 'detail'}
		<Detail />
	{:else}
		<div>No view selected</div>
	{/if}
</main>