# Sample setup run: creativecore.ai on Lovable (2026-05-12)

Walkthrough of `/ccai-seo-setup lovable audits/creativecore-ai-2026-05-12/REPORT.md`, feeding an audit into setup to generate paste-ready Lovable prompts.

---

## Step 1, Skill reads the audit

Skill opens `audits/creativecore-ai-2026-05-12/REPORT.md`, extracts the top 10 fixes:

1. Add FAQPage schema to all 12 guides
2. Visible "Updated YYYY-MM-DD" on every guide
3. OG image dimensions + absolute URLs
4. Person schema + author page
5. IndexNow integration
6. UTM auto-tagging on share buttons
7. Author page (combined with #4)
8. Bing Webmaster verification
9. Image lazy-loading
10. BreadcrumbList schema

## Step 2, Skill asks for missing context

```
Stack: lovable (from arg)
Source: audit
Site type: coaching-creator + content-blog (from audit)

A few details to fill the prompts cleanly:

1. Production domain: creativecore.ai (confirmed from audit)
2. Author name for Person schema: Cory Loflin
3. Photo URL for Person schema (used in JSON-LD): ?
4. LinkedIn handle for sameAs (optional): ?
5. IndexNow key, generate a new one, or you have one? (generate)
6. Bing Webmaster, verified yet? (no, will add to plan)
```

User provides: photo URL `https://creativecore.ai/cory.jpg`, no LinkedIn yet, generate IndexNow key.

## Step 3, Skill writes SETUP_PLAN.md

```markdown
# SEO Setup Plan, creativecore.ai

Stack: Lovable (Vite + React)
Site type: coaching-creator + content-blog
Source: audit (REPORT.md from 2026-05-12)
IndexNow key: 8a7f4b2e3c1d6f9a0b5e7c2d4f8a1b3e

## Fixes (ordered by dependency + impact × ease)

1. ⏳ Create /about page with Person schema, `prompts/01-author-page.md`
2. ⏳ Update Article JSON-LD across guides to reference /about, `prompts/02-article-schema-update.md`
3. ⏳ Add visible "Updated YYYY-MM-DD" + dateModified, `prompts/03-updated-date.md`
4. ⏳ Fix OG image absolute URLs, `prompts/04-og-image-urls.md`
5. ⏳ Add FAQPage schema to guides with Q&A H2s, `prompts/05-faq-schema.md`
6. ⏳ Add BreadcrumbList schema to guides, `prompts/06-breadcrumb-schema.md`
7. ⏳ Lazy-load images on long guides, `prompts/07-lazy-load-images.md`
8. ⏳ UTM auto-tag share buttons, `prompts/08-utm-share.md`
9. ⏳ IndexNow integration, `prompts/09-indexnow.md`
10. ⏳ Bing Webmaster Tools verification, `prompts/10-bing-webmaster.md` (user task, no Lovable)
```

## Step 4, Per-fix prompts (sample: 01 and 05)

### `prompts/01-author-page.md`

```markdown
# Fix 1: Create /about page with Person schema

**Checklist item:** 3.5 (Person schema for authors) + CC.1 (About page depth)
**Why:** EEAT authority signal, AI engines weight cited sources by author entity. Currently the site credits Cory in bylines but has no author page or Person schema. This is the highest-impact fix in the audit.

**The prompt, paste this into Lovable:**

---

Create a new page at /about with the following:

1. Visible content:
   - Photo of Cory (use https://creativecore.ai/cory.jpg)
   - Heading: "Cory Loflin, Founder, Creative Core AI"
   - Sub: "Houston TX. AI marketing operations for small businesses."
   - 2-paragraph bio (placeholder; I'll write the real copy):
     - Para 1: Background + what CCAI does
     - Para 2: Why I started the free Skool community + diagnostic call CTA
   - Two CTAs at the bottom: "Start the free course →" (links to https://skool.com/creative-core-ai) and "Book a free diagnostic" (links to https://creativecore.ai/book)
   - Social links: GitHub (https://github.com/cory-dot), Instagram (https://instagram.com/creativecoreai), Skool (https://skool.com/creative-core-ai)

2. In the head of /about, inject this Person JSON-LD via react-helmet-async:

```json
{
  "@context": "https://schema.org",
  "@type": "Person",
  "@id": "https://creativecore.ai/about#cory",
  "name": "Cory Loflin",
  "url": "https://creativecore.ai/about",
  "image": "https://creativecore.ai/cory.jpg",
  "jobTitle": "Founder",
  "worksFor": { "@type": "Organization", "name": "Creative Core AI", "url": "https://creativecore.ai" },
  "sameAs": [
    "https://github.com/cory-dot",
    "https://instagram.com/creativecoreai",
    "https://skool.com/creative-core-ai"
  ]
}
```

3. Add /about to the sitemap.xml output and to the primary nav.

---

**Verify by:**
1. Visit https://creativecore.ai/about, confirm visible bio
2. Run https://creativecore.ai/about through https://search.google.com/test/rich-results, Person schema detected, no errors
3. View source, confirm `<script type="application/ld+json">` block in head
```

### `prompts/05-faq-schema.md`

```markdown
# Fix 5: Add FAQPage schema to guides with Q&A H2s

**Checklist item:** 5.1 (FAQ section with FAQPage schema)
**Why:** Highest-return AEO item. AI Overviews and ChatGPT search heavily cite content with FAQPage schema. The audit identified 9 of 12 guides have H2/H3 questions but no FAQPage JSON-LD wrapper.

**Affected guides (from audit):**
- /guides/01, /guides/02, /guides/04, /guides/05, /guides/06, /guides/08, /guides/09, /guides/10, /guides/12

**The prompt, paste this into Lovable:**

---

For each of the listed guide pages, detect H2/H3 elements ending in "?" (these are the FAQ questions) and the paragraph immediately after each (the answer). Build a FAQPage JSON-LD block from those Q&As and inject into the page head via react-helmet-async.

Per-guide approach:

1. Walk the article body's rendered DOM (or the source markdown if available)
2. Collect H2 or H3 elements whose text ends with "?"
3. For each, capture the question text and the next paragraph's plaintext (strip HTML)
4. If 4-6 Q&As exist, wrap in FAQPage JSON-LD:

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "<question text>",
      "acceptedAnswer": { "@type": "Answer", "text": "<answer paragraph>" }
    }
    // ... per Q&A
  ]
}
```

5. Inject the JSON-LD via Helmet into the head of that specific article page

Do NOT fabricate Q&As. If a page doesn't have natural question H2s, skip it and log "no FAQ-eligible content on this page", don't force-fit.

---

**Verify by:**
1. Open any of the affected guide URLs in https://search.google.com/test/rich-results
2. Confirm FAQ block detected with the Q&As shown
3. Repeat for at least 3 different guides

After applying, mark this item ✅ in SETUP_PLAN.md and move to fix 6.
```

(Skipping the other 8 prompts for brevity, each follows the same pattern.)

## Step 5, verification-checklist.md

```markdown
# Verification checklist for SEO setup

After each fix is applied in Lovable, verify:

| Fix | Verify by | URL/Tool |
|---|---|---|
| 01, /about + Person schema | Visit /about + Rich Results Test | https://search.google.com/test/rich-results |
| 02, Article JSON-LD links to /about | View-source on any guide, find author.@id | view-source: |
| 03, Visible Updated date | Open any guide, see "Updated YYYY-MM-DD" near title | browser |
| 04, OG image absolute URLs | View-source, confirm og:image starts with https://creativecore.ai | view-source: |
| 04 (cont), OG preview | Facebook Sharing Debugger + Twitter Card Validator | https://developers.facebook.com/tools/debug/ |
| 05, FAQPage schema | Rich Results Test on /guides/01, /guides/02 (sample) | https://search.google.com/test/rich-results |
| 06, BreadcrumbList | Rich Results Test on any /guides/* | same |
| 07, Lazy-load images | DevTools Network tab, images load as user scrolls | browser DevTools |
| 08, UTM share | Click copy-link on any guide, paste, URL has ?utm_source=share | browser |
| 09, IndexNow | Visit creativecore.ai/<KEY>.txt, returns key content | browser |
| 09 (cont), IndexNow ping | After publishing a test page, check Bing Webmaster Tools "URL Inspection", should be indexed within hours | Bing Webmaster |
| 10, Bing Webmaster | Property verified, sitemap submitted, sitemap status: success | Bing Webmaster |
```

## Step 6, README.md for the setup folder

```markdown
# SEO Setup, creativecore.ai

This folder contains paste-ready Lovable prompts for the top 10 SEO + AEO fixes from your 2026-05-12 audit.

## How to use

1. Open SETUP_PLAN.md
2. Start with prompt 01, open `prompts/01-author-page.md`
3. Copy the section under "The prompt, paste this into Lovable:"
4. Paste into your Lovable project chat
5. Wait for Lovable to apply, verify per verification-checklist.md
6. Mark fix ✅ in SETUP_PLAN.md
7. Move to prompt 02

## Order matters

Fixes are dependency-ordered. Author page (01) must exist before Article JSON-LD (02) can reference it. Don't reorder.

## After all fixes applied

Re-run `/ccai-seo-audit creativecore.ai` to verify scores improved. Target: site score from 72 → 90+, AEO score from 58 → 85+.
```

## What the user does next

1. Opens `seo-setup/prompts/01-author-page.md` in Cursor or VS Code
2. Copies the prompt block
3. Pastes into Lovable chat
4. Lovable applies the change
5. User verifies per the checklist
6. Marks ✅ in SETUP_PLAN.md
7. Moves to 02

Total time to apply all 10 fixes: about an hour of paste-verify-mark cycles.
