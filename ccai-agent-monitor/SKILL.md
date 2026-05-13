---
name: ccai-agent-monitor
description: "Monitors and audits the status of your running Claude agents and scheduled skills, surfaces failures, surfaces costs, identifies drift in skill output quality over time. Free version reads log files the agents write. Pro version adds live API monitoring of Anthropic Managed Agents + cost dashboards. Use when the user has multiple agents/skills running and wants visibility into what's working vs failing."
when_to_use: "User mentions agent monitoring, scheduled tasks, \"is my automation working,\" skill failures, \"what did my agents do this week,\" cost tracking, agent debugging, or has built mother skills and wants oversight."
argument-hint: "[status | costs | drift | failures]"
---

# CCAI Agent Monitor

Status + cost + drift monitoring for your running agents and scheduled skills.

## Output contract

Saves to `monitor/` in the working directory:
- `monitor/status-YYYY-MM-DD.md`, current snapshot
- `monitor/costs-YYYY-MM.md`, monthly cost rollup
- `monitor/drift-log.md`, append-only quality observations
- `monitor/incidents/YYYY-MM-DD-NN.md`, per-incident reports

## The 4 monitor modes

### Status mode (default)
Snapshot of every active agent / scheduled skill:
- Skill name
- Last run timestamp
- Status (success / fail / running / paused)
- Last 3 outputs (file paths)
- Next scheduled run (if cron'd)

### Costs mode
Monthly rollup of:
- Claude API token usage (if user provides Anthropic console export)
- Per-skill token consumption
- Estimated $ cost by skill
- Outliers (skills consuming >2× monthly average)

### Drift mode
Compares recent outputs of a skill to historical baselines:
- Has output length drifted up/down?
- Has output structure changed?
- Has the user marked recent outputs as worse than older ones?
- Are voice taboos being violated more frequently?

If drift detected, flag for review + suggest specific re-anchor steps.

### Failures mode
Lists every failed run in the rolling 7 days:
- What skill failed
- Error message / failure cause
- Suggested fix
- Whether the failure is recoverable or requires intervention

## Inputs

Free version reads:
- All `_log.md` files in CCAI skill output directories
- Each skill's most recent output files (for drift comparison)
- Pasted error logs (if user has them from their cron/scheduler)
- Optional: pasted Anthropic console export for cost data

Pro version pulls live from:
- Anthropic Managed Agents API
- Anthropic Console cost endpoint
- User's local cron logs

## Process

### Status mode walkthrough
1. Scan working directory for known CCAI skill output dirs
2. For each: find most-recent file, parse timestamp + status (from frontmatter)
3. Cross-reference scheduled-task files if `~/.claude/scheduled-tasks/` exists
4. Output the snapshot table
5. Flag any skill that hasn't produced output in 2× its expected cadence

### Costs mode walkthrough
1. Ask user for Anthropic console CSV export (free version doesn't auto-pull)
2. Group by date + skill (if metadata available)
3. Sum monthly + flag outliers
4. Suggest 1-2 cost-saving actions if monthly spend > $X

### Drift mode walkthrough
1. Ask user which skill to audit
2. Pull last 10 outputs of that skill
3. Compare: avg length, structural similarity, taboo violation count
4. Surface trends + suggest re-anchoring (e.g., re-run `ccai-brand-voice` if voice drift detected)

### Failures mode walkthrough
1. Look for `error.log`, failure files, or skill outputs that contain error markers
2. Categorize failures (config error / API error / data missing / user input issue)
3. Produce remediation list

## Hard rules

- **Never auto-restart failed agents.** Surface failures; let user decide.
- **Never claim cost data is live without proof.** Free version is paste-and-display only.
- **Drift detection is heuristic, not definitive.** "Possible drift detected", not "drift detected." Flag for human review.
- **Privacy first.** Logs may contain customer data; never include identifying info in summaries unless user explicitly approves.

## Pro version differences

`ccai-agent-monitor-pro` (planned):
- Live Anthropic Managed Agents API integration
- Real-time cost tracking
- Slack/SMS alerts on failures
- Auto-pause skills after N consecutive failures
- Drift detection via embedding-based output comparison

## Reference files
- `templates/MONITOR_STATUS.md`, schema for status snapshot
- `examples/sample-status-snapshot.md`, filled example with 6 running skills
