---
name: rfi-creator
description: "Use this skill whenever the user wants to create, draft, or improve a Request for Information (RFI) document. Triggers include: any mention of 'RFI', 'Request for Information', 'information request to vendors', '情報提供依頼書', 'ベンダー情報収集', or requests to explore what vendors or solutions exist in a market before issuing an RFP. Also use when the user wants to compare vendor capabilities at an exploratory stage, gather market intelligence, or create a shortlist of potential suppliers. This skill covers RFIs for any domain: IT systems, SaaS, consulting, construction procurement, marketing, and more. Do NOT use this skill for RFPs (detailed proposal requests with requirements and pricing) or RFQs (pricing-only requests) — use the rfp skill for RFPs instead. If the user is unsure whether they need an RFI or RFP, help them decide based on how well-defined their requirements are."
---

# RFI (Request for Information) Creator

This skill defines the workflow and structure for creating RFI documents. An RFI is a formal document used in the early stages of procurement to collect information about vendor capabilities, available solutions, and market landscape before committing to a detailed RFP.

## When to Use an RFI (vs. RFP)

An RFI is appropriate when the requirements are not yet fully defined and the organization needs to understand what solutions exist in the market. If requirements are already well-defined and the organization is ready to solicit detailed proposals with pricing, an RFP is more appropriate.

The key question is: "Do we know what we want, or are we still figuring out what's possible?" If the latter, use an RFI.

## Workflow

### Step 1: Understand the User's Situation

Gather the following from the user through conversation. Not all items will be known — that is expected at the RFI stage.

- What problem or need is driving this procurement?
- What is the business context? (industry, organization size, relevant constraints)
- How well-defined are the requirements? (if very well-defined, suggest an RFP instead)
- Are there known solution categories or vendors already in mind?
- What specific information does the user want to learn from vendors?
- What is the timeline? (RFI response deadline, expected next steps)
- Who is the intended audience? (broad market vs. pre-selected vendor list)

### Step 2: Draft the RFI

Refer to `references/rfi-sections.md` for the full section catalog. Select only the sections relevant to the user's situation — an RFI should be concise (typically 4–8 pages). Not every section in the reference is needed for every RFI.

Important principles for RFI drafting:

- Keep it short and focused. An RFI that is too long will reduce vendor response rates.
- Ask only what you genuinely need to know at this stage. Detailed specifications belong in a subsequent RFP.
- Structure questions so that responses are comparable across vendors. Provide a response format or template where appropriate.
- Make it clear that the RFI is non-binding and does not commit either party to a purchase.
- Do not request detailed pricing. The RFI may ask for general pricing models or cost structures, but specific quotes belong in an RFQ.

### Step 3: Output the Document

Create the RFI as Markdown (.md) by default. If the user requests .docx or .pdf output, use the corresponding skill (docx or pdf) to convert.

## Important Notes

- If the user's input is insufficient for a complete RFI, produce a draft with clearly marked `[TBD]` placeholders and explain what information is still needed.
- For Japanese-language RFIs, follow the same structure but adapt formatting conventions (e.g., use 御中 for addressing, appropriate keigo for formal documents).
- The section catalog in `references/rfi-sections.md` is a superset. Use judgment to include only relevant sections based on the user's context.
- If the user already has requirements detailed enough for an RFP, proactively suggest switching to the rfp skill instead.
