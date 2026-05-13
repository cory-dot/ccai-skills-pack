---
name: ccai-seo-setup
description: "Implementation skill for SEO + AEO. Reads an audit report (from ccai-seo-audit) or starts fresh, then generates paste-ready prompts targeted at your specific stack, Lovable, Next.js, Vite + React, Webflow, or Wix. Covers all 55+ checklist items: sitemap, robots, canonical, JSON-LD, Open Graph, FAQ schema, IndexNow, UTM auto-tagging, Search Console setup. Free version is paste-ready prompts; pro version (planned) executes the prompts directly via MCP. Use when starting a new site OR fixing audit findings, not when only diagnosing (that's ccai-seo-audit)."
when_to_use: "User mentions setting up SEO on a new site, fixing audit findings, implementing structured data, adding sitemap, configuring robots.txt, setting up OG images, FAQ schema, IndexNow, UTM tracking, Google Search Console / Bing Webmaster verification, or wants paste-ready Lovable / Next.js / Vite prompts for SEO work."
argument-hint: "[stack, lovable / nextjs / vite-react / webflow / wix] [optional path to audit report]"
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

## Supported stacks

| Stack | Output type | Notes |
|---|---|---|
| **Lovable** | Single mega-prompt or per-fix prompts | Lovable's AI applies the changes |
| **Next.js** (App Router) | File-level diffs + code blocks | Paste into Cursor or hand to dev |
| **Vite + React** | File-level diffs + build-time gen patterns (satori for OG) | Same workflow as Next.js |
| **Webflow** | Step-by-step UI clicks + custom code embed snippets | Most config is in Webflow's panel |
| **Wix** | Step-by-step UI clicks + Velo (custom code) snippets where needed | Some items not implementable on Wix |

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
- Stack (lovable / nextjs / vite-react / webflow / wix)
- Production domain
- Brand name
- Author name (for Person schema)
- Social handles (for sameAs)
- GSC + Bing Webmaster verification status
- IndexNow key (or generate one)
- Site type (content-blog / saas / ecommerce / local-service / coaching-creator)

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
- **Stack-honest.** If a checklist item can't be implemented on the user's stack (e.g., Wix can't do every JSON-LD pattern), say so explicitly in the SETUP_PLAN.
- **Prompts must be complete.** A "paste-ready" prompt that requires the user to fill in 5 variables is a fail. Pre-fill from context.
- **Order matters.** Don't generate prompts for FAQ schema before Article schema is in place. Respect dependencies.
- **Domain-aware.** All URLs in prompts use the user's actual domain, not example.com.

## Stack template files

- `templates/SEO_CHECKLIST.md`, mirror of audit skill's canonical checklist (same source of truth)
- `templates/lovable-prompt.md`, patterns for Lovable mega-prompts and per-fix prompts
- `templates/nextjs-implementation.md`, App Router patterns, file paths, code blocks
- `templates/vite-react-implementation.md`, Vite + satori + resvg-wasm for OG, build-time gen
- `templates/webflow-checklist.md`, UI clicks + custom code embed locations
- `templates/wix-checklist.md`, UI clicks + Velo snippets, items not possible flagged

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
