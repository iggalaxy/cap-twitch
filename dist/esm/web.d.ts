import { WebPlugin } from '@capacitor/core';
import type { TwitchPlugin } from './definitions';
export declare class TwitchWeb extends WebPlugin implements TwitchPlugin {
    openStream(options: {
        username: string;
    }): Promise<void>;
}
