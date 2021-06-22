import { registerPlugin } from '@capacitor/core';

import type { TwitchPlugin } from './definitions';

const Twitch = registerPlugin<TwitchPlugin>('Twitch', {
  web: () => import('./web').then(m => new m.TwitchWeb()),
});

export * from './definitions';
export { Twitch };
