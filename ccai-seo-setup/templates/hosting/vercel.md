# Vercel hosting template

Vercel hosts Next.js (their native stack), Vite + React, Astro, and most other modern stacks. The hosting layer is generous and well-documented; most stack templates apply directly without workarounds.

## What Vercel does that just works

- **Clean URLs resolve natively.** `/products` serves `products.html`, `products/index.html`, OR the SPA fallback in the right priority order. No `.html` URL convention required.
- **Production build runs your full build command.** Whatever's in `package.json`'s `build` script (or your project's `vercel.json` build config) executes on every deploy. Chains of `next build && my-postbuild-script` work.
- **Build logs are visible** in the Vercel dashboard. If something errors, you see the stack trace.
- **Environment variables are reliably plumbed** into build-time scripts (no need for file-based fallbacks).
- **`vercel.json` supports rewrites and redirects** if you need them: https://vercel.com/docs/edge-network/rewrites
- **Edge Functions and Edge Middleware** available for any runtime logic (auth, A/B tests, personalization, dynamic OG generation).

## What this means for the 13 essential SEO prompts

Most of them work as written from the standard stack template. Specific notes:

- **Prompt 04 (`.html` URL workaround)**: SKIP. Not needed on Vercel. Use clean URLs throughout: sitemap entries are `/products`, canonicals are `/products`, internal links are `/products`. No HtmlSuffixStripper needed.
- **Prompts 02 + 03 (Vite plugin prerender + body prerender)**: Apply as written. The Vite plugin pattern still works on Vercel (in fact it's the cleanest approach). You could also use `vite-ssg` on Vercel since clean URLs resolve to nested `index.html` natively, but the plugin pattern is portable to other hosts.
- **Prompts 10 (IndexNow), 12 (llms.txt), 13 (verification meta tags)**: Apply as written. The file-based key fallback for IndexNow is still good hygiene even though env vars work on Vercel.
- **All other prompts**: Apply as written.

If your project is Next.js (App Router) rather than Vite + React, see `templates/stacks/nextjs.md` for native metadata patterns (preferred over `react-helmet-async` on Next).

## Sentinel file pattern (still useful)

Even though Vercel exposes build logs, the sentinel file pattern (`dist/PRERENDER_RAN.txt` or `.next/PRERENDER_RAN.txt`) is worth including. It gives you a single URL to check from any device after deploy without having to log into the Vercel dashboard.

## Stack templates to reference

- `templates/stacks/vite-react.md` for Vite + React
- `templates/stacks/nextjs.md` for Next.js (App Router)