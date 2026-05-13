---
name: ccai-command-center
description: A single Claude Code dashboard that surfaces the most important state across your business — open inbox count, calendar today, last week's revenue, top 3 content ideas, pending decisions, agent status. Pulls from your CCAI skill outputs and (in pro version) from connected MCPs. Use as your morning standup tool — one command shows you what matters today.
when_to_use: User mentions morning routine, daily standup, business dashboard, "what should I focus on today," weekly review (lighter version), or asks for a single summary view of their business state.
argument-hint: "[daily | weekly]"
---

# CCAI Command Center

Your morning standup tool. One command shows everything that matters.

## Output contract

Writes a snapshot to `command-center/YYYY-MM-DD-NN.md` and shows it inline.

## What it pulls (free version)

The free version reads from CCAI skill outputs already in the working directory:
- `CONTENT_IDEAS.md` → today's top 3 drafted/scheduled ideas
- `BRAND_VOICE.md` → exists? (yes/no signal for new project setup)
- `COMPETITOR_RADAR.md` → most recent profile update date
- `meta-ads/_log.md` → last week's spend + best CPA
- `bookkeeping/` → latest P&L month net + flagged items count
- `leads/_log.md` → last batch date + qualified count
- `outreach/_log.md` → pending sequences + reply rates
- `second-opinion/` → unresolved decisions (status not marked complete)

If user pastes input (calendar dump, inbox count), the skill incorporates that too.

## Process

### Step 1 — Mode
Daily (default) or weekly (more detail, week-over-week)?

### Step 2 — Pull state
Scan all known CCAI files. For each, extract the headline number/status.

### Step 3 — Ask for the rest (manually)
Things the free version can't pull automatically:
- "What's on your calendar today?"
- "How many new emails in your inbox?"
- "Any client fires?"

### Step 4 — Surface the dashboard
Output structure:
```
# Command Center — YYYY-MM-DD

## What matters most today
[3-5 bullets — top priorities pulled from the data]

## Quick stats
- [Stat] · [Stat]
- [Stat] · [Stat]

## Open decisions
[Anything from second-opinion/ marked unresolved]

## Action items (Top 3)
1. [Most important thing today]
2.
3.
```

### Step 5 — Save and timestamp
Saved to `command-center/YYYY-MM-DD-NN.md` so weekly review has the daily snapshots to look back on.

## Hard rules

- **Show, don't suggest.** Surface the state. Don't tell the user what to do (unless asked).
- **Never fabricate numbers.** If a stat isn't pulled from real data, mark it `[paste:]` and leave blank.
- **Stay short.** Daily mode is a 1-page dashboard. Anything longer is the weekly version.
- **Action items max 3.** More than 3 = nothing is a priority.

## Pro version differences

`ccai-command-center-pro` (planned):
- Live MCP pulls: Gmail (inbox count), Calendar (today's events), Stripe (yesterday's revenue), Slack (mention count), HubSpot (deal stage changes)
- Cron schedule: auto-generate at 7am every weekday
- Slack/SMS delivery
- Voice command summary ("read me my command center")

## Reference files
- `templates/COMMAND_CENTER.md` — daily/weekly schema
- `examples/sample-daily.md` — a filled daily snapshot
