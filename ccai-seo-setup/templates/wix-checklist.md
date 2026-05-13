# Wix implementation checklist

For Wix sites (Wix Studio or classic Wix Editor). Most SEO config is in the UI; structured data + custom logic goes through Velo (Wix's JS environment).

## Per-fix instructions

### Item 1.1, robots.txt

**Wix Dashboard → SEO Tools → robots.txt Editor**
- Wix auto-generates a baseline robots.txt
- Edit to add/remove rules
- Submit changes; verify at `<DOMAIN>/robots.txt`

### Item 1.2, sitemap.xml

Wix auto-generates `/sitemap.xml`. No action needed unless:
- You want to exclude pages: Page Settings → SEO Basics → "Hide from search engines"
- You want to verify: visit `<DOMAIN>/sitemap.xml`

### Item 1.6, noindex check

Per page: **Page Settings → SEO Basics → Advanced SEO → "Let search engines index this page"** (toggle)

### Item 1.7, Canonical tags

Wix auto-adds canonical for each page. To override:
- Page Settings → SEO Basics → Advanced SEO → Custom canonical URL

### Item 3.2, Article JSON-LD (via Velo)

Wix doesn't have a built-in JSON-LD builder. Use Velo:

1. Enable Velo for the site (Settings → Dev Mode → Enable Velo)
2. On the Blog Post page (or Dynamic Page):
3. In the page code panel, add:

```javascript
import wixWindow from 'wix-window';

$w.onReady(async () => {
  // Pull post data from the current dynamic page
  const post = $w('#dynamicDataset').getCurrentItem();

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": post.title,
    "description": post.metaDescription,
    "image": post.coverImage,
    "datePublished": post.published,
    "dateModified": post.updated || post.published,
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
    "mainEntityOfPage": `https://<DOMAIN>/guides/${post.slug}`
  };

  wixWindow.copyToClipboard; // placeholder; for head injection use the SEO API
  // Inject via Wix's structured data API:
  await $w('#page').setStructuredData([jsonLd]);
});
```

Note: Wix added a `setStructuredData` API but coverage varies by editor type. For Wix Studio it's cleaner.

Alternative: **Page Settings → SEO Basics → Advanced SEO → Add Custom Meta Tags → "Add Schema Markup"**, Wix has a built-in structured data section that accepts raw JSON-LD.

### Item 3.3, Organization + WebSite (homepage)

Homepage → SEO Basics → Advanced SEO → Add Schema Markup. Paste Organization and WebSite JSON-LD blocks.

### Item 3.4, BreadcrumbList

Same pattern. Add via SEO Basics → Schema Markup on each Collection / Dynamic Page template.

### Item 3.5, Person schema + author page

1. Create a Page called "About" or "Author"
2. Add Person schema via SEO Basics → Schema Markup
3. Update all Article JSON-LD blocks (in their respective page settings) so `author.@id` references the about page

### Item 4, Open Graph

Per page: **Page Settings → SEO Basics → Social Share**
- Title
- Description
- Image (1200×630 recommended)

For Blog posts: Wix uses the post's cover image by default. Verify it's at least 1200×630 OR set a custom Social Share image per post.

### Item 5.1, FAQ schema

Wix has an FAQ App that auto-generates FAQPage schema if used. Otherwise:
- Page Settings → SEO Basics → Schema Markup → paste FAQPage JSON-LD manually

### Item 5.4, Visible "Updated" date

For Blog: add "Last updated" custom field to the Blog Collection, bind it to a text element in the post template, and pass the same date into the JSON-LD `dateModified`.

### Item 5.5, IndexNow

Wix doesn't natively support IndexNow. Options:
- Set up a Velo backend HTTP function that pings IndexNow on publish (requires Wix's HTTP Functions feature)
- Use Zapier/Make: Wix publish webhook → POST to api.indexnow.org/indexnow

Host the key file at `<DOMAIN>/<KEY>.txt`:
- Wix doesn't easily allow static `.txt` files at root. Workarounds:
  - Use a redirect to the file hosted elsewhere
  - Or use Wix's HTTP Functions to respond with the key content at the path
  - Or move IndexNow setup outside Wix (Cloudflare in front of the site)

### Item 11.2, UTM auto-tagging on copy-link

In Velo, on the page with the share button:

```javascript
$w('#copyButton').onClick(async () => {
  const url = new URL(wixLocation.url);
  url.searchParams.set('utm_source', 'share');
  url.searchParams.set('utm_medium', 'copy-link');
  url.searchParams.set('utm_campaign', wixLocation.path.pop() || 'home');
  await wixWindow.copyToClipboard(url.toString());
  // toast notification
});
```

### Item 11.4, Search Console + Bing Webmaster

**Wix Dashboard → SEO Tools → Google Search Console**, guided flow, one click
**Bing:** SEO Tools → Connect to Bing Webmaster (also guided)

## Wix-specific limitations

These items are hard or impossible on Wix without significant Velo work:
- **Per-page dynamic JSON-LD beyond what the Schema Markup field accepts**, limited template binding
- **Build-time OG image generation**, must upload manually per post
- **Custom server response codes**, limited
- **IndexNow**, requires Velo HTTP Functions OR external automation
- **Static .txt files at root**, workarounds needed

If these limitations matter for the site, consider migrating to Vite/Next.js/Webflow. Wix is improving SEO tooling rapidly (Wix Studio is closer to par with Webflow now).

## What Wix does well

- robots.txt + sitemap.xml: auto + editable
- Schema Markup field in page settings: straightforward
- Per-page Social Share settings: clean
- Search Console + Bing integration: native
- HTTPS: handled
