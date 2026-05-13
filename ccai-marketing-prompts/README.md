# ccai-marketing-prompts

> A curated, callable library of 35 marketing prompts — surfaced for your task and adapted to your voice. Not a flat document.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-marketing-prompts`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most "AI marketing prompt libraries" are PDFs with 100 prompts you'll never use. You download them, save them to Notion, and forget where they live.

This skill is different: it's a **searchable, voice-adapted prompt library** that surfaces the right prompt for your task at the moment you need it. Tell it what you're trying to do; it pulls the matching prompt, adapts it to your `BRAND_VOICE.md`, fills in what it can from context, and asks you for the rest.

You either:
- **Take the adapted prompt and use it yourself**, or
- **Have Claude run it inline** and produce the deliverable in the same session

---

## The 35 prompts, by category

| Category | Count | Examples |
|---|---|---|
| Content creation | 8 | Captions (3 types), LinkedIn posts (2 lengths), Twitter threads, newsletter subjects, headline batches |
| Sales + offers | 6 | Landing heroes, sales emails, welcome sequences, offer audits, pricing frames, VSL outlines |
| Ads | 5 | Meta ad copy, Google Search ads, angle brainstorms, fatigue refreshes |
| Customer research | 5 | Interview questions, survey questions, review mining, objection lists, VOC synthesis |
| Competitive analysis | 4 | Quick competitor profiles, differentiation finders, pricing comparisons, fast SWOT |
| Positioning + brand | 4 | Positioning statements, niche narrowing, value props, short bios |
| Workflow + meta | 3 | Copy audits, evergreen refreshes, repurposing briefs |

Full index in [`prompts/_INDEX.md`](prompts/_INDEX.md).

---

## Why it's different from a prompt PDF

1. **Searchable by task, not category.** You don't have to know what category "write me an offer audit" falls under. The skill matches the request to the right prompt.
2. **Voice-adapted on the fly.** Each prompt gets calibrated to your `BRAND_VOICE.md` — taboos respected, signature vocab inserted, cadence rules applied.
3. **Variable collection is interactive.** The skill walks you through what inputs the prompt needs rather than handing you a fill-in-the-blank template.
4. **Knows when to defer to deeper skills.** Want a full sales page? The skill redirects you to `/ccai-sales-copy`, not a generic prompt. The 35 prompts are for *quick starts*; the deeper skills are for *full builds*.
5. **Trackable usage.** Optional usage log builds your personal performance history of which prompts work best for your audience.

---

## What you need

- Claude Code installed
- **Strongly recommended:** `ccai-brand-voice` already run
- A task you want a prompt for

No API keys. No external data. Just a smarter way to start a marketing task.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-marketing-prompts ~/.claude/skills/ccai-marketing-prompts
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-marketing-prompts
```

Or just describe the task: *"I need a prompt for writing a sales email"* / *"give me a good starter for an Instagram caption."*

The skill will:
1. Match your task to one (or more) of the 35 prompts
2. Load the prompt file
3. Adapt to your BRAND_VOICE.md
4. Ask for the variables the prompt needs
5. Ask: return the adapted prompt for you to use, or run it inline now?
6. Either hand you the prompt OR produce the deliverable

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`prompts/_INDEX.md`](prompts/_INDEX.md) | Full searchable index of 35 prompts |
| [`prompts/_TEMPLATE.md`](prompts/_TEMPLATE.md) | The format every prompt follows |
| [`prompts/caption.short.md`](prompts/caption.short.md) | Sample prompt: IG feed-photo caption |
| [`prompts/landing.hero.md`](prompts/landing.hero.md) | Sample prompt: landing page hero |
| [`examples/sample-session.md`](examples/sample-session.md) | Transcript of how a session works |
| [`LICENSE`](LICENSE) | MIT |

*Note: only 2 of the 35 prompt files are fully written in v0.1 (`caption.short`, `landing.hero`). The remaining 33 follow the same format and are stubbed in `_INDEX.md`. v0.2 will fill in the rest.*

---

## FAQ

**Why only 35 prompts? I've seen libraries with 200+.**
Curation. 35 prompts I've validated as actually working > 200 mediocre ones. The skill exists to surface the *right* prompt, not all the prompts.

**Can I add my own prompts?**
Yes. Drop your own `.md` file into `prompts/` following `_TEMPLATE.md`. Add an entry to `_INDEX.md`. The skill will pick them up automatically.

**What if my task doesn't match any of the 35?**
The skill will tell you so and either suggest the closest match (with adaptation notes) or redirect you to a deeper specialized skill (`ccai-sales-copy`, `ccai-video-script`, etc.).

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-marketing-prompts ~/.claude/skills/ccai-marketing-prompts

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai) — our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
