# Meta-prompt: customize the prompts to your site

The 13 essential SEO prompts (see `templates/PROMPTS.md` or the published article) use placeholder variables like `${YOUR_DOMAIN}`. Two ways to fill them in:

1. **Easy path:** paste this meta-prompt + the prompts you want into Claude.ai or Cursor or any LLM. The LLM returns customized versions ready to paste into your build tool.
2. **Manual path:** find-replace the variables in your editor.

## The meta-prompt

Paste this entire block into Claude.ai (or any LLM chat). Edit the `MY SITE` block at the top to match your site. Paste the prompts you want from the appendix at the bottom. The LLM returns customized prompts in the same order, each in its own code block.

````
Below is my site config and a set of generic SEO prompts. Customize each prompt by replacing every ${VARIABLE} with my actual values. Return the customized prompts one at a time, each in its own code block, in the same order I gave you. Do not paraphrase the prompts or change their structure. Only substitute the variables.

If a variable looks like JSON or a multi-line list, format it appropriately for the surrounding context (e.g., a JS array vs. inline text).

If a variable is missing from MY SITE below, leave the placeholder in place and add a comment at the end of the customized prompt: "// Missing: ${VARIABLE_NAME}".

=== MY SITE ===

YOUR_DOMAIN: example.com
YOUR_SITE_URL: https://example.com
YOUR_BUSINESS_NAME: Example Business
YOUR_BUSINESS_TAGLINE: One-sentence value proposition, under 100 characters.
YOUR_BUSINESS_DESCRIPTION: Two-to-three-sentence longer description for meta descriptions and Organization schema. Used by Google and AI surfaces to summarize what your business is.

YOUR_FOUNDER_NAME: First Last
YOUR_FOUNDER_NAME_SLUG: firstlast      # lowercase, no spaces; used in JSON-LD @id like /about.html#firstlast
YOUR_FOUNDER_TITLE: Founder
YOUR_FOUNDER_FIRSTNAME_LOWER: first    # lowercase first name; used for /<first>.jpg filename
YOUR_FOUNDER_BIO_P1: First paragraph of your founder bio. Direct, in your voice. About 80-120 words.
YOUR_FOUNDER_BIO_P2: Second paragraph. Optional CTA-adjacent close. About 60-100 words.

YOUR_LOCATION_CITY: Houston
YOUR_LOCATION_REGION: TX
YOUR_LOCATION_COUNTRY: US

YOUR_BOOKING_URL: /book.html
YOUR_BOOKING_CTA: Book a free consult call

YOUR_GUIDES_DIR: src/content/guides    # where markdown content lives

YOUR_BRAND_SOCIALS:
  - https://www.instagram.com/example/
  - https://www.facebook.com/example
  - https://www.linkedin.com/company/example/
  - https://www.youtube.com/@example
  - https://x.com/example
  - https://www.tiktok.com/@example
  # Used in Organization.sameAs. Brand-owned accounts only.

YOUR_FOUNDER_PERSONAL_SOCIALS:
  - https://github.com/yourhandle
  # Personal-only accounts. Brand socials do NOT go here. Used in Person.sameAs.

YOUR_KNOWS_ABOUT:
  - Topic 1
  - Topic 2
  - Topic 3
  - Topic 4
  - Topic 5
  # 3-7 topics your business is expert in. Used in Organization.knowsAbout.

YOUR_OFFERS:
  - { name: "Starter tier name", priceRange: "$X-$Y" }
  - { name: "Mid tier name", priceRange: "$X-$Y/mo" }
  - { name: "Top tier name", priceRange: "$X-$Y/mo" }
  # Optional. Used in Organization.offers. Skip if you don't publish prices.

YOUR_LOGO_URL: https://example.com/og-image.png   # 1200×630, used as default OG image + Organization.logo

YOUR_INDEXNOW_KEY: # leave blank; the IndexNow prompt will generate one

=== PROMPTS TO CUSTOMIZE ===

(paste the prompts you want from `templates/PROMPTS.md` or the article appendix here, one after another, with --- separators between them if you want clearer LLM output)
````

## Tips for using the meta-prompt

- **Run it in a single LLM conversation.** The LLM can refer back to your `MY SITE` config for each prompt without you having to re-paste it.
- **Start small.** Customize 2-3 prompts at a time, paste them into your build tool, verify, then come back for the next batch. Don't dump all 13 at once unless you're confident.
- **The output is paste-ready, but verify before publish.** Read each customized prompt and confirm the variables look right. The LLM will sometimes miss edge cases (e.g., JSON arrays vs. multi-line lists).
- **Save your `MY SITE` block.** Once you've filled it out, save it as a file (e.g., `seo-config.txt` in your repo). Future setup runs reuse the same config without you having to re-type everything.

## Variable reference

| Variable | Used in prompts | Notes |
|---|---|---|
| `YOUR_DOMAIN` | All | Domain only, no protocol. e.g., `example.com` |
| `YOUR_SITE_URL` | All | Full URL with protocol. e.g., `https://example.com` |
| `YOUR_BUSINESS_NAME` | 02, 05-07, 09, 12 | Business name as it appears in nav / footer |
| `YOUR_BUSINESS_TAGLINE` | 02, 09 | Short value prop, used in titles + OG |
| `YOUR_BUSINESS_DESCRIPTION` | 02, 07, 12 | 2-3 sentence description |
| `YOUR_FOUNDER_NAME` | 06, 07 | For Person + Organization.founder |
| `YOUR_FOUNDER_NAME_SLUG` | 05, 06, 07 | For JSON-LD `@id` values |
| `YOUR_FOUNDER_TITLE` | 06, 07 | e.g., "Founder", "CEO" |
| `YOUR_FOUNDER_FIRSTNAME_LOWER` | 06 | For `/public/<first>.jpg` photo filename |
| `YOUR_FOUNDER_BIO_P1`, `YOUR_FOUNDER_BIO_P2` | 06 | Bio paragraphs in your voice |
| `YOUR_LOCATION_CITY/REGION/COUNTRY` | 06, 07 | PostalAddress fields |
| `YOUR_BOOKING_URL` | 06, FAQ filter in 05 | Where your primary CTA goes |
| `YOUR_BOOKING_CTA` | 06 | Button text |
| `YOUR_GUIDES_DIR` | 02, 03, 05, 08, 09, 10, 12 | Path to markdown content directory |
| `YOUR_BRAND_SOCIALS` | 07 | List of brand-owned social URLs |
| `YOUR_FOUNDER_PERSONAL_SOCIALS` | 06 | List of personal-only social URLs |
| `YOUR_KNOWS_ABOUT` | 07 | Topic list for Organization.knowsAbout |
| `YOUR_OFFERS` | 07 | Optional service tiers for Organization.offers |
| `YOUR_LOGO_URL` | 05 | Default OG image + Organization.logo |
| `YOUR_INDEXNOW_KEY` | 10 | 32-char hex; the prompt generates one if not set |