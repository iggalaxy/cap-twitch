import { registerPlugin } from '@capacitor/core';
const Twitch = registerPlugin('Twitch', {
    web: () => import('./web').then(m => new m.TwitchWeb()),
});
export * from './definitions';
export { Twitch };
//# sourceMappingURL=index.js.map