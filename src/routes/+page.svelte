<script lang="ts">
	import { getContext } from 'svelte';
	import type { ViewName } from '$lib/types/appState';
	import Dash from '$lib/components/views/Dash.svelte';
	import Detail from '$lib/components/views/Detail.svelte';
	import List from '$lib/components/views/List.svelte';
	import Email from '$lib/components/views/Email.svelte';

	const getViewName = getContext<() => ViewName>('getViewName');

	let view = $derived(getViewName());
</script>

<div class="h-full w-full overflow-y-auto">
	{#if view === 'dash'}
		<Dash />
	{:else if view === 'list'}
		<List />
	{:else if view === 'detail'}
		<Detail />
	{:else if view === 'email'}
		<Email />
	{:else}
		<div class="p-4">No view selected</div>
	{/if}
</div>
