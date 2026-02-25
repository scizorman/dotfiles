# Report Templates

This reference defines the output formats for GitHub Project reports.

---

## Sprint Summary

Use this format for sprint progress summaries.

```markdown
## スプリントサマリー: <Sprint Name>

**期間:** <Start Date> – <End Date>
**生成日:** <Today's Date>

### 進捗

| ステータス | 件数 |
|---|---|
| 完了 | X |
| 進行中 | X |
| 未着手 | X |
| ブロック中 | X |
| **合計** | **X** |

**完了率:** X% (X / X 件)

### 完了済みタスク

- #123 タスクタイトル (@assignee)
- #124 タスクタイトル (@assignee)

### 進行中タスク

- #125 タスクタイトル (@assignee) — Priority: High
- #126 タスクタイトル (@assignee) — Priority: Medium

### 未完了タスク (スプリント繰り越し候補)

- #127 タスクタイトル — 未着手
- #128 タスクタイトル — ブロック中: <理由>
```

---

## Health Check Report

Use this format for project health checks.

```markdown
## プロジェクトヘルスチェック

**プロジェクト:** <Project Name>
**生成日:** <Today's Date>

### サマリー

| チェック項目 | 結果 | 件数 |
|---|---|---|
| ブロッカー | ⚠️ 要対応 / ✅ 問題なし | X |
| 未アサイン (進行中) | ⚠️ 要対応 / ✅ 問題なし | X |
| 未見積もり | ⚠️ 要対応 / ✅ 問題なし | X |
| WIP 過多 | ⚠️ 要対応 / ✅ 問題なし | X / 上限X |
| 期限超過 | ⚠️ 要対応 / ✅ 問題なし | X |

### ブロッカー

<!-- List if any, otherwise omit this section -->
- #123 タスクタイトル — ブロック理由: <reason>

### 未アサイン (進行中)

<!-- List if any, otherwise omit this section -->
- #125 タスクタイトル — Status: In Progress, Assignee: なし

### 未見積もり

<!-- List if any, otherwise omit this section -->
- #127 タスクタイトル — Size: 未設定

### WIP 過多

<!-- Include only if WIP count exceeds the limit -->
現在の WIP: X 件 (上限: X 件)
- #128 タスクタイトル (@assignee)
- #129 タスクタイトル (@assignee)

### 期限超過

<!-- List if any, otherwise omit this section -->
- #130 タスクタイトル — 期限: <Due Date>, 現在のステータス: <Status>

### 推奨アクション

1. <Action item 1>
2. <Action item 2>
```

---

## Progress Report

Use this format for narrative progress reports (e.g., sprint retrospective input, stakeholder update).

```markdown
## 進捗レポート: <Project Name>

**対象期間:** <Start Date> – <End Date>
**作成者:** <Author>
**生成日:** <Today's Date>

### エグゼクティブサマリー

<2–3 sentence summary of overall progress. State what was accomplished, what is in progress, and any significant blockers or risks.>

### 完了した成果

- <Outcome 1>: #123, #124 が完了。<Brief impact statement.>
- <Outcome 2>: #125 が完了。<Brief impact statement.>

### 現在の状況

**進行中のタスク (X 件)**

| # | タイトル | Priority | 担当者 | 備考 |
|---|---|---|---|---|
| #126 | タスクタイトル | High | @assignee | — |
| #127 | タスクタイトル | Medium | @assignee | レビュー待ち |

### ブロッカーとリスク

<!-- Omit if none -->
| # | タイトル | ブロック理由 | 対応方針 |
|---|---|---|---|
| #128 | タスクタイトル | 外部依存待ち | <Action> |

### 次期スプリントの見通し

<Summary of planned work for the next sprint and any capacity concerns.>

### メトリクス

| 指標 | 値 |
|---|---|
| 完了件数 (今期) | X 件 |
| 完了率 | X% |
| 平均サイクルタイム | X 日 |
| ブロッカー件数 | X 件 |
```

---

## Prioritized Task List

Use this format when extracting high-priority tasks.

```markdown
## 優先タスク一覧

**プロジェクト:** <Project Name>
**生成日:** <Today's Date>
**フィルター:** Priority = Critical, High / Status ≠ Done

| Priority | # | タイトル | Status | 担当者 | Size |
|---|---|---|---|---|---|
| Critical | #123 | タスクタイトル | In Progress | @assignee | M |
| Critical | #124 | タスクタイトル | Todo | — | L |
| High | #125 | タスクタイトル | Blocked | @assignee | S |
| High | #126 | タスクタイトル | Todo | — | — |

**合計:** X 件 (Critical: X 件, High: X 件)
```
