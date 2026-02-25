---
name: project-charter-creator
description: "Use this skill whenever the user wants to create, draft, or improve a Project Charter. Triggers include: any mention of 'project charter', 'charter', 'プロジェクト憲章', 'プロジェクトチャーター', 'プロジェクト企画書', or requests to formally authorize a project, define project scope and objectives, align stakeholders, or establish project governance. Also use when the user says 'プロジェクトの立ち上げ', 'プロジェクトの認可', 'キックオフ文書', or mentions needing to get sponsor approval for a project. This skill covers project charters for any methodology (Waterfall, Agile, Lean Six Sigma) and any domain (IT, construction, marketing, organizational change, product development, etc.). Use this skill even if the user just says 'help me start a project' or 'I need to get alignment on my project'."
---

# Project Charter

A skill for creating Project Charter documents — the foundational document that formally authorizes a project and provides the project manager with the authority to apply organizational resources.

## What This Skill Produces

A Markdown document that serves as the project's authoritative reference for scope, objectives, stakeholders, and governance. The charter is not a detailed project plan; it is a high-level agreement that establishes the project's existence, boundaries, and direction.

## When to Read Reference Files

Before drafting, read [references/charter-sections.md](references/charter-sections.md) for detailed guidance on each section's purpose, content, and common pitfalls.

## Workflow

### Step 1: Understand the Context

Gather essential information from the user before drafting. Ask about the following aspects as needed. Not all are required upfront; focus on what the user already knows.

- What problem or opportunity is this project addressing?
- What does success look like? Are there measurable criteria?
- Who is the project sponsor (the person with authority to approve)?
- What is in scope and, critically, what is out of scope?
- Are there known constraints (budget, timeline, regulations, dependencies)?
- What methodology will the project follow (Waterfall, Agile, hybrid)?
- What is the intended audience for this charter (executive sponsors, cross-functional team, PMO)?

If the user provides partial information, proceed with what is available and mark gaps with `[TBD]` placeholders.

### Step 2: Determine the Appropriate Level of Detail

The charter's granularity should match the project's context.

For large-scale or formal projects (enterprise system implementations, regulatory projects, construction), use the full section set from `references/charter-sections.md`. These projects typically require detailed scope boundaries, formal approval sections, and comprehensive risk/constraint documentation.

For medium-scale projects (departmental initiatives, product launches, process improvements), use the core sections and selectively include optional sections based on relevance.

For lightweight or agile projects (sprint-level initiatives, internal tooling, exploratory projects), produce a concise charter that fits on a single page. Focus on the "Why", "What", and "Who". Omit sections like detailed budget breakdowns or formal approval signatures unless the user explicitly requests them.

### Step 3: Draft the Charter

Produce the charter as a Markdown file (.md). If the user requests .docx or .pdf output, use the appropriate skill to convert after drafting in Markdown.

Refer to `references/charter-sections.md` for the content and structure of each section. The sections listed there form a superset — select only the sections relevant to the user's project.

When drafting, follow these principles.

Write for the charter's audience. If the audience is executive sponsors, emphasize business value and strategic alignment. If the audience is a cross-functional project team, emphasize scope clarity and role definitions.

Be specific rather than generic. Replace placeholder-style language with concrete details drawn from the user's input. A charter filled with vague statements like "improve customer satisfaction" provides no alignment value.

Define the negative space. The out-of-scope section is as important as the in-scope section. Explicitly stating what the project will NOT do prevents scope creep and sets clear expectations.

Keep it concise. A charter is not a project plan. Resist the urge to include detailed task breakdowns, Gantt charts, or implementation specifics. Those belong in subsequent planning documents.

### Step 4: Review and Iterate

Present the draft to the user and ask for feedback. Common areas for refinement include scope boundaries that are too broad or too narrow, missing stakeholders, success criteria that are not measurable, and risk items that the user had not considered.

## Important Notes

- Output format is Markdown by default. If the user requests .docx or .pdf, use the corresponding skill to convert.
- The section structure in `references/charter-sections.md` is a superset. Not every section is needed for every charter. Use judgment based on the project's scale and methodology.
- If the user's input is insufficient for a complete charter, produce a draft with `[TBD]` placeholders and explain what information is still needed.
- For Japanese-language charters, follow the same structure but use appropriate business Japanese conventions (敬体 for formal documents unless the user specifies otherwise).
- A project charter is distinct from a project plan. The charter answers "Why are we doing this?" and "What are we committing to?" while the project plan answers "How will we do it?"
