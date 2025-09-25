<script lang="ts">
	interface Props {
		canUndo: boolean;
		onclick: () => void;
	}

	let { canUndo, onclick }: Props = $props();
</script>

<button
	type="button"
	{onclick}
	disabled={!canUndo}
	class="btn-submit btn-sm"
	title="Undo last change (Ctrl+Z)"
>
	Undo
</button>