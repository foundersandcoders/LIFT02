<script lang="ts">
	import { dev } from '$app/environment';
	import StateTable from '$lib/components/logic/StateTable.svelte';
	import { getContext } from 'svelte';
	import type { Profile } from '$lib/types/appState';

	let { devMode, profileId } = $props();

	const toggleDevMode = getContext<() => void>('setDevMode');
	const onToggleDevMode = () => {
		toggleDevMode();
	};

	// ========== TESTING ONLY - REMOVE WHEN DONE ==========
	const getTestUsers = getContext<() => Profile[]>('getTestUsers');
	const setTestUser = getContext<(userId: string, userName: string) => void>('setTestUser');

	const sortedTestUsers = $derived(
		[...(getTestUsers() || [])]
			.filter(
				(user): user is Profile & { id: string; name: string } =>
					user.id !== null && user.name !== null && user.is_line_manager === false
			)
			.sort((a, b) => a.id.localeCompare(b.id))
	);

	let dropdownExpanded = $state(false);
	let selectedUserId = $state<string | null>(null);

	function handleUserSelect(userId: string, userName: string) {
		setTestUser(userId, userName);
		selectedUserId = userId;
		console.log('Test user selected:', userName, userId);

		// Close dropdown after selection
		dropdownExpanded = false;
		const dropdown = document.activeElement as HTMLElement;
		dropdown?.blur();
	}

	function toggleDropdown() {
		dropdownExpanded = !dropdownExpanded;
	}
	// ======================================================
</script>

<footer id="footer" class="footer">
	<div id="footer-content" class="footer-content">
		<div id="footer-profile" class="flex flex-col justify-around p-4 h-full">
			<div>
				<p class="flex items-center h-8 text-sm">{#if profileId} Logged In {:else} Not Logged In {/if}</p>
			</div>
		</div>

		<div id="footer-dev" class="p-4 h-full">
			{#if devMode} <!-- Dev Mode Warning -->
				<p>Dev Mode</p>
			{/if}

			<!-- Dev Mode Toggle (Development Only) 
			<button
				onclick={onToggleDevMode}
				class="btn-dev"
				type="button"
				aria-label="Toggle development mode"
			>Dev</button> -->

			<!-- ========== TESTING ONLY - REMOVE WHEN DONE ========== -->
			{#if !profileId}
				<div class="dropdown dropdown-top dropdown-end">
					<button
						type="button"
						class="btn btn-sm m-1 text-xs"
						onclick={toggleDropdown}
						onkeydown={(e) => (e.key === 'Enter' || e.key === ' ' ? toggleDropdown() : null)}
						aria-label="Select test user for development"
						aria-expanded={dropdownExpanded}
						aria-haspopup="listbox"
					>
						User ⬆️
					</button>
					<ul
						class="dropdown-content menu bg-base-100 rounded-box text-base-content z-1 w-52 p-2 shadow-sm"
						role="listbox"
						aria-label="Available test users"
					>
						{#each sortedTestUsers as user (user.id)}
							<li role="option" aria-selected={selectedUserId === user.id}>
								<button
									onclick={() => handleUserSelect(user.id, user.name)}
									class="text-left"
									aria-label="Select {user.name} as test user"
								>
									<span class="text-xs opacity-60">{user.id.slice(-2)}</span>
									{user.name}
								</button>
							</li>
						{/each}
					</ul>
				</div>
			{/if}
			<!-- ====================================================== -->
		</div>
	</div>
</footer>

{#if devMode}
	<StateTable />
{/if}
