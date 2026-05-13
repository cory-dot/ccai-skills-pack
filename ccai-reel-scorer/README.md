# ccai-reel-scorer

> Pre-flight checklist for short-form video. Score your script before you film it. Catch the dead reels at the draft stage, not the editing stage.

**Slash command:** `/ccai-reel-scorer`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most "is my reel any good" questions get answered after filming, after editing, after posting — when the data finally comes in. By then you've wasted 2 hours per dead reel.

This skill catches dead reels at the script stage. It runs your draft through a 10-dimension viral-readiness checklist:

1. Hook strength
2. Hold-rate risk
3. Payoff clarity
4. Specificity
5. Pacing
6. Visual filmability
7. Voice fit
8. CTA strength
9. Saveability
10. Differentiation

Each gets a 0-10 score with a specific quote-backed justification. Total = 0-100 readiness score with a clear verdict (Ship / Revise / Significant rewrite / Reframe / Kill). And — the part most "AI feedback" tools skip — **the top 3 highest-leverage revisions in priority order**, with estimated point gains from each.

---

## What this is NOT

This is **not** perceptual video scoring (sound, visual, completion-rate prediction from footage). That's what tools like [Higgsfield Virality Predictor](https://higgsfield.ai/apps/virality-predictor) do, and it's handled in the pro version (`ccai-reel-scorer-pro` — Higgsfield MCP wrapper).

This is **script-stage** scoring. Catches the structural problems that perceptual scoring can't fix anyway — wrong hook, weak CTA, missing proof anchor, voice drift. Most "this reel didn't hit" reasons live here.

---

## Why it's different from "ask Claude if this is any good"

1. **Quantified scoring with calibration.** Each dimension is bounded 0-10 with explicit anchor descriptions per band. Forced discrimination — you can't give everything a 7.
2. **Quote-backed justifications.** Every score points to a specific line. No "feels weak" hand-waving.
3. **Top-3 revisions, not generic critique.** Most feedback tools tell you what's wrong. This one tells you what to fix *first* to move the score the most.
4. **Reads your foundation files.** If `BRAND_VOICE.md`, `HOOK_LIBRARY.md`, and `CONTENT_IDEAS.md` exist, scoring is calibrated to your specific voice and proven patterns.
5. **Refuses to greenlight low scores.** Hard rule in the skill: even if you're rushing, the skill won't recommend "ship it" with anything below 70/100.

---

## What you need

- Claude Code installed
- A reel script (either pasted or saved at `scripts/...md`) OR a concept ready for review
- **Strongly recommended:** `ccai-brand-voice` already run

No API keys, no video upload, no perceptual analysis. Pure script-stage scoring.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-reel-scorer ~/.claude/skills/ccai-reel-scorer
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-reel-scorer
```

Or *"score this reel"* / *"is this script ship-ready"* / *"pre-flight check this."*

The skill will:
1. Get the script (file path, paste, or concept description)
2. Read foundation files (BRAND_VOICE.md, HOOK_LIBRARY.md, CONTENT_IDEAS.md)
3. Score each of 10 dimensions with quote-backed justifications
4. Sum to 0-100, determine verdict band
5. Pick top 3 highest-leverage revisions with estimated point gains
6. Save the report to `reel-scores/YYYY-MM-DD-NN-slug.md`

Expect ~3-5 min of skill output to read carefully. Score + verdict at the top, full breakdown below.

---

## The verdict bands

| Score | Verdict |
|---|---|
| 85-100 | **Ship it.** Film and post as drafted. |
| 70-84 | **Solid.** Revise 2-3 weakest dimensions, then film. |
| 50-69 | **Promising concept, weak execution.** Significant rewrite before filming. |
| 30-49 | **Structural problems.** Reframe or pick a different concept. |
| 0-29 | **Don't film.** Concept doesn't work as drafted. |

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions with all 10 dimension definitions |
| [`templates/REEL_SCORE.md`](templates/REEL_SCORE.md) | Output report template |
| [`examples/sample-reel-score.md`](examples/sample-reel-score.md) | A fully scored example (82/100 verdict with top-3 revisions) |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Can it score a video file I already filmed?**
No. That's perceptual scoring. Use [Higgsfield Virality Predictor](https://higgsfield.ai/apps/virality-predictor) for finished video. This skill is for the script before you commit to filming.

**Why so many dimensions? Isn't that overengineered?**
Each dimension catches a different failure mode. A script can have a 10/10 hook and 3/10 CTA and still flop. Single-score "is it good" feedback misses the diagnosis — which dimension is broken. The 10-dim breakdown is what makes the top-3 revisions actionable.

**Score doesn't always predict performance, right?**
Correct. This is a leading indicator at the script stage, not a guarantee. A 95/100 script can still flop if the timing is wrong, the audience changed, or the platform algorithm did something weird. But a 30/100 script flopping isn't a surprise — and the skill saves you the filming time.

**Pro version with perceptual scoring?**
`ccai-reel-scorer-pro` wraps the Higgsfield MCP for actual video-file analysis (engagement score, peak hook timestamp, hold rate, brain heatmap). Free version covers script-stage; pro adds the post-film layer.

---

## Part of the Creative Core AI skills pack

This is one of ~33 skills in the [Creative Core AI skills pack](https://github.com/cory-dot/ccai-skills-pack). The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).

---

## License

MIT.
