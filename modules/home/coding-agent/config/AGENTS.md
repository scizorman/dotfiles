# Global Guidelines

## Fundamentals

### Language

Always communicate in Japanese.
Technical terms may be used in English.

### Response Attitude

Never answer based on speculation.
If investigation yields no answer, say so.

- Do not accept user claims at face value. Investigate before acting on a correction.
- State the *why* alongside any non-trivial decision or config change.

---

## Workflow

### Command Execution

When a project has a Makefile, run lint, fmt, test, and similar commands through make.
Read the Makefile before execution to understand available targets and their contents.
When running from outside the working directory, specify the directory with `make -C <directory>`.

Use shell + standard UNIX tooling (jq / awk / sed / xargs) for scripting. Do not use Python or Node for ad-hoc scripts, including from subagents.

Parallelize bulk operations with `xargs -P` when iterating over many independent items.

Do not run install / curl / wget side-effects while in plan mode or before the user has approved the action.

Compute dates with `TZ=Asia/Tokyo`. Resolve relative dates ("today" / "yesterday") to absolute JST dates before recording them.

### Git

Use kebab-case for branch names.
Write commit messages in Conventional Commits format.

### GitHub Issue / PR

Write issue bodies as desired end-states in passive voice.
Do not include implementation steps, commands, file paths, resource names, or backwards-compatibility discussion.

The "Overview" section is a 1–2 sentence summary, distinct from "Goal" / "Purpose".

Do not write checkboxes (`- [ ]`) in issue or PR bodies.
Do not edit existing checkboxes on the user's behalf.

Keep issue comments within the original issue's scope.

Reference files via GitHub URLs in summaries and comments, not local paths.

For project activity summaries, prefer `gh` CLI (Issues / PRs / Projects) over `git log`.
Issue/PR/Project history reflects activity better than commits.

---

## Writing

### Style

Use plain form (常体) by default.
When editing text written in polite form (敬体), match its style.

### Formatting Rules

- Put a single half-width space between Japanese text and ASCII characters.
- Do not put a space after Japanese punctuation. Use `。` and `、` as punctuation marks.
- Do not end a sentence with a colon. This applies to introductions for bullet lists and headings as well.
- Use Markdown heading syntax (`#`, `##`, `###`). Do not use numbered lists or bold text as heading substitutes.
- Use semantic line breaks — break at sentence boundaries, not column width.
- Use bullet lists (`-`) only for independent items that can be reordered without changing meaning.
- Use numbered lists only when order matters. Write `1.` for every item (minimizes diff on reorder).
- Do not mix numbered lists and bullet lists at the same level.
- Indent nested lists with 2 spaces.
- Wrap inline code in backticks. Add a language tag to every code fence.
- Limit `**bold**` to genuinely important content. Do not use it as a heading substitute.
- Mark notes with `Note:`. Do not use `※` or `注:`.
- Mermaid node names use snake_case. Do not use abbreviations (e.g. MKT / OPP / ESC). No decorative colors (`classDef` / `style ... fill:`), emoji, or bold labels.
- Use HTML tags only for functional requirements (e.g. collapsibles). Not for decoration.
