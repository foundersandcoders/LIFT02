<script lang="ts">
	import { setView } from "$lib/components/logic/view.svelte";
	import { setListNum } from "$lib/components/logic/dev.svelte";
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestions } from "$lib/services/database/questions";
	import type { ActionCheck } from "$lib/types/ui";

	let devMode = $state(true);
	const toggleDevMode = () => { devMode = !devMode };

	let actions = $state({ exist: false, count: 0 });
	let queryQuestions = $state(getQuestions());

	let profileId = $derived(devMode ? "550e8400-e29b-41d4-a716-446655440001" : "");
	let queryActions = $derived(profileId != "" ? getUserActions(profileId) : null);

	async function countActions(profileId:string):Promise<ActionCheck> {
		let actionsNum = 0;
		let isError = false;

		const { data, error } = await getUserActions(profileId);

		if (error) {
			console.error(error);
			isError = true;
		} else if (data) {
			actionsNum = data.length;
		}

		!isError && actionsNum > 0 ? actions.exist = true : actions.exist = false;

		return {
			isError: isError,
			exist: !isError && actionsNum > 0,
			count: actionsNum
		};
	}

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
	<div id="dash-header" class="dev">
		<h1>view/dash</h1>
		
		<button
			class="dev {devMode ? 'button' : 'inactive'}"
			onclick={() => toggleDevMode()}
		>
			<p>Turn {devMode ? 'Off' : 'On'} Dev Mode</p>
		</button>
	</div>

	<div id="dev-info" class="dev">
		<p>Dev Mode: {devMode}</p>
		<p>Profile ID: {profileId}</p>
	</div>

	<div id="dash-tiles" class="dev">
		{#await queryActions}
			<p>Loading...</p>
		{:then result}
			{#if result && result.data}
				<button class="dev tile" onclick={() => onclick(1)}>
					<p>{result.data.length} Actions</p>
				</button>
			{:else}
				<button class="dev inactive" onclick={() => onclick(1)}>
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
					<button class="dev tile" onclick={() => onclick(1)}>
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