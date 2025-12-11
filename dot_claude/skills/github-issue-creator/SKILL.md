---
name: github-issue-creator
description: Creates GitHub issues using gh CLI. Use when creating new issues, filing bug reports, or requesting features.
---

# GitHub Issue Creator

This skill defines rules and procedures for creating GitHub issues.

## Workflow

1. Understand the user's intent: bug report, feature request, or other type. Check if labels, assignees, or milestones are specified.
1. Check if the repository has issue templates.
1. Select the appropriate template (see Template Selection).
1. Create the issue with `gh issue create`.
1. Report the issue URL to the user.

## Template Detection

Check for templates.

```bash
if [ -d ".github/ISSUE_TEMPLATE" ]; then
    ls .github/ISSUE_TEMPLATE/
elif [ -f ".github/ISSUE_TEMPLATE.md" ]; then
    echo "Legacy single template found"
fi
```

## Template Selection

When templates exist, determine which one to use.

If the user specified a template, use it directly.

If a single template exists, use that template.

If multiple templates exist and the user did not specify one, read the template names and descriptions from their frontmatter. When the issue context clearly matches one template (e.g., user describes a bug and there's a bug_report.md), select it and inform the user which template is being used. When the match is ambiguous, present the available templates to the user and ask which one to use.

After selecting a template, read its content with `cat` and follow its structure.

If no templates exist, use [templates/default.md](templates/default.md).

## Title Guidelines

The title should be a natural language sentence summarizing the issue.
Do not use commit message format (e.g., "fix(auth): bug").

Good examples:
- ログイン時にセッションタイムアウトが発生する
- ダークモード切り替え機能を追加したい
- Login session timeout occurs unexpectedly

Bad examples:
- fix(auth): session timeout bug
- Bug

## Language

Write issue content in Japanese by default. If the user explicitly requests English, write in English.

## Creating Issues in Different Repositories

Use the `-R` flag to create an issue in a repository different from the current directory.

```bash
gh issue create -R OWNER/REPO --title "<title>" --body "<body>"
```
