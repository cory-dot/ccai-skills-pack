# ccai-agent-monitor

> Status + cost + drift monitoring for your running Claude agents and scheduled skills.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-agent-monitor`
**Status:** v0.1 · Tier B · works with Claude Code

---

## What it does

Once you have 5+ skills running and a couple of scheduled agents, knowing what's working becomes its own problem. This skill is the oversight layer.

4 modes:

1. **Status** (default) — snapshot of every active skill: last run, success/fail, output paths, next scheduled
2. **Costs** — monthly token consumption rollup with outliers flagged (paste in Anthropic console export)
3. **Drift** — compares recent outputs to historical baselines, flags possible quality drift
4. **Failures** — categorizes failed runs in last 7 days with suggested fixes

## Why it's different

1. **Doesn't auto-restart failures.** Surfaces them; you decide.
2. **Drift detection is heuristic, not authoritative.** Flags "possible drift" — you confirm.
3. **Reads CCAI skill outputs directly.** No new logging system to set up.
4. **Privacy-first.** Customer/lead data never appears in summaries unless you approve.

## Install

```bash
git clone https://github.com/cory-dot/ccai-agent-monitor ~/.claude/skills/ccai-agent-monitor
```

## Usage

```
/ccai-agent-monitor [status | costs | drift | failures]
```

## Pro version

`ccai-agent-monitor-pro`:
- Live Anthropic Managed Agents API monitoring
- Real-time cost tracking
- Slack/SMS failure alerts
- Auto-pause skills after N consecutive failures
- Embedding-based output drift detection

## License

MIT.
