<script lang="ts">
	import { getContext } from 'svelte';

	const toggleDevMode = getContext<() => void>('toggleDevMode');
	const onToggleDevMode = () => { toggleDevMode() };
</script>

<header class="sticky top-0 z-50 w-full border-b border-gray-200 bg-white">
	<div class="flex h-16 items-center justify-between px-4 sm:px-6 lg:px-8">
		<!-- Logo and App Name -->
		<div class="flex items-center space-x-3">
			<img
				src="/Logos/LIFT_logo_gradient_clean.svg"
				alt="Neacons logo"
				class="h-8 w-auto sm:h-10"
			/>
			<h1 class="text-xl font-bold tracking-tight text-gray-900 sm:text-2xl">Neacons</h1>
		</div>

		<!-- Dev Mode Toggle (Development Only) -->
		<button
			onclick={onToggleDevMode}
			class="button inline-flex items-center rounded-md border border-gray-300 bg-gray-100 px-3 py-2 text-sm font-medium text-gray-700 transition-colors duration-200 hover:bg-gray-200 focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:outline-none"
			type="button"
			aria-label="Toggle development mode"
		>
			<span class="sr-only">Toggle</span>
			Dev Mode
		</button>
	</div>
</header>