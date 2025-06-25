<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, Detail, TableName, ViewName } from '$lib/types/appState';
	import type { Action, Question } from '$lib/types/tableMain';
	import { randomNum } from '$lib/utils/random';

	const getDevMode = getContext<() => boolean>('getDevMode');
	const devMode = $derived(getDevMode());

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	// Component Props
	let { item, table } = $props<{
		item: Action | Question;
		table: TableName;
	}>();

	// Context Pulls
	const setDetail = getContext<(detail: Detail) => void>('setDetail');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const onclick = (table: null | TableName, item: null | Action | Question) => {
		setViewName('detail');
		setDetail({
			table: table,
			item: {
				id: item ? item.id || null : null
			}
		});
	};
</script>

<button
	id="list-item-{item.id}"
	onclick={() => onclick(table, item)}
	tabindex="0"
	class="list-item"
>
	<div class="list-item-row">
		<!-- [!] the status icon logic has to be replaced by db queries -->
		<div id="list-item-{item.id}-status" class="flex items-center">
			{#if app.profile.id != '' && randomNum() > 7}
				<div id="list-item-{item.id}-status-icon" class="status-indicator-xl status-active"></div>
			{:else}
				<div id="list-item-{item.id}-status-icon" class="status-indicator-xl status-default"></div>
			{/if}
		</div>

		<div id="list-item-{item.id}-title" class="list-item-content prose">
			{#if table == 'actions'}
				{@const item = { id: null }}
				<p>ACTION</p>
			{:else if table == 'questions' && item}
				<p>{item.preview}</p>
			{:else}
				{@const table = null}
				{@const item = { id: null }}
				<p>NULL</p>
			{/if}
		</div>

		<div id="list-item-{item.id}-action" class="flex flex-row items-center">
			{#if app.profile.id && randomNum() > 7}
				<div id="list-item-{item.id}-action-icon" class="status-indicator-xl status-action"></div>
			{:else}
				<div id="list-item-{item.id}-action-icon" class="status-indicator status-default"></div>
			{/if}
		</div>
	</div>
</button>
