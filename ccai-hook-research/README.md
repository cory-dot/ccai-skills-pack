# ccai-hook-research

> Build and grow a structured library of proven content hooks. Generate new hooks for any topic, calibrated to your brand voice.

**Slash command:** `/ccai-hook-research`
**Status:** v0.1 · works with Claude Code

---

## What it does

You collect hooks all the time — screenshots from creators you watch, lines that stopped you scrolling, openers from emails that made you actually read on. The problem is they live in your camera roll, your Notes app, and your head. You can't reuse what you can't find.

This skill turns that scattered collection into a structured `HOOK_LIBRARY.md`:

- Classifies every hook into one of **10 proven patterns** (contrarian, pain mirror, confession, etc.)
- Extracts the reusable template from each ("[N] things I'd do if I started over with [constraint]")
- Tags performance data if you have it (outlier scoring vs. creator baseline)
- **Generates 10 new hooks** for any topic when you ask, using your library + your brand voice

If you also have `ccai-brand-voice` set up, generated hooks come out sounding like *you* — not like a generic AI ad.

---

## Why it's different from other hook generators

Most hook tools just give you a list of formulas and ask you to fill in the blanks. This skill is different in three ways:

1. **It learns from hooks *you've already proven work for your audience.*** Generic templates assume your audience is like everyone else's. Yours isn't.

2. **It saves underperformers too.** A hook that flopped is data, not garbage. The library keeps a `❌ underperformed` section so future generations don't fall into the same trap.

3. **It writes in your voice.** When `BRAND_VOICE.md` exists in the same directory, generated hooks match your vocabulary, cadence, and taboos. No `"Let's dive in!"` openers when you'd never say that.

---

## What you need

- Claude Code installed (`@anthropic-ai/claude-code`)
- Some hooks to research, OR a topic to generate hooks for
- **Strongly recommended:** `ccai-brand-voice` already run in the same directory so this skill can match your voice
- **Optional:** performance data (views vs. creator baseline) — enables outlier scoring

No API keys, no scraping, no external services. You provide the hooks, the skill does the analysis.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-hook-research ~/.claude/skills/ccai-hook-research
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

### Mode A — Research (add hooks to your library)

```
/ccai-hook-research research
```

Or just say *"I have some hooks I want to classify"* and Claude Code will load this skill.

The skill will:
1. Ask you to paste hooks (one per line) or point to a folder
2. Classify each into one of 10 patterns
3. Extract the reusable template
4. Score against creator baseline if you have data
5. Append to `HOOK_LIBRARY.md` in your working directory

### Mode B — Generate (make new hooks)

```
/ccai-hook-research generate "topic goes here"
```

Or say *"give me 10 hooks for a reel about X."*

The skill will:
1. Ask you the brief (topic, audience pain, format, optional pattern preferences)
2. Read your `HOOK_LIBRARY.md` and `BRAND_VOICE.md` if they exist
3. Produce 10 hooks spread across at least 5 different patterns
4. Pick its top 3 and explain why
5. Tighten iteratively based on which one you like

---

## The 10 patterns

Full definitions in [`templates/HOOK_PATTERNS.md`](templates/HOOK_PATTERNS.md). Quick summary:

1. **Contrarian** — "Stop doing X. Do Y instead."
2. **Pain mirror** — "You've [specific painful experience]?"
3. **Authority + proof** — "I [credential]. Here's the one thing that mattered."
4. **Step-by-step promise** — "N steps to X. Step 1 is the one most people skip."
5. **Confession / forbidden** — "I probably shouldn't share this, but…"
6. **Before vs after** — "[Where I started] → [where I am]"
7. **Quick-fix promise** — "Fix X in 60 seconds."
8. **Suspense / open loop** — "Watch what happens when I…"
9. **Personal cost** — "This cost me $X. Don't repeat it."
10. **Hidden truth** — "No one talks about X in [niche]."

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill instructions Claude Code follows |
| [`templates/HOOK_PATTERNS.md`](templates/HOOK_PATTERNS.md) | The 10-pattern taxonomy reference |
| [`templates/HOOK_LIBRARY.md`](templates/HOOK_LIBRARY.md) | Blank template for your library file |
| [`examples/sample-hook-library.md`](examples/sample-hook-library.md) | A filled-in example showing the bar |
| [`LICENSE`](LICENSE) | MIT |

---

## Workflow tip

Run **research mode every 1–2 weeks** as you collect new hooks. Run **generate mode every time you write a new piece of content.** The library compounds — the longer you've been adding to it, the better your generated hooks get.

---

## Part of the Creative Core AI skills pack

This is one of ~33 skills in the [Creative Core AI skills pack](https://github.com/cory-dot/ccai-skills-pack). The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).

---

## License

MIT. Use commercially, fork, modify — don't claim you wrote it.
