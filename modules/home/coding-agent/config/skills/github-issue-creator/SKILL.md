---
name: 'github-issue-creator'
description: >-
  Create GitHub issues with gh CLI, including standard issues and sub-issues linked to a parent issue.
  Use when creating a new issue, breaking down a larger issue into child issues,
  or establishing a parent-child relationship between issues.
  Detect repository issue templates, apply title and body conventions, and create the issue with gh CLI.
compatibility: 'Requires gh CLI authenticated to GitHub with permission to access the target repository.'
metadata:
  short-description: 'Create GitHub issues and sub-issues with gh CLI'
---

# GitHub Issue Creator

This skill handles the full lifecycle of creating a GitHub issue: gathering inputs, detecting repository templates, and creating the issue with `gh` CLI.
When a parent issue is specified, the workflow extends to link the created issue as a sub-issue.
If any required information is missing, ask the user before proceeding.

## Confirm Inputs

Confirm the following before creating the issue, because creating an issue in the wrong repository or under the wrong parent is tedious to undo.

- target repository
- issue title and purpose
- labels, assignees, and milestone when specified
- parent issue number when the new issue should become a sub-issue

## Detect Templates

Detect issue templates in the target repository.
Following the repository's established template keeps the issue readable and consistent for maintainers.
Filenames are case-insensitive.

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
Note that this default template is written in Japanese.

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

### Title format

Write the title as a natural-language sentence describing the issue.
This keeps issue lists and search results readable.
Commit-message format (e.g., `fix(auth): bug`) is meaningless outside of a git log and makes issues harder to scan.

Good examples:

- ログイン時にセッションタイムアウトが発生する
- ダークモード切り替え機能を追加したい
- Login session timeout occurs unexpectedly

Bad examples:

- fix(auth): session timeout bug
- Bug

## Link a Parent Issue

When a parent issue is specified, read [references/github-sub-issue-link.md](references/github-sub-issue-link.md) for the exact commands to link the created issue as a sub-issue.
Report the created issue URL after the link succeeds.
