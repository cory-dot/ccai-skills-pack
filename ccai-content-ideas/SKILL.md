---
name: ccai-content-ideas
description: "Structured content idea generation for creators and small business owners. Produces 10 ideas at a time, each with a hook, format, angle, and proof anchor, calibrated to the user's brand voice and saved hooks. Maintains a persistent CONTENT_IDEAS.md radar with status tracking (idea → drafted → published → result) so ideation compounds over time. Use when the user asks for content ideas, says they're stuck, needs a batch of reels/posts/scripts, or wants to plan content for the week."
when_to_use: "User mentions content ideas, post ideas, video ideas, content planning, \"what should I post,\" writer's block, content calendar, content pipeline, or asks to brainstorm. Also use after a script or post is finished, to suggest follow-ups."
argument-hint: "[topic or theme, optional]"
---

# CCAI Content Ideas

Generate and track content ideas in a structured way. Not a one-shot brainstormer, a compounding radar.

## Output contract

This skill maintains `CONTENT_IDEAS.md` in the working directory. Each run appends new ideas; old ideas are never deleted. Each idea has a status field that the user updates over time.

**Schema is defined in `templates/CONTENT_IDEAS.md`, do not change section headings.**

## Inputs the skill reads (if present in working directory)

- `BRAND_VOICE.md`, for voice calibration on hook phrasing
- `HOOK_LIBRARY.md`, to use the user's proven hook templates as starting structures
- `CONTENT_IDEAS.md`, to see what's already been generated/used (avoid duplicates, identify themes that work)

If none exist, the skill works from first principles using the framework below but flags that quality will improve once the user runs `ccai-brand-voice` and `ccai-hook-research`.

## Process

### Step 1, Brief

Ask for:
1. **Topic / theme**, what's the content about? Can be broad ("AI for small businesses") or narrow ("the new MCP feature")
2. **Audience pain or curiosity right now**, what does the viewer feel *this week* that wasn't true a month ago? Push the user for current specificity, not evergreen pain
3. **Format mix**, Reels only? LinkedIn? Mix? Specify count per format if a mix
4. **Recent observations**, anything they've noticed trending in their feed, in conversations, in their inbox, in their analytics. The skill works best when fed live observations, not pulled from thin air

If the user can't answer #2 specifically, run a quick prompt: *"What's the last conversation, DM, or comment that made you think 'huh, lots of people are asking this'?"* Use that as the pain seed.

### Step 2, Read context

If `HOOK_LIBRARY.md` exists, scan the user's top-performing patterns. Bias new ideas toward those patterns (with at least 2 deliberate experiments outside the user's comfort zone).

If `BRAND_VOICE.md` exists, read taboos and signature vocabulary. Generated hooks must respect both.

If `CONTENT_IDEAS.md` exists with prior entries, scan for:
- Topics already covered (avoid recency duplication)
- Patterns marked ✅ in user's result column (lean toward)
- Patterns marked ❌ (avoid)

### Step 3, Generate 10 ideas

Each idea is a row with these fields:

| Field | What it captures |
|---|---|
| **#** | Sequential number in CONTENT_IDEAS.md |
| **Idea** | One-sentence summary of the post/script |
| **Hook** | The exact opener (6–18 words depending on format) |
| **Pattern** | Which of the 10 hook patterns (from HOOK_PATTERNS.md taxonomy) it uses |
| **Format** | Reel / Short / Carousel / LinkedIn / Email / Blog |
| **Angle** | The specific frame or contrarian take, what makes this idea worth making vs. the obvious version |
| **Proof anchor** | What gives this idea credibility, a number, a personal story, a screenshot, a result, a date |
| **Status** | `idea` (default, user updates later) |
| **Result** | (filled in by user later, `worked` / `flopped` / `mixed` + note) |

### Step 4, The "is this worth making" filter

Before finalizing the 10 ideas, run each through this filter and drop or rewrite any that fail:

1. **Specificity test:** does the hook mention a real number, name, date, or vivid detail? If it's all abstract, rewrite or cut.
2. **Originality test:** could the user's nearest competitor post the exact same idea verbatim? If yes, sharpen the angle until they couldn't.
3. **Voice test:** does the hook violate any taboos in BRAND_VOICE.md? If yes, rewrite.
4. **Proof test:** can the user actually back up the claim within 60 seconds of footage / 200 words of copy? If not, soften the claim or pick a different idea.

### Step 5, Output

Write the 10 ideas to `CONTENT_IDEAS.md` under a new dated section. Then summarize for the user:

> **10 ideas added to CONTENT_IDEAS.md. My top 3 picks: #X (because Y), #X (because Y), #X (because Y). Reply with which ones you want to draft and I'll route them, script via ccai-video-script, copy via ccai-sales-copy, carousels via ccai-carousel-builder.**

### Step 6, Update loop (when re-run later)

When the user comes back later and says *"I posted #3, it did okay"* or *"#7 flopped"*, update the corresponding row's `result` field. Don't ask for analytics-grade detail, even a one-word verdict feeds the next generation.

## Hard rules

- **Never generate 10 ideas that all use the same pattern.** Spread across at least 5 of the 10 hook patterns. Pattern diversity is the point.
- **Never invent results.** If the user hasn't shared performance data, the `result` column stays empty. Don't fabricate "predicted: high engagement", that's noise.
- **Real input or no output.** If the user has no observations and no pain to share, push back: *"I can generate generic ideas, but they won't be useful. What's one thing you've heard your audience say this week?"*
- **No "evergreen" ideas without a fresh angle.** "5 ways to improve productivity" is dead. "Why I deleted my productivity app on day 4 and got more done" is alive. Always look for the now-flavored angle.
- **Respect BRAND_VOICE.md taboos absolutely.** Bigger sin than a weak idea.

## Reference files

- `templates/CONTENT_IDEAS.md`, schema for the user's radar file
- `examples/sample-content-ideas.md`, filled-in example showing the bar

## Anti-patterns to avoid

- Padding 10 with weak ideas. Better to deliver 7 good ones and tell the user the other 3 didn't pass the filter.
- Skipping the brief because the user is in a hurry. The brief is 60 seconds and saves 30 minutes of bad ideas.
- Treating Reddit/Twitter/TikTok trend headlines as ideas. They're inputs, not ideas. The skill's job is to combine a trend with the user's angle, not surface trends.
- Generating ideas without checking `CONTENT_IDEAS.md` for duplicates. The radar compounds; respect what's already there.
