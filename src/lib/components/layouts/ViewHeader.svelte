<script lang="ts">
	interface Props {
		title: string;
		onclick?: () => void;
	}

	const { title, onclick }: Props = $props();
</script>

<div
	id="{title}-header"
	class="prose bg-accent w-screen flex flex-row items-center justify-between p-4 -mx-2"
>
	<h2 class="text-accent-content">{title}</h2>

	{#if onclick}
		<button {onclick} class="btn-nav border-primary"> Back </button>
	{/if}
</div>
