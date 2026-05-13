---
name: ccai-seo-audit
description: "Diagnostic SEO + AEO audit for an existing website. Crawls the full sitemap, runs 50+ checks per page (crawlability, Core Web Vitals signals, structured data, Open Graph, AEO readiness, EEAT, mobile, accessibility, attribution), builds an internal link graph, flags cannibalization + orphans + broken links, and outputs a prioritized fix list. Free version is HTML-only crawl; pro version adds PageSpeed Insights API, Search Console, backlink data. Use when a site exists and the user wants to know what's broken or underperforming, not when starting a new site (that's ccai-seo-setup)."
when_to_use: "User mentions SEO audit, site audit, \"why isn't my site ranking,\" AEO / AI search optimization, Core Web Vitals, indexation problems, structured data check, sitemap issues, Search Console errors, \"is my site set up for AI search,\" or anything diagnostic about an existing live site."
argument-hint: "[site URL, e.g., creativecore.ai]"
---

# CCAI SEO Audit

Full-site diagnostic SEO + AEO audit. Crawl the sitemap, score every page against a 50+ item canonical checklist, build a link graph, output a prioritized fix list a non-technical operator can hand to a developer (or to `ccai-seo-setup` to implement).

## What this skill IS

- A diagnostic tool. Existing site → scorecard + ranked fixes.
- A full-sitemap crawler. Not just homepage.
- Honest about what HTML-only inspection can and can't see.
- Built for business owners who can't read DevTools but need to know what to fix first.

## What this skill is NOT

- Not an implementation skill. For paste-ready fixes use **`ccai-seo-setup`**.
- Not a backlink tool. No Ahrefs / Moz integration in free tier.
- Not a real-time Core Web Vitals reader. Free tier estimates from HTML; pro tier hits PageSpeed Insights API.
- Not a content writing skill. Use `ccai-sales-copy` or `ccai-content-repurpose` for content.

## Prerequisites

- A live, publicly-accessible URL
- Optional: `BRAND_VOICE.md` in working dir (used for content-quality checks against tone rules)
- Optional: Google Search Console + Bing Webmaster verified (for pro-tier additions)

## Output contract

```
audits/
├── <domain>-YYYY-MM-DD/
│   ├── REPORT.md                    # site-wide summary + top 10 fixes + scores
│   ├── per-page/
│   │   ├── homepage.md
│   │   └── <each-page>.md
│   ├── link-graph.md                # internal linking analysis
│   ├── cannibalization-check.md     # multi-page keyword conflicts
│   └── orphans-and-broken.md
```

Top-level `REPORT.md` gives:
- Overall score (0-100)
- Pages audited (X of Y)
- Critical issues (must-fix, ranked)
- High-priority fixes
- Optimization opportunities
- Separate AEO readiness score (0-100)

## Process

### Step 1, Resolve the target

Ask user for the URL if not supplied. Validate it resolves over HTTPS. If HTTP-only or redirect chain to HTTPS is broken, that's finding #1, log and continue.

Determine site type via quick homepage inspection:
- **content-blog**, blog/articles/guides as primary structure
- **saas**, product + pricing + docs
- **ecommerce**, products + cart + checkout
- **local-service**, location-based, NAP visible
- **coaching-creator**, about + offer + testimonials + booking

Site type loads the matching `templates/site-type/<type>.md` overlay. If ambiguous, ask user.

### Step 2, Crawl the sitemap

1. Fetch `/robots.txt`, validate format, extract `Sitemap:` URL
2. Fetch sitemap (or `/sitemap.xml` fallback), parse canonical URL list + `lastmod`
3. If no sitemap → fall back to homepage + visible nav links + a 2-level deep crawl from there. Log as finding: "No sitemap found, recommend adding one."

### Step 2.5, Detect hosting platform + URL convention

Many SEO problems are hosting-platform-specific (e.g., Lovable's SPA fallback for clean URLs, Webflow's lack of dynamic sitemap, Wix's locked-down `<head>`). Detect the host so the audit can flag platform-specific gotchas.

Detection heuristics (from response headers, HTML fingerprints, CDN signatures):
- **Lovable hosting**: HTML contains `<script ... src="/~flock.js"` or `data-proxy-url="/~api/analytics"`. May have `pub-*.r2.dev` URLs in OG tags from preview environment leakage.
- **Vercel**: response headers include `server: Vercel` or `x-vercel-id`. URL paths like `/_next/static/` in HTML.
- **Netlify**: response headers include `server: Netlify` or `x-nf-request-id`.
- **Cloudflare Pages**: `server: cloudflare` + `cf-ray` header (note: Cloudflare can also be in front of any other host as a proxy; check for absence of other-host signatures).
- **Webflow**: HTML contains `data-wf-page` or `wf-page-link` classes.
- **Wix**: HTML contains `wix-` classes or `_wixCIDX` window globals.

Once hosting is identified, run platform-specific extra checks (see `templates/hosting/<platform>.md` overlays). Examples of hosting-specific findings:
- Lovable: does the host resolve clean URLs to nested `index.html`, or only to flat `.html`? (Test: curl `/<route>` and `/<route>.html`; if titles differ, host is serving SPA fallback for clean URLs.)
- Lovable: does the hosted build run the full npm script chain, or only `vite build`? (Test: check for sentinel files, manifests, or post-build artifacts that should exist but don't.)
- Webflow: dynamic sitemap limit (Webflow caps at certain page counts).
- Wix: which `<head>` injection methods are available; flag items that aren't implementable.

### Step 2.6, Body content size check (critical for SPAs)

For every URL in the crawl, after fetching HTML, measure body content size:

```
body_size = len(HTML between <body> and </body>) minus whitespace
```

For SPAs and prerendered sites, the threshold is the key SEO signal:

- **< 200 bytes**: body is effectively empty. Page is JS-only. Critical finding: non-JS crawlers (Bingbot by default, GPTBot, ClaudeBot, PerplexityBot, social unfurl bots like Facebook/Twitter/LinkedIn/Slack) see no content. Even if metadata is rich, the page won't index in Bing and won't be cited by AI search engines.
- **200-500 bytes**: minimal body. Probably just a heading + navigation. Flag as warning.
- **500+ bytes**: real content. Pass.

The empty-body trap is sneaky because Googlebot renders JavaScript, so a page can be indexed in Google while remaining invisible to Bing and AI crawlers. Google Search Console won't flag this. Bing's URL Inspection eventually will (vague "Discovered but not crawled" error). The audit catches it before Bing does.

This check is ONE of the highest-impact items in the entire audit. Score it heavily.

Site-size handling:
- 1-50 pages → full crawl
- 50-200 pages → full crawl, paginated
- 200-1000 pages → sample 100 representative pages (homepage + each top-level section + random sample) and note "free-tier sampled audit; pro version offers full crawl"
- 1000+ → free tier hard-stops at 100; pro version uses Firecrawl

### Step 3, Per-page checks

For each URL, fetch HTML and run the 50+ items in `templates/SEO_CHECKLIST.md`. Group findings by category. Write one report card to `per-page/<slug>.md` per page using `templates/AUDIT_REPORT.md` schema:

- Page URL + title
- Overall page score
- Pass / warn / fail per check
- Top 3 fixes for this specific page
- Notable wins (what's already done well)

### Step 4, Build the link graph

Aggregate all internal links across crawled pages. Detect:
- **Orphans**, pages in sitemap with zero internal links pointing at them
- **Broken links**, 404/500 internal links
- **Redirect chains**, internal links pointing at URLs that 301/302
- **Click-depth violations**, pages >3 clicks from homepage
- **Most-linked pages**, should match priority pages; flag if not

Output → `link-graph.md`.

### Step 5, Cannibalization + duplicate check

- Cluster pages by title similarity (>70% overlap)
- Cluster pages by H1 similarity
- Cluster pages by primary keyword target (inferred from title + H1 + meta description)
- Flag clusters where multiple pages compete for the same keyword

Output → `cannibalization-check.md`.

### Step 5.5, Internal link convention consistency

Detect mismatches between internal links and canonical URLs. Common pattern: a site that uses `.html` URLs in its sitemap and canonical tags, but has internal `<a href="/guides/something">` links pointing to clean URLs that fall through to SPA fallback.

For each crawled page:
1. Extract all internal `<a href>` values
2. Compare each href to the canonical URL convention (does the canonical end in `.html`? Do internal links?)
3. Flag inconsistencies as findings: "Internal links use clean URLs while canonicals use `.html` URLs. Bots following internal links hit SPA fallback instead of prerendered HTML."

This compounded Bing's deduplication problem on Lovable-hosted SPAs (Bing followed clean-URL internal links, found duplicate empty bodies, and picked the wrong canonical for the whole site). The audit catches it as a separate finding from the body-size check.

### Step 5.6, Stale search engine cache (manual step note)

The audit can't directly read search engine indexes (free tier doesn't have GSC/Bing API access), but it can prompt the user to run a manual check after the audit:

> After this audit, open Google Search Console and Bing Webmaster Tools. For your homepage and 2-3 top pages, run URL Inspection. Compare what the search engine has indexed (the "Crawled page" HTML in GSC) against what's currently served by the site. If they differ significantly, your search engine has a stale cache from before recent fixes. After any major SEO overhaul, manually click "Request Indexing" on every important URL in both consoles. GSC has a daily quota (~10-12); Bing is more lenient.

Add this as a follow-up task in the REPORT.md if any critical issues are flagged.

### Step 6, Write the top-level REPORT.md

Synthesize per-page findings into a site-wide narrative:

1. **Overall scores**, SEO score / AEO score / Performance proxy score / Accessibility score
2. **Hosting platform detected** + platform-specific gotchas flagged
3. **The top 10 fixes**, ranked by (impact × ease). Each fix references the pages affected.
4. **What you're doing well**, keep the win list short and honest, not flattering
5. **Critical issues**, anything blocking indexation, HTTPS issues, broken canonicals, empty bodies on SPA pages
6. **AEO readiness**, separate breakout: FAQ presence, structured data depth, content freshness signals, citation patterns, original data
7. **Post-fix runbook**, manual Request Indexing list (see step 5.6)
8. **Next step**, either "run `ccai-seo-setup <hosting-platform>` to fix these" (if hosting is supported) or "share REPORT.md with your developer"

### Step 7, Brand voice check (optional)

If `BRAND_VOICE.md` exists in working dir, sample 3 pages and flag taboo phrasing. Don't be exhaustive, this is a sanity-check pass.

### Step 8, Verify

- Read REPORT.md back to user in chat as a summary
- Confirm output paths
- Suggest the appropriate follow-on skill (`ccai-seo-setup` to fix, `ccai-content-ideas` to plan new content, `ccai-competitor-research` if rankings issue)

## Hard rules

- **No fabricated metrics.** If a check requires data the free tier can't access (real Core Web Vitals, backlinks, real index status), say "needs pro tier", never invent numbers.
- **JS-rendered SPAs without prerendering are a critical finding.** Log it. Don't try to "render" client-side React in audit.
- **Empty-body prerendered SPAs are ALSO a critical finding.** A page can have rich `<head>` metadata and a 45-byte `<body>` containing only `<div id="root"></div>`. Bingbot and AI crawlers won't index it. Googlebot will (it renders JS), which masks the problem. The body-size check (step 2.6) is mandatory for any site that looks like an SPA.
- **Hosting-platform detection is mandatory.** Many SEO issues are hosting-specific. Run step 2.5 before running per-page checks so platform overlays apply.
- **Respect robots.txt during crawl.** If it disallows `/`, log as finding and stop.
- **Reasonable rate limit**, 1 request / 500ms during crawl. Don't hammer the user's site.
- **Sample bias warning.** When sampling (>200 pages), state clearly that findings are based on a sample.
- **Curl is the tiebreaker.** When the host's own SEO panel, an SEO tool, and the live HTML disagree, trust curl against the live URL. Hosts' built-in scanners frequently see different content than real crawlers do (especially on hosts that use SPA fallback for clean URLs). See `templates/hosting/lovable.md` for the specific case study.

## Free vs Pro

**Free (this skill):**
- HTML-only crawl up to 100 pages
- All 50+ checks that can run from HTML
- Full link graph + cannibalization + orphans
- Site-type adaptive

**Pro (`ccai-seo-audit-pro`, planned):**
- PageSpeed Insights API → real Core Web Vitals
- Google Search Console MCP → real index + queries data
- Firecrawl integration → unlimited page count
- Backlink data via DataForSEO
- PDF export
- Scheduled re-audits with diff reports

## Reference files

- `templates/SEO_CHECKLIST.md`, the canonical 50+ item checklist
- `templates/AUDIT_REPORT.md`, per-page report card schema
- `templates/site-type/content-blog.md`, overlay for content sites
- `templates/site-type/saas.md`, overlay for SaaS
- `templates/site-type/ecommerce.md`, overlay for e-comm
- `templates/site-type/local-service.md`, overlay for local
- `templates/site-type/coaching-creator.md`, overlay for creators/coaches
- `templates/hosting/lovable.md`, Lovable-specific gotchas (SPA fallback, npm script chain ignored, OG image cache, etc.)
- `templates/hosting/vercel.md`, Vercel-specific notes (mostly: clean URLs work natively, no special workarounds needed)
- `templates/hosting/netlify.md`, Netlify-specific notes (`_redirects` + `netlify.toml`)
- `templates/hosting/cloudflare-pages.md`, CF Pages notes (`_routes.json` if needed)
- `templates/hosting/webflow.md`, Webflow gotchas (dynamic sitemap limit, schema injection methods)
- `templates/hosting/wix.md`, Wix gotchas (locked-down `<head>`, items not implementable)
- `examples/sample-audit-creativecore-ai.md`, full walkthrough on creativecore.ai (a Vite+React SPA on Lovable hosting — the canonical case study for the empty-body trap and the `.html` URL workaround)

## Sister skill

After running this audit, the natural next step is **`ccai-seo-setup`**, same canonical checklist, but produces paste-ready implementation prompts for your stack (Lovable, Next.js, Vite + React, Webflow, Wix).
