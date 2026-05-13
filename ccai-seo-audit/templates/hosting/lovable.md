# Lovable hosting overlay (audit-side)

Platform-specific checks to run when the audit detects a Lovable-hosted site. These supplement the main 50+ item checklist.

## Detection signatures

Lovable hosting is identified by any of:
- HTML contains `<script defer src="/~flock.js"` (Lovable's analytics injection)
- HTML contains `data-proxy-url="/~api/analytics"`
- OG image URLs point to `pub-<uuid>.r2.dev/...lovable.app-<id>.png` (preview environment leakage; common in older deploys)
- DNS shows Cloudflare in front (not unique to Lovable, but in combination with the above is a strong signal)

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

### 5. Lovable's own "Improve SEO" panel false positives

The user may have already run Lovable's built-in SEO scanner and have a list of issues from it. The audit should explicitly verify those findings against live HTML before treating them as ground truth. Common Lovable panel false positives:

- "Sitemap is missing" → curl `${SITE}/sitemap.xml`; if 200 with valid XML, the panel is wrong.
- "Social previews are generic" / "OG URL is hardcoded to homepage" → curl the prerendered `.html` URLs and check `og:title`/`og:url`; if per-page, the panel is wrong.
- "Pages are missing schema for rich results" → curl `.html` URLs and grep for `application/ld+json`; if present, the panel is wrong.

The pattern: Lovable's scanner crawls clean URLs and falls into the same SPA-fallback trap a naive crawler would, while the prerendered `.html` versions Google indexes have the right metadata. Verify with curl.

### 6. Lovable preview environment URL leakage

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