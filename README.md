# Creative Core AI, Skills Pack

> The complete free + pro skill library for small business owners using Claude Code. 34 skills, dual-distributed: install the whole pack, or grab them ad-hoc one at a time.

**Maintained by:** [Creative Core AI](https://creativecore.ai)
**Course:** [The AI Operator's Playbook](https://skool.com/creative-core-ai) (free)
**Diagnostic call:** [Book here](https://creativecore.ai/book)

---

## Two ways to install

### Option 1, Install the entire pack (recommended for new users)

```bash
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack
cd ~/ccai-skills-pack
./install.sh                  # installs all 34 skills

# Or install specific groups:
./install.sh foundation       # 4 foundation skills only (start here)
./install.sh seo              # SEO audit + setup
./install.sh ccai-brand-voice # just one skill
```

Windows PowerShell:
```powershell
git clone https://github.com/cory-dot/ccai-skills-pack $HOME\ccai-skills-pack
cd $HOME\ccai-skills-pack
.\install.ps1                 # all 34
.\install.ps1 foundation      # foundation set
```

Run `./install.sh --help` (or `.\install.ps1 -Help`) for the full target list.

### Option 2, Install one skill ad-hoc

Each skill also lives in its own standalone repo. Install just what you need:

```bash
git clone https://github.com/cory-dot/ccai-brand-voice ~/.claude/skills/ccai-brand-voice
```

This is the right approach if you only want one or two skills and don't want the whole pack on disk.

Restart Claude Code or run `/doctor` after install to confirm skills loaded.

---

## The 34 skills

### Foundation (start here, 4 skills)

Read/write files that other skills depend on. Always install these first.

| Skill | What it does |
|---|---|
| **[`ccai-brand-voice`](./ccai-brand-voice)** | Captures your authentic voice into `BRAND_VOICE.md`, every other skill reads from it |
| **[`ccai-hook-research`](./ccai-hook-research)** | `HOOK_LIBRARY.md` across 10 proven hook patterns + generate mode |
| **[`ccai-content-ideas`](./ccai-content-ideas)** | `CONTENT_IDEAS.md` radar with status tracking + insights ledger |
| **[`ccai-competitor-research`](./ccai-competitor-research)** | `COMPETITOR_RADAR.md` with 8-dimension profiles + cross-radar synthesis |

### Content production (4 skills)

| Skill | What it does |
|---|---|
| **[`ccai-video-script`](./ccai-video-script)** | Two-column video scripts with 5 de-AI passes |
| **[`ccai-content-repurpose`](./ccai-content-repurpose)** | One source → 6 format-native outputs with de-repetition |
| **[`ccai-sales-copy`](./ccai-sales-copy)** | Direct-response copy with Schwartz awareness diagnosis |
| **[`ccai-carousel-builder`](./ccai-carousel-builder)** | IG + LinkedIn carousels with swipe-friction check |

### Decisions + quality (2 skills)

| Skill | What it does |
|---|---|
| **[`ccai-second-opinion`](./ccai-second-opinion)** | 5-advisor Karpathy LLM Council decision review |
| **[`ccai-reel-scorer`](./ccai-reel-scorer)** | Pre-film script-stage scoring across 10 dimensions |

### Workflow + meta (3 skills)

| Skill | What it does |
|---|---|
| **[`ccai-marketing-prompts`](./ccai-marketing-prompts)** | 35-prompt callable library, voice-adapted |
| **[`ccai-super-employee-prompts`](./ccai-super-employee-prompts)** | 8 delegation patterns + 5-part framework |
| **[`ccai-mother-skill-template`](./ccai-mother-skill-template)** | Chains CCAI skills with approval gates |

### SEO + AEO (2 skills)

| Skill | What it does |
|---|---|
| **[`ccai-seo-audit`](./ccai-seo-audit)** | Full-sitemap SEO + AEO audit, 55+ checks per page, link graph, cannibalization, prioritized fix list |
| **[`ccai-seo-setup`](./ccai-seo-setup)** | Implementation skill, paste-ready prompts for Lovable / Next.js / Vite / Webflow / Wix |

### Operations / Tier B (11 skills)

These reference external services. Free version uses manual paste; pro versions add API integration.

| Skill | What it does |
|---|---|
| **[`ccai-bookkeeping`](./ccai-bookkeeping)** | Monthly P&L + categorized transactions + anomaly detection |
| **[`ccai-lead-finder`](./ccai-lead-finder)** | ICP scoring + personalized outreach angles |
| **[`ccai-cold-outreach`](./ccai-cold-outreach)** | 4-touch personalized outreach sequences |
| **[`ccai-meta-ads-autopilot`](./ccai-meta-ads-autopilot)** | Weekly Meta Ads workflow with 3-3-2-2 creative distribution |
| **[`ccai-meta-ad-creative`](./ccai-meta-ad-creative)** | Quick 5-concept Meta ad creative generator |
| **[`ccai-meta-api-throttle`](./ccai-meta-api-throttle)** | Internal helper for Meta API rate-limit awareness (called by other skills) |
| **[`ccai-ugc-video-ads`](./ccai-ugc-video-ads)** | 5 UGC-style video ad concepts with creator brief + shot list |
| **[`ccai-obsidian-wiki`](./ccai-obsidian-wiki)** | Tiered retrieval for Obsidian vaults (5-10x token savings) |
| **[`ccai-command-center`](./ccai-command-center)** | One-command morning dashboard across all CCAI skill outputs |
| **[`ccai-shopify-ops`](./ccai-shopify-ops)** | 5-mode Shopify ops (audit, descriptions, weekly review, messages, cart) |
| **[`ccai-agent-monitor`](./ccai-agent-monitor)** | Status + costs + drift + failures for your running agents |

### Build / Tier C (8 skills)

| Skill | What it does |
|---|---|
| **[`ccai-website-builder-setup`](./ccai-website-builder-setup)** | Scaffolds Next.js + Tailwind + shadcn/ui project with STYLE_GUIDE.md |
| **[`ccai-landing-page`](./ccai-landing-page)** | 7-panel landing pages into your scaffolded project |
| **[`ccai-ghl-page`](./ccai-ghl-page)** | GoHighLevel-specific funnel builder (paste-ready) |
| **[`ccai-dashboard-builder`](./ccai-dashboard-builder)** | Internal-tool dashboards (KPI views, admin panels) |
| **[`ccai-3d-website`](./ccai-3d-website)** | 3D hero / product viewer / background via Three.js / Spline |
| **[`ccai-video-editor`](./ccai-video-editor)** | Programmatic video editing via Remotion, 5 template types |
| **[`ccai-batch-render`](./ccai-batch-render)** | CSV → many videos (companion to ccai-video-editor) |
| **[`ccai-3d-capture`](./ccai-3d-capture)** | Gaussian Splatting workflow (capture → process → web embed) |

---

## Recommended install order

Don't install all 32 on day one. The order that produces the most value fastest:

1. **`ccai-brand-voice`**, foundation that everything else reads from
2. **`ccai-hook-research`** + **`ccai-content-ideas`**, start the content engine
3. **`ccai-video-script`** + **`ccai-content-repurpose`**, actually produce content
4. **`ccai-second-opinion`**, for real decisions
5. Then add operations + ads + build skills as your business needs them

The installer makes this easy:

```bash
./install.sh foundation     # step 1
./install.sh content        # step 3
./install.sh decisions      # step 4
```

---

## How the skills chain together

The whole pack is designed so skill outputs flow into other skills. The known file paths are the contract:

```
BRAND_VOICE.md          ← ccai-brand-voice
HOOK_LIBRARY.md         ← ccai-hook-research
CONTENT_IDEAS.md        ← ccai-content-ideas
COMPETITOR_RADAR.md     ← ccai-competitor-research

scripts/*               ← ccai-video-script
copy/*                  ← ccai-sales-copy
carousels/*             ← ccai-carousel-builder
repurposed/*            ← ccai-content-repurpose

reel-scores/*           ← ccai-reel-scorer
second-opinion/*        ← ccai-second-opinion

bookkeeping/*           ← ccai-bookkeeping
leads/*                 ← ccai-lead-finder
outreach/*              ← ccai-cold-outreach
meta-ads/*              ← ccai-meta-ads-autopilot, ccai-meta-ad-creative
shopify/*               ← ccai-shopify-ops
command-center/*        ← ccai-command-center
monitor/*               ← ccai-agent-monitor

ghl-pages/*             ← ccai-ghl-page

audits/*                ← ccai-seo-audit
seo-setup/*             ← ccai-seo-setup
```

`ccai-mother-skill-template` lets you chain any of these into a multi-step workflow with approval gates.

---

## Free vs Pro

Every skill has a free version (in this pack) and a planned pro version. Free versions are intentionally complete, no crippled functionality. Pro versions add automation: API integrations, cron scheduling, auto-pull/auto-deploy.

**Free** = you bring the data, the skill structures it
**Pro** = the skill brings the data too

Pro versions ship later as paid skills or as part of the [Production Stack course](https://creativecore.ai) (advanced, coming).

---

## Distribution model

Each skill lives in two places:

1. **Inside this monorepo** at `./ccai-<name>/`, the canonical source for bulk install
2. **In its own repo** at `github.com/cory-dot/ccai-<name>`, for ad-hoc install

They're synced. If you find a bug or have a PR, file it on whichever repo is more convenient, we'll mirror the fix.

For most users: install from this pack with `./install.sh`. For users who want only one or two skills, the individual repos exist for clean targeted clones.

---

## Who built this

[Creative Core AI](https://creativecore.ai), AI marketing operations done-for-you for small businesses. Based in Houston TX. Built by Cory Loflin.

The skills come out of real client work. We use them daily, internally. If a skill doesn't pull its weight, we deprecate it, the pack stays curated.

---

## How to support

- ⭐ Star this repo (or the individual skill repos you find useful)
- 📝 [Join the free Skool community](https://skool.com/creative-core-ai)
- 📞 [Book a free diagnostic](https://creativecore.ai/book) if you want help setting these up

---

## License

All skills: MIT. Use commercially, fork, modify, don't claim you wrote it.
