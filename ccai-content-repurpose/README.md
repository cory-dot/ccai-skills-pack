# ccai-content-repurpose

> One source. Many formats. Format-native adaptation that preserves the insight without copy-pasting.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-content-repurpose`
**Status:** v0.1 · works with Claude Code

---

## What it does

You wrote one good script. Now you want it on LinkedIn, in your newsletter, as a Twitter thread, and as a carousel. The lazy way is to paste it everywhere with minor edits. The audience notices and tunes out.

This skill does the opposite: it extracts the **one load-bearing insight** from your source content, then produces format-native adaptations for each platform — different hook, different structure, different rhythm — while keeping the proof anchor consistent so the brand stays coherent.

Supported target formats:
- **LinkedIn post** (150–250 words, no hashtags)
- **Twitter/X thread** (5–10 tweets, opening tweet works standalone)
- **Email newsletter** (300–500 words, single CTA)
- **Carousel** (5–8 slides, one idea per slide)
- **Reel/Short script** (delegates to `ccai-video-script` if available)
- **Blog post** (600–900 words, SEO-friendly)

---

## Why it's different from "rewrite this for LinkedIn"

1. **Step 2 is the whole game.** Before any output, the skill explicitly extracts the load-bearing claim, proof anchor, and audience aha — then asks you to confirm. Bad extraction = bad repurposing. The skill won't move forward until the foundation is right.
2. **Format-native rules, not template-fill.** A LinkedIn post isn't "the script with line breaks." Each format has its own hook style, length budget, and CTA pattern enforced by the skill.
3. **De-repetition pass at the end.** After all formats are drafted, the skill checks: is the same hook used in 3+ places? Same ending? Same phrasing? If yes, it varies them. Someone who follows you on 3 platforms shouldn't get the same content 3 times.
4. **Recommended posting cadence.** The output includes a 5-day posting calendar. Same-day cross-posting fatigues your audience; staggered posting compounds.

---

## What you need

- Claude Code installed
- A source — a script, transcript, blog post, email, or just a topic from `CONTENT_IDEAS.md`
- **Strongly recommended:** `ccai-brand-voice` already run

No downloads, no transcription, no APIs. You bring the source text; the skill multiplies it.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-content-repurpose ~/.claude/skills/ccai-content-repurpose
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-content-repurpose
```

Or *"turn this script into a LinkedIn post and a Twitter thread"* / *"repurpose [file path] across all formats."*

The skill will:
1. Read the source (file path, paste, or `CONTENT_IDEAS.md` reference)
2. Extract the core insight + proof anchor + audience aha (and confirm with you)
3. Ask which formats you want (default: LinkedIn + Twitter + Email)
4. Generate each format with its native rules
5. Run de-repetition pass across all outputs
6. Save to `repurposed/YYYY-MM-DD-source-slug/` (one file per format)
7. Suggest a posting cadence

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`templates/REPURPOSE.md`](templates/REPURPOSE.md) | Output schema with cadence calendar |
| [`examples/sample-repurposed-batch.md`](examples/sample-repurposed-batch.md) | One source repurposed to 4 formats — LinkedIn, Twitter thread, Email, Carousel |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Can I repurpose a video URL?**
Not in the free version. Transcribe first (using your tool of choice — Descript, Otter, etc.), paste the transcript, then run this skill. The pro version (`ccai-content-repurpose-pro`) handles auto-transcription via yt-dlp + Whisper.

**How do I keep formats from sounding identical?**
The skill runs an explicit de-repetition pass — but it works best when you have `BRAND_VOICE.md` set up, because different format adaptations sound natural in your voice rather than mechanical.

**What's the right cadence to publish?**
The output suggests a Mon-Fri spread. The full week posting cadence (one format per day) outperforms same-day cross-posting in nearly every audience study.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-content-repurpose ~/.claude/skills/ccai-content-repurpose

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai) — our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
