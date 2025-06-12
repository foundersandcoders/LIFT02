<script lang="ts">
	import type { View } from '$lib/types/ui';
	import { getContext } from 'svelte';
	import QuestionCard from '$lib/components/cards/QuestionCard.svelte';

	const setView = getContext<(view: View) => void>('setView');

	const onBackClick = () => {
		setView('list');
	};

	const questionId = 'bacc6ffa-b589-4bdc-8eb8-d29eeef7f153';
</script>

<div class="dev dev-div">
	<div id="detail-header" class="dev dev-div flex flex-row justify-between">
		<h2 class="dev dev-div">Detail View</h2>

		<button onclick={onBackClick} class="dev dev-div dev-button"> Back </button>
	</div>

	<div id="detail-content" class="dev dev-div">
		<QuestionCard {questionId} />
	</div>
</div>
