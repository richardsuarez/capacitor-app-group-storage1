# capacitor-app-group-storage

Allow to connect an ionic app with App Group capability of native apps

## Install

```bash
npm install capacitor-app-group-storage
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`saveImage(...)`](#saveimage)
* [`listImages(...)`](#listimages)
* [`readImageAsBase64(...)`](#readimageasbase64)
* [`copyToTempForWebView(...)`](#copytotempforwebview)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


### saveImage(...)

```typescript
saveImage(options: SaveImageOptions) => Promise<{ path: string; }>
```

| Param         | Type                                                          |
| ------------- | ------------------------------------------------------------- |
| **`options`** | <code><a href="#saveimageoptions">SaveImageOptions</a></code> |

**Returns:** <code>Promise&lt;{ path: string; }&gt;</code>

--------------------


### listImages(...)

```typescript
listImages(options: ListOptions) => Promise<{ files: { name: string; path: string; size: number; mtime: number; }[]; }>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#listoptions">ListOptions</a></code> |

**Returns:** <code>Promise&lt;{ files: { name: string; path: string; size: number; mtime: number; }[]; }&gt;</code>

--------------------


### readImageAsBase64(...)

```typescript
readImageAsBase64(options: ReadOptions) => Promise<{ data: string; }>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#readoptions">ReadOptions</a></code> |

**Returns:** <code>Promise&lt;{ data: string; }&gt;</code>

--------------------


### copyToTempForWebView(...)

```typescript
copyToTempForWebView(options: CopyOptions) => Promise<{ path: string; }>
```

| Param         | Type                                                |
| ------------- | --------------------------------------------------- |
| **`options`** | <code><a href="#copyoptions">CopyOptions</a></code> |

**Returns:** <code>Promise&lt;{ path: string; }&gt;</code>

--------------------


### Interfaces


#### SaveImageOptions

| Prop             | Type                |
| ---------------- | ------------------- |
| **`groupId`**    | <code>string</code> |
| **`filename`**   | <code>string</code> |
| **`dataBase64`** | <code>string</code> |


#### ListOptions

| Prop          | Type                |
| ------------- | ------------------- |
| **`groupId`** | <code>string</code> |


#### ReadOptions

| Prop           | Type                |
| -------------- | ------------------- |
| **`groupId`**  | <code>string</code> |
| **`filename`** | <code>string</code> |


#### CopyOptions

| Prop           | Type                |
| -------------- | ------------------- |
| **`groupId`**  | <code>string</code> |
| **`filename`** | <code>string</code> |

</docgen-api>
