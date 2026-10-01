---
name: 'github-issue-pr-operator'
description: >-
  Comment on, close, reopen, and edit GitHub Issues and Pull Requests with gh CLI.
  Use when commenting on an issue or PR, closing or reopening an issue or PR,
  editing an issue or PR body, reporting completed work, sharing progress,
  summarizing investigation results, recording design decisions, proposing implementation plans,
  or changing the design or scope of work on an open PR.
  Do not use for inline pull request review comments on specific files or lines.
compatibility: 'Requires gh CLI authenticated to GitHub with permission to comment on the target repository.'
metadata:
  short-description: 'Comment on, close, reopen, and edit GitHub Issues and PRs'
---

# GitHub Issue/PR Operator

This skill handles operations on existing GitHub issues and pull requests: posting comments, closing, reopening, and editing bodies.
It covers regular issue comments and PR timeline comments.
It does not cover file-level review comments, pending reviews, or approval/request-changes workflows.
Write comments in Japanese by default. If the issue or PR is written in English, write in English.
If the target or the comment intent is ambiguous, ask the user before posting.

## Shared Conventions

These apply to every comment, body edit, and lifecycle operation.

- Reference files via GitHub URLs, not local paths, so links work for every reader.
- Do not write checkboxes (`- [ ]`) in issue or PR bodies or comments, and do not edit existing checkboxes on the user's behalf.
- Keep issue comments within the original issue's scope; open a new issue for out-of-scope findings.

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

## Close and Reopen

Close issues with an explicit `--reason`, because the reason distinguishes finished work from abandoned work in later searches.

```bash
gh issue close <ISSUE_NUMBER> --reason completed
gh issue close <ISSUE_NUMBER> --reason "not planned"
```

Choose `completed` when the described outcome was achieved, and `not planned` when the issue is abandoned or superseded.
If neither clearly applies, ask the user.
When closing after finishing work, post a work report comment first so the resolution is traceable.

## Edit Bodies

Edit issue or PR bodies with `--body-file` to avoid shell parsing problems.

```bash
gh issue edit <ISSUE_NUMBER> --body-file /tmp/gh-issue-body.md
gh pr edit <PR_NUMBER> --body-file /tmp/gh-pr-body.md
```

Preserve the parts of the body you were not asked to change, including existing checkboxes and their states.

## Design Changes on an Open PR

Before implementing a design or scope change on an open PR, post the reasoning and approach as a PR comment first, so reviewers see the direction change before the diff changes under them.
