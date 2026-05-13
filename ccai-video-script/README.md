# ccai-video-script

> Write short-form video scripts (Reels, Shorts, TikTok) that don't sound AI-generated — calibrated to your actual brand voice.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-video-script`
**Status:** v0.1 · works with Claude Code

---

## What it does

Generic AI scripts have a tell: they start with "In this video..." or "Today we're going to talk about..." They use phrases like "game-changing," "unlock the power of," "let's dive in." They never sound like *you*.

This skill is built around five explicit **de-AI passes** that strip those tells out. Every script the skill outputs has gone through:

1. Banned phrases sweep
2. Specificity injection
3. Sentence cadence calibration (against your BRAND_VOICE.md)
4. Read-aloud test
5. End test (cut the moralizing last line)

It also produces a proper two-column shooting script — spoken lines on the left, visual/B-roll/on-screen text cues on the right — so you can hand the file to your editor or just film straight from it.

---

## Why it's different from "ask Claude for a script"

1. **10 hook options first, then the script.** You pick the hook before the body is written. No more "here's a great hook" attached to a script that doesn't actually deliver on it.
2. **Reads your BRAND_VOICE.md, HOOK_LIBRARY.md, COMPETITOR_RADAR.md, and CONTENT_IDEAS.md.** When you have the CCAI foundation skills installed, scripts come out calibrated. The same prompt produces very different output for two different brands.
3. **Section budgeting.** A 45-second script is ~120 words. The skill enforces budgets per section (hook, promise, demo, payoff, CTA) so the script actually fits the target length.
4. **Visual cues are mandatory.** Spoken-only scripts are unfilmable. Every line gets a visual direction.
5. **Saves to versioned files in `scripts/`.** Not buried in chat history — proper datestamped files you can grep, reuse, and reference from other skills.

---

## What you need

- Claude Code installed
- A topic or idea (can come from `CONTENT_IDEAS.md` automatically if available)
- **Strongly recommended:** `ccai-brand-voice` already run — without it, scripts will sound generic
- **Helpful:** `ccai-hook-research` (uses your hook patterns) and `ccai-competitor-research` (uses Steal verdicts)

No API keys. No transcription. No video downloads. You write, the skill structures.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-video-script ~/.claude/skills/ccai-video-script
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-video-script
```

Or say *"write me a reel about X"* / *"script this idea"* / *"turn idea #4 from my radar into a script."*

The skill will:
1. Ask the brief (topic, audience pain, format, target length, proof anchor)
2. Generate 10 hook options across at least 5 hook patterns
3. Wait for you to pick the hook
4. Draft the script in the Hook → Promise → Demo → Payoff → CTA structure
5. Run all 5 de-AI passes
6. Save to `scripts/YYYY-MM-DD-NN-slug.md`
7. List footage needed (talking-head lines, B-roll, screenshots, on-screen text)

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill instructions Claude Code follows |
| [`templates/SCRIPT.md`](templates/SCRIPT.md) | Two-column script template |
| [`examples/sample-script.md`](examples/sample-script.md) | A filled-in 45-second Reel script with de-AI pass notes |
| [`LICENSE`](LICENSE) | MIT |

---

## The five de-AI passes (in detail)

| Pass | What it does | Why it matters |
|---|---|---|
| 1. Banned phrases sweep | Removes "in this video," "let's dive in," "game-changer," etc. | These phrases scream "AI wrote this." Strip on sight. |
| 2. Specificity injection | Replaces vague claims with concrete numbers, dates, names | "A lot of people" → "12 of my 14 clients" is the difference between credible and noise. |
| 3. Cadence calibration | Matches sentence length and rhythm to BRAND_VOICE.md | Your voice has a rhythm. Generic AI doesn't. |
| 4. Read-aloud test | Flags lines with stumble words, repeats, dense comma chains | Spoken language ≠ written language. Most AI writes prose, not speech. |
| 5. End test | Cuts moralizing "and that's why..." endings | The viewer doesn't need a lesson. They need a CTA. |

---

## FAQ

**How long does this take?**
First script: ~5 min (most spent picking the hook). After you've used it 3-4 times, ~2 min per script.

**Can it write longer-form (3-5 minute) videos?**
Not optimally — this is built for short-form (under 90 seconds). For long-form, the structural rules are different. A separate `ccai-longform-script` skill is on the roadmap.

**What about teleprompter scripts?**
The two-column format is teleprompter-friendly — just print the left column, ignore the right. Add a line break every 6-8 words for natural breathing pauses if you read on-prompter.

**Pro version with auto-scraped competitor hooks?**
Coming in `ccai-video-script-pro` (Apify + auto hook ingestion + on-camera teleprompter export).

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-video-script ~/.claude/skills/ccai-video-script

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai) — our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
