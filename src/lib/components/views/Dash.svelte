<script lang="ts">
	import ViewHeader from "../layouts/ViewHeader.svelte";
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

<div id="dash-view">
	<ViewHeader title="Dashboard"/>

	<div id="dash-tiles" class="flex flex-col justify-center items-center m-2 p-4">
		{#await queryActions}
			<button disabled class="card prose border border-primary bg-base-100 p-4 m-2 w-full" >
				<p>Loading Actions...</p>
			</button>
		{:then result}
			{#if result && result.data}
				{@const table = "actions"}
				{@const category = { raw: "actions", format: "Actions" }}
				<button onclick={() => onclick(table, category)}
					class="card prose border border-primary bg-base-100 p-4 m-2 w-full"
				>
					<p>{result.data.length} Actions</p>
				</button>
			{:else}
				<div class="card prose border border-primary bg-base-100 p-4 m-2 w-full">
					<p>0 Actions</p>
				</div>
			{/if}
		{:catch error}
			<div class="card prose border border-primary bg-base-100 p-4 m-2 w-full">
				<p>Error Getting Actions: {error.message}</p>
			</div>
		{/await}

		{#await queryQuestions}
			<div class="card prose border border-primary bg-base-100 p-4 m-2 w-full">
				<p>Loading Questions...</p>
			</div>
		{:then result}
			{#if result.data}
				{#each extractCategories(result.data) as category}
					<!-- [ ] Extract this button component into a separate <DashTile /> -->
					{@const table = "questions"}
					<button onclick={() => onclick(table, category)}
						class="card prose border border-primary bg-base-100 p-4 m-2 w-full"
					>
						<p>{category.format}</p>
					</button>
				{/each}
			{:else}
				<div class="card prose border border-primary bg-base-100 p-4 m-2 w-full">
					<p>No Questions Found</p>
				</div>
			{/if}
		{:catch error}
			<div class="card prose border border-primary bg-base-100 p-4 m-2 w-full">
				<p>Loading Questions...</p>
			</div>
		{/await}
	</div>
</div>
