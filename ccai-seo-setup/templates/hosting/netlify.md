# Netlify hosting template

Netlify hosts most static and JAMstack projects (Vite, Astro, Eleventy, Hugo, Next.js with the Netlify adapter, etc.). Similar to Vercel: clean URLs resolve natively, full build command runs, build logs visible.

## What just works

- **Clean URLs resolve natively** via Netlify's pretty URLs (set `[build] pretty_urls = true` in `netlify.toml`, or leave it as default).
- **Production build runs your full build command** (set in `netlify.toml` or via the UI).
- **Build logs visible** in the Netlify dashboard.
- **Environment variables reliably plumbed** at build time.
- **`_redirects` file** at `public/_redirects` supports redirects, rewrites, and custom 404 responses. Useful for moving old URLs to new ones (e.g., `/old-blog/* /guides/:splat 301`).
- **`netlify.toml`** supports headers, redirects, build settings, and Edge Function definitions.

## What this means for the 13 essential SEO prompts

Most apply as written. Specific notes:

- **Prompt 04 (`.html` URL workaround)**: SKIP. Clean URLs work natively. Use them throughout.
- **Real 404 status for the soft-404 fix (prompt 01)**: Netlify supports `_redirects` with custom status codes. Add `/*  /404.html  404` to `public/_redirects` to serve `404.html` with a real 404 status for unknown URLs. This is BETTER than the noindex meta workaround Lovable requires, because real 404s tell crawlers definitively that the URL doesn't exist.
- **All other prompts**: Apply as written.

## Worth doing on Netlify specifically

- **`_redirects` for old URL migration.** If you're moving content from an old site, set up 301 redirects in `public/_redirects` so existing inbound links keep working.
- **`netlify.toml` headers for Cache-Control on `/llms.txt` and `/sitemap.xml`**. Default is short caching; you may want to bump it to `Cache-Control: public, max-age=3600` for these (re-generated on every build, so a small cache is fine).

## Stack templates to reference

- `templates/stacks/vite-react.md` for Vite + React
- `templates/stacks/nextjs.md` for Next.js (with Netlify adapter)