---
name: github-project-operator
description: Manages GitHub Projects v2 write operations using gh CLI. Use when adding issues or PRs to a project, creating tasks (issues) in a project, updating field values (Status, Priority, Size, Sprint, etc.), creating draft issues, creating fields, or archiving items. Also use at the start of a session when selecting a project to work with.
---

# GitHub Project Operator

This skill defines rules and procedures for write operations on GitHub Projects v2.

## Session Initialization: Project Selection

At the start of each session, select the target project and collect all required IDs.

### Step 1: List Projects

```bash
gh project list --owner "@me" --format json
```

Present the list to the user and ask which project to use.

### Step 2: Collect Project Metadata

Once the user selects a project, retrieve the Project ID and field definitions in one batch.

```bash
# Get the project number from the list output
gh project view <NUMBER> --owner "@me" --format json

# List all fields with their IDs and option IDs
gh project field-list <NUMBER> --owner "@me" --format json
```

Retain the following values for the entire session:

| Value | Description |
|---|---|
| Project ID | `id` field from `gh project view` (node ID format: `PVT_...`) |
| Field ID | `id` field per field from `gh project field-list` |
| Option ID | `id` per option within single-select fields |

For field type specifics and ID resolution procedures, see [references/field-operations.md](references/field-operations.md).

## Workflow: Create a Task

Use this workflow when the user wants to create a new issue and add it to the project.

### Step 1: Create the Issue

Use the `github-issue-creator` skill to create the issue. This applies issue templates, title guidelines, and language settings.

Note the issue URL from the output (e.g., `https://github.com/OWNER/REPO/issues/123`).

### Step 2: Add the Issue to the Project

```bash
gh project item-add <PROJECT_NUMBER> --owner "@me" --url <ISSUE_URL>
```

Note the item ID from the output (`PVTI_...`).

### Step 3: Set Field Values

Set Status, Priority, Size, Sprint, and other fields as needed.

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --single-select-option-id <OPTION_ID>
```

For the full flag reference by field type, see [references/field-operations.md](references/field-operations.md).

## Workflow: Create a Sub-task

Use the `github-issue-creator` skill with the parent issue number to create and link the sub-issue, then add it to the project following the same steps as above.

## Workflow: Add Existing Issue or PR to Project

```bash
gh project item-add <PROJECT_NUMBER> --owner "@me" --url <ISSUE_OR_PR_URL>
```

## Workflow: Create a Draft Issue

Draft issues exist only within the project and have no associated repository issue.

```bash
gh project item-create <PROJECT_NUMBER> --owner "@me" \
  --title "<title>" \
  --body "<body>"
```

After creation, set field values using `gh project item-edit` as needed.

## Workflow: Update Field Values

When updating fields on an existing project item:

1. Resolve the item ID if not already known:

```bash
gh project item-list <PROJECT_NUMBER> --owner "@me" --format json | \
  jq '.items[] | select(.content.number == <ISSUE_NUMBER>)'
```

2. Update the field:

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --single-select-option-id <OPTION_ID>   # for single-select fields
```

For other field types (number, date, text, iteration), see [references/field-operations.md](references/field-operations.md).

## Workflow: Create a Field

```bash
gh project field-create <PROJECT_NUMBER> --owner "@me" \
  --name "<Field Name>" \
  --data-type <TYPE>
```

Supported `--data-type` values: `TEXT`, `NUMBER`, `DATE`, `SINGLE_SELECT`, `ITERATION`.

For `SINGLE_SELECT`, options must be added via the GitHub web UI or GraphQL API after creation.

## Workflow: Archive an Item

```bash
gh project item-archive <PROJECT_NUMBER> --owner "@me" --id <ITEM_ID>
```

## Notes

- Always resolve Project ID, Field ID, and Option ID before making edits. These IDs are node IDs (e.g., `PVT_...`, `PVTF_...`, `62c28424`), not human-readable names.
- Project numbers (integers) are used with `gh project item-add`, `gh project item-list`, and `gh project field-list`. Project IDs (node IDs) are used with `gh project item-edit`.
- When the user does not specify field values, omit them rather than guessing defaults.
