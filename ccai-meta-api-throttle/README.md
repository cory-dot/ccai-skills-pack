# ccai-meta-api-throttle

> Internal helper for any skill that calls the Meta Marketing / Graph / Insights API. Prevents rate-limit lockouts without each skill re-implementing the math.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Status:** v0.1 · Tier B helper · `user-invocable: false` (other skills call it)

---

## What it does

Meta's rate limiting is fragmented across 4 different systems (Marketing API limits, Graph API quotas, Insights-specific caps, Business Use Case CPU scores). Every skill that calls Meta has to handle all four, or it gets locked out.

This skill centralizes the logic. Other skills (`ccai-meta-ads-autopilot-pro`, `ccai-meta-ad-creative-pro`, custom integrations) call it before and after Meta API requests:

- **`precheck <endpoint>`** → PROCEED / WAIT(seconds) / BACKOFF / STOP
- **`record-call <endpoint> <status> <cpu>`** → logs call to running quota
- **`batch-plan <endpoint> <items>`** → optimal batch size + wall-time estimate
- **`interpret-error <code> <message>`** → maps error to remediation

State lives in `meta-api/_quota.md`, append-only log per project / per ad account.

## Why this is a separate skill

If you only have one skill calling Meta, you don't strictly need this. But once 3+ skills (autopilot, ad creative, insights pull, anything custom) hit the same API, they share a quota. Each skill rolling its own throttle math = drift + lockouts.

Centralized state = single source of truth.

## Why it's not user-invocable

It's a helper. Users don't type `/ccai-meta-api-throttle`, other skills load it programmatically. The `user-invocable: false` frontmatter hides it from the slash-command menu.

## What you need

- A skill that's calling Meta APIs (otherwise this skill has nothing to do)
- An app ID / ad account ID you're calling against

## Install

```bash
git clone https://github.com/cory-dot/ccai-meta-api-throttle ~/.claude/skills/ccai-meta-api-throttle
```

No usage instructions, other skills handle the integration.

## Files in this repo

| File | Purpose |
|---|---|
| `SKILL.md` | Helper instructions for Claude when called by other skills |
| `templates/_QUOTA.md` | Schema for the per-project quota log |
| `examples/sample-quota-log.md` | Filled example after 2 hours of API activity |

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (32 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-meta-api-throttle ~/.claude/skills/ccai-meta-api-throttle

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

## License

MIT.
