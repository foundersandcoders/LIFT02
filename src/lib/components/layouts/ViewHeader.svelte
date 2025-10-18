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

	<div class="flex items-start gap-2 pt-1 md:gap-3">
		<HelpButton />
	</div>
</div>
