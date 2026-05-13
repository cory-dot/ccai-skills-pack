---
name: ccai-carousel-builder
description: Builds Instagram and LinkedIn carousels — slide-by-slide structure with visual direction, swipe-friction pacing rules, and brand-voice calibration. Defaults to 8 slides but adapts to source content density. Use when the user asks for a carousel, swipe post, multi-slide post, or wants to turn one idea into a multi-slide visual story.
when_to_use: User mentions carousel, swipe post, slides, Instagram multi-slide, LinkedIn carousel, "make this into slides," or asks to break an idea into visual chunks.
argument-hint: "[topic or source content]"
---

# CCAI Carousel Builder

Build carousels that actually get swiped through — not just saved-and-forgotten on slide 1.

## Output contract

Each carousel is saved as `carousels/YYYY-MM-DD-NN-slug.md` in the working directory. The file contains:
- Frontmatter (platform, slide count, hook pattern, source, generated date)
- Slide-by-slide breakdown with copy + visual direction
- Swipe-friction analysis log
- Recommended caption (for the post itself, not the slides)

## Inputs the skill reads (if present)

- `BRAND_VOICE.md` — voice + taboos
- `HOOK_LIBRARY.md` — slide 1 hook patterns
- `CONTENT_IDEAS.md` — if carousel is for an idea in the radar

## The 4 carousel rules

1. **Slide 1 is the only slide most readers see.** Treat it as a standalone hook. If slide 1 doesn't make them swipe, the rest doesn't exist.
2. **One idea per slide. Maximum.** Two ideas on a slide is a guaranteed scroll-past.
3. **Each slide must promise the next.** Implicit or explicit cliffhanger structure. If slide 4 wraps neatly, no one reaches slide 5.
4. **The last slide is a CTA, not a summary.** "And that's how!" is a wasted slide. Replace with a specific action.

## Process

### Step 1 — Brief

Ask for:
1. **Platform** — Instagram (square 1080×1080 or 1080×1350) / LinkedIn (1200×1500) / both?
2. **Topic** — what's the carousel about? One sentence.
3. **Source** — written content the user has? Path to a script/post/article? Or generating from scratch?
4. **Slide count target** — default 8 (Instagram sweet spot). LinkedIn can go up to 10. Tell the user the default if unspecified.
5. **CTA** — what action do they want from the final slide? (Save, share, link in bio, comment a keyword, follow.)

### Step 2 — Read context

If `BRAND_VOICE.md` exists: respect taboos (especially "no emoji" if applicable).
If `HOOK_LIBRARY.md` exists: pull a hook pattern that matches the topic.
If source content (path) was provided, read it and extract:
- The single load-bearing claim
- The 3-5 supporting points
- The strongest proof anchor

### Step 3 — Generate slide-by-slide

Use the **Hook → Setup → Body → Payoff → CTA** structure across the slide count.

For an 8-slide carousel, the budget is:
- Slide 1 = **HOOK** (pattern from HOOK_LIBRARY or HOOK_PATTERNS)
- Slide 2 = **SETUP** (set the stakes — what they get if they swipe through)
- Slides 3-6 = **BODY** (one idea per slide; 4 ideas total)
- Slide 7 = **PAYOFF** (the takeaway, the "now what")
- Slide 8 = **CTA** (one specific action)

For shorter (6-slide) or longer (10-slide) carousels, expand/contract the body. Hook/setup/payoff/CTA always stay.

Each slide output format:

```
**Slide N — [role]**
Copy: [the actual text on the slide — max 12-15 words]
Visual direction: [what the slide should look like; key visual element]
On-screen text style: [headline size, body, accent]
```

### Step 4 — Swipe-friction check

After all slides are drafted, run these checks:

**Friction check 1 — Slide 1 standalone test**
Read slide 1 aloud. If it sounds like a complete thought, kill it and rewrite. Slide 1 must create curiosity, not satisfaction. Test: would a reader have an unanswered question after slide 1? If no, fix.

**Friction check 2 — Density audit**
Count words per slide. If any slide exceeds 15 words for IG (or 25 for LinkedIn), it's too dense. Split into two slides or cut.

**Friction check 3 — Promise chain**
Read slides in order. Between each pair, ask: "what makes this reader swipe right now?" If you can't answer for any transition, that's a leak. Strengthen the cliffhanger or kill the slide.

**Friction check 4 — Last slide CTA test**
Is the last slide a specific action? "Follow for more" is dead. "Save this and steal the structure" works. "DM me 'Claude' for the full guide" works. Replace generic CTAs with specific ones.

### Step 5 — Write the caption

The caption (the actual post text below the carousel) is separate from the slide copy. Generate a caption that:
- Opens with a 1-line standalone hook (won't compete with slide 1's hook — use a different angle)
- ~80-150 words for IG, ~150-250 for LinkedIn
- One specific CTA at the end
- No hashtags unless BRAND_VOICE.md says to use them

### Step 6 — Save

Write to `carousels/YYYY-MM-DD-NN-slug.md`. Summarize:

> *"Carousel saved to carousels/X. [N] slides, hook pattern: [Y]. Estimated time to design in Canva: ~30 min. Want me to tighten any slide or generate alt versions of slide 1?"*

## Hard rules

- **No "Slide 1" reading like "Here's a list of..." or "5 things..."** That's not a hook, it's a table of contents. Hooks create swipe momentum; tables of contents kill it.
- **No more than 15 words on any IG slide.** Period.
- **No emoji-heavy slides** unless BRAND_VOICE.md establishes emoji as on-brand.
- **No "Save this for later" CTA** unless paired with something specific to save *for*. "Save this for next time you write a sales page" is fine. "Save this!" is not.
- **Respect BRAND_VOICE.md taboos absolutely.**

## Reference files

- `templates/CAROUSEL.md` — slide schema with visual direction structure
- `examples/sample-carousel.md` — an 8-slide example

## Anti-patterns to avoid

- Slide 1 being a numbered list teaser ("5 ways to..."). Generic; reader has seen 1,000 of these.
- Conclusion slides ("So in summary..."). The carousel is the summary. Skip.
- Multiple CTAs at the end ("Follow + save + share + DM me"). Pick one.
- Cramming a paragraph onto a single slide because "we have the screen space." Real-readability beats screen-fill every time.
- Generating without reading the source. If user has a script/post/article, the carousel should pull from it, not start from scratch.
