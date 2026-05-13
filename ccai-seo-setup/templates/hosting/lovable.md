# Lovable hosting template

Lovable (lovable.dev) hosts Vite + React + TypeScript SPAs. You describe changes in natural language; Lovable's AI applies them; you click Publish to deploy to production. Both the AI and the hosting layer have specific behaviors that affect SEO, and most of them are not documented in Lovable's UI.

This template is the canonical case study for SEO on Lovable. Other hosts have lighter overlays.

> **For setup runs:** read this template first, then the matching stack template (`templates/stacks/vite-react.md` by default). The hosting template covers what's different about Lovable; the stack template covers the underlying Vite + React patterns.

---

## What Lovable does in production

Verified by curl + sentinel diagnostics on a live Lovable site (2026-05-13):

1. **Production build runs `vite build` only.** Lovable's hosted build does NOT execute your `package.json` `build` script chain. If your `build` looks like `"vite build && bun run prerender && bun run sitemap"`, only the `vite build` part runs in production. The rest is dead weight on the deployed site, even though it runs fine in Lovable's preview environment.

2. **SPA fallback is hardcoded at the infra level.** There is no `_redirects` file, no `vercel.json`, no `_routes.json`, no UI flag to configure routing. Every URL not matching an exact file in `dist/` falls through to `dist/index.html`. This means:
   - `/products.html` serves `dist/products.html` (if it exists). ✅
   - `/products/index.html` serves that file (if it exists). ✅
   - `/products` falls through to `dist/index.html` (SPA fallback). The host does NOT try `/products.html` or `/products/index.html` first. ❌
   - Result: clean URLs return homepage HTML regardless of whether prerendered files exist for those paths.

3. **No build logs visible to the user.** You cannot see what ran, what errored, what files were emitted, or which environment variables were available at build time. The only signal you get is "Publish succeeded."

4. **Runtime secrets are not reliably plumbed into Vite's build env.** Setting `INDEXNOW_KEY` in Lovable's Settings → Secrets does not guarantee `process.env.INDEXNOW_KEY` is readable from a Vite build script. Always provide a file-based fallback (`.indexnow-key` in repo root) for any secret that build scripts need.

5. **Cloudflare in front, no real edge logic.** Lovable serves through Cloudflare with `Cache-Control: no-cache, must-revalidate, max-age=0` on HTML. You CAN put your own Cloudflare in front of the Lovable origin if you want Worker logic, but doing so is going to the trouble of a partial migration.

6. **Lovable's "Improve SEO" panel is blind to Lovable's hosting.** Their internal scanner crawls clean URLs and falls into the same SPA-fallback trap a real naive crawler would. Their panel will tell you the sitemap is missing, social previews are broken, and schema is absent, all of which can be verifiably false against the live HTML. Treat the panel as a hint, not a verdict. Use curl + Google Search Console + Bing Webmaster Tools + Rich Results Test as your real auditors.

---

## What "fix SEO on Lovable" actually means

You're building around the constraints above, not removing them. The architecture that works on Lovable:

### 1. Move all build-time work into a Vite plugin

Lovable runs `vite build`. So everything that touches `dist/` after Vite writes it must run inside `vite build`. Use the `closeBundle` hook:

```ts
// vite.config.ts
import type { Plugin } from "vite";

function prerenderPlugin(): Plugin {
  return {
    name: "${YOUR_DOMAIN}-prerender",
    apply: "build",
    async closeBundle() {
      const { prerenderRoutes } = await import("./scripts/prerender-routes");
      const { prerenderGuides } = await import("./scripts/prerender-guides");
      const { generateSitemap } = await import("./scripts/generate-sitemap");
      const { pingIndexNow } = await import("./scripts/indexnow-from-build");
      prerenderRoutes();
      prerenderGuides();
      generateSitemap();
      await pingIndexNow();
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

All scripts must be Node-compatible. `import.meta.dir` (Bun-only) does not work in Lovable's hosted build. Use:

```ts
import { fileURLToPath } from "node:url";
import { dirname, resolve } from "node:path";
const __dirname = dirname(fileURLToPath(import.meta.url));
const ROOT = resolve(__dirname, "..");
```

### 2. Always emit a sentinel file

End of `closeBundle`, write `dist/PRERENDER_RAN.txt` with a timestamp and the directory listing. After publish, curl it. If you get 200, your plugin ran. If you get 404, it didn't:

```ts
import { writeFileSync, readdirSync } from "node:fs";
import { join } from "node:path";

const entries = readdirSync(DIST).join(", ");
writeFileSync(
  join(DIST, "PRERENDER_RAN.txt"),
  `closeBundle invoked: ${new Date().toISOString()}\ncwd: ${process.cwd()}\ndist entries: ${entries}\n`,
  "utf8"
);
```

This is the only forensic tool you have when Lovable doesn't expose build logs. Free, ten lines.

### 3. Use the `.html` URL convention site-wide

Because Lovable's SPA fallback eats clean URLs, the sitemap, internal links, canonical tags, and OG URL values must all use `.html` URLs explicitly. Then a small React component strips `.html` from the address bar after hydration so users see clean URLs.

The prerender script emits BOTH layouts (flat `dist/products.html` AND nested `dist/products/index.html`). This is portable; if you ever migrate to Vercel/Netlify/Cloudflare Pages (which all resolve clean URLs natively), you can swap the sitemap and internal links back to clean URLs without rebuilding the prerender output.

```tsx
// src/components/HtmlSuffixStripper.tsx
import { useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";

export const HtmlSuffixStripper = () => {
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

Place inside `<BrowserRouter>` in `App.tsx`.

### 4. Prerender BOTH head AND body

The single most common Lovable + Vite SPA failure mode: rich `<head>` metadata, empty `<body>` (just `<div id="root"></div>`). Bing flags affected URLs as "Discovered but not crawled." AI crawlers (GPTBot, ClaudeBot, PerplexityBot) skip the content entirely. Google indexes anyway (renders JS), so the problem is invisible in Google Search Console.

The body prerender pass:
1. Parse markdown body (already loaded for FAQ extraction if using prompt 05)
2. Render to HTML using the same markdown library the runtime component uses
3. Inject into `<div id="root">` wrapper with article scaffold (header, H1, article-meta, article-body)
4. For top-level routes (no markdown source), hand-write body content blocks in the route config

After build, verify:
```
curl -s ${YOUR_SITE_URL}/guides/<some-slug>.html | awk '/<body/,/<\/body>/' | wc -c
```

Anything under 500 bytes for a content page means your body is empty.

### 5. Rewrite internal links to match canonical URL convention

When the prerender renders markdown to HTML, do a final pass that rewrites any internal href ending in a clean URL (`/guides/something`) to the `.html` form (`/guides/something.html`). Inconsistency causes search engine deduplication to pick the wrong canonical (Bing observed: picked `/guides.html` as canonical of the entire site when all article URLs had empty bodies AND internal links pointed at clean URLs).

Skip anchor links, external URLs, mailto:, tel:, and already-`.html` links.

### 6. Provide file-based fallbacks for all build-time secrets

Lovable secrets are not reliably plumbed into Vite's build env. Pattern:

```ts
import { existsSync, readFileSync } from "node:fs";
import { resolve } from "node:path";

function getIndexNowKey(): string | undefined {
  const env = process.env.INDEXNOW_KEY;
  if (env) return env;
  const file = resolve(ROOT, ".indexnow-key");
  if (existsSync(file)) return readFileSync(file, "utf8").trim();
  return undefined;
}
```

Commit `.indexnow-key` to the repo. IndexNow keys aren't really secret (the key file is publicly served at `/<key>.txt` by design), so committing the key file is fine. Same pattern for any other key your build scripts need.

### 7. Manual Request Indexing after major changes is non-optional

Lovable's hosted build doesn't trigger search engine re-crawl by itself. After any structural SEO change (template, schema, hosting move, body prerender), open Google Search Console and Bing Webmaster Tools, run URL Inspection on every important URL, and click Request Indexing. Both consoles support it; GSC has a daily quota of ~10-12 manual requests per property, Bing is more lenient.

This is the difference between "fixes visible in search results within 24-48 hours" and "fixes visible in search results in 3-6 weeks." Not optional after a major overhaul.

---

## Per-fix Lovable prompt skeleton

All Lovable prompts are conversational instructions Lovable's AI executes. Format:

```
${PLAIN_ENGLISH_DESCRIPTION_OF_WHAT_TO_DO}

${SPECIFIC_FILES_AND_FUNCTIONS}

${EXACT_CODE_OR_PATTERN}

After this is applied, verify by running:
  curl -s ${YOUR_SITE_URL}/<some-path> | grep <something>
  # Expected: <result>
```

Always include a curl verification step. Lovable will say "Done" but the only way to know it's actually deployed is to curl.

---

## The 13 essential Lovable prompts

These are the prompts a Lovable + Vite + React content site needs, in dependency order. Each prompt is paste-ready (after variable substitution via `templates/META_PROMPT.md`).

1. **Soft-404 fix** (noindex injection on NotFound page). Stand-alone, no dependencies.
2. **Vite plugin for per-page metadata prerender** (`closeBundle` pattern, Node-compatible scripts, sentinel file). Foundation for everything below.
3. **Body content prerender** (the empty-body trap fix). Extends prompt 2.
4. **`.html` URL workaround** (sitemap, canonicals, internal links, HtmlSuffixStripper). Required on Lovable.
5. **Article + BreadcrumbList + FAQPage JSON-LD on guides**. Depends on 2 + 3.
6. **/about page with Person schema + OG image**. Depends on 2.
7. **Homepage Organization + WebSite schema + sameAs + founder @id**. Depends on 6.
8. **Updated date pattern** (frontmatter + visible UI + sitemap lastmod + JSON-LD dateModified). Depends on 5.
9. **/guides hub upgrade** (intro + clusters + CollectionPage + ItemList). Depends on 2.
10. **IndexNow integration with file fallback + auto-ping on build**. Depends on 2.
11. **UTM auto-tagging on share buttons**. Stand-alone.
12. **llms.txt auto-generation** (build-time, AI-crawler discovery). Depends on 2.
13. **GSC + Bing Webmaster verification meta tags** (placeholders Cory swaps in). Stand-alone.

For the prompt text (generic, with `${VARIABLES}`), see `templates/PROMPTS.md` (or the published companion article at https://creativecore.ai/guides/fixing-lovable-seo.html for a narrative walkthrough of why each one exists).

---

## Verification per fix (Lovable-specific quirks)

| Fix | Verify by |
|---|---|
| 01 noindex | `curl -s ${SITE}/some-bad-url \| grep noindex` (the 404 page must inject the meta) |
| 02 Vite plugin | `curl ${SITE}/PRERENDER_RAN.txt` returns 200 with timestamp |
| 03 Body prerender | `curl ${SITE}/guides/<slug>.html \| awk '/<body/,/<\/body>/' \| wc -c` ≥ 1000 bytes |
| 04 `.html` workaround | `curl ${SITE}/products.html` returns correct page; `${SITE}/products` returns homepage (SPA fallback, confirms host behavior) |
| 05 Guide schemas | `curl ${SITE}/guides/<slug>.html \| grep -c "application/ld+json"` returns 2 or 3 |
| 06 /about | `curl -sI ${SITE}/about.html` returns 200; `curl ${SITE}/about.html \| grep '"@type":"Person"'` matches |
| 07 Homepage schema | `curl ${SITE}/ \| grep -A 2 sameAs` shows your social URLs |
| 08 Updated dates | `curl ${SITE}/sitemap.xml \| grep -B 1 -A 2 <slug>` shows correct lastmod |
| 09 /guides hub | `curl ${SITE}/guides.html \| grep -oE '"position":[0-9]+'` shows all guide positions |
| 10 IndexNow | `curl ${SITE}/<key>.txt` returns the key; manual POST returns HTTP 200 or 202 |
| 11 UTM share | Open site in browser, click copy-link, paste URL, verify `utm_*` params |
| 12 llms.txt | `curl ${SITE}/llms.txt` returns markdown |
| 13 GSC + Bing meta | `curl ${SITE}/ \| grep google-site-verification` matches |

For all of these: the curl command is non-negotiable. Lovable's UI saying "Done" is necessary but not sufficient.

---

## Common Lovable failure modes (and how to diagnose them)

| Symptom | Likely cause | Diagnostic |
|---|---|---|
| "Publish succeeded" but curl returns old content | Build didn't actually deploy, or Cloudflare cached stale HTML | Check sentinel file timestamp; check `Cache-Control` headers |
| Sentinel file 404 | Vite plugin didn't run | Lovable's hosted build may not be running the plugin. Check `mode !== "development"` guard is correct. |
| Sentinel file 200 but per-page content still serves homepage | Files emitted to wrong path, or SPA fallback is intercepting | Check sentinel body for `dist entries:` listing; check if file exists at expected path |
| `/products` serves homepage but `/products.html` serves correct page | This is normal Lovable behavior. SPA fallback for clean URLs. | Use `.html` URL convention site-wide (prompt 04). |
| Body is empty (45 bytes) but head metadata is correct | Body prerender step missing or broken | Run prompt 03 (body prerender) |
| Bing says "Discovered but not crawled" | Empty body OR stale cache from before body prerender | Verify body is non-empty, then Request Indexing in Bing |
| Google Search Console shows old content under "Crawled page" but live HTML is correct | Google hasn't re-crawled since fixes shipped | Manual Request Indexing in GSC (daily quota ~10-12) |
| `${YOUR_BUSINESS_NAME}` schema isn't being picked up by Rich Results Test | JSON-LD has syntax error, or it's hydrated client-side only | Verify it's in the prerendered HTML (curl + grep), not just `react-helmet-async` runtime injection |
| OG image not updating when shared on Facebook/Twitter | Social platforms cache OG metadata for ~24-48 hours | Use Facebook Sharing Debugger to force re-fetch; Twitter's validator is gone but pasting in a Twitter compose box re-fetches |

---

## When to consider migrating off Lovable

Lovable's hosting is fine for content sites that fit within its constraints. The constraints become painful if you need any of these:
- `_redirects` style rewrites (e.g., `/old-blog/* /guides/* 301`)
- Server-side rendering (true SSR, not just prerender)
- Edge Workers for personalization, auth, A/B testing
- Build logs to debug deployment issues
- A custom build command beyond `vite build`
- Real-time API endpoints (Lovable supports some via their backend, but limited)

The migration path is short:
1. Export the repo from Lovable's GitHub integration (or copy `src/`, `public/`, `vite.config.ts`, `package.json`)
2. Deploy to Vercel, Netlify, or Cloudflare Pages
3. Drop the `.html` URL convention if you want (clean URLs resolve natively on all three)
4. Keep the prerender plugin; it works the same way

Estimated migration time: 1-2 hours for a small content site.