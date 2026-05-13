# Per-Page Audit Report, Schema

Used for every `per-page/<slug>.md` file. Keep this format consistent so site-wide REPORT.md can aggregate cleanly.

---

```markdown
# Audit: <Page Title>

**URL:** https://example.com/path
**Audited:** YYYY-MM-DD
**Page type:** homepage | article | product | category | landing | author | other
**Overall page score:** XX / 100
**AEO sub-score:** XX / 100

---

## Scores by category

| Category | Score | Notes |
|---|---|---|
| Crawlability & indexation | X/8 | |
| Core Web Vitals + performance | X/7 | |
| Structured data | X/6 | |
| Open Graph + Twitter | X/5 | |
| AEO / AI search | X/6 | |
| EEAT signals | X/5 | |
| Internationalization | X/5 or N/A | |
| Local SEO | X/5 or N/A | |
| Accessibility-as-SEO | X/4 | |
| Mobile + tap targets | X/3 | |
| Attribution + analytics | X/4 | |

---

## Critical issues (must-fix)

For each:
- **Item:** <checklist item ID, e.g., 1.6 No noindex on important pages>
- **What's wrong:** <plain-English description>
- **Where:** <specific line / element / file reference>
- **How to fix:** <action, paste-ready when possible>
- **Effort:** <small / medium / large>
- **Impact:** <small / medium / large>

---

## High-priority fixes

Same shape as Critical, ranked.

---

## Optimization opportunities

Same shape, but `medium` or `low` severity.

---

## Notable wins

Bulleted list, what this page does well. Short, factual, no flattery.

- ...
- ...

---

## Raw findings

Full pass/warn/fail per checklist item, grouped by category. Useful for handing to a dev.

### 1. Crawlability & indexation
- 1.1 robots.txt valid + accessible, PASS / WARN / FAIL, note
- 1.2 sitemap.xml accessible + referenced, PASS, note
- ...

(repeat for all 11 categories)

---

## Next step

One of:
- "Run `ccai-seo-setup` with this report to generate paste-ready fixes for your stack"
- "Hand this report to your developer, start with critical issues"
- "Re-crawl in 30 days to verify fixes"
```

---

## Notes on writing

- **Be specific.** "Image alt text missing" is useless. "Hero image at line 47 (`/images/hero.jpg`) has no alt attribute" is actionable.
- **Quote the actual HTML** when possible. Readers want to find the thing.
- **No vague severity.** Every issue gets `effort × impact`. The top fixes are obvious from the matrix.
- **No corporate language.** Reports are for operators. Direct, plain English.
- **Wins matter.** Auditors who only list failures get tuned out. List 3-5 things the page does well.
