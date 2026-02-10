---
name: implementing-feature
description: "Initiates feature implementation workflow: fetch latest master, create feature branch, plan implementation, and execute. Use when: (1) User says /impl, 実装開始, 実装して, (2) User provides a task description and wants to start implementing, (3) User asks to create a branch and start coding. Handles the full workflow from branch creation to implementation."
---

# Implementing Feature

機能実装を開始するためのワークフロー。最新のmasterを取得し、ブランチを作成し、実装プランを立てて実装を行う。

## ワークフロー

```
実装開始チェックリスト:
- [ ] Step 1: 最新masterを取得
- [ ] Step 2: 要件を分析しブランチ名を決定
- [ ] Step 3: フィーチャーブランチを作成
- [ ] Step 4: 実装プランを作成（EnterPlanMode）
- [ ] Step 5: プラン承認後、実装を開始
```

### Step 1: 最新masterを取得

```bash
git fetch origin master
git checkout master
git pull origin master
```

### Step 2: 要件を分析しブランチ名を決定

ユーザーの依頼内容から適切なブランチ名を決定する。

**ブランチ名の形式:**
```
{type}/{short-description}
```

| type | 用途 |
|------|------|
| feat | 新機能 |
| fix | バグ修正 |
| refactor | リファクタリング |
| docs | ドキュメント |
| test | テスト追加・修正 |
| chore | その他（設定、依存関係等） |

**例:**
- `feat/add-user-authentication`
- `fix/login-validation-error`
- `refactor/extract-common-utils`

### Step 3: フィーチャーブランチを作成

```bash
git checkout -b {branch-name}
```

### Step 4: 実装プランを作成

**EnterPlanModeツールを使用**してプランモードに入り、以下を行う：

1. 関連コードの調査（Task/Exploreエージェント使用）
2. 実装アプローチの設計
3. 変更が必要なファイルの特定
4. 実装ステップの詳細化

### Step 5: プラン承認後、実装を開始

ユーザーがプランを承認したら、実装を開始する。

## 使用例

**ユーザー:** `/impl ユーザー認証機能を追加して`

**Claude:**
1. masterを最新化
2. ブランチ名: `feat/add-user-authentication` を提案
3. ブランチ作成
4. EnterPlanModeで実装プラン作成
5. 承認後、実装開始

## 注意事項

- **実装完了後は `/submitting-changes` スキルを使用してPR作成を行う**
- 大きな変更は複数のコミットに分割することを検討
- 実装中に設計変更が必要な場合は、ユーザーに確認を取る
