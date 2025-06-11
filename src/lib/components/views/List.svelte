<script lang="ts">
	import type { ListCategory, ViewName } from "$lib/types/ui";
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestionsByCategory } from "$lib/services/database/questions";
	import { getContext } from 'svelte';
	import ListItem from "$lib/components/cards/ListItem.svelte";

	const setViewName = getContext<(view:ViewName) => void>('setViewName');

	const getListCategory = getContext<() => ListCategory>('getListCategory');
	const setListCategory = getContext<(list:ListCategory) => void>('setListCategory');
	let list = $derived(getListCategory());

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());
	
	const getItemId = getContext<() => string>('getDetailItem');
	const setItemId = getContext<(questionId:string) => void>('setDetailItem');
	let questionId = $derived(getItemId());

	let queryActions = $derived(getUserActions(profileId));
	let queryQuestions = $derived(getQuestionsByCategory(list.raw));

	const onBackClick = () => {
		setView("dash");
		setList({ raw: "", format: "" });
	};
	const onListClick = (item:any) => {
		setView("detail");
		if (item.raw != "action") {
			console.log(`item.question_id: ${item.question_id}`);
			console.log(`Question ID: ${questionId}`);
			setQuestionId(item.question_id);
		};
	};
</script>

<div class="dev dev-div">
	<div id="list-header" class="dev dev-div flex flex-row justify-between">
		<h2 class="dev dev-div">List View</h2>

		<button onclick={onBackClick} class="dev dev-div dev-button">
			Back
		</button>
	</div>

	<div id="list-items" class="dev dev-div flex flex-col justify-left">
		{#if list.raw == "actions"}
			{#await queryActions}
				<p>Loading...</p>
			{:then result}
				{#if result.data}
					{#each result.data as action}
						<button onclick={onListClick} class="dev dev-div dev-list">
							{action.description}
						</button>
					{/each}
				{/if}
			{:catch error}
				<p>Error: {error.message}</p>
			{/await}
		{:else if list.raw}
			{#await queryQuestions}
				<p>Loading...</p>
			{:then result}
				{#if result.data}
					{#each result.data as question}
						<ListItem {question} />
					{/each}
				{/if}
			{:catch error}
				<p>Error: {error.message}</p>
			{/await}
		{:else}
			<div class="dev dev-div dev-list">
				<p>No list selected</p>
			</div>
		{/if}
	</div>
</div>