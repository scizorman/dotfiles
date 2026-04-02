# Sub-issues

Use this workflow only when a parent issue is specified.

## Confirm Inputs

Confirm:

- parent issue repository
- parent issue number
- created issue URL

Use the parent issue repository for all `gh api` calls in this workflow.

## Resolve the Created Issue Number

Extract the issue number from the created issue URL.

Example:

- `https://github.com/OWNER/REPO/issues/123` -> `123`

## Get the REST API ID

Get the numeric REST API `id` of the created issue.
Do not use the issue number or `node_id`.

```bash
gh api repos/OWNER/REPO/issues/123 --jq .id
```

## Add the Sub-issue Link

Add the created issue as a sub-issue of the parent issue.

```bash
gh api repos/OWNER/REPO/issues/PARENT_ISSUE_NUMBER/sub_issues -X POST -F sub_issue_id=ISSUE_ID
```

## Example

Create a sub-issue for parent issue `#100` in `octocat/hello-world`.
Assume the created issue URL is `https://github.com/octocat/hello-world/issues/123`.

```bash
# Get the issue ID
gh api repos/octocat/hello-world/issues/123 --jq .id
# Output: 3000028010

# Add the sub-issue link
gh api repos/octocat/hello-world/issues/100/sub_issues -X POST -F sub_issue_id=3000028010
```

## Reference

For more details, see the GitHub REST API documentation for sub-issues.
