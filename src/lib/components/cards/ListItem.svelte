<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, RowId, TableName, ViewName } from "$lib/types/appState";
	import type { Action, Question } from "$lib/types/tableMain";

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	// Component Props
	let {item, table} = $props<{item:Action | Question, table:TableName}>();

	// Context Pulls
	const setDetailItemId = getContext<(dbId:RowId) => void>('setDetailItem');
	const setDetailTable = getContext<(table:TableName) => void>('setDetailItem');
	const setViewName = getContext<(view:ViewName) => void>('setViewName');

	// Event Handlers
	const onclick = () => {
		setViewName("detail");
		const event = new CustomEvent('itemClick', {
			detail: { table, item: { id: item.id } }
		});
		dispatchEvent(event);
	};

	const onListClick = (dTable:TableName, dItem:Action | Question) => {
		setViewName("detail");
		if (dTable == "questions" && dItem.id) {
			setDetailTable(dTable);
			setDetailItemId(dItem.id);
		};
	};

	const onkeydown = (press:KeyboardEvent) => {
		if (press.key === 'Enter') onclick();
	};
</script>

<div role="button" {onclick} {onkeydown} class="dev dev-div flex flex-row justify-between" tabindex="0">
	<div class="dev dev-div dev-text">
		<pre>status</pre>
	</div>

	<div class="dev dev-div dev-text">
		{#if app.detail.table == "actions"}
			<p>Coming soon, you fuck</p>
		{:else if item}
			<p>{item}</p>
		{:else}
			<p>No idea how you got here</p>
		{/if}
	</div>
	<div class="dev dev-div dev-text"><pre>actions</pre></div>
</div>