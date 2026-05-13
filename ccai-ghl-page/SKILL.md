---
name: ccai-ghl-page
description: Builds landing pages for GoHighLevel (GHL) — the agency-favorite CRM+page-builder platform. Generates the page copy + section structure + form spec ready to paste into GHL's drag-and-drop editor, calibrated to BRAND_VOICE.md. Use when the user is on GoHighLevel (white-labeled or main brand) and needs structured page content for their funnels.
when_to_use: User mentions GoHighLevel, GHL, HighLevel, sub-account, funnel builder (GHL context), white-label CRM, or asks for landing pages they'll paste into GHL.
argument-hint: "[funnel goal — lead-gen / sale / appointment]"
---

# CCAI GHL Page

GoHighLevel-specific landing page generator. Output formatted to paste directly into GHL's editor.

## Why this exists separately from ccai-landing-page

`ccai-landing-page` generates Next.js code. That doesn't help if your funnel lives in GoHighLevel — you can't paste React into GHL's drag-and-drop builder.

This skill produces what GHL editors actually accept: section-by-section copy, image specs, form field lists, and the structural plan that maps to GHL's "rows + columns + blocks" model.

## Output contract

Saves to `ghl-pages/YYYY-MM-DD-funnel-slug.md`:
- Section-by-section copy with GHL block-type labels (Headline / Text / Button / Form / Video / etc.)
- Form field list with GHL custom field name suggestions
- Image specs per section
- Suggested workflow trigger after form submission (for the GHL automation builder)

## Inputs

- Funnel goal: lead-gen / direct sale / appointment booking / cold lead nurture
- Offer + price
- Audience + primary objection
- Where the form should route to (Smart Lists, contact tags, workflow trigger name)
- BRAND_VOICE.md (strongly recommended)

## Process

### Step 1 — Choose funnel type
GHL funnels vary structurally:
- **Lead-gen:** 1-page opt-in + thank you page (2 pages)
- **Webinar / appointment:** opt-in + booking page + confirmation (3 pages)
- **Product sale:** sales page + order form + upsell (optional) + thank you (3-4 pages)
- **Cold lead nurture:** long-form sales letter + footer-only CTA

### Step 2 — Diagnose audience awareness
Same Schwartz framework as `ccai-sales-copy` — drives the copy depth per section.

### Step 3 — Generate the section-by-section spec
For each section, output:

```
### Section N — [section name]
**GHL block type:** [Headline / Text / Image / Button / Form / Video / Spacer / Column-row]

**Copy:**
"[exact text to paste]"

**Settings:**
- Headline tag: H1 / H2 / H3
- Alignment: left / center
- Background: [color or image]
- Padding: [tight / normal / loose]
```

### Step 4 — Form specification
For the opt-in or order form:
- Each field: type, label, placeholder, required/optional
- GHL custom field name suggestions
- Tag(s) to apply on submission
- Workflow trigger name to fire

### Step 5 — Workflow stub
A 1-paragraph description of what the post-submit workflow should do — user builds this in GHL's automation builder. The skill doesn't auto-create workflows (no GHL API in free version).

## Hard rules

- **GHL-native copy only.** No HTML, no React, no markdown formatting that GHL's editor will strip.
- **Section labels match GHL terminology.** Calling something a "section" when GHL calls it a "row" creates confusion.
- **No fake urgency.** Even more important on GHL pages where the platform encourages "Only 3 spots left" countdown timers.
- **Respect BRAND_VOICE.md.** GHL templates default to high-energy, which violates most CCAI client brand voices.

## Pro version differences

`ccai-ghl-page-pro` (planned):
- GHL API integration to auto-build the funnel pages
- Workflow JSON generation (paste into GHL's automation import)
- Custom field auto-creation
- Snapshot for multi-tenant agency deployment

## Reference files
- `templates/GHL_FUNNEL.md` — schema for funnel output
- `examples/sample-ghl-funnel.md` — filled example for a coaching opt-in funnel
