---
name: ccai-3d-website
description: "Adds 3D animated hero sections / product viewers to your ccai-website-builder-setup project using Three.js (via react-three-fiber) and Spline. Generates the React component code and the asset spec, you provide the 3D model file (Spline / Blender / Gaussian Splat). Free version handles the integration; pro version (planned) auto-generates models from product photos. Use when the user wants a high-end \"expensive-looking\" hero animation for their marketing site."
when_to_use: "User mentions 3D website, 3D hero, animated 3D product viewer, Three.js, react-three-fiber, Spline embed, Gaussian Splat on web, immersive landing page, or wants their site to feel more premium than a static Next.js page."
argument-hint: "[section type, hero / product-viewer / background / object-rotator]"
---

# CCAI 3D Website

Add 3D animated sections to your Next.js marketing site. You provide the 3D model; the skill generates the integration.

## Prerequisites

- `ccai-website-builder-setup` already ran (Next.js + Tailwind project exists)
- A 3D asset, in one of these formats:
  - **`.splinecode`**, exported from Spline (no-code 3D tool, recommended for non-3D-modelers)
  - **`.glb` / `.gltf`**, standard 3D model format (from Blender, Three.js exporter, marketplace asset)
  - **`.splat` / `.ply`**, Gaussian Splat capture (works with `ccai-3d-capture`)

If you don't have any 3D asset yet, the skill walks you through which path to take:
- **Quickest:** [Spline](https://spline.design), free no-code 3D builder, 1-day learning curve
- **Most flexibility:** Blender (free, steep learning curve)
- **Hire a freelancer:** Fiverr / Cara.app, $50-300 for a simple branded 3D object

## What this skill generates

Depending on section type chosen:

### Hero with 3D background
- `components/sections/Hero3D.tsx`, full hero with 3D scene as background, copy overlay
- `components/three/HeroScene.tsx`, the Three.js scene component
- `public/3d/<model-file>`, placement for the asset (user uploads)
- Imports: `@react-three/fiber`, `@react-three/drei`, possibly `@splinetool/react-spline`

### Product viewer
- `components/sections/ProductViewer.tsx`, interactive 360° viewer
- Click-and-drag controls, auto-rotate on idle
- Mobile gesture support (pinch to zoom, drag to rotate)

### 3D background (non-hero)
- Subtle 3D scene that runs in the background of any section
- Particle field / gradient mesh / abstract geometry

### Object rotator (small)
- Small 3D object as part of a feature section (next to text)
- Auto-rotates, optional click interaction

## Process

### Step 1, Decide section type
4 options above. Recommend based on user goal:
- **"I want my hero to feel premium"** → Hero with 3D background
- **"I'm selling a physical product"** → Product viewer
- **"I want visual depth without distraction"** → 3D background
- **"I want a small accent"** → Object rotator

### Step 2, Check / install dependencies
Verify in user's project:
- `@react-three/fiber` (Three.js React wrapper)
- `@react-three/drei` (useful helpers)
- `three` (peer dep)
- `@splinetool/react-spline` (only if using Spline export)

Install missing ones:
```bash
npm install @react-three/fiber @react-three/drei three
# OR for Spline:
npm install @splinetool/react-spline @splinetool/runtime
```

### Step 3, Ask for the 3D asset
- Where is the file? (path or URL)
- If Spline: ask user to export with "Export → Code → React" + give them the embed URL
- If GLB/GLTF: ask user to put it in `public/3d/` and confirm filename
- If user doesn't have an asset yet, generate placeholder code + tell them what to produce

### Step 4, Generate the component
For the chosen section type, write the component file(s). Each component includes:

- Performance considerations: lazy-load with `next/dynamic` to avoid SSR issues
- `Suspense` boundaries with fallback (3D models load async)
- Mobile fallback (static image if `prefers-reduced-motion` or low-power device)
- Accessibility: alt-text equivalent for screen readers

### Step 5, Performance audit
3D in browser has real costs. The skill explicitly warns about:
- Load time (heavy GLB files = slow LCP) → suggest optimization with `gltfpack` or `meshoptimizer`
- Mobile (most phones can't render complex scenes smoothly) → mandatory fallback
- Bundle size (Three.js is ~600KB) → ensure dynamic import + code splitting

Outputs a perf checklist for the user to verify before deploying.

### Step 6, Verify
Run `npm run dev`. Confirm:
- Component renders without errors
- 3D model loads (or placeholder appears if not yet provided)
- Mobile fallback path works

## Hard rules

- **Always lazy-load Three.js components.** SSR doesn't work with WebGL, `next/dynamic({ ssr: false })` is mandatory.
- **Always provide mobile fallback.** A static image fallback for `prefers-reduced-motion` users + low-end devices.
- **Always warn about load-time costs.** 3D hero adds 1-3 seconds to LCP if not optimized. The user must know this trade-off.
- **Don't render 3D in the above-the-fold area for SEO-critical pages.** The blank space during load hurts CLS.
- **Respect BRAND_VOICE.md**, no marketing copy in the 3D component itself, only the surrounding overlay.

## Pro version differences

`ccai-3d-website-pro` (planned):
- Auto-generate Spline scenes from a product photo (via Spline API or similar)
- Auto-optimize GLB files (gltfpack integration)
- Gaussian Splat compression for web delivery
- A/B testing static vs 3D hero conversion

## Reference files
- `templates/HERO_3D.tsx.md`, sample component code as reference
- `examples/sample-3d-integration.md`, full walk-through example
