---
name: github-pr-creator
description: GitHub 上の変更を Pull Request として提出する skill。Issue の確認、branch 名の決定、`ghq` 配下の git worktree 作成または再利用、commit と push、PR テンプレートの選択、`gh pr create` による PR 作成までを一貫して扱う。ユーザーが「PR 作って」「プルリクを出して」「この Issue に着手したい」「作業ブランチを切って進めたい」など、PR 前後の GitHub workflow を依頼した時に使う。
---

# GitHub Pull Request Creator

GitHub 上の 1 変更を Pull Request として提出可能な状態まで進める。
PR 作成だけでなく、その前段の git workflow も扱う。
作業単位は branch とし、worktree はその branch を扱う標準の作業場所として扱う。

## Workflow

### Issue の確認

ユーザーが Issue を指定した場合、その Issue を使用する。

ユーザーが「Issue 不要」と明示した場合、Issue 紐づけなしで進める。

ユーザーが指定していない場合、PR の実装内容を簡潔に要約し、どの Issue に紐づけるか、または紐づけ不要かを確認する。

### Branch と Worktree

新規タスクでは、専用 branch と専用 worktree を作ることを標準とする。
repo 直下に worktree を作ってはならない。

worktree の canonical path は次とする。

```text
$(ghq root)/.worktrees/<host>/<owner>/<repo>/<branch>
```

`<host>/<owner>/<repo>` は `origin` remote から決定する。
branch 名は repository またはユーザーの規約に従う。
明示的な規約がない場合は kebab-case を使う。

対象 branch の worktree が既にある場合は再利用する。
branch だけが存在する場合は、その branch を指す worktree を canonical path に作る。
現在の作業場所が既に対象 branch の worktree なら、そのまま続行してよい。

repo が `ghq` 管理外にあり canonical path をそのまま使えない場合は、勝手に別ルールへ逸脱せずユーザーに確認する。

main worktree や他タスクの worktree に unrelated changes がある場合は混ぜない。
専用 worktree を作るか、どの変更を対象にするかを確認する。

### Commit と Push

PR 作成前に、対象変更が commit 済みか確認する。
未 commit なら、必要な commit を先に行う。

対象 branch が remote に push 済みか確認する。
upstream が未設定なら、初回 push で upstream を設定する。

ユーザーの依頼が PR 作成だけでも、commit や push が不足していればそこで止めず補ってから進める。

### テンプレート検出

PR テンプレートを検出する。
ファイル名は大文字小文字を区別しない。

単一ファイルテンプレートは以下の順序で検索し、最初に見つかったものを使用する。

- `.github/pull_request_template.md`
- `pull_request_template.md`
- `docs/pull_request_template.md`

複数テンプレートディレクトリは以下の場所を確認する。

- `.github/PULL_REQUEST_TEMPLATE/`
- `PULL_REQUEST_TEMPLATE/`
- `docs/PULL_REQUEST_TEMPLATE/`

単一ファイルが見つかった場合は読み込んで使用する。
ディレクトリが見つかった場合は利用可能なテンプレート一覧を示し、ユーザーに選択を求める。
テンプレートが存在しない場合は [templates/default.md](templates/default.md) を使用する。

### PR 作成

PR の body は `/tmp/gh-pr-body.md` に書き出し、`--body-file` で渡す。
`--body` に直接渡してはならない。

```bash
gh pr create --title "..." --body-file /tmp/gh-pr-body.md
```

PR URL をユーザーに報告する。

## Issue Link Format

PR テンプレートの有無に関わらず、Issue 紐づけには常にフル URL 形式を使用する。

```text
- https://github.com/{owner}/{repo}/issues/xxx
```

## Title Guidelines

タイトルはタスクと実装内容を要約した自然言語の文にする。
コミットメッセージ形式は使用しない。
