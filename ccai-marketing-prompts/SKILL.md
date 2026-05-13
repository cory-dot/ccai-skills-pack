---
name: ccai-marketing-prompts
description: "A curated, callable library of 35 marketing prompts for small business owners, copy-paste-ready prompts for captions, emails, ads, sales pages, customer research, and competitive analysis. Surface the right prompt for the user's task and adapt it to their BRAND_VOICE.md and current context, rather than handing over a flat document. Use when the user asks \"what's the best prompt for X,\" \"give me a prompt to do Y,\" or wants a starting point for a marketing task."
when_to_use: "User asks for a prompt, a prompt template, \"what should I ask Claude to write a [marketing asset],\" or wants help framing a marketing-related request. Also use when starting any new marketing task to suggest a good starter prompt."
argument-hint: "[task or category, e.g. 'caption', 'cold email', 'positioning']"
---

# CCAI Marketing Prompts

A callable library of battle-tested marketing prompts, indexed by task. Not a flat document, a search-and-adapt skill.

## Output behavior

This skill doesn't write files by default. It surfaces the right prompt for the user's task, adapts it to their BRAND_VOICE.md + context, and either:
- **Returns the adapted prompt to the user** (so they can use it themselves), OR
- **Runs the prompt inline and produces the deliverable** (if the user prefers)

Ask which mode the user wants on first invocation.

## Inputs the skill reads (if present)

- `BRAND_VOICE.md`, every adapted prompt is calibrated to the user's voice
- `COMPETITOR_RADAR.md`, competitive-analysis prompts pull from this
- `CONTENT_IDEAS.md`, idea-generation prompts add the user's existing ideas as context

## The library, 35 prompts across 7 categories

### Category 1: Content creation (8 prompts)
- `caption.short`, Instagram caption for a feed photo
- `caption.story`, Instagram story copy with a poll/swipe-up
- `caption.video`, caption for a reel/short post
- `linkedin.short`, short LinkedIn post (under 200 words)
- `linkedin.long`, long LinkedIn post (300-500 words)
- `thread.x`, Twitter/X thread starter
- `newsletter.subject`, newsletter subject line + pre-header batch
- `headline.batch`, 10 headlines for split-testing

### Category 2: Sales + offers (6 prompts)
- `landing.hero`, landing page hero copy
- `email.sales`, single sales email
- `email.sequence.welcome`, 3-email welcome sequence
- `offer.audit`, audit an existing offer for clarity/urgency/risk reversal
- `pricing.frame`, how to frame a price point in copy
- `vsl.outline`, 15-section VSL outline (free tier, full 21-step is pro)

### Category 3: Ads (5 prompts)
- `ad.meta.short`, Meta primary text + headline + description
- `ad.meta.variants`, 5 variants of a winning ad
- `ad.google.search`, Google Search ad copy
- `ad.angle.brainstorm`, 10 ad angles for one product
- `ad.fatigue.refresh`, refresh tired ad copy with new framing

### Category 4: Customer research (5 prompts)
- `interview.questions`, 12 customer-interview questions for a product
- `survey.questions`, 8 survey questions for a launch
- `review.mine`, extract themes from a batch of customer reviews
- `objection.list`, surface the top objections in your audience
- `voc.synthesize`, voice-of-customer synthesis from pasted data

### Category 5: Competitive analysis (4 prompts)
- `competitor.profile`, quick competitor profile (lighter than ccai-competitor-research)
- `differentiation.find`, find your differentiation from a competitor
- `pricing.compare`, compare your price-to-value vs alternatives
- `swot.fast`, 15-min SWOT for a positioning decision

### Category 6: Positioning + brand (4 prompts)
- `positioning.statement`, write a one-sentence positioning statement
- `niche.narrow`, narrow your audience to who you actually serve best
- `value.prop`, write a value proposition with proof scaffolding
- `bio.short`, 1-2 sentence bio for LinkedIn/IG

### Category 7: Workflow + meta (3 prompts)
- `audit.copy`, audit an existing piece of copy for weak spots
- `refresh.evergreen`, refresh a piece of evergreen content
- `repurpose.brief`, quick brief for repurposing across formats (handoff to ccai-content-repurpose)

## Process

### Step 1, Find the right prompt

When the user invokes the skill or asks for a prompt:

1. If they specify a task ("write me an Instagram caption"), match it to the closest prompt in the library
2. If they're vague, ask: *"What are you trying to accomplish? Pick one: content / sales / ads / research / competitive / positioning / workflow. Or describe the task in one sentence."*
3. If their request maps to a deeper skill (e.g. they ask for "a brand voice doc", that's `ccai-brand-voice`, not a prompt), redirect them.

### Step 2, Load the prompt

Read the prompt file from `prompts/<prompt-id>.md`. Each prompt file follows the format in `prompts/_TEMPLATE.md`.

### Step 3, Adapt to context

Before returning the prompt, fill in:
- **Brand voice variables**, pull from `BRAND_VOICE.md` if present (vocabulary, taboos, signoff style)
- **User-specific variables**, ask the user for any [BRACKETED] placeholders the prompt needs (audience, offer, etc.)
- **Cross-references**, if the prompt references `COMPETITOR_RADAR.md` or `CONTENT_IDEAS.md`, surface relevant entries

### Step 4, Decide: return or run

Ask: *"Want me to **return the adapted prompt** so you can save it and use later, or **run it now** and give you the output?"*

If returning: give them the prompt as a clean code block they can copy.
If running: execute the prompt in this session and produce the deliverable.

### Step 5, Track usage (optional)

If the user wants tracking, append usage to `prompt-usage.md`:

```
| Date | Prompt ID | Outcome | Notes |
```

Over time this builds a personal performance log of which prompts the user gets the most value from.

## Hard rules

- **Never invent prompts on the fly.** If the user's task doesn't fit one of the 35, say so and either (a) suggest the closest match with adaptation notes, or (b) redirect to a deeper skill (`ccai-sales-copy`, `ccai-video-script`, etc.).
- **Always adapt to BRAND_VOICE.md if it exists.** A generic prompt that violates voice taboos is worse than no prompt.
- **Don't dump the full library on the user.** Surface 1-3 relevant prompts, not 35.
- **If a prompt's job is "redirect to a deeper skill," redirect.** This skill is for quick starts, not for replacing the specialized skills.

## Reference files

- `prompts/_TEMPLATE.md`, the format every prompt file follows
- `prompts/_INDEX.md`, complete searchable index of all 35 prompts
- `prompts/caption.short.md`, one example showing the format
- `prompts/landing.hero.md`, another example
- `examples/sample-session.md`, a transcript of how the skill works in practice

## Anti-patterns to avoid

- Returning all 35 prompts at once. The whole point is curation.
- Adapting "lightly" by just adding [INSERT YOUR BUSINESS HERE] placeholders. Real adaptation pulls from BRAND_VOICE.md and rewrites accordingly.
- Replacing the deeper skills. If the user wants a full sales page, point them at `ccai-sales-copy`. This skill is for one-shot prompts and quick starts.
