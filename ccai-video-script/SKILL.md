---
name: ccai-video-script
description: Writes short-form video scripts (Reels, Shorts, TikTok) calibrated to the user's brand voice, hook library, and competitor research. Produces 10 hook options, then a full script with explicit de-AI editing passes. Saves the result to scripts/ as a numbered, datestamped file. Use when the user asks for a video script, a reel, a TikTok script, a YouTube Short, or says "write me a script for a video about X."
when_to_use: User mentions reel, short, TikTok, YouTube Short, video script, talking-head video, B-roll script, or asks "what should I say in this video." Also use when the user picks an idea from CONTENT_IDEAS.md and wants to turn it into a script.
argument-hint: "[topic or idea — optional]"
---

# CCAI Video Script

Write short-form video scripts that don't sound AI-generated, calibrated to the user's actual voice.

## Output contract

Each script is saved as a separate file in `scripts/` in the working directory:

```
scripts/YYYY-MM-DD-NN-slug.md
```

Example: `scripts/2026-05-12-01-claude-plan-comparison.md`

The NN is a sequential number for that day's scripts. The slug is a 3-5 word kebab-case summary of the topic. Each file is self-contained and follows the template in `templates/SCRIPT.md`.

## Inputs the skill reads (if present)

- `BRAND_VOICE.md` — **required for good output.** Vocabulary, cadence, taboos, calibration corpus.
- `HOOK_LIBRARY.md` — pulls hook patterns the user has already proven work
- `COMPETITOR_RADAR.md` — uses the "Steal" verdicts as structural hints
- `CONTENT_IDEAS.md` — if the topic came from an idea in this file, pull the angle and proof anchor

If `BRAND_VOICE.md` doesn't exist, push back: *"I can write this, but it'll sound generic. Want to run `/ccai-brand-voice` first? Takes 20 minutes."* If the user wants to proceed anyway, output the script but flag at the top that it's preliminary.

## Process

### Step 1 — Get the brief

Ask for:
1. **Topic / idea** — what's the video about? One sentence.
2. **Audience pain or curiosity** — what does the viewer feel right before they tap? Specific.
3. **Format** — Reel / Short / TikTok / general short-form? (Affects length and pacing.)
4. **Target length** — 30s / 45s / 60s / 90s? (Default to 45s if not specified.)
5. **One key proof anchor** — a number, story, screenshot, result, or claim the user can back up with footage.

If the topic comes from `CONTENT_IDEAS.md`, ask which idea # and pull #2/#5 automatically.

### Step 2 — Generate 10 hook options

Spread across at least 5 of the 10 hook patterns (from `HOOK_PATTERNS.md` if `ccai-hook-research` is also installed; otherwise from the embedded taxonomy in `templates/SCRIPT.md`).

Format:
```
HOOK OPTIONS

1. [Pattern type] — "Hook text."
2. [Pattern type] — "Hook text."
...
10. [Pattern type] — "Hook text."

My top 3: #X, #Y, #Z — because [one specific reason each].
```

Ask the user to pick (or say "use #X"). Don't proceed to script until a hook is chosen.

### Step 3 — Draft the script structure

Use the **Hook → Promise → Demonstration → Payoff → CTA** structure as default. For ultra-short (under 30s) scripts, drop Demonstration and combine Promise+Payoff.

Section budgets for a 45s script (~120 words spoken):
- Hook: 1–2 lines (5–8 words) — must land within 3 seconds
- Promise: 1 line (the payoff teased)
- Demonstration: 4–6 lines (the proof or example)
- Payoff: 1–2 lines (the takeaway)
- CTA: 1 line (specific action)

Output the script in two columns: **left = spoken word**, **right = visual / on-screen text / B-roll cue**.

### Step 4 — Run de-AI passes

After the first draft, run these passes explicitly in order:

**Pass 1 — Banned phrases sweep**
Strip every instance of:
- "In this video..." / "Today we're going to talk about..."
- "Let's dive in" / "Without further ado"
- "Stay tuned" / "Don't forget to like and subscribe"
- "Game changer," "revolutionary," "unlock the power of"
- "It's no secret that..."
- Any sentence starting with "If you've ever..." — overused
- Anything in BRAND_VOICE.md's Taboos section

**Pass 2 — Specificity injection**
For every vague claim, add one concrete element:
- Abstract ("a lot of people") → Specific ("3 of my last 5 calls")
- Vague ("a while ago") → Dated ("two weeks ago")
- General ("a tool") → Named ("Claude Code")
- Implied result ("saved time") → Numbered ("saved 4 hours that week")

**Pass 3 — Sentence cadence calibration**
Compare to the user's BRAND_VOICE.md cadence rules:
- If their average sentence length is 14 words, no line over 20 words
- If they use fragments (per voice doc), include 2–3 fragments
- If they use em-dashes, sprinkle in 1–2

**Pass 4 — Read-aloud test**
Mentally simulate reading each line aloud. Flag any line that:
- Has a stumble word ("subsequently," "henceforth," anything you wouldn't say to a friend)
- Repeats a word from the line before
- Has more than one comma (likely too dense for spoken)

Rewrite flagged lines.

**Pass 5 — End test**
Re-read the last line. Ask: does this feel like the natural punchline, or am I just hitting word count? If it's word-count filler, cut the line.

### Step 5 — Output

Write the final script to `scripts/YYYY-MM-DD-NN-slug.md`. Include:
- Frontmatter (topic, hook used, target length, source idea if applicable)
- Two-column script (spoken / visual)
- Footer: list of what the user needs to record (B-roll shots, screenshots, voiceover lines)

Summarize for the user: *"Saved to scripts/X. Estimated runtime: NN seconds. Footage needed: [list]. Want me to tighten any section?"*

## Hard rules

- **Never start a script with "Hey guys" or any greeting.** The first 3 seconds are the hook. Greetings are scroll-killers.
- **Never write a script longer than the target length supports.** 120 words ≈ 45 seconds spoken at conversational pace. Overshoot = bad pacing.
- **Always provide visual/B-roll cues.** A script without visual direction is a half-script.
- **Respect BRAND_VOICE.md taboos absolutely.** Bigger sin than a weak hook.
- **One CTA only.** Two CTAs = no CTA. Pick the highest-value action and ask for that one thing.

## Reference files

- `templates/SCRIPT.md` — output schema with the 2-column format
- `examples/sample-script.md` — a filled-in example showing the bar

## Anti-patterns to avoid

- Writing a "script" that's just paragraphs of prose. Short-form scripts need line breaks, beats, and visual cues to be filmable.
- Skipping the de-AI passes because they feel mechanical. They are mechanical — that's why they work. Don't trust your first draft.
- Adding the CTA mid-script. Always last line.
- "And that's why you should..." moralizing endings. Cut. The viewer gets it.
