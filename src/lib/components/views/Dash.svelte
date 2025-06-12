<script lang="ts">
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestions } from "$lib/services/database/questions";
	import type { ListCategory, ViewName } from "$lib/types/ui";
	import { getContext } from 'svelte';

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());

	const setViewName = getContext<(view:ViewName) => void>('setViewName');

	const setList = getContext<(list: ListCategory) => void>('setListCategory');

	let queryActions = $derived(profileId != "" ? getUserActions(profileId) : null);
	let queryQuestions = $state(getQuestions());

	interface Question {
		id: string;
		question_text: string;
		category: string;
	};

	function getCategories(questions: any): ListCategory[] {
		const categoriesRaw:string[] = questions.map(
			(question:Question) => question.category
		);

		const categoriesUnique = [...new Set(categoriesRaw)];
		
		const categoriesFormatted:ListCategory[] = Array.from(categoriesUnique).map((category:string) => ({
			raw: category,
			format: category.split('_').map(
				word => word.charAt(0).toUpperCase() + word.slice(1)
			).join(' ')
		}));

		return categoriesFormatted;
	}

	const onClickTile = (category:ListCategory) => {
		setList(category);
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
				<button onclick={() => onClickTile({ raw: "actions", format: "Actions" })}
					class="dev dev-div dev-tile"
				>
					<p>{result.data.length} Actions</p>
				</button>
			{:else}
				<button class="dev dev-div dev-inactive">
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
				{#each getCategories(result.data) as category}
					<button onclick={() => onClickTile(category)}
						class="dev dev-div dev-tile"
					>
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