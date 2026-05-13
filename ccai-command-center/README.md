# ccai-command-center

> Your morning standup tool. One command shows everything that matters — inbox, calendar, revenue, content state, open decisions, top 3 actions.

**Slash command:** `/ccai-command-center`
**Status:** v0.1 · Tier B · works with Claude Code

---

## What it does

Most business owners spend the first 30 min of the day scattered across 6 apps trying to remember what mattered yesterday. This skill replaces that.

One command. One dashboard. The state of your business across:
- What's already in your CCAI skill outputs (content radar, leads, outreach, bookkeeping, ads, decisions)
- What you paste in (inbox count, calendar today, fires)
- Top 3 actions for the day

The output is a 1-page dashboard saved to `command-center/YYYY-MM-DD.md` so weekly reviews have the daily snapshots to look back on.

## Why it's different from a generic dashboard tool

1. **Reads your CCAI skill files directly.** No new tool to set up — pulls from `CONTENT_IDEAS.md`, `meta-ads/_log.md`, `bookkeeping/`, etc. that you're already building.
2. **Refuses to fabricate stats.** If a number isn't pulled from real data, it shows `[paste:]` and asks you to fill in.
3. **Max 3 action items.** More than 3 = nothing is a priority.
4. **Surfaces open decisions** from `second-opinion/` files so they don't slip.

## Install

```bash
git clone https://github.com/cory-dot/ccai-command-center ~/.claude/skills/ccai-command-center
```

## Usage

Daily (each morning):
```
/ccai-command-center
```

Weekly (deeper view):
```
/ccai-command-center weekly
```

## Pro version

`ccai-command-center-pro`:
- Live Gmail / Calendar / Stripe / Slack / HubSpot MCP pulls
- Cron schedule (auto-generate 7am weekdays)
- Slack/SMS delivery
- Voice command summary

## License

MIT.
