import { registerPlugin } from '@capacitor/core';

import type { AppGroupStoragePlugin } from './definitions';

const AppGroupStorage = registerPlugin<AppGroupStoragePlugin>('AppGroupStorage');

export * from './definitions';
export { AppGroupStorage };
