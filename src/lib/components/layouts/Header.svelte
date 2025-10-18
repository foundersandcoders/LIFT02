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

	// Long press for version display
	let showVersion = $state(false);
	let longPressTimer: ReturnType<typeof setTimeout> | null = null;

	const onLogoTouchStart = (e: TouchEvent) => {
		longPressTimer = setTimeout(() => {
			showVersion = true;
		}, 500);
	};

	const onLogoTouchEnd = () => {
		if (longPressTimer) {
			clearTimeout(longPressTimer);
			longPressTimer = null;
		}
		// Hide version after 2 seconds
		if (showVersion) {
			setTimeout(() => {
				showVersion = false;
			}, 2000);
		}
	};

	const onLogoTouchCancel = () => {
		if (longPressTimer) {
			clearTimeout(longPressTimer);
			longPressTimer = null;
		}
	};

	// For desktop: use mousedown/mouseup
	const onLogoMouseDown = () => {
		longPressTimer = setTimeout(() => {
			showVersion = true;
		}, 500);
	};

	const onLogoMouseUp = () => {
		if (longPressTimer) {
			clearTimeout(longPressTimer);
			longPressTimer = null;
		}
		// Hide version after 2 seconds
		if (showVersion) {
			setTimeout(() => {
				showVersion = false;
			}, 2000);
		}
	};

	const onLogoMouseLeave = () => {
		if (longPressTimer) {
			clearTimeout(longPressTimer);
			longPressTimer = null;
		}
	};
</script>

<header class="header">
	<div class="header-left">
		<div class="relative">
			<button
				id="brand-logo"
				class="logo-button cursor-pointer hover:opacity-80 transition-opacity"
				onclick={onLogoClick}
				ontouchstart={onLogoTouchStart}
				ontouchend={onLogoTouchEnd}
				ontouchcancel={onLogoTouchCancel}
				onmousedown={onLogoMouseDown}
				onmouseup={onLogoMouseUp}
				onmouseleave={onLogoMouseLeave}
				type="button"
				aria-label="Go to dashboard"
			>
				<img alt="LIFT logo" src="/logo/LIFT_logo_gradient_clean.svg" class="h-8 w-16 md:h-10 md:w-20" />
			</button>

			{#if showVersion}
				<div class="absolute top-full left-1/2 -translate-x-1/2 mt-1 bg-white text-gray-800 px-3 py-1 rounded-md shadow-lg text-sm font-medium whitespace-nowrap z-50">
					v{version}
				</div>
			{/if}
		</div>

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
