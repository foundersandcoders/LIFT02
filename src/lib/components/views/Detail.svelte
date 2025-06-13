<script lang="ts">
	import QuestionCard from "$lib/components/cards/QuestionCard.svelte";
	import { getQuestionById } from '$lib/services/database/questions';
	import type { RowId, TableName, ViewName } from '$lib/types/appState';
	import type { Question } from '$lib/types/tableMain';
	import { getContext } from 'svelte';

	const getQuestion = async (itemId: RowId) => {
		const result = await getQuestionById(itemId);
		return result.data || null;
	};

	const getTable = getContext<() => TableName>("getListTable");
	let table = $derived(getTable());

	const getDetailItemId = getContext<() => RowId>("getDetailItemId");
	let itemId = $derived(getDetailItemId());

	let question:Promise<Question|null> | null = $derived(
		(table == "questions" && itemId)
			? getQuestion(itemId)
			: null
	);

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const onclick = () => {
		setViewName('list');
	};
</script>

<div class="dev dev-div">
	<div id="detail-header" class="dev dev-div flex flex-row justify-between">
		<h2 class="dev dev-div">
			Detail View
		</h2>

		<div id="detail-source" class="dev dev-div">
			<pre>{table}</pre>
		</div>

		<button {onclick} class="dev dev-div dev-button">
			Back
		</button>
	</div>

	<div id="detail-content" class="dev dev-div">
		{#if table == "questions"}
			{#await question}
				<p>Loading...</p>
			{:then question}
				{#if question?.id}
					<QuestionCard questionId={question.id} />
				{:else}
					No question found
				{/if}
			{/await}
		{:else if table == "actions"}
			<p>Action Card TBD</p>
		{:else}
			<p>Error displaying {table}</p>
		{/if}
	</div>
</div>
