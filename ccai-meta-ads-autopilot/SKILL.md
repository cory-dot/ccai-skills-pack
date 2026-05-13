---
name: ccai-meta-ads-autopilot
description: Weekly Meta Ads (Facebook/Instagram) management workflow — sweeps last week's data, identifies winners and losers, generates 10 new ad concepts using the proven 3-3-2-2 distribution (3 doubling-down on winners, 3 competitor-inspired, 2 new psychology pillars, 2 wildcards), produces upload-ready ad copy variants, and outputs a clear kill/promote/test action list. Free version is manual-upload (you bring last week's data, the skill plans the next batch). Pro version adds Meta API + Higgsfield automation. Use when the user runs Meta ads and wants a structured weekly creative refresh process.
when_to_use: User mentions Meta ads, Facebook ads, Instagram ads, ad campaign management, weekly ad refresh, ad fatigue, "what should I test next," ad creative generation, or asks to plan a weekly ads sprint.
argument-hint: "[paste last week's ad data, or 'setup' for first run]"
---

# CCAI Meta Ads Autopilot

Free version. Manual data input, structured weekly planning + creative output. Pro version adds Meta API auto-execution.

## What this skill is (and isn't)

**Is:** A weekly Meta Ads planning workflow that turns last week's performance data into next week's creative batch — using the same 7-step logic as full-auto media buyer tools, but executed manually.

**Isn't:** Direct Meta API integration. The free version does NOT auto-pull data, auto-upload ads, or auto-kill underperformers. You bring the data; the skill plans the strategy and produces upload-ready creative. Pro version (`ccai-meta-ads-autopilot-pro`) adds full API automation.

## Why this works manually

The hard part of weekly ad management isn't the API calls — it's the strategic decisions: which winners to double down on, which competitors to copy, which psychology pillars to test. A skilled media buyer's value lives in those decisions. This skill runs the decision logic on your behalf; you handle the 15 minutes of manual upload.

If you're running fewer than $5,000/month in ad spend, the manual version is the right tradeoff. Above that, the pro version pays for itself in API automation.

## Output contract

Each weekly run writes to `meta-ads/YYYY-MM-DD-week-NN.md` in the working directory:
- Last week's audit (winners, losers, gray-zone)
- Kill/promote/test action list (manual: do these in Ads Manager)
- 10 new ad concepts (3-3-2-2 distribution)
- Upload-ready ad copy for each concept (primary text, headline, description, audience, budget)
- Image direction for each concept (you generate the image yourself OR use Higgsfield/Midjourney/Canva)

## Inputs the skill reads (if present)

- `BRAND_VOICE.md` — for ad copy voice
- `COMPETITOR_RADAR.md` — competitors' positioning for Step 3 (competitor-inspired concepts)
- `meta-ads/` directory — past weeks' logs for trend awareness

## Required user inputs (each weekly run)

1. **Last week's ad performance data** — paste a table with columns: ad name, spend, impressions, clicks, CPM, CTR, conversions, CPA. Doesn't need to be all columns; CPA and CTR are minimum.
2. **The offer** — what's being advertised (URL, price, format)
3. **Audience** — who's the target? (Detailed targeting parameters Meta supports)
4. **Weekly budget** — total testing + main spend
5. **3-10 competitor Page IDs or names** — for Step 3 inspiration
6. **Kill threshold** — what's the spend-per-ad ceiling without a conversion? (Default: $20)
7. **Win threshold** — what CPA counts as a winner worth scaling? (Default: ≤ your target CPA × 0.7)

## The 7-step weekly loop

### Step 1 — Sweep last week
Read the pasted performance data. For each ad, classify:
- **🟢 Winner** — CPA at or below win threshold → action: promote to main campaign
- **🔴 Loser** — spend > kill threshold, 0 conversions → action: kill (pause)
- **🟡 Gray zone** — between thresholds → action: let it run another week

Output: a numbered action list the user executes manually in Ads Manager.

### Step 2 — Read performance over 30 days
If past weekly logs exist in `meta-ads/`, aggregate the trends:
- Top 5 winners across the rolling 30 days
- Bottom 5 losers
- Format diversity (image / video / carousel ratio)
- Audience diversity (which targeting setups produce winners)

If no history exists (first run), skip this step and note the user can run a 4-week retro after enough data exists.

### Step 3 — Competitor inspiration
Ask the user for 3-5 competitor ads they've seen recently — pasted or described. (Pro version scrapes Meta Ad Library directly.) For each:
- Identify the hook pattern
- Identify the structural angle
- Identify what's likely making it work

Pick the 3 strongest patterns for the new batch.

### Step 4 — Generate 10 concepts (3-3-2-2 distribution)
- **3 doubling-down** on Step 1's winners — variations of what worked, not exact copies
- **3 competitor-inspired** — using patterns from Step 3, applied to the user's offer
- **2 new psychology pillars** — testing an angle not yet attempted (problem → solution, before/after, contrarian, social proof, transformation, urgency, etc.)
- **2 wildcards** — concepts the user wouldn't normally make (different format, different audience, unexpected angle)

Each concept includes:
- **Concept name** (1-3 words for tracking)
- **Hook pattern** (from the 10 in HOOK_PATTERNS taxonomy if `ccai-hook-research` is installed)
- **Primary text** (90 chars max — Meta's ad primary text field)
- **Headline** (30 chars — Meta's headline field)
- **Description** (30 chars — Meta's description field)
- **Image direction** (what the image should show — for generation)
- **Audience** (targeting parameters)
- **Initial budget** (suggested daily spend in testing)

### Step 5 — Image direction (not generation)
The free version describes the image but does NOT generate it. For each of the 10 concepts:
- A 2-3 sentence visual description
- Suggested format (single image, carousel, video idea)
- On-screen text overlay if applicable
- Color palette / mood

User generates the images using their tool of choice (Midjourney, Canva, DALL-E, Higgsfield). Pro version auto-generates via Higgsfield MCP.

### Step 6 — Output upload spec
Write the full weekly batch to `meta-ads/YYYY-MM-DD-week-NN.md`. Include:
- The Step 1 action list (kill/promote)
- The 10 new ad specs
- A suggested Meta Ads Manager upload order (often: launch all 10 paused, un-pause as a batch for clean A/B comparison)
- A `BUDGET_PLAN.md` summary: how the weekly budget splits across testing vs main campaign

### Step 7 — Log the run
Append a one-line entry to `meta-ads/_log.md`:
```
| YYYY-MM-DD | Wk N | Spend $X | Best CPA $Y | New concepts 10 | Notes |
```

This log feeds Step 2 in future weeks (30-day rolling history).

## Hard rules

- **Free version never calls Meta API.** All execution is manual. If the user asks for auto-upload, redirect to pro version.
- **The 3-3-2-2 distribution is enforced.** Don't generate 6 winners-variations and 4 wildcards. Diversity is the point — saves you from over-fitting to last week.
- **Respect BRAND_VOICE.md taboos in every ad.** Even ad copy with strict character limits cannot violate brand voice rules.
- **Don't recommend killing an ad before it's reached the kill threshold.** "Looks weak" is not a kill signal — spend + zero conversions is.
- **Never fabricate competitor data.** If the user hasn't provided competitor ads, do Step 3 with the user's known competitor names and ask them to verify the patterns.

## Reference files

- `templates/WEEKLY_BATCH.md` — output schema for each weekly run
- `examples/sample-weekly-batch.md` — a filled example

## Anti-patterns to avoid

- Producing 10 ads that all use the same hook pattern. The 3-3-2-2 distribution prevents this — enforce it.
- Recommending "scale up budget" without enough data. A winner with 5 conversions isn't enough to scale; needs at least 20-30 for statistical significance.
- Skipping the wildcard concepts. They feel low-probability but are where the biggest unexpected winners come from.
- Generating ad copy that's too long. Meta truncates primary text at ~125 characters (~90 visible before "See More"). Respect the limit.
- Auto-recommending "test broader audience" every week. Broader audiences are the right move sometimes, not always.

## Pro version

`ccai-meta-ads-autopilot-pro` (planned) adds:
- Meta Marketing API integration (auto-pull performance data, auto-create campaigns/ad sets/ads)
- Higgsfield MCP for auto-image generation
- Cron scheduling (runs every Monday 9am automatically)
- Slack/SMS digest of the weekly results
- Automated kill/promote actions in Ads Manager

The strategic logic (3-3-2-2, kill thresholds, win thresholds) is identical between free and pro. The difference is who executes the actions.
