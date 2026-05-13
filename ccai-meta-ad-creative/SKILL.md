---
name: ccai-meta-ad-creative
description: Generates Meta (Facebook/Instagram) ad creative from a product URL or product description — produces 5 distinct creative concepts each with primary text, headline, description, image direction, and audience targeting. Companion to ccai-meta-ads-autopilot (which does the full weekly batch). This skill is for one-off creative generation when you need a quick test concept. Free version: image direction only (you generate the image). Pro version: auto-generates images via Higgsfield MCP.
when_to_use: User mentions Meta ad creative, ad concepts, ad variants, creative testing, single ad copy, or asks for a quick ad concept without running the full weekly batch.
argument-hint: "[product URL or 1-paragraph product description]"
---

# CCAI Meta Ad Creative

5 distinct ad concepts from a product URL or description. Quick alternative to the full weekly batch.

## Output contract

Saves to `meta-ads/creative-YYYY-MM-DD-NN-slug.md`:
- 5 concept cards with full Meta spec (primary text, headline, description, image direction, audience)
- A recommendation for which to launch first

## When to use this vs ccai-meta-ads-autopilot

| Use this skill | Use ccai-meta-ads-autopilot |
|---|---|
| One-off creative test | Weekly creative refresh |
| New offer launch | Ongoing account management |
| Quick concept for a specific moment | Full 7-step weekly loop |
| You just need 5 ideas | Performance + competitor analysis baked in |

## Inputs

- Product URL OR 1-paragraph description
- Audience (1 sentence — primary persona)
- Offer + price
- Optional: BRAND_VOICE.md for voice match

## Process

### Step 1 — Extract or confirm the offer
- If URL: ask Claude Code to read the page (if accessible)
- Otherwise: ask user for offer, price, transformation, audience

### Step 2 — Pick 5 distinct angles
Each concept uses a different psychological pillar:
1. **Pain mirror** — name a specific pain the audience is feeling now
2. **Contrarian** — challenge an assumption they hold
3. **Social proof** — third-party validation
4. **Personal cost** — "this cost me $X, don't repeat"
5. **Curiosity gap** — promise + reveal

### Step 3 — Generate full Meta spec for each
- Primary text: ≤ 90 chars (visible-before-truncation)
- Headline: ≤ 30 chars
- Description: ≤ 30 chars
- Image direction: 2-3 sentences (what the visual should be)
- Audience: targeting parameters
- Recommended budget for first test

### Step 4 — Recommend launch order
- Best for cold audience: [N]
- Best for retargeting: [N]
- Highest-risk/highest-reward: [N]

## Hard rules

- **No fake urgency.** "Only 3 left" only if literally true.
- **Specificity over hype.** Real numbers in copy, not "amazing results."
- **Respect Meta character limits absolutely.** Truncated copy loses 30%+ CTR.
- **Image direction is descriptive, not poetic.** "Stark white background, product centered, single price callout in red" — not "evocative and dynamic."

## Reference files
- `templates/AD_CREATIVE.md` — 5-concept output schema
- `examples/sample-ad-creative.md` — filled example for a coaching offer
