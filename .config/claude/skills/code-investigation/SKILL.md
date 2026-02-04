---
name: code-investigation
description: "コードベースの調査・分析を行い、結果をドキュメントにまとめる。「調査して」「分析して」「まとめて」などのリクエストで発動。"
---

# コード調査スキル

## 保存先ルール

- 調査結果は `~/.claude/docs/{project-name}/` に保存する
- プロジェクト内には調査ドキュメントを作成しない
- ファイル名は内容を表す英語のケバブケース（例: `rpc-usage-analysis.md`）

## project-name の決定

- git リポジトリ名を使用する（例: `knowledgework`）
- リポジトリ外の場合はディレクトリ名を使用する
