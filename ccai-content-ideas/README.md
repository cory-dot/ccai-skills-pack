# ccai-content-ideas

> Structured content idea generation that compounds over time. Not a one-shot brainstormer — a content radar.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-content-ideas`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most AI content idea generators produce 10 ideas, you save them in Notion, you forget about them, and next week you ask for 10 more. Nothing compounds.

This skill is built differently. It maintains a persistent `CONTENT_IDEAS.md` file in your project directory that:

- Captures 10 new ideas per run, each with hook + format + angle + proof anchor
- Tracks status (`idea` → `drafting` → `posted` → `worked/flopped`)
- Avoids duplicating topics from recent batches
- Learns from your results — patterns marked ✅ get prioritized, ❌ patterns get avoided
- Builds an **insights ledger** as a side-effect — observations about what works for *your* audience

After 4–6 batches, the file becomes more valuable than the AI generating the ideas. That's the point.

---

## Why it's different from other content idea generators

1. **Append-only file, not a chat history.** Your ideas persist across sessions. You can edit, annotate, and update them with results.
2. **Reads your `BRAND_VOICE.md` and `HOOK_LIBRARY.md`.** If you've run the foundational CCAI skills, ideas come out in your voice using hook patterns you've already proven work.
3. **Spreads across 10 hook patterns, not 1.** The taxonomy comes from `ccai-hook-research`. No more "5 ways to..." spam.
4. **"Is this worth making" filter runs before delivery.** Each idea is tested for specificity, originality, voice fit, and provability. Weak ideas get cut or sharpened, not handed to you.
5. **The status loop matters more than the generation.** Telling the skill "#3 flopped" makes the next batch better.

---

## What you need

- Claude Code installed
- An ongoing project (this skill is most valuable used over weeks/months, not one-time)
- **Strongly recommended:** `ccai-brand-voice` and `ccai-hook-research` already run in the same directory
- **At minimum:** willingness to share *one* fresh observation about what your audience is feeling/saying this week. Without that, the output is generic.

No API keys. No external services. No "Reddit trend scraper." You bring the observations; the skill structures and compounds them.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-content-ideas ~/.claude/skills/ccai-content-ideas
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-content-ideas
```

Or say *"give me 10 content ideas"* / *"I'm stuck on what to post."*

The skill will:
1. Ask you for the brief (topic, audience pain, format mix, recent observations)
2. Read `BRAND_VOICE.md`, `HOOK_LIBRARY.md`, and existing `CONTENT_IDEAS.md`
3. Generate 10 ideas spread across at least 5 hook patterns
4. Run each through the "is this worth making" filter
5. Append the batch to `CONTENT_IDEAS.md` with status `idea`
6. Pick its top 3 and explain why
7. Offer to route any of them to `ccai-video-script`, `ccai-sales-copy`, or `ccai-carousel-builder` for drafting

---

## The status loop

After you post, come back and update the result column:

```
# Conversation example
> "I posted idea #3 from the last batch. Got 4x my usual reach."
```

The skill will mark #3 as `posted` + result `worked` and use that signal next time you generate. After ~10–15 marked results, the recommendations get noticeably better.

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill instructions Claude Code follows |
| [`templates/CONTENT_IDEAS.md`](templates/CONTENT_IDEAS.md) | Blank radar file template |
| [`examples/sample-content-ideas.md`](examples/sample-content-ideas.md) | A filled-in example showing the bar |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**How is this different from `ccai-hook-research` generate mode?**
`ccai-hook-research generate` produces 10 hook lines for a single piece of content. `ccai-content-ideas` produces 10 full content concepts (hook + format + angle + proof) and tracks them over time. Use hook-research when you have a topic locked and need a great opener; use content-ideas when you're earlier in the funnel and don't know what to make yet.

**Can I run this without `ccai-brand-voice` or `ccai-hook-research`?**
Yes, but the output will be generic. The whole point is calibration to *you*. Run the two foundation skills first, then this.

**My audience is B2B / enterprise — does this still work?**
Yes. The format mix is configurable (LinkedIn, email, white paper sections, sales talking points). The taxonomy isn't TikTok-specific.

**What about Pro version with auto trend-scraping?**
Coming in `ccai-content-ideas-pro` — adds Apify/Reddit/Google Trends auto-feed for trending topic discovery. Free version intentionally requires you to bring your own observations because the observation *is* the differentiator.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-content-ideas ~/.claude/skills/ccai-content-ideas

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai) — our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
