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

<header class="header">
	<div id="header-content" class="header-content">
		<div id="header-left" class="header-left">
			<div id="brand-logo" class="header-container-logo">
				<img
					alt="LIFT logo"
					src="/logo/LIFT_logo_gradient_clean.svg"
					class="h-8 w-auto sm:h-10"
				/>
			</div>

			<div id="app-name" class="header-container-name">
				<h1>LIFT App 0.6</h1>
			</div>
		</div>

		<div id="header-right" class="flex items-center space-x-3">
			<!-- Profile Button -->
			<!-- <button
				id="profile-button"
				onclick={onProfileClick}
				class="btn-nav"
				type="button"
				aria-label="View Profile"
			>
				Profile
			</button> -->

			<!-- Email Button -->
			<button
				id="email-button"
				onclick={onEmailClick}
				class="btn-nav"
				type="button"
				aria-label="Send Email to Line Manager"
			>
				Email Preview
			</button>
		</div>
	</div>
</header>
