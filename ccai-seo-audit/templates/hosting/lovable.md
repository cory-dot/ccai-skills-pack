# Lovable hosting overlay (audit-side)

Platform-specific checks to run when the audit detects a Lovable-hosted site. These supplement the main 60-item checklist.

> **Updated 2026-05-17** for Lovable's May 13, 2026 native SEO release. Key behavioral changes since previous version of this overlay:
> - New Lovable projects (May 13+) default to TanStack Start with full SSR — most architectural prerender issues no longer apply.
> - Existing Vite + React projects (overwhelming majority of Lovable sites) get an "auto-prerender" that snapshots `index.html` only. Route components do not execute. Per-route meta, body, JSON-LD, H1, canonical, nav, footer, CTAs — none of these reach prerendered HTML unless the user has a custom prerender plugin.
> - Lovable now ships auto-generated `sitemap.xml`, `robots.txt`, `llms.txt`, and basic head tags on Vite + React projects. Audit should credit these as wins, not flag them as missing.
> - Lovable's new "Try to fix" SEO review tool is a different beast from the old "Improve SEO" panel. See Section 5 below.

## Detection signatures

Lovable hosting is identified by any of:
- HTML contains `<script defer src="/~flock.js"` (Lovable's analytics injection)
- HTML contains `data-proxy-url="/~api/analytics"`
- OG image URLs point to `pub-<uuid>.r2.dev/...lovable.app-<id>.png` (preview environment leakage; common in older deploys)
- DNS shows Cloudflare in front (not unique to Lovable, but in combination with the above is a strong signal)

## What Lovable now ships natively (May 13, 2026 release)

On a default Vite + React Lovable project with no custom prerender, the following are present out of the box. Audit should detect and credit these as wins:

- **`sitemap.xml`** — auto-generated with the project's known top-level routes. Note: usually does NOT include dynamic routes (e.g., `/product/:id`, `/blog/:slug`). Flag missing dynamic routes as a finding.
- **`robots.txt`** — auto-generated with bot-specific allows (Googlebot, Bingbot, Twitterbot, facebookexternalhit) and a `Sitemap:` directive.
- **`llms.txt`** — auto-generated with structured "Pages" and "Optional" sections.
- **Site-wide JSON-LD** — Organization + WebSite blocks in `index.html`'s head. Note: this is NOT per-page schema; do not credit as Article/Product schema presence.
- **HTTPS + HSTS + standard security headers** — Cloudflare-in-front gives these by default.

These items used to require a custom build script chain (which Lovable's hosted build doesn't run). With the May 13 release, they're handled at the platform level. Substantial improvement; treat the basics as solved for new Lovable users.

## Mandatory extra checks for Lovable sites

### 1. SPA fallback for clean URLs

Test:
```
curl -s ${SITE}/some-route       | grep -oi "<title>[^<]*"
curl -s ${SITE}/some-route.html  | grep -oi "<title>[^<]*"
```

If the `.html` version returns a different (correct) title and the clean URL returns the homepage title, the host is falling through to SPA fallback for clean URLs. This is normal Lovable behavior and means the site needs the `.html` URL workaround (see `ccai-seo-setup templates/hosting/lovable.md`).

Findings to log:
- "Lovable hosting falls through to SPA fallback for clean URLs. Prerendered `.html` files exist but clean URLs in the sitemap/canonicals/internal links serve the SPA fallback (homepage HTML)." (HIGH severity if sitemap uses clean URLs; LOW if sitemap correctly uses `.html` URLs)

### 2. npm script chain executed in production?

Test: check for sentinel files, post-build artifacts, or files that should exist if the npm chain ran:
- `${SITE}/sitemap.xml` — should exist if the user has any sitemap script
- `${SITE}/PRERENDER_RAN.txt` — if the user uses this pattern, it tells you exactly when the build ran
- `${SITE}/<route>.html` for a known top-level route — should exist if a prerender script runs

If these are 404 but the user has corresponding scripts in `package.json`, the scripts aren't running on production. Lovable's hosted build runs `vite build` only.

Findings to log:
- "package.json's build script chain is not executed by Lovable hosting. Only `vite build` runs. Any prerender/sitemap/OG/IndexNow scripts chained after `vite build` are dead in production." (CRITICAL if dependent SEO infrastructure isn't running)

### 3. Empty body trap

This is the highest-impact Lovable-specific finding (also applies to other SPAs, but Lovable's hosting makes it especially common). See main checklist Step 2.6 for the body-size check methodology.

For Lovable sites, the typical pattern is:
- Vite builds the SPA bundle
- Lovable's host serves `dist/index.html` for every URL not exactly matching a file
- `dist/index.html` has rich `<head>` (if `react-helmet-async` is wired) BUT an empty `<body>` (just `<div id="root"></div>`)
- After hydration, the body has content; before hydration, it's empty
- Googlebot renders JS → indexes correctly → masks the problem in Google Search Console
- Bingbot doesn't → flags as "Discovered but not crawled" with vague error
- AI crawlers don't → skip the content for citation

Findings to log:
- "All page bodies under 200 bytes. Non-JS crawlers (Bingbot, GPTBot, ClaudeBot, PerplexityBot, social unfurl bots) see no content. Critical." (CRITICAL)

### 4. Internal link convention mismatch

If the canonical URL convention is `.html` but internal links point to clean URLs (`/guides/something` instead of `/guides/something.html`), this compounds the deduplication problem on Bing. Step 5.5 in the main SKILL.md.

### 5. Lovable's "Try to fix" SEO review tool blind spots (May 2026)

Lovable replaced the older "Improve SEO" panel with a "Try to fix" review tool in their May 13, 2026 release. The new tool checks more items and applies fixes with one click. The blind spot:

**The tool checks the project source state, not the deployed HTML.** When it marks an item as "Fixed," it means Lovable's AI has updated the React component source code. On a Vite + React project (the majority of Lovable sites), those source changes don't reach the prerendered HTML because the auto-prerender doesn't execute route components.

Common "Fixed" claims that don't reach the crawler on Vite + React Lovable projects:

| "Try to fix" claim | What actually happens on Vite + React |
|---|---|
| "Search results show the same title for all pages — Fixed" | Per-route `<title>` is set in a React component via `useEffect` / `<Helmet>`. The component never runs during prerender. All routes still serve the same `<title>` in HTML. |
| "Social previews are the same for every page — Fixed" | Same architectural cause. OG tags set per-route in React still serve identically to all crawlers. |
| "Pages are missing schema for rich results — Fixed" | Per-page JSON-LD added to React components, but the prerendered HTML still only contains the site-wide schema in `index.html`. |
| "Headings are out of order — Fixed" | Heading hierarchy fixed in React JSX, but prerendered HTML still has no `<h1>` element. |
| "Page loads slowly — Fixed" | Loosely meaningful (Lighthouse score may improve from JS optimizations) but does nothing for crawlers that don't execute JS. |
| "Sitemap missing — Fixed" | **Actually fixed.** Lovable generates `sitemap.xml` as a static file. ✓ |
| "AI summary missing / llms.txt — Fixed" | **Actually fixed.** Lovable generates `llms.txt` as a static file. ✓ |

**The diagnostic:** any "Fixed" item from the Lovable review tool that touches per-route content (title, meta, OG, JSON-LD, H1, canonical, body content) MUST be curl-verified before the audit accepts it. Static-file fixes (sitemap, robots.txt, llms.txt) are reliable.

**Communicate this to the user as part of the audit:** they may have just run "Try to fix" and seen all-green checkmarks. The audit is the external verification step that catches what the Lovable tool's source-state check misses.

### 5a. Old "Improve SEO" panel false positives (pre-May-2026, legacy)

The older Lovable scanner is now replaced by "Try to fix" but some users may have sites that were audited under the old version. Pattern was the same in the opposite direction — the scanner crawled clean URLs and fell into SPA-fallback, reporting issues that weren't actually broken on prerendered `.html` URLs. Verify any such reports with curl.

### 6. Nav / footer / CTA prerender check (Checklist Category 12)

This is the most common newly-emerging failure on Lovable sites in 2026: per-page content is prerendered correctly, but the navigation header, footer links, and article CTAs remain React components that only render after JS hydration.

Diagnostic curls:

```bash
# Homepage internal links
curl -s ${SITE}/ | grep -oE '<a [^>]*href="/[^"]*"' | sort -u

# Same for an article
curl -s ${SITE}/<article-url> | grep -oE '<a [^>]*href="/[^"]*"' | sort -u

# Compare the sets. If they DON'T overlap on 3+ links (a shared nav), nav is JS-only.
```

Findings to log (severity per Category 12 thresholds):

- "Homepage has fewer than 5 internal links in prerendered HTML. Site navigation is JavaScript-only; crawlers cannot traverse the site beyond the sitemap." (CRITICAL)
- "Articles have zero internal cross-links. Brand CTAs (Skool, booking URL, etc.) are not present as `<a href>` in HTML — they're React components without anchor tags." (HIGH)
- "Footer links not in prerendered HTML." (MEDIUM)

Fix path: see `ccai-seo-setup templates/patterns/nav-prerender.md` and `templates/patterns/related-articles.md`.

### 7. Lovable preview environment URL leakage

Some Lovable sites have OG images pointing at preview environment URLs (`pub-<uuid>.r2.dev/...lovable.app-<id>.png`) instead of the production domain. These often 404 once the preview is wiped.

Test:
```
curl -sI <og:image URL> | head -1
```

If 404, the og:image is broken and social shares will fall back to no image. Finding: "OG image URL points at deprecated Lovable preview environment, returns 404. Update og:image to a production-domain URL (e.g., `${YOUR_SITE_URL}/og-image.png`)."

## Recommended fix sequence on Lovable

If multiple Lovable-specific issues are flagged, the fix sequence in the setup skill is:

1. Soft-404 noindex (small, no dependencies)
2. Vite plugin for prerender (foundation for everything else)
3. Body content prerender (the empty-body trap fix)
4. `.html` URL workaround (sitemap + canonicals + internal links + HtmlSuffixStripper)
5. Per-page metadata + JSON-LD bake-in
6. Re-ping IndexNow with the now-correct URLs
7. Manual Request Indexing in GSC + Bing for the homepage and top 5-10 pages

See `ccai-seo-setup templates/hosting/lovable.md` for the full prompt sequence.