---
name: github-issue-creator
description: Create GitHub issues with gh CLI, including standard issues and sub-issues linked to a parent issue. Use when creating a new issue, breaking down a larger issue into child issues, or establishing a parent-child relationship between issues. Detect repository issue templates, apply title and body conventions, and create the issue with gh CLI.
compatibility: Requires gh CLI authenticated to GitHub with permission to access the target repository.
metadata:
  short-description: Create GitHub issues and sub-issues with gh CLI
---

# GitHub Issue Creator

Create GitHub issues with GitHub CLI.
When the user specifies a parent issue, create the issue first and then link it as a sub-issue.

## Confirm Inputs

Confirm:

- target repository
- issue title and purpose
- labels, assignees, and milestone when specified
- parent issue number when the new issue should become a sub-issue

When a parent issue is specified, treat the request as a sub-issue workflow.

## Detect Templates

Detect issue templates. Filenames are case-insensitive.

Single-file template locations in priority order:

- `.github/issue_template.md`
- `issue_template.md` (repository root)
- `docs/issue_template.md`

Multiple-template directory locations:

- `.github/ISSUE_TEMPLATE/`
- `ISSUE_TEMPLATE/` (repository root)
- `docs/ISSUE_TEMPLATE/`

If a single-file template exists, read and follow it.
If a templates directory exists, list the available templates and ask the user which one to use.
If no template exists, use [templates/default.md](templates/default.md).

## Create the Issue

Write the final issue body to `/tmp/gh-issue-body.md`, then create the issue with `--body-file`.
This avoids shell parsing problems caused by headings or HTML comments in the body.
If `gh` is unavailable, unauthenticated, or lacks access to the target repository, stop and report the failure clearly.

```bash
gh issue create --title "<title>" --body-file /tmp/gh-issue-body.md
```

When targeting a different repository, use `-R OWNER/REPO`.

```bash
gh issue create -R OWNER/REPO --title "<title>" --body-file /tmp/gh-issue-body.md
```

Record the created issue URL.

## Link a Parent Issue

If a parent issue is specified, continue with the sub-issue workflow after creating the issue.
Use [references/sub-issues.md](references/sub-issues.md) for the exact commands.
Report the created issue URL after the link succeeds.

## Title Guidelines

The title should be a natural-language sentence summarising the issue.
Do not use commit-message format (for example, `fix(auth): bug`).

Good examples:
- ログイン時にセッションタイムアウトが発生する
- ダークモード切り替え機能を追加したい
- Login session timeout occurs unexpectedly

Bad examples:
- fix(auth): session timeout bug
- Bug
