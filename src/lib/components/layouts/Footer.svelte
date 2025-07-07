<script lang="ts">
	import { dev } from '$app/environment';
	import StateTable from '$lib/components/logic/StateTable.svelte';
	import { getContext } from 'svelte';

	let { devMode, profileId } = $props();

	const toggleDevMode = getContext<() => void>('setDevMode');
	const onToggleDevMode = () => {
		toggleDevMode();
	};

	// ========== TESTING ONLY - REMOVE WHEN DONE ==========
	const getTestUsers = getContext<() => any[]>('getTestUsers');
	const setTestUser = getContext<(userId: string, userName: string) => void>('setTestUser');

	function handleUserSelect(userId: string, userName: string) {
		setTestUser(userId, userName);
		console.log('Test user selected:', userName, userId);

		// Close dropdown after selection
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}
	// ======================================================
</script>

<footer
	id="footer"
	class="bg-primary text-primary-content footer footer-center w-full flex-shrink-0"
>
	<div id="footer-content" class="flex w-full justify-between">
		<div id="footer-content-profile" class="p-4">
			<p class="text-sm">
				{#if profileId}
					Profile ID: {profileId}
				{:else}
					Not Logged In
				{/if}
			</p>
		</div>

		<div id="footer-content-dev-mode" class="p-4">
			{#if devMode}<p>Dev Mode</p>{/if}
		</div>

		<div id="footer-content-dev" class="p-4">
			<!-- Dev Mode Toggle
				(Development Only)
			-->
			<!-- <button
				onclick={onToggleDevMode}
				class="btn-dev"
				type="button"
				aria-label="Toggle development mode"
			>
				Dev
			</button> -->

			<!-- ========== TESTING ONLY - REMOVE WHEN DONE ========== -->
			<div class="dropdown dropdown-top dropdown-end">
				<div tabindex="0" role="button" class="btn m-1">Select User ⬆️</div>
				<ul
					class="dropdown-content menu bg-base-100 rounded-box text-base-content z-1 w-52 p-2 shadow-sm"
				>
					{#each [...getTestUsers()].sort((a, b) => a.id.localeCompare(b.id)) as user (user.id)}
						<li>
							<button onclick={() => handleUserSelect(user.id, user.name)} class="text-left">
								<span class="text-xs opacity-60">{user.id.slice(-2)}</span>
								{user.name}
							</button>
						</li>
					{/each}
				</ul>
			</div>
			<!-- ====================================================== -->
		</div>
	</div>
</footer>

{#if devMode}
	<StateTable />
{/if}
