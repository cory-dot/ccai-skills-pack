---
name: ccai-landing-page
description: "Generates a complete production-grade landing page, hero, social proof, problem agitation, offer, FAQ, risk reversal, CTA, using your `ccai-website-builder-setup` project as the base. Reads BRAND_VOICE.md and STYLE_GUIDE.md so output is on-brand without re-prompting. Use after the Next.js scaffold is in place and you have a specific offer to build a page for."
when_to_use: "User mentions building a landing page, sales page, offer page, lead-capture page, or has scaffolded a website via ccai-website-builder-setup and wants to build out a specific page now."
argument-hint: "[offer name or product]"
---

# CCAI Landing Page

Production-grade landing page generator. Assumes `ccai-website-builder-setup` ran first.

## Output contract

Writes the landing page directly into the user's Next.js project:
- `app/<slug>/page.tsx`, full page composed of section components
- `components/sections/<page-slug>/Hero.tsx`, `SocialProof.tsx`, `Problem.tsx`, `Offer.tsx`, `FAQ.tsx`, `Risk.tsx`, `FinalCTA.tsx`, one file per section
- Mobile-responsive Tailwind, Framer Motion for entry animations
- Form wiring stubbed for Formspree / Resend / Cal.com inline embed (user fills in env vars)

## Prerequisites

- `ccai-website-builder-setup` already run (project exists at working dir or sub-dir)
- `BRAND_VOICE.md` exists in the project root
- `STYLE_GUIDE.md` exists (auto-created by website-builder-setup)

If any missing, the skill stops and tells the user what to run first.

## The 7-panel landing page structure

This skill generates exactly 7 sections in this order:

1. **Hero**, headline (8-14 words), subhead (1 sentence), primary CTA, sub-CTA reassurance, 1 hero visual placeholder
2. **Social proof**, logo bar OR testimonial strip (user provides)
3. **Problem agitation**, name the pain in their language, 3 specific examples
4. **Offer**, what they get, with specifics: deliverables, format, timeline, price
5. **FAQ**, 5-7 objection-handling Q&As (skill identifies the likely objections)
6. **Risk reversal**, guarantee / refund policy / free trial, whatever makes the buy feel safe
7. **Final CTA**, same primary CTA from hero, plus an alternate path (book a call vs. buy now)

This 7-panel structure isn't decorative, it maps to the buyer's mental flow: *attention → trust → pain → solution → answer my objections → reduce my risk → take action.*

## Process

### Step 1, Diagnose
Ask the same 3 questions as `ccai-sales-copy`:
1. **Awareness stage** (Schwartz 5): unaware / problem-aware / solution-aware / product-aware / most-aware
2. **Asset type:** confirm landing page (vs. sales section / hero only)
3. **Brief:** offer + price, audience (1 sentence with pain), proof anchor, primary objection, transformation (before → after)

If the user can't answer the brief specifically, push back. The full 7-panel page cannot be generated from vague input.

### Step 2, Plan
Restate the diagnosis. Pick the framework (defer to `ccai-sales-copy`'s framework logic, AIDA, PAS, BAB, FAB, OATH or hybrid).

Walk through the 7 panels. Each panel: what it'll contain, what framework moves it uses, what proof anchor it deploys.

Approval gate before generation.

### Step 3, Generate the section components
For each of the 7 sections, write a React component:
- Tailwind classes that match `STYLE_GUIDE.md`
- Framer Motion entry animation (subtle, viewport-triggered)
- Mobile-first responsive
- All copy reading from `BRAND_VOICE.md` (respect taboos)
- Image placeholders with descriptive alt text + `<Image>` next/image components

### Step 4, Compose into the page route
- Create `app/<slug>/page.tsx`
- Import all 7 sections
- Add SEO frontmatter / `<Head>` metadata

### Step 5, Wire forms (if applicable)
- Lead capture form: Formspree stub OR Resend stub
- Booking: Cal.com inline embed component
- Env var placeholders in `.env.local.template`

### Step 6, Verify build
Run `npm run dev`, confirm page loads at `localhost:3000/<slug>`, screenshot the result via Claude Code's preview if available.

### Step 7, Handoff
Summary: file paths, env vars to fill in, suggested image sources for each placeholder.

## Hard rules

- **Never modify global config** (tailwind.config.ts, next.config.js) without explicit confirmation.
- **Never auto-deploy.** `vercel` is the user's call.
- **Respect BRAND_VOICE.md taboos in every section.** Especially the FAQ section, where the temptation to soften with adjectives is highest.
- **One primary CTA per page.** The "alternate path" in section 7 is allowed (book a call vs. buy) but the page has one mission.
- **No fake urgency, no fake scarcity.** Real countdowns / real spot limits only.

## Pro version differences

`ccai-landing-page-pro` (planned):
- A/B test variant generation (3 hero versions, 3 CTA versions, automatic split)
- Conversion tracking integration (PostHog, GA4, Plausible auto-wired)
- Image generation via Higgsfield for hero visuals
- One-click Vercel deploy

## Reference files
- `templates/PAGE_BRIEF.md`, diagnosis questionnaire
- `examples/sample-landing-page-plan.md`, example showing all 7 panels planned for a real offer
