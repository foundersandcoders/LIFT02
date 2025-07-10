<script lang="ts">
	import { getContext } from 'svelte';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import DashTile from '../cards/DashTile.svelte';
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

	<div id="dash-tiles" class="view-content">
		{#if app.profile.id == null}
			<div class="dash-grid">
				<DashTile title="No Profile Selected" variant="square" disabled />
			</div>
		{:else}
			<!-- Top Row -->
			<div class="dash-grid">
				<!-- Actions -->
				{#await queryActions}
					<DashTile title="Actions" loading={true} variant="square" disabled />
				{:then result}
					{#if result && result.data}
						{@const table = 'actions'}
						{@const category = { raw: 'actions', format: 'Actions' }}
						{@const num = result.data.length}
						<DashTile
							title={num > 0 ? `${num} Active Actions` : 'No Active Actions'}
							variant="square"
							onclick={() => onclick(table, category)}
						/>
					{:else}
						<DashTile title="No Active Actions" variant="square" disabled />
					{/if}
				{:catch error}
					<DashTile title="Error Getting Actions" error={error.message} variant="square" disabled />
				{/await}

				<!-- Resources -->
				{#await queryResources}
					<DashTile title="Resources" loading={true} variant="square" disabled />
				{:then}
					{@const table = 'resources'}
					{@const category = { raw: 'resources', format: 'Resources' }}
					<DashTile title={'Resources'} variant="square" onclick={() => onclick(table, category)} />
				{:catch error}
					<DashTile
						title="Error Getting Resources"
						error={error.message}
						variant="square"
						disabled
					/>
				{/await}
			</div>

			<!-- Categories -->
			<div class="dash-vertical-container">
				<!-- Questions -->
				{#await queryQuestions}
					<div class="list-item">
						<p class="text-center">Loading Questions...</p>
					</div>
				{:then result}
					{#if result.data}
						{#each extractCategories(result.data) as category}
							{@const table = 'questions'}
							<DashTile title={category.format} onclick={() => onclick(table, category)} />
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
		{/if}
	</div>
</div>
