<script lang="ts">
  interface Props {
    title: string;
    onclick?: () => void;
  }

  const { title, onclick }:Props = $props();
</script>

<div id="{title}-header" class="prose flex flex-row justify-between items-center p-4 bg-accent">
  <h2 class="text-accent-content">{title}</h2>

  {#if onclick}
    <button {onclick} class="btn-nav border-primary">
      Back
    </button>
  {/if}
</div>