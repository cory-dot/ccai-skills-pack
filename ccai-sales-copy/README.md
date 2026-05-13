# ccai-sales-copy

> Direct-response sales copy that diagnoses the audience first, then picks the right framework. Not template-fill.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-sales-copy`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most "AI sales copy" tools dump generic AIDA into whatever you ask for. The result reads like every other landing page on the internet.

This skill is built around a simple insight: **60% of bad sales copy is framework-stage mismatch.** Using AIDA on a solution-aware reader, or FAB on someone who doesn't know they have a problem, doesn't work, no matter how good the writing is.

So the skill diagnoses first:
1. Where is the reader in **Schwartz's 5 awareness stages**? (Unaware → Most-aware)
2. What's the asset? (Landing hero, ad, email, VSL outline, sales section, or headlines batch)
3. What's the offer, proof anchor, primary objection, and transformation?

Then it picks the right framework, **AIDA, PAS, BAB, FAB, OATH**, or a hybrid, and writes the copy. Every output runs through a 5-point conversion check (specificity, objection coverage, proof placement, CTA singularity, voice fit) before it's saved.

---

## Why it's different

1. **Diagnosis before drafting.** The skill won't write a single line until you've confirmed the awareness stage and asset type. No generic output.
2. **Framework taxonomy, not bag-of-tricks.** Five canonical frameworks, each defined with structure + best-fit audience + watch-outs. No "100 sales letter templates" overwhelm.
3. **Conversion check log included in every output.** Specificity audit, objection coverage, proof placement, CTA singularity, voice fit. You see exactly what got checked.
4. **Reads your `BRAND_VOICE.md`.** Taboos are absolute, no "transform your business" if your voice doc forbids it.
5. **Saves to versioned files.** `copy/` directory with frontmatter for tracking. You can A/B test across variants without losing track.

---

## What you need

- Claude Code installed
- An offer (something to sell, paid, free, lead magnet, anything with a CTA)
- A real proof anchor (number, testimonial, screenshot, result)
- An honest take on the audience's primary objection
- **Strongly recommended:** `ccai-brand-voice` already run

No API keys. No scraping. No "swipe file" downloads. You bring the diagnosis; the skill writes the copy.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-sales-copy ~/.claude/skills/ccai-sales-copy
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-sales-copy
```

Or *"write me a landing page hero for X"* / *"give me 10 headlines for the Skool launch ad."*

The skill will:
1. Ask the 3 diagnostic questions (awareness stage, asset type, brief)
2. Restate the diagnosis and the framework it'll use, wait for your confirmation
3. Generate the copy
4. Run the 5-point conversion check
5. Save to `copy/YYYY-MM-DD-NN-slug.md` with frontmatter

---

## Supported asset types

| Asset | What it includes |
|---|---|
| **Landing hero** | Headline + subhead + body + CTA + sub-CTA |
| **Short ad** | 90-char primary + 30-char headline + 30-char description × 3 variants |
| **Email** | Subject line + pre-header + body (250-500 words) + single CTA |
| **VSL outline** | Section-by-section outline (not full script, pro version handles the 21-step VSL) |
| **Sales page section** | One specific section (FAQ, about-the-offer, risk reversal, etc.) |
| **Headlines batch** | 10 variants across 4+ angles for A/B split testing |

For full long-form sales pages (11-panel) and 21-step VSLs, see `ccai-sales-copy-pro` (coming).

---

## The 5 frameworks

Defined in detail in [`templates/FRAMEWORKS.md`](templates/FRAMEWORKS.md). Quick reference:

- **AIDA** (Attention → Interest → Desire → Action), best for problem-aware
- **PAS** (Problem → Agitation → Solution), best for solution-aware shopping for fixes
- **BAB** (Before → After → Bridge), best when you have a vivid contrast
- **FAB** (Features → Advantages → Benefits), best for product-aware comparing options
- **OATH** (Oblivious → Apathetic → Thinking → Hurting), diagnostic, matches tone to reader state

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`templates/FRAMEWORKS.md`](templates/FRAMEWORKS.md) | The 5 framework references |
| [`templates/SALES_ASSET.md`](templates/SALES_ASSET.md) | Output schema |
| [`examples/sample-landing-hero.md`](examples/sample-landing-hero.md) | A landing-hero example using PAS |
| [`examples/sample-headlines-batch.md`](examples/sample-headlines-batch.md) | A 10-headline batch with testing plan |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Can it write a full long-form sales page?**
The free version writes sections of one. Pro version writes the full 11-panel page and the 21-step VSL.

**What if I don't know the awareness stage?**
The skill walks you through 3 quick questions to figure it out. Most people guess wrong on first try, the questions usually correct that.

**Can it write copy that sounds urgent?**
Yes, but the skill refuses to write fake urgency. "Doors close Friday" works *if doors actually close*. "Only 3 spots left" is dead unless it's literally true. If you want urgency without honest reasoning, you'll need a different tool.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-sales-copy ~/.claude/skills/ccai-sales-copy

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
