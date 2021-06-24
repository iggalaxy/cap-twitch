import { WebPlugin } from '@capacitor/core';

import type { TwitchPlugin } from './definitions';

export class TwitchWeb extends WebPlugin implements TwitchPlugin {
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  async openStream(options: { username: string }): Promise<void> {
    throw new Error('No web implementation for TwitchWeb: openStream');
  }
}
