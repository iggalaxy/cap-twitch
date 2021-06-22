export interface TwitchPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
