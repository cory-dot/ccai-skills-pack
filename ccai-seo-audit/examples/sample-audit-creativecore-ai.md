# Sample audit: creativecore.ai (2026-05-12)

This is the kind of output you'll get when you run `/ccai-seo-audit creativecore.ai`. Illustrative, actual numbers depend on the live state of the site at audit time.

---

## Site-wide REPORT.md

```markdown
# SEO + AEO Audit: creativecore.ai

**Audited:** 2026-05-12
**Pages audited:** 18 of 18 (full sitemap crawled)
**Site type:** coaching-creator + content-blog hybrid
**Overall site score:** 72 / 100
**AEO readiness score:** 58 / 100

---

## Scores at a glance

| Category | Score | Weight |
|---|---|---|
| Crawlability & indexation | 7/8 | normal |
| Core Web Vitals + performance | 5/7 | high |
| Structured data | 4/6 | high |
| Open Graph + Twitter | 4/5 | normal |
| AEO / AI search | 3/6 | critical |
| EEAT signals | 4/5 | high |
| Internationalization | N/A |, |
| Local SEO | 3/5 | medium (Houston-tagged) |
| Accessibility-as-SEO | 3/4 | normal |
| Mobile + tap targets | 3/3 | critical |
| Attribution + analytics | 2/4 | high |

---

## The top 10 fixes (ranked by impact × ease)

### 1. Add FAQPage schema to all 12 guides
- **Item:** 5.1
- **What's wrong:** 9 of 12 guides have H2/H3 questions in body but no FAQPage JSON-LD wrapper
- **Effort:** small (one block per page, can templatize)
- **Impact:** large, AEO citation rate
- **Pages affected:** /guides/01 through /guides/12 except 03, 07, 11

### 2. Visible "Updated YYYY-MM-DD" on every guide
- **Item:** 5.4
- **What's wrong:** dateModified exists in JSON-LD on 8 guides but not displayed visibly on the page; 4 guides have no dateModified at all
- **Effort:** small
- **Impact:** large, freshness signal to AI engines + user trust
- **Pages affected:** all 12 guides

### 3. OG image dimensions + absolute URLs
- **Item:** 4.3
- **What's wrong:** 5 guides have og:image as relative URL (`/og/article-04.png`); social platforms require absolute HTTPS URLs
- **Effort:** small
- **Impact:** medium, social share CTR
- **Pages affected:** articles 04, 06, 09, 10, 12

### 4. Add Person schema for author (Cory)
- **Item:** 3.5
- **What's wrong:** Articles credit "Cory Loflin" in byline + JSON-LD `author.name`, but no Person schema block; no `/author/cory-loflin/` page
- **Effort:** medium (create author page + schema block, link from all articles)
- **Impact:** large, EEAT authority signal
- **Pages affected:** all 12 guides + sitewide

### 5. Implement IndexNow for instant indexing
- **Item:** 5.5
- **What's wrong:** No IndexNow key file at root; new articles take 2-4 weeks to appear in Bing
- **Effort:** small (one-time setup + webhook on publish)
- **Impact:** large, ChatGPT search + Copilot reach the same week as publish
- **Pages affected:** sitewide

### 6. UTM auto-tagging on share buttons
- **Item:** 11.2
- **What's wrong:** Copy-link button on /guides/* outputs naked URL; no UTM parameters appended
- **Effort:** small
- **Impact:** medium, attribution accuracy
- **Pages affected:** all guides

### 7. Author page + Person schema (combined with #4)
- **Item:** 3.5 / CC.1
- **What's wrong:** No `/about` page with structured author bio; About content exists on homepage only
- **Effort:** medium
- **Impact:** large
- **Pages affected:** sitewide

### 8. Bing Webmaster verification + sitemap submission
- **Item:** 11.4
- **What's wrong:** Google Search Console verified; Bing Webmaster Tools not configured
- **Effort:** small
- **Impact:** medium, ChatGPT search uses Bing index
- **Pages affected:** sitewide

### 9. Image lazy-loading on long guides
- **Item:** 2.5
- **What's wrong:** Guides with 4+ images load all eagerly; LCP estimate >3s on /guides/03 and /guides/08
- **Effort:** small (add `loading="lazy"` to all but first image)
- **Impact:** medium, page speed + Core Web Vitals
- **Pages affected:** /guides/03, /guides/05, /guides/08, /guides/10

### 10. BreadcrumbList schema on guides
- **Item:** 3.4
- **What's wrong:** Visual breadcrumbs present ("Home › Guides › Article Title") but no BreadcrumbList JSON-LD
- **Effort:** small
- **Impact:** medium, SERP breadcrumb display + site hierarchy signal
- **Pages affected:** all 12 guides

---

## What you're doing well

- Sitemap.xml is complete and references all 12 guides + booking page + homepage
- HTTPS site-wide, no mixed content
- Canonical tags self-referencing on all pages
- Article JSON-LD present on all 12 guides (just incomplete in places)
- No noindex own-goals
- Strong internal linking, every guide links to at least 2 others via "Related Reading"
- Booking CTA prominent (Cal.com inline embed on /book)
- Mobile responsive, tap targets all ≥44×44px

## Critical issues

None blocking. No HTTPS issues. No noindex. No broken canonicals.

## AEO readiness breakdown (58/100)

- FAQ presence (3/12 guides have it), **biggest fix**
- Original data, 8/12 guides include original numbers/percentages, good
- Source attribution, inconsistent, some guides cite external sources well, others don't
- Content freshness, dateModified inconsistent (see fix #2)
- IndexNow, not set up
- Reddit/LinkedIn/YouTube, LinkedIn good, no Reddit presence, YouTube empty

---

## Next step

Run **`/ccai-seo-setup creativecore.ai`** to generate paste-ready Lovable prompts that fix the top 10 in order. The setup skill reads this report and outputs implementation prompts targeted at your stack.

Or: hand this REPORT.md to your developer and prioritize fixes 1-5 first.
```

---

## Sample per-page card: /guides/article-04

```markdown
# Audit: How to Pick the Right Hooks for Your Reels

**URL:** https://creativecore.ai/guides/article-04
**Audited:** 2026-05-12
**Page type:** article
**Overall page score:** 68 / 100
**AEO sub-score:** 55 / 100

## Scores by category

| Category | Score |
|---|---|
| Crawlability & indexation | 8/8 |
| Core Web Vitals + performance | 4/7 |
| Structured data | 3/6 |
| Open Graph + Twitter | 3/5 |
| AEO / AI search | 2/6 |
| EEAT signals | 4/5 |
| Accessibility-as-SEO | 3/4 |
| Mobile + tap targets | 3/3 |

## Critical issues

- **Item 4.3 og:image relative URL**
  - What's wrong: `<meta property="og:image" content="/og/article-04.png">`, relative path
  - Where: line 23 of `<head>`
  - How to fix: change to `https://creativecore.ai/og/article-04.png`
  - Effort: small / Impact: medium

## High-priority fixes

- **Item 5.1 No FAQPage schema**, 4 H2 questions in body but no JSON-LD; add FAQPage block referencing the 4 Q&As
- **Item 5.4 No visible Updated date**, JSON-LD has `dateModified: 2026-04-22` but page shows only `datePublished`
- **Item 3.5 Person schema for author**, author.name = "Cory Loflin" but no Person sub-object with sameAs

## Optimization opportunities

- **Item 2.5 Lazy-load images**, 6 images load eagerly; add `loading="lazy"` to images 2-6
- **Item 3.4 BreadcrumbList schema**, visual breadcrumb present, schema missing

## Notable wins

- Original data point: "82% of reels with native-hook patterns get >3× saves", exactly the kind of attributable stat AI engines cite
- Author byline visible with photo + role
- 3 internal links to related guides (good linking depth)
- Reading time visible
- Clean H2/H3 hierarchy
```

---

## What this audit gives you

A REPORT.md you can:

1. Hand directly to a developer with no SEO context, every fix has location + action
2. Feed into `ccai-seo-setup` to generate Lovable prompts for each fix
3. Re-run in 30 days to verify (the skill diffs against previous audits when available)
