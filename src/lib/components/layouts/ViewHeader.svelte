<script lang="ts">
	interface Props {
		title: string;
		onclick?: () => void;
	}

	const { title, onclick }: Props = $props();
</script>

<div
	id="{title}-header"
	class="prose bg-accent flex w-screen flex-row items-center justify-between p-4"
>
	<h2 class="text-accent-content flex items-center">{title}</h2>

	{#if onclick}
		<button {onclick} class="btn-nav border-primary"> Back </button>
	{:else}
		<div class="btn-nav invisible opacity-0">Back</div>
	{/if}
</div>
