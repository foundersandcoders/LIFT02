<script lang="ts">
	import { getContext } from 'svelte';
	import ViewHeader from '../layouts/ViewHeader.svelte';
	import DashTile from '../cards/DashTile.svelte';
	import Tooltip from '../ui/Tooltip.svelte';
	import InfoModal from '../ui/InfoModal.svelte';
	import { getLatestActions } from '$lib/services/database/actions';
	import { getQuestions } from '$lib/services/database/questions';
	import { getResources } from '$lib/services/database/resources';
	import { getUserResponses } from '$lib/services/database/responses';
	import type { Question, Response } from '$lib/types/tableMain';
	import type { AppState, ItemCategory, List, TableName, ViewName, Profile } from '$lib/types/appState';
	import { makePretty } from '$lib/utils/textTools';

	let showTermsModal = $state(false);
	let showPrivacyModal = $state(false);

	const getApp = getContext<() => AppState>('getApp');
	const app = $derived(getApp());
	const setList = getContext<(list: List) => void>('setList');
	const setViewName = getContext<(view: ViewName) => void>('setViewName');

	let queryActions = $derived(app.profile.id ? getLatestActions(app.profile.id, false) : null);
	let queryQuestions = $state(getQuestions());
	let queryResources = $state(getResources());
	let queryResponses = $derived(app.profile.id ? getUserResponses(app.profile.id) : null);

	function extractCategories(questions: Question[]): ItemCategory[] {
		// TODO: Move extractCategories() to a utils file
		const categoriesRaw: string[] = questions.map((question: Question) => question.category);
		const categoriesUnique = [...new Set(categoriesRaw)];

		return categoriesUnique.map((category: string) => ({
			raw: category,
			format: makePretty(category, 'db-table-name', 'tile-text')
		}));
	}

	const onclick = (table: TableName, category: ItemCategory) => {
		// TODO: Create a utils file for regular view transitions
		setList({ table, category });
		setViewName('list');
	};
</script>

<div id="dash-view" class="view">
	<ViewHeader title="Dashboard" />

	<div id="dash-tiles" class="view-content">
		{#if app.profile.id == null}
			<div class="dash-grid-1">
				<DashTile title="Loading Profile..." loading={true} disabled />
			</div>
		{:else}
			<!-- Actions Section -->
			<div class="card bg-base-100 shadow-sm mt-2">
				<div class="card-body p-4">
					<h3 class="card-title text-base opacity-70 mb-0">Actions</h3>
					<div class="dash-vertical-container">
						{#await queryActions}
							<DashTile title="Loading Actions..." loading={true} disabled />
						{:then result}
							{#if result && result.data}
								{@const table = 'actions'}
								{@const category = { raw: 'actions', format: 'Actions' }}
								{@const num = result.data.length}
								{@const any = result.data.length > 0}
								{@const name = "Active Actions"}
								<DashTile
									title={any ? `${num} ${name}` : `No ${name}`}
									onclick={() => onclick(table, category)}
								/>
							{:else}
								<DashTile title="No Active Actions" disabled />
							{/if}
						{:catch error}
							<DashTile title="Error Getting Actions" error={error.message} disabled />
						{/await}
					</div>
				</div>
			</div>

			<!-- Categories Section -->
			<div class="card bg-base-100 shadow-sm mt-4">
				<div class="card-body p-4">
					<h3 class="card-title text-base opacity-70 mb-0">Categories</h3>
					<div class="dash-vertical-container">
						{#await Promise.all([queryQuestions, queryResponses])}
							<div class="list-item">
								<p class="text-center">Loading Questions...</p>
							</div>
						{:then [questionsResult, responsesResult]}
							{#if questionsResult.data}
								{#each extractCategories(questionsResult.data) as category}
									{@const table = 'questions'}
									{@const categoryQuestions = questionsResult.data.filter((q: Question) => q.category === category.raw)}
									{@const total = categoryQuestions.length}
									{@const answeredQuestionIds = new Set(responsesResult?.data?.map((r: Response) => r.question_id).filter((id): id is string => Boolean(id)) || [])}
									{@const completed = categoryQuestions.filter((q: Question) => q.id && answeredQuestionIds.has(q.id)).length}
									{@const completionText = `${completed}/${total}`}
									<DashTile
										title={category.format}
										onclick={() => onclick(table, category)}
										showStatus={true}
										{completed}
										{total}
										{completionText}
									/>
								{/each}
							{:else}
								<div class="list-item">
									<p class="text-center">No Questions Found</p>
								</div>
							{/if}
						{:catch error}
							<div class="list-item">
								<p class="text-center">Loading Questions...</p>
							</div>
						{/await}
					</div>
				</div>
			</div>

			<!-- Resources Section -->
			<div class="card bg-base-100 shadow-sm mt-4">
				<div class="card-body p-4">
					<h3 class="card-title text-base opacity-70 mb-0">Resources</h3>
					<div class="dash-vertical-container">
						{#await queryResources}
							<DashTile title="Loading Resources..." loading={true} disabled />
						{:then}
							{@const table = 'resources'}
							{@const category = { raw: 'resources', format: 'Resources' }}
							<DashTile
								title={'Resources'}
								onclick={() => onclick(table, category)}
							/>
							<DashTile
								title={'Terms of Use'}
								onclick={() => (showTermsModal = true)}
							/>
							<DashTile
								title={'Privacy Policy'}
								onclick={() => (showPrivacyModal = true)}
							/>
						{:catch error}
							<DashTile
								title="Error Getting Resources"
								error={error.message}
								disabled
							/>
						{/await}
					</div>
				</div>
			</div>
		{/if}
	</div>
</div>

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
