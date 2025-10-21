<script lang="ts">
	import Tooltip from './Tooltip.svelte';

	interface Props {
		canUndo: boolean;
		onclick: () => void;
	}

	let { canUndo, onclick }: Props = $props();
</script>

<Tooltip text="Undo last change (Ctrl+Z)" position="top">
	<button
		type="button"
		{onclick}
		disabled={!canUndo}
		class="btn-submit btn-sm"
	>
		Undo
	</button>
</Tooltip>