<script lang="ts">
	import { getContext } from 'svelte';
	import Button from '$lib/components/ui/Button.svelte';

	const toggleDevMode = getContext<() => void>('toggleDevMode');
	const onToggleDevMode = () => { toggleDevMode() };
</script>

<header class="sticky top-0 z-50 w-full border-b border-gray-200 bg-white">
	<div class="p-0 flex h-16 items-center justify-between px-4 sm:px-6 lg:px-8">
		<!-- Logo and App Name. Forcing uppercase for consistency -->
		<div class="flex items-center space-x-3">
			<img
				src="/Logos/LIFT_logo_gradient_clean.svg"
				alt="Neacons logo"
				class="h-8 w-auto sm:h-10"
			/>
			<h1 class="text-xl font-bold tracking-tight text-gray-900 sm:text-2xl">Neacons</h1>
		</div>

		<!-- Action Buttons -->
		<div class="flex items-center space-x-3">
			<!-- Dev Mode Toggle (Development Only) -->
			<button
				onclick={onToggleDevMode}
				class="btn btn-primary text-base-100"
				type="button"
				aria-label="Toggle development mode"
			>
				<span class="sr-only">Toggle</span>
				Dev Mode
			</button>

			<!-- Profile Button - to replace dev-mode button
			<Button class="hidden" text="Profile" variant="primary" onclick={() => {}} />
		-->
		</div>
	</div>
</header>
