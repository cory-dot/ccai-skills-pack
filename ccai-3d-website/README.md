# ccai-3d-website

> Add 3D animated hero sections / product viewers to your ccai-website-builder-setup project. Three.js + react-three-fiber (or Spline). Generates the component code; you provide the 3D asset.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-3d-website`
**Status:** v0.1 · Tier C · works with Claude Code

---

## What it does

Generates the React component code that integrates a 3D scene into your Next.js project. 4 section types:

1. **Hero with 3D background** — slowly-rotating object behind your headline
2. **Product viewer** — interactive 360° viewer with click-drag controls
3. **3D background** — subtle decorative scene for any section
4. **Object rotator** — small 3D accent next to text

You provide the 3D asset (GLB / GLTF / Spline / Gaussian Splat). The skill writes the component, handles lazy-loading, mobile fallback, and accessibility.

## What it WON'T do (be honest)

- Generate 3D models from photos (that's pro)
- Optimize your GLB files automatically (it tells you to run gltfpack)
- Make your site faster (3D adds 1-3s to LCP — real trade-off)
- Work in SSR (Three.js can't render server-side — skill handles the `next/dynamic` pattern)

## Prerequisites

- `ccai-website-builder-setup` already ran
- A 3D asset OR a plan to get one:
  - **Quickest:** [Spline](https://spline.design) — free, no-code, 1-day learning curve
  - **Most flexible:** Blender (free, steep)
  - **Hire:** Fiverr / Cara.app — $50-300 for a simple branded 3D object
  - **Ambient:** [Sketchfab CC0 collection](https://sketchfab.com/3d-models/cc0)

## Install

```bash
git clone https://github.com/cory-dot/ccai-3d-website ~/.claude/skills/ccai-3d-website
```

## Usage

```
/ccai-3d-website
```

The skill walks you through section choice → dependency install → asset provision → component generation → performance audit.

## Performance honesty

3D on the web has real costs:
- **+600KB** bundle from Three.js (even with code-splitting)
- **+1-3 seconds LCP** depending on model size
- **Mobile-low-power throttling** — must have a fallback path

The skill enforces:
- Always lazy-load (next/dynamic)
- Always have a reduced-motion fallback (still image)
- Always warn about LCP impact

If your audience is mobile-heavy + speed-sensitive (e-commerce especially), the skill may recommend skipping 3D entirely.

## Pro version

`ccai-3d-website-pro` (planned):
- Auto-generate Spline scenes from product photos
- Auto-optimize GLB files (gltfpack integration)
- Gaussian Splat web compression
- A/B testing static vs 3D conversion

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (32 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-3d-website ~/.claude/skills/ccai-3d-website

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
