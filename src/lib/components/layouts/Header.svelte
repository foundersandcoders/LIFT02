<script lang="ts">
	import { getContext } from 'svelte';
	import type { ViewName } from '$lib/types/appState';

	const setViewName = getContext<(view: ViewName) => void>('setViewName');
	const onProfileClick = () => {
		// setViewName('profile');
		console.log('Profile Clicked');
	};
	const onEmailClick = () => {
		setViewName('email');
	};
</script>

<header class="bg-primary sticky top-0 z-50 w-full flex-shrink-0 border-b border-gray-200">
	<div
		id="header-content"
		class="flex h-16 w-full max-w-full flex-row items-center justify-between px-4 sm:px-6 lg:px-8"
	>
		<div id="header-content-brand-logo">
			<img
				alt="Neacons logo"
				src="/Logos/LIFT_logo_gradient_clean.svg"
				class="h-8 w-auto sm:h-10"
			/>
		</div>

		<div id="header-content-brand-name" class="h-8 w-auto sm:h-10">
			<h1 class="text-primary-content text-xl font-bold tracking-tight uppercase">Neacons</h1>
		</div>

		<div id="header-content-buttons" class="flex items-center space-x-3">
			<button onclick={onProfileClick} class="btn-nav" type="button" aria-label="View Profile">
				Profile
			</button>

			<button
				onclick={onEmailClick}
				class="btn-nav"
				type="button"
				aria-label="Send Email to Line Manager"
			>
				<span>Send Email</span>
			</button>
		</div>
	</div>
</header>
