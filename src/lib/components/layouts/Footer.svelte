<script lang="ts">
	import { dev } from '$app/environment';
	import StateTable from '$lib/components/logic/StateTable.svelte';
	import { getContext } from 'svelte';
	import type { Profile } from '$lib/types/appState';
	import InfoModal from '../ui/InfoModal.svelte';
	import { Icon, ClipboardDocumentList, ShieldCheck } from 'svelte-hero-icons';

	let { devMode, profileId } = $props();

	const toggleDevMode = getContext<() => void>('setDevMode');
	const onToggleDevMode = () => {
		toggleDevMode();
	};

	let showTermsModal = $state(false);
	let showPrivacyModal = $state(false);

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
	<div id="footer-content" class="mt-2 flex w-full flex-row items-center justify-around">
		<!-- <div id="footer-profile" class="flex flex-col justify-around px-2 py-2 h-full">
			<div>
				<p class="flex items-center h-8 text-sm mt-1">{#if profileId} Logged In {:else} Not Logged In {/if}</p>
			</div>
		</div> -->

		<!-- Left spacer for balance -->
		<!-- <div class="flex-1"></div> -->

		<!-- Legal buttons centered -->
		<button class="btn btn-ghost btn-sm" onclick={() => (showTermsModal = true)}>
			<Icon src={ClipboardDocumentList} class="h-5 w-5" />
			<span class="text-center">Terms of Use</span>
		</button>
		<button class="btn btn-ghost btn-sm" onclick={() => (showPrivacyModal = true)}>
			<Icon src={ShieldCheck} class="h-5 w-5" />
			<span class="text-center">Privacy Policy</span>
		</button>

		<!-- ========== TESTING ONLY - REMOVE WHEN DONE ========== -->
		{#if !profileId}
			<div class="dropdown dropdown-top dropdown-end">
				<button
					type="button"
					class="btn btn-sm text-xs"
					onclick={toggleDropdown}
					onkeydown={(e) => (e.key === 'Enter' || e.key === ' ' ? toggleDropdown() : null)}
					aria-label="Select test user for development"
					aria-expanded={dropdownExpanded}
					aria-haspopup="listbox"
				>
					User
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
</footer>

{#if devMode}
	<StateTable />
{/if}

<InfoModal show={showTermsModal} title="Terms of Use" onclose={() => (showTermsModal = false)}>
	<h2>1. Introduction</h2>
	<p>
		Welcome to Workwise ("Service"), a workplace passport application provided by LIFT. By using our
		Service, you agree to these Terms of Use. Please read them carefully.
	</p>
	<p>
		The Service allows you to create, maintain, and selectively share workplace statements about
		your preferences, needs, and working style with your line managers and employers.
	</p>

	<h2>2. User Accounts</h2>
	<p>
		Authentication is provided through a secure magic link system sent to your email address. You
		are responsible for:
	</p>
	<ul>
		<li>Maintaining the security of your email account</li>
		<li>Only using magic links sent directly to your email</li>
		<li>Notifying us of any unauthorized access</li>
	</ul>
	<p>
		If you register with a new email address, a new passport will be created that cannot be merged
		with existing data. This is intentional for data protection reasons.
	</p>

	<h2>3. Your Content</h2>
	<p>You retain ownership of all content you create through our Service. By using Workwise, you:</p>
	<ul>
		<li>Are responsible for the accuracy of your statements</li>
		<li>Control which statements are marked as "public" and can be shared</li>
		<li>Decide when to share information with your line manager</li>
		<li>Can update or delete your content at any time</li>
	</ul>

	<h2>4. Acceptable Use</h2>
	<p>You agree not to use Workwise to:</p>
	<ul>
		<li>Create or share statements that are harmful, offensive, or discriminatory</li>
		<li>Attempt to gain unauthorized access to other users' data</li>
		<li>Upload malicious code or attempt to compromise the service</li>
		<li>Impersonate others or provide false information</li>
	</ul>

	<h2>5. Legal Terms</h2>
	<p>
		<strong>Service Modifications:</strong> We may modify or discontinue the Service at any time with
		reasonable notice.
	</p>
	<p>
		<strong>Limitation of Liability:</strong> To the fullest extent permitted by law, LIFT shall not
		be liable for any indirect, incidental, special, consequential, or punitive damages.
	</p>
	<p>
		<strong>Governing Law:</strong> These Terms are governed by the laws of [Jurisdiction], without regard
		to its conflict of law principles.
	</p>
</InfoModal>

<InfoModal
	show={showPrivacyModal}
	title="Privacy Policy"
	onclose={() => (showPrivacyModal = false)}
>
	<h2>How We Protect Your Data</h2>
	<p>
		At Workwise, we prioritize your privacy and ensure your personal information is handled
		securely.
	</p>
	<ul>
		<li>Your data is encrypted both in transit and at rest</li>
		<li>We use secure passwordless authentication (Magic Links) to protect your account</li>
		<li>We only collect the minimum information needed to provide our service</li>
		<li>You retain complete control over your data at all times</li>
	</ul>

	<h2>Your Rights</h2>
	<p>Under data protection law, you have the right to:</p>
	<ul>
		<li>Access your personal data</li>
		<li>Correct inaccurate data</li>
		<li>Request deletion of your data</li>
		<li>Restrict or object to processing of your data</li>
		<li>Obtain and reuse your data (data portability)</li>
		<li>Withdraw consent at any time</li>
	</ul>

	<h2>Data Sharing</h2>
	<p>We only share your data:</p>
	<ul>
		<li>With your explicit consent</li>
		<li>Only statements marked as "public" can be shared with your line manager</li>
		<li>You control when and how your data is shared</li>
		<li>Email sharing is initiated by you and only sent to the email address you provide</li>
	</ul>
</InfoModal>
