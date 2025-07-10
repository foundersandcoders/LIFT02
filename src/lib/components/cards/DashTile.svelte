<script lang="ts">
	import { getContext } from 'svelte';
	import { getLatestActions } from '$lib/services/database/actions';
	import { getQuestions } from '$lib/services/database/questions';
	import { getResources } from '$lib/services/database/resources';
	import type { Question } from '$lib/types/tableMain';	
	import { makePretty } from '$lib/utils/textTools';
	
	import type { AppState, ItemCategory, List, TableName, ViewName } from '$lib/types/appState';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const setList = getContext<(list: List) => void>('setList');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	interface Props {
		title: string | null;
		loading?: boolean;
		error?: string | null;
		disabled?: boolean;
		onclick?: () => void;
		variant?: 'square' | 'default';
	}

	let {
		title,
		loading = false,
		error = null,
		disabled = false,
		onclick,
		variant = 'default'
	}: Props = $props();
</script>

<button class={variant === 'square' ? 'dash-tile-square' : 'dash-tile-rect'} {onclick} {disabled}>
	{#if loading}
		<p class="text-center">Loading {title}...</p>
	{:else if error}
		<p class="text-center">Error: {error}</p>
	{:else}
		<p class="text-center">{title}</p>
	{/if}
</button>
