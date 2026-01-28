import { registerPlugin } from '@capacitor/core';

import type { AppGroupStoragePlugin } from './definitions';

const AppGroupStorage = registerPlugin<AppGroupStoragePlugin>('AppGroupStorage', {
  web: () => import('./web').then((m) => new m.AppGroupStorageWeb()),
});

export * from './definitions';
export { AppGroupStorage };
