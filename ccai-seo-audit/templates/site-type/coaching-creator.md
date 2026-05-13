# Site-type overlay: coaching-creator

For solo operators, coaches, course creators, agencies-of-one. Authority and trust are the moat.

## Additional checks

### CC.1 About page depth
- **What:** /about page exists, has author photo, story, credentials, links to social proof, Person schema
- **Why:** AI engines disproportionately cite authority figures with strong entity signals.
- **Severity:** critical

### CC.2 Testimonials with Person schema
- **What:** Testimonials include name + photo + (where possible) link to person's profile/LinkedIn, marked up with Review or Testimonial schema
- **Severity:** high

### CC.3 Course/offer schema if applicable
- **What:** If selling courses, Course JSON-LD with name, description, provider; if coaching, Service or Offer schema
- **Severity:** high

### CC.4 Proof-of-work content
- **What:** Case studies, client results, before/after numbers visible. AI search heavily weights specific outcomes ("helped X grow from Y to Z").
- **Severity:** high

### CC.5 Booking/call-to-action prominence
- **What:** Above-fold and footer CTA leads to a booking page (Cal.com, Calendly), not a contact form
- **Severity:** high

### CC.6 Sameas social linking
- **What:** Organization JSON-LD `sameAs` includes all real social handles (LinkedIn, Twitter/X, YouTube, Instagram, Skool community)
- **Severity:** medium

### CC.7 Content velocity / freshness
- **What:** Blog/newsletter cadence, at least 1 published piece per month visible
- **Why:** Stale content = stale authority signal.
- **Severity:** medium

### CC.8 Community / email list signal
- **What:** Visible community link (Skool, Discord, Circle) OR email list opt-in with clear value prop
- **Severity:** high

## Weighted scoring for coaching-creator

- About page depth (CC.1), 3× weight
- Testimonials with schema (CC.2), 2× weight
- Proof-of-work (CC.4), 2× weight
- Booking CTA prominence (CC.5), 2× weight

## Common findings on coaching-creator sites

1. About page is 3 sentences with a stock photo
2. Testimonials are anonymous ("J.S., Houston")
3. Bookings hidden behind a contact form instead of an embedded calendar
4. Person schema missing from author markup
5. Social links exist but not in `sameAs` JSON-LD on homepage
6. Course offering not marked up with Course schema
