---
name: ccai-3d-capture
description: "End-to-end Gaussian Splatting workflow for capturing real-world objects/spaces as 3D models for the web. Covers shooting protocol (which apps, how many photos, what lighting), processing (Polycam, Luma, Postshot, Brush), web-optimization, and integration with ccai-3d-website. Use when the user wants real 3D captures of their products, locations, or spaces, not synthetic 3D models. This is the \"Gaussian Splatting business\" playbook from the course."
when_to_use: "User mentions Gaussian Splatting, 3D scanning, photogrammetry, Polycam, Luma AI, Postshot, NeRF, capturing real-world objects in 3D, real-estate 3D tours, or asks about the \"Gaussian Splatting business.\""
argument-hint: "[capture subject, product / space / person / vehicle]"
---

# CCAI 3D Capture

The end-to-end playbook for capturing real-world objects/spaces as Gaussian Splats for the web. Not synthetic 3D, actual photogrammetric captures.

## What Gaussian Splatting is (and isn't)

Gaussian Splatting is a rendering technique that turns photo sets into volumetric 3D scenes. The output looks photorealistic, closer to a real photo than a traditional 3D model, and renders in real-time in browsers.

For business owners, it's a way to put real products, spaces, or people on a website in interactive 3D without:
- A 3D modeler ($500-5K per asset)
- Hours of Blender work
- Expensive scanning equipment

A smartphone + 5 minutes + the right app can produce a usable splat.

What it CAN'T do well (yet):
- Reflective/transparent surfaces (glass, mirrors, polished chrome, fuzzy results)
- Very small objects (under fist-size, apps struggle with focal distance)
- Moving subjects (Gaussian Splat assumes static scene)
- Editing the captured model (you can scale/rotate but not modify geometry)

## Why this is a "business"

The course lesson framed it as "the $0-startup Gaussian Splatting business." The play:

- Local real estate agents pay $200-500 per listing for 3D tours (Matterport competitor)
- Restaurants pay $300-800 for ambiance captures for their websites
- E-commerce stores pay $50-150 per product splat for premium product pages
- Wedding photographers add 3D venue captures as a $500-1000 upsell

The capture takes 5-10 min. The processing takes 30-60 min (mostly waiting on cloud apps). Margins are high for an under-served local market.

This skill makes both sides work:
- **For your own business:** captures of your products/space for your CCAI site
- **For a side business:** structured workflow to deliver captures for clients

## Prerequisites

- A modern smartphone (iPhone 12+ or recent Android)
- One of the capture apps installed:
  - **Polycam** (free tier: 5 captures/month; $20/mo unlimited), easiest, fastest
  - **Luma AI** (free: unlimited Gaussian Splat captures), best free option
  - **Postshot** (desktop, ~$200), pro-grade desktop processing
  - **Brush** (Anthropic), newer, integrates with Claude (early-access)

## Output contract

Generates in working directory:

```
captures/
├── _capture-log.md                    # running log of all captures
├── YYYY-MM-DD-NN-subject-slug/
│   ├── BRIEF.md                       # subject specs + shoot plan
│   ├── reference-photos/              # user uploads source photos
│   ├── exports/                       # final splat files
│   │   ├── original.splat             # raw output
│   │   ├── web-optimized.splat        # compressed for web
│   │   └── preview.jpg                # 2D thumbnail
│   └── INTEGRATION.md                 # how to embed in ccai-3d-website
```

## Process

### Step 1, Define the capture

Ask:
1. **Subject type:** product / space / person / vehicle
2. **Final use case:** website hero / product page / real estate listing / standalone embed
3. **Size of subject:** thumbnail (under 1ft) / human-scale / room-sized / building/space-sized
4. **Lighting conditions:** indoor / outdoor / mixed / control available?
5. **Budget:** free apps only / willing to pay for Polycam Pro / desktop pipeline OK?

### Step 2, Recommend app + protocol

Based on subject + budget, recommend:

**For products (small, indoor):** Polycam free → 60-80 photos around subject in 3 horizontal arcs (low / mid / high angle)

**For spaces (room-sized):** Luma AI free → walk-through video, 30-90 sec, smooth movement

**For human-scale objects (vehicle, sculpture):** Polycam Pro → 120-200 photos, 4 arcs

**For real estate (multi-room):** Luma AI → multiple captures stitched, plus 360 photos for spherical context

### Step 3, Shoot protocol generated

A detailed checklist for the specific subject:

```
SHOT PLAN, [Subject]

Preparation (10 min):
- Subject placement: [where, what backdrop, what lighting]
- Clear surrounding area of mess/distractions
- Lighting: [specific recommendations]
- Camera settings: [iPhone/Android specifics]

Capture (5-15 min):
- Start position: [angle/distance]
- Movement pattern: [arcs / orbit / walk-through]
- Photo count: [N]
- Overlap: [each photo should overlap ~60% with adjacent]

Common mistakes to avoid:
- Moving the subject between shots (kills the capture)
- Wide focal length too close (apps need flat-ish FOV)
- Direct overhead lighting (creates harsh shadows that confuse the algorithm)
- Reflective floor (creates duplicate "ghost" subject)
```

### Step 4, Processing instructions

For the chosen app:
- Upload steps (specific to Polycam/Luma)
- Processing time expectation (15-60 min)
- Quality check criteria
- Export format (.splat / .ply / GLB)

### Step 5, Web optimization

Raw splats are huge (50-500MB). Web delivery needs <5MB ideally:

- Use **SuperSplat** (free web tool) to compress
- Aim for 100K-500K splats max
- Recommended settings per file-size target

### Step 6, Integration with ccai-3d-website

If user wants to put the splat on their website:
- Generate the React component using `@react-three/fiber` + a Gaussian Splat library (e.g., `@mkkellogg/gaussian-splats-3d`)
- Drop into the `ccai-website-builder-setup` project
- Performance notes (Gaussian Splats are heavier than GLB)

### Step 7, Log + invoice template (if delivering to a client)

If the user is doing this as a service:
- Add capture to `_capture-log.md`
- Generate a client deliverable email + invoice template
- Pricing tiers based on subject complexity

## Hard rules

- **No people without consent.** Capturing humans in 3D without their permission is a privacy + legal issue. Skill refuses without explicit confirmation.
- **No proprietary/IP-protected subjects.** Don't capture branded products you don't own or copyrighted artwork.
- **Acknowledge the "fuzzy result" reality.** Reflective and transparent objects produce fuzzy splats, set expectations honestly.
- **Always compress before web delivery.** Raw splats are bandwidth disasters. Recommend SuperSplat or similar.

## Pro version differences

`ccai-3d-capture-pro` (planned):
- Polycam / Luma API integration for upload automation
- Auto-compression pipeline (SuperSplat CLI)
- Auto-generation of the React embed component
- Client-portal generation for delivery

## Reference files
- `templates/CAPTURE_BRIEF.md`, schema for the per-capture brief
- `examples/sample-product-capture.md`, full walk-through of capturing a piece of pottery for a product page
