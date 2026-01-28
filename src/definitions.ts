export interface AppGroupStoragePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
