# Project Charter — Section Reference

This document describes each section that may appear in a project charter. These sections form a superset; not every charter needs every section. Select sections based on the project's scale, methodology, and organizational requirements.

Sections are divided into **Core** (almost always included) and **Optional** (include when relevant).

---

## Core Sections

### 1. Project Overview

A brief identification block at the top of the charter.

What to include:

- Project name — should convey the project's purpose at a glance. Avoid generic names like "System Improvement Project"; prefer specific names like "Customer Portal Migration to Cloud-Native Architecture"
- Date of creation and version number
- Project sponsor — the individual or group with authority to approve the project and allocate resources
- Project manager — the individual accountable for day-to-day execution
- Organization / department

Why it matters: This block establishes who owns the project and who is accountable. Without it, authority is ambiguous and decisions stall.

### 2. Background and Business Case

Explains why this project exists and what business need or opportunity it addresses.

What to include:

- The business problem, market opportunity, or organizational need that triggered the project
- Current state — what is happening today that is unsatisfactory or insufficient
- Strategic alignment — how this project connects to the organization's goals or strategy
- Impact of inaction — what happens if the project is not undertaken

Why it matters: This section is the project's justification. It answers the question "Why should we invest resources in this?" If this section is weak, the project will struggle to maintain support when competing priorities arise.

Common pitfall: Writing a vague problem statement like "We need to modernize our systems." A strong statement identifies the specific pain point: "The current order management system has a 12% error rate in invoice generation, resulting in an estimated $2M annual revenue leakage and increasing customer churn."

### 3. Objectives and Success Criteria

Defines what the project aims to achieve and how achievement will be measured.

What to include:

- Measurable objectives — use the SMART framework (Specific, Measurable, Achievable, Relevant, Time-bound) as a guide, but do not force every objective into a rigid SMART format if it becomes artificial
- Success criteria — the conditions under which the project is considered complete and successful
- Key Performance Indicators (KPIs) — specific metrics that will be tracked

Why it matters: Without measurable objectives, "success" becomes subjective and debatable. Clear criteria prevent the situation where a project is technically complete but no one agrees it achieved its goals.

Example of weak vs. strong objectives:

- Weak: "Improve customer satisfaction"
- Strong: "Reduce average customer support ticket resolution time from 48 hours to 12 hours within 6 months of launch"

### 4. Scope

Defines what the project will and will not deliver.

What to include:

- In-scope — the work, deliverables, features, and capabilities the project will produce
- Out-of-scope — explicit list of items that are NOT part of this project, even if stakeholders might reasonably assume they are
- Scope change process — how changes to scope will be evaluated and approved (optional for lightweight charters)

Why it matters: Scope definition is the primary defense against scope creep. The out-of-scope section is often more important than the in-scope section, because it sets explicit boundaries and prevents "I assumed that was included" conversations later.

Example of effective out-of-scope statement:

"This project covers the migration of the web application to the new platform. Mobile application migration, third-party API integrations with partners, and historical data migration beyond 24 months are explicitly out of scope and will be addressed in separate initiatives."

### 5. Key Deliverables

Lists the tangible outputs the project will produce.

What to include:

- Each major deliverable with a brief description
- Acceptance criteria for each deliverable (who approves it and what "done" means)

Why it matters: Deliverables make abstract objectives concrete. They give the team something specific to build toward and give stakeholders something specific to evaluate.

### 6. Stakeholders and Roles

Identifies everyone who has a stake in the project and defines accountability.

What to include:

- Stakeholder list with name, role/title, and their relationship to the project
- Role definitions — who decides, who executes, who is consulted, who is informed (RACI or similar)
- Escalation path — who to go to when decisions cannot be made at the project level

Why it matters: Unclear roles lead to duplicated effort, missed responsibilities, and conflicts. The escalation path is particularly important for cross-functional projects where multiple departments have competing priorities.

### 7. Risks, Constraints, and Assumptions

Documents known uncertainties and limitations.

What to include:

- Risks — events that may occur and would negatively impact the project. Include likelihood and impact assessment if the project warrants it
- Constraints — fixed boundaries the project must operate within (budget ceiling, regulatory deadline, technology stack requirements, resource availability)
- Assumptions — things believed to be true for planning purposes but not yet confirmed. Assumptions that prove false often become risks

Why it matters: This section forces the team to acknowledge uncertainty upfront rather than being surprised later. It also creates a record that can be reviewed when circumstances change.

Common pitfall: Listing generic risks like "The project may be delayed." Effective risk identification is specific: "If the vendor's API does not support batch processing (currently unconfirmed), the data migration timeline will extend by approximately 4 weeks."

---

## Optional Sections

### 8. High-Level Schedule and Milestones

Provides a timeline overview with key checkpoints.

What to include:

- Project start and target end dates
- Major milestones with target dates
- Key dependencies between milestones or external events
- Phase gates or review points (if applicable)

When to include: For any project longer than a few weeks or where multiple teams need to coordinate timing. Omit for lightweight or exploratory projects where the timeline is inherently flexible.

Note: This is NOT a detailed project schedule. It should fit in a simple table or short list. Detailed scheduling belongs in the project plan.

### 9. Budget and Resources

Estimates the financial and human resources required.

What to include:

- Estimated budget range (not a detailed cost breakdown)
- Funding source
- Key resource requirements (headcount, specialized skills, tools, infrastructure)
- Contingency reserve, if applicable

When to include: When the project requires formal budget approval or when resource allocation decisions need to be made. For projects using existing team capacity with no incremental cost, this section may be unnecessary.

### 10. Approach and Methodology

Describes how the project will be executed at a high level.

What to include:

- Development methodology (Waterfall, Agile/Scrum, Kanban, hybrid, Lean Six Sigma DMAIC, etc.)
- Key process decisions (e.g., "Two-week sprints with demo at end of each sprint", "Gate reviews at end of each phase")
- Quality assurance approach (testing strategy, review cadence)
- Communication cadence (status reporting frequency, stakeholder review meetings)

When to include: When the methodology choice has implications for how stakeholders interact with the project (e.g., an Agile project where stakeholders need to participate in sprint reviews) or when the organization does not have a default methodology.

### 11. Dependencies and Interfaces

Documents external factors the project depends on.

What to include:

- Other projects or initiatives this project depends on or is depended upon by
- External vendor or partner dependencies
- Regulatory or compliance dependencies
- Technical infrastructure dependencies

When to include: For projects that operate within a larger program or portfolio, or when external dependencies pose significant risk.

### 12. Approval and Authorization

Formalizes the project's authorization.

What to include:

- Approval authority (who signs off)
- Approval date
- Signature lines or equivalent authorization record

When to include: For organizations that require formal project authorization before resources can be allocated. In less formal environments, verbal or email approval from the sponsor may suffice, and this section can be simplified or omitted.

---

## Section Selection Guide

The following table suggests which sections to include based on project scale.

| Section | Large / Formal | Medium | Lightweight / Agile |
|---|---|---|---|
| Project Overview | Yes | Yes | Yes |
| Background and Business Case | Yes | Yes | Yes (brief) |
| Objectives and Success Criteria | Yes | Yes | Yes |
| Scope | Yes | Yes | Yes (brief) |
| Key Deliverables | Yes | Yes | Optional |
| Stakeholders and Roles | Yes | Yes | Yes (brief) |
| Risks, Constraints, Assumptions | Yes | Yes | Optional |
| Schedule and Milestones | Yes | Yes | Optional |
| Budget and Resources | Yes | If applicable | Rarely |
| Approach and Methodology | Yes | If applicable | Rarely |
| Dependencies and Interfaces | Yes | If applicable | Rarely |
| Approval and Authorization | Yes | If applicable | Rarely |
