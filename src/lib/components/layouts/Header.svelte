<script lang="ts">
	import { getContext } from 'svelte';
	import type { AppState, ViewName } from '$lib/types/appState';
	import Tooltip from '../ui/Tooltip.svelte';
	import { Icon, Envelope } from 'svelte-hero-icons';
	import { version } from '$lib/version';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());

	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	// Check if currently in email view
	const isInEmailView = $derived(app.view.name === 'email');
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
				<img alt="LIFT logo" src="/logo/LIFT_logo_gradient_clean.svg" class="h-8 w-auto sm:h-10" />
			</div>

			<div id="app-name" class="header-container-name flex flex-row items-end gap-2">
				<h1>Workwise</h1>
				<p class="text-sm">{version}</p>
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
			{#if app.profile.id}
				<Tooltip
					text={isInEmailView
						? 'Currently viewing email preview'
						: 'Generate an email summary of your responses and actions to share with your line manager'}
					position="bottom_left"
				>
					<button
						id="email-button"
						onclick={onEmailClick}
						class="btn-nav"
						type="button"
						aria-label="Send Email to Line Manager"
						disabled={isInEmailView}
					>
						<Icon src={Envelope} solid class="h-6 w-6" />
					</button>
				</Tooltip>
			{/if}
		</div>
	</div>
</header>
