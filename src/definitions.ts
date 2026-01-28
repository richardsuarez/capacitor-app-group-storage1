export interface SaveImageOptions {
  groupId: string;
  filename: string;       // e.g., "IMG_1234.jpg"
  dataBase64: string;     // raw base64 (no data: prefix)
}

export interface ListOptions {
  groupId: string;
}

export interface ReadOptions {
  groupId: string;
  filename: string;
}

export interface CopyOptions {
  groupId: string;
  filename: string;
}

export interface AppGroupStoragePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  saveImage(options: SaveImageOptions): Promise<{ path: string }>;
  listImages(options: ListOptions): Promise<{ files: { name: string; path: string; size: number; mtime: number }[] }>;
  readImageAsBase64(options: ReadOptions): Promise<{ data: string }>;
  copyToTempForWebView(options: CopyOptions): Promise<{ path: string }>;
}
