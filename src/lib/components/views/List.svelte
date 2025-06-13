<script lang="ts">
	import type { ListCategory, View } from "$lib/types/ui";
	import { getUserActions } from "$lib/services/database/actions";
	import { getQuestionsByCategory } from "$lib/services/database/questions";
	import { getContext } from 'svelte';
	import ListItem from "$lib/components/cards/ListItem.svelte";
	
	const setView = getContext<(view:View) => void>('setView');

	const getList = getContext<() => ListCategory>('getList');
	const setList = getContext<(list:ListCategory) => void>('setList');
	let list = $derived(getList());

	const getProfileId = getContext<() => string>('getProfileId');
	let profileId = $derived(getProfileId());

	let queryActions = $derived(getUserActions(profileId));
	let queryQuestions = $derived(getQuestionsByCategory(list.raw));

	const onBackClick = () => {
		setView("dash");
		setList({ raw: "", format: "" });
	};
	const onListClick = () => { setView("detail") };
</script>

<div class="">
	<div id="list-header" class="flex justify-between">
		<h2 class="">List View</h2>

		<button onclick={onBackClick} class="btn btn-primary">
			Back
		</button>
	</div>

	<div id="list-items" class="flex flex-col justify-left">
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