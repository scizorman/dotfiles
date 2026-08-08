# Global Guidelines

## Language

Always communicate in Japanese.
Technical terms may be used in English.

## Response Attitude

- Verify shell / make / tool behavior with a minimal reproduction before asserting it; do not extrapolate from version or distribution knowledge.
- Evaluate artifacts against best practices and their own requirements, not by consistency with sibling files.
- When a team decision is still open, present options side by side with comparison material (flow, benefits, issues), analyzing every option — including the user's favored one — at the same depth; add a recommendation only when asked or when direction is already agreed.
- Check quantitative claims and citations from subagents or web research against the primary source before relying on them; sources get misattributed.

## Workflow

### Command Execution

When a project has a Makefile, read it first and run lint, fmt, test, and similar commands through make (`make -C <directory>` from outside the working directory).

Use shell + standard UNIX tooling (jq / awk / sed / xargs) for scripting, not Python or Node — including from subagents.

Run one-off CLI tools through mise (`mise exec <tool> -- ...`), not npx or `nix run`.

Resolve relative dates ("today" / "yesterday") to absolute JST dates before recording them.

Never run state-changing operations against production environments (including DCL such as GRANT) without explicit confirmation; investigate via read-only means.

### Scope

Change only what was requested; do not touch items deferred as "decide after verification", and do not revert edits the user made by hand.
Adjust incidental values (timeouts, quotas, defaults) only with measured evidence, never "just in case".

### MCP

Use MCP only for exploring a few files and triage.
For bulk or mechanical data retrieval, use official CLIs or direct API calls — MCP output passes through the model and consumes tokens heavily.

### Git

Use kebab-case for branch names.
Write commit messages in Conventional Commits format.
Fix mistakes with a new commit; history rewrites (amend / force-push / rebase) only when explicitly asked, and never offered as an option.
Do PR work in a dedicated worktree at `~/ghq/.worktrees/github.com/<owner>/<repo>/<branch>`, not in the main working tree.
Keep user-local paths and private instructions (`~/.claude/*`) out of committed files and repo-facing artifacts; restate the rationale inline instead.

## Development

Develop with TDD: explore → red → green → refactor.

### Code Design

- Define the contract layer (APIs and types) strictly; keep the implementation layer regenerable.
- Encode statically checkable rules in the environment's linter or ast-grep, not in prompts.
- Do not abstract, split, or automate preemptively; extract shared config, split files, or add CI/CD only after duplication or real friction exists.
- Leave the code and config you write uncommented except for why-nots: why a seemingly natural alternative would break, in about a line plus a reference. A comment that describes what the code does, or why the change was made, is not a why-not.
- Write conditionals that state the exact condition being checked (`is None`, `len(x) == 0`), not truthy / falsy shortcuts.
- Write rules and conventions as general principles that cases can be derived from, not as lists of cases.
- Partition state, modules, and scopes by change reason, blast cost, and one-way dependency direction — not by provider boundary or residual categories such as infra / foundation.

### Makefile

Write file-generating recipes as real file targets with actual source files as prerequisites; do not use a `FORCE` target hack.
Declare `.PHONY` individually, directly above each target.
Create directories with `mkdir -p $(@D)` in the recipe.
Prefix recipe lines that expand secrets with `@` to suppress command echo.

## Writing

### Style

Use plain form (常体) by default; match polite form (敬体) when editing text written in it.

Name new categories and concepts with industry-general vocabulary; when a repo-internal definition conflicts with common usage, surface the conflict instead of following the internal definition.

Avoid dash-insertion asides and hedging preambles.
Define a technical term in plain language once at first use, then keep using the plain wording instead of repeating the term.

### Formatting Rules

These apply to all Markdown you produce, including plan files, proposals, and PR bodies.

- Put a single half-width space between Japanese text and ASCII characters.
- Use `。` and `、` as punctuation marks.
- Do not end a sentence with a colon, including introductions for bullet lists.
- Do not use numbered lists or bold text as heading substitutes; limit `**bold**` to genuinely important content.
- Use semantic line breaks — break at sentence boundaries, not column width.
- Use bullet lists (`-`) only for independent, reorderable items; use numbered lists only when order matters, writing `1.` for every item. Do not mix the two at the same level.
- Mark notes with `Note:`, not `※` or `注:`.
- Mermaid node names use snake_case, without abbreviations, decorative colors, emoji, or bold labels.
- Use HTML tags only for functional requirements (e.g. collapsibles), not decoration.
- Do not assign mechanical labels or IDs to items (案 A, 論点 1, パターン X, P0); name items by their content.
- Do not coin abbreviations for proper nouns, and do not use enclosed characters such as circled numbers (①②③).
- Prefer natural Japanese over loanwords for concept words; keep English for product names, proper nouns, code identifiers, and reserved words.
