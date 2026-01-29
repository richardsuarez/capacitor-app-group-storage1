import { Capacitor, registerPlugin } from '@capacitor/core';

import type { AppGroupStoragePlugin } from './definitions';

const AppGroupStorage = registerPlugin<AppGroupStoragePlugin>('AppGroupStorage');


export function toWebViewUrl(nativePath: string) {
  return Capacitor.convertFileSrc(nativePath);
}

export * from './definitions';
export { AppGroupStorage };
