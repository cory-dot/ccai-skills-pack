# Related articles cross-linking pattern

Content sites with weak internal link graphs struggle to rank. Each article needs ≥3 internal links to other articles (Checklist 12.5). On Lovable Vite + React projects, the typical failure is that "related articles" components exist in React but don't reach the prerendered HTML — same architectural cause as nav/footer/CTAs.

This pattern fixes that by generating a "Related articles" section in HTML during the prerender step.

> **Applies to:** Lovable + Vite + React content sites with markdown articles in `src/content/guides/` or `src/content/blog/`. Adapts to any build-time prerender setup.

## Symptoms this fixes

```bash
# How many other-article links does an article have?
curl -s ${YOUR_SITE_URL}/guides/<some-article>.html | grep -oE '<a [^>]*href="/(guides|blog)/[^"]*"' | wc -l
# Expected: 3+. Got 0? Articles are isolated; no internal link graph between content.
```

## The algorithm

For each article, pick 3-5 related articles by:

1. **Tag/category match (primary signal).** Articles in the same category, then articles sharing tags.
2. **Recency tiebreaker.** Newer articles preferred when category/tag tie.
3. **Exclude self.** Don't link an article to itself.
4. **Variety bonus.** If primary category has fewer than 3 candidates, pull from adjacent categories.

Simple implementation: read all article frontmatter at build time, build an index keyed by category + tags, then for each article look up its category/tag siblings.

## Pattern: relations index + render function

```ts
// scripts/related-articles.ts
import { readdirSync, readFileSync } from "node:fs";
import { resolve, basename, extname } from "node:path";
import matter from "gray-matter"; // already a dep if you process markdown

interface ArticleMeta {
  slug: string;
  url: string;
  title: string;
  category: string;
  tags: string[];
  published: string;
}

const CONTENT_DIRS = [
  { dir: "src/content/guides", urlPrefix: "/guides" },
  { dir: "src/content/blog", urlPrefix: "/blog" },
];

export function buildArticleIndex(rootDir: string): ArticleMeta[] {
  const articles: ArticleMeta[] = [];
  for (const { dir, urlPrefix } of CONTENT_DIRS) {
    const absDir = resolve(rootDir, dir);
    let files: string[] = [];
    try {
      files = readdirSync(absDir).filter((f) => f.endsWith(".md"));
    } catch {
      continue; // dir may not exist (e.g., site without /blog/)
    }
    for (const file of files) {
      const slug = basename(file, extname(file));
      const fm = matter(readFileSync(resolve(absDir, file), "utf8"));
      articles.push({
        slug,
        url: `${urlPrefix}/${slug}.html`,
        title: fm.data.title || slug,
        category: fm.data.category || "Uncategorized",
        tags: Array.isArray(fm.data.tags) ? fm.data.tags : [],
        published: fm.data.published || fm.data.date || "1970-01-01",
      });
    }
  }
  return articles;
}

export function pickRelated(current: ArticleMeta, all: ArticleMeta[], n = 4): ArticleMeta[] {
  const candidates = all.filter((a) => a.slug !== current.slug || a.url !== current.url);
  // Score each by overlap
  const scored = candidates.map((a) => {
    let score = 0;
    if (a.category === current.category) score += 10;
    const sharedTags = a.tags.filter((t) => current.tags.includes(t)).length;
    score += sharedTags * 3;
    return { article: a, score };
  });
  // Sort: highest score first; ties broken by recency desc
  scored.sort((x, y) => {
    if (y.score !== x.score) return y.score - x.score;
    return y.article.published.localeCompare(x.article.published);
  });
  // Take top N with at least some signal; if not enough scored above 0, fall back to recent
  let picks = scored.filter((s) => s.score > 0).map((s) => s.article).slice(0, n);
  if (picks.length < n) {
    const remaining = scored
      .map((s) => s.article)
      .filter((a) => !picks.includes(a))
      .sort((x, y) => y.published.localeCompare(x.published))
      .slice(0, n - picks.length);
    picks = picks.concat(remaining);
  }
  return picks;
}

export function renderRelatedHTML(current: ArticleMeta, all: ArticleMeta[]): string {
  const related = pickRelated(current, all, 4);
  if (related.length === 0) return "";
  const items = related
    .map((a) => `<li><a href="${a.url}">${escapeHtml(a.title)}</a></li>`)
    .join("\n      ");
  return `
  <section class="prerender-related-articles" aria-labelledby="related-h2">
    <h2 id="related-h2">Related articles</h2>
    <ul>
      ${items}
    </ul>
  </section>`;
}

function escapeHtml(s: string): string {
  return s
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}
```

## Pattern: inject into article prerender

In the script that writes article HTML (likely `scripts/prerender-guides.ts` and `scripts/prerender-blog.ts`):

```ts
import { buildArticleIndex, renderRelatedHTML } from "./related-articles";

const allArticles = buildArticleIndex(ROOT);

for (const article of allArticles.filter((a) => a.url.startsWith("/guides/"))) {
  const relatedHTML = renderRelatedHTML(article, allArticles);
  const bodyHTML = renderArticleBody(article) + relatedHTML;
  // ...write dist/guides/<slug>.html with bodyHTML inside the page assembly
}
```

The `relatedHTML` should go inside the `<main>` element, before the closing `</main>` and before any global CTAs section (so the order is: article body → related articles → CTAs → footer).

## React hydration coexistence

Same as nav prerender: the React app may also render a related-articles component on hydration. Use the `PrerenderCleanup` component (from `nav-prerender.md`) and add `.prerender-related-articles` to its selector list:

```tsx
// src/components/PrerenderCleanup.tsx (updated)
document.querySelectorAll(
  ".prerender-header, .prerender-footer, .prerender-article-ctas, .prerender-related-articles"
).forEach((el) => el.remove());
```

If the React app doesn't render its own related articles, you can leave the prerendered version in place by *not* including the class in the cleanup selector. That's the simpler path — the HTML version is good enough for both crawlers and users.

## The Lovable prompt to apply this

```
Add a "Related articles" cross-linking section that's generated at build time and appears in the prerendered HTML of every article. Goal: each article links to 3-5 related articles via crawlable <a href> elements, building the internal link graph for SEO.

Create `scripts/related-articles.ts` that exports three functions:
1. `buildArticleIndex(rootDir)` — reads all .md files in src/content/guides/ and src/content/blog/, returns an array of {slug, url, title, category, tags, published}.
2. `pickRelated(currentArticle, allArticles, n=4)` — scores candidates by category match (10pts) + shared tags (3pts each), tiebreaker is recency desc.
3. `renderRelatedHTML(currentArticle, allArticles)` — returns a <section class="prerender-related-articles"> with <ul> of <a href> links to the picks.

Then update scripts/prerender-guides.ts (and prerender-blog.ts if separate) to call renderRelatedHTML on each article and append the returned HTML inside the <main> element, before any CTAs section.

Optionally update src/components/PrerenderCleanup.tsx to also remove .prerender-related-articles on hydration if there's a React component that re-renders the same section. If there isn't, leave it as-is and the prerendered HTML stays visible to users.

After this is applied, verify:
  curl -s ${YOUR_SITE_URL}/guides/<some-article>.html | grep -oE '<a [^>]*href="/(guides|blog)/[^"]*"' | wc -l
  # Expected: 3 or more (the related article links)
  
  curl -s ${YOUR_SITE_URL}/guides/<some-article>.html | grep "Related articles"
  # Expected: at least one match (the section heading)
```

## Verification

1. **Count of internal article links per article:** ≥3 (`curl | grep -oE '<a [^>]*href="/(guides|blog)/[^"]*"' | wc -l`).
2. **Different articles get different related sets:** spot-check 2 articles, confirm their related lists differ.
3. **Related articles match category/topic:** look at the picks, do they make editorial sense?
4. **No broken links:** every related URL returns 200 (`for url in $(curl -s <article> | grep -oE 'href="/[^"]*"' | grep -E '(guides|blog)'); do curl -sI "$url"; done`).

## When to NOT use this

- Site has <5 articles total: not enough candidates to pick from. Manually curate "see also" links until article count grows.
- Site has highly heterogeneous categories with no overlap: scoring algorithm needs tuning, or use editor-curated related arrays in each article's frontmatter (e.g., `related_slugs: [...]`).

## Related patterns

- `templates/patterns/nav-prerender.md` — required upstream (the prerender pipeline must be in place first)
- `templates/hosting/lovable.md` — Lovable case study, Section 6 (nav/footer/CTA check)
