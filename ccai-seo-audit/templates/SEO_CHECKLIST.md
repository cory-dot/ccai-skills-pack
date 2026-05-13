# Canonical SEO + AEO Checklist (2026)

> 55 items across 11 categories. Used by both `ccai-seo-audit` (to grade) and `ccai-seo-setup` (to implement). Keep these two files in sync.

Each item has:
- **What**, the check
- **Why**, why it matters in 2026
- **How to verify**, what an HTML-only crawl can see vs what needs pro tools
- **Severity**, critical / high / medium / low

---

## 1. Crawlability & indexation (8 items)

### 1.1 robots.txt valid + accessible
- **What:** `/robots.txt` returns 200 and parses cleanly
- **Why:** Without it, crawlers guess. Bad rules can deindex the entire site.
- **How:** Fetch the file, validate syntax
- **Severity:** critical

### 1.2 sitemap.xml accessible + referenced in robots.txt
- **What:** Sitemap URL is reachable, valid XML, and `Sitemap:` directive exists in robots.txt
- **Why:** Sitemaps are the canonical "what's on this site" signal. Especially important for AI crawlers (GPTBot, ClaudeBot, PerplexityBot).
- **How:** Fetch sitemap, parse XML
- **Severity:** critical

### 1.3 sitemap has accurate lastmod dates
- **What:** Every URL in sitemap has a `<lastmod>` tag, dates reflect actual update times
- **Why:** Crawlers prioritize fresh content. Stale lastmod = wasted crawl budget.
- **How:** Spot-check 5 random pages, compare lastmod to visible "updated" date
- **Severity:** medium

### 1.4 Site architecture: max 3 clicks deep
- **What:** No important page is more than 3 clicks from the homepage
- **Why:** Click-depth correlates with crawl frequency and ranking.
- **How:** Build link graph during crawl, compute shortest path from /
- **Severity:** high

### 1.5 Crawl budget not wasted
- **What:** No infinite-scroll, no faceted-nav URL explosions, no session-id URLs in sitemap
- **Why:** Google has limited crawl budget per site. Wasting it on duplicate URLs starves real content.
- **How:** Look for `?session=`, `?sort=`, calendar paginations in sampled URLs
- **Severity:** medium

### 1.6 No noindex on important pages
- **What:** No `<meta name="robots" content="noindex">` on pages that should rank
- **Why:** Most common own-goal in audits.
- **How:** Inspect every page's robots meta + X-Robots-Tag header
- **Severity:** critical

### 1.7 Canonical tags consistent + self-referencing
- **What:** Every page has `<link rel="canonical">` pointing at itself (absolute URL, HTTPS, trailing-slash convention matches sitemap)
- **Why:** Prevents duplicate-content scattering and signals the preferred URL.
- **How:** Inspect canonical on every page, flag mismatches
- **Severity:** high

### 1.8 No redirect chains or soft 404s
- **What:** Internal links don't chain through 2+ redirects; "not found" pages return real 404 status code
- **Why:** Chains lose PageRank; soft 404s pollute the index.
- **How:** During crawl, log redirect status codes. Visit /this-page-does-not-exist-xyz and check status
- **Severity:** high

---

## 2. Core Web Vitals + performance (7 items)

### 2.1 LCP under 2.5 seconds
- **What:** Largest Contentful Paint <2.5s on mobile
- **Why:** Core ranking factor since 2021.
- **How:** Free tier, estimate from HTML (image sizes, render-blocking resources). Pro tier, PageSpeed Insights API.
- **Severity:** critical

### 2.2 INP under 200 milliseconds
- **What:** Interaction to Next Paint <200ms (replaced FID in March 2024)
- **Why:** Measures real responsiveness. Heavy JS = INP failures.
- **How:** Free tier, flag heavy inline scripts + main-thread blockers. Pro tier, CrUX data.
- **Severity:** critical

### 2.3 CLS under 0.1
- **What:** Cumulative Layout Shift <0.1
- **Why:** Stops the "page jumps as you click" experience.
- **How:** Free tier, check images have width/height attributes, no late-loaded ads/banners. Pro tier, PSI.
- **Severity:** high

### 2.4 Visual Stability Index (VSI) acceptable
- **What:** Google's 2026 metric, content visibility stability over time
- **Why:** New ranking signal in 2026. Penalizes content that swaps or rebuilds during interaction.
- **How:** Look for client-side hydration patterns, late-injected content
- **Severity:** medium

### 2.5 Images: WebP/AVIF + responsive
- **What:** Modern formats used (WebP at minimum), `srcset` + `sizes` set
- **Why:** Cuts page weight 30-50%. Single biggest LCP win for most sites.
- **How:** Inspect every `<img>`, flag JPEG/PNG-only, missing srcset
- **Severity:** high

### 2.6 Fonts preloaded + critical CSS inlined
- **What:** Web fonts have `<link rel="preload">` and key above-fold CSS is inline
- **Why:** Prevents FOIT/FOUT and unblocks rendering.
- **How:** Inspect `<head>` for preload + inline `<style>`
- **Severity:** medium

### 2.7 Page weight + server response time
- **What:** Total transfer <1MB target (3MB hard ceiling), TTFB <600ms
- **Why:** Big pages = slow on mobile networks. Real users abandon.
- **How:** Sum response sizes during crawl; log TTFB per page
- **Severity:** medium

---

## 3. Structured data, JSON-LD (6 items)

### 3.1 JSON-LD format only (no microdata / RDFa)
- **What:** All structured data is in `<script type="application/ld+json">`
- **Why:** Google's preferred format. Cleaner, easier to maintain, doesn't pollute HTML.
- **How:** Look for `itemprop=` (microdata) or `vocab=` (RDFa), flag if found
- **Severity:** low (works but not preferred)

### 3.2 Article / BlogPosting schema on every content page
- **What:** Content pages have Article or BlogPosting JSON-LD with headline, author, datePublished, dateModified, image
- **Why:** Required for rich results in search, heavily used by AI search engines for citation attribution.
- **How:** Parse JSON-LD on each content page
- **Severity:** critical (for blogs)

### 3.3 Organization + WebSite schema on homepage
- **What:** Homepage has both Organization and WebSite JSON-LD with name, URL, logo, sameAs (social links), and SearchAction
- **Why:** Establishes brand entity for Google Knowledge Graph + AI search citation patterns.
- **How:** Parse homepage JSON-LD
- **Severity:** high

### 3.4 BreadcrumbList schema per page
- **What:** Every non-homepage page has BreadcrumbList JSON-LD
- **Why:** Shows in SERP as breadcrumb, helps AI engines map site hierarchy.
- **How:** Parse JSON-LD on each page
- **Severity:** medium

### 3.5 Person schema for authors + dedicated author pages
- **What:** Each author has a Person JSON-LD block linked from their content (`author.@id`) and a dedicated `/author/<name>/` page
- **Why:** Author authority is a 2026 EEAT priority. AI engines weight cited sources by author entity.
- **How:** Inspect author markup + check for author landing pages
- **Severity:** high

### 3.6 Validates in Rich Results Test
- **What:** No errors when run through Google's Rich Results Test
- **Why:** Errors mean the structured data is being ignored entirely.
- **How:** Free tier, local JSON-LD syntax validation; pro tier, actual Rich Results API call
- **Severity:** high

---

## 4. Open Graph + Twitter Cards (5 items)

### 4.1 og:title set, ≤60 chars
- **What:** Every page has `<meta property="og:title">` distinct from `<title>` if needed
- **Why:** Controls how the link looks when shared on social.
- **Severity:** medium

### 4.2 og:description set, ≤155 chars
- **What:** Every page has og:description
- **Why:** Click-through copy for social shares.
- **Severity:** medium

### 4.3 og:image, full URL, 1200×630 minimum
- **What:** Absolute HTTPS URL, dimensions ≥1200×630, file size <8MB, valid JPEG/PNG/WebP
- **Why:** Most-clicked element when previewed. Missing OG image = grey box = no clicks.
- **How:** Verify URL resolves + dimensions
- **Severity:** high

### 4.4 og:url + og:type
- **What:** og:url matches canonical, og:type set ("article" or "website")
- **Why:** Standard OG protocol completeness.
- **Severity:** low

### 4.5 twitter:card = summary_large_image
- **What:** Either `twitter:card` is set OR OG falls through correctly (most platforms auto-fall-through now)
- **Why:** Wider previews on Twitter/X drive more clicks.
- **Severity:** low

---

## 5. AEO / AI Search Optimization (6 items)

### 5.1 FAQ section with 4-6 natural-language Q&As
- **What:** Each major page (or site-wide FAQ page) has 4-6 conversational questions with concise answers, marked up with FAQPage schema
- **Why:** Highest-return AEO item. AI Overviews (now 48% of queries) cite FAQ answers heavily.
- **How:** Detect H2/H3 patterns ending in "?" + FAQPage JSON-LD
- **Severity:** critical (for AEO)

### 5.2 Original statistics, numbers, or data
- **What:** Content includes at least one original number/stat/data point, ideally with a chart or callout
- **Why:** AI engines preferentially cite content with attributable specific data over general claims.
- **How:** Heuristic, count `%`, `$`, numerals in body content; flag pages with zero
- **Severity:** high

### 5.3 Source attribution patterns
- **What:** External claims include source (publisher + year + link). Pattern: "According to [Source] (YYYY), ..."
- **Why:** AI engines mirror EEAT by citing well-cited content.
- **How:** Spot-check pages for outbound link patterns to authoritative domains
- **Severity:** medium

### 5.4 Content freshness signals
- **What:** Visible "Updated YYYY-MM-DD" date on every content page, matches `dateModified` in JSON-LD and `lastmod` in sitemap
- **Why:** AI engines penalize stale content. Three-signal consistency builds trust.
- **How:** Spot-check 5 pages for visible date + JSON-LD + sitemap alignment
- **Severity:** high

### 5.5 IndexNow API integration
- **What:** Site pings IndexNow on publish/update (instant Bing + Yandex indexing; ChatGPT search uses Bing index)
- **Why:** ChatGPT, Copilot, and Bing AI all use the Bing index. IndexNow = same-minute indexing instead of days.
- **How:** Check for IndexNow key file at `/<key>.txt` in root
- **Severity:** medium

### 5.6 Reddit / LinkedIn / YouTube footprint
- **What:** Brand has presence on at least 2 of: Reddit (subreddit posts), LinkedIn (regular posts), YouTube (channel with content)
- **Why:** AI search engines disproportionately cite Reddit and LinkedIn. YouTube videos get cited with timestamps.
- **How:** Manual check (free tier, flag as user task). Pro tier, auto-search citation patterns.
- **Severity:** medium

---

## 6. EEAT signals (5 items)

### 6.1 Author bios with proof-of-work
- **What:** Every content page has visible author with bio link, photo, credentials, and proof (links to past work / publications / accounts)
- **Why:** EEAT's "E" (Experience) is the differentiator in 2026.
- **How:** Inspect author markup + linked bio pages
- **Severity:** high

### 6.2 First-hand experience visible in content
- **What:** Content includes specific personal/business experience markers ("I tested this with X clients," "we ran this for 6 months," "our actual numbers were")
- **Why:** Google's December 2022 EEAT update added "Experience", first-hand is the new defensible moat vs AI-generated content.
- **How:** Heuristic flag, generic vs experiential language; sample 3 pages
- **Severity:** high

### 6.3 Citations + case studies + original data
- **What:** At least 30% of content pages cite external sources or include original case study / data
- **How:** Sample 10 pages, count outbound authoritative links + data presence
- **Severity:** medium

### 6.4 Contact + privacy + terms accessible
- **What:** Site has Contact page, Privacy Policy, Terms of Service, all linked from footer
- **Why:** Trust signals for both Google and AI engines.
- **How:** Check footer links + presence of standard pages
- **Severity:** medium

### 6.5 HTTPS everywhere
- **What:** Every page served over HTTPS, no mixed content warnings, HSTS header set
- **Why:** Ranking factor since 2014, hard requirement now.
- **How:** Check protocol + sample pages for `http://` references in source
- **Severity:** critical

---

## 7. Internationalization (5 items, optional)

### 7.1 hreflang self-referencing + reciprocal
- **What:** Every page in a localized cluster has hreflang tags pointing to all language versions AND to itself
- **Why:** Common own-goal, missing self-reference confuses Google.
- **Severity:** high (if multilingual)

### 7.2 Valid ISO codes + x-default
- **What:** Codes follow `language-region` (en-US, not en_US), `x-default` set for fallback
- **Severity:** high (if multilingual)

### 7.3 Multilingual canonicalization
- **What:** Each language version has its own canonical pointing to its own URL (not the English version)
- **Severity:** critical (if multilingual)

### 7.4 International sitemaps with xhtml namespace
- **What:** Sitemap includes `<xhtml:link rel="alternate" hreflang="...">` per URL
- **Severity:** medium (if multilingual)

### 7.5 Locale URL structure consistent
- **What:** Either subdirectory (/en/, /es/) or subdomain (en., es.), one pattern, applied consistently
- **Severity:** medium (if multilingual)

---

## 8. Local SEO (5 items, optional, local-service type)

### 8.1 NAP consistency
- **What:** Name + Address + Phone identical on site, Google Business Profile, and all directory listings
- **Severity:** critical (for local)

### 8.2 Google Business Profile optimized
- **What:** Verified, complete (hours, services, photos, primary + secondary categories), Q&A populated, reviews responded to
- **Severity:** critical (for local)

### 8.3 LocalBusiness schema
- **What:** Homepage has LocalBusiness JSON-LD with address, geo, hours, priceRange
- **Severity:** high (for local)

### 8.4 Location pages + local content
- **What:** Service-area businesses have a dedicated page per location with unique content (not just templated copy with city name swapped)
- **Severity:** high (for local)

### 8.5 Local citations on directories
- **What:** Consistent NAP on at least 10 directories, Yelp, BBB, industry-specific
- **How:** Manual (free tier flags as a task)
- **Severity:** medium (for local)

---

## 9. Accessibility-as-SEO (4 items)

### 9.1 WCAG 2.2 compliance
- **What:** No critical accessibility errors, color contrast, keyboard navigation, focus states
- **Why:** Legal risk in US/EU + correlates with Google quality signals.
- **How:** Free tier, heuristic checks (alt presence, contrast samples). Pro tier, axe-core audit.
- **Severity:** high

### 9.2 Alt text on all images, descriptive
- **What:** Every `<img>` has alt attribute; not empty unless decorative; descriptive (not "image1.jpg")
- **Severity:** high

### 9.3 Semantic HTML
- **What:** Uses `<article>`, `<nav>`, `<main>`, `<aside>`, `<header>`, `<footer>`, not just `<div>`s
- **Severity:** medium

### 9.4 Heading hierarchy
- **What:** Exactly one `<h1>` per page, logical H2/H3 nesting (no skipping levels)
- **Severity:** medium

---

## 10. Mobile + tap targets (3 items)

### 10.1 Viewport meta tag
- **What:** `<meta name="viewport" content="width=device-width, initial-scale=1">`
- **Severity:** critical

### 10.2 Tap targets ≥44×44px
- **What:** Buttons, links, form inputs are at least 44×44px on mobile
- **How:** Inspect CSS; flag small buttons
- **Severity:** medium

### 10.3 Content parity desktop ↔ mobile
- **What:** Mobile version isn't a stripped-down subset of desktop
- **Why:** Mobile-first indexing, Google ranks what mobile users see.
- **Severity:** high

---

## 11. Attribution + analytics + UTM (4 items)

### 11.1 UTM convention for outbound shares
- **What:** Documented UTM convention used consistently, `utm_source` (linkedin/instagram/email), `utm_medium` (social/email/referral), `utm_campaign` (specific)
- **Why:** Without UTMs, you can't tell which channel drives traffic.
- **Severity:** medium

### 11.2 Share-link auto-tagging
- **What:** "Copy link" / share buttons on site auto-append UTMs (e.g., `?utm_source=share&utm_medium=copy-link`)
- **Why:** Free attribution win, every social share gets tagged automatically.
- **Severity:** medium

### 11.3 GA4 (or Plausible) event tracking on CTAs
- **What:** Conversion events fire on key CTAs (form submit, "book a call" click, signup click)
- **Why:** Without event tracking, you can't optimize what works.
- **How:** Inspect homepage + key landing pages for analytics + event handlers
- **Severity:** high

### 11.4 Search Console + Bing Webmaster verified
- **What:** Both Google Search Console and Bing Webmaster Tools verify ownership and have sitemap submitted
- **Why:** Bing = where ChatGPT search and Copilot index from. Verify both, not just Google.
- **How:** Check `<meta name="google-site-verification">` and `<meta name="msvalidate.01">` (or DNS verification)
- **Severity:** high

---

## Scoring

Each item:
- **PASS**, fully meets the check
- **WARN**, partial / borderline
- **FAIL**, missing or broken

Page score = `(passes / total_applicable) × 100`

Site score = average of page scores, weighted by:
- Homepage: 3×
- Top-nav pages: 2×
- All other pages: 1×

AEO sub-score = items in categories 3, 5, 6 only.

Performance sub-score = category 2.
Accessibility sub-score = category 9.
