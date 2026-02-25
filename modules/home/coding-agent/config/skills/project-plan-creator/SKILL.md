---
name: project-plan-creator
description: Creates project management plans in Markdown. Use when creating project plans, defining how to manage scope/schedule/risk/communication, or detailing project execution strategy. Primarily for internal projects that build systems, processes, or organizational capabilities.
---

# Project Plan Creator

This skill defines rules and procedures for creating project management plans.

A project management plan describes **how** the project will be executed, monitored, and controlled. It is distinct from a project charter, which defines **what** and **why**.

## Workflow

1. If a project charter exists in the repository or is provided by the user, read it first to understand the project context (scope, objectives, constraints, milestones).
2. Assess the project's nature and scale to determine which optional sections to include (see Tailoring).
3. Generate the plan using [templates/default.md](templates/default.md) as the base structure.
4. Write in Markdown and save to the location specified by the user, or to a reasonable default path.

## Tailoring

Not all sections are needed for every project. Select sections based on the project's characteristics.

### Required Sections

Always include these sections regardless of project scale.

- Project Overview
- Scope Management Plan
- Schedule Management Plan
- Organization and Roles
- Communication Management Plan
- Risk Management Plan

### Optional Sections

Include these when the project's context warrants them. The criteria below are guidelines, not rigid rules.

**Quality Management Plan** — Include when the project produces deliverables with explicit acceptance criteria, or when quality failures carry significant consequences.

**Cost Management Plan** — Include when the project has a dedicated budget, involves external procurement costs, or requires effort tracking beyond simple task assignment.

**Change Management Plan** — Include when the scope is likely to evolve, multiple stakeholders may request changes, or the project spans more than a few months.

**Procurement Management Plan** — Include when external vendors, tools, or services need to be selected and managed.

**Stakeholder Management Plan** — Include when the project involves multiple departments, competing interests, or stakeholders who are not directly involved but have influence over outcomes.

## Charter Reference

If a project charter exists:

- Extract the project's objectives, scope boundaries, constraints, and key milestones from the charter.
- Do not duplicate charter content. Reference it and build upon it.
- If the charter defines success criteria, align the plan's scope and schedule to those criteria.

If no charter exists, the Project Overview section should cover the essential context (background, objectives, scope) that a charter would normally provide.

## Language

Write plan content in Japanese by default.
If the user explicitly requests English, write in English.
