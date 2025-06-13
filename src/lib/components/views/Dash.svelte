<script lang="ts">
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestions } from "$lib/services/database/questions";
	import type { Question } from "$lib/types/tableMain";
	import type { AppState, ItemCategory, List, TableName, ViewName } from "$lib/types/appState";
	import { makePretty } from "$lib/utils/textTools";
	import { getContext } from 'svelte';

	const getApp = getContext<() => AppState>('getApp');

	const app = $derived(getApp());

	const setList = getContext<(list:List) => void>('setList');
	const setViewName = getContext<(view:ViewName) => void>('setViewName');

	let queryActions = $derived(app.profile.id ? getUserActions(app.profile.id) : null);
	let queryQuestions = $state(getQuestions());

	function extractCategories(questions:Question[]):ItemCategory[] {
		// TODO: Move extractCategories() to a utils file
		const categoriesRaw:string[] = questions.map((question:Question) => question.category);
		const categoriesUnique = [...new Set(categoriesRaw)];
		
		return categoriesUnique.map((category:string) => ({
			raw: category,
			format: makePretty(category, "db-table-name", "tile-text")
		}));
	}

	const onclick = (table:TableName, category:ItemCategory) => {
		// TODO: Create a utils file for regular view transitions
		setList({ table, category });
		setViewName("list");
	};
</script>

<div class="dev dev-div">
	<div id="dash-header" class="dev dev-div flex flex-row justify-between">
		<h2>Dashboard View</h2>
	</div>

	<div id="dash-tiles" class="dev dev-div">
		{#await queryActions}
			<p>Loading...</p>
		{:then result}
			{#if result && result.data}
				{@const table = "actions"}
				{@const category = { raw: "actions", format: "Actions" }}
				<button onclick={() => onclick(table, category)} class="dev dev-state-active dev-tile">
					<p>{result.data.length} Actions</p>
				</button>
			{:else}
				<button class="dev dev-tile dev-state-inactive">
					<p>0 Actions</p>
				</button>
			{/if}
		{:catch error}
			<p>Error Getting Actions: {error.message}</p>
		{/await}

		{#await queryQuestions}
			<p>Loading...</p>
		{:then result}
			{#if result.data}
				{#each extractCategories(result.data) as category}
					{@const table = "questions"}
					<button onclick={() => onclick(table, category)} class="dev dev-state-active dev-tile">
						<p>{category.format}</p>
					</button>
				{/each}
			{:else}
				<p>No categories found</p>
			{/if}
		{:catch error}
			<p>Error Getting Questions: {error.message}</p>
		{/await}
	</div>
</div>