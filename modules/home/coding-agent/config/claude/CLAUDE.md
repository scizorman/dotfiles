@~/.claude/AGENTS.md

# Claude Code Guidelines

## Model Cost Allocation (Subagent Delegation)

When the main session runs a high-cost model (Fable / Opus), control token consumption as follows.

- The main session handles design, task decomposition, auditing, and review.
- Delegate small fixes, test writing, and mechanical changes to a general-purpose agent with model `sonnet`.
  Keep large or difficult implementation (cross-cutting changes, delicate refactoring, root-cause-unknown debugging) in the main session.
- Run MCP calls with large outputs (file content fetches, bulk search results) in a read-only subagent with model `sonnet`, and return only summaries or extracts.
  Do not stream raw data into the main context.
- Offload broad read-only exploration (codebase investigation) to the built-in Explore agent.
- Pass self-contained prompts when delegating: target file paths, conventions to follow, completion criteria, and verification commands.
- Dispatch subagents asynchronously and keep working in the main session instead of blocking on them.
- For long-running tasks, have an independent subagent with fresh context periodically verify the work against the spec, instead of self-critique.
- Review and verify subagent outputs in the main session before treating the work as complete.
