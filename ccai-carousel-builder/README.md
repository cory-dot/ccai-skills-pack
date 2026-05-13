# ccai-carousel-builder

> Build Instagram and LinkedIn carousels that actually get swiped through, not just saved-and-forgotten on slide 1.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-carousel-builder`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most "AI carousel builders" produce 10 slides with a paragraph each. That's not a carousel, it's a slideshow no one swipes.

This skill is built around the four rules that actually drive carousel engagement:

1. **Slide 1 is the only slide most readers see.** Hook it like it's standalone.
2. **One idea per slide. Maximum.** Two ideas = guaranteed scroll-past.
3. **Each slide must promise the next.** Cliffhanger structure throughout.
4. **The last slide is a CTA, not a summary.**

Output is a full carousel breakdown, slide copy, visual direction, on-screen text styling, plus a separate caption for the post body, a design notes section for whoever's building it in Canva, and a swipe-friction check log that audits each transition.

---

## Why it's different

1. **Slide-by-slide structure with explicit roles.** Hook → Setup → Body × N → Payoff → CTA. No more "8 slides, all about the same thing."
2. **Swipe-friction check on every output.** Density audit (word count cap), promise chain (does each slide make me swipe?), CTA specificity. Skill won't ship a carousel that fails these checks.
3. **Reads source content if you have it.** Already wrote a script or post? Skill pulls the load-bearing claim and proof anchor from it rather than starting from scratch.
4. **Separate caption generation.** The caption is its own asset, different hook angle than slide 1, so cross-feed exposure doesn't feel redundant.
5. **Respects BRAND_VOICE.md taboos.** No emoji if you don't use emoji. No hype words.

---

## What you need

- Claude Code installed
- A topic or source content (script, post, article)
- **Strongly recommended:** `ccai-brand-voice` already run

No image generation, no Canva integration, the skill produces the *blueprint*. You (or your designer) build the actual slides in Canva, Figma, or whatever tool. The skill outputs slide copy + visual direction precise enough to hand off.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-carousel-builder ~/.claude/skills/ccai-carousel-builder
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-carousel-builder
```

Or *"build a carousel about X"* / *"turn this post into a carousel."*

The skill will:
1. Ask the brief (platform, topic, source, slide count, CTA)
2. Read your voice + hook library if available
3. Generate slide-by-slide breakdown with visual direction
4. Run the 4-point swipe-friction check
5. Generate a separate caption for the post body
6. Output design notes for the Canva build
7. Save to `carousels/YYYY-MM-DD-NN-slug.md`

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`templates/CAROUSEL.md`](templates/CAROUSEL.md) | Slide-by-slide schema |
| [`examples/sample-carousel.md`](examples/sample-carousel.md) | Filled 8-slide Instagram carousel example |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Does this make the actual images?**
No. It produces the blueprint (copy + visual direction). The build happens in Canva, Figma, or your editor of choice. This is intentional, image generation for carousels is a separate problem (typography, brand consistency, design system) that's much better handled by a designer or a dedicated design tool.

**What about LinkedIn document posts (the "PDF carousel" format)?**
Same rules apply. Output is identical, the only difference is aspect ratio in the design notes (1200×1500 vs 1080×1080).

**Word count limit per slide?**
15 words max for Instagram, 25 max for LinkedIn. The skill enforces this.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-carousel-builder ~/.claude/skills/ccai-carousel-builder

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
