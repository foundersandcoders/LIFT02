<script lang="ts">
	import { getContext } from 'svelte';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import { getLatestActions } from '$lib/services/database/actions';
	import { getQuestions } from '$lib/services/database/questions';
	import { getResources } from '$lib/services/database/resources';
	import type { Question } from '$lib/types/tableMain';
	import type { AppState, ItemCategory, List, TableName, ViewName } from '$lib/types/appState';
	import { makePretty } from '$lib/utils/textTools';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const setList = getContext<(list: List) => void>('setList');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	let queryActions = $derived(app.profile.id ? getLatestActions(app.profile.id, false) : null);
	let queryQuestions = $state(getQuestions());
	let queryResources = $state(getResources());

	function extractCategories(questions: Question[]): ItemCategory[] {
		// TODO: Move extractCategories() to a utils file
		const categoriesRaw: string[] = questions.map((question: Question) => question.category);
		const categoriesUnique = [...new Set(categoriesRaw)];

		return categoriesUnique.map((category: string) => ({
			raw: category,
			format: makePretty(category, 'db-table-name', 'tile-text')
		}));
	}

	const onclick = (table: TableName, category: ItemCategory) => {
		// TODO: Create a utils file for regular view transitions
		setList({ table, category });
		setViewName('list');
	};
</script>

<div id="dash-view" class="view">
	<ViewHeader title="Dashboard" />

	<div id="dash-content" class="view-content">
		{#await queryActions}
			<button disabled class="list-item">
				<p class="text-center">Loading Actions...</p>
			</button>
		{:then result}
			{#if result && result.data}
				{@const table = 'actions'}
				{@const category = { raw: 'actions', format: 'Actions' }}
				<button onclick={() => onclick(table, category)} class="list-item">
					<p class="text-center">{result.data.length > 0 ? `${result.data.length} Active Actions` : 'No Active Actions'}</p>
				</button>
			{:else}
				<div class="list-item">
					<p class="text-center">No Active Actions</p>
				</div>
			{/if}
		{:catch error}
			<div class="list-item">
				<p class="text-center">Error Getting Actions: {error.message}</p>
			</div>
		{/await}

		{#await queryResources}
			<button disabled class="list-item">
				<p class="text-center">Loading Resources...</p>
			</button>
		{:then result}
			{#if result && result.data}
				{@const table = 'resources'}
				{@const category = { raw: 'resources', format: 'Resources' }}
				<button onclick={() => onclick(table, category)} class="list-item">
					<p class="text-center">{result.data.length} Resources</p>
				</button>
			{:else}
				<div class="list-item">
					<p class="text-center">0 Resources</p>
				</div>
			{/if}
		{:catch error}
			<div class="list-item">
				<p class="text-center">Error Getting Resources: {error.message}</p>
			</div>
		{/await}

		{#await queryQuestions}
			<div class="list-item">
				<p class="text-center">Loading Questions...</p>
			</div>
		{:then result}
			{#if result.data}
				{#each extractCategories(result.data) as category}
					<!-- [ ] Extract this button component into a separate <DashTile /> -->
					{@const table = 'questions'}
					<button onclick={() => onclick(table, category)} class="list-item">
						<p class="text-center">{category.format}</p>
					</button>
				{/each}
			{:else}
				<div class="list-item">
					<p class="text-center">No Questions Found</p>
				</div>
			{/if}
		{:catch error}
			<div class="list-item">
				<p class="text-center">Loading Questions...</p>
			</div>
		{/await}
	</div>
</div>
