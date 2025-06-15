<script lang="ts">
	import type { View, Detail } from '$lib/types/ui';
	import { getContext } from 'svelte';
	import QuestionCard from '$lib/components/cards/QuestionCard.svelte';

	const setView = getContext<(view: View) => void>('setView');

	const getDetail = getContext<() => Detail>('getDetail');
	let detail = $derived(getDetail());

	const onBackClick = () => {
		setView('list');
	};
	const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';
</script>

<div class="bg-base-200 p-0">
	<button onclick={onBackClick} class="btn btn-primary text-primary-content mt-2 ml-4">
		Back
	</button>

	<div id="detail-content" class="">
		{#if detail == 'response'}
			<QuestionCard {questionId} />
		{:else if detail == 'action'}
			<pre>Action To Do</pre>
		{:else if detail == 'email'}
			<pre>Email Preview To Do</pre>
		{:else}
			<pre>No Content Loaded</pre>
		{/if}
	</div>
</div>
