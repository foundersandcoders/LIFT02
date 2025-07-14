<script lang="ts">
	interface Props {
		show: boolean;
		title: string;
		message: string;
		onConfirm: () => Promise<void>;
		onSuccess?: () => void;
		onCancel: () => void;
	}

	let { show, title, message, onConfirm, onSuccess, onCancel }: Props = $props();

	let dialog = $state<HTMLDialogElement>();
	let previouslyFocused = $state<HTMLElement | null>(null);
	let isLoading = $state(false);
	let errorMessage = $state<string | null>(null);

	const handleConfirm = async () => {
		isLoading = true;
		errorMessage = null;

		try {
			const timeoutPromise = new Promise((_, reject) =>
				setTimeout(() => reject(new Error('Request timed out')), 8000)
			);

			await Promise.race([onConfirm(), timeoutPromise]);

			onSuccess?.();
			onCancel(); // Close modal on success
		} catch (error) {
			if (error instanceof Error && error.message === 'Request timed out') {
				errorMessage = 'The request timed out. Please check your connection and try again.';
			} else {
				errorMessage = 'The operation failed. Please try again.';
			}
			console.error('❌ Operation failed:', error);
		} finally {
			isLoading = false;
		}
	};

	$effect(() => {
		if (show && dialog) {
			previouslyFocused = document.activeElement as HTMLElement;
			errorMessage = null; // Reset error on show
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
				dialog.querySelectorAll(
					'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
				)
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
		if (show && e.key === 'Escape' && !isLoading) {
			onCancel();
		}
	}}
/>
{#if show}
	<dialog
		bind:this={dialog}
		class="modal"
		onclick={(event) => {
			if (event.currentTarget === event.target && !isLoading) {
				onCancel();
			}
		}}
		onkeydown={handleKeydown}
	>
		<div class="modal-box">
			<h3 class="text-lg font-bold">{title}</h3>
			<p class="py-4">{message}</p>
			{#if errorMessage}
				<div class="alert alert-error">{errorMessage}</div>
			{/if}
			<div class="modal-action">
				<button class="btn" onclick={onCancel} disabled={isLoading}>Cancel</button>
				<button class="btn btn-primary" onclick={handleConfirm} disabled={isLoading} data-autofocus>
					{#if isLoading}
						<span class="loading loading-spinner"></span>
						Processing...
					{:else}
						Confirm
					{/if}
				</button>
			</div>
		</div>
	</dialog>
{/if}
