<script lang="ts">
	import QuestionCard from '$lib/components/cards/QuestionCard.svelte';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import { getQuestionById } from '$lib/services/database/questions';
	import { getActionById } from '$lib/services/database/actions';
	import type { ItemCategory, RowId, TableName, ViewName } from '$lib/types/appState';
	import type { Question } from '$lib/types/tableMain';
	import { getContext } from 'svelte';

	const getQuestion = async (itemId: RowId) => {
		const result = await getQuestionById(itemId);
		return result.data || null;
	};

	const getTable = getContext<() => TableName>('getListTable');
	let table = $derived(getTable());

	const getDetailItemId = getContext<() => RowId>('getDetailItemId');
	let itemId = $derived(getDetailItemId());

	const getCategory = getContext<() => ItemCategory>('getListCategory');
	let category = $derived(getCategory());

	let question: Promise<Question | null> | null = $derived(
		table == 'questions' && itemId ? getQuestion(itemId) : null
	);

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	const title = $derived(table === 'questions' ? 'Your Response' : 'Your Actions');
	const onclick = () => {
		setViewName('list');
	};
</script>

<div id="detail-view" class="dev dev-div">
	<ViewHeader {title} {onclick} />

	<div id="detail-content" class="dev dev-div">
		{#if table == 'questions'}
			{#await question}
				<p>Loading...</p>
			{:then question}
				{#if question?.id}
					<QuestionCard questionId={question.id} />
				{:else}
					No question found
				{/if}
			{/await}
		{:else if table == 'actions' && itemId}
			{#await getActionById(itemId)}
				<p>Loading action...</p>
			{:then result}
				{#if result?.data}
					<p>Action: {result.data.description || 'No description'}</p>
					<p>Type: {result.data.type}</p>
					<p>Status: {result.data.status}</p>
				{:else}
					<p>Action not found</p>
				{/if}
			{:catch error}
				<p>Error loading action: {error.message}</p>
			{/await}
		{:else}
			<p>Error displaying {table}</p>
		{/if}
	</div>
</div>
