# Cloudflare Pages hosting template

Cloudflare Pages hosts static + JAMstack projects. Tightly integrated with Cloudflare Workers for edge logic. Similar profile to Vercel and Netlify.

## What just works

- **Clean URLs resolve natively**: Pages tries `/route` → `/route.html` → `/route/index.html` → SPA fallback (if `_redirects` configured) in priority order.
- **Production build runs your full build command** (configured in the Pages project settings).
- **Build logs visible** in the Cloudflare dashboard.
- **Environment variables reliably plumbed** at build time.
- **`_redirects` file** at `public/_redirects` (or `dist/_redirects` after build) for redirects + rewrites + custom 404s. Same syntax as Netlify.
- **`_routes.json`** if you need fine-grained control over what Pages serves vs. what falls through to a Pages Function.
- **Cloudflare Workers / Pages Functions** available at the edge for any dynamic logic (dynamic OG images, auth, A/B tests, custom headers).

## What this means for the 13 essential SEO prompts

Most apply as written. Specific notes:

- **Prompt 04 (`.html` URL workaround)**: SKIP. Clean URLs work natively.
- **Real 404 status (prompt 01)**: Add `/*  /404.html  404` to `public/_redirects` for a real 404 status on unknown URLs.
- **All other prompts**: Apply as written.

## Worth doing on Cloudflare Pages specifically

- **Cache-Control headers via Functions**: if you want longer caching on `/sitemap.xml` and `/llms.txt`, you can add a Function or `_headers` file to set explicit `Cache-Control` values.
- **Edge dynamic OG**: if you want truly dynamic OG images (e.g., per-share-link customization), Cloudflare Workers + satori-html-wasm is a clean pattern. Optional; the build-time satori approach in the stack template is usually sufficient.

## Stack templates to reference

- `templates/stacks/vite-react.md` for Vite + React
- `templates/stacks/nextjs.md` for Next.js (with appropriate adapter)