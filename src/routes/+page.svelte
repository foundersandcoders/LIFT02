<script lang="ts">
	import { getContext } from 'svelte';
	import Dash from "$lib/components/views/Dash.svelte";
	import List from "$lib/components/views/List.svelte";
	import Detail from "$lib/components/views/Detail.svelte";
	import type { View } from "$lib/types/ui";

	// import '$lib/components/QuestionCard.svelte';
	// import QuestionCard from '$lib/components/QuestionCard.svelte';
	// import { getQuestionById, getQuestions } from '$lib/services/database/questions';

	//Delete later --> This needs to manually updated every time you db reset
	// const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';

	const getView = getContext<() => View>('view');
</script>

<main id="view" class="dev">
	{#if getView() === "dash"}
		<Dash />
	{:else if getView() === "list"}
		<List />
	{:else if getView() === "detail"}
		<Detail />
	{/if}
</main>

<!-- <QuestionCard {questionId} /> -->