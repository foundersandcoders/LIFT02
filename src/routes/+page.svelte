<script lang="ts">
	import { getContext } from 'svelte';
	import type { ViewName } from '$lib/types/appState';
	import Dash from '$lib/components/views/Dash.svelte';
	import Detail from '$lib/components/views/Detail.svelte';
	import List from '$lib/components/views/List.svelte';
	import EmailPreview from '$lib/components/cards/EmailPreview.svelte';

	const getViewName = getContext<() => ViewName>('getViewName');

	let view = $derived(getViewName());
</script>

{#if view === 'dash'}
	<Dash />
{:else if view === 'list'}
	<List />
{:else if view === 'detail'}
	<Detail />
{:else if view === 'email'}
	<EmailPreview />
{:else}
	<div>No view selected</div>
{/if}
