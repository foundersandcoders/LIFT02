<script lang="ts">
	interface Props {
		show: boolean;
		title: string;
		message: string;
		onConfirm: () => void;
		onCancel: () => void;
	}

	let { show, title, message, onConfirm, onCancel }: Props = $props();

	let dialog = $state<HTMLDialogElement>();
	let previouslyFocused = $state<HTMLElement | null>(null);

	$effect(() => {
		if (show && dialog) {
			previouslyFocused = document.activeElement as HTMLElement;
			dialog.showModal();
			const autofocusElement = dialog.querySelector<HTMLElement>('[data-autofocus]');
			if (autofocusElement) {
				autofocusElement.focus();
			}
		} else if (!show && dialog && previouslyFocused) {
			dialog.close();
			previouslyFocused.focus();
			previouslyFocused = null;
		}
	});

	function handleKeydown(e: KeyboardEvent) {
		if (!dialog) return;
		if (e.key === 'Tab') {
			const focusable = Array.from(
				dialog.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])')
			) as HTMLElement[];
			const first = focusable[0];
			const last = focusable[focusable.length - 1];

			if (e.shiftKey && document.activeElement === first) {
				last.focus();
				e.preventDefault();
			} else if (!e.shiftKey && document.activeElement === last) {
				first.focus();
				e.preventDefault();
			}
		}
	}
</script>

<svelte:window
	onkeydown={(e) => {
		if (show && e.key === 'Escape') {
			onCancel();
		}
	}}
/>
{#if show}
	<dialog
		bind:this={dialog}
		class="modal"
		onclick={(event) => {
			if (event.currentTarget === event.target) {
				onCancel();
			}
		}}
		onkeydown={handleKeydown}
	>
		<div class="modal-box">
			<h3 class="text-lg font-bold">{title}</h3>
			<p class="py-4">{message}</p>
			<div class="modal-action">
				<button class="btn" onclick={onCancel}>Cancel</button>
				<button class="btn btn-primary" onclick={onConfirm} data-autofocus>Confirm</button>
			</div>
		</div>
	</dialog>
{/if}
