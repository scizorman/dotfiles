@~/.claude/AGENTS.md

# Claude Code Guidelines

## Model Cost Allocation (Subagent Delegation)

When the main session runs a high-cost model (Fable / Opus), allocate work as follows.

- Delegate small fixes, test writing, and mechanical changes to a general-purpose agent with model `sonnet`; keep cross-cutting changes, delicate refactoring, and root-cause-unknown debugging in the main session.
- Run MCP calls with large outputs in a read-only subagent with model `sonnet` and return only summaries or extracts; do not stream raw data into the main context.
