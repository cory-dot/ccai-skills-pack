# ccai-website-builder-setup

> Scaffold a production-grade Next.js + Tailwind + shadcn/ui + Framer Motion project that Claude Code can build a marketing site into. With a brand-aware STYLE_GUIDE.md so every page stays on-brand.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-website-builder-setup`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most AI-generated websites end up looking like every other AI-generated website. The reason is usually structural: there's no design system, no style guide, no shared vocabulary between sessions. Claude Code rebuilds your aesthetic from scratch on every page.

This skill fixes that by scaffolding a modern web project with the right design stack — and writing a `STYLE_GUIDE.md` that Claude Code reads before building anything new.

What you get:
- A working **Next.js 14 + TypeScript + Tailwind** project
- **shadcn/ui** components (copied into your project, not imported — you own them)
- **Framer Motion** for animations
- **lucide-react** for icons
- A `STYLE_GUIDE.md` derived from your `BRAND_VOICE.md` (colors, typography, spacing, voice rules)
- A symlinked `BRAND_VOICE.md` so Claude Code can read it from inside the project
- Sensible `package.json`, `tailwind.config.ts`, `tsconfig.json`
- A placeholder hero section that's ready to be built into — not "finished-looking"
- `npm run dev` verified working before handoff

What you DON'T get (intentionally):
- No paid component libraries by default
- No analytics scripts (you add the one you want)
- No tracking pixels
- No popup builders
- No CMS lock-in

---

## Why it's different from the original `website-builder-setup`

The original `@tenfoldmarc/website-builder-setup` was a wrapper that installed 3 third-party community skills (UI/UX Pro Max + Framer Motion + 21st.dev Magic). That works, but creates dependencies on skills you don't own.

This version is different in scope:
1. **Scaffolds an actual project**, not just installs other skills
2. **Generates STYLE_GUIDE.md from your BRAND_VOICE.md** — design tokens linked to your voice
3. **Zero third-party paid dependencies** — works with free tools end-to-end
4. **TypeScript + App Router by default** — modern Next.js, not legacy
5. **Includes deployment notes** — Vercel one-click is documented in the project README

---

## What you need

- Node.js v20+ installed
- Claude Code installed
- A directory to scaffold into (empty preferred)
- **Strongly recommended:** `ccai-brand-voice` already run

No paid component libraries, no API keys, no design tools required to start.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-website-builder-setup ~/.claude/skills/ccai-website-builder-setup
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-website-builder-setup
```

Or *"set up a new website project"* / *"scaffold a Next.js marketing site."*

The skill will:
1. Check Node.js + git prerequisites
2. Ask for project name, site type, domain, primary CTA
3. Read `BRAND_VOICE.md` if available
4. Run the scaffold (`create-next-app`, `shadcn-ui init`, install Framer Motion + lucide)
5. Generate `STYLE_GUIDE.md` from your brand voice
6. Replace the default Next.js homepage with a ready-to-build placeholder
7. Verify `npm run dev` works
8. Hand off with next-step instructions

After scaffold, you tell Claude Code: *"build a hero section for [your offer]"* — and it reads STYLE_GUIDE.md + BRAND_VOICE.md and builds it on-brand.

---

## The 4-tool stack

| Tool | Why it's in the default stack |
|---|---|
| **Next.js 14+ (App Router, TypeScript)** | Modern React framework. SSR for SEO. Free tier on Vercel handles marketing sites. |
| **Tailwind CSS** | Utility-first means Claude composes layouts without inventing class names. |
| **shadcn/ui** | Components copied into your project (not a dependency). You own them; you can modify them. |
| **Framer Motion** | Smooth, production-grade animations without rolling your own. |

Plus `lucide-react` for icons (MIT-licensed, comprehensive).

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`templates/STYLE_GUIDE.md`](templates/STYLE_GUIDE.md) | Schema for the design system doc |
| [`examples/sample-style-guide.md`](examples/sample-style-guide.md) | Filled example using Creative Core AI's brand |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Can I use this for a non-marketing site (app, dashboard, blog)?**
Yes — the stack supports all of those. The scaffold optimizes for *marketing sites* by default (single-page or few-page), but it's a starting point you can extend.

**What about Astro / SvelteKit / Remix?**
v0.1 ships Next.js only. If demand justifies it, v0.2 will add a `--framework` flag.

**Why shadcn/ui and not Material UI / Chakra / Mantine?**
shadcn's "copy components into your project" model means you own and can modify everything. The others require staying within their styling system. For a brand-distinct marketing site, shadcn wins.

**Where does my deployed site live?**
After scaffolding, the README in your project explains Vercel one-click deployment. Free tier handles marketing sites comfortably.

**Pro version?**
`ccai-website-builder-setup-pro` will add: image generation (via Replicate or similar), CMS integration (Sanity / Contentful boilerplate), e-commerce scaffolding (Shopify Storefront or Stripe), and pre-built section libraries.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-website-builder-setup ~/.claude/skills/ccai-website-builder-setup

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai) — our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
