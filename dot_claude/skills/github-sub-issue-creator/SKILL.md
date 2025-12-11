---
name: github-sub-issue-creator
description: Creates GitHub sub-issues and links them to parent issues using gh CLI and REST API. Use when creating child issues, breaking down large issues into smaller tasks, or establishing parent-child relationships between issues.
---

# GitHub Sub-issue Creator

This skill defines rules and procedures for creating GitHub sub-issues.

## Workflow

1. Identify the parent issue number and repository.
1. Create a new issue using `gh issue create` (or use the github-issue-creator skill).
1. Get the REST API ID of the created issue.
1. Add the issue as a sub-issue to the parent issue using the REST API.
1. Report the sub-issue URL to the user.

## Creating a Sub-issue

Sub-issues are regular issues linked to a parent issue. The gh CLI does not have a direct option to create sub-issues, so use the REST API via `gh api` command.

### Step 1: Create the Issue

Create a normal issue first.

```bash
gh issue create -R OWNER/REPO --title "<title>" --body "<body>"
```

Note the issue number from the output URL (e.g., `https://github.com/OWNER/REPO/issues/123` → issue number is 123).

### Step 2: Get the Issue ID

Get the REST API ID of the created issue. This is the numeric `id` field, not the `node_id` or issue number.

```bash
gh api repos/OWNER/REPO/issues/123 --jq .id
```

### Step 3: Add as Sub-issue

Add the issue as a sub-issue to the parent issue.

```bash
gh api repos/OWNER/REPO/issues/PARENT_ISSUE_NUMBER/sub_issues -X POST -f sub_issue_id=ISSUE_ID
```

## Example

Creating a sub-issue for parent issue #100 in octocat/hello-world:

```bash
# 1. Create the issue
gh issue create -R octocat/hello-world --title "認証モジュールのリファクタリング" --body "親 Issue #100 の一環として認証モジュールをリファクタリングする。"
# Output: https://github.com/octocat/hello-world/issues/123

# 2. Get the issue ID
gh api repos/octocat/hello-world/issues/123 --jq .id
# Output: 3000028010

# 3. Add as sub-issue
gh api repos/octocat/hello-world/issues/100/sub_issues -X POST -f sub_issue_id=3000028010
```

## Reference

For more details on the sub-issues API, see [REST API endpoints for sub-issues](https://docs.github.com/en/rest/issues/sub-issues).
