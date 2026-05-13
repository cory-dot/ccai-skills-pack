# Site-type overlay: content-blog

For sites whose primary purpose is publishing articles, guides, or editorial content. Matches CCAI's own site (creativecore.ai/guides).

## Additional checks beyond the canonical 55

### CB.1 Topical clustering
- **What:** Articles cluster around 3-7 well-defined topics, each with a hub/pillar page and supporting articles
- **Why:** Topic authority is how Google + AI engines decide site expertise.
- **How:** Group articles by inferred topic from titles/tags; flag if >40% are "orphan topics"
- **Severity:** high

### CB.2 Author pages with publication history
- **What:** Every author has a `/author/<slug>/` page listing all their content, with Person schema
- **Severity:** high

### CB.3 Internal linking depth per article
- **What:** Each article links to at least 2 other articles on the site and is linked FROM at least 2 other articles
- **Why:** "Related reading" patterns help both rankings and AEO citation chains.
- **How:** During crawl, count internal links in/out per article
- **Severity:** high

### CB.4 Content freshness rate
- **What:** Articles older than 18 months either have a visible "Updated" date <12 months ago OR are tagged "Evergreen"
- **Severity:** medium

### CB.5 Cannibalization risk
- **What:** No two articles target the same primary keyword/intent
- **Why:** Cannibalization splits ranking signal across competing pages.
- **How:** Cluster articles by title similarity + meta description similarity
- **Severity:** high

### CB.6 Article schema completeness
- **What:** Every article has Article OR BlogPosting (NOT both), with headline, author, datePublished, dateModified, image, publisher, mainEntityOfPage
- **Severity:** critical

### CB.7 Reading time visible
- **What:** Each article shows estimated reading time
- **Why:** Bounce-rate signal, readers self-select before committing.
- **Severity:** low

### CB.8 Newsletter / email capture present
- **What:** At least one non-intrusive email capture per article (inline mid-article + footer)
- **Why:** First-party audience is the only durable channel as AI search reduces SERP clicks.
- **Severity:** medium

## Weighted scoring for content-blog

- Article schema (3.2), 3× weight
- FAQ presence (5.1), 3× weight (high AEO impact for blogs)
- Author bios (6.1), 2× weight
- Cannibalization (CB.5), 2× weight
- Internal linking depth (CB.3), 2× weight

## Common findings on content-blog sites

1. Missing dateModified, sitemap shows fresh dates, JSON-LD shows stale
2. Author bylines without Person schema or author pages
3. FAQ-shaped questions in H2s without FAQPage schema markup
4. Topical clusters that don't link to each other
5. OG images that are the post's first image instead of an OG-specific 1200×630
