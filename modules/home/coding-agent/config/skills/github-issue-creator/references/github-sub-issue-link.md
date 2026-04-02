# GitHub Sub-issue Link

## Get the REST API ID

Get the numeric REST API `id` of the created issue.
Do not use the issue number or `node_id`.

```bash
gh api repos/OWNER/REPO/issues/123 --jq .id
# => 3000028010
```

## Add the Sub-issue Link

Call the API against the parent issue's repository.

```bash
gh api repos/OWNER/REPO/issues/PARENT_NUMBER/sub_issues \
  -X POST -F sub_issue_id=ISSUE_ID
```

On success, the API returns the sub-issue object.

## Cross-repo sub-issues

When the child issue lives in a different repository than the parent, the same commands apply.
Always use the parent issue's repository in the `gh api repos/...` path.
Retrieve the child issue's `id` from the child issue's repository.
