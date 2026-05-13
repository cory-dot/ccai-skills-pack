# ccai-seo-audit

> Diagnostic SEO + AEO audit. Crawl your full sitemap, run 55+ checks per page, build the internal link graph, output a prioritized fix list. Free version, pro adds PageSpeed Insights API, Search Console, backlink data.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 34-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-seo-audit`
**Status:** v0.1 · Foundation tier · works with Claude Code

---

## What it does

Crawls your full sitemap, runs 55+ checks per page across 11 categories, builds an internal link graph, flags cannibalization and orphans, and outputs a prioritized fix list a non-technical operator can hand to a developer.

Built for business owners who keep getting told "your SEO needs work" but never told *which 3 things to fix first*.

## What makes this different

Most SEO audit tools are either:
1. **$200/mo SaaS** (Ahrefs, Semrush), overkill for solo operators
2. **Free Chrome extensions**, homepage-only, miss site-wide issues
3. **Developer scripts**, assume you can read JSON output

This skill:
- Runs locally in Claude Code (no SaaS subscription)
- Crawls the full sitemap, not just homepage
- Outputs plain-English fix lists ranked by impact × ease
- Treats AEO (AI search) as a first-class category, not an afterthought
- Pairs with `ccai-seo-setup` to actually implement the fixes

## When this is the right tool

- You have a live site that exists
- You want to know what's broken before paying for fixes
- You care about both Google AND AI search (ChatGPT, Perplexity, Claude)
- You're a non-technical operator or small-team owner

## When this is NOT the right tool

- You don't have a live site yet → use `ccai-seo-setup` instead
- You need backlink analysis → free tier doesn't do this (Ahrefs/Moz do)
- You need real Core Web Vitals data → wait for the pro version (PageSpeed Insights API)
- You want auto-fixes → use `ccai-seo-setup` after this audit

## The 11 categories audited

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

55+ specific checks total. See [`templates/SEO_CHECKLIST.md`](templates/SEO_CHECKLIST.md) for the full canonical list.

## Output

Creates `audits/<domain>-YYYY-MM-DD/` with:
- `REPORT.md`, site-wide scores + top 10 fixes
- `per-page/<slug>.md`, one report card per crawled page
- `link-graph.md`, internal linking analysis
- `cannibalization-check.md`, keyword conflict detection
- `orphans-and-broken.md`, orphaned pages + broken internal links

## Site-type adaptive

The skill detects whether your site is content-blog / SaaS / e-commerce / local-service / coaching-creator and overlays the right checks. A coaching-creator audit cares about About-page depth and testimonial schema. An e-commerce audit cares about faceted-nav indexation and Product schema.

## Install

```bash
git clone https://github.com/cory-dot/ccai-seo-audit ~/.claude/skills/ccai-seo-audit
```

## Usage

```
/ccai-seo-audit creativecore.ai
```

The skill walks through site-type detection → sitemap crawl → per-page checks → link graph → prioritized report.

## Example output

See [`examples/sample-audit-creativecore-ai.md`](examples/sample-audit-creativecore-ai.md), full walkthrough auditing creativecore.ai.

## Free vs Pro

| | Free | Pro (planned) |
|---|---|---|
| HTML-only checks | ✓ | ✓ |
| Sitemap crawl | up to 100 pages | unlimited (Firecrawl) |
| Real Core Web Vitals | estimated | PageSpeed Insights API |
| Search Console data | manual | MCP integration |
| Backlinks | not included | DataForSEO |
| PDF export | markdown only | branded PDF |
| Scheduled re-audits | manual | cron + diff reports |

## Pairs with

- **`ccai-seo-setup`**, implementation skill. Takes this audit's REPORT.md and generates paste-ready prompts for Lovable / Next.js / Vite / Webflow / Wix.
- **`ccai-content-ideas`**, content gaps surfaced by the audit feed into the content ideas radar.
- **`ccai-competitor-research`**, if rankings are the issue, comparing structured-data depth vs competitors is the next step.

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (34 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-seo-audit ~/.claude/skills/ccai-seo-audit

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
