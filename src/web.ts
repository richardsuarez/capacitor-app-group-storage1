import { WebPlugin } from '@capacitor/core';

import type { AppGroupStoragePlugin } from './definitions';

export class AppGroupStorageWeb extends WebPlugin implements AppGroupStoragePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
