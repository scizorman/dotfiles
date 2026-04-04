---
name: 'github-pr-creator'
description: >-
  Submit changes as a GitHub Pull Request with gh CLI.
  Covers the full workflow: issue confirmation, branch naming, implementation delegation,
  commit and push, PR template detection, and PR creation with gh pr create.
  Use when creating a pull request, opening a PR, starting work on an issue, or cutting a working branch.
compatibility: 'Requires gh CLI authenticated to GitHub and git.'
metadata:
  short-description: 'Create GitHub Pull Requests with gh CLI'
---

# GitHub Pull Request Creator

This skill handles the full workflow of submitting changes as a GitHub Pull Request: confirming the related issue, preparing a branch, and creating the PR.
If any required information is missing, ask the user before proceeding.

## Confirm Issue

Confirm the issue to link before starting work, because a PR without a clear issue link makes the purpose of the change harder to trace after the fact.

- If the user specified an issue, use it.
- If the user explicitly says no issue is needed, proceed without linking.
- If unspecified, summarize the implementation and ask which issue to link, or whether to skip linking.

## Branch Name

Determine the branch name for the task.

Branch names use kebab-case (e.g. `add-export-feature`, `fix-session-timeout`).
Do not use prefix-slash patterns like `feature/xxx` or `fix/xxx`.

## Delegate to Agent (Claude Code only)

When the task requires implementation (the user specifies an issue or describes work to do), use the Agent tool with `isolation: "worktree"` to delegate all remaining work to a subagent, but only when the current workspace does not already contain task-local work that should be continued in place.

The subagent is responsible for the complete implementation-to-PR workflow.

- Create the branch with `git switch -c <branch-name>`
- Implement the changes
- Commit and push the branch
- Detect PR templates in the repository (see template detection rules below)
- Write the PR body to `/tmp/gh-pr-body.md`
- Create the PR with `gh pr create --title "..." --body-file /tmp/gh-pr-body.md`
- Report the PR URL

Pass the subagent a prompt that includes the following.

- The issue number, title, and a summary of the issue body
- The kebab-case branch name to create
- The template detection rules and PR creation rules from this skill (copy them verbatim into the prompt)

After the subagent completes, extract the PR URL from its output and report it to the user.

### When to skip agent delegation

Skip agent delegation and continue in the current workspace when any of the following apply.

- The user already has changes on a branch and only wants to create a PR.
- The current workspace has staged changes or unstaged changes.
- The repository is in the middle of a merge, rebase, cherry-pick, revert, or bisect.
- `HEAD` is detached.
- The current branch is not the default branch and already appears to contain work for the same task. Treat this as true when the branch is ahead of its upstream branch. If the relationship between the existing branch work and the current task is unclear, ask before delegating.

In these cases, follow the Commit and Push, Detect Templates, and Create the Pull Request sections directly instead of creating a fresh delegated worktree.

---

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
