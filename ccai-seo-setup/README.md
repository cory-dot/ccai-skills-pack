# ccai-seo-setup

> Implementation skill for SEO + AEO. Generates paste-ready prompts targeted at your stack, Lovable, Next.js, Vite + React, Webflow, or Wix. Companion to ccai-seo-audit.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 34-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-seo-setup`
**Status:** v0.1 · Foundation tier · works with Claude Code

---

## What it does

Reads either an audit REPORT.md (from `ccai-seo-audit`) or a fresh-site intent, and outputs a folder of paste-ready prompts, one per checklist item, targeted at your stack.

For Lovable users: paste each prompt into your project chat. For Next.js / Vite users: paste into Cursor or hand to your dev. For Webflow / Wix users: step-by-step UI clicks + custom code snippets.

## What makes this different

Most "SEO checklists" online are either generic ("add a sitemap!") or tool-specific (just for Yoast). This skill:
- Speaks your stack's language. Lovable prompts ≠ Next.js diffs ≠ Webflow steps.
- Pulls from a canonical 55+ item checklist (same source as `ccai-seo-audit`)
- Pre-fills every prompt with your actual domain, author, brand info
- Orders fixes by dependency (author page before Article schema, etc.)
- Pairs with the audit skill: audit finds problems → setup writes the prompts

## When this is the right tool

- You ran `ccai-seo-audit` and want paste-ready fixes
- You're setting up a brand-new site
- You're working with Lovable / Cursor / Webflow / Wix and want stack-native instructions
- You're handing the work to a developer and want a clear punch list

## When this is NOT the right tool

- You only want a diagnosis → use `ccai-seo-audit`
- You want backlinks or off-site SEO → out of scope
- You want auto-execution → wait for pro version (or paste-and-go via Lovable)

## Supported stacks

| Stack | Output type |
|---|---|
| Lovable | Per-fix prompts you paste into Lovable chat |
| Next.js (App Router) | File-level diffs + code blocks |
| Vite + React | Build-time scripts + react-helmet-async patterns |
| Webflow | UI clicks + custom code embed snippets |
| Wix | UI clicks + Velo snippets, limits flagged |

## The canonical 55+ item checklist

11 categories, same source of truth as `ccai-seo-audit`:

1. Crawlability & indexation
2. Core Web Vitals + performance
3. Structured data (JSON-LD)
4. Open Graph + Twitter Cards
5. AEO / AI search optimization
6. EEAT signals
7. Internationalization (optional)
8. Local SEO (optional)
9. Accessibility-as-SEO
10. Mobile + tap targets
11. Attribution + analytics + UTM

Full checklist: [`templates/SEO_CHECKLIST.md`](templates/SEO_CHECKLIST.md)

## Output

Creates `seo-setup/`:

```
seo-setup/
├── SETUP_PLAN.md
├── prompts/
│   ├── 01-<fix>.md
│   ├── 02-<fix>.md
│   └── ...
├── verification-checklist.md
└── README.md
```

## Install

```bash
git clone https://github.com/cory-dot/ccai-seo-setup ~/.claude/skills/ccai-seo-setup
```

## Usage

Audit-driven (preferred):
```
/ccai-seo-setup lovable audits/creativecore-ai-2026-05-12/REPORT.md
```

Fresh-site:
```
/ccai-seo-setup nextjs
```

The skill walks through stack confirmation → context gathering → SETUP_PLAN generation → per-fix prompt generation → verification checklist.

## Example output

See [`examples/sample-setup-run-lovable.md`](examples/sample-setup-run-lovable.md), full walkthrough applying audit findings to a Lovable site.

## Free vs Pro

| | Free | Pro (planned) |
|---|---|---|
| All 5 stack templates | ✓ | ✓ |
| Audit-driven mode | ✓ | ✓ |
| Fresh-site mode | ✓ | ✓ |
| Paste-ready prompts | ✓ | ✓ |
| Direct execution via Lovable MCP |, | ✓ |
| GitHub PR creation (Next.js / Vite) |, | ✓ |
| IndexNow auto-ping on publish |, | ✓ |
| Continuous regression monitoring |, | ✓ |

## Pairs with

- **`ccai-seo-audit`**, diagnostic counterpart. Run audit first; pipe REPORT.md into this skill.
- **`ccai-website-builder-setup`**, if you don't have a site yet, scaffold one first (Next.js + Tailwind + shadcn).
- **`ccai-content-ideas`**, after SEO is set up, populate the content pipeline.

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (34 skills total). Two ways to install:

```bash
# Just this skill
git clone https://github.com/cory-dot/ccai-seo-setup ~/.claude/skills/ccai-seo-setup

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
