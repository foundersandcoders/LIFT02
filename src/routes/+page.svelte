<script lang="ts">
	import { supabase } from '$lib/services/supabaseClient';

	let email = $state('');
	let loading = $state(false);
	let error = $state<string | null>(null);
	let sent = $state(false);

	async function handleSubmit(e: Event) {
		e.preventDefault();
		loading = true;
		error = null;

		try {
			const { error: authError } = await supabase.auth.signInWithOtp({
				email: email.trim().toLowerCase(),
				options: {
					emailRedirectTo: `${window.location.origin}/auth/callback`
				}
			});

			if (authError) throw authError;

			sent = true;
		} catch (err: any) {
			error = err.message || 'Failed to send magic link';
		} finally {
			loading = false;
		}
	}

	function handleDoubleClick() {
		email = 'alex.chen@example.com';
	}
</script>

<div class="flex min-h-screen items-center justify-center bg-base-200 p-4">
	<div class="card w-full max-w-md bg-base-100 shadow-xl">
		<div class="card-body">
			<h2 class="card-title text-2xl font-bold">LIFT Digital Workplace Passport</h2>

			{#if !sent}
				<p class="text-sm opacity-70">Sign in with your email to access your workplace passport</p>

				<form onsubmit={handleSubmit} class="mt-4 space-y-4">
					<div class="form-control">
						<label for="email" class="label">
							<span class="label-text">Email address</span>
						</label>
						<input
							id="email"
							type="email"
							bind:value={email}
							placeholder="you@example.com"
							required
							disabled={loading}
							class="input input-bordered w-full"
							ondblclick={handleDoubleClick}
						/>
					</div>

					{#if error}
						<div class="alert alert-error">
							<span>{error}</span>
						</div>
					{/if}

					<button type="submit" class="btn btn-primary w-full" disabled={loading}>
						{#if loading}
							<span class="loading loading-spinner"></span>
							Sending magic link...
						{:else}
							Send magic link
						{/if}
					</button>
				</form>
			{:else}
				<div class="alert alert-success">
					<svg
						xmlns="http://www.w3.org/2000/svg"
						class="h-6 w-6 shrink-0 stroke-current"
						fill="none"
						viewBox="0 0 24 24"
					>
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="2"
							d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
						/>
					</svg>
					<div>
						<h3 class="font-bold">Check your email!</h3>
						<div class="text-xs">
							We've sent a magic link to <strong>{email}</strong>. Click the link to sign in.
						</div>
					</div>
				</div>

				<p class="mt-4 text-sm opacity-70">
					Didn't receive the email? Check your spam folder or try again.
				</p>

				<button onclick={() => (sent = false)} class="btn btn-ghost btn-sm mt-2">
					Try different email
				</button>
			{/if}
		</div>
	</div>
</div>
