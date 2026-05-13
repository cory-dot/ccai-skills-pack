# ccai-seo-setup

> Implementation skill for SEO + AEO. Generates paste-ready prompts targeted at your hosting platform (Lovable, Vercel, Netlify, Cloudflare Pages, Webflow, Wix) and stack (Next.js, Vite + React). Companion to ccai-seo-audit.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 34-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-seo-setup`
**Status:** v0.2 · Foundation tier · works with Claude Code

---

## What's new in v0.2 (2026-05-13)

Hardened from the first real-world implementation against a Lovable-hosted Vite + React site. The skill now produces correct prompts the first time for failure modes that were previously gap discoveries:

- **Hosting-platform-first navigation.** Most non-developers know "I built it with Lovable" before they know "Vite + React + TypeScript." The skill now asks for hosting platform first and routes to the matching `templates/hosting/<platform>.md` overlay.
- **Vite plugin `closeBundle` pattern** for build-time prerender (replaces the old npm script chain that hosted builds frequently ignore). Node-compatible scripts only.
- **Body content prerender** is now a mandatory part of any SPA setup, not an optional add-on. Prevents the empty-body trap that flags in Bing as "Discovered but not crawled."
- **`.html` URL workaround** for hosts that don't natively resolve clean URLs (Lovable specifically). Includes sitemap, canonicals, internal link rewriting, and the `HtmlSuffixStripper` component for clean address-bar URLs after hydration.
- **Sentinel file diagnostic** pattern for hosts that don't expose build logs.
- **IndexNow with file-based key fallback** for hosts that don't reliably plumb env vars into Vite's build env.
- **llms.txt auto-generation** for AI crawlers (ChatGPT search, Claude, Perplexity).
- **GSC + Bing verification meta tag placeholders** baked into the prerender so they survive future builds.
- **`templates/META_PROMPT.md`**: a meta-prompt readers can paste into any LLM with their site config to customize all the generated prompts in one shot.

New template structure: `templates/hosting/{lovable,vercel,netlify,cloudflare-pages}.md` and `templates/stacks/vite-react.md`. The canonical case study is `templates/hosting/lovable.md`.

---

## What it does

Reads either an audit REPORT.md (from `ccai-seo-audit`) or a fresh-site intent, and outputs a folder of paste-ready prompts targeted at your hosting platform + stack.

For Lovable users: paste each prompt into your project chat. For Vercel / Netlify / CF Pages users: file-level diffs + code blocks. For Webflow / Wix users: step-by-step UI clicks + custom code snippets.

## What makes this different

Most "SEO checklists" online are either generic ("add a sitemap!") or tool-specific (just for Yoast). This skill:
- Speaks your stack's language. Lovable prompts ≠ Next.js diffs ≠ Webflow steps.
- Pulls from a canonical 60+ item checklist (same source as `ccai-seo-audit`)
- Pre-fills every prompt with your actual domain, author, brand info
- Orders fixes by dependency (author page before Article schema, etc.)
- Pairs with the audit skill: audit finds problems → setup writes the prompts

## When this is the right tool

- You ran `ccai-seo-audit` and want paste-ready fixes
- You're setting up a brand-new site
- You're working with Lovable / Cursor / Webflow / Wix and want stack-native instructions
- You're handing the work to a developer and want a clear punch list

## When this is NOT the right tool

- You only want a diagnosis → use `ccai-seo-audit`
- You want backlinks or off-site SEO → out of scope
- You want auto-execution → wait for pro version (or paste-and-go via Lovable)

## Supported hosting platforms

| Hosting | Default stack | Output type |
|---|---|---|
| Lovable | Vite + React (Lovable's default) | Conversational prompts you paste into Lovable chat |
| Vercel | Any (Next.js, Vite + React, others) | File-level diffs + code blocks |
| Netlify | Any | File-level diffs + `_redirects` notes |
| Cloudflare Pages | Any | File-level diffs + `_routes.json` if needed |
| Webflow | Webflow's own | UI clicks + custom code embed snippets |
| Wix | Wix's own | UI clicks + Velo snippets, limits flagged |

## Supported stacks (when host-agnostic)

| Stack | Notes |
|---|---|
| Next.js (App Router) | Native metadata API, route segments, native sitemap.ts |
| Vite + React | Build-time prerender via Vite plugin `closeBundle` hook (NOT npm script chain). See [`templates/stacks/vite-react.md`](templates/stacks/vite-react.md) |

## The canonical 60+ item checklist

11 categories, same source of truth as `ccai-seo-audit`:

1. Crawlability & indexation
2. Core Web Vitals + performance
3. Structured data (JSON-LD)
4. Open Graph + Twitter Cards
5. AEO / AI search optimization
6. EEAT signals
7. Internationalization (optional)
8. Local SEO (optional)
9. Accessibility-as-SEO
10. Mobile + tap targets
11. Attribution + analytics + UTM

Full checklist: [`templates/SEO_CHECKLIST.md`](templates/SEO_CHECKLIST.md)

## Output

Creates `seo-setup/`:

```
seo-setup/
├── SETUP_PLAN.md
├── prompts/
│   ├── 01-<fix>.md
│   ├── 02-<fix>.md
│   └── ...
├── verification-checklist.md
└── README.md
```

## Install

```bash
git clone https://github.com/cory-dot/ccai-seo-setup ~/.claude/skills/ccai-seo-setup
```

## Usage

Audit-driven (preferred):
```
/ccai-seo-setup lovable audits/creativecore-ai-2026-05-12/REPORT.md
```

Fresh-site:
```
/ccai-seo-setup nextjs
```

The skill walks through stack confirmation → context gathering → SETUP_PLAN generation → per-fix prompt generation → verification checklist.

## Example output

See [`examples/sample-setup-run-lovable.md`](examples/sample-setup-run-lovable.md), full walkthrough applying audit findings to a Lovable site.

## Free vs Pro

| | Free | Pro (planned) |
|---|---|---|
| All 5 stack templates | ✓ | ✓ |
| Audit-driven mode | ✓ | ✓ |
| Fresh-site mode | ✓ | ✓ |
| Paste-ready prompts | ✓ | ✓ |
| Direct execution via Lovable MCP |, | ✓ |
| GitHub PR creation (Next.js / Vite) |, | ✓ |
| IndexNow auto-ping on publish |, | ✓ |
| Continuous regression monitoring |, | ✓ |

## Pairs with

- **`ccai-seo-audit`**, diagnostic counterpart. Run audit first; pipe REPORT.md into this skill.
- **`ccai-website-builder-setup`**, if you don't have a site yet, scaffold one first (Next.js + Tailwind + shadcn).
- **`ccai-content-ideas`**, after SEO is set up, populate the content pipeline.

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (34 skills total). Two ways to install:

```bash
# Just this skill
git clone https://github.com/cory-dot/ccai-seo-setup ~/.claude/skills/ccai-seo-setup

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
