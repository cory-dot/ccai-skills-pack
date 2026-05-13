---
name: ccai-content-repurpose
description: "Takes one piece of content (transcript, post, article, email, video script) and adapts it into multiple target formats, LinkedIn post, Twitter/X thread, email newsletter, carousel, short-form video script, blog post, all calibrated to the user's brand voice. Preserves the load-bearing insight while restructuring for each platform's medium. Use when the user has one piece of content and wants to multiply it across channels without sounding repetitive."
when_to_use: "User mentions repurpose, multiply content, content for multiple platforms, adapt this for X, turn this reel into a post, \"make this work for LinkedIn,\" or asks to break one piece into smaller pieces."
argument-hint: "[path to source content or target formats]"
---

# CCAI Content Repurpose

One source of content. N target formats. Preserves the insight, restructures the delivery.

## Output contract

Repurposed outputs are written to `repurposed/` in the working directory:

```
repurposed/YYYY-MM-DD-source-slug/
├── linkedin.md
├── twitter-thread.md
├── email.md
├── carousel.md
├── reel-script.md
└── blog.md
```

Only the formats the user requests are generated. Each file is self-contained.

## Inputs the skill reads (if present)

- `BRAND_VOICE.md`, voice calibration is non-negotiable; every output must respect taboos and cadence
- `HOOK_LIBRARY.md`, different format = different hook style; this provides options per format
- `COMPETITOR_RADAR.md`, Steal verdicts may suggest format choices to prioritize

## Process

### Step 1, Get the source

Ask for one of:
- A path to a file in the project (e.g. `scripts/2026-05-12-01-claude-plan-comparison.md`)
- Pasted text (transcript, post, email, article)
- A topic/idea that already exists in `CONTENT_IDEAS.md` (will be expanded then repurposed)

**Do not try to fetch URLs or download videos.** If the user only has a video URL, ask them to transcribe first.

### Step 2, Extract the core insight

Read the source. Identify:
1. **The single load-bearing claim**, what's the ONE thing this content is asserting? One sentence.
2. **The proof anchor**, the specific number, story, screenshot, or example that makes the claim land
3. **The audience aha**, what shifts in the reader/viewer's head if they accept the claim?
4. **Anything format-specific worth preserving**, a visual joke, a quoted line, a structural punchline

Show the user this extraction in 4 lines and ask: *"Is this the load-bearing insight, or am I missing something?"* Wait for confirmation before generating.

### Step 3, Ask which formats

Default formats supported:
- **LinkedIn post** (150–250 words, professional, no hashtags)
- **Twitter/X thread** (5–10 tweets, casual, threaded)
- **Email newsletter** (300–500 words, conversational, one clear CTA)
- **Carousel** (5–8 slides, sparse text, one idea per slide)
- **Reel/Short script** (45–60 sec, two-column format if `ccai-video-script` template exists)
- **Blog post** (600–900 words, SEO-friendly, with H2/H3 structure)
- **Newsletter teaser tweet** (single tweet promoting the newsletter)

Ask: *"Which formats? Default is LinkedIn + Twitter + Email if you don't specify."*

### Step 4, Generate each format

For each requested format, follow its specific rules:

#### LinkedIn rules
- 2-sentence opener (contrarian reframe of the topic preferred)
- Single-line breaks between every paragraph
- No hashtags (unless BRAND_VOICE.md explicitly says use them)
- One CTA at end, format: "[Action verb] [link]." Plain. No "Don't miss out."
- 150–250 words max

#### Twitter/X thread rules
- Opening tweet = the hook (must work standalone, 80%+ of readers won't read the thread)
- Each subsequent tweet adds ONE idea, ONE example, or ONE clarification
- 5–10 tweets, each under 280 chars
- Last tweet = CTA + (optional) link
- Number tweets only if there's a meaningful sequence (1/, 2/, 3/...)

#### Email rules
- Subject line = 6–9 words, ideally curiosity-gap or specific-promise
- Pre-header = 1 sentence amplifying the subject
- Body opens with a one-line scene/observation, not "Hi friends!"
- 300–500 words
- ONE CTA, button-style: `[Read the full guide →](link)`
- Signoff matches BRAND_VOICE.md sign-off pattern if defined

#### Carousel rules
- Slide 1 = the hook (just the hook, big text, nothing else)
- Slides 2–6 = one idea per slide, ~12 words max per slide
- Slide 7 = the takeaway/payoff
- Slide 8 = CTA + handle
- Output format: numbered slides with `**Slide N:** text` + visual direction note

#### Reel/Short rules
- Defer to `ccai-video-script` if available, invoke it as a sub-task
- If not available, produce a two-column script (spoken / visual) following the same rules as `ccai-video-script`

#### Blog rules
- H1 = a search-friendly version of the topic (8–14 words)
- 2-sentence opener that promises the payoff
- H2/H3 structure with 3–5 H2 sections
- Each H2 ~150–200 words
- TL;DR box at top
- 1–2 internal-link placeholders for related content
- CTA at the end (Skool + diagnostic, matching the article template)

### Step 5, De-repetition pass

After all formats are drafted, run a cross-format check:
- **Same hook used in 3+ formats? Vary it.** Each format should have a different opener, even if the core insight is the same.
- **Same proof anchor stated identically?** Rephrase. Use different framings.
- **All endings identical?** Diversify CTAs. Email gets one CTA, Twitter gets a different one, LinkedIn a third.

The goal: someone who follows the user across 3 platforms shouldn't get the exact same content 3 times. Same *insight*, different *delivery*.

### Step 6, Save and summarize

Write each format to its respective file under `repurposed/YYYY-MM-DD-source-slug/`. Summarize for the user:

> *"Repurposed [source] into [N] formats. Files saved to `repurposed/[folder]`. Estimated time-to-publish across all formats: [estimate]. Want me to tighten any one?"*

## Hard rules

- **One source, many formats, never invert.** Don't try to repurpose 5 pieces into 1 mega-piece. That's content compilation, different skill.
- **Preserve the proof anchor across formats.** The specific number, story, or claim must be present in every format. Without the anchor, the formats are abstract noise.
- **Format-native, not lazy-copy.** A LinkedIn post is not "the reel script with line breaks." Each format has its own rules; respect them.
- **Respect BRAND_VOICE.md taboos in every format.** A taboo on emoji applies to the carousel too.
- **One CTA per format.** Two = none.

## Reference files

- `templates/REPURPOSE.md`, output schema
- `examples/sample-repurposed-batch.md`, a filled example showing one source repurposed to 4 formats

## Anti-patterns to avoid

- Producing 6 versions of essentially the same paragraph. Each format must adapt structurally, not just visually.
- Skipping Step 2 (extract the core insight). The whole skill rests on a clean extraction. Lazy extractions produce mush.
- Adding "Click here for more!" to every format. Boring and lowers conversion. Plain action verbs.
- Recommending the user "post all 6 today." Spread them out, same-day cross-post fatigues the audience. Default suggestion: 1 format per day across a week.
