<script lang="ts">
	import type { HelpContent } from '$lib/types/help';

	let {
		show,
		helpContent,
		onclose
	} = $props<{
		show: boolean;
		helpContent: HelpContent | null;
		onclose: () => void;
	}>();

	let dialog = $state<HTMLDialogElement>();
	let previouslyFocused = $state<HTMLElement | null>(null);

	$effect(() => {
		if (show && dialog) {
			previouslyFocused = document.activeElement as HTMLElement;
			document.body.inert = true;
			dialog.showModal();
			const autofocusElement = dialog.querySelector<HTMLElement>('[data-autofocus]');
			if (autofocusElement) {
				autofocusElement.focus();
			}
		} else if (!show && dialog) {
			dialog.close();
			document.body.inert = false;
			if (previouslyFocused) {
				previouslyFocused.focus();
				previouslyFocused = null;
			}
		}
	});
</script>

<svelte:window
	onkeydown={(e) => {
		if (show && e.key === 'Escape') {
			onclose();
		}
	}}
/>

{#if show && helpContent}
	<dialog
		bind:this={dialog}
		class="modal"
		onclick={(event) => {
			if (event.currentTarget === event.target) {
				onclose();
			}
		}}
	>
		<div class="modal-box modal-box-help">
			<h3 class="text-lg font-bold mb-4">{helpContent.title}</h3>
			
			<div class="prose max-w-none space-y-6">
				{#each helpContent.sections as section}
					<div class="help-section">
						{#if section.heading}
							<h4 class="text-base font-semibold mb-2">{section.heading}</h4>
						{/if}
						
						<p class="mb-4">{section.text}</p>
						
						{#if section.screenshot}
							<div class="screenshot-container mb-4">
								<div class="screenshot-placeholder bg-base-200 border-2 border-dashed border-base-300 rounded-lg p-8 text-center max-w-2xl">
									<p class="text-base-content/50 text-sm">
										📷 Screenshot: {section.screenshot.caption || section.screenshot.alt}
									</p>
									<p class="text-xs text-base-content/40 mt-2">
										(Screenshots will be added in a future update)
									</p>
								</div>
								<!-- 
								<img
									src={section.screenshot.src}
									alt={section.screenshot.alt}
									class="rounded-lg border border-base-300 shadow-md w-full max-w-2xl"
									onerror="this.style.display='none'; this.nextElementSibling.style.display='block';"
								/>
								<div class="screenshot-placeholder bg-base-200 border-2 border-dashed border-base-300 rounded-lg p-8 text-center max-w-2xl" style="display: none;">
									<p class="text-base-content/50 text-sm">
										📷 Screenshot: {section.screenshot.caption || section.screenshot.alt}
									</p>
								</div>
								-->
								{#if section.screenshot.caption}
									<p class="text-sm text-base-content/70 mt-2 italic">{section.screenshot.caption}</p>
								{/if}
							</div>
						{/if}
						
						{#if section.callouts}
							<ul class="list-disc list-inside space-y-1 bg-base-200 p-4 rounded-lg">
								{#each section.callouts as callout}
									<li class="text-sm">{callout}</li>
								{/each}
							</ul>
						{/if}
					</div>
				{/each}
			</div>
			
			<div class="modal-action">
				<button class="btn btn-primary" onclick={onclose} data-autofocus>Close</button>
			</div>
		</div>
	</dialog>
{/if}

