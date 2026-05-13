---
name: ccai-meta-api-throttle
description: "Internal helper for any skill that calls the Meta Marketing API. Prevents rate-limit violations by tracking per-app call rate, batching reads, and pacing writes. Used by ccai-meta-ads-autopilot-pro, ccai-meta-ad-creative-pro, and any custom skill that hits the Meta Graph API. Use when you're building Meta API automation and need a single source of truth for rate-limit awareness."
when_to_use: "Another CCAI skill is making Meta API calls. User mentions Meta rate limits, \"(#80004) too many calls,\" API throttling, Graph API quota. Also use proactively when scaffolding any new Meta API integration."
user-invocable: false
---

# CCAI Meta API Throttle

Internal helper skill, not user-invocable. Other skills load this to comply with Meta's rate limits without re-implementing the logic.

## Why this exists separately

Meta's rate limiting is per-app and varies by call type:
- **Marketing API**, call-count limits scaled by ad spend volume; varies by ad-account tier
- **Graph API**, 200 calls/hour/user baseline; reads cheaper than writes; certain edges (ads_insights) have additional caps
- **Ads Insights**, separate rate-limit bucket; async reports for large pulls
- **Business Use Case rate limits**, newer, calculated as CPU/memory/total_cputime usage scores

Each skill rolling its own throttle logic = bugs, drift, lockouts. This skill centralizes it.

## What this skill provides

When another skill calls in (`Skill ccai-meta-api-throttle <op>`), it returns:

1. **Pre-call check**, given an operation (read / write / insights / batch), should you proceed now or wait?
2. **Backoff calculation**, if rate-limited, how long to wait before retry?
3. **Batching guidance**, for read operations, optimal batch size to stay under quotas
4. **Quota tracking**, running tally of calls in current window, written to `meta-api/_quota.md`

## State file

Maintained at `meta-api/_quota.md` in working directory:

```
# Meta API Quota, App [name]
> Last call: YYYY-MM-DD HH:MM
> Window resets: YYYY-MM-DD HH:MM

| Endpoint | Calls this hour | Limit | % used |
|---|---|---|---|
| /act_<id>/ads (read) | 47 | ~unlimited (under spend) |, |
| /act_<id>/ads (write) | 12 | 200/hr soft cap | 6% |
| /act_<id>/insights | 4 | 60/hr | 7% |
| /act_<id>/campaigns | 3 |, |, |

## Last 10 calls
- HH:MM  endpoint  status  cpu_score
- ...
```

## The 4 operations

### `precheck <endpoint>`
Returns: PROCEED / WAIT(seconds) / BACKOFF / STOP-LIMIT-REACHED.

Logic:
- Read quota state from `meta-api/_quota.md`
- Compare current window calls vs known limits for that endpoint
- If under 70% of cap → PROCEED
- If 70-90% → PROCEED-WITH-WARNING (calling skill should log this)
- If 90-100% → WAIT(N seconds until window reset)
- Already returned a 4xx rate-limit error in last 5 min → BACKOFF(exponential)

### `record-call <endpoint> <status> <cpu_score>`
Appends to the quota log. Other skills must call this after every API hit.

### `batch-plan <endpoint> <total-items>`
For read ops over many items (e.g., "fetch insights for 200 ads"), returns optimal batch size and total estimated wall time.

### `interpret-error <error-code> <error-message>`
Maps a Meta API error response to a remediation action. Examples:
- `(#80004) Too many calls` → BACKOFF 5 min, reduce batch size by 50%
- `(#80000) Rate limit reached` → WAIT until window reset
- `(#100) Invalid parameter` → not a rate-limit issue, surface to user

## Hard rules

- **Never make API calls itself.** This skill is read-only against the quota file. The calling skill makes the actual Meta requests.
- **Never auto-bypass limits.** If precheck says WAIT, the calling skill MUST wait. No "I'll just retry once" hacks.
- **Quota log is append-only.** Never delete entries, useful for debugging account-level patterns over weeks.
- **One quota file per ad account.** If the user runs multiple Meta accounts, each project directory has its own quota file.

## Reference files

- `templates/_QUOTA.md`, schema for the quota state file
- `examples/sample-quota-log.md`, filled example after 2 hours of API activity
