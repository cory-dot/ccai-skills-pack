# ccai-ugc-video-ads

> 5 UGC-style video ad concepts from a product brief. Each uses a different proven UGC archetype (discovery confession, problem-fixed reaction, honest comparison, insider tip, before/after). Full creator brief — script, on-screen text plan, shot list, persona.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-ugc-video-ads`
**Status:** v0.1 · Tier B · works with Claude Code

---

## What it does

UGC video ads consistently outperform polished branded creative on Meta and TikTok for small-business spend. But producing them is hard: brief creators well, get the right energy, structure the on-screen text.

This skill produces the *brief* for 5 distinct UGC concepts — one per archetype:
1. **Discovery confession** — "I just figured out..."
2. **Problem-fixed reaction** — "I almost gave up, then..."
3. **Honest comparison** — "I tested all of these..."
4. **Insider tip / hack** — "My friend in [industry] told me..."
5. **Before/after transformation** — visual-first

For each concept, the output includes:
- Spoken hook (first 3 sec)
- Full voiceover script (15-60 sec depending on platform)
- On-screen text overlay plan with timestamps
- Shot list (5+ shots per concept)
- Creator persona spec (age, vibe, wardrobe, location)
- Audio direction (trending sound or not, background music, SFX)
- Estimated production cost ($50-500 per video)

## Why this skill is different from "give me 5 ad scripts"

1. **5 archetypes enforced.** No two concepts use the same UGC structure. Diversity is the point.
2. **Creator-briefable.** Hand the file to a UGC creator on Backstage or Billo and they can film it without follow-up.
3. **Refuses fake testimonials.** Won't write "I cried when..." unless mapped to a real benefit. No performative emotion.
4. **Honest production costs.** $50-500 per video is the real range. Doesn't promise unrealistic prices.
5. **Trending-sound aware.** Recommends trending sound categories, never specific copyrighted tracks.

## What you need

- A product/offer to advertise
- Budget for creator(s): $100-500 per video typical
- OR Higgsfield account (pro version auto-generates videos from the brief)
- `BRAND_VOICE.md` strongly recommended for on-brand voiceovers

## Install

```bash
git clone https://github.com/cory-dot/ccai-ugc-video-ads ~/.claude/skills/ccai-ugc-video-ads
```

## Usage

```
/ccai-ugc-video-ads
```

Or *"5 UGC ad concepts for [product]."*

## Pro version

`ccai-ugc-video-ads-pro` (planned):
- Higgsfield MCP integration — auto-generate videos from the brief
- TikTok API for trending-sound auto-detection
- Direct Meta upload via API
- A/B variant generation

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (32 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-ugc-video-ads ~/.claude/skills/ccai-ugc-video-ads

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
