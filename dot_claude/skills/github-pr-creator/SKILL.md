---
name: github-pr-creator
description: Creates GitHub pull requests using gh CLI. Use when creating PRs, submitting code changes, or proposing merges.
---

# GitHub Pull Request Creator

This skill defines rules and procedures for creating GitHub pull requests.

## Workflow

1. Ensure the branch is created and changes are committed and pushed. (Refer to git-operator skill for Git operations.)
1. Determine Issue linking (see Issue Linking).
1. Check if the repository has PR templates.
1. Create the pull request with `gh pr create`.
1. Report the PR URL to the user.

## Issue Linking

If the user specified which Issue to link, use that Issue.

If the user explicitly indicated no Issue linking is needed, proceed without linking.

If the user did not specify, ask the user which Issue this PR should be linked to, or whether Issue linking is not needed for this PR.
Provide context by briefly summarizing what the PR implements to help the user decide.

## Issue Link Format

Regardless of whether a PR template exists, always use the full URL format for Issue linking.

`- https://github.com/{owner}/{repo}/issues/xxx`

## Template Detection

Check for PR templates.

```bash
if [ -f ".github/PULL_REQUEST_TEMPLATE.md" ]; then
    cat .github/PULL_REQUEST_TEMPLATE.md
elif [ -d ".github/PULL_REQUEST_TEMPLATE" ]; then
    ls .github/PULL_REQUEST_TEMPLATE/
fi
```

If templates exist, read the content and follow the structure.
If no templates exist, use [templates/default.md](templates/default.md).

## Title Guidelines

The title should be a natural language sentence summarizing the task and the implemented changes.
Do not use commit message format (e.g., "chore(update): xxx").

## Language

Write PR content in Japanese by default.
If the user explicitly requests English, write in English.
