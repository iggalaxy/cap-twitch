import { WebPlugin } from '@capacitor/core';

import type { TwitchPlugin } from './definitions';

export class TwitchWeb extends WebPlugin implements TwitchPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
