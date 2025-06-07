<script lang="ts">
	import { setView } from "$lib/components/logic/view.svelte";
	import { setListNum } from "$lib/components/logic/dev.svelte";
	import { getQuestions } from "$lib/services/database/questions";

	let query = $state(getQuestions());

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

	const onclick = (listNum: number) => {
		setListNum(listNum);
		setView("list");
	};
</script>

<div class="dev">
	<h1>view/dash</h1>

	{#await query}
		<p>Loading...</p>
	{:then data}
		{#if data.data}
			{#each getCategories(data.data) as category}
				<button class="dev tile" onclick={() => onclick(1)}>
					<p>{category}</p>
				</button>
			{/each}
		{:else}
			<p>No categories found</p>
		{/if}
	{:catch error}
		<p>Error: {error.message}</p>
	{/await}
</div>