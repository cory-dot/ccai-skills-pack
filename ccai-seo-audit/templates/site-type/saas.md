# Site-type overlay: saas

For SaaS products with feature pages, pricing, blog, docs.

## Additional checks

### S.1 Comparison page presence
- **What:** Dedicated `<competitor>-vs-<you>` or `<category>-alternatives` pages
- **Why:** Highest-converting commercial-intent traffic. AI search heavily cites comparison content.
- **Severity:** high

### S.2 Pricing page indexable + structured
- **What:** /pricing is not noindexed, has visible prices (or "starts at $X"), Product/Offer schema
- **Why:** Common own-goal, teams noindex pricing thinking it's "lead-gated."
- **Severity:** critical

### S.3 Feature pages depth
- **What:** Each major feature has its own page with use case, screenshots, integration list, not just a card on /features
- **Severity:** high

### S.4 Glossary / docs subdomain configuration
- **What:** Glossary terms and docs are indexable, on the same root domain (`/docs`, `/glossary`) or properly configured subdomain
- **Severity:** medium

### S.5 Integration / app pages
- **What:** Each supported integration has its own page (`/integrations/<tool>`), these rank for "<their tool> + <yours>" queries
- **Severity:** high

### S.6 Software/SoftwareApplication schema
- **What:** Homepage has SoftwareApplication JSON-LD with name, applicationCategory, offers, operatingSystem
- **Severity:** medium

### S.7 Trust signals on homepage
- **What:** Visible above-fold, logo bar, count of users/customers, key testimonial with Person schema
- **Severity:** high

## Weighted scoring for saas

- Comparison pages (S.1), 3× weight
- Pricing indexability (S.2), 3× weight
- Feature page depth (S.3), 2× weight
- Integration pages (S.5), 2× weight

## Common findings on saas sites

1. /pricing noindex'd or behind JS-only render
2. /docs on separate subdomain without proper hreflang/canonical
3. Marketing site speed killed by feature-page video autoplay
4. No comparison or alternatives content
5. JS-rendered above-fold content with no SSR fallback
