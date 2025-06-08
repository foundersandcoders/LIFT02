<script lang="ts">
	import { getContext } from 'svelte';
	import Dash from "$lib/components/view/dash.svelte";
	import List from "$lib/components/view/list.svelte";
	import Detail from "$lib/components/view/detail.svelte";
	import type { View } from "$lib/types/ui";

	const getView = getContext<() => View>('view');
</script>

<main id="view" class="dev">
	{#if getView() === "dash"}
		<Dash />
	{:else if getView() === "list"}
		<List />
	{:else if getView() === "detail"}
		<Detail />
	{/if}
</main>