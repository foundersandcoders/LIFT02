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

	const onLogoClick = () => {
		setViewName('dash');
	};
</script>

<header class="header">
	<div class="header-left">
		<button
			id="brand-logo"
			class="logo-button cursor-pointer hover:opacity-80 transition-opacity"
			onclick={onLogoClick}
			type="button"
			aria-label="Go to dashboard"
		>
			<img alt="LIFT logo" src="/logo/LIFT_logo_gradient_clean.svg" class="h-10 w-20" />
		</button>

		<h1>Workwise</h1>
	</div>

	<div class="header-right">
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
						class="w-10 h-10 rounded-full border-2 border-white bg-transparent flex items-center justify-center hover:bg-white hover:bg-opacity-20 transition-colors disabled:opacity-50"
						type="button"
						aria-label="Send Email to Line Manager"
						disabled={isInEmailView}
					>
						<Icon src={Envelope} solid class="h-5 w-5 text-white" />
					</button>
				</Tooltip>
			{/if}

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
	</div>
</header>
