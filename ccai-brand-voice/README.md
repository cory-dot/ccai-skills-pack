# ccai-brand-voice

> Capture your authentic writing/speaking voice into a structured `BRAND_VOICE.md` other CCAI skills read from automatically.

**Slash command:** `/ccai-brand-voice`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most AI-generated content sounds generic because the AI has no idea what *you* sound like. This skill fixes that.

You feed it 5–15 samples of your own content (transcripts, written posts, emails — anything). It analyzes those samples across 7 dimensions and produces a single `BRAND_VOICE.md` file in your working directory. From that point on, every other Creative Core AI skill that writes for you — scripts, captions, sales copy, repurposing — reads from that file and writes in your voice.

It's the foundational skill in the Creative Core AI stack. **Install this one first.**

---

## Why it's different from "use AI to write a brand voice doc" prompts

Most brand voice prompts ask the AI to make adjectives ("punchy, direct, warm"). Adjectives don't translate into output the AI can actually mimic.

This skill is built on a stricter rule: **every observation in the doc must be backed by a verbatim quote from your real content.** No "punchy and direct" — instead, the actual sentence you wrote that demonstrates what punchy means *for you specifically*. Other skills can then match that pattern rather than guessing what "punchy" means in your context.

It also runs a mandatory validation loop at the end: the skill writes 3 short test samples in the voice it captured, and you have to confirm they sound like you before the skill considers the task done. If they don't, it iterates.

---

## What you need

- Claude Code installed (`@anthropic-ai/claude-code`)
- 5–15 samples of your own content. Mix of:
  - At least one written sample
  - At least one spoken sample (transcript)
  - Variety of contexts: explaining, selling, casual, formal
- Five minutes to read the test samples and approve or correct them

You **don't** need: video downloaders, transcription services, API keys, or any external services. If you only have video URLs, transcribe them first using whatever tool you prefer, then paste the transcripts.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-brand-voice ~/.claude/skills/ccai-brand-voice
```

Then restart Claude Code or run `/doctor` to confirm the skill loaded.

---

## Usage

In your project directory, type:

```
/ccai-brand-voice
```

…or just say something like *"capture my brand voice"* or *"make AI sound like me"* and Claude Code will load this skill automatically.

The skill will:
1. Ask you for content samples
2. Analyze them across 7 dimensions (identity, vocabulary, cadence, hook patterns, energy register, structural tells, taboos)
3. Write `BRAND_VOICE.md` to your working directory
4. Generate 3 test samples in your voice and ask you to approve them
5. Iterate until you sign off

---

## Output

A single `BRAND_VOICE.md` file in your working directory. See [`examples/sample-brand-voice.md`](examples/sample-brand-voice.md) for the level of detail it produces.

Other Creative Core AI skills will automatically read this file when they run in the same directory:

- `ccai-video-script` — writes reels and shorts in your voice
- `ccai-content-repurpose` — turns one post into many formats while keeping your voice
- `ccai-sales-copy` — writes long-form copy in your voice
- `ccai-carousel-builder` — builds carousels in your voice
- `ccai-content-ideas` — generates ideas calibrated to your taboos and patterns

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill instructions Claude Code follows |
| [`templates/BRAND_VOICE.md`](templates/BRAND_VOICE.md) | Blank template Claude fills in |
| [`examples/sample-brand-voice.md`](examples/sample-brand-voice.md) | A fully-filled example showing the bar of detail |
| [`LICENSE`](LICENSE) | MIT |

---

## Re-running the skill

Your voice evolves. Plan to re-run this skill:

- After publishing 10+ new pieces of content
- After a major brand/positioning shift
- If other CCAI skills start producing output that doesn't sound like you anymore
- At least once a year

When you re-run it in a directory that already has `BRAND_VOICE.md`, the skill will ask whether to **refine** the existing doc or **rebuild from scratch**.

---

## FAQ

**Can I run this for multiple brands (e.g. my personal voice + a client's voice)?**
Yes. Run it in separate working directories. Each directory gets its own `BRAND_VOICE.md`. Other skills read whichever one is in their current directory.

**My samples are all videos. Do I need to transcribe them first?**
Yes. This skill deliberately doesn't try to download or transcribe videos — too many failure modes, too many external dependencies. Use whatever transcription tool you prefer (Descript, Otter, OpenAI Whisper locally, etc.) and paste the text.

**How many samples is "enough"?**
Five minimum, 8–15 ideal. If you give it 5, the resulting doc will be marked "preliminary" and you'll want to re-run after adding more content.

**The doc captured a phrase I don't actually like. Can I edit `BRAND_VOICE.md` directly?**
Yes — it's a markdown file. Edit it freely. Just keep the section headings intact so other CCAI skills can read it.

---

## Part of the Creative Core AI skills pack

This is one of ~33 skills in the [Creative Core AI skills pack](https://github.com/cory-dot/ccai-skills-pack). The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai).

---

## License

MIT. Use it commercially, fork it, modify it — just don't claim you wrote it.
