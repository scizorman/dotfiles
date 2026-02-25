---
name: github-issue-commenter
description: Posts work report comments to GitHub Issues or PRs using gh CLI. Use when reporting completed work, posting progress updates, summarizing changes made in a session, or adding structured comments to issues or PRs. Also use when the user says "issue にコメントして", "作業報告して", or "進捗を報告して".
---

# GitHub Issue Commenter

This skill defines rules and procedures for posting work report comments to GitHub Issues and Pull Requests.

## Workflow

### Step 1: Identify the Target

Determine the issue or PR number and the repository. If not specified by the user, infer from context (e.g., the branch name, recent commits, or current working directory).

```bash
# Check current branch for issue number hints
git branch --show-current

# Check recent commits
git log --oneline -5
```

### Step 2: Gather Work Content

Collect the information to include in the comment.

For session-end reports, gather:

```bash
# Changes made in this session
git diff main...HEAD --stat

# Commits made
git log main...HEAD --oneline
```

For progress updates, ask the user what to include if not specified.

### Step 3: Compose the Comment

Use [templates/default.md](templates/default.md) as the base structure. Adapt sections based on the context:

- For work reports: fill in the summary, changes, and next steps sections.
- For progress updates: fill in the current status and blockers sections.
- Omit sections that are not applicable. Do not include empty sections.

### Step 4: Post the Comment

```bash
gh issue comment <ISSUE_NUMBER> --body "<comment>"
```

For repositories other than the current directory:

```bash
gh issue comment <ISSUE_NUMBER> -R OWNER/REPO --body "<comment>"
```

For PR comments:

```bash
gh pr comment <PR_NUMBER> --body "<comment>"
```

For multi-line comments, use a heredoc or a temporary file to avoid shell escaping issues:

```bash
gh issue comment <ISSUE_NUMBER> --body-file /tmp/comment.md
```

### Step 5: Confirm

Report the comment URL to the user.

## Language

Write comments in Japanese by default. If the issue or PR is written in English, write in English.

## Guidelines

- Be concise. Reviewers and collaborators should be able to understand the update at a glance.
- Prefer bullet points for lists of changes. Use prose for context and explanations.
- Include references to related commits, PRs, or issues using GitHub's cross-reference syntax (`#123`, `OWNER/REPO#123`).
- Do not include internal implementation details that are irrelevant to the issue's goals.
- When reporting blockers, be specific: state what is blocked, why, and what is needed to unblock.
