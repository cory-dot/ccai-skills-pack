# Lovable implementation template

For sites built on Lovable (lovable.dev), a Vite + React + TypeScript builder where you describe changes in natural language and the AI applies them.

## Two prompt styles

### Mega-prompt (use sparingly)

One big prompt covering 5-10 related fixes at once. Best when the fixes share state (e.g., all metadata setup). Risk: Lovable may partially apply.

### Per-fix prompt (preferred)

One prompt per checklist item. Lovable applies, user verifies, marks ✅ in SETUP_PLAN.md, moves to next.

---

## Per-fix prompt skeleton

```
## Fix: <checklist item>, <plain description>

**What I want you to do:**
<concrete, paste-ready instruction>

**Where:**
<file path OR "site-wide" OR "in the <X> component">

**Code (use this exactly):**
```<lang>
<exact code to add or replace>
```

**Verify by:**
<1-2 verification steps>
```

---

## Fix-by-fix Lovable prompts

### Item 1.1 + 1.2, robots.txt + sitemap.xml

```
Add a robots.txt and sitemap.xml to this site.

robots.txt (place at /public/robots.txt):

User-agent: *
Allow: /
Disallow: /admin
Disallow: /draft

Sitemap: https://<DOMAIN>/sitemap.xml

sitemap.xml: generate dynamically at build time (or as a build script that crawls all routes and outputs to /public/sitemap.xml). Include every public route, homepage, /guides, every /guides/<slug>, /book, /about. Each entry needs <loc>, <lastmod> (use the build date or the file's last modified date), <changefreq>, <priority>.

Verify by fetching /robots.txt and /sitemap.xml in production.
```

### Item 1.7, Canonical tags

```
Add self-referencing canonical tags to every page.

For each route, the document head needs:
<link rel="canonical" href="https://<DOMAIN><pathname>" />

In the React app, add this to the head of every page component (or to a shared Layout / Helmet component using react-helmet-async). The href must be the full HTTPS absolute URL with the canonical trailing-slash convention (match what's in the sitemap).

Verify by viewing source on any 2 pages and confirming the canonical href.
```

### Item 3.2, Article JSON-LD on /guides/*

```
On every /guides/<slug> page, inject Article JSON-LD into the document head.

The JSON-LD block (replace placeholders from the article's frontmatter):

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "<article.title>",
  "description": "<article.meta_description>",
  "image": "<article.og_image (absolute URL)>",
  "datePublished": "<article.published>",
  "dateModified": "<article.updated || article.published>",
  "author": {
    "@type": "Person",
    "name": "Cory Loflin",
    "url": "https://<DOMAIN>/about"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Creative Core AI",
    "logo": {
      "@type": "ImageObject",
      "url": "https://<DOMAIN>/logo.png"
    }
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://<DOMAIN>/guides/<slug>"
  }
}
</script>

Verify by running the page through Google's Rich Results Test (search.google.com/test/rich-results).
```

### Item 3.3, Organization + WebSite schema on homepage

```
On the homepage only, add these two JSON-LD blocks to the document head:

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Creative Core AI",
  "url": "https://<DOMAIN>",
  "logo": "https://<DOMAIN>/logo.png",
  "sameAs": [
    "https://instagram.com/creativecoreai",
    "https://skool.com/creative-core-ai",
    "https://github.com/cory-dot",
    "https://linkedin.com/in/<HANDLE>"
  ]
}
</script>

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "name": "Creative Core AI",
  "url": "https://<DOMAIN>",
  "potentialAction": {
    "@type": "SearchAction",
    "target": "https://<DOMAIN>/search?q={search_term_string}",
    "query-input": "required name=search_term_string"
  }
}
</script>

Skip the SearchAction block if site search doesn't exist.

Verify by running the homepage through Rich Results Test.
```

### Item 3.4, BreadcrumbList schema on /guides/*

```
On every /guides/<slug> page, add BreadcrumbList JSON-LD:

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    { "@type": "ListItem", "position": 1, "name": "Home", "item": "https://<DOMAIN>" },
    { "@type": "ListItem", "position": 2, "name": "Guides", "item": "https://<DOMAIN>/guides" },
    { "@type": "ListItem", "position": 3, "name": "<article.title>", "item": "https://<DOMAIN>/guides/<slug>" }
  ]
}
</script>
```

### Item 3.5, Person schema + author page

```
Create a new page at /about (or /author/cory-loflin) with:

1. A visible bio: photo, role, location (Houston TX), short story, links to creativecore.ai/book + skool.com/creative-core-ai + github.com/cory-dot.

2. Person JSON-LD in the head:

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Person",
  "@id": "https://<DOMAIN>/about#cory",
  "name": "Cory Loflin",
  "url": "https://<DOMAIN>/about",
  "image": "https://<DOMAIN>/cory.jpg",
  "jobTitle": "Founder",
  "worksFor": { "@type": "Organization", "name": "Creative Core AI" },
  "sameAs": [
    "https://github.com/cory-dot",
    "https://instagram.com/creativecoreai",
    "https://skool.com/creative-core-ai"
  ]
}
</script>

3. Update every Article JSON-LD on /guides/*, the author.@id should now reference https://<DOMAIN>/about#cory so author entity links to this page.
```

### Item 4.1-4.5, Open Graph + Twitter Cards

```
For every page, ensure these meta tags are in the document head:

<meta property="og:title" content="<page-specific or article title, ≤60 chars>" />
<meta property="og:description" content="<≤155 chars>" />
<meta property="og:image" content="https://<DOMAIN>/og/<slug>.png" />
<meta property="og:image:width" content="1200" />
<meta property="og:image:height" content="630" />
<meta property="og:url" content="https://<DOMAIN><pathname>" />
<meta property="og:type" content="article" />  <!-- "website" on homepage -->
<meta property="og:site_name" content="Creative Core AI" />
<meta name="twitter:card" content="summary_large_image" />

og:image must be:
- Absolute HTTPS URL (NOT relative)
- 1200×630 minimum
- <8MB
- Real PNG/JPEG/WebP

For per-article OG images, use the existing /og/<slug>.png pattern. If they don't exist, generate them at build time with satori + resvg-wasm, pull the article's frontmatter data, render a 1200×630 React component, output to /public/og/<slug>.png.

Verify with Facebook Sharing Debugger + Twitter Card Validator.
```

### Item 5.1, FAQPage schema (CRITICAL FOR AEO)

```
On every page that has H2/H3 questions in the body (most /guides/*), wrap those Q&As in FAQPage JSON-LD.

Identify the 4-6 most question-like H2s/H3s on the page. Their immediately-following paragraphs are the answers.

<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "<the question text>",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "<the answer paragraph, plain text, no HTML>"
      }
    }
    // ... 3-5 more
  ]
}
</script>

Place the script tag in the document head (not the body). Verify with Rich Results Test.

If a page doesn't naturally have question H2s, skip, don't fabricate questions.
```

### Item 5.4, Visible "Updated" date

```
On every article page, render a visible "Updated YYYY-MM-DD" line below the title (or in a small "About this article" block at the top).

Source: article.updated OR article.published if no updated date set.

The visible date must match the dateModified in the Article JSON-LD AND the <lastmod> in sitemap.xml. Three-signal consistency is the goal.
```

### Item 5.5, IndexNow

```
Set up IndexNow for instant indexing on Bing (and by extension, ChatGPT search, Copilot).

1. Generate a 32-character key (any random hex). Place it at /public/<KEY>.txt with the same key as content. Example: /public/8a7f...abc.txt containing the string "8a7f...abc".

2. Add a publish/update hook that POSTs to IndexNow when a new article is added or updated. Endpoint:

POST https://api.indexnow.org/indexnow
Content-Type: application/json

{
  "host": "<DOMAIN>",
  "key": "<KEY>",
  "keyLocation": "https://<DOMAIN>/<KEY>.txt",
  "urlList": ["https://<DOMAIN>/guides/<new-slug>"]
}

If this site doesn't have a CMS / publish workflow, expose a manual endpoint or admin button that triggers it.
```

### Item 11.2, UTM auto-tagging on copy-link button

```
On every article page's copy-link button, append UTM parameters to the shared URL.

Current behavior: copies https://<DOMAIN>/guides/<slug>
Desired behavior: copies https://<DOMAIN>/guides/<slug>?utm_source=share&utm_medium=copy-link&utm_campaign=<slug>

Also replace the window.prompt fallback with an inline toast/banner that says "Link copied to clipboard", auto-dismiss after 3 seconds.
```

### Item 11.4, Search Console + Bing Webmaster verification

```
This requires user action, not a code change, but a one-time setup.

For the user (not Lovable):
1. Go to search.google.com/search-console → Add property → enter <DOMAIN> → verify via DNS TXT record (or HTML file upload to public root)
2. Submit sitemap: <DOMAIN>/sitemap.xml
3. Go to bing.com/webmasters → Add site → enter <DOMAIN> → verify (can auto-import from GSC)
4. Submit sitemap there too

For Lovable: only needed if HTML file upload verification, add the verification file to /public/ as instructed by Google/Bing.
```

---

## Mega-prompt template (use only if shipping all fixes at once)

```
I'm doing a full SEO + AEO setup pass on this site. Domain: <DOMAIN>. Stack: Lovable (Vite + React). Apply these in order, verify each before moving to the next.

[paste fixes 1-9 from above in priority order]

After applying, tell me which fixes need user verification outside Lovable (Search Console setup, Rich Results Test, social debuggers).
```

## Notes specific to Lovable

- Lovable uses Vite + React, not Next.js. Don't suggest Next.js metadata API.
- Server-side rendering is limited. For OG images, prefer build-time generation (satori + resvg-wasm).
- `react-helmet-async` is the standard head-management library on Lovable projects.
- Lovable can't directly run a publish webhook (IndexNow), the user needs to wire that to a serverless function or admin UI button.
- For sitemap.xml: prefer a build-time script that crawls routes and outputs to /public/, don't try to make it dynamic.
