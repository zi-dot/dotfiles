---
argument-hint: [target]
description: mock/data.tsのリファクタ
---

以下のガイドをもとに、Mock Factoryパターンへのリファクタを進めて。
対象ファイル一覧: $ARGUMENTS

# Mock Factory パターンへのリファクタリングガイド

## 概要

このガイドは、古いmock生成パターンを `createMockFactory` を使った統一的なパターンへリファクタリングする際の手順と注意点をまとめたものです。

### 目的

- `createMockFactory` による統一的なmock生成パターンの導入
- Deep Partial な挙動により、柔軟で型安全なモック生成を実現
- 後方互換性を保ちながら段階的に移行

## 対象パターン

### リファクタ対象のコード

```typescript
// 古いパターン
export const createWebhookMock = (
  seed: Partial<Omit<Webhook, 'id'> & { id: string }> = {},
): Webhook => ({
  serviceName: seed.serviceName ?? 'slack',
  definitions: seed.definitions ?? [
    { key: 'webhookUrl', displayText: 'Webhook URL', sensitive: false },
  ],
  itemForAnnouncement: seed.itemForAnnouncement ?? {
    values: { webhookUrl: 'dummy-text' },
    hasValueKeysInSensitive: [],
  },
  // ...
})
```

### 理想的なコード

```typescript
// createMockFactory パターン（理想形）
export const createWebhookMock = createMockFactory<
  Webhook,
  {
    definitions: MockFactorySeed<typeof createWebhookDefinitionMock>[]
    itemForAnnouncement: MockFactorySeed<typeof createWebhookItemForAnnouncementMock>
    itemsForSpace: MockFactorySeed<typeof createWebhookItemForSpaceMock>[]
  }
>(({ definitions, itemForAnnouncement, itemsForSpace, ...seed } = {}) => ({
  serviceName: 'slack',
  definitions: definitions?.map(createWebhookDefinitionMock) ?? [createWebhookDefinitionMock()],
  itemForAnnouncement: createWebhookItemForAnnouncementMock(itemForAnnouncement),
  itemsForSpace:
    itemsForSpace?.map(createWebhookItemForSpaceMock) ??
    spaceSummaryMocks.map(({ id }) => createWebhookItemForSpaceMock({ spaceId: id })),
  ...seed,
}))
```

**重要なポイント:**
- `MockFactorySeed<typeof createXxxMock>` でネストされたオブジェクトの型を安全に取得
- 配列は `MockFactorySeed<T>[]` で型定義
- 初期値を直接設定し、最後に `...seed` で上書き可能に

## リファクタリング手順

### 1. インポートの追加

```typescript
import { castId } from '@kwork/base/lib/id'
import {
  createMocks,
  createMockFactory,
  generateId,
  type MockFactorySeed,
} from '@kwork/base/lib/mockHelper'
```

- `createMockFactory`: モックファクトリー作成用
- `MockFactorySeed`: ネストされたモックファクトリーの型取得用
- `generateId`: Data型用のID生成（string）
- `castId`: 非Data型用のID型変換（string → Id<T>）

### 2. ネストされた型用のモックファクトリー作成

ネストされたオブジェクトごとに個別のモックファクトリーを作成します。

**重要な原則: seedで受け取った値は必ずfactoryに渡す**

```typescript
// ❌ 悪い例: seedで受け取った値を使わず、直接mockを使用
export const createExternalShareMock = createMockFactory<ExternalShare>(
  ({ owner: _owner, ...seed } = {}) => ({
    // _owner で受け取っているのに使っていない（seedの値が無視される）
    owner: userSummaryMock,
    ...seed,
  })
)

// ⭕ 良い例: seedで受け取った値をfactoryに渡す
export const createExternalShareMock = createMockFactory<ExternalShare>(
  ({ owner, ...seed } = {}) => ({
    // ownerの値をcreateUserSummaryMockに渡す
    owner: createUserSummaryMock(owner ?? userSummaryMock),
    ...seed,
  })
)

// ❌ 悪い例: 配列でもmockをそのまま使用
items: attachableItemMocks.map((item) => ({ ...item, downloadPolicy: 'DENY' }))

// ⭕ 良い例: 配列の各要素をfactoryに渡す
items: (items ?? attachableItemMocks).map((item) =>
  createAttachableItemMock({ ...item, downloadPolicy: 'DENY' })
)
```

**パターン1: シンプルな型（ネストなし）**

```typescript
export const createWebhookDefinitionMock = createMockFactory<WebhookDefinition>(
  (seed = {}) => ({
    key: 'webhookUrl',
    displayText: 'Webhook URL',
    sensitive: false,
    ...seed,
  }),
)
```

**パターン2: ネストされたオブジェクトを持つ型**

```typescript
export const createHelpFeatureSectionMock = createMockFactory<
  HelpFeatureSection,
  {
    id: string
    category: MockFactorySeed<typeof createHelpFeatureCategoryMock>
  }
>(({ id, category, ...seed } = {}) => ({
  id: castId<HelpFeatureSection['id']>(id ?? generateId()),
  name: 'name',
  category: createHelpFeatureCategoryMock(category),
  ...seed,
}))
```

**ポイント:**
- 初期値を直接フィールドに設定（`seed.xxx ?? 'default'` ではなく `xxx: 'default'`）
- 最後に `...seed` で上書き可能に
- ネストされたオブジェクトは `MockFactorySeed` で型定義
- **重要**: 引数から分割代入で取り出し、必ず個別のファクトリーに渡す
  - ❌ 悪い例: `owner: userSummaryMock` （seedで渡された値を無視）
  - ⭕ 良い例: `owner: createUserSummaryMock(owner ?? userSummaryMock)` （seedの値をfactoryに渡す）
- 配列の場合も同様にmap経由でfactoryに渡す
  - ❌ 悪い例: `items: attachableItemMocks`
  - ⭕ 良い例: `items: (items ?? attachableItemMocks).map(createAttachableItemMock)`

### 3. ID変換が必要な場合の実装

**非Data型（`Xxx` suffixなし）:**

```typescript
export const createWebhookItemForSpaceMock = createMockFactory<
  WebhookItemForSpace,
  { spaceId: string }  // ← Modified型でstringとして受け取る
>(({ spaceId, ...seed } = {}) => ({
  spaceId: castId<Space['id']>(spaceId ?? generateId()),  // ← 適切な型へ変換
  // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりRecord<string, string | undefined>になるため型アサーションが必要
  values: { webhookUrl: 'dummy-text' } as Record<string, string>,
  hasValueKeysInSensitive: [],
  ...seed,
}))
```

**Data型（`XxxData` suffix）:**

```typescript
export const createWebhookItemForSpaceDataMock = createMockFactory<WebhookItemForSpaceData>(
  (seed = {}) => ({
    spaceId: generateId(),  // ← string型のまま
    // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりRecord<string, string | undefined>になるため型アサーションが必要
    values: { webhookUrl: 'dummy-text' } as Record<string, string>,
    hasValueKeys: [],
    ...seed,
  }),
)
```

**ポイント:**
- **非Data型**: Modified型で `spaceId: string` と指定し、`castId` で型変換
- **Data型**: Modified型不要、`generateId()` で直接string生成
- 初期値を直接設定し、最後に `...seed` で上書き可能に
- `Record<string, string>` は型アサーションが必要（DeepPartialの影響）

### 4. メインモックファクトリーの実装

```typescript
export const createWebhookMock = createMockFactory<
  Webhook,
  {
    definitions: MockFactorySeed<typeof createWebhookDefinitionMock>[]
    itemForAnnouncement: MockFactorySeed<typeof createWebhookItemForAnnouncementMock>
    itemsForSpace: MockFactorySeed<typeof createWebhookItemForSpaceMock>[]
  }
>(({ definitions, itemForAnnouncement, itemsForSpace, ...seed } = {}) => ({
  serviceName: 'slack',
  definitions: definitions?.map(createWebhookDefinitionMock) ?? [createWebhookDefinitionMock()],
  itemForAnnouncement: createWebhookItemForAnnouncementMock(itemForAnnouncement),
  itemsForSpace:
    itemsForSpace?.map(createWebhookItemForSpaceMock) ??
    spaceSummaryMocks.map(({ id }) => createWebhookItemForSpaceMock({ spaceId: id })),
  ...seed,
}))
```

**ポイント:**
- ネストされたオブジェクトは `MockFactorySeed` で型定義
- 配列は `MockFactorySeed<T>[]` で型定義
- 初期値を直接設定（`serviceName: 'slack'`）
- 最後に `...seed` で上書き可能に

## よくある問題と解決策

### 問題1: `Record<string, string>` の型エラー

**エラー内容:**
```
Type 'DeepObjectPartial<Record<string, string>>' is not assignable to type 'Record<string, string>'.
```

**原因:**
`DeepPartial` が `Record<string, string>` を `Record<string, string | undefined>` に変換するため。

**解決策:**
型アサーション（`as`）を使用し、eslint-disable directiveで理由を明記。

```typescript
export const createWebhookItemForAnnouncementMock = createMockFactory<WebhookItemForAnnouncement>(
  (seed = {}) => ({
    // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりRecord<string, string | undefined>になるため型アサーションが必要
    values: { webhookUrl: 'dummy-text' } as Record<string, string>,
    hasValueKeysInSensitive: [],
    ...seed,
  }),
)
```

**重要:**
- デフォルト値により実行時の型安全性は保証される
- Modified型で `values: Record<string, string>` を指定しても、DeepPartialの適用は止められない
- 型アサーションは必要最小限に留め、理由を必ず記述

### 問題1-2: ネストされたオブジェクトフィールドの型エラー回避

**背景:**
ネストされたオブジェクトフィールド（例: `date: { year: number, month: number, day: number }`）を持つ型で、DeepPartialによる `number | undefined` の型エラーが発生する場合があります。

**従来の解決策（型アサーション使用）:**
```typescript
export const createDailyBillingMeasurementDataMock = createMockFactory<DailyBillingMeasurementData>(
  (seed = {}) => ({
    // eslint-disable-next-line @typescript-eslint/consistent-type-assertions
    date: { year: 1, month: 1, day: 1 } as { year: number; month: number; day: number },
    userCounts: 10,
    ...seed,
  }),
)
```

**推奨の解決策（型アサーション不要）:**
```typescript
export const createDailyBillingMeasurementDataMock = createMockFactory<DailyBillingMeasurementData>(
  ({ date, ...seed } = {}) => ({
    date: { year: 1, month: 1, day: 1, ...date },
    userCounts: 10,
    ...seed,
  }),
)

// 使用例
createDailyBillingMeasurementDataMock({
  date: { year: 2021, month: 7, day: 15 }
})
```

**この方法のメリット:**
- 型アサーションが不要（ESLint disable directiveも不要）
- ネストされたオブジェクトのプロパティを部分的に上書き可能
  ```typescript
  createDailyBillingMeasurementDataMock({
    date: { year: 2021 } // month, day はデフォルト値を使用
  })
  ```
- より柔軟で型安全な実装

**適用できるケース:**
- ネストされたオブジェクトが単純な構造（プリミティブ型のみ）
- ネストされたオブジェクト全体を上書きする必要がある場合

**注意点:**
- ネストされたオブジェクトがさらに複雑な構造を持つ場合は、専用のファクトリーを作成することを推奨
- 配列フィールドには適用できない（配列は `...array` でマージできないため）

### 問題2: スプレッド構文の順序

**従来のパターン（非推奨）:**
```typescript
name: seed.name ?? 'name',
description: seed.description ?? '<span>description</span>',
```

**理想的なパターン（推奨）:**
```typescript
name: 'name',
description: '<span>description</span>',
...seed,
```

**理由:**
- `...seed` による上書きで、すべてのプロパティを柔軟にカスタマイズ可能
- コードがシンプルで読みやすい
- DeepPartial の恩恵を最大限活用

**スプレッド順序の重要性:**
```typescript
({
  name: 'name',                              // 1. デフォルト値
  section: createHelpFeatureSectionMock(section),
  ...createHelpCommonDataMock(seed),         // 2. 他のファクトリー
  ...createHelpZendeskDataMock(seed),
  ...seed,                                   // 3. 最終上書き
})
```

### 問題3: Modified型パラメータの使い分け

**使うべき場面:**
- ID型の変換が必要な場合（string → Id<T>）
  ```typescript
  createMockFactory<WebhookItemForSpace, { spaceId: string }>
  ```

**使わなくて良い場面:**
- 型アサーションで対応できる場合
  ```typescript
  // ❌ 不要
  createMockFactory<WebhookItemForAnnouncement, { values: Record<string, string> }>

  // ⭕ シンプル
  createMockFactory<WebhookItemForAnnouncement>
  ```

### 問題4: ESLintエラー

**エラー:**
```
Do not use any type assertions. [@typescript-eslint/consistent-type-assertions]
```

**解決策:**
ファイル内で `eslint-disable-next-line` を使用し、理由を記述。

```typescript
// eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりRecord<string, string | undefined>になるため型アサーションが必要
values: (seed.values ?? { webhookUrl: 'dummy-text' }) as Record<string, string>,
```

**重要:**
- ESLint設定でルール自体を無効化しない
- 必要な箇所だけを個別に無効化
- 理由を必ず記述（今後のメンテナンスのため）

### 問題5: Timestamp型フィールドの扱い

**背景:**
Protobufの `Timestamp` 型フィールドを持つData型モックで、型アサーションを避けるより良い方法。

**従来の解決策（型アサーション使用）:**
```typescript
export const createDraftPageContentSummaryDataMock = createMockFactory<DraftPageContentSummaryData>(
  ({ id, createdAt, updatedAt, contentPage, ...seed } = {}) => ({
    id: id ?? generateId(),
    contentPage: { contentType: 'page', ...contentPage },
    // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりTimestamp型が崩れるため型アサーションが必要
    createdAt: (createdAt ?? Timestamp.fromDate(new Date('2021-07-01'))) as DraftPageContentSummaryData['createdAt'],
    // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりTimestamp型が崩れるため型アサーションが必要
    updatedAt: (updatedAt ?? Timestamp.fromDate(new Date('2021-07-14'))) as DraftPageContentSummaryData['updatedAt'],
    ...seed,
  }),
)
```

**推奨の解決策（Modified型を使用）:**
```typescript
export const createDraftPageContentSummaryDataMock = createMockFactory<
  DraftPageContentSummaryData,
  {
    createdAt: Date
    updatedAt: Date
  }
>(({ id, createdAt, updatedAt, contentPage, ...seed } = {}) => ({
  id: id ?? generateId(),
  contentPage: { contentType: 'page', ...contentPage },
  createdAt: Timestamp.fromDate(createdAt ?? new Date('2021-07-01')),
  updatedAt: Timestamp.fromDate(updatedAt ?? new Date('2021-07-14')),
  ...seed,
}))
```

**この方法のメリット:**
- 型アサーションが不要（ESLint disable directiveも不要）
- Modified型により `Date` → `Timestamp` の変換を明示的に
- より型安全で保守性が向上
- 使用側で `Date` を渡すだけでよいため直感的

**使用例:**
```typescript
// デフォルト値を使用
const mock1 = createDraftPageContentSummaryDataMock()

// 特定の日付を指定
const mock2 = createDraftPageContentSummaryDataMock({
  createdAt: new Date('2023-01-01'),
  updatedAt: new Date('2023-12-31'),
})

// 一部のみ上書き
const mock3 = createDraftPageContentSummaryDataMock({
  createdAt: new Date('2023-01-01'),
  // updatedAt はデフォルト値を使用
})
```

**適用できるケース:**
- Protobufの `Timestamp` 型フィールドを持つData型モック
- `@bufbuild/protobuf` の `Timestamp` を使用している場合

**注意点:**
- Modified型で `Date` を指定することで、内部で `Timestamp.fromDate()` に変換
- 非Data型（通常のドメインモデル）では `Date` 型をそのまま使用するため、この対応は不要

## Before/After コード例

### 完全な例: WebhookItemForSpace

**Before:**
```typescript
export const createWebhookItemForSpaceMock = (
  seed: Partial<Omit<WebhookItemForSpace, 'id'> & { id: string }> = {},
): WebhookItemForSpace => ({
  spaceId: seed.spaceId ?? 'dummy-id',
  values: seed.values ?? { webhookUrl: 'dummy-text' },
  hasValueKeysInSensitive: seed.hasValueKeysInSensitive ?? [],
})
```

**After:**
```typescript
export const createWebhookItemForSpaceMock = createMockFactory<
  WebhookItemForSpace,
  { spaceId: string }
>(({ spaceId, ...seed } = {}) => ({
  spaceId: castId<Space['id']>(spaceId ?? generateId()),
  // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりRecord<string, string | undefined>になるため型アサーションが必要
  values: { webhookUrl: 'dummy-text' } as Record<string, string>,
  hasValueKeysInSensitive: [],
  ...seed,
}))
```

### メインファクトリーの例

**Before:**
```typescript
export const createWebhookMock = (
  seed: Partial<Omit<Webhook, 'id'> & { id: string }> = {},
): Webhook => ({
  serviceName: seed.serviceName ?? 'slack',
  definitions: seed.definitions ?? [
    { key: 'webhookUrl', displayText: 'Webhook URL', sensitive: false },
  ],
  itemForAnnouncement: seed.itemForAnnouncement ?? {
    values: { webhookUrl: 'dummy-text' },
    hasValueKeysInSensitive: [],
  },
  itemsForSpace:
    seed.itemsForSpace ??
    spaceSummaryMocks.map(({ id }) => ({
      spaceId: id,
      values: { webhookUrl: 'dummy-text' },
      hasValueKeysInSensitive: [],
    })),
})
```

**After:**
```typescript
export const createWebhookMock = createMockFactory<
  Webhook,
  {
    definitions: MockFactorySeed<typeof createWebhookDefinitionMock>[]
    itemForAnnouncement: MockFactorySeed<typeof createWebhookItemForAnnouncementMock>
    itemsForSpace: MockFactorySeed<typeof createWebhookItemForSpaceMock>[]
  }
>(({ definitions, itemForAnnouncement, itemsForSpace, ...seed } = {}) => ({
  serviceName: 'slack',
  definitions: definitions?.map(createWebhookDefinitionMock) ?? [createWebhookDefinitionMock()],
  itemForAnnouncement: createWebhookItemForAnnouncementMock(itemForAnnouncement),
  itemsForSpace:
    itemsForSpace?.map(createWebhookItemForSpaceMock) ??
    spaceSummaryMocks.map(({ id }) => createWebhookItemForSpaceMock({ spaceId: id })),
  ...seed,
}))
```

## チェックリスト

リファクタ完了時に以下を確認してください：

### コード品質

- [ ] すべてのモックファクトリーで `createMockFactory` を使用
- [ ] ネストされたオブジェクトに `MockFactorySeed` を使用
- [ ] 初期値を直接フィールドに設定し、`...seed` で上書き可能に
- [ ] ID型の変換が適切に行われている（非Data型は `castId`、Data型は `generateId`）
- [ ] 型アサーションには必ず `eslint-disable-next-line` とコメントを記述
- [ ] ネストされた単純なオブジェクトフィールドは、可能な限り型アサーション不要な方法（スプレッド構文でのマージ）を使用
- [ ] Modified型パラメータは必要最小限（IDとネストオブジェクトのみ）
- [ ] デフォルト値が元の実装と同じ

### 後方互換性

- [ ] エクスポートされる関数名・定数名は変更していない
- [ ] 既存の使用箇所で引数なし・部分的な引数での呼び出しが動作する

### 検証

```bash
# ESLint
pnpm -F <package-name> lint

# TypeScript型チェック
pnpm -F <package-name> typecheck

# テスト
pnpm -F <package-name> test
```

- [ ] ESLintエラーなし（webhook/mock関連）
- [ ] TypeScript型エラーなし（webhook/mock関連）
- [ ] すべてのテストがパス

## 参考実装

### 推奨参考ファイル

- **理想的なパターン**: `product/coaching/npm/product-coaching/src/domain/roleplay/mock/data.ts:95-147`
  - MockFactorySeedの使い方
  - ネストされたオブジェクトの扱い
  - 配列の処理パターン

- **実践例**: `central/npm/central/src/domain/helpFeature/mock/data.ts`
  - MockFactorySeedを使った実装例
  - 初期値 + `...seed` パターン
  - スプレッド構文の順序

- **複雑な例**: `middleware/content/npm/middleware-content/src/domain/space/mock/data.ts`
  - ID変換の実装
  - 配列のマッピング
  - 条件分岐の処理

### パターン別実装

#### パターン1: シンプルな型

```typescript
export const createWebhookDefinitionMock = createMockFactory<WebhookDefinition>(
  (seed = {}) => ({
    key: 'webhookUrl',
    displayText: 'Webhook URL',
    sensitive: false,
    ...seed,
  }),
)
```

#### パターン2: Record型を含む

```typescript
export const createWebhookItemForAnnouncementMock = createMockFactory<WebhookItemForAnnouncement>(
  (seed = {}) => ({
    // eslint-disable-next-line @typescript-eslint/consistent-type-assertions -- DeepPartialによりRecord<string, string | undefined>になるため型アサーションが必要
    values: { webhookUrl: 'dummy-text' } as Record<string, string>,
    hasValueKeysInSensitive: [],
    ...seed,
  }),
)
```

#### パターン2-2: ネストされたオブジェクトフィールド（型アサーション不要）

```typescript
export const createDailyBillingMeasurementDataMock = createMockFactory<DailyBillingMeasurementData>(
  ({ date, ...seed } = {}) => ({
    date: { year: 1, month: 1, day: 1, ...date },
    userCounts: 10,
    storageUsedBytes: BigInt(100),
    storageUsedText: '1.00',
    storageUsedUnit: 'GB',
    ...seed,
  }),
)

// 使用パターン
// 1. デフォルト値を使用
const mock1 = createDailyBillingMeasurementDataMock()

// 2. date を完全に上書き
const mock2 = createDailyBillingMeasurementDataMock({
  date: { year: 2021, month: 7, day: 15 }
})

// 3. date の一部のみ上書き
const mock3 = createDailyBillingMeasurementDataMock({
  date: { year: 2021 } // month, day はデフォルト値
})

// 4. 他のフィールドと組み合わせ
const mock4 = createDailyBillingMeasurementDataMock({
  date: { year: 2021, month: 7, day: 15 },
  userCounts: 150,
})
```

**ポイント:**
- ネストされたオブジェクトを引数から分割代入で取り出す
- デフォルト値の後に `...date` でマージ
- 型アサーションが不要で、柔軟な上書きが可能

#### パターン3: ID変換とネストオブジェクト（非Data型）

```typescript
export const createHelpFeatureSectionMock = createMockFactory<
  HelpFeatureSection,
  {
    id: string
    category: MockFactorySeed<typeof createHelpFeatureCategoryMock>
  }
>(({ id, category, ...seed } = {}) => ({
  id: castId<HelpFeatureSection['id']>(id ?? generateId()),
  name: 'name',
  category: createHelpFeatureCategoryMock(category),
  ...seed,
}))
```

#### パターン4: ネストされた配列

```typescript
export const createHelpFeatureOfTopPageMock = createMockFactory<
  HelpFeatureOfTopPage,
  {
    category: MockFactorySeed<typeof createHelpFeatureCategoryMock>
    features: MockFactorySeed<typeof createHelpFeatureMock>[]
  }
>(({ category, features, ...seed } = {}) => ({
  category: createHelpFeatureCategoryMock(category),
  features: features ? features.map(createHelpFeatureMock) : createMocks(createHelpFeatureMock, 10),
  ...seed,
}))
```

#### パターン5: スプレッド構文との組み合わせ

```typescript
export const createHelpFeatureDataMock = createMockFactory<
  HelpFeatureData,
  {
    section: MockFactorySeed<typeof createHelpFeatureSectionDataMock>
  }
>(({ section, ...seed } = {}) => ({
  name: 'name',
  section: createHelpFeatureSectionDataMock(section),
  description: '<span>description</span>',
  ...createHelpCommonDataMock(seed),
  ...createHelpZendeskDataMock(seed),
  ...seed,
}))
```

**ポイント:**
- 他のファクトリーのスプレッドを中間に配置
- 最後に `...seed` で最終上書き

#### パターン6: Timestamp型フィールド（Data型）

```typescript
export const createDraftPageContentSummaryDataMock = createMockFactory<
  DraftPageContentSummaryData,
  {
    createdAt: Date
    updatedAt: Date
  }
>(({ id, createdAt, updatedAt, contentPage, ...seed } = {}) => ({
  id: id ?? generateId(),
  contentPage: { contentType: 'page', ...contentPage },
  createdAt: Timestamp.fromDate(createdAt ?? new Date('2021-07-01')),
  updatedAt: Timestamp.fromDate(updatedAt ?? new Date('2021-07-14')),
  ...seed,
}))
```

**ポイント:**
- Modified型で `createdAt: Date`, `updatedAt: Date` として定義
- 内部で `Timestamp.fromDate()` に変換
- 型アサーション不要でクリーンなコード
- 使用側は `Date` を渡すだけで直感的

## トラブルシューティング

### Q: `@ts-expect-error` を使っても良い？

A: ❌ 推奨しません。代わりに：
1. 型アサーション（`as`）を使用
2. `eslint-disable-next-line` で理由を明記
3. より明示的で、将来のメンテナンスが容易

### Q: Modified型で `values` を指定しても型エラーが出る

A: Modified型でフィールドを指定しても、`DeepPartial` の適用は止められません。型アサーションを使用してください。

### Q: ネストされたオブジェクトで型アサーションを避けるには？

A: ネストされたオブジェクトフィールドを引数から分割代入で取り出し、スプレッド構文でマージする方法を推奨します：

```typescript
// ❌ 型アサーション使用
export const createMock = createMockFactory<Type>(
  (seed = {}) => ({
    nested: { a: 1, b: 2 } as { a: number; b: number },
    ...seed,
  }),
)

// ⭕ 推奨: 型アサーション不要
export const createMock = createMockFactory<Type>(
  ({ nested, ...seed } = {}) => ({
    nested: { a: 1, b: 2, ...nested },
    ...seed,
  }),
)
```

この方法は以下の場合に有効です：
- ネストされたオブジェクトが単純な構造（プリミティブ型のみ）
- 部分的な上書きが必要な場合

より複雑な構造の場合は、専用のファクトリーを作成してください。

### Q: 既存の使用箇所を全部調べる必要がある？

A: いいえ。後方互換性を保っているため、既存コードは動作します。ただし、Storybookなど主要な使用箇所は動作確認推奨。

### Q: プロジェクト全体で一気にリファクタすべき？

A: いいえ。段階的な移行を推奨します：
1. まず1つのドメインで試す
2. 問題がないことを確認
3. 他のドメインへ展開

### Q: MockFactorySeed は必須？

A: ネストされたオブジェクトがある場合は使用を推奨。型安全性が向上し、コードの意図が明確になります。

### Q: 初期値を `seed.xxx ?? 'default'` から `xxx: 'default', ...seed` に変えるメリットは？

A: 以下のメリットがあります：
- コードがシンプルで読みやすい
- DeepPartialの恩恵を最大限活用できる
- すべてのプロパティを柔軟に上書き可能
- スプレッド構文の順序を意識することで、より明確な上書き制御が可能

## まとめ

### 重要なポイント

1. **createMockFactory を使う**: 統一的なパターンで保守性向上
2. **MockFactorySeed を使う**: ネストされたオブジェクトの型安全性を確保
3. **初期値は直接設定**: `seed.xxx ?? 'default'` ではなく `xxx: 'default', ...seed`
4. **ID変換の使い分け**: 非Data型は `castId`、Data型は `generateId`
5. **Record型は型アサーション**: eslint-disable directiveで理由を記述
6. **Modified型は最小限**: IDとネストオブジェクト、Timestamp型フィールドのみ
7. **Timestamp型フィールド**: Modified型で `Date` として受け取り、内部で `Timestamp.fromDate()` に変換
8. **後方互換性を保つ**: デフォルト値と関数名を維持

### 次のステップ

このガイドを参考に、他のmock/data.tsファイルも段階的にリファクタリングを進めてください。

不明点があれば、参考実装（coaching, space）を確認するか、このガイドを更新してください。
