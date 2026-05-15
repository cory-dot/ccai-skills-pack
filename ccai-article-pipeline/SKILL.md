---
name: ccai-article-pipeline
description: "End-to-end article publishing pipeline for creativecore.ai (and any Lovable-hosted Vite + React content site with the ccai-seo-setup infrastructure). Drafts articles in your brand voice from recent Claude/AI news (or a specified topic), validates frontmatter against the 9-rule pre-publish gate, commits the .md to your GitHub-synced Lovable repo on the right branch, and verifies the full prerender pipeline ran correctly after you publish (OG image, body content, sitemap, llms.txt, JSON-LD, /guides Latest section). Built from the failure modes discovered in the first real Lovable SEO debug session: silent OG generator failures on long titles, /guides body regression on adjacent refactors, stale search engine cache, empty body trap."
when_to_use: "User wants to write a new article and publish it to their Lovable site. Triggered by /ccai-article-pipeline, /write-article, or any mention of drafting + publishing a guide/article to their CCAI site. Also triggers when user wants to verify a recently-published article shipped correctly."
argument-hint: "[topic, OR --commit <slug>, OR --verify <slug>, OR --next]"
---

# CCAI Article Pipeline

Orchestrates the full lifecycle of a new article: research → draft → validate → commit → publish (manual step) → verify. Designed for Lovable-hosted Vite + React content sites running the `ccai-seo-setup` v0.2 prerender infrastructure.

## What this skill IS

- A content pipeline. Topic → reviewed markdown → GitHub commit → published article → verification report.
- News-driven by default. Searches the web for recent Claude/AI/Anthropic updates and proposes timely takes for small-business owners.
- Voice-aware. Reads `BRAND_VOICE.md` and enforces project-wide rules (no em-dashes, signature patterns, both CTAs at end).
- Failure-aware. Built from the actual gotchas hit in the first real publish: OG generator silently 404s on long titles, prerender-routes refactors can regress /guides body, search engine cache stales after structural changes, body prerender is non-negotiable for SPAs.

## What this skill is NOT

- Not an auto-publisher. Lovable's manual Publish click is required (we don't browser-automate it; brittle). The skill stops at the GitHub commit step.
- Not a content idea generator from scratch. For pure idea brainstorming, use `ccai-content-ideas`. This skill specializes in news-driven articles.
- Not for non-Lovable sites without modification. The commit step targets a Lovable + GitHub-synced project. Adapt the `--commit` mode for other hosts.

## Prerequisites

- A GitHub-synced Lovable project (this skill commits via `gh api`, no local clone needed)
- `gh` CLI authenticated for the user
- `BRAND_VOICE.md` in the working directory (for voice enforcement)
- Existing `articles/` directory with prior articles (for structure + length reference)
- `memory/project_article_publish_workflow.md` (for canonical frontmatter template)
- The site running the `ccai-seo-setup` v0.2 prerender pipeline (`prerender-routes.ts`, `prerender-guides.ts`, OG generation, IndexNow auto-ping, llms.txt)

## Output contract

```
articles/
├── article-<NN>-<slug>.md   # Final published versions (NN auto-incremented). Source of truth for the authoring workspace.
├── drafts/
│   └── draft-<slug>.md      # In-progress drafts. Auto-moved + renamed on --commit.
└── ...

When a draft is committed, the file is renamed AND moved:
  articles/drafts/draft-<slug>.md   →   articles/article-<NN>-<slug>.md
  (both locally AND in the GitHub repo)

verify-output (on --verify <slug>):
✅ /guides/<slug>.html         → 200
✅ /og/<slug>.png              → 200
✅ <title>                     → matches seo_title
✅ <h1>                        → matches title
✅ Body size                   → 1,234 bytes (above threshold)
✅ Canonical                   → matches frontmatter
✅ Sitemap entry               → present
✅ llms.txt entry              → present
✅ JSON-LD count               → 2 (Article + BreadcrumbList)
❌ /guides.html Latest section → article URL NOT found
   → Diagnosis: ...
   → Suggested Lovable prompt: ...
```

## Process

### Mode 1, Default (no args), news-driven draft

User invokes `/ccai-article-pipeline` with no arguments. Skill researches and drafts.

1. **Research recent news.** Use WebSearch with queries like "Anthropic Claude announcement past week", "Claude 4 release notes", "Anthropic AI marketing news". Filter for stories from the last 7 days.

2. **Filter for audience fit.** Score each story on:
   - Is it relevant to small-business owners (not just developers)?
   - Does it have a "what does this mean for me" angle?
   - Is it newsy enough to feel timely?
   Drop technical-only stories and pure marketing announcements. Keep substantive product/feature/research releases.

3. **Present top 3-5 candidates** as a numbered list with:
   - Headline of the news story
   - Date
   - One-sentence "what's new"
   - One-sentence "the take" we'd write for Cory's audience

4. **Ask user to pick** which one to write (or "give me different options"). If the user picks "different options", expand search to last 14 days and re-present.

5. **Draft the article.** Use this structure:
   - **H1**: long viral hook (60-110 chars) that frames the news as a question or contrarian take
   - **Lead paragraph**: 2-3 sentences, "honest answer" pattern
   - **TL;DR block**: 4-6 lines bolded summary at top (mirrors existing articles)
   - **Body**: 1500-2500 words, H2 sections, conversational, direct
   - **Honest take section**: Cory's contrarian or experiential take on what the news actually means (this is the differentiator)
   - **Practical "what to do" section**: 3-5 concrete actions a reader can take this week
   - **Two CTAs at end**: Skool + /book.html (brand voice rule)

6. **Generate frontmatter** matching the template in `memory/project_article_publish_workflow.md`:
   - `title`: the long H1 hook (60-110 chars)
   - `seo_title`: short SEO version (under 60 chars), keyword-targeted
   - `slug`: kebab-case, derived from seo_title
   - `published`, `updated`: today's UTC date
   - `author`: Cory Loflin
   - `category`: foundations / AI marketing operations / Build with AI / News (pick best fit)
   - `meta_description`: 2-3 sentence summary (under 160 chars)
   - `og_image`: `/og/<slug>.png`
   - `canonical_url`: `https://creativecore.ai/guides/<slug>.html`
   - `reading_time`: estimated based on word count (~250 wpm)

7. **Run pre-publish gate checks** (see Pre-publish gate section below). If any fail, fix automatically where possible (e.g., shorten seo_title) or warn the user.

8. **Save** to `articles/drafts/draft-<slug>.md` locally. Also push a backup to the GitHub repo at `articles/drafts/draft-<slug>.md` on `refresh/wave-1` (gives you collaborator-visible drafts for review on mobile / from anywhere).

9. **Output summary**:
   - Word count, reading time, frontmatter snapshot
   - Voice check results (PASS/FAIL per rule)
   - Path to draft (local + GitHub URL)
   - Next step: "Review the draft, then run `/ccai-article-pipeline --commit <slug>` to publish"

### Mode 2, Topic-specified draft

User invokes `/ccai-article-pipeline <topic>` with a specific topic.

Skip the news search step. Use the user's topic as the seed. Otherwise same as Mode 1 from step 5 onward. Useful for:
- Writing about your own product / tool / case study
- Following up on a previous article
- Evergreen pieces (no news angle needed)

### Mode 3, --commit <slug>, push reviewed draft to GitHub

User invokes `/ccai-article-pipeline --commit <slug>`. Skill validates and pushes.

1. **Locate the draft.** Look in this order:
   - `articles/drafts/draft-<slug>.md` (current convention)
   - `articles/draft-<slug>.md` (legacy location, for older drafts)
   - `articles/article-*-<slug>.md` (might be a re-commit of an already-renamed file)
   Fail if none of these exist.

2. **Re-run pre-publish gate** (full set, see below). HARD FAIL on any gate failure. Output the failing checks and stop. Don't silently push broken content.

3. **Determine target branch.** Default: `refresh/wave-1` for cory-dot/creativecoregroup (the Lovable working branch). Configurable via env var `CCAI_LOVABLE_BRANCH` or skill arg `--branch <name>`.

4. **Push via GitHub Contents API.** Use `gh api`:
   ```bash
   # Get the SHA of the file if it exists (for updates), else create new
   EXISTING_SHA=$(gh api "repos/cory-dot/creativecoregroup/contents/src/content/guides/<slug>.md?ref=refresh/wave-1" --jq .sha 2>/dev/null)
   
   # Base64 encode the file content
   CONTENT=$(base64 -w 0 articles/draft-<slug>.md)
   
   # PUT to GitHub Contents API
   gh api "repos/cory-dot/creativecoregroup/contents/src/content/guides/<slug>.md" \
     --method PUT \
     -f message="Add article: <article title>" \
     -f branch="refresh/wave-1" \
     -f content="$CONTENT" \
     ${EXISTING_SHA:+-f sha="$EXISTING_SHA"}
   ```

5. **Rename and move:**
   - Local: rename `articles/drafts/draft-<slug>.md` → `articles/article-NN-<slug>.md` (auto-increment NN based on existing article numbers in `articles/`)
   - GitHub: PUT the finalized version to `articles/article-NN-<slug>.md` AND DELETE the old `articles/drafts/draft-<slug>.md` so the drafts/ folder stays clean

6. **Output summary**:
   - Commit SHA for production push
   - Commit SHA for /articles/ backup
   - Commit SHA for draft deletion
   - Branch
   - File paths (production + backup + deleted draft)
   - Next steps:
     - "Go to Lovable, click Publish."
     - "After publish completes, run `/ccai-article-pipeline --verify <slug>`"

### Mode 4, --verify <slug>, post-publish checks

User invokes `/ccai-article-pipeline --verify <slug>` after they've clicked Publish in Lovable. Skill runs all post-publish curls and outputs a pass/fail report.

1. **Wait briefly** (~10s) if just-published, to let CDN settle.

2. **Run all 15 verification checks** in parallel via Bash:
   ```bash
   SLUG=<slug>
   SITE=https://creativecore.ai
   
   # Run all curls, parse results
   ARTICLE_STATUS=$(curl -sI "$SITE/guides/$SLUG.html" | head -1)
   OG_STATUS=$(curl -sI "$SITE/og/$SLUG.png" | head -1)
   ARTICLE_HTML=$(curl -s "$SITE/guides/$SLUG.html")
   TITLE_TAG=$(echo "$ARTICLE_HTML" | grep -oE '<title>[^<]*' | head -1)
   H1_TAG=$(echo "$ARTICLE_HTML" | grep -oE '<h1[^>]*>[^<]+' | head -1)
   BODY_SIZE=$(echo "$ARTICLE_HTML" | awk '/<body/,/<\/body>/' | wc -c)
   CANONICAL=$(echo "$ARTICLE_HTML" | grep -oE 'rel="canonical" href="[^"]*"')
   OG_URL=$(echo "$ARTICLE_HTML" | grep -oE 'og:url" content="[^"]*"')
   OG_IMAGE_META=$(echo "$ARTICLE_HTML" | grep -oE 'og:image" content="[^"]*"')
   JSON_LD_COUNT=$(echo "$ARTICLE_HTML" | grep -c "application/ld+json")
   AUTHOR_AT_ID=$(echo "$ARTICLE_HTML" | grep -oE '"@id":"https://creativecore.ai/about.html#[a-z]+"')
   SITEMAP_HAS=$(curl -s "$SITE/sitemap.xml" | grep -c "$SLUG")
   LLMS_HAS=$(curl -s "$SITE/llms.txt" | grep -c "$SLUG")
   GUIDES_HAS=$(curl -s "$SITE/guides.html" | grep -c "$SLUG")
   GUIDES_H2_COUNT=$(curl -s "$SITE/guides.html" | grep -oE '<h2[^>]*>[^<]+' | wc -l)
   SENTINEL=$(curl -s "$SITE/PRERENDER_RAN.txt" | head -1)
   ```

3. **Output a clear pass/fail report.** Format:
   ```
   ✅ Article URL              200 OK
   ✅ OG image                  200 OK
   ✅ <title>                   "<seo_title>" (52 chars)
   ✅ <h1>                      "<title>" (98 chars)
   ✅ Body size                 4,221 bytes
   ✅ Canonical                 https://creativecore.ai/guides/<slug>.html
   ✅ OG image meta             https://creativecore.ai/og/<slug>.png
   ✅ JSON-LD blocks            2 (Article + BreadcrumbList)
   ✅ Author @id                https://creativecore.ai/about.html#cory
   ✅ Sitemap entry             present
   ✅ llms.txt entry            present
   ✅ /guides.html includes     present
   ✅ /guides.html cluster H2s  4 (no regression)
   ✅ Build sentinel timestamp  2026-05-14T16:42:00Z (recent)
   
   ALL CHECKS PASSED
   ```

   On any failure, mark with ❌ + diagnosis + suggested Lovable prompt to fix.

4. **Output Request Indexing URL list:**
   ```
   Manual next step: Request Indexing in GSC and Bing for:
     https://creativecore.ai/guides/<slug>.html
   
   (Also rerun verify after re-publish if you had to fix anything.)
   ```

### Mode 5, --next, headless idea-pick

Same as Mode 1 but auto-picks the top candidate without asking. Saves draft to `articles/draft-<slug>.md`. Designed for future cron-firing; for now invoked manually if you want a fast no-prompt draft.

## Pre-publish gate (the 9 rules)

All checks run on `articles/draft-<slug>.md` before allowing `--commit`. HARD FAIL on any single failure.

1. **Required frontmatter fields present:** `title`, `seo_title`, `slug`, `published`, `updated`, `author`, `category`, `meta_description`, `og_image`, `canonical_url`, `reading_time`
2. **`seo_title` length ≤ 60 chars**
3. **`title` length ≤ 110 chars** (warn-only if longer)
4. **`meta_description` length ≤ 160 chars** (warn-only if longer)
5. **No em-dashes (`—` or `—`) anywhere in body or frontmatter**
6. **Both CTAs at the end of the body:** must contain BOTH a link to `skool.com/creative-core-ai-7628` AND a link to `/book` (or `/book.html`)
7. **`canonical_url` ends in `.html`**
8. **`slug` not already used** by another article in `articles/` (excluding the current draft)
9. **`og_image` path matches `/og/<slug>.png`** exactly

## Editorial rules to enforce (separate from voice)

These are about WHAT goes in the article, not HOW it's written. They apply at drafting time and must be re-checked at `--commit`.

### Rule E1: assume the reader has their own setup

Personal examples are encouraged (real numbers, real tools, concrete situations make articles credible). But every example must read as a template, not a tour of Cory's personal machine.

Drafted articles MUST NOT contain:
- ❌ Absolute file paths from Cory's machine (`D:\claude-code-agents\`, `C:\Users\coryl\...`, etc.). Use relative paths or `<placeholders>`.
- ❌ Internal tool names that aren't public to the reader (e.g., `creative-engine`). If a personal tool is essential, describe what it does generically: "my existing video pipeline" not "creative-engine."
- ❌ Internal client identifiers like `ccai_ads`, `creativecoreai` (used as database client keys) — readers don't have those rows.
- ❌ Personal config that doesn't generalize (specific Meta dev app names, ad account names, etc.).
- ❌ Scratch file paths or session-specific filenames (e.g., `scratch/ccai_ads/280-meta-creative-flow.md`).

Drafted articles MAY contain:
- ✅ Public tools/services by name (Pipeboard, Claude Code, GitHub, ElevenLabs, etc.).
- ✅ Real numbers and outcomes ("first ad cost $2.11") — grounds the story without requiring reader to have the same setup.
- ✅ Generic file paths in code examples (`<your video path>`, `.mcp.json`, `src/pages/...`).

### Rule E2: don't let side quests dilute the value prop

Every article has ONE main value proposition stated in the H1 / lead / TL;DR. Sections that don't directly serve that value prop get cut, no matter how individually interesting.

**Pre-flight check at draft time:**
1. State the value prop in one sentence. Write it down at the top of the draft scratch.
2. For each section, ask: "Does this serve the value prop, or am I including it because it's interesting?" Cut the second category.
3. If multiple distinct value props emerge during drafting, split into multiple articles. One article = one value prop.

**Example from article-15 (Meta Ads MCP):** original draft had 10 "discoveries" but only 6 served the value prop ("how to use Pipeboard to connect agents to Meta Ads"). The other 4 (brand voice methodology, pre-flight QA gates, parallel-DB pattern, "system is the product" philosophy) were cut. Each could become its own article for a different audience.

This rule is the difference between a focused article that ranks for its target query and a sprawling article that's interesting to read but doesn't serve a search intent.

## Brand voice rules to enforce (from BRAND_VOICE.md + memory)

Drafted articles MUST:
- Use signature patterns: "Here's the honest answer:", "Here's the thing", "actually" (as tone softener), "real" (adjectivally, "real numbers, not vibes")
- Open with hook + lead, not "Hey friends!" or any greeting
- Cadence: ~14 word average sentence length, short paragraphs (2-3 sentences typical), fragments for emphasis
- First-person singular "I" for Cory's solo content; "we" only when representing CCAI as a company
- Direct second-person "you" for the reader
- End with TWO CTAs (Skool + /book.html)

Drafted articles MUST NOT contain:
- ❌ Em-dashes anywhere (project-wide ban as of 2026-05-12)
- ❌ "transform" / "transformative", "revolutionary", "game-changing", "leverage" (as verb), "synergy", "ecosystem", "passionate about", "in today's fast-paced world", "unlock the power of"
- ❌ "Click here", "Don't miss out", "Sign up today!"
- ❌ Emoji (allowed sparingly in social, not in articles)
- ❌ Hashtags
- ❌ AI-affirmative openers ("Great question!", "Certainly!")
- ❌ Moralizing closers ("And that's why you should...")

## Hard rules

- **Never auto-commit without --commit explicitly invoked.** All draft mode invocations stop at the local draft file. The user always reviews.
- **HARD FAIL on pre-publish gate violations.** Don't try to "fix in commit" — return to draft, fix, re-run gate.
- **Never bypass `gh` auth.** If `gh auth status` returns unauthenticated, output the auth command and stop.
- **Respect the Lovable working branch.** Default to `refresh/wave-1` for cory-dot/creativecoregroup. Don't push to `main` unless explicitly told.
- **Idempotent --verify.** Can be run multiple times; only reads, never writes.
- **Don't fabricate news.** If WebSearch returns no relevant Claude/AI news in the past 7 days, expand to 14 days, then fall back to topic-mode-with-prompt rather than invent a story.

## Free vs Pro

**Free (this skill):**
- News-driven draft from WebSearch
- Topic-specified draft
- Pre-publish gate validation
- GitHub commit via `gh api`
- Post-publish verification (15 checks)
- Request Indexing URL list output

**Pro (`ccai-article-pipeline-pro`, planned):**
- Browser automation to click Publish in Lovable
- Auto Request Indexing via Google Search Console API + Bing Webmaster API
- Multi-article batch generation
- A/B test variants of seo_title and meta_description
- Scheduled cron execution (currently you'd use the `schedule` skill manually)
- Performance feedback loop (GSC Search Analytics API → which articles got the most clicks → influence next draft's topic)

## Reference files

- `BRAND_VOICE.md`, voice rules and taboo word list
- `memory/project_article_publish_workflow.md`, canonical frontmatter template + verification curl set
- `memory/project_gsc_indexing_queue.md`, outstanding GSC Request Indexing URLs
- `articles/article-*.md`, existing articles for length + structure + voice reference
- `articles/article-13-fixing-lovable-seo.md`, canonical example with new seo_title pattern

## Sister skills

- `ccai-seo-audit`, diagnostic for the live site. Run periodically to catch regressions.
- `ccai-seo-setup`, the implementation that built the prerender pipeline this skill depends on.
- `ccai-content-ideas`, if you want pure topic brainstorming (no news angle).
- `ccai-brand-voice`, the voice capture skill that produces `BRAND_VOICE.md`.
