---
name: ccai-ugc-video-ads
description: Generates UGC-style video ads from a product photo or brief — produces 5 distinct UGC concepts each with a scripted creator voiceover, on-screen text plan, and shot list. Free version outputs the spec (you film or use your video tool of choice). Pro version (planned) auto-generates videos via Higgsfield MCP. Use when the user needs Meta/TikTok ad video creative in the UGC format and wants structured concepts instead of generic scripts.
when_to_use: User mentions UGC video ads, user-generated content style ads, talking-head ad scripts, TikTok-style ads for Meta, creator-style ad spec, Higgsfield, or asks for video ad concepts beyond static creative.
argument-hint: "[product URL or product description]"
---

# CCAI UGC Video Ads

5 UGC-style video ad concepts from a product URL or brief. Free version outputs the spec; pro auto-generates via Higgsfield.

## Output contract

Saves to `meta-ads/ugc/YYYY-MM-DD-NN-product-slug.md`:
- 5 UGC concept cards with: hook, voiceover script, on-screen text plan, shot list, recommended creator persona, suggested length, audio direction

## When this skill makes sense

UGC video ads work because they feel like real customer content, not branded content. They consistently beat polished branded creative for Meta and TikTok at small-business scale.

But producing them is hard: finding creators, briefing them, getting good footage. This skill structures the *brief* so when you do hire a creator (or generate via Higgsfield), the output is on-target the first time.

## Inputs

- Product URL OR 1-paragraph description
- Audience (1 sentence)
- Offer + price
- Optional: target platform (Meta / TikTok / both — affects length + tone)
- Optional: BRAND_VOICE.md for voice match in voiceovers

## The 5 UGC concept structure

Each concept uses a different UGC archetype:

### 1. Discovery confession
*"OK guys you have to see this. I've been using this for 2 weeks and..."*
- Persona: enthusiastic 25-35yo discovering a tool/product
- Length: 15-30 sec
- Energy: high but not performative

### 2. Problem-fixed reaction
*"I literally cried when I figured this out — I've been struggling with X for years..."*
- Persona: 30-45yo who solved a specific painful problem
- Length: 30-45 sec
- Energy: emotional, vulnerable

### 3. Honest comparison
*"I tested all 4 of these so you don't have to. Here's the one that actually works."*
- Persona: 30-50yo "savvy researcher" persona
- Length: 30-60 sec
- Energy: confident, measured

### 4. Insider tip / hack
*"My friend in [industry] told me about this and I had to share..."*
- Persona: any age, "in-the-know friend" archetype
- Length: 15-30 sec
- Energy: conspiratorial, friendly

### 5. Before/after transformation
Visual-first concept: split screen or sequential transformation.
- Persona: depends on transformation (fitness/business/aesthetic/skill)
- Length: 15-45 sec
- Energy: dependent

## Process

### Step 1 — Brief
- Product / offer / price
- Audience
- Platform (Meta / TikTok)
- Voice notes if BRAND_VOICE.md present

### Step 2 — Generate 5 concepts (one per UGC archetype)
For each:

```
**Concept N — [archetype name]**

**Hook (first 3 seconds — said by creator):**
"[exact dialogue]"

**Voiceover script (full):**
"[full 15-60 sec script]"

**On-screen text plan (overlay timeline):**
- 0-3s: "[text]"
- 3-8s: "[text]"
- 8-15s: "[text]"
- 15-25s: "[text]"

**Shot list:**
1. [shot description — angle, action, length]
2. ...
5. ...

**Creator persona (if hiring):**
- Age range: [N]-[N]
- Vibe: [descriptor]
- Wardrobe: [casual / business-casual / specific]
- Location: [indoor / outdoor / specific]

**Audio direction:**
- Trending sound: [yes / no — if yes, type recommended]
- Background music vs voiceover-only: [recommendation]
- Sound effects: [list if any]

**Recommended length:** [N] seconds for Meta, [N] for TikTok if different

**Estimated production cost:** $X (creator $) — $Y (creator + post-production)
```

### Step 3 — Recommend launch order
- Highest-likelihood-to-work for cold audience: [#]
- Best for retargeting warm audience: [#]
- Riskiest / wildcard: [#]

### Step 4 — Save and summarize

## Hard rules

- **No fake testimonials.** If the user wants a "testimonial-style" UGC, the creator must be filming a real opinion about a real experience. Faking testimonials violates Meta's policy + most jurisdiction laws.
- **No fake "I cried" type emotional bait.** The emotional reaction has to map to a real benefit, not be performative.
- **Respect BRAND_VOICE.md taboos in voiceovers.** Hype words banned even in UGC scripts.
- **Recommend trending sounds, never specific copyrighted tracks.** "An upbeat trending pop sound" not "Espresso by Sabrina Carpenter."
- **Honest production cost estimates.** UGC creators range $50-500 per video. Don't promise unrealistic prices.

## Pro version differences

`ccai-ugc-video-ads-pro` (planned):
- Higgsfield MCP integration for auto-video generation from the brief
- Direct Meta upload via API
- A/B-test variant generation
- Trending-sound auto-detection from TikTok API

## Reference files
- `templates/UGC_BATCH.md` — output schema
- `examples/sample-ugc-batch.md` — filled example for a coaching offer
