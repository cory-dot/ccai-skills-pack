# Next.js implementation template

For Next.js 14+ App Router. Most metadata items use the built-in `metadata` API.

## Per-fix implementations

### Item 1.1, robots.txt

```typescript
// app/robots.ts
import type { MetadataRoute } from 'next';

export default function robots(): MetadataRoute.Robots {
  return {
    rules: [{ userAgent: '*', allow: '/', disallow: ['/admin', '/draft'] }],
    sitemap: 'https://<DOMAIN>/sitemap.xml',
  };
}
```

### Item 1.2, sitemap.xml

```typescript
// app/sitemap.ts
import type { MetadataRoute } from 'next';
import { getAllArticles } from '@/lib/articles';

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const articles = await getAllArticles();
  return [
    { url: 'https://<DOMAIN>', lastModified: new Date(), changeFrequency: 'weekly', priority: 1 },
    { url: 'https://<DOMAIN>/guides', lastModified: new Date(), changeFrequency: 'weekly', priority: 0.9 },
    ...articles.map(a => ({
      url: `https://<DOMAIN>/guides/${a.slug}`,
      lastModified: new Date(a.updated || a.published),
      changeFrequency: 'monthly' as const,
      priority: 0.8,
    })),
  ];
}
```

### Item 1.7, Canonical tags

```typescript
// app/guides/[slug]/page.tsx
export async function generateMetadata({ params }): Promise<Metadata> {
  return {
    alternates: { canonical: `https://<DOMAIN>/guides/${params.slug}` },
  };
}
```

### Item 3.2, Article JSON-LD

```tsx
// app/guides/[slug]/page.tsx
export default async function Page({ params }) {
  const article = await getArticle(params.slug);
  const jsonLd = {
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
    mainEntityOfPage: { '@type': 'WebPage', '@id': `https://<DOMAIN>/guides/${params.slug}` },
  };
  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <Article {...article} />
    </>
  );
}
```

### Item 3.3, Organization + WebSite (homepage)

```tsx
// app/page.tsx, same pattern, two JSON-LD blocks
```

### Item 3.5, Author page

Create `app/about/page.tsx` with the bio component and the Person JSON-LD inline. Update all article pages so `author['@id']` references this page.

### Item 4, Open Graph + Twitter

```typescript
// app/guides/[slug]/page.tsx
export async function generateMetadata({ params }): Promise<Metadata> {
  const article = await getArticle(params.slug);
  return {
    title: article.title,
    description: article.meta_description,
    openGraph: {
      title: article.title,
      description: article.meta_description,
      url: `https://<DOMAIN>/guides/${params.slug}`,
      images: [{ url: article.og_image, width: 1200, height: 630 }],
      type: 'article',
      publishedTime: article.published,
      modifiedTime: article.updated,
      authors: ['Cory Loflin'],
    },
    twitter: {
      card: 'summary_large_image',
      title: article.title,
      description: article.meta_description,
      images: [article.og_image],
    },
    alternates: { canonical: `https://<DOMAIN>/guides/${params.slug}` },
  };
}
```

For per-article OG image generation, use `@vercel/og` (`app/guides/[slug]/opengraph-image.tsx`):

```tsx
import { ImageResponse } from 'next/og';

export const runtime = 'edge';
export const size = { width: 1200, height: 630 };
export const contentType = 'image/png';

export default async function Image({ params }) {
  const article = await getArticle(params.slug);
  return new ImageResponse(
    (
      <div style={{ /* layout */ }}>
        <h1>{article.title}</h1>
        <p>{article.meta_description}</p>
      </div>
    ),
    size,
  );
}
```

### Item 5.1, FAQPage schema

Inline JSON-LD block on article pages with Q&A H2s. Same `<script>` pattern as Article schema.

### Item 5.5, IndexNow

```typescript
// app/api/indexnow/route.ts
import { NextRequest } from 'next/server';

const KEY = process.env.INDEXNOW_KEY!;
const HOST = '<DOMAIN>';

export async function POST(req: NextRequest) {
  const { urls } = await req.json();
  await fetch('https://api.indexnow.org/indexnow', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      host: HOST,
      key: KEY,
      keyLocation: `https://${HOST}/${KEY}.txt`,
      urlList: urls,
    }),
  });
  return Response.json({ ok: true });
}
```

Place `public/<KEY>.txt` containing the key.

### Item 11.2, UTM auto-tagging

```tsx
function copyLink(pathname: string) {
  const url = new URL(`https://<DOMAIN>${pathname}`);
  url.searchParams.set('utm_source', 'share');
  url.searchParams.set('utm_medium', 'copy-link');
  url.searchParams.set('utm_campaign', pathname.split('/').pop() || 'home');
  navigator.clipboard.writeText(url.toString());
  toast('Link copied');
}
```

## Notes specific to Next.js

- App Router's `metadata` API handles 80% of head-tag work, use it, don't roll your own
- `@vercel/og` is the standard for per-page OG image generation
- Server Components handle JSON-LD cleanly via `dangerouslySetInnerHTML`
- Edge runtime is fine for OG images and IndexNow webhook
- For multilingual sites, use the `alternates.languages` metadata field for hreflang
