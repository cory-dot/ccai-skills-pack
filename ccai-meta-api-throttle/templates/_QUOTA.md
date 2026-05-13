# Meta API Quota, App [app-name]

> Maintained by: ccai-meta-api-throttle
> Ad account: act_[id]
> Last call: YYYY-MM-DD HH:MM:SS UTC
> Current window reset: YYYY-MM-DD HH:MM:SS UTC
> Last rate-limit error: YYYY-MM-DD HH:MM (or "none in last 24h")

## Per-endpoint quota (rolling 1-hour window)

| Endpoint | Calls this hour | Soft cap | Hard cap | % of hard | Status |
|---|---|---|---|---|---|
| /act_X/ads (read) | 0 |, | per-spend tier |, | 🟢 |
| /act_X/ads (write) | 0 | 100 | 200 | 0% | 🟢 |
| /act_X/adsets | 0 | 80 | 150 | 0% | 🟢 |
| /act_X/campaigns | 0 | 50 | 100 | 0% | 🟢 |
| /act_X/insights | 0 | 30 | 60 | 0% | 🟢 |
| /me/business_users | 0 | 100 | 200 | 0% | 🟢 |
| Other | 0 |, |, |, | 🟢 |

**Status legend:**
- 🟢 under 70% of hard cap, PROCEED
- 🟡 70-90%, PROCEED-WITH-WARNING
- 🟠 90-100%, WAIT until window reset
- 🔴 4xx error in last 5 min, BACKOFF (exponential)

## CPU score tracking (Business Use Case rate limits)

| Metric | Value | Threshold |
|---|---|---|
| Latest call_count score | 0 | 100 |
| Latest total_cputime score | 0 | 100 |
| Latest total_time score | 0 | 100 |

(All scores are 0-100; Meta starts throttling at 100.)

## Last 10 calls (rolling)

| Time (UTC) | Endpoint | Method | Status | call_count | cputime |
|---|---|---|---|---|---|
| | | | | | |

## Active recommendations

- (none right now)
- [If quota high, recommended action goes here]

---

*Append-only quota log. Maintained by ccai-meta-api-throttle.*
