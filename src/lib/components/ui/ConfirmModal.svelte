<script lang="ts">
	interface Props {
		show: boolean;
		title: string;
		message: string;
		onConfirm: () => void;
		onCancel: () => void;
	}

	let { show, title, message, onConfirm, onCancel }: Props = $props();
</script>

{#if show}
	<dialog class="modal modal-open">
		<div class="modal-box">
			<h3 class="font-bold text-lg">{title}</h3>
			<p class="py-4">{message}</p>
			<div class="modal-action">
				<button class="btn" onclick={onCancel}>Cancel</button>
				<button class="btn btn-primary" onclick={onConfirm}>Confirm</button>
			</div>
		</div>
	</dialog>
{/if}
