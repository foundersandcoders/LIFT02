<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, Detail, ItemCategory, List, Profile, RowId, TableName, ViewName } from "$lib/types/appState";
	import type { Action, Question } from "$lib/types/tableMain";
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestionsByCategory } from "$lib/services/database/questions";
	import ListItem from "$lib/components/cards/ListItem.svelte";

	// App State
	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	
	let category:ItemCategory = $derived(app.list.category);
	let profile:Profile = $derived(app.profile);
	let table:TableName | null = $derived(app.list.table);

	const setList = getContext<(list:List) => void>('setList');
	const setView = getContext<(view:ViewName) => void>('setViewName');

	// DB Queries
	let queryActions = $derived((table == "actions" && profile.id)
		? getUserActions(profile.id)
		: null
	);
	let queryQuestions = $derived((table == "questions" && category.raw != null)
		? getQuestionsByCategory(category.raw)
		: null
	);

	// Event Handlers
	const onclick = () => {
		setView("dash");
		setList({
			table: null,
			category: { raw: null, format: null }
		});
	};
</script>

<div id="list-view" class="">
	<div id="list-header" class="flex justify-between">
		<h2 class="">List View</h2>

		<button {onclick} class="btn btn-primary">
			Back
		</button>
	</div>

	<div id="list-body" class="flex flex-col justify-left m-2 p-2">
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
