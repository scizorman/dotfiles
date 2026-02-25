---
name: rfp-creator
description: "Use this skill whenever the user wants to create, draft, or improve a Request for Proposal (RFP) document. Triggers include: any mention of 'RFP', 'Request for Proposal', 'proposal request', 'vendor selection document', 'procurement document', or requests to create documents for soliciting bids from vendors/suppliers. Also use when the user mentions '提案依頼書' (Japanese RFP), 'ベンダー選定', or similar procurement-related document creation in any language. This skill covers RFPs for any domain: IT systems, construction, marketing, consulting, software development, MDM, ERP, and more. Use this skill even if the user just says 'help me write an RFP' or 'I need to compare vendors for a project'. Do NOT use for RFP *responses* (vendor-side proposal writing) or general report/memo creation."
---

# RFP (Request for Proposal) Creator

## Overview

This skill guides the creation of professional, comprehensive RFP documents that enable vendors to produce accurate estimates and proposals. A well-crafted RFP is the foundation of successful vendor selection — incomplete or ambiguous RFPs lead to poor proposals, mismatched expectations, and project failure.

## Core Principle

**An RFP must contain enough information for a vendor to produce a credible estimate.** Every section should be written with this goal in mind. If a vendor cannot estimate cost, timeline, or effort from the RFP alone, the document is incomplete.

## Workflow

### Step 1: Understand the User's Context

Before writing anything, gather the following from the user through conversation. Do not assume — ask.

**Mandatory context (the RFP cannot be written without these):**

- What is being procured? (system, service, product, construction, consulting, etc.)
- What is the business problem or objective?
- Who is the target audience for this RFP? (type of vendor, industry, geography)
- What is the approximate budget range? (even a rough range helps vendors propose appropriate solutions)
- What is the desired timeline? (both for RFP process and for project delivery)

**Highly recommended context (the RFP will be significantly better with these):**

- Current state / as-is situation (existing systems, processes, pain points)
- Volume and scale information (users, transactions, data volumes, locations)
- Integration requirements (what existing systems must the solution connect to)
- Organizational constraints (regulatory, security, technology stack preferences)

### Step 2: Determine the RFP Type and Tailor the Structure

Read `references/rfp-sections.md` for the detailed section-by-section guidance. The core sections are universal, but emphasis varies by domain.

For **IT / System** RFPs, emphasize: functional requirements, non-functional requirements (performance, availability, security), integration architecture, data migration volumes, and licensing model.

For **Service / Consulting** RFPs, emphasize: scope of work, deliverables, team composition requirements, methodology, and success criteria.

For **Construction / Physical** RFPs, emphasize: specifications, site details, materials, regulatory compliance, insurance/bonds, and safety standards.

For **Product / Procurement** RFPs, emphasize: specifications, quantities, delivery schedule, quality standards, and warranty terms.

### Step 3: Draft the RFP

Use the docx skill (`/mnt/skills/public/docx/SKILL.md`) to produce a professional Word document. RFPs should be delivered as .docx files because:
- They are the industry standard for procurement documents
- Vendors need to be able to reference specific sections
- Internal stakeholders need to review and comment using tracked changes

**Document formatting guidelines:**
- Include a cover page with project name, issuing organization, date, and confidentiality notice
- Include a table of contents
- Use numbered sections (1, 1.1, 1.1.1) for precise cross-referencing
- Use tables for structured data (requirements matrices, evaluation criteria, timeline milestones)
- Keep the language clear, unambiguous, and free of jargon unless the audience is domain-specific

### Step 4: Review Checklist

Before finalizing, verify the RFP against this checklist:

**Estimability check — Can a vendor produce an estimate from this document?**
- [ ] Scope is clearly bounded (what is in scope AND what is out of scope)
- [ ] Volume/scale information is provided (or placeholders are clearly marked as TBD)
- [ ] Timeline expectations are stated
- [ ] Budget range or constraints are communicated
- [ ] Evaluation criteria and weightings are disclosed
- [ ] Required proposal format/structure is specified

**Completeness check — Are all necessary sections present?**
- [ ] Company/project background provides sufficient context
- [ ] Requirements are stated as testable, unambiguous statements
- [ ] Non-functional requirements are included (for system/IT RFPs)
- [ ] Proposal submission process and timeline are clear
- [ ] Contact information for questions is provided
- [ ] Legal/contractual terms or references are included

**Clarity check — Will the vendor understand what you need?**
- [ ] No compound requirements (one requirement per statement)
- [ ] No undefined acronyms or internal jargon
- [ ] Assumptions are explicitly stated
- [ ] Diagrams or visuals are included where they add clarity

## Section Reference

For detailed guidance on each RFP section, including what to include, common mistakes, and examples, read: `references/rfp-sections.md`

## Important Notes

- Always produce the RFP as a .docx file using the docx skill
- If the user provides reference materials (existing documents, specifications, etc.), incorporate them into the appropriate sections
- If the user's input is insufficient for a complete RFP, produce a draft with clearly marked `[TBD]` placeholders and explain what information is still needed
- For Japanese-language RFPs, follow the same structure but adapt formatting conventions (e.g., use 「」 for emphasis, 御中 for addressing, and appropriate keigo)
- The RFP structure in `references/rfp-sections.md` is a superset — not every section is needed for every RFP. Use judgment to include only relevant sections.
