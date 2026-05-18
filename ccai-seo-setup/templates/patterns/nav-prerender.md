# Nav / footer / CTA prerender pattern

The most common SEO failure on Lovable Vite + React projects in 2026 is "metadata and body are prerendered correctly, but navigation, footer, and CTA links are JavaScript-only." Non-JS crawlers (Bingbot, GPTBot, ClaudeBot, PerplexityBot, social unfurls) see a content-rich page with zero outbound links, breaking link-graph signals and CTA discoverability.

This pattern fixes that. Use it AFTER body-content prerender is in place (the `closeBundle` Vite plugin pattern). It extends the prerender to inject site navigation, footer links, and per-page CTAs into the prerendered HTML.

> **Applies to:** Lovable + Vite + React (the canonical case). Adapts to other SPA + build-time prerender setups (Vite or Webpack) with minor tweaks. Not needed on Next.js (App Router handles this natively).

## Symptoms this fixes

Run these diagnostics first. If yes to any, you need this pattern:

```bash
# Are nav links in the HTML?
curl -s ${YOUR_SITE_URL}/ | grep -oE '<a [^>]*href="/[^"]*"' | wc -l
# Expected: 5+. Got 0-1? Nav is JS-only.

# Are nav links the SAME across multiple pages?
diff <(curl -s ${YOUR_SITE_URL}/ | grep -oE 'href="/[^"]*"' | sort -u) \
     <(curl -s ${YOUR_SITE_URL}/about.html | grep -oE 'href="/[^"]*"' | sort -u)
# Expected: small diff (page-unique links only). Got huge diff? Nav inconsistent or JS-only.

# Are article CTAs in the HTML?
curl -s ${YOUR_SITE_URL}/<some-article>.html | grep -F 'href="${YOUR_BOOKING_URL}"'
# Expected: at least one match. Got zero? CTAs are JS-only.
```

## The architectural fix

You need to write the nav, footer, and CTAs as **HTML strings during prerender**, not just as React components that hydrate at runtime. The React components stay (for client-side navigation), but the prerender step now also emits a static version into the HTML before the React root mounts.

### Pattern A: Shared HTML string functions

Create `scripts/prerender-partials.ts` (or `.js`) that exports HTML-string functions for nav and footer:

```ts
// scripts/prerender-partials.ts

// Update this map when you add a top-level route.
const NAV_LINKS = [
  { href: "/", label: "Home" },
  { href: "/guides.html", label: "Guides" },
  { href: "/blog.html", label: "Blog" },
  { href: "/about.html", label: "About" },
  { href: "/products.html", label: "Products" },
  { href: "/book.html", label: "Book a call" },
];

const FOOTER_LINKS = [
  { href: "/", label: "Home" },
  { href: "/about.html", label: "About" },
  { href: "/privacy.html", label: "Privacy" },
  { href: "/terms.html", label: "Terms" },
];

const SOCIAL_LINKS = [
  { href: "${YOUR_LINKEDIN_URL}", label: "LinkedIn" },
  { href: "${YOUR_TWITTER_URL}", label: "X" },
  { href: "${YOUR_GITHUB_URL}", label: "GitHub" },
  { href: "${YOUR_SKOOL_URL}", label: "Skool community" },
];

export function renderHeaderHTML(currentPath: string): string {
  const links = NAV_LINKS.map(({ href, label }) => {
    const isCurrent = href === currentPath ? ' aria-current="page"' : "";
    return `<a href="${href}"${isCurrent}>${label}</a>`;
  }).join("\n      ");
  return `
  <header class="prerender-header" role="banner">
    <a href="/" class="prerender-brand">${YOUR_BUSINESS_NAME}</a>
    <nav class="prerender-nav" aria-label="Main">
      ${links}
    </nav>
  </header>`;
}

export function renderFooterHTML(): string {
  const navLinks = FOOTER_LINKS.map(({ href, label }) => `<a href="${href}">${label}</a>`).join("\n      ");
  const socialLinks = SOCIAL_LINKS.map(({ href, label }) => `<a href="${href}" rel="noopener noreferrer">${label}</a>`).join("\n      ");
  return `
  <footer class="prerender-footer" role="contentinfo">
    <nav aria-label="Footer">
      ${navLinks}
    </nav>
    <nav aria-label="Social">
      ${socialLinks}
    </nav>
    <p>© ${new Date().getFullYear()} ${YOUR_BUSINESS_NAME}. All rights reserved.</p>
  </footer>`;
}

export function renderArticleCTAsHTML(): string {
  return `
  <section class="prerender-article-ctas" aria-label="Next steps">
    <h2>Where to go next</h2>
    <p>
      Two CTAs. Pick whichever fits.
    </p>
    <ul>
      <li><a href="${YOUR_SKOOL_URL}" rel="noopener noreferrer">Join the ${YOUR_BUSINESS_NAME} community on Skool</a> for daily discussion and templates.</li>
      <li><a href="${YOUR_BOOKING_URL}">Book a free diagnostic call</a> if you want a custom plan for your business.</li>
    </ul>
  </section>`;
}
```

### Pattern B: Inject into prerender pipeline

Wherever your prerender script writes `dist/<route>.html`, wrap the body content with header + footer (and CTAs for articles):

```ts
// scripts/prerender-routes.ts (or wherever you assemble route HTML)
import { renderHeaderHTML, renderFooterHTML, renderArticleCTAsHTML } from "./prerender-partials";

function assemblePageHTML({ route, headHTML, bodyContentHTML, isArticle }: {
  route: string;
  headHTML: string;
  bodyContentHTML: string;
  isArticle: boolean;
}): string {
  const header = renderHeaderHTML(route);
  const footer = renderFooterHTML();
  const ctas = isArticle ? renderArticleCTAsHTML() : "";

  return `<!DOCTYPE html>
<html lang="en">
<head>
${headHTML}
</head>
<body>
<div id="root">
${header}
<main>
${bodyContentHTML}
${ctas}
</main>
${footer}
</div>
<script type="module" src="/src/main.tsx"></script>
</body>
</html>`;
}
```

### Pattern C: React hydration coexistence

The React app on hydration will render its own header/footer/CTAs (because those components are part of `App.tsx`). If you don't handle this, the user sees double headers briefly during hydration.

Two approaches:

**Approach 1 — Remove prerender partials at hydration.** In your root React component, on mount, remove `.prerender-header`, `.prerender-footer`, `.prerender-article-ctas` from the DOM:

```tsx
// src/components/PrerenderCleanup.tsx
import { useEffect } from "react";

export const PrerenderCleanup = () => {
  useEffect(() => {
    document.querySelectorAll(".prerender-header, .prerender-footer, .prerender-article-ctas")
      .forEach((el) => el.remove());
  }, []);
  return null;
};
```

Place this inside `<App>` so it runs once after hydration. The React app then renders its own header/footer/CTAs in their place, with full interactivity.

**Approach 2 — Detect prerendered partials and skip rendering.** In each component, check for the prerendered DOM and bail:

```tsx
// In src/components/Header.tsx
export const Header = () => {
  if (document.querySelector(".prerender-header")) return null;
  return /* the real interactive header */;
};
```

Approach 1 is simpler and more robust. Use it unless you have a specific reason not to.

## The Lovable prompt to apply this

Paste the following into Lovable's chat. Substitute the `${VARIABLES}` first (use `templates/META_PROMPT.md` for that):

```
Add a navigation, footer, and CTA prerender layer to our build. This is an extension of the existing closeBundle Vite plugin prerender; the goal is to ensure that <a href> links to nav routes, footer routes, and article CTAs appear in the prerendered HTML before React hydrates, so that non-JS crawlers (Bing, GPTBot, ClaudeBot, social unfurl bots) can traverse the site.

Create `scripts/prerender-partials.ts` with three exported functions:
1. `renderHeaderHTML(currentPath: string): string` — returns a <header> block with our brand link to "/" and nav links to: ${NAV_ROUTES_COMMA_SEPARATED}. Use the actual production URLs (e.g., "/guides.html" not "/guides").
2. `renderFooterHTML(): string` — returns a <footer> block with footer nav links to: ${FOOTER_ROUTES} and social links to: ${SOCIAL_URLS}.
3. `renderArticleCTAsHTML(): string` — returns a <section> with our two CTAs as anchor tags: a link to ${YOUR_SKOOL_URL} and a link to ${YOUR_BOOKING_URL}.

Then modify our prerender route assembly (likely in scripts/prerender-routes.ts and scripts/prerender-guides.ts or whichever files write dist/*.html during closeBundle) to:
- Always inject the header HTML at the top of <body>
- Always inject the footer HTML at the bottom of <body>
- On article/blog pages (any route under /guides/ or /blog/), inject the CTA section after the article body

Finally, add a PrerenderCleanup component to src/components/ that removes elements with classes .prerender-header, .prerender-footer, .prerender-article-ctas on mount. Add <PrerenderCleanup /> at the top of <App> so the real React-rendered nav/footer/CTAs can take over after hydration.

After this is applied, verify by running:
  curl -s ${YOUR_SITE_URL}/ | grep -oE '<a [^>]*href="/[^"]*"' | sort -u
  # Expected: a list of 5+ nav links (/, /guides.html, /blog.html, /about.html, etc.)

  curl -s ${YOUR_SITE_URL}/guides/some-article.html | grep -F 'href="${YOUR_BOOKING_URL}"'
  # Expected: at least one match (the booking CTA at the end of the article)

  curl -s ${YOUR_SITE_URL}/guides/some-article.html | grep -F 'href="${YOUR_SKOOL_URL}"'
  # Expected: at least one match (the Skool CTA at the end of the article)
```

## Verification

After Lovable publishes:

1. **Nav presence:** `curl -s ${SITE}/ | grep -oE '<a [^>]*href="/[^"]*"' | sort -u` returns ≥5 unique nav links.
2. **Nav consistency:** Same query on `/about.html` returns substantially the same set (small diff for page-unique current-page styling is OK).
3. **Article CTAs:** `curl -s ${SITE}/guides/<slug>.html | grep -E 'href="(${YOUR_SKOOL_URL_REGEX}|${YOUR_BOOKING_URL})"'` returns at least 2 matches.
4. **Footer:** `curl -s ${SITE}/ | grep -E 'href="(/privacy.html|/terms.html)"'` returns matches.
5. **No visual double-header during hydration.** Open the site in a browser, hard refresh, verify nav doesn't visibly duplicate.

If verification fails, the most likely cause is the `closeBundle` plugin isn't running (check the sentinel file). The second most likely is the prerender partials aren't being included in the assembly function — re-check the prerender route script for the function calls.

## Related patterns

- `templates/patterns/related-articles.md` — auto-generated cross-links between articles, fixes Checklist 12.5
- `templates/hosting/lovable.md` — the canonical Lovable case study, includes Section 6 (nav/footer/CTA check) and Section 4 (body content prerender) as upstream dependencies
