<script lang="ts">
	import type { View } from "$lib/types/ui";
	import { getContext } from 'svelte';
	import QuestionCard from "$lib/components/cards/QuestionCard.svelte";

	const getQuestionId = getContext<() => string>('getQuestionId');
	let questionId = $derived(getQuestionId());

	const setView = getContext<(view:View) => void>('setView');

	const onBackClick = () => { setView("list") };
</script>

<div class="dev dev-div">
	<div id="detail-header" class="dev dev-div flex flex-row justify-between">
		<h2 class="dev dev-div">Detail View</h2>

		<div class="dev dev-div">
			{#if}
				{#if questionId}{questionId}{:else}No question ID{/if}
			{/if}
		</div>

		<button onclick={onBackClick} class="dev dev-div dev-button">
			Back
		</button>
	</div>

	<div id="detail-content" class="dev dev-div">
		<QuestionCard questionId={"1"} />
	</div>
</div>