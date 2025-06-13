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
				rowId: item ? (item.id || null) : null
			}
		});
		// if (dTable == "questions" && dItem.id) {
		// 	setDetailTable(dTable);
		// 	setDetailItemId(dItem.id);
		// };
	};

	// Event Handlers
	// const onclick = () => {
	// 	setViewName("detail");
	// 	const event = new CustomEvent('itemClick', {
	// 		detail: {
	// 			table,
	// 			item: {
	// 				id: item.id
	// 			}
	// 		}
	// 	});
	// 	dispatchEvent(event);
	// };

	const onkeydown = (press:KeyboardEvent) => {
		if (press.key === 'Enter') onclick(table, item);
	};
</script>

<button onclick={() => onclick(table, item)} {onkeydown} tabindex="0" class="dev dev-div flex flex-row justify-between">
	<div id="list-item-status" class="dev dev-div dev-text">
		<pre>status</pre>
	</div>

	<div id="list-item-title" class="dev dev-div dev-text">
		{#if table == "actions"}
			{@const item = {id: null}}
			<p>Coming soon, you fuck</p>
		{:else if table == "questions" && item}
			<p>{item.preview}</p>
		{:else}
			{@const table = null}
			{@const item = {id: null}}
			<p>No idea how you got here</p>
		{/if}
	</div>
	<div class="dev dev-div dev-text"><pre>actions</pre></div>
</button>