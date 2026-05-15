# ccai-article-pipeline

> End-to-end article publishing pipeline for Lovable-hosted Vite + React content sites. Drafts articles from recent Claude/AI news in your brand voice, commits to GitHub, verifies the full prerender pipeline ran correctly after publish. Built from the failure modes discovered in the first real Lovable SEO debug session.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 35-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-article-pipeline`
**Status:** v0.1 · Content tier · works with Claude Code

---

## What it does

A four-mode skill that handles the full content lifecycle for a Lovable site:

1. **Research + draft:** searches the web for recent Claude/AI/Anthropic news, proposes timely angles for small-business owners, drafts a 1500-2500 word article in your brand voice.
2. **Validate:** runs a 9-rule pre-publish gate (frontmatter completeness, seo_title length, no em-dashes, both CTAs present, slug uniqueness, etc.). Hard fails on any violation.
3. **Commit:** pushes the reviewed draft to your GitHub-synced Lovable repo on the working branch via `gh api` (no local clone needed).
4. **Verify:** after you click Publish in Lovable, runs 15 post-publish curl checks to confirm the OG image generated, body content prerendered, sitemap + llms.txt updated, JSON-LD baked in, /guides Latest section regenerated, and no adjacent pages regressed.

The skill stops short of clicking Publish in Lovable (manual step) and clicking Request Indexing in GSC + Bing (also manual). Everything else is automated.

## Why this exists

I ran my first real SEO setup on a Lovable site and hit four silent failure modes:

1. **OG generator 404'd silently** on an article with a 106-char title (satori choked on the length)
2. **`/guides` page body regressed** to a flat list when Lovable refactored prerender-routes for an adjacent feature
3. **Search engine caches stayed stale** for days after fixes shipped (Google still showed the original starter-template HTML)
4. **The empty-body trap**: rich `<head>` metadata but empty `<body>`, invisible to Google (it renders JS) but blocking to Bing + AI crawlers

This skill bakes in checks for every one of those, so future publishes catch them before they ship (or immediately after, before they cost weeks of indexed traffic).

## When this is the right tool

- You're shipping a content site on Lovable (Vite + React, GitHub-synced)
- You've run `ccai-seo-setup` v0.2 and have the prerender pipeline working
- You write articles in markdown with frontmatter
- You want a "draft → review → ship → verify" loop, not "draft and pray"

## When this is NOT the right tool

- You don't have a Lovable site → use the appropriate publishing pipeline for your stack
- You don't have a GitHub-synced project → the `--commit` step won't work; use it as draft-only
- You want fully automated end-to-end (including Publish click) → wait for the pro version with browser automation

## Modes

| Command | What it does |
|---|---|
| `/ccai-article-pipeline` | Default. WebSearch last 7 days for Claude/AI news, presents top 3-5 candidates, you pick one, drafts article, saves to `articles/draft-<slug>.md`. |
| `/ccai-article-pipeline <topic>` | Skips news search. Drafts on your specified topic. |
| `/ccai-article-pipeline --commit <slug>` | After your review, pushes the draft to your Lovable repo's working branch via `gh api`. |
| `/ccai-article-pipeline --verify <slug>` | Post-publish curl checks + Request Indexing URL list. Run after clicking Publish in Lovable. |
| `/ccai-article-pipeline --next` | Headless: auto-picks the top news candidate without prompting. For future cron use. |

## Output

```
articles/
├── draft-<slug>.md          # Draft, waits for human review
├── article-<NN>-<slug>.md   # Final after --commit (NN auto-incremented)
└── ...
```

Plus a verification report on `--verify`:

```
✅ Article URL              200 OK
✅ OG image                  200 OK
✅ <title>                   "Short SEO title" (52 chars)
✅ <h1>                      "Long viral hook" (98 chars)
✅ Body size                 4,221 bytes
✅ JSON-LD blocks            2 (Article + BreadcrumbList)
✅ /guides.html includes     present
✅ /guides.html cluster H2s  4 (no regression)
...
```

Failures get specific diagnostics + suggested Lovable prompts to fix.

## Prerequisites

- `gh` CLI authenticated
- `BRAND_VOICE.md` in working directory (voice enforcement)
- `memory/project_article_publish_workflow.md` (canonical frontmatter template)
- Existing `articles/` directory with prior articles (structure reference)
- Site running the `ccai-seo-setup` v0.2 prerender pipeline

## Install

```bash
git clone https://github.com/cory-dot/ccai-article-pipeline ~/.claude/skills/ccai-article-pipeline
```

## Usage

```
# Get a draft from this week's Claude news
/ccai-article-pipeline

# Or specify your own topic
/ccai-article-pipeline "How small businesses should think about Claude Skills"

# After reviewing the draft, push to GitHub
/ccai-article-pipeline --commit how-small-biz-thinks-about-claude-skills

# After clicking Publish in Lovable, verify
/ccai-article-pipeline --verify how-small-biz-thinks-about-claude-skills
```

## Pairs with

- **`ccai-seo-audit`**, periodic diagnostic. Run monthly to catch regressions across the whole site.
- **`ccai-seo-setup`**, the underlying prerender infrastructure this pipeline depends on.
- **`ccai-content-ideas`**, alternative idea source (pure brainstorming, no news angle).
- **`ccai-brand-voice`**, voice capture skill that produces `BRAND_VOICE.md`.

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack):

```bash
# Just this skill
git clone https://github.com/cory-dot/ccai-article-pipeline ~/.claude/skills/ccai-article-pipeline

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
