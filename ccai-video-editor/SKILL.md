---
name: ccai-video-editor
description: Programmatic video editing using Remotion — generates React components that render videos with text overlays, transitions, and audio sync. Use when you need to produce variations of the same video at scale (e.g., 50 customer-specific intro variants, 10 ad creative A/B tests, 100 templated reels). Free version generates the Remotion project + composition; pro version (planned) adds Replicate/ElevenLabs integration for AI voice + image generation.
when_to_use: User mentions Remotion, programmatic video, video templates, variant videos, scaled video production, "render 100 videos," text-overlay videos, or anything that suggests "I need many videos that look similar but vary in some specific way."
argument-hint: "[video purpose — reel-template / ad-variants / personalized-intro / etc.]"
---

# CCAI Video Editor

Programmatic video editing via Remotion. Generates the React composition code; you render the videos. Pro version adds AI asset generation.

## What Remotion is and why it's the right tool

[Remotion](https://www.remotion.dev/) lets you write videos in React. A video is a function from frame number to JSX. You can have on-screen text, animations, audio sync, transitions — all in code.

Why this matters for business owners:
- **Templated videos at scale.** Same template, 50 variants with different data per variant.
- **Source-controlled.** Your "video" is a Git-trackable React component.
- **No video editor learning curve.** If Claude Code can write React, it can write Remotion.

What it's NOT:
- A replacement for Final Cut / Premiere for one-off creative editing
- Photoshop/After Effects for hero-quality production
- Suitable for video where the creative changes per frame (motion graphics that are heavily designed)

It IS the right tool when you have a *template* and need to *scale* it.

## Prerequisites

- Node.js v20+
- Claude Code installed
- A specific video pattern in mind — not "let's make a video" but "I have data + a template structure I want to repeat"

This skill is NOT for "help me create a video idea." That's `ccai-video-script`.

## Output contract

Creates or updates a Remotion project in the working directory (or a subdirectory):

```
remotion-project/
├── src/
│   ├── Composition.tsx        # the main video component
│   ├── Root.tsx               # registers compositions
│   └── components/
│       ├── Hook.tsx           # opening section
│       ├── Body.tsx           # main content
│       └── Outro.tsx          # closing CTA
├── public/
│   ├── audio/                 # voiceovers, music
│   └── images/                # B-roll, screenshots
├── remotion.config.ts
├── package.json
└── README.md                  # render commands
```

## Process

### Step 1 — Choose template type

5 supported patterns:

1. **Reel/Short template** — 15-60sec vertical (1080×1920), hook + body + CTA structure
2. **Ad variant template** — 15-30sec, designed for batch variants (same structure, swap headline/proof/CTA per variant)
3. **Personalized intro** — 5-15sec intros customized per recipient (great for sales)
4. **Carousel-to-video** — turns slides into a video with auto-paced reveals
5. **Data-viz video** — animates numbers/charts (for monthly recap videos)

### Step 2 — First-run scaffold (if no Remotion project exists)

```bash
npx create-video@latest --template=remix
# then install dependencies
```

Followed by the skill writing the actual composition components on top of the scaffold.

### Step 3 — Generate the composition

For the chosen pattern, write:
- `Composition.tsx` — top-level video that orchestrates sections + timing
- Section components — Hook / Body / Outro
- Reads from `BRAND_VOICE.md` (taboos respected even in short text overlays)
- Reads from `STYLE_GUIDE.md` (typography + colors for text overlays)

### Step 4 — Data schema for variants

For ad-variant or personalized-intro templates, generate a `data.ts` file with the schema:

```typescript
export interface VideoVariant {
  headline: string;
  subheadline: string;
  proofNumber: string;
  cta: string;
  // ... per-template fields
}

export const variants: VideoVariant[] = [
  // user fills in
]
```

User adds rows to `variants[]`; rendering produces one video per variant.

### Step 5 — Rendering commands

Skill produces a `package.json` with scripts:

```json
"scripts": {
  "preview": "remotion preview",
  "render": "remotion render Composition",
  "render-all": "ts-node scripts/render-all.ts"
}
```

`render-all` iterates `variants[]` and produces one MP4 per variant.

### Step 6 — Verify
- Run `npm run preview` to confirm scene renders in browser
- Render a single variant to verify the MP4 output looks right
- Optimize if file size is large (Remotion has codec options)

## Hard rules

- **No fabricated voiceover.** Voiceovers must be user-provided MP3s OR explicitly stub'd. Pro version generates via ElevenLabs.
- **No copyrighted music.** Reference user-provided MP3s or free music libraries (Epidemic, Artlist).
- **Respect platform specs.** Reels = 1080×1920, TikTok same, YouTube Shorts same, Meta in-feed = 1080×1350. Wrong aspect ratio = failed delivery.
- **Bundled assets must be in `public/`.** Don't reference local-only paths.

## Pro version differences

`ccai-video-editor-pro` (planned):
- ElevenLabs MCP for AI voiceover generation
- Replicate MCP for AI image/B-roll generation
- Cloud rendering on Remotion Lambda
- Auto-upload to Meta/TikTok/YouTube via APIs

## Reference files
- `templates/REEL_COMPOSITION.tsx.md` — sample reel template
- `examples/sample-video-project.md` — full walk-through of a 50-variant ad render
