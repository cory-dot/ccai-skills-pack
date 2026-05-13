# ccai-video-editor

> Programmatic video editing via Remotion. Generate 1 or 1,000 video variants from a React-based template. Free tier, pro adds AI voice + image generation.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-video-editor`
**Status:** v0.1 · Tier C · works with Claude Code

---

## What it does

[Remotion](https://www.remotion.dev/) is "videos in React", your video is a function from frame number to JSX, with text, animation, audio sync, and transitions all in code.

This skill makes Remotion accessible without learning the framework: it generates the project scaffold + composition components for 5 video patterns, and you customize from there.

## When this is the right tool

- **Templated videos at scale.** Same structure, 50 variants for an A/B test
- **Personalized intros.** "Hi [name]" intros for sales outreach
- **Data-viz videos.** Animated charts for monthly recaps
- **Carousel-to-video.** Slides into a single MP4 with auto-pacing

## When this is NOT the right tool

- One-off hero brand video → hire an editor / use Premiere
- Heavy motion graphics → After Effects
- Interview / documentary edit → not the right tool

This skill specifically earns its place when you need *many* videos that share a template structure.

## The 5 template types

1. **Reel/Short**, 15-60sec vertical, hook/body/CTA
2. **Ad variants**, designed for batch generation, single template + variant data array
3. **Personalized intro**, 5-15sec custom intros per recipient
4. **Carousel-to-video**, slides → video with auto-paced reveals
5. **Data-viz video**, animated numbers/charts

## What you need

- Node.js v20+
- A specific scaled-video use case (not "let's make a video", that's `ccai-video-script`)
- Audio files (voiceover, background music), user-provided, no copyrighted tracks

## Install

```bash
git clone https://github.com/cory-dot/ccai-video-editor ~/.claude/skills/ccai-video-editor
```

## Usage

```
/ccai-video-editor
```

The skill walks through template selection → scaffold → composition generation → variant data → render commands.

## Example output

See [`examples/sample-video-project.md`](examples/sample-video-project.md), full walk-through of producing 50 Meta ad variants in 30 minutes, including upload-and-launch.

## Pro version

`ccai-video-editor-pro` (planned):
- ElevenLabs MCP for AI voiceover
- Replicate MCP for AI image / B-roll generation
- Cloud rendering on Remotion Lambda
- Auto-upload to Meta/TikTok/YouTube via APIs

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (32 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-video-editor ~/.claude/skills/ccai-video-editor

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
