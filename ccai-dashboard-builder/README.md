# ccai-dashboard-builder

> Generates internal-tool dashboards (KPI views, admin panels, ops consoles) into your existing Next.js project. Mock data first, real data second.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-dashboard-builder`
**Status:** v0.1 · Tier C · works with Claude Code

---

## What it does

Generates a complete dashboard page into your `ccai-website-builder-setup` Next.js project:
- Stat cards for top-line numbers
- Data tables for lists (with search + filter)
- Charts for trends
- Mock data baked in so the dashboard renders immediately
- Typed interfaces in `lib/data/` ready for you to wire to real sources

Three layout options:
- **A: Stat cards + table + chart** (most common)
- **B: Sidebar nav + multi-section** (complex dashboards)
- **C: Single-table focus** (when there's one main list)

## Why mock data first

The biggest dashboard-building mistake is wiring data first and looking at design second. The skill generates with mock data so:
1. You see the dashboard render in ~5 minutes
2. You can iterate the layout before sinking 60-90 min into API wiring
3. The wiring step is bounded, you know exactly what data shape each function returns

## Install

```bash
git clone https://github.com/cory-dot/ccai-dashboard-builder ~/.claude/skills/ccai-dashboard-builder
```

## Usage

```
/ccai-dashboard-builder
```

The skill walks you through: purpose → audience → data points → layout → generates.

## Pro version

`ccai-dashboard-builder-pro` adds:
- Live data wiring (Stripe, Supabase, Postgres, Sheets)
- CRUD operations
- Real-time updates via webhooks
- Multi-tenant client-facing dashboards
- RBAC

## License

MIT.
