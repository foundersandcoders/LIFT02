<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, Detail, RowId, TableName, ViewName } from "$lib/types/appState";
	import type { Action, Question } from "$lib/types/tableMain";

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	// Component Props
	let {item, table} = $props<{item:Action|Question, table:TableName}>();

	// Context Pulls
	const setDetail = getContext<(detail:Detail) => void>('setDetail');
	const setDetailItemId = getContext<(dbId:RowId) => void>('setDetailItem');
	const setDetailTable = getContext<(table:TableName) => void>('setDetailItem');
	const setViewName = getContext<(view:ViewName) => void>('setViewName');

	const onclick = (table:null|TableName, item:null|Action|Question) => {
		setViewName("detail");
		setDetail({
			table: table,
			item: {
				id: item ? (item.id || null) : null
			}
		});
	};

	const onkeydown = (press:KeyboardEvent) => {
		if (press.key === 'Enter') onclick(table, item);
	};
</script>

<button onclick={() => onclick(table, item)} {onkeydown} tabindex="0"
	class="p-4 m-2 flex justify-between border border-primary rounded"
>
	<div id="list-item-status">
		<pre>status</pre>
	</div>

	<div id="list-item-title" class="prose">
		{#if table == "actions"}
			{@const item = {id: null}}
			<pre>ACTION</pre>
		{:else if table == "questions" && item}
			<p>{item.preview}</p>
		{:else}
			{@const table = null}
			{@const item = {id: null}}
			<pre>NULL</pre>
		{/if}
	</div>
	<div><pre>actions</pre></div>
</button>
