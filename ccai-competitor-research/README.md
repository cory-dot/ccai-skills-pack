# ccai-competitor-research

> Build and maintain structured competitor profiles. Not a one-time analysis — a living strategic radar that compounds over time.

**Slash command:** `/ccai-competitor-research`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most "competitor research" ends with a Notion doc that's out of date in 60 days. This skill takes a different angle: a single living `COMPETITOR_RADAR.md` file in your project directory that you grow over months.

For each competitor you research, the skill captures:
- Positioning, content pillars, format mix, offers, audience
- Which **hook patterns** (from the same 10-pattern taxonomy as `ccai-hook-research`) they lean on
- What's **working** and what's **stale** for them
- Three explicit verdicts: ✅ **Steal**, ❌ **Avoid**, 🎯 **Gap** (the most valuable column)

After 3+ profiles, the skill produces a **cross-radar synthesis** — common pillars, unique territory, white space, and offer-ladder gaps.

---

## Why it's different from "ask AI to summarize this competitor"

1. **Append-only, dated entries.** When a competitor pivots, you add a new dated update — never overwrite. The history shows you how they evolved.
2. **Eight explicit analysis dimensions.** No vibes-based "they're killing it." Every observation is structural.
3. **Cross-platform by default.** Not Instagram-only. The skill asks about LinkedIn, YouTube, newsletter, podcast, X — wherever the competitor actually operates.
4. **The Gap column.** Every competitor profile must end with "what they're *not* doing that you could own." Most analysis tools skip this. It's the highest-value output.
5. **Reads your other CCAI files.** If you have `BRAND_VOICE.md` and `HOOK_LIBRARY.md`, the verdicts respect your voice and known patterns instead of generic advice.

---

## What you need

- Claude Code installed
- 1–5 competitors you want to study (more than 7 and returns diminish sharply)
- Some real samples of their content (pasted or screenshotted) — the skill works on evidence, not speculation
- **Strongly recommended:** `ccai-brand-voice` already run so verdicts can respect your voice

No API keys, no scraping, no Apify. You provide the samples; the skill structures them.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-competitor-research ~/.claude/skills/ccai-competitor-research
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-competitor-research
```

Or just say *"research competitor X"* / *"who else is in this space"* and Claude Code will load this skill.

For each competitor, the skill will:
1. Ask you for samples and signals
2. Analyze across 8 dimensions
3. Produce 3 verdicts (Steal / Avoid / Gap)
4. Append the profile to `COMPETITOR_RADAR.md`
5. After 3+ profiles exist, offer to run a cross-radar synthesis

---

## When to update vs. profile new

- **New competitor entering your radar →** create a new profile
- **Existing competitor pivots, launches something, changes strategy →** add a dated update inside their profile section. Don't overwrite. The history is signal.
- **Quarterly maintenance →** worth re-running the cross-radar synthesis even if no new profiles, to see how the landscape moved.

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill instructions Claude Code follows |
| [`templates/COMPETITOR_RADAR.md`](templates/COMPETITOR_RADAR.md) | Blank radar template |
| [`examples/sample-competitor-radar.md`](examples/sample-competitor-radar.md) | A filled-in example with 3 profiles + cross-radar synthesis |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Can you scrape Instagram for me?**
Not in the free version. That's the pro version — `ccai-competitor-research-pro` (Apify + Whisper transcription pipeline) — coming later. The free version is built on evidence you provide, which is intentionally a constraint that forces you to actually look at competitor content rather than auto-importing slop.

**How many competitors should I profile?**
3–5 is the sweet spot. The cross-radar synthesis becomes possible at 3. Past 7, profiles stop adding new signal because everyone starts looking the same.

**What if the competitor is huge (10M+ followers) and I'm small?**
Profile them anyway, but be honest about which patterns are available to you. Their cadence and production budget probably aren't — but their hook patterns, content pillars, and offer structure usually are.

---

## Part of the Creative Core AI skills pack

This is one of ~33 skills in the [Creative Core AI skills pack](https://github.com/cory-dot/ccai-skills-pack). The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).

---

## License

MIT.
