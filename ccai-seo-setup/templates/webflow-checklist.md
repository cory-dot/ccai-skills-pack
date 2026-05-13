# Webflow implementation checklist

For Webflow-hosted sites. Most SEO config happens in Webflow's UI panels; structured data goes in custom code embeds.

## Per-fix instructions

### Item 1.1, robots.txt

Webflow auto-generates robots.txt. To customize:
1. **Project Settings → SEO tab → Indexing → robots.txt**
2. Paste:
   ```
   User-agent: *
   Allow: /
   Disallow: /admin

   Sitemap: https://<DOMAIN>/sitemap.xml
   ```
3. Publish.

### Item 1.2, sitemap.xml

Webflow auto-generates sitemap.xml at `/sitemap.xml`. To enable:
1. **Project Settings → SEO → Sitemap → Auto-generate Sitemap: ON**
2. Optionally exclude pages: per-page Settings → SEO → "Exclude this page from search indexing" and Sitemap exclude
3. Publish; verify at `<DOMAIN>/sitemap.xml`

### Item 1.6, noindex check

For each page that should rank:
1. Page Settings → SEO → uncheck "Exclude this page from search indexing"

For pages that should NOT rank (admin, drafts):
1. Same place → check the exclude box

### Item 1.7, Canonical tags

Webflow auto-adds canonical tags pointing to the page's own URL. No manual action needed for self-referencing canonicals.

For custom canonical (rare, e.g., AMP or syndicated content):
1. Page Settings → Custom Code → Inside `<head>` tag → paste:
   ```html
   <link rel="canonical" href="https://<DOMAIN>/correct-page" />
   ```

### Item 3.2, Article JSON-LD

For CMS Collection pages (e.g., blog posts):
1. Open the Collection Page template → **Page Settings → Custom Code → Inside `<head>` tag**
2. Paste with Collection field bindings:
   ```html
   <script type="application/ld+json">
   {
     "@context": "https://schema.org",
     "@type": "Article",
     "headline": "<<Post Title>>",
     "description": "<<Meta Description>>",
     "image": "<<OG Image URL>>",
     "datePublished": "<<Published Date>>",
     "dateModified": "<<Updated Date or Published Date>>",
     "author": {
       "@type": "Person",
       "name": "Cory Loflin",
       "url": "https://<DOMAIN>/about"
     },
     "publisher": {
       "@type": "Organization",
       "name": "Creative Core AI",
       "logo": { "@type": "ImageObject", "url": "https://<DOMAIN>/logo.png" }
     },
     "mainEntityOfPage": "https://<DOMAIN>/guides/<<Slug>>"
   }
   </script>
   ```
3. Use Webflow's "+ Add Field" picker to bind dynamic values from the Collection.

### Item 3.3, Organization + WebSite (homepage)

1. Open Home page → **Page Settings → Custom Code → Inside `<head>` tag**
2. Paste Organization + WebSite JSON-LD blocks (see canonical checklist for full schema)

### Item 3.4, BreadcrumbList

Add to Collection Page template via custom code, same pattern.

### Item 3.5, Person schema + author page

1. Create an "About" or "Author" static page (or use a CMS Collection for authors if multi-author)
2. Paste Person JSON-LD in Page Settings → Custom Code → head
3. Update all Article JSON-LD blocks so `author.@id` references this page's URL + `#cory` anchor

### Item 4, Open Graph

Per page: **Page Settings → SEO → Open Graph Settings**
- Title
- Description
- Image (upload 1200×630 PNG/JPEG)

Webflow auto-renders the meta tags. Verify with view-source.

For CMS Collection pages: use field bindings in the same panel.

### Item 5.1, FAQ schema

If the page has FAQ-style H2/H3 content:
1. **Page Settings → Custom Code → Inside `<head>` tag**
2. Paste FAQPage JSON-LD with the actual questions and answers (cannot bind to body content automatically, manually mirror)

### Item 5.4, Visible "Updated" date

1. Add a "Last Updated" field to your blog Collection
2. In the Collection template, bind a text element to display "Updated <<Last Updated>>"
3. Ensure the same date is used in the dateModified field of the Article JSON-LD

### Item 5.5, IndexNow

Webflow doesn't natively support IndexNow. Options:
- **Manual:** After publishing a post, use a free tool like IndexNow Submitter (Chrome extension) to ping
- **Zapier/Make:** Webflow Publish webhook → HTTP POST to api.indexnow.org/indexnow
- **Cloudflare proxy:** Add a Worker that pings IndexNow on publish webhook

Place `<KEY>.txt` at root: **Project Settings → Custom Code → upload to /public** is not directly supported on Webflow; use a 301 redirect or host the key file elsewhere.

This is the area where Webflow has limits. If IndexNow is critical, consider Zapier integration.

### Item 11.2, UTM auto-tagging

Webflow can't intercept clipboard.writeText natively. Options:
1. Custom code in Project Settings → Custom Code → Before `</body>`:
   ```html
   <script>
   document.addEventListener('click', e => {
     const btn = e.target.closest('[data-copy-link]');
     if (!btn) return;
     const url = new URL(window.location.href);
     url.searchParams.set('utm_source', 'share');
     url.searchParams.set('utm_medium', 'copy-link');
     url.searchParams.set('utm_campaign', url.pathname.split('/').pop() || 'home');
     navigator.clipboard.writeText(url.toString());
     // toast logic
   });
   </script>
   ```
2. Add `data-copy-link` attribute to your copy-link button in Designer

### Item 11.4, Search Console + Bing Webmaster

1. Google Search Console: Use DNS verification OR Webflow's built-in verification field at Project Settings → SEO → Google Site Verification → paste token
2. Bing Webmaster: Project Settings → Custom Code → Inside `<head>`:
   ```html
   <meta name="msvalidate.01" content="<TOKEN>" />
   ```

## Webflow-specific limitations

These items are hard or impossible on Webflow:
- **Per-page `og:image` with dynamic generation**, must manually upload 1200×630 per Collection item
- **Build-time scripts**, Webflow doesn't run user build steps
- **Edge functions for IndexNow**, need external automation (Zapier/Make/Cloudflare)
- **Custom server response codes** for soft 404s, limited control

If these limitations matter for the site, consider migrating to Vite/Next.js. Otherwise, Webflow handles 80% of SEO config natively, which is excellent.

## What Webflow does well

- robots.txt + sitemap.xml: auto
- Canonical tags: auto
- Per-page meta + OG: clean UI
- Page-level noindex toggle: clean UI
- HTTPS + HSTS: handled by Webflow hosting
- Core Web Vitals: Webflow CDN is fast by default
