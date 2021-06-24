export interface TwitchPlugin {
  openStream(options: { username: string }): Promise<void>;
}
