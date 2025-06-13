<script lang="ts">
	import type { TableName, ViewName } from '$lib/types/appState';
	import { getContext } from 'svelte';
	import QuestionCard from "$lib/components/cards/QuestionCard.svelte";

	const getQuestion = getContext<() => string>('getQuestionId');
	const getTable = getContext<() => TableName>("getListTable")

	let queryTable = $derived(getTable());
	let questionId = $derived(getQuestion());

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const onBackClick = () => {
		setViewName('list');
	};
</script>

<div class="dev dev-div">
	<div id="detail-header" class="dev dev-div flex flex-row justify-between">
		<h2 class="dev dev-div">Detail View</h2>

		<div class="dev dev-div">
			{queryTable}
		</div>

		<button onclick={onBackClick} class="dev dev-div dev-button"> Back </button>
	</div>

	<div id="detail-content" class="dev dev-div">
			{#if queryTable == "questions"}
				{#if questionId}
					<QuestionCard {questionId} />
				{:else}
					No question ID
				{/if}
			{/if}
	</div>
</div>
