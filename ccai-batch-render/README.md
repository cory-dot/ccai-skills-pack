# ccai-batch-render

> CSV → many videos. Bridge between a `ccai-video-editor` Remotion template and a spreadsheet of variants. Produces one MP4 per row.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-batch-render`
**Status:** v0.1 · Tier C · works with Claude Code

---

## What it does

Companion to `ccai-video-editor`. If that skill is "videos in code," this skill is "videos from a spreadsheet."

You have:
1. A Remotion template (from `ccai-video-editor`)
2. A CSV with N rows of variant data

This skill generates the orchestration script that walks the CSV, renders one video per row, names them sensibly, logs successes/failures, and produces a clean output folder.

Real use cases:
- 50 personalized intro videos for sales outreach
- 100 ad variants for a Meta A/B test
- 200 templated reels for affiliate partners
- 500 product-specific demo videos from an inventory CSV

## What's in the box

- `scripts/batch-render.ts`, the orchestration script (generated)
- `data/variants.csv`, where you put your CSV
- `out/`, rendered MP4s land here
- `out/_render-log.md`, per-row success/failure log

Failed rows don't stop the batch. Renders that already exist get skipped (use `--overwrite` to re-render).

## Prerequisites

- `ccai-video-editor` already ran (Remotion project exists)
- A CSV with one row per variant
- CSV columns match the template's variant props

## Install

```bash
git clone https://github.com/cory-dot/ccai-batch-render ~/.claude/skills/ccai-batch-render
```

## Usage

```
/ccai-batch-render
```

The skill verifies the Remotion project + CSV, maps columns, generates the render script, estimates wall-time and disk space, then offers to run.

## Performance + limits

Sequential rendering on a typical laptop:
- Simple 5-second video: ~8 seconds per render
- 30-second reel: ~25-40 seconds per render
- Complex composition: 1-2 minutes per render

Math:
- 50 videos × 8s = ~7 minutes
- 100 reels × 30s = ~50 minutes
- 500 videos × 1 min = ~8 hours (you'll want Lambda for this, pro version)

## Pro version

`ccai-batch-render-pro` (planned):
- Remotion Lambda integration (100s of parallel renders in the cloud)
- Direct CDN upload after each render (Cloudflare R2 / S3)
- Cost estimation per batch (Lambda pricing)
- Failure auto-retry with exponential backoff
- Slack notification on completion

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (32 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-batch-render ~/.claude/skills/ccai-batch-render

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
