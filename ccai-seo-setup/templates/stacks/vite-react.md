# Vite + React stack template

For Vite + React + TypeScript projects, regardless of hosting. Build-time prerender via a Vite plugin's `closeBundle` hook.

> **For setup runs:** read this template after the matching hosting template (e.g., `templates/hosting/lovable.md`). Hosting templates cover what's specific to your platform; this template covers the underlying Vite + React patterns that work on any host.

---

## Why a Vite plugin, not an npm script chain

Many hosted build platforms run `vite build` directly and ignore your `package.json` build script chain. Lovable does this; other "managed" hosts may too. The safest pattern is to put all build-time work inside a Vite plugin's `closeBundle` hook so it runs as part of `vite build` itself.

```ts
// vite.config.ts
import { defineConfig, type Plugin } from "vite";
import react from "@vitejs/plugin-react-swc";

function prerenderPlugin(): Plugin {
  return {
    name: "${YOUR_DOMAIN}-prerender",
    apply: "build",  // only run during `vite build`, not dev server
    async buildStart() {
      // Pre-bundle work that needs to happen BEFORE Vite writes dist/
      // e.g., generating OG images that index.html references via <meta og:image>
      try {
        const { generateOgImages } = await import("./scripts/generate-og-images");
        await generateOgImages();
      } catch (err) {
        this.warn(`[og] Skipped: ${(err as Error).message}`);
      }
    },
    async closeBundle() {
      // Post-bundle work after Vite has written dist/index.html
      const { prerenderRoutes } = await import("./scripts/prerender-routes");
      const { prerenderGuides } = await import("./scripts/prerender-guides");
      const { generateSitemap } = await import("./scripts/generate-sitemap");
      const { generateLlmsTxt } = await import("./scripts/generate-llms-txt");
      const { pingIndexNow } = await import("./scripts/indexnow-from-build");

      prerenderRoutes();    // emit dist/about.html, dist/products.html, etc.
      prerenderGuides();    // emit dist/guides/<slug>.html for each markdown file
      generateSitemap();    // emit dist/sitemap.xml
      generateLlmsTxt();    // emit dist/llms.txt
      await pingIndexNow(); // POST to api.indexnow.org for URLs with updated == today
    },
  };
}

export default defineConfig(({ mode }) => ({
  plugins: [
    react(),
    mode !== "development" && prerenderPlugin(),
  ].filter(Boolean),
  // ...
}));
```

The `apply: "build"` flag and the `mode !== "development"` guard prevent the plugin from running during `vite dev`, which would slow your dev server and emit production files into your local `dist/`.

---

## Node-compatible scripts (NOT Bun-only)

If you're prototyping with Bun locally, your build scripts may use Bun-specific APIs that fail in Node's runtime (which is what most hosted builds use). The most common offender:

```ts
// ❌ Bun-only, fails on Node
const ROOT = resolve(import.meta.dir, "..");
```

```ts
// ✅ Node + Bun compatible
import { fileURLToPath } from "node:url";
import { dirname, resolve } from "node:path";
const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(__dirname, "..");
```

Apply to every script the Vite plugin imports.

---

## Prerender script architecture

### scripts/prerender-routes.ts

Static list of top-level routes. Each route is an object with metadata + JSON-LD + body content. Loop emits `dist/<path>.html` AND `dist/<path>/index.html` for each.

```ts
import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const SITE = "${YOUR_SITE_URL}";
const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(__dirname, "..");
const DIST = join(ROOT, "dist");

interface RouteMeta {
  path: string;
  title: string;
  description: string;
  ogTitle?: string;
  ogDescription?: string;
  ogImage?: string;
  ogType?: string;
  jsonLd?: Record<string, unknown> | Record<string, unknown>[];
  bodyHtml?: string;  // Static body content for non-markdown routes
}

const ROUTES: RouteMeta[] = [
  {
    path: "/",
    title: "${YOUR_BUSINESS_NAME} · ${YOUR_BUSINESS_TAGLINE}",
    description: "${YOUR_BUSINESS_DESCRIPTION}",
    jsonLd: [/* Organization */, /* WebSite */],
    bodyHtml: "<h1>${YOUR_BUSINESS_NAME}</h1><p>${HOMEPAGE_INTRO_PARAGRAPH}</p>",
  },
  {
    path: "/about",
    title: "About ${YOUR_FOUNDER_NAME}, ${YOUR_FOUNDER_TITLE} of ${YOUR_BUSINESS_NAME}",
    description: "...",
    jsonLd: [/* Person */],
    bodyHtml: "<h1>About ${YOUR_FOUNDER_NAME}</h1><p>${BIO_PARAGRAPH_1}</p><p>${BIO_PARAGRAPH_2}</p><a href='${YOUR_BOOKING_URL}'>${YOUR_BOOKING_CTA}</a>",
  },
  // ... other routes
];

export function prerenderRoutes(): void {
  const template = readFileSync(join(DIST, "index.html"), "utf8");
  for (const route of ROUTES) {
    const headTags = buildHeadTags(route);
    let html = template.replace("</head>", `${headTags}\n</head>`);
    if (route.bodyHtml) {
      html = html.replace('<div id="root"></div>', `<div id="root">${route.bodyHtml}</div>`);
    }
    const slug = route.path === "/" ? "index" : route.path.slice(1);
    // Flat layout
    if (slug !== "index") writeFileSync(join(DIST, `${slug}.html`), html, "utf8");
    // Nested layout
    if (slug !== "index") {
      mkdirSync(join(DIST, slug), { recursive: true });
      writeFileSync(join(DIST, slug, "index.html"), html, "utf8");
    } else {
      writeFileSync(join(DIST, "index.html"), html, "utf8");
    }
  }
}
```

### scripts/prerender-guides.ts

Walks `${YOUR_GUIDES_DIR}/*.md`, parses frontmatter, renders markdown body to HTML, emits `dist/guides/<slug>.html` AND `dist/guides/<slug>/index.html` for each.

Key responsibilities:
1. Parse frontmatter (title, slug, published, updated, author, og_image, meta_description, canonical_url, category)
2. Render markdown body to HTML using the same library the runtime component uses
3. Rewrite internal links in the rendered HTML to match the canonical URL convention (e.g., `.html` if hosting requires it)
4. Build head metadata (title, description, canonical, og:*, Article JSON-LD, BreadcrumbList JSON-LD, FAQPage JSON-LD if 4+ qualifying Q&As)
5. Wrap body in article scaffold (`<article><header><h1>...</h1><p class="article-meta">...</p></header><div class="article-body">...</div></article>`)
6. Inject both head and body into the template
7. Write both flat and nested layouts

### scripts/generate-sitemap.ts

Builds `dist/sitemap.xml` from the route list + the guides directory. Each entry uses the `.html` URL convention (if hosting requires it). Sorts guides by `updated || published` descending. Appends `Sitemap:` line to `dist/robots.txt`.

### scripts/generate-llms-txt.ts

Builds `dist/llms.txt` following the llmstxt.org convention. Hardcoded "core pages" section + dynamic "guides" section auto-built from the markdown directory.

### scripts/indexnow-from-build.ts

Reads `${INDEXNOW_KEY}` from env or `.indexnow-key` file fallback. Walks the guides directory, finds entries where `updated || published == today UTC`, POSTs URLs to IndexNow. Logs result; never fails the build on IndexNow errors.

---

## Sentinel file pattern (debug-without-logs)

At the end of `closeBundle`, write a tiny diagnostic file:

```ts
import { readdirSync, writeFileSync } from "node:fs";
import { join } from "node:path";

const DIST = "dist";
const entries = readdirSync(DIST).join(", ");
writeFileSync(
  join(DIST, "PRERENDER_RAN.txt"),
  `closeBundle invoked: ${new Date().toISOString()}\ncwd: ${process.cwd()}\ndist entries: ${entries}\n`,
  "utf8"
);
```

After deploy: `curl ${YOUR_SITE_URL}/PRERENDER_RAN.txt`. 200 = plugin ran. 404 = plugin didn't run.

This is essential for hosts that don't expose build logs (Lovable being the example). Even on hosts that DO expose logs, the sentinel gives you a single URL to check from anywhere, no console-diving required.

---

## Body prerender (non-negotiable for SPAs)

A common failure mode: rich `<head>` with title, description, OG, canonical, JSON-LD, but the `<body>` is just `<div id="root"></div>`. This is ~45 bytes of body content. Bing won't index. AI crawlers won't read it. Only Google's JS-rendering crawler will see the content (after hydration), so Google Search Console makes the problem invisible.

The body prerender pass:

```ts
// In prerender-guides.ts, after rendering markdown to HTML:
const articleScaffold = `
  <article>
    <header>
      <h1>${escapeHtml(title)}</h1>
      <p class="article-meta">
        By ${escapeHtml(author)} · Published ${formatDate(published)}
        ${updated && updated !== published ? ` · Updated ${formatDate(updated)}` : ""}
      </p>
    </header>
    <div class="article-body">
      ${renderedMarkdownHtml}
    </div>
  </article>
`;

html = html.replace('<div id="root"></div>', `<div id="root">${articleScaffold}</div>`);
```

For top-level routes (no markdown source), hardcode body HTML in the route config (see `bodyHtml` field in the route entries above).

Verify after build:
```
curl -s ${YOUR_SITE_URL}/guides/<slug>.html | awk '/<body/,/<\/body>/' | wc -c
```
Anything under ~500 bytes for a content page means your body is empty.

---

## Internal link rewriting

If your hosting requires `.html` URLs (Lovable), rewrite internal links in the rendered markdown HTML before injecting it. Most markdown libraries emit `href="/guides/something"` for relative links written as `[text](/guides/something)`. These need to become `href="/guides/something.html"`.

Skip:
- Anchor links (`#section`)
- External URLs (anything not on `${YOUR_DOMAIN}`)
- Already-`.html` links
- `mailto:`, `tel:`, etc.

```ts
function rewriteInternalLinks(html: string, domain: string): string {
  return html.replace(/href="([^"]+)"/g, (match, href) => {
    if (href.startsWith("#")) return match;
    if (href.startsWith("mailto:") || href.startsWith("tel:")) return match;
    if (href.endsWith(".html")) return match;
    if (href.startsWith("http") && !href.includes(domain)) return match;
    // Match relative paths or absolute URLs on our domain
    const isOnDomain = href.startsWith("/") || href.includes(domain);
    if (!isOnDomain) return match;
    // Apply the .html convention
    const newHref = href.replace(/\/?$/, ".html");
    return `href="${newHref}"`;
  });
}
```

---

## Runtime React: react-helmet-async + HtmlSuffixStripper

While prerendered HTML covers crawlers and AI bots, the runtime React app still needs to manage page state during client-side navigation. Use `react-helmet-async` for runtime metadata updates (e.g., when a user clicks from one guide to another without a full page reload).

```tsx
// src/lib/seo.ts
export function setPageSEO(opts: { title: string; description: string; canonical: string; ... }) {
  // Sets document.title, updates <meta> tags, updates JSON-LD blocks
  // Returns a cleanup function for React's useEffect
}
```

Each page component calls `setPageSEO` in a `useEffect` on mount.

For the `.html` URL convention, add `HtmlSuffixStripper` inside `<BrowserRouter>`:

```tsx
const HtmlSuffixStripper = () => {
  const { pathname, search, hash } = useLocation();
  const navigate = useNavigate();
  useEffect(() => {
    if (pathname.endsWith(".html") && pathname !== "/index.html") {
      navigate(pathname.replace(/\.html$/, "") + search + hash, { replace: true });
    }
  }, [pathname, search, hash, navigate]);
  return null;
};
```

This handles the case where a user lands on a `.html` URL from a search engine result: the prerendered HTML loads with correct metadata, then React hydrates and strips `.html` from the address bar.

---

## Workflow: adding a new article

1. Create `${YOUR_GUIDES_DIR}/<slug>.md` with frontmatter:
   ```
   ---
   title: ...
   slug: ...
   published: YYYY-MM-DD
   updated: YYYY-MM-DD       # same as published initially
   author: ${YOUR_FOUNDER_NAME}
   meta_description: ...
   og_image: /og/<slug>.png  # generated by buildStart
   category: ...
   ---
   # Article body in markdown
   ```
2. Publish (commit + push, or click Publish on Lovable).
3. Build runs:
   - Vite builds the SPA bundle
   - `closeBundle` runs, which:
     - Generates OG image at `/og/<slug>.png`
     - Prerenders the article to `dist/guides/<slug>.html` AND `dist/guides/<slug>/index.html` with head metadata + body content + Article JSON-LD + BreadcrumbList JSON-LD (+ FAQPage JSON-LD if 4+ qualifying Q&As)
     - Adds the URL to `dist/sitemap.xml` with `lastmod = published`
     - Adds a line to `dist/llms.txt` under "Guides"
     - If `updated == today UTC`, POSTs the URL to IndexNow
4. No manual steps for routine new content.

## Workflow: updating an existing article

1. Edit the markdown body.
2. Bump `updated:` in frontmatter to today's date (UTC).
3. Publish.
4. Build runs, IndexNow auto-pings Bing with the updated URL. Google sees the new `dateModified` in JSON-LD + new `lastmod` in sitemap on its next crawl.

For a force re-crawl, run `bun run indexnow -- --all-guides` from a terminal that has the `.indexnow-key` file available.

---

## Cross-references

- Hosting-specific notes:
  - `templates/hosting/lovable.md`, the canonical case study for Vite + React on a constrained host
  - `templates/hosting/vercel.md`, lighter overlay; clean URLs work natively
  - `templates/hosting/netlify.md`, similar
  - `templates/hosting/cloudflare-pages.md`, similar
- `templates/META_PROMPT.md`, for customizing the 13 essential prompts to your site