<script lang="ts">
	import HelpButton from '../ui/HelpButton.svelte';

	interface Props {
		title: string;
		onclick?: () => void;
	}

	const { title, onclick }: Props = $props();
</script>

<div id="{title}-header" class="view-header">
	<h2 class="text-accent-content">{title}</h2>

	<div class="flex items-center gap-3">
		{#if onclick}
			<button {onclick} class="btn-nav border-primary"> Back </button>
		{/if}
		<HelpButton />
	</div>
</div>
