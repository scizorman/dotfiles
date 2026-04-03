# Comment Intents

Choose the comment template from the primary purpose of the message, not from the repository object type.
An issue and a pull request can both need the same intent.

## Work report

Use [templates/work-report.md](../templates/work-report.md) when reporting completed work at the end of a session or milestone.

Include:

- what was completed
- what was verified
- what remains or needs follow-up

Avoid:

- command output pasted without any explanation of what it shows — always add a brief interpretation
- file-by-file change logs that obscure the outcome
- omitting command output that is essential to understanding what was verified — abbreviate non-essential parts (progress bars, repeated boilerplate) but keep the meaningful lines

## Progress update

Use [templates/progress-update.md](../templates/progress-update.md) when work is in progress and collaborators need a concise status update.

Include:

- current status
- in-progress work
- blockers or risks
- next step

Avoid:

- pretending work is further along than it is
- vague blocker descriptions such as "still investigating"

## Investigation summary

Use [templates/investigation-summary.md](../templates/investigation-summary.md) when sharing findings from research, debugging, or analysis.

Include:

- the question investigated
- the conclusion
- the evidence that supports it
- unresolved points
- the recommended next action

Avoid:

- mixing observations and guesses without labeling them
- withholding uncertainty that materially affects the recommendation

## Design proposal

Use [templates/design-proposal.md](../templates/design-proposal.md) when proposing an implementation direction or recording an architectural decision.

Include:

- the background and constraints
- the proposed approach
- alternatives considered
- tradeoffs and impact
- the exact feedback or decision needed

Avoid:

- presenting one option as obvious when alternatives exist
- listing options without judging them

## PR supplement

Use [templates/pr-supplement.md](../templates/pr-supplement.md) when the pull request description is not enough and reviewers need extra context in the PR conversation.

Include:

- why the extra comment is needed
- review focus points
- verification status
- known limitations or follow-up work

Avoid:

- repeating the pull request body verbatim
- using a supplement comment when the PR body itself should be updated instead
