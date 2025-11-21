# Claude Code グローバル設定

このファイルは、すべてのプロジェクトで Claude Code が動作する際のガイダンスを提供する。

## 会話ガイドライン

- 常に日本語で会話する。技術用語は英単語を使用しても構わない。
- 憶測で回答しない。
- 調査した結果、わからなかったことはわからないと回答する。

## 文章作成ガイドライン

Claude Code が生成する文章（Markdown 出力、Issue、Pull Request の説明文など）に適用されるルール。

### 文体の統一

基本的に常体を使用する。
ただし、編集対象の文章が敬体の場合は、その文体に合わせる。

### 表記ルール

- 数字の箇条書き（1. 2. 3.）で見出しを表現しない
- **太字**で見出しを表現しない
- Markdown の見出し記法（#, ##, ###）を適切に使用する
- 箇条書きで文章の流れを表現しない
- 数字の箇条書きと通常の箇条書き（- または *）を同一階層で併用しない
- 文章をコロン（:）で終わらせて箇条書きに続けない。文章は句点で終わらせる

## タスクガイドライン

問題とは、目標と現状のギャップであり、目標達成のために解決すべき事柄である。
まず Issue で問題を整理し、解決のための具体的なアクション（課題）を定義する。
その課題の単位が Pull Request である。

### 問題の整理 (Issue)

#### 1. Issueの作成

タイトルは commit message の形式（例: chore(update): xxx）ではなく、ユーザーが Claude Code に指示した問題の内容を自然な文章で簡潔にまとめる。
プロジェクトに GitHub Issue template があればそれに従い、なければ以下の構造で description をまとめる。

```markdown
### 概要

背景と目的を踏まえた Issue の概要を簡潔に記述する。

### 背景

この Issue の背景となっている問題について記述し、具体的な課題に落とし込めている場合はその課題も記述する。

### 目的

この Issue に取り組む目的を背景を踏まえて記述する。
```

### 課題の解決 (Pull Request)

#### 1. 関連ファイルを Git stage に登録する

ユーザーが Claude Code に指示したタスクの内容を読み解いて、そのタスクに関連する変更されたファイルを Git stage に登録する。

#### 2. Branch 作成

Git stage 上の変更を確認し、タスクに応じた適切な名前で branch を作成する。
branch 名は kebab-case にする（例：`add-dbt-resources`）。

#### 3. Git Commit

Git stage 上の変更を確認し、タスクに応じた適切な commit message を作成する。
commit message は [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) に従う。

#### 4. Git Push

作成した branch を remote repository に push する。

#### 5. Pull Request 作成

タイトルは commit message の形式（例: chore(update): xxx）ではなく、ユーザーが Claude Code に指示したタスクの内容と実装した変更を自然な文章で簡潔にまとめる。
プロジェクトに Pull Request template があればそれに従い、なければ以下の構造で description をまとめる。

```markdown
### 概要

背景・目的・実装内容を踏まえた Pull Request 全体の概要を簡潔に記述する。

### 背景

関連する GitHub Issue へのリンクをまず記述する。
その後、GitHub Issue の内容に基づいた背景を簡潔にまとめる。

GitHub Issue に紐づけない場合はリンクは記載しない。
この Pull Request の背景となっている問題について記述し、具体的な課題に落とし込めている場合はその課題も記述する。

### 目的

関連する GitHub Issue の目的に基づいた目的を簡潔にまとめる。
関連する GitHub Issue がない場合は、この Pull Request に取り組む目的を背景を踏まえて記述する。

### 実装内容

Pull Request のコード内容と、ユーザーが Claude Code に指示したタスクの内容をもとに、実装内容をまとめる。
細かいコードの変更内容ではなく、背景と目的を踏まえた上での実装の概要をまとめる。
```

#### Git 操作の禁止事項

以下の Git 操作は絶対に行ってはならない。

- `git commit --amend` による commit の修正
- `git push --force` や `git push -f` による強制 push

これらの操作は履歴を書き換えるため、他の開発者との協調作業において重大な問題を引き起こす可能性がある。
一度 push した commit は原則として変更せず、新しい commit で対応する。
