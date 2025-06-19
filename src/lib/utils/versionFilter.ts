 import type { Response, Action} from '$lib/types/tableMain';

 /**
   * Get the latest version of each response for a 
  user+question combination
   */
export function getLatestResponses(responses: 
Response[]): Response[] {
        const latestResponsesMap = new Map<string, Response>();

        for (const response of responses) {
                const key =
`${response.user_id}-${response.question_id}`;
                const existing = latestResponsesMap.get(key);

                if (!existing || (response.version &&
existing.version && response.version >
existing.version)) {
                        latestResponsesMap.set(key, response);
                }
        }

        return Array.from(latestResponsesMap.values());
}

  /**
   * Get the latest version of each action for a 
  user+response combination
   */
export function getLatestActions(actions: Action[]): 
Action[] {
    const latestActionsMap = new Map<string, Action>();

    for (const action of actions) {
            const key =
`${action.user_id}-${action.response_id}`;
            const existing = latestActionsMap.get(key);

            if (!existing || (action.version &&
existing.version && action.version >
existing.version)) {
                    latestActionsMap.set(key, action);
            }
    }

    return Array.from(latestActionsMap.values());
}