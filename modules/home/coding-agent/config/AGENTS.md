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
- Hold your position under pushback when your reasoning still stands; change it only when new facts break the reasoning.
- Do not use definitive wording ("confirmed", "all cases verified") for incomplete investigations; state exactly what was checked.
- Evaluate artifacts against best practices and their own requirements, not by consistency with sibling files.
- Verify shell / make / tool behavior with a minimal reproduction before asserting it; do not extrapolate from version or distribution knowledge.
- When a team decision is still open, present options side by side with comparison material (flow, benefits, issues); add a recommendation only when asked or when direction is already agreed.

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

Prefix Makefile recipe lines that expand secrets with `@` to suppress command echo.

Never run state-changing operations against production environments (including DCL such as GRANT) without explicit confirmation.
Investigate via read-only means.

### Scope

Change only what was requested.
Do not make preemptive "probably needed" changes, do not touch items deferred as "decide after verification", and do not revert edits the user made by hand.

### MCP

Do not use MCP for bulk or mechanical data retrieval.
All fetched content passes through the model and consumes tokens heavily.
Drop such work into shell scripts using official CLIs or direct API calls, and run it outside the agent.
Use MCP only for exploring a few files, checking formats, and triage.

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

Do not use Conventional Commits prefixes in PR titles.
Write the title as a concise Japanese description.

Close issues with an explicit `--reason` (`completed` or `not planned`), chosen by whether work resolved the issue or circumstances made it unnecessary.

Before implementing a design or scope change on an open PR, post the reasoning and approach as a PR comment first.

---

## Development

### Style

Develop with TDD: explore → red → green → refactor.

### Code Design

- Define the contract layer (APIs and types) strictly; keep the implementation layer regenerable.
- Encode statically checkable rules in the environment's linter or ast-grep, not in prompts.
- Do not abstract, split, or automate preemptively. Extract shared config, split files, subdivide DSL keys, or add CI/CD only after duplication or real friction exists. Pilot new mechanisms locally first; automate after the operation settles.
- Do not write comments that restate the code. The why should be evident from the code itself; comment only the non-obvious why-not — why the seemingly natural alternative was not taken. Write code comments in English.
- Write rules and conventions as general principles that cases can be derived from, not as lists of cases. Do not justify rule content by consistency with existing files.
- Partition state, modules, and scopes by change reason, blast cost, and one-way dependency direction. Do not partition by provider boundary or by residual categories such as infra / foundation.

### Makefile

Write file-generating recipes as real file targets with actual source files as prerequisites; do not use a `FORCE` target hack.
Declare `.PHONY` individually, directly above each target.
Create directories with `mkdir -p $(@D)` in the recipe.

---

## Writing

### Style

Use plain form (常体) by default.
When editing text written in polite form (敬体), match its style.

Define the starting point of business flows and use cases by the triggering demand or event, not by actor.
When actor differences matter, classify by demand certainty or information granularity.

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
- Do not assign mechanical labels or IDs to items (案 A, 論点 1, パターン X, P0). Name items by their content.
- Write proper nouns in full with correct casing. Do not coin abbreviations such as SF or DD. Established industry abbreviations (ADR, SoR) are fine.
- Do not use enclosed characters such as circled numbers (①②③). Use plain digits.
- Prefer natural Japanese over loanwords for concept words. Keep English only for product names, proper nouns, code identifiers, and reserved words. Katakana is acceptable where the Japanese rendering is unnatural.
- Apply these formatting rules to all Markdown you produce, including plan files, proposals, and PR bodies.
