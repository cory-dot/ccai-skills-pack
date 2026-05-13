---
id: landing.hero
title: Landing page hero copy
category: sales
inputs_needed: [offer, audience, proof anchor, primary objection]
reads_voice: yes
deliverable: Headline + subhead + 3-bullet body + CTA + sub-CTA
estimated_time: 3-5 min
---

# Landing page hero copy

## When to use
You need above-the-fold copy for a landing page or sales page. The user is solution-aware or product-aware (they know what category they need). This prompt gives you the hero section only, not the full page.

## The prompt

```
You're a direct-response copywriter writing the hero section of a landing page for [OFFER].

Audience: [AUDIENCE_DESCRIPTION]. They are [AWARENESS_STAGE, solution-aware or product-aware].

The single strongest proof I can deploy: [PROOF_ANCHOR, specific number, testimonial, screenshot, credential].

The #1 objection the reader has before clicking the CTA: [PRIMARY_OBJECTION].

Voice + tone rules (from BRAND_VOICE.md if available, otherwise:
- Direct, not corporate
- No "transform," "revolutionary," "game-changing"
- No fake urgency
- One CTA only, no "click here OR email us OR follow on Twitter"

Write:
1. Headline (8-14 words, contrarian or specific-number preferred)
2. Subhead (1 sentence amplifying the headline with the offer specifics)
3. Three short body bullets that:
   - Address the proof anchor
   - Address the primary objection
   - Show the transformation/before-after
4. Primary CTA (one action, direct verb)
5. Sub-CTA line (one line of reassurance, what they don't have to commit to)

Make all numbers concrete. No abstract claims.
```

## Variables to fill
- `[OFFER]`, what's being sold + price (e.g. "Creative Core AI free Skool course")
- `[AUDIENCE_DESCRIPTION]`, one sentence with one pain or desire
- `[AWARENESS_STAGE]`, solution-aware OR product-aware
- `[PROOF_ANCHOR]`, strongest single piece of evidence (number, testimonial, etc.)
- `[PRIMARY_OBJECTION]`, the #1 reader objection

## Brand voice adaptation
If BRAND_VOICE.md exists:
- Adds taboos to the "no [X]" list
- Adjusts CTA phrasing to match user's normal CTA style
- Calibrates sentence length to user's cadence

## Common failure mode
Users provide a vague proof anchor ("years of experience"). Push for specific: "Years of experience" → "11 years building marketing systems for B2B SaaS, with 3 sub-$100K → $1M+ revenue case studies." Concrete proof anchors carry the whole hero section.

## Related prompts
- `headline.batch`, when you need 10 headline variants for A/B testing instead of one
- `offer.audit`, if the offer itself feels weak before writing copy
- `email.sales`, for sending traffic to the landing page

## Upgrade path
For the full landing page (not just hero), use `/ccai-sales-copy`. It runs the same diagnosis but produces the full page section by section with conversion checks.
