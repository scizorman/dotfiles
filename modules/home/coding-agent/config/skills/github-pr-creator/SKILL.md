---
name: 'github-pr-creator'
description: >-
  Submit changes as a GitHub Pull Request with gh CLI.
  Covers the full workflow: issue confirmation, branch naming, ghq-based git worktree creation or reuse,
  commit and push, PR template detection, and PR creation with gh pr create.
  Use when creating a pull request, opening a PR, starting work on an issue, or cutting a working branch.
compatibility: 'Requires gh CLI authenticated to GitHub, git, and ghq for worktree management.'
metadata:
  short-description: 'Create GitHub Pull Requests with gh CLI using ghq worktrees'
---

# GitHub Pull Request Creator

This skill handles the full workflow of submitting changes as a GitHub Pull Request: confirming the related issue, preparing a branch and worktree, committing and pushing, detecting PR templates, and creating the PR with `gh` CLI.
The unit of work is a branch, and a worktree is the standard workspace for that branch.
If any required information is missing, ask the user before proceeding.

## Confirm Issue

Confirm the issue to link before starting work, because a PR without a clear issue link makes the purpose of the change harder to trace after the fact.

- If the user specified an issue, use it.
- If the user explicitly says no issue is needed, proceed without linking.
- If unspecified, summarize the implementation and ask which issue to link, or whether to skip linking.

## Branch and Worktree

Create a dedicated branch and worktree for each task, because mixing unrelated changes in a single branch or the main worktree makes PRs harder to review and revert.
Never create a worktree inside the repository root.

The canonical worktree path is:

```text
$(ghq root)/.worktrees/<host>/<owner>/<repo>/<branch>
```

`<host>/<owner>/<repo>` is derived from the `origin` remote.
Branch names follow the repository or user conventions; default to kebab-case when no convention is specified.

- If a worktree for the target branch already exists, reuse it.
- If only the branch exists without a worktree, create a worktree at the canonical path for that branch.
- If the current location is already the target branch's worktree, continue in place.
- If the repository is not managed by `ghq` and the canonical path cannot be used, ask the user rather than silently deviating to a different layout.
- If the main worktree or another task's worktree has unrelated changes, do not mix them in. Ask whether to create a dedicated worktree or which changes to include.

## Commit and Push

Verify that all target changes are committed and pushed before creating the PR, because `gh pr create` requires an up-to-date remote branch to succeed.

- If any target changes are uncommitted, commit them first.
- If the branch has not been pushed to the remote, push it. Set the upstream on the first push.
- Even when the user asks only to create a PR, fill in any missing commit or push steps rather than stopping.

## Detect Templates

Detect PR templates in the target repository.
Following the repository's established template keeps pull requests readable and consistent for reviewers.
Filenames are case-insensitive.

Single-file template locations in priority order:

- `.github/pull_request_template.md`
- `pull_request_template.md` (repository root)
- `docs/pull_request_template.md`

Multiple-template directory locations:

- `.github/PULL_REQUEST_TEMPLATE/`
- `PULL_REQUEST_TEMPLATE/` (repository root)
- `docs/PULL_REQUEST_TEMPLATE/`

If a single-file template exists, read and follow it.
If a templates directory exists, list the available templates and ask the user which one to use.
If no template exists, use [templates/default.md](templates/default.md).
Note that this default template is written in Japanese.

## Create the Pull Request

Write the final PR body to `/tmp/gh-pr-body.md`, then create the PR with `--body-file`.
This avoids shell parsing problems caused by headings or HTML comments in the body.
If `gh` is unavailable, unauthenticated, or lacks access to the target repository, stop and report the failure clearly.

```bash
gh pr create --title "..." --body-file /tmp/gh-pr-body.md
```

Record and report the created PR URL to the user.

### Issue link format

Always use the full URL form when linking an issue, regardless of whether a PR template is used.
Full URLs work correctly from any repository context and leave no ambiguity.

```text
- https://github.com/{owner}/{repo}/issues/xxx
```

### Title format

Write the title as a natural-language sentence summarizing the task and the change.
This keeps PR lists and search results readable.
Commit-message format (e.g., `fix(auth): bug`) is meaningless outside of a git log and makes PRs harder to scan.

Good examples:

- ログイン画面のセッション管理を修正する
- ダッシュボードにエクスポート機能を追加する
- Fix session management on the login page

Bad examples:

- fix(auth): session timeout bug
- WIP
