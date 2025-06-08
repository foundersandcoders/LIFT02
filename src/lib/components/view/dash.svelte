<script lang="ts">
	import { setListNum } from "$lib/components/logic/dev.svelte";
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestions } from "$lib/services/database/questions";
	import type { View } from "$lib/types/ui";
	import { getContext } from 'svelte';

	const getProfileId = getContext<() => string>('profileId');
	let profileId = $derived(getProfileId());

	const setView = getContext<(view: View) => void>('setView');

	let queryQuestions = $state(getQuestions());
	let queryActions = $derived(profileId != "" ? getUserActions(profileId) : null);

	function getCategories(questions: any) {
		interface Question {
			id: string;
			question_text: string;
			category: string;
		};

		const categories = questions.map(
			// Extract the Categories
			(question:Question) => question.category
		).map(
			// Convert to Title Case
			(category:string) => category.split('_').map(
				word => word.charAt(0).toUpperCase() + word.slice(1)
			).join(' ')
		);

		// Remove Duplicates
		const categoriesUnique = [...new Set(categories)];

		return categoriesUnique;
	}

	const setViewList = (listNum: number) => {
		setListNum(listNum);
		setView("list");
	};
</script>

<div class="dev">
	<div id="dash-header" class="dev flex flex-row justify-between">
		<h2>Dashboard View</h2>
	</div>

	<div id="dash-tiles" class="dev">
		{#await queryActions}
			<p>Loading...</p>
		{:then result}
			{#if result && result.data}
				<button class="dev tile" onclick={() => setViewList(1)}>
					<p>{result.data.length} Actions</p>
				</button>
			{:else}
				<button class="dev inactive">
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
					<button class="dev tile" onclick={() => setViewList(1)}>
						<p>{category}</p>
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