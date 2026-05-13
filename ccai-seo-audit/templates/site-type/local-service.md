# Site-type overlay: local-service

For service businesses tied to physical locations, plumbers, dentists, lawyers, agencies serving a specific city/region.

## Additional checks (most pull from canonical category 8)

### L.1 NAP consistency across site
- **What:** Name + Address + Phone identical on every page footer + contact page + schema
- **Severity:** critical

### L.2 Google Business Profile claimed + optimized
- **What:** Manual check, GBP claimed, primary category + 2-4 secondary, hours, services, photos every quarter, reviews responded to
- **Severity:** critical

### L.3 LocalBusiness JSON-LD on homepage
- **What:** Homepage has LocalBusiness JSON-LD with address (PostalAddress), geo (latitude/longitude), openingHoursSpecification, priceRange, telephone, areaServed
- **Severity:** critical

### L.4 Location pages for multi-location
- **What:** If serving multiple cities, each city has a dedicated page with unique content (history, team, projects in that area), NOT templated copy with city name swapped
- **Severity:** high

### L.5 Service pages with local intent
- **What:** Each service has a page that combines service + location (e.g., "Plumbing Repair in Houston TX"), with local landmarks/neighborhoods mentioned
- **Severity:** high

### L.6 Citations on directories
- **What:** Consistent NAP on at least 10 local directories, Yelp, BBB, industry-specific (HomeAdvisor for trades, Avvo for lawyers, Healthgrades for medical)
- **Severity:** high

### L.7 Reviews on multiple platforms
- **What:** Active review presence on Google, Yelp, Facebook + industry-specific (BBB, etc.)
- **Severity:** medium

### L.8 Map embed on contact page
- **What:** Google Maps embed of business location on /contact
- **Severity:** medium

### L.9 Service area schema
- **What:** If service-area business (no walk-in), LocalBusiness schema uses `areaServed` properly with GeoCircle or list of cities
- **Severity:** high

## Weighted scoring for local-service

- NAP consistency (L.1), 3× weight
- GBP optimization (L.2), 3× weight
- LocalBusiness schema (L.3), 2× weight
- Location pages (L.4), 2× weight (multi-location only)

## Common findings on local-service sites

1. Different phone numbers on homepage vs footer vs Google Business Profile
2. Service pages without location modifier (just "Plumbing" not "Plumbing in Houston")
3. Templated location pages with no unique content
4. GBP set up years ago, never updated since
5. No LocalBusiness schema (or generic Organization schema instead)
