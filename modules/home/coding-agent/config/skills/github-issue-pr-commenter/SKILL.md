---
name: 'github-issue-pr-commenter'
description: >-
  Post structured comments to GitHub Issues and Pull Requests with gh CLI.
  Use when reporting completed work, sharing progress, summarizing investigation results,
  recording design decisions, proposing implementation plans, asking for feedback,
  or adding supplementary context to a pull request conversation.
  Do not use for inline pull request review comments on specific files or lines.
compatibility: 'Requires gh CLI authenticated to GitHub with permission to comment on the target repository.'
metadata:
  short-description: 'Post structured comments to GitHub Issues and PRs'
---

# GitHub Issue/PR Commenter

This skill handles posting structured comments to GitHub issue and pull request conversations.
It covers regular issue comments and PR timeline comments.
It does not cover file-level review comments, pending reviews, or approval/request-changes workflows.
Write comments in Japanese by default. If the issue or PR is written in English, write in English.
If the target or the comment intent is ambiguous, ask the user before posting.

## Confirm the Comment Type

Decide whether the user wants an issue comment or a pull request conversation comment,
because posting the wrong type of comment creates noise in the wrong thread.

Stop and clarify when the request actually implies:

- an inline review comment on a specific file or line
- a pull request review summary
- an approve/request-changes review

## Identify the Target

Determine the issue or PR number or URL and the repository.
Misidentifying the target posts a comment in an unrelated thread and confuses collaborators.
If the user did not specify them, infer from context such as the branch name, recent commits, or remotes.
If the inference is still ambiguous, ask before posting.

## Select the Comment Intent

Choose one primary intent before writing the body,
because mixing multiple purposes in one comment buries the key message and makes it unclear what action is expected.
Read [references/comment-intents.md](references/comment-intents.md) when the intent is unclear.

- work report: [templates/work-report.md](templates/work-report.md)
- progress update: [templates/progress-update.md](templates/progress-update.md)
- investigation summary: [templates/investigation-summary.md](templates/investigation-summary.md)
- design proposal: [templates/design-proposal.md](templates/design-proposal.md)
- PR supplement: [templates/pr-supplement.md](templates/pr-supplement.md)

If a comment must address multiple intents, keep the primary template and add only the minimum supporting sections needed.

## Gather Supporting Facts

Collect only the information required for the chosen intent.
Overloading a comment with tangential data buries the conclusion the reader needs to act on.
Read the issue or pull request thread first so the comment does not repeat facts that are already visible there.

Depending on the intent, gather:

- what was completed, what was verified (including commands run and key output), and what remains
- the question or problem being addressed, the conclusion, and the evidence that supports it
- the constraints and tradeoffs behind a proposed direction
- the unresolved points and what is needed to resolve them
- the exact action or decision being requested from the reader

## Compose the Comment

Start from the selected template.
Remove the instructional comments before posting and omit sections that do not apply.
Do not leave empty headings.

Lead with the conclusion or current status before supporting detail.
Write not only what happened or what is proposed, but why — the reasoning, constraints, or evidence behind it.
Without the why, reviewers cannot judge whether the conclusion is correct or suggest better alternatives.
Make the requested decision, feedback, or follow-up explicit.

Cross-reference related commits, PRs, or issues using `#123` for the same repository and full URLs for cross-repository references.
Do not dump file-by-file implementation details unless they are necessary for the requested decision.
When reporting blockers, state what is blocked, why it is blocked, and what is needed to unblock.

## Post the Comment

Write the comment body to a temporary file and pass it with `--body-file`,
because shell parsing problems caused by Markdown headings or HTML comments in the body corrupt the posted text.
If `gh` is unavailable, unauthenticated, or lacks permission for the target repository, stop and report the failure clearly.

For issue comments, write to `/tmp/gh-issue-comment.md`:

```bash
gh issue comment <ISSUE_NUMBER> --body-file /tmp/gh-issue-comment.md
```

For a different repository:

```bash
gh issue comment <ISSUE_NUMBER> -R OWNER/REPO --body-file /tmp/gh-issue-comment.md
```

For pull request comments, write to `/tmp/gh-pr-comment.md`:

```bash
gh pr comment <PR_NUMBER> --body-file /tmp/gh-pr-comment.md
```

For a different repository:

```bash
gh pr comment <PR_NUMBER> -R OWNER/REPO --body-file /tmp/gh-pr-comment.md
```

Record the comment URL and report it to the user.
