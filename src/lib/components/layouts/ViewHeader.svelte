<script lang="ts">
	import Breadcrumb from '../ui/Breadcrumb.svelte';

	interface Props {
		title: string;
		onclick?: () => void;
	}

	const { title, onclick }: Props = $props();
</script>

<div id="{title}-header" class="view-header">
	<Breadcrumb />

	<!-- Back button commented out - use breadcrumb navigation instead -->
	<!-- <div class="flex items-start gap-2 md:gap-3">
		{#if onclick}
			<button {onclick} class="btn-nav" aria-label="Go back">
				<svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
					<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
				</svg>
				<span>Back</span>
			</button>
		{/if}
	</div> -->
</div>
