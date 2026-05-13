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

### Step 6, Write the top-level REPORT.md

Synthesize per-page findings into a site-wide narrative:

1. **Overall scores**, SEO score / AEO score / Performance proxy score / Accessibility score
2. **The top 10 fixes**, ranked by (impact × ease). Each fix references the pages affected.
3. **What you're doing well**, keep the win list short and honest, not flattering
4. **Critical issues**, anything blocking indexation, HTTPS issues, broken canonicals
5. **AEO readiness**, separate breakout: FAQ presence, structured data depth, content freshness signals, citation patterns, original data
6. **Next step**, either "run `ccai-seo-setup` to fix these" (if stack is supported) or "share REPORT.md with your developer"

### Step 7, Brand voice check (optional)

If `BRAND_VOICE.md` exists in working dir, sample 3 pages and flag taboo phrasing. Don't be exhaustive, this is a sanity-check pass.

### Step 8, Verify

- Read REPORT.md back to user in chat as a summary
- Confirm output paths
- Suggest the appropriate follow-on skill (`ccai-seo-setup` to fix, `ccai-content-ideas` to plan new content, `ccai-competitor-research` if rankings issue)

## Hard rules

- **No fabricated metrics.** If a check requires data the free tier can't access (real Core Web Vitals, backlinks, real index status), say "needs pro tier", never invent numbers.
- **JS-rendered SPAs without prerendering are a critical finding.** Log it. Don't try to "render" client-side React in audit.
- **Respect robots.txt during crawl.** If it disallows `/`, log as finding and stop.
- **Reasonable rate limit**, 1 request / 500ms during crawl. Don't hammer the user's site.
- **Sample bias warning.** When sampling (>200 pages), state clearly that findings are based on a sample.

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
- `examples/sample-audit-creativecore-ai.md`, full walkthrough on creativecore.ai

## Sister skill

After running this audit, the natural next step is **`ccai-seo-setup`**, same canonical checklist, but produces paste-ready implementation prompts for your stack (Lovable, Next.js, Vite + React, Webflow, Wix).
