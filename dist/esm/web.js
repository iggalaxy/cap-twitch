import { WebPlugin } from '@capacitor/core';
export class TwitchWeb extends WebPlugin {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    async openStream(_options) {
        throw new Error('No web implementation for TwitchWeb: openStream');
    }
}
//# sourceMappingURL=web.js.map