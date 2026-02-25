# Field Operations Reference

This reference covers ID resolution, field type operations, batch updates, and troubleshooting for GitHub Projects v2.

## ID Resolution

GitHub Projects v2 uses node IDs throughout. Human-readable names must be resolved to IDs before any edit operation.

### Resolve Project ID

```bash
gh project view <PROJECT_NUMBER> --owner "@me" --format json --jq '.id'
# Output: PVT_kwDOBxxxxxx
```

### Resolve Field ID and Option IDs

```bash
gh project field-list <PROJECT_NUMBER> --owner "@me" --format json
```

Example output structure:

```json
{
  "fields": [
    {
      "id": "PVTF_lADOBxxxxxx",
      "name": "Status",
      "type": "ProjectV2SingleSelectField",
      "options": [
        { "id": "47fc9ee4", "name": "Todo" },
        { "id": "98236657", "name": "In Progress" },
        { "id": "62c28424", "name": "Done" }
      ]
    },
    {
      "id": "PVTF_lADOBxxxxxy",
      "name": "Priority",
      "type": "ProjectV2SingleSelectField",
      "options": [
        { "id": "a1b2c3d4", "name": "Critical" },
        { "id": "e5f6g7h8", "name": "High" },
        { "id": "i9j0k1l2", "name": "Medium" },
        { "id": "m3n4o5p6", "name": "Low" }
      ]
    },
    {
      "id": "PVTF_lADOBxxxxxy",
      "name": "Size",
      "type": "ProjectV2SingleSelectField",
      "options": [
        { "id": "q7r8s9t0", "name": "XS" },
        { "id": "u1v2w3x4", "name": "S" },
        { "id": "y5z6a7b8", "name": "M" },
        { "id": "c9d0e1f2", "name": "L" },
        { "id": "g3h4i5j6", "name": "XL" }
      ]
    }
  ]
}
```

### Resolve Item ID

```bash
gh project item-list <PROJECT_NUMBER> --owner "@me" --format json | \
  jq '.items[] | select(.content.number == <ISSUE_NUMBER>) | .id'
# Output: PVTI_lADOBxxxxxx
```

---

## Field Type Reference

The `gh project item-edit` command uses different flags depending on the field type.

| Field Type | `--data-type` | `item-edit` Flag | Value Format |
|---|---|---|---|
| Single Select | `SINGLE_SELECT` | `--single-select-option-id` | Option ID (8-char hex) |
| Number | `NUMBER` | `--number` | Numeric value |
| Date | `DATE` | `--date` | `YYYY-MM-DD` |
| Text | `TEXT` | `--text` | String |
| Iteration | `ITERATION` | `--iteration-id` | Iteration ID |

### Single Select Field

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --single-select-option-id <OPTION_ID>
```

### Number Field

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --number <VALUE>
```

### Date Field

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --date "2025-12-31"
```

### Text Field

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --text "Some text value"
```

### Iteration Field

Resolve the iteration ID first:

```bash
gh project field-list <PROJECT_NUMBER> --owner "@me" --format json | \
  jq '.fields[] | select(.name == "Sprint") | .iterations[] | select(.title == "<SPRINT_NAME>") | .id'
```

Then set:

```bash
gh project item-edit \
  --project-id <PROJECT_ID> \
  --id <ITEM_ID> \
  --field-id <FIELD_ID> \
  --iteration-id <ITERATION_ID>
```

---

## Batch Field Updates

To update multiple fields on one item, run `gh project item-edit` once per field. There is no multi-field flag in a single command.

Pattern for setting Status + Priority + Size in sequence:

```bash
# Status → In Progress
gh project item-edit --project-id <PROJECT_ID> --id <ITEM_ID> \
  --field-id <STATUS_FIELD_ID> --single-select-option-id <IN_PROGRESS_OPTION_ID>

# Priority → High
gh project item-edit --project-id <PROJECT_ID> --id <ITEM_ID> \
  --field-id <PRIORITY_FIELD_ID> --single-select-option-id <HIGH_OPTION_ID>

# Size → M
gh project item-edit --project-id <PROJECT_ID> --id <ITEM_ID> \
  --field-id <SIZE_FIELD_ID> --single-select-option-id <M_OPTION_ID>
```

---

## Troubleshooting

### "Could not resolve to a node with the global id"

The Project ID, Field ID, or Item ID is incorrect. Re-run ID resolution steps.

Common causes:
- Using the project number (integer) where the project ID (node ID) is required
- Using the issue number where the item ID is required
- Copy-paste error in IDs

### "Field not found" or missing field in `field-list`

The field may have been renamed or deleted. Re-run `gh project field-list` to get the current state.

### Single-select option not found

The option ID is case-sensitive and specific to the project. Re-run `gh project field-list` and copy the option ID exactly.

### Item not found in `item-list`

The issue may not have been added to the project yet. Use `gh project item-add` first.

### Authentication errors

Ensure the token has the `project` scope:

```bash
gh auth status
gh auth refresh -s project
```
