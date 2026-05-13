---
name: ccai-seo-setup
description: "Implementation skill for SEO + AEO. Reads an audit report from ccai-seo-audit (or starts fresh) and generates paste-ready prompts targeted at your hosting platform (Lovable, Vercel, Netlify, Cloudflare Pages, Webflow, Wix) and stack (Next.js, Vite + React, etc.). Covers sitemap, robots, canonical, per-page metadata via build-time prerender, JSON-LD entity graph, Open Graph, body-content prerender, FAQ schema, IndexNow auto-ping, UTM auto-tagging, llms.txt, Search Console + Bing Webmaster setup, .html URL workarounds for hosts without clean URL resolution. Use when starting a new site OR fixing audit findings, not for diagnosis (that's ccai-seo-audit)."
when_to_use: "User mentions setting up SEO on a new site, fixing audit findings, implementing structured data, adding sitemap, configuring robots.txt, setting up OG images, FAQ schema, IndexNow, UTM tracking, llms.txt, Google Search Console or Bing Webmaster verification, or wants paste-ready Lovable / Cursor / Next.js / Vite prompts for SEO work."
argument-hint: "[hosting-platform: lovable / vercel / netlify / cloudflare-pages / webflow / wix] [optional stack: nextjs / vite-react] [optional path to audit report]"
---

# CCAI SEO Setup

Generates paste-ready implementation prompts for the 55+ item canonical SEO + AEO checklist, targeted at your specific stack. The companion to `ccai-seo-audit`.

## What this skill IS

- An implementation skill. Outputs prompts you paste into Lovable / Cursor / your dev's chat / a no-code builder.
- Stack-aware. The same fix gets a Lovable prompt OR a Next.js diff OR a Webflow checklist.
- Audit-aware. If you've run `ccai-seo-audit`, this skill reads the REPORT.md and only generates prompts for failed/warned items.
- Pragmatic. Skips items that don't apply (no e-comm checks on a coaching site).

## What this skill is NOT

- Not a diagnostic skill. For diagnosis use `ccai-seo-audit`.
- Not a deployer. Free version generates prompts; you (or your dev / Lovable) paste them.
- Not a content writer. For content use `ccai-sales-copy`, `ccai-content-repurpose`, `ccai-hook-research`.

## Prerequisites

- Either: an audit report from `ccai-seo-audit` (preferred, most targeted) OR a fresh-site setup intent
- Knowledge of your stack
- Access to wherever the changes go (Lovable project, GitHub repo, Webflow editor, etc.)

## Supported hosting platforms + stacks

Users often know their hosting platform ("I built it with Lovable", "I deployed to Vercel") before they know their stack. The skill is dual-indexed: navigate by hosting platform OR by stack.

| Hosting platform | Default stack | Output type | Notes |
|---|---|---|---|
| **Lovable** | Vite + React (Lovable's default) | Conversational prompts you paste into Lovable's chat | Lovable's AI applies the changes. See `templates/hosting/lovable.md` for the canonical case study of platform-specific gotchas. |
| **Vercel** | Next.js, Vite + React, others | File-level diffs + code blocks | Clean URLs resolve natively. Most stack templates apply directly. |
| **Netlify** | Any | File-level diffs + `_redirects` / `netlify.toml` if needed | Similar to Vercel; clean URLs natively. |
| **Cloudflare Pages** | Any | File-level diffs + `_routes.json` if needed | Similar to Vercel + Netlify; CF Workers available for edge logic. |
| **Webflow** | Webflow's own | Step-by-step UI clicks + custom code embed snippets | Most config is in Webflow's panel. Dynamic sitemap has page-count limits. |
| **Wix** | Wix's own | Step-by-step UI clicks + Velo (custom code) snippets where needed | Locked-down `<head>`. Some items not implementable. |

| Stack (when host-agnostic) | Notes |
|---|---|
| **Next.js** (App Router) | Native metadata API, route segments, native sitemap.ts. See `templates/stacks/nextjs.md`. |
| **Vite + React** | Build-time prerender via Vite plugin (`closeBundle` hook), NOT npm script chain. See `templates/stacks/vite-react.md`. The Vite + React + Lovable combination has special hosting-layer constraints; see also `templates/hosting/lovable.md`. |

The recommended entry point is hosting-platform-first. The hosting template references the relevant stack template(s) for build-time code patterns.

## Output contract

Creates `seo-setup/` in the working directory:

```
seo-setup/
├── SETUP_PLAN.md              # The ordered list of fixes with status
├── prompts/
│   ├── 01-sitemap.md          # one file per fix, ready to paste
│   ├── 02-robots.md
│   ├── 03-canonical-tags.md
│   ├── 04-json-ld-article.md
│   ├── 05-faq-schema.md
│   ├── 06-og-images.md
│   ├── 07-indexnow.md
│   ├── 08-utm-share-tagging.md
│   └── ... (one per applicable checklist item)
├── verification-checklist.md  # what to verify after applying each fix
└── README.md                  # what to do with this folder
```

## Process

### Step 1, Determine mode

Two modes:

**A. Audit-driven mode (preferred):**
User points to `audits/<domain>-YYYY-MM-DD/REPORT.md`. Skill reads it, extracts failed/warned items, ordered by priority. Only generates prompts for those.

**B. Fresh-site mode:**
No audit exists yet. Skill asks for stack + site type + a few details (domain, business name, location for local), then generates a full SETUP_PLAN.md covering every applicable item.

### Step 2, Ask for missing context

Pull from working dir if available, ask user otherwise:
- **Hosting platform** (lovable / vercel / netlify / cloudflare-pages / webflow / wix) — ask FIRST, since this determines which template overlay applies and which gotchas to flag.
- **Stack** if not implied by hosting (most hosts work with any stack; Lovable/Webflow/Wix imply their own). lovable / nextjs / vite-react / webflow / wix / other
- Production domain
- Brand name + one-sentence tagline + 2-3 sentence description
- Founder/author name + title (for Person schema)
- Founder bio (2 paragraphs OK; can be placeholder initially)
- Location (city, region, country, for PostalAddress in Organization + Person schema)
- Brand social URLs (for Organization.sameAs)
- Founder personal social URLs (for Person.sameAs, kept separate from brand)
- knowsAbout topics (3-7 topics the business is expert in)
- Service tiers / offers (optional, for Organization.offers)
- Booking / consult CTA URL
- GSC + Bing Webmaster verification status
- IndexNow key (or generate one server-side; never expose as VITE_ prefix)
- Site type (content-blog / saas / ecommerce / local-service / coaching-creator)
- Markdown content directory path (if site has guides/blog articles in `.md` files)

### Step 3, Build SETUP_PLAN.md

Ordered list of fixes:

```markdown
# SEO Setup Plan, <domain>

Stack: <stack>
Site type: <type>
Source: audit (REPORT.md from YYYY-MM-DD) | fresh-site

## Fixes (ordered by impact × dependency)

1. ⏳ Sitemap.xml + robots.txt, `prompts/01-sitemap.md`
2. ⏳ Canonical tags sitewide, `prompts/02-canonical.md`
3. ⏳ Article JSON-LD, `prompts/03-json-ld-article.md`
...
```

Status icons: ⏳ pending / ✅ applied / ⚠️ partial / ❌ blocked

### Step 4, Generate per-fix prompts

For each item, write `prompts/NN-<slug>.md` using the matching stack template. Each prompt file contains:

- **What this fixes**, checklist item ID + plain description
- **Why it matters**, short
- **The prompt**, a complete, paste-ready block
- **Where to paste**, Lovable chat / Cursor / Webflow embed / etc.
- **How to verify**, what the user checks after it's applied

### Step 5, Generate verification-checklist.md

For each fix, what URL or tool verifies it worked:

- robots.txt → fetch `/robots.txt`
- sitemap → fetch `/sitemap.xml` + check sitemap submission in Search Console
- canonical → view-source any 2 pages
- JSON-LD → Google Rich Results Test
- OG image → Facebook Sharing Debugger + Twitter Card Validator
- FAQ schema → Rich Results Test
- IndexNow → submit a test URL, check response
- UTM → click "Copy link" on the site, verify URL has utm_*
- GSC/Bing → property verified, sitemap submitted
- Core Web Vitals → PageSpeed Insights

### Step 6, Write README.md for the setup folder

User-facing instructions: "Start with prompts/01, paste into [stack], verify per verification-checklist.md, mark ✅ in SETUP_PLAN.md, move to next."

### Step 7, Suggest follow-on

After setup is applied:
- Re-run `ccai-seo-audit` to verify scores improved
- If site is new, populate `ccai-content-ideas` to start the content engine
- If competing for keywords, run `ccai-competitor-research`

## Hard rules

- **No fabricated structured data.** If you don't have a real author / address / business info, ask the user, never invent.
- **Stack-honest.** If a checklist item can't be implemented on the user's stack or hosting platform (e.g., Wix can't do every JSON-LD pattern; Lovable can't natively resolve clean URLs), say so explicitly in the SETUP_PLAN and provide the appropriate workaround.
- **Hosting-platform-aware.** Detect the hosting platform first. Lovable specifically has a tangle of hosting-layer constraints (`vite build` only, no `_redirects`, SPA fallback for clean URLs, no build logs, env vars unreliably plumbed). See `templates/hosting/lovable.md`. Other hosts have their own quirks; reference the matching overlay.
- **Prompts must be complete.** A "paste-ready" prompt that requires the user to fill in 5 variables is a fail. Pre-fill from context.
- **Body prerender, not just head prerender.** When generating prerender prompts for SPAs, the prompt MUST cover both head metadata AND body content rendering. An empty body (`<div id="root"></div>`) with rich head metadata is the most common failure mode after a partial prerender setup. Bing flags it; Google masks it.
- **Order matters.** Don't generate prompts for FAQ schema before Article schema is in place. Respect dependencies.
- **Domain-aware.** All URLs in prompts use the user's actual domain, not example.com.
- **Curl-verify after every host change.** The verification checklist for every fix on a hosted-AI-editor (Lovable, etc.) MUST include a `curl` command against the deployed URL. Hosts' built-in previews and "improve SEO" panels frequently see different content than real crawlers. Trust curl.
- **Manual Request Indexing after every major change.** The verification checklist for any structural SEO fix MUST end with: "Click Request Indexing in GSC and Bing for the affected URLs." Otherwise users wait weeks for the natural re-crawl. Both consoles support it; GSC has a daily quota, Bing is more lenient.

## Template files

Templates are organized by both hosting platform and stack. A typical setup run reads ONE hosting template + ONE stack template (or just the hosting template if the host implies a stack).

**Hosting platforms** (`templates/hosting/`):
- `lovable.md`, Lovable-specific gotchas + the `.html` URL workaround + Vite plugin closeBundle pattern + sentinel file diagnostic + body prerender + GSC/Bing/IndexNow file fallback. The deepest single template; Lovable is the most-constrained host.
- `vercel.md`, mostly "use the stack template directly, clean URLs work natively"
- `netlify.md`, similar to Vercel + `_redirects` notes
- `cloudflare-pages.md`, similar + `_routes.json` if needed
- `webflow.md`, UI clicks + custom code embed locations + dynamic sitemap limits
- `wix.md`, UI clicks + Velo snippets + items flagged as not implementable

**Stacks** (`templates/stacks/`):
- `vite-react.md`, Vite + React + build-time prerender via plugin (closeBundle hook), Node-compatible scripts (NOT Bun-only), body prerender pass, internal-link rewriting, IndexNow auto-ping
- `nextjs.md`, App Router patterns, native metadata API, sitemap.ts, route handlers for OG
- `webflow.md` (host-implied), see hosting/webflow.md
- `wix.md` (host-implied), see hosting/wix.md

**Shared**:
- `SEO_CHECKLIST.md`, mirror of audit skill's canonical checklist (same source of truth)
- `META_PROMPT.md`, the "customize these prompts for my site" meta-prompt users can paste into Claude.ai or Cursor

**Legacy file names** (kept for backwards compatibility, will be deprecated):
- `lovable-prompt.md` → see `hosting/lovable.md`
- `nextjs-implementation.md` → see `stacks/nextjs.md`
- `vite-react-implementation.md` → see `stacks/vite-react.md`
- `webflow-checklist.md` → see `hosting/webflow.md`
- `wix-checklist.md` → see `hosting/wix.md`

## Free vs Pro

**Free (this skill):**
- All 5 stack templates
- Audit-driven + fresh-site modes
- Paste-ready prompts you (or your AI builder) apply
- Verification checklist

**Pro (`ccai-seo-setup-pro`, planned):**
- Direct execution via Lovable MCP (skill applies the prompts itself)
- GitHub PR creation for Next.js / Vite sites
- IndexNow auto-ping on publish (cron + webhook)
- Continuous monitoring + auto-fix for regressions

## Reference files

- `templates/SEO_CHECKLIST.md`, the 55+ item canonical checklist (shared with audit skill)
- `templates/lovable-prompt.md`, Lovable patterns
- `templates/nextjs-implementation.md`, Next.js patterns
- `templates/vite-react-implementation.md`, Vite patterns
- `templates/webflow-checklist.md`, Webflow steps
- `templates/wix-checklist.md`, Wix steps
- `examples/sample-setup-run-lovable.md`, full walkthrough applying audit findings to a Lovable site

## Sister skill

`ccai-seo-audit` is the diagnostic counterpart. Run audit first; pipe its REPORT.md into this skill; this skill writes the prompts; you apply them; re-run audit to verify.
