# ccai-3d-capture

> End-to-end Gaussian Splatting workflow — capture real objects/spaces in 3D using a smartphone, optimize for web, embed on your site. The "Gaussian Splatting business" playbook.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-3d-capture`
**Status:** v0.1 · Tier C · works with Claude Code

---

## What it does

Gaussian Splatting turns photo sets into photorealistic 3D scenes that render in browsers. A smartphone + 5 minutes can produce a usable splat. This skill is the playbook for doing that consistently — for your own products, spaces, or as a side business serving local real estate / e-commerce / hospitality clients.

The workflow covers:
1. **Define the capture** — subject type, size, lighting, final use case
2. **Recommend app + protocol** — Polycam vs Luma vs Postshot vs Brush, with specific shoot plans
3. **Pre-capture checklist** — what to clear, what to light, what to avoid
4. **Processing** — upload steps, time expectations, quality criteria
5. **Web optimization** — compress 50-500MB raw splats to <5MB for web delivery
6. **Integration** — embed in your `ccai-website-builder-setup` project via Three.js + Gaussian Splat library
7. **Client deliverable + invoice template** — if doing this as a service

## When this is the right tool

- Real product on your e-commerce site (premium look vs flat photo)
- Real estate listing 3D tour (Matterport alternative, much cheaper)
- Restaurant ambiance / venue capture
- Personal portfolio (sculpture, fashion, custom builds)
- Side business: $200-500 per local client capture

## When it's the wrong tool

- Reflective objects (glass, polished metal) — fuzzy results
- Transparent objects (acrylic, water) — algorithm struggles
- Moving subjects (animals, people not staying still) — Gaussian Splat needs static scene
- You need editable geometry — splats can't be modified, just rendered
- Tiny objects (under fist-size) — apps struggle with focal distance

## Apps supported

| App | Best for | Cost |
|---|---|---|
| Polycam | Products, vehicles | Free 5/mo · $20/mo unlimited |
| Luma AI | Spaces, large objects | Free (unlimited splats) |
| Postshot | Pro desktop pipeline | ~$200 one-time |
| Brush (Anthropic) | Claude-integrated workflows | Early-access |

## What you need

- iPhone 12+ or recent Android
- 5-15 minutes per capture
- One of the apps installed
- (Optional) A `ccai-website-builder-setup` site to embed the result into

## Install

```bash
git clone https://github.com/cory-dot/ccai-3d-capture ~/.claude/skills/ccai-3d-capture
```

## Usage

```
/ccai-3d-capture
```

The skill walks you through subject definition → app + protocol recommendation → shot plan → processing → web optimization → integration.

## The side-business angle

The course frames this as a $0-startup opportunity. Real numbers from running it:

- Local real estate agents: $200-500 per listing 3D tour
- E-commerce stores: $50-150 per product splat
- Restaurants: $300-800 per ambiance capture
- Wedding photographers: $500-1000 per venue capture (as a service add-on)

Time per capture: ~1 hour active work (the rest is wall time waiting on processing). Margin is high for an under-served local market.

The skill produces a client deliverable + invoice template for each capture if you're using it as a service.

## Pro version

`ccai-3d-capture-pro` (planned):
- Polycam / Luma API integration for upload automation
- Auto-compression pipeline
- Auto-generation of React embed component
- Client portal for delivery

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (32 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-3d-capture ~/.claude/skills/ccai-3d-capture

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
