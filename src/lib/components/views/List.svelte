<script lang="ts">
	import { getContext } from 'svelte';
	import type { App, Detail, ListCategory, Profile, RowId, TableName, ViewName } from "$lib/types/appState";
	import type { Action, Question } from "$lib/types/tableMain";
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestionsByCategory } from "$lib/services/database/questions";
	import ListItem from "$lib/components/cards/ListItem.svelte";

	// App State
	const getApp = getContext<() => App>('getApp');
	const app = $derived(getApp());
	
	let category:ListCategory = $derived(app.list.category);
	let item:Detail = $derived(app.detail);
	let profile:Profile = $derived(app.profile);
	let table:TableName = $derived(app.list.table);

	const setCategory = getContext<(list:ListCategory) => void>('setListCategory');
	const setDetailItemId = getContext<(dbId:RowId) => void>('setDetailItem');
	const setDetailTable = getContext<(table:TableName) => void>('setDetailItem');
	const setView = getContext<(view:ViewName) => void>('setViewName');

	// DB Queries
	let queryActions = $derived((table == "actions" && profile.id != null)
		? getUserActions(profile.id)
		: null
	);
	let queryQuestions = $derived((table == "questions" && category.raw != null)
		? getQuestionsByCategory(category.raw)
		: null
	);

	// Event Handlers
	const onBackClick = () => {
		setView("dash");
		setCategory({
			raw: null,
			format: null
		});
	};
</script>

<div class="dev dev-div">
	<div id="list-header" class="dev dev-div flex flex-row justify-between">
		<h2 class="dev dev-div">List View</h2>

		<button onclick={onBackClick} class="dev dev-div dev-button">
			Back
		</button>
	</div>

	<div id="list-body" class="dev dev-div flex flex-col justify-left">
		{#if table == "actions"}
			{#await queryActions}
				<p>Loading...</p>
			{:then result}
				{#if result?.data}
					{#each result.data as action}
						<ListItem item={action as Action} {table} />
					{/each}
				{:else}
					<p>No actions found</p>
				{/if}
			{:catch error}
				<p>Error: {error.message}</p>
			{/await}
		{:else if table == "questions" && category.raw}
			{#await queryQuestions}
				<p>Loading...</p>
			{:then result}
				{#if result?.data}
					{#each result.data as question}
						<ListItem item={question as Question} {table} />
					{/each}
				{:else}
					<p>No questions found</p>
				{/if}
			{:catch error}
				<p>Error: {error.message}</p>
			{/await}
		{:else}
			<p>No list selected</p>
		{/if}
	</div>
</div>