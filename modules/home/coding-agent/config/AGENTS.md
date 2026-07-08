# Global Guidelines

## Fundamentals

### Language

Always communicate in Japanese.
Technical terms may be used in English.

### Response Attitude

- Do not accept user claims at face value. Investigate before acting on a correction.
- Hold your position under pushback while your reasoning still stands; change it only when new facts break the reasoning.
- State the *why* alongside any non-trivial decision or config change — in the conversation or commit message, not as a code comment.
- State exactly what was checked; if investigation yields no answer, say so rather than speculating.
- Verify shell / make / tool behavior with a minimal reproduction before asserting it; do not extrapolate from version or distribution knowledge.
- Evaluate artifacts against best practices and their own requirements, not by consistency with sibling files.
- When a team decision is still open, present options side by side with comparison material (flow, benefits, issues); add a recommendation only when asked or when direction is already agreed.

---

## Workflow

### Command Execution

When a project has a Makefile, read it first and run lint, fmt, test, and similar commands through make (`make -C <directory>` from outside the working directory).

Use shell + standard UNIX tooling (jq / awk / sed / xargs) for scripting, not Python or Node — including from subagents.
Parallelize bulk operations over independent items with `xargs -P`.

Do not run install / curl / wget side-effects while in plan mode or before the user has approved the action.

Compute dates with `TZ=Asia/Tokyo` and resolve relative dates ("today" / "yesterday") to absolute JST dates before recording them.

Never run state-changing operations against production environments (including DCL such as GRANT) without explicit confirmation; investigate via read-only means.

### Scope

Change only what was requested.
Do not make preemptive "probably needed" changes, do not touch items deferred as "decide after verification", and do not revert edits the user made by hand.

### MCP

Use MCP only for exploring a few files, checking formats, and triage.
For bulk or mechanical data retrieval, use shell scripts with official CLIs or direct API calls instead — MCP output passes through the model and consumes tokens heavily.

### Git

Use kebab-case for branch names.
Write commit messages in Conventional Commits format.

### GitHub Issue / PR

Write issue bodies as desired end-states in passive voice, without implementation steps, commands, file paths, resource names, or backwards-compatibility discussion.
The "Overview" section is a 1–2 sentence summary, distinct from "Goal" / "Purpose".

Do not write checkboxes (`- [ ]`) in issue or PR bodies, and do not edit existing checkboxes on the user's behalf.

Keep issue comments within the original issue's scope.
Reference files via GitHub URLs in summaries and comments, not local paths.

For project activity summaries, prefer `gh` CLI (Issues / PRs / Projects) over `git log`; issue and PR history reflects activity better than commits.

Write PR titles as concise Japanese descriptions, not Conventional Commits prefixes.

Close issues with an explicit `--reason` (`completed` or `not planned`).

Before implementing a design or scope change on an open PR, post the reasoning and approach as a PR comment first.

---

## Development

### Style

Develop with TDD: explore → red → green → refactor.

### Code Design

- Define the contract layer (APIs and types) strictly; keep the implementation layer regenerable.
- Encode statically checkable rules in the environment's linter or ast-grep, not in prompts.
- Do not abstract, split, or automate preemptively; extract shared config, split files, or add CI/CD only after duplication or real friction exists. Pilot new mechanisms locally first.
- Do not write code comments by default; the why of a change belongs in the commit message. Comment only a constraint that a reader would otherwise wrongly "fix" and cannot recover from the code, commit history, or upstream docs.
- Write rules and conventions as general principles that cases can be derived from, not as lists of cases.
- Partition state, modules, and scopes by change reason, blast cost, and one-way dependency direction — not by provider boundary or residual categories such as infra / foundation.

### Makefile

Write file-generating recipes as real file targets with actual source files as prerequisites; do not use a `FORCE` target hack.
Declare `.PHONY` individually, directly above each target.
Create directories with `mkdir -p $(@D)` in the recipe.
Prefix recipe lines that expand secrets with `@` to suppress command echo.

---

## Writing

### Style

Use plain form (常体) by default; match polite form (敬体) when editing text written in it.

Define the starting point of business flows and use cases by the triggering demand or event, not by actor.
When actor differences matter, classify by demand certainty or information granularity.

### Formatting Rules

These apply to all Markdown you produce, including plan files, proposals, and PR bodies.

- Put a single half-width space between Japanese text and ASCII characters.
- Use `。` and `、` as punctuation marks, with no space after them.
- Do not end a sentence with a colon, including introductions for bullet lists.
- Do not use numbered lists or bold text as heading substitutes.
- Use semantic line breaks — break at sentence boundaries, not column width.
- Use bullet lists (`-`) only for independent, reorderable items; use numbered lists only when order matters, writing `1.` for every item. Do not mix the two at the same level. Indent nested lists with 2 spaces.
- Add a language tag to every code fence.
- Limit `**bold**` to genuinely important content.
- Mark notes with `Note:`, not `※` or `注:`.
- Mermaid node names use snake_case, without abbreviations, decorative colors, emoji, or bold labels.
- Use HTML tags only for functional requirements (e.g. collapsibles), not decoration.
- Do not assign mechanical labels or IDs to items (案 A, 論点 1, パターン X, P0); name items by their content.
- Write proper nouns in full with correct casing; do not coin abbreviations. Established industry abbreviations (ADR, SoR) are fine.
- Do not use enclosed characters such as circled numbers (①②③); use plain digits.
- Prefer natural Japanese over loanwords for concept words; keep English for product names, proper nouns, code identifiers, and reserved words.
