<script lang="ts">
	import HelpButton from '../ui/HelpButton.svelte';
	import Breadcrumb from '../ui/Breadcrumb.svelte';

	interface Props {
		title: string;
		onclick?: () => void;
	}

	const { title, onclick }: Props = $props();
</script>

<div id="{title}-header" class="view-header">
	<Breadcrumb />

	<div class="flex items-center gap-3">
		{#if onclick}
			<button {onclick} class="btn-nav border-primary"> Back </button>
		{/if}
		<HelpButton />
	</div>
</div>
