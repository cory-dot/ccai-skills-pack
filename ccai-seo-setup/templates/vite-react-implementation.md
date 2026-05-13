# Vite + React implementation template

For Vite + React projects (Lovable's base stack, custom Vite + React Router setups). Different from Next.js, no built-in metadata API. Use `react-helmet-async` and build-time scripts.

## Key dependencies

```bash
npm i react-helmet-async
npm i -D satori @resvg/resvg-wasm  # for build-time OG image gen
```

## Per-fix implementations

### Item 1.1, robots.txt

Static file at `public/robots.txt`:

```
User-agent: *
Allow: /
Disallow: /admin

Sitemap: https://<DOMAIN>/sitemap.xml
```

### Item 1.2, sitemap.xml (build-time)

```typescript
// scripts/build-sitemap.ts
import fs from 'node:fs';
import path from 'node:path';
import { glob } from 'glob';

const DOMAIN = 'https://<DOMAIN>';

async function build() {
  const articleFiles = await glob('content/articles/*.md');
  const articles = articleFiles.map(f => {
    const stat = fs.statSync(f);
    const slug = path.basename(f, '.md');
    return { slug, lastmod: stat.mtime.toISOString().split('T')[0] };
  });

  const urls = [
    { loc: DOMAIN, lastmod: new Date().toISOString().split('T')[0], priority: '1.0' },
    { loc: `${DOMAIN}/guides`, lastmod: new Date().toISOString().split('T')[0], priority: '0.9' },
    ...articles.map(a => ({ loc: `${DOMAIN}/guides/${a.slug}`, lastmod: a.lastmod, priority: '0.8' })),
    { loc: `${DOMAIN}/book`, lastmod: new Date().toISOString().split('T')[0], priority: '0.9' },
    { loc: `${DOMAIN}/about`, lastmod: new Date().toISOString().split('T')[0], priority: '0.7' },
  ];

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urls.map(u => `  <url><loc>${u.loc}</loc><lastmod>${u.lastmod}</lastmod><priority>${u.priority}</priority></url>`).join('\n')}
</urlset>`;

  fs.writeFileSync('public/sitemap.xml', xml);
  console.log(`Wrote sitemap with ${urls.length} URLs`);
}

build();
```

Add to `package.json`:
```json
"scripts": {
  "build": "npm run build:sitemap && vite build",
  "build:sitemap": "tsx scripts/build-sitemap.ts"
}
```

### Item 1.7, 3.x, 4.x, Head management with react-helmet-async

Wrap app in provider (once, in `main.tsx`):
```tsx
import { HelmetProvider } from 'react-helmet-async';
ReactDOM.createRoot(root).render(
  <HelmetProvider><App /></HelmetProvider>
);
```

Per-page head component:
```tsx
// components/ArticleHead.tsx
import { Helmet } from 'react-helmet-async';

export function ArticleHead({ article }: { article: Article }) {
  const url = `https://<DOMAIN>/guides/${article.slug}`;
  const articleJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Article',
    headline: article.title,
    description: article.meta_description,
    image: article.og_image,
    datePublished: article.published,
    dateModified: article.updated || article.published,
    author: { '@type': 'Person', name: 'Cory Loflin', '@id': 'https://<DOMAIN>/about#cory' },
    publisher: {
      '@type': 'Organization',
      name: 'Creative Core AI',
      logo: { '@type': 'ImageObject', url: 'https://<DOMAIN>/logo.png' },
    },
    mainEntityOfPage: { '@type': 'WebPage', '@id': url },
  };
  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      { '@type': 'ListItem', position: 1, name: 'Home', item: 'https://<DOMAIN>' },
      { '@type': 'ListItem', position: 2, name: 'Guides', item: 'https://<DOMAIN>/guides' },
      { '@type': 'ListItem', position: 3, name: article.title, item: url },
    ],
  };

  return (
    <Helmet>
      <title>{article.title}</title>
      <meta name="description" content={article.meta_description} />
      <link rel="canonical" href={url} />
      <meta property="og:title" content={article.title} />
      <meta property="og:description" content={article.meta_description} />
      <meta property="og:image" content={article.og_image} />
      <meta property="og:image:width" content="1200" />
      <meta property="og:image:height" content="630" />
      <meta property="og:url" content={url} />
      <meta property="og:type" content="article" />
      <meta property="og:site_name" content="Creative Core AI" />
      <meta name="twitter:card" content="summary_large_image" />
      <script type="application/ld+json">{JSON.stringify(articleJsonLd)}</script>
      <script type="application/ld+json">{JSON.stringify(breadcrumbJsonLd)}</script>
    </Helmet>
  );
}
```

### OG image generation (build-time, Vite, no @vercel/og)

`@vercel/og` requires Vercel's edge runtime. For Vite, use satori + resvg-wasm at build time:

```typescript
// scripts/build-og-images.ts
import satori from 'satori';
import { Resvg } from '@resvg/resvg-wasm';
import fs from 'node:fs';
import { getAllArticles } from './articles';

const FONT = fs.readFileSync('./assets/Inter-Bold.ttf');

async function renderOG(article) {
  const svg = await satori(
    {
      type: 'div',
      props: {
        style: { display: 'flex', flexDirection: 'column', width: 1200, height: 630, padding: 80, background: '#0A0A0A', color: '#fff' },
        children: [
          { type: 'div', props: { style: { fontSize: 28, opacity: 0.6 }, children: 'creativecore.ai/guides' } },
          { type: 'div', props: { style: { fontSize: 72, fontWeight: 700, marginTop: 40 }, children: article.title } },
          { type: 'div', props: { style: { fontSize: 32, marginTop: 'auto', opacity: 0.8 }, children: article.tagline || article.meta_description } },
        ],
      },
    },
    { width: 1200, height: 630, fonts: [{ name: 'Inter', data: FONT, weight: 700, style: 'normal' }] }
  );

  const resvg = new Resvg(svg);
  const png = resvg.render().asPng();
  fs.writeFileSync(`public/og/${article.slug}.png`, png);
}

async function build() {
  const articles = await getAllArticles();
  fs.mkdirSync('public/og', { recursive: true });
  for (const a of articles) await renderOG(a);
  console.log(`Generated ${articles.length} OG images`);
}

build();
```

Wire into build:
```json
"build": "npm run build:og && npm run build:sitemap && vite build",
"build:og": "tsx scripts/build-og-images.ts"
```

### Item 5.5, IndexNow

If site has a CMS / publish workflow, hit IndexNow on publish. If not, manual button in admin:

```typescript
// utils/indexnow.ts
const KEY = import.meta.env.VITE_INDEXNOW_KEY;
const HOST = '<DOMAIN>';

export async function pingIndexNow(urls: string[]) {
  await fetch('https://api.indexnow.org/indexnow', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ host: HOST, key: KEY, keyLocation: `https://${HOST}/${KEY}.txt`, urlList: urls }),
  });
}
```

Place `public/<KEY>.txt` containing the same key string.

### Item 11.2, UTM auto-tagging

```tsx
function copyShareLink(pathname: string) {
  const u = new URL(`https://<DOMAIN>${pathname}`);
  u.searchParams.set('utm_source', 'share');
  u.searchParams.set('utm_medium', 'copy-link');
  u.searchParams.set('utm_campaign', pathname.split('/').pop() || 'home');
  navigator.clipboard.writeText(u.toString());
  showToast('Link copied');
}
```

## Notes specific to Vite + React

- No SSR by default, meta tags get applied client-side via react-helmet-async. Modern crawlers (Google, Bing, ClaudeBot, GPTBot) handle JS-rendered meta, but it adds latency.
- For better crawlability, consider Vite SSG plugin (vite-ssg) or migrate to Next.js / Astro if SEO is critical
- All "Next.js metadata API" patterns translate to react-helmet-async
- OG image generation MUST be build-time on Vite, no edge runtime
- Routing: assume React Router; canonical URL is `window.location.pathname`-derived or known from route params
