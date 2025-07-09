<script lang="ts">
	interface Props {
		title: string;
		onclick?: () => void;
	}

	const { title, onclick }: Props = $props();
</script>

<div id="{title}-header" class="view-header">
	<h2 class="text-accent-content flex items-center">{title}</h2>

	{#if onclick}
		<button {onclick} class="btn-nav border-primary"> Back </button>
	{/if}
</div>
