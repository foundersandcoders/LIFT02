import type { HelpContent, HelpContentMap, HelpContextKey } from '$lib/types/help';

let helpContentCache: HelpContentMap | null = null;

export async function loadHelpContent(): Promise<HelpContentMap> {
	if (helpContentCache) {
		return helpContentCache;
	}

	try {
		const response = await fetch('/help/content/help-content.json');
		if (!response.ok) {
			throw new Error(`Failed to load help content: ${response.statusText}`);
		}
		
		helpContentCache = await response.json();
		return helpContentCache as HelpContentMap;
	} catch (error) {
		console.error('Error loading help content:', error);
		// Return fallback content
		return getFallbackHelpContent();
	}
}

export async function getHelpContent(contextKey: HelpContextKey): Promise<HelpContent> {
	const allContent = await loadHelpContent();
	return allContent[contextKey] || getFallbackContent(contextKey);
}

function getFallbackContent(contextKey: HelpContextKey): HelpContent {
	return {
		title: 'Help',
		sections: [
			{
				text: `Get guidance for using this section of your workplace passport. Context: ${contextKey}`
			}
		]
	};
}

function getFallbackHelpContent(): HelpContentMap {
	const contexts: HelpContextKey[] = [
		'dashboard-no-profile',
		'dashboard-profile', 
		'actions',
		'resources',
		'categories',
		'responses',
		'email'
	];

	const fallbackContent: Partial<HelpContentMap> = {};
	
	for (const context of contexts) {
		fallbackContent[context] = getFallbackContent(context);
	}

	return fallbackContent as HelpContentMap;
}