---
name: ccai-website-builder-setup
description: "Scaffolds a production-grade Next.js + Tailwind + shadcn/ui + Framer Motion project ready for Claude Code to build a marketing site into. Generates a STYLE_GUIDE.md (derived from BRAND_VOICE.md if available) so every page Claude builds afterward stays visually and tonally consistent. Use when the user wants to start a new business website, landing page, or marketing site from scratch."
when_to_use: "User mentions building a website, landing page, marketing site, \"set up a website project,\" \"scaffold a Next.js app,\" or starts a new web project. Also use when starting from an empty directory and the user mentions creating any web app."
argument-hint: "[project name, optional]"
---

# CCAI Website Builder Setup

Scaffold a modern Next.js marketing-site project with the design stack Claude Code needs to build clean, on-brand pages.

## Output contract

This skill creates a working Next.js project in the working directory (or in a named subdirectory). The project includes:

```
<project>/
├── app/
│   ├── layout.tsx
│   ├── page.tsx          # placeholder landing page
│   └── globals.css
├── components/
│   ├── ui/               # shadcn/ui components installed on demand
│   └── sections/         # marketing-section components (Hero, Features, CTA, etc.)
├── lib/
│   └── utils.ts          # cn() helper for Tailwind
├── public/
├── STYLE_GUIDE.md        # generated design system, Claude reads this for future page builds
├── BRAND_VOICE.md        # symlinked from working dir if present, else templated
├── tailwind.config.ts
├── tsconfig.json
├── package.json
├── next.config.js
└── README.md
```

Plus a `.env.local.template` showing what env vars the eventual site will need (analytics, form handlers, Cal.com embed, etc.).

## Stack rationale

| Tool | Why |
|---|---|
| **Next.js 14+ (App Router)** | The default modern React framework. SSR for SEO, generous free tier on Vercel, large ecosystem. |
| **TypeScript** | Catches errors before runtime. Worth the small setup cost, Claude Code handles TS without help. |
| **Tailwind CSS** | Utility-first means Claude can compose layouts without inventing class names. |
| **shadcn/ui** | Component library that *copies* components into your project (not a dependency). Means you own and can modify everything. |
| **Framer Motion** | Production-grade animation library. Smooth transitions without rolling your own. |
| **lucide-react** | Icon library, MIT-licensed, comprehensive. |

Deliberately NOT included: paywalled components, design-system-as-a-service, anything requiring an API key for basic functionality.

## Process

### Step 1, Check prerequisites

Verify in this order:
1. Node.js installed (require ≥ v20). If not: link to nodejs.org and stop.
2. `git` installed (warn but don't block if missing, recoverable later).
3. The working directory is empty OR the user explicitly wants to scaffold inside an existing project (rare). If neither, ask before overwriting.

### Step 2, Get the project specifics

Ask:
1. **Project name**, e.g. `creativecore-site` (used for directory name and package.json)
2. **Site type**, landing page only / multi-page marketing site / blog-included / app-with-marketing-site?
3. **Domain**, what's the eventual URL? (Used for OG image metadata, sitemap, robots.txt.)
4. **Primary CTA**, what's the single most important action visitors take? (Used to generate the placeholder hero CTA.)

### Step 3, Read context

- `BRAND_VOICE.md` if present in working directory, symlinked into the project so Claude reads it from inside the project too
- Any existing color palette / brand guide file the user mentions

### Step 4, Run the scaffold

Execute in order:

```bash
npx create-next-app@latest <project-name> --typescript --tailwind --app --no-src-dir --import-alias "@/*"
cd <project-name>
npx shadcn-ui@latest init     # accept defaults; default theme = neutral
npm install framer-motion lucide-react
npm install -D @types/node
```

Then add these shadcn components by default (most marketing sites use them):
```bash
npx shadcn-ui@latest add button card dialog input separator
```

### Step 5, Generate STYLE_GUIDE.md

Create `STYLE_GUIDE.md` in the project root. If BRAND_VOICE.md exists, derive design tokens from it:

- **Color palette**, propose 3 (primary, accent, neutral). If user has explicit brand colors, use them.
- **Typography**, propose a heading font + body font pair. Default: Inter + system fallback (battle-tested, free, fast).
- **Spacing scale**, Tailwind default 4px scale (no need to customize unless user asks).
- **Border radius**, default 0.5rem (matches shadcn neutral theme).
- **Voice rules**, pull directly from BRAND_VOICE.md taboos so future page builds respect them.

Show the user this STYLE_GUIDE.md and ask them to confirm or tweak before saving.

### Step 6, Replace the default Next.js homepage

Replace `app/page.tsx` with a placeholder hero section that:
- Uses the project name as the H1
- Uses the primary CTA from Step 2
- Has 3 placeholder "Section" components imported from `components/sections/` (currently empty stubs)
- Is mobile-responsive
- Uses Framer Motion for a single subtle fade-in entry animation

This is a "ready to be built into" starting point, not a finished site.

### Step 7, Add helpful project READMEs

Write a project `README.md` that includes:
- How to run dev server (`npm run dev`)
- Where to put new sections (`components/sections/`)
- How to ask Claude Code to build specific sections (with example prompts)
- Where the style guide lives
- Deployment notes (Vercel one-click)

### Step 8, First-run verification

Run `npm run dev` and confirm:
- Server starts on port 3000
- Homepage loads without errors
- Tailwind classes are working

If there are errors, debug them before declaring the scaffold complete.

### Step 9, Hand off summary

Tell the user:

> *"Scaffold complete at `<project-name>/`. Next steps:*
> *1. Run `npm run dev` and open http://localhost:3000*
> *2. Tell Claude Code: 'build a hero section for [your offer]', it'll read STYLE_GUIDE.md and BRAND_VOICE.md to keep things consistent*
> *3. When the site is ready, deploy to Vercel: `vercel` (free tier handles marketing sites comfortably)"*

## Hard rules

- **Always set TypeScript and App Router defaults.** Don't ask. They're the right defaults in 2026.
- **Never install third-party paid skills as dependencies.** If the user wants premium component libraries, they can install them after, but the scaffold works without them.
- **Never auto-deploy.** Even after a successful scaffold, deployment is the user's call. Approval gate before any `vercel deploy` command.
- **Respect BRAND_VOICE.md absolutely.** If it forbids emoji, don't put emoji in the placeholder homepage. If it has a vocabulary list, use it in the placeholder copy.
- **No tracking scripts in the scaffold.** Add a stubbed `<Analytics />` component the user wires up later. Don't install Google Analytics or any tracker by default.

## Reference files

- `templates/STYLE_GUIDE.md`, the schema for the design system doc
- `examples/sample-style-guide.md`, a filled example using Creative Core AI's brand

## Anti-patterns to avoid

- Scaffolding into a non-empty directory without warning. Destructive without consent.
- Adding 20 shadcn components by default. 5 covers most marketing-site needs. Let the user add others when needed.
- Generating a "finished-looking" placeholder homepage. The point is a starting skeleton, too much placeholder content slows down the real build.
- Skipping the `npm run dev` verification step. If you don't confirm it works before handing off, the user will hit errors in 5 minutes and lose trust in the scaffold.
- Bundling analytics, marketing scripts, popup builders. These are individual decisions; the scaffold stays minimal.
