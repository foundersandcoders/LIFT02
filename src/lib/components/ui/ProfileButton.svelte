<script lang="ts">
	import { getContext } from 'svelte';
	import { Icon, User } from 'svelte-hero-icons';
	import type { AppState } from '$lib/types/appState';
	import Tooltip from './Tooltip.svelte';
	import ProfileSettingsModal from './ProfileSettingsModal.svelte';

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const hasProfile = $derived(!!app.profile.id);

	let showModal = $state(false);

	function handleClick() {
		showModal = true;
	}

	function handleClose() {
		showModal = false;
	}
</script>

{#if hasProfile}
	<Tooltip text="Edit your profile settings" position="top">
		<button
			id="profile-button"
			onclick={handleClick}
			class="flex h-10 w-10 items-center justify-center rounded-full border-2 border-white bg-transparent text-white group"
			type="button"
			aria-label="Profile Settings"
		>
			<Icon src={User} solid class="h-5 w-5 transition-transform group-hover:scale-125" />
		</button>
	</Tooltip>

	<ProfileSettingsModal show={showModal} onclose={handleClose} />
{/if}
