---
name: submitting-changes
description: "Automates git commit, push, and PR creation with Japanese commit messages and emoji prefixes. Use when: (1) User asks to create a PR, (2) User says PRお願い, PR作って, PR作成, commit and pr, (3) User confirms with yes after being asked about creating a PR. Creates draft PR with assignee zi-dot."
---

# Submitting Changes

変更をコミット → プッシュ → PR作成する自動化スキル。

## ワークフロー

1. `git status` と `git diff` で変更確認
2. 変更ファイルをステージング
3. 絵文字プレフィックス付き日本語コミットメッセージ作成
4. リモートにプッシュ
5. Draft PRを作成（assignee: `zi-dot`）

## コミットメッセージ形式

```
{絵文字} [{カテゴリ}] {変更内容の簡潔な説明}
```

### 絵文字

| 絵文字 | 用途 |
|--------|------|
| ✨ | 新機能 |
| 🐛 | バグ修正 |
| ♻️ | リファクタリング |
| 🎨 | UIデザイン |
| ⚡️ | パフォーマンス改善 |
| 📝 | ドキュメント |
| 🔧 | 設定ファイル |
| 💚 | E2Eテスト |

## PR説明形式

```markdown
## Summary

[1〜2文：何をしたか + なぜやったか]

[変更の詳細を箇条書きで]
- メインポイント
  - 理由や補足

## References

- #123 または n/a
```

**詳細なスタイルガイド**: [references/pr-style-guide.md](references/pr-style-guide.md)

## 注意事項

- コミットメッセージとPRタイトルは同じにする
- PRは必ずDraftで作成
