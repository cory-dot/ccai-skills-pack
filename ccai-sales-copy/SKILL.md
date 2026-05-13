---
name: ccai-sales-copy
description: "Writes direct-response sales copy, landing page hero, short ad copy (Meta/Google), email sales sequence, VSL outline, sales page section, or a batch of 10 headlines for split testing. Diagnoses the audience awareness stage first (Schwartz 5 levels), then picks the right framework (AIDA, PAS, BAB, FAB, OATH), or hybridizes them. Calibrated to brand voice. Use when the user asks for sales copy, ad copy, a landing page, an email sequence, headlines, or any copy whose explicit purpose is to convert."
when_to_use: "User mentions sales copy, ad copy, landing page, conversion, email sequence, sales page, headlines, VSL, hero section, offer copy, \"write a pitch,\" or asks \"what should I say to sell X.\""
argument-hint: "[asset type or topic]"
---

# CCAI Sales Copy

Direct-response copy that diagnoses audience awareness first, then applies the right framework. No bag-of-tricks templates.

## Output contract

Each sales asset is saved as its own file under `copy/` in the working directory:

```
copy/YYYY-MM-DD-NN-asset-type-slug.md
```

Examples:
- `copy/2026-05-12-01-landing-hero-skool-course.md`
- `copy/2026-05-12-02-email-launch-day-2.md`
- `copy/2026-05-12-03-headlines-meta-ad-test.md`

Each file is self-contained with frontmatter (asset type, framework used, awareness stage targeted, target audience, generated date).

## Inputs the skill reads (if present)

- `BRAND_VOICE.md`, voice calibration, taboos (e.g. "no hype language") absolutely respected
- `COMPETITOR_RADAR.md`, for "Avoid" verdicts on offer claims competitors overuse
- `CONTENT_IDEAS.md`, if copy is for an idea in the radar, pull the proof anchor

## The framework selection logic

Sales copy quality is dominated by **diagnosis**, not vocabulary. Before writing a single line, the skill asks 3 questions and selects the framework based on the answers.

### Step 1, Diagnose awareness stage (Schwartz's 5 levels)

| Stage | Reader state | Best framework |
|---|---|---|
| **Unaware** | Doesn't know they have the problem | OATH (Oblivious phase), surface the problem first |
| **Problem-aware** | Knows the problem, doesn't know solutions exist | AIDA, earn attention, build interest in the category |
| **Solution-aware** | Knows solutions exist, evaluating options | PAS or BAB, agitate the cost of *their current* solution; show the new "after" |
| **Product-aware** | Knows your product exists, weighing it vs alternatives | FAB, features → advantages → benefits, with proof |
| **Most-aware** | Ready to buy, just needs a reason now | Direct offer + scarcity/urgency + risk reversal |

Ask the user: *"Which best describes the reader of this copy? [give the 5 options in plain language]"*

### Step 2, Identify the asset type

Available asset types in this free version:
- **Landing page hero** (above-the-fold: headline + subhead + bullets + CTA)
- **Short ad copy** (Meta/Google: 90-character primary, 30-char headline, 30-char description, 3 variants)
- **Email** (one specific email, 250–500 words, single CTA)
- **VSL outline** (video sales letter, section-by-section outline, not full script)
- **Sales page section** (a single section of a long-form page, e.g. "About the offer," "FAQ," "Risk reversal")
- **Headlines batch** (10 headline variants for split testing, for ads, emails, or pages)

For VSL outline and full-page landing copy, this is intentionally limited to **outline + key sections**, the 21-step VSL and 11-panel landing page are pro-tier (`ccai-sales-copy-pro`).

### Step 3, Get the brief

Beyond awareness stage and asset type, ask:

1. **Offer**, what is being sold? Price? Format? (Course, service, product, free lead magnet, etc.)
2. **Audience**, one sentence describing them, ideally with one specific pain or desire
3. **Proof anchor**, the strongest piece of evidence the user can deploy (specific number, testimonial, screenshot, result, credential)
4. **Primary objection**, the #1 reason this reader doesn't buy yet
5. **One-line transformation**, what's their state BEFORE vs AFTER they buy/sign up?

## Process

### Step 1, Diagnose + confirm

Run the 3 questions above. Restate the diagnosis back to the user before writing:

> *"You're writing for a [solution-aware] reader, the asset is a [landing page hero], the offer is [X], the proof anchor is [Y], and the primary objection is [Z]. I'm going to use [PAS framework]. Confirm?"*

Wait for confirmation.

### Step 2, Generate the copy

Use the selected framework's structure. The framework definitions are in `templates/FRAMEWORKS.md`.

For headlines, generate 10, spread across at least 4 angles (curiosity, specific-result, contrarian, social-proof). Mark the top 3 picks and explain why.

### Step 3, Run the conversion check

Before finalizing, run these checks (similar in spirit to `ccai-video-script`'s de-AI passes):

**Check 1, Specificity audit**
Every claim must be either:
- Backed by a number, date, or named example
- Or labeled as a hypothesis ("could," "might," "in our experience"), never asserted

Generic claims ("life-changing," "powerful," "transformative") get rewritten or cut.

**Check 2, Objection coverage**
The primary objection from the brief must be explicitly addressed somewhere in the copy. If it isn't, insert a section. (Common objections: too expensive, no time, won't work for me, tried before and it failed.)

**Check 3, Proof placement**
The strongest proof anchor must appear within the first third of the asset (above the fold for landing pages, in the first 100 words for emails). Burying proof is the most common rookie error.

**Check 4, CTA singularity**
One CTA. Same CTA repeated at multiple visual moments is fine; multiple *different* CTAs is not. Pick the highest-intent action and ask only for that.

**Check 5, Voice + taboos**
Cross-reference BRAND_VOICE.md. Any taboo violations? Any vocabulary mismatches with the signature words list? Fix.

### Step 4, Save and summarize

Write to `copy/YYYY-MM-DD-NN-slug.md` with frontmatter. Summarize:

> *"Saved to copy/X. Framework used: [PAS]. Word count: [N]. Primary objection addressed: [Y]. Want me to write a variant with a different framework for A/B testing?"*

## Hard rules

- **No diagnosis = no writing.** If the user says "just write me sales copy," push back with the 3 diagnosis questions. Generic sales copy is bad sales copy.
- **No "transform your X" language.** The word "transform" is a vibe-killer in 2026 copy. Use specific verbs.
- **No fake urgency.** "Only 3 spots left" is dead unless it's literally true. If the user wants urgency and it's not real, refuse to write the line and suggest an honest alternative ("Doors close Friday", only if doors actually close).
- **No "hey friend" pseudo-intimacy openers** unless the user's BRAND_VOICE.md explicitly establishes this pattern.
- **Respect BRAND_VOICE.md taboos absolutely.** Bigger sin than weak copy.

## Reference files

- `templates/FRAMEWORKS.md`, the 5 frameworks (AIDA, PAS, BAB, FAB, OATH) with structures + when to use each
- `templates/SALES_ASSET.md`, output schema with frontmatter
- `examples/sample-landing-hero.md`, a filled-in landing page hero example
- `examples/sample-headlines-batch.md`, a filled-in batch of 10 headlines

## Anti-patterns to avoid

- Writing without diagnosing the awareness stage. 60% of bad sales copy is framework-stage mismatch.
- Putting the offer details before the problem agitation (for solution-aware audiences). Wrong order.
- Loading copy with adjectives instead of evidence. "Revolutionary" is a placeholder for "I didn't have proof to show."
- Multiple CTAs ("Click here OR email us OR fill out the form"). Choose one.
- Skipping objection coverage. The reader's silent "but..." is what kills conversion.
