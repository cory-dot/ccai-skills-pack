# Site-type overlay: ecommerce

For sites with products + cart + checkout. Shopify, WooCommerce, BigCommerce, custom.

## Additional checks

### E.1 Product schema completeness
- **What:** Every product has Product JSON-LD with name, image, description, sku, brand, offers (price, priceCurrency, availability), aggregateRating (if reviews exist)
- **Severity:** critical

### E.2 Stock / availability accuracy
- **What:** Product schema `availability` matches what's actually shown on page (no "in stock" in schema when page says out of stock)
- **Why:** Mismatch = manual action risk + lost rich results
- **Severity:** high

### E.3 Faceted nav not creating URL explosions
- **What:** Filter URLs (?color=red&size=L) either canonicalize to base category OR are blocked in robots.txt
- **Why:** Without controls, faceted nav can create millions of low-quality indexed URLs
- **Severity:** critical

### E.4 Category page density
- **What:** Each category page has at least 8 products, unique intro copy (not boilerplate), breadcrumb
- **Severity:** high

### E.5 Reviews / ratings visible + schema
- **What:** Product reviews shown on PDP with AggregateRating JSON-LD
- **Severity:** high

### E.6 Internal search results not indexed
- **What:** /search?q= URLs are noindex or robots-blocked
- **Why:** Search results = thin pages = Google quality penalty
- **Severity:** high

### E.7 Out-of-stock handling
- **What:** Out-of-stock products stay published with "out of stock" indicator + estimated restock OR 301 to category, never just deleted
- **Severity:** medium

### E.8 Checkout HTTPS + trust badges
- **What:** Cart and checkout pages HTTPS, payment processor badges visible, return policy linked
- **Severity:** critical

## Weighted scoring for ecommerce

- Product schema (E.1), 3× weight on PDPs
- Faceted nav control (E.3), 3× weight
- Stock accuracy (E.2), 2× weight
- Reviews (E.5), 2× weight

## Common findings on ecommerce sites

1. Faceted nav indexed → thousands of thin filter pages
2. Product schema stuck at "InStock" when product is sold out
3. Category pages with no intro copy / just product grid
4. Internal search results indexed
5. Product images not lazy-loaded → terrible LCP on category pages
