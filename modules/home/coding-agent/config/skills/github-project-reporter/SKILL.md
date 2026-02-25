---
name: github-project-reporter
description: Reads and analyzes GitHub Projects v2 data using gh CLI. Use when listing items by status, extracting high-priority tasks, generating sprint progress summaries, detecting blockers or health issues (unassigned items, overdue items, WIP excess), or producing progress reports.
---

# GitHub Project Reporter

This skill defines rules and procedures for read operations, analysis, and report generation on GitHub Projects v2.

## Session Initialization: Project Selection

At the start of each session, select the target project.

### Step 1: List Projects

```bash
gh project list --owner "@me" --format json
```

Present the list to the user and ask which project to use.

### Step 2: Collect Project Metadata

```bash
gh project view <NUMBER> --owner "@me" --format json
gh project field-list <NUMBER> --owner "@me" --format json
```

Retain the Project number, Project ID, and field definitions for the session.

## Workflow: List Items by Status

```bash
gh project item-list <PROJECT_NUMBER> --owner "@me" --format json
```

Group and display items by their Status field value. Use the field definitions collected during initialization to resolve option IDs to human-readable names.

For report formats, see [references/report-templates.md](references/report-templates.md).

## Workflow: Extract High-Priority Tasks

From the item list, filter items where:

- Status is not `Done` / `Closed` (or equivalent)
- Priority is `Critical` or `High` (or the highest available options)

Sort by Priority descending, then by creation date ascending (oldest first).

Present as a prioritized task list with issue numbers, titles, assignees, and current status.

## Workflow: Sprint Progress Summary

Collect all items in the current sprint or iteration:

```bash
gh project item-list <PROJECT_NUMBER> --owner "@me" --format json | \
  jq '[.items[] | select(.fieldValues[] | select(.field.name == "Sprint") | .name == "<SPRINT_NAME>")]'
```

Calculate:

- Total items in sprint
- Completed items (Status = Done or equivalent)
- Completion rate (%)
- Remaining items by status

Use the Sprint Summary template from [references/report-templates.md](references/report-templates.md).

## Workflow: Health Check

Run all of the following checks and produce a Health Check Report.

### Blocker Detection

Items with Status `Blocked` or with a `Blocked` label:

```bash
gh project item-list <PROJECT_NUMBER> --owner "@me" --format json | \
  jq '[.items[] | select(.fieldValues[] | select(.field.name == "Status") | .name == "Blocked")]'
```

### Unassigned Items

Items in progress (Status = `In Progress` or equivalent) with no assignee:

```bash
gh project item-list <PROJECT_NUMBER> --owner "@me" --format json | \
  jq '[.items[] | select(.assignees == null or (.assignees | length == 0))]'
```

### Unestimated Items

Items without a Size (or Story Points / Effort) field value:

Filter items where the Size field value is null or empty.

### WIP Excess

Count items with Status `In Progress`. If the count exceeds the WIP limit (ask the user if not configured), flag as warning.

### Overdue Items

Items with a due date field (e.g., `Due Date`) earlier than today and Status not `Done`:

```bash
# Today's date
date +%Y-%m-%d
```

Filter items where due date < today and status != Done.

Use the Health Check Report template from [references/report-templates.md](references/report-templates.md).

## Workflow: Progress Report

Generate a narrative progress report combining sprint summary, health check, and recent completions.

Use the Progress Report template from [references/report-templates.md](references/report-templates.md).

## Notes

- All read operations use `gh project item-list` with `--format json` and `jq` for filtering.
- Field values are stored as structured objects; always resolve option IDs to names using the field definitions collected during initialization.
- When data is insufficient for a metric (e.g., no Sprint field exists), state clearly that the metric is not available rather than skipping it silently.
- Dates are in ISO 8601 format (`YYYY-MM-DD`).
