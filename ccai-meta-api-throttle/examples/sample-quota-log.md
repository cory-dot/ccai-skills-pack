# Meta API Quota — App "ccai-meta-pro"

> Maintained by: ccai-meta-api-throttle
> Ad account: act_8472615980341
> Last call: 2026-05-12 09:47:22 UTC
> Current window reset: 2026-05-12 10:00:00 UTC (13 minutes)
> Last rate-limit error: 2026-05-12 09:31 (Recovered after 47s backoff)

## Per-endpoint quota (rolling 1-hour window)

| Endpoint | Calls this hour | Soft cap | Hard cap | % of hard | Status |
|---|---|---|---|---|---|
| /act_X/ads (read) | 124 | — | per-spend tier | — | 🟢 |
| /act_X/ads (write) | 18 | 100 | 200 | 9% | 🟢 |
| /act_X/adsets | 11 | 80 | 150 | 7% | 🟢 |
| /act_X/campaigns | 4 | 50 | 100 | 4% | 🟢 |
| /act_X/insights | 28 | 30 | 60 | 47% | 🟡 |
| /me/business_users | 1 | 100 | 200 | 0.5% | 🟢 |
| Other | 6 | — | — | — | 🟢 |

**Total this hour:** 192 calls

## CPU score tracking (Business Use Case rate limits)

| Metric | Value | Threshold |
|---|---|---|
| Latest call_count score | 38 | 100 |
| Latest total_cputime score | 22 | 100 |
| Latest total_time score | 19 | 100 |

All scores well under threshold — no throttling expected.

## Last 10 calls (rolling)

| Time (UTC) | Endpoint | Method | Status | call_count | cputime |
|---|---|---|---|---|---|
| 09:47:22 | /act_X/ads/{id}/insights | GET | 200 | 38 | 22 |
| 09:46:54 | /act_X/ads/{id}/insights | GET | 200 | 37 | 22 |
| 09:46:31 | /act_X/ads/{id}/insights | GET | 200 | 36 | 21 |
| 09:46:12 | /act_X/ads | POST | 200 | 35 | 21 |
| 09:45:48 | /act_X/ads | POST | 200 | 34 | 20 |
| 09:45:14 | /act_X/ads | POST | 200 | 33 | 20 |
| 09:42:33 | /act_X/insights | GET | 200 | 28 | 18 |
| 09:42:01 | /act_X/insights | GET | 200 | 27 | 18 |
| 09:31:47 | /act_X/insights | GET | **429** | — | — |
| 09:31:46 | /act_X/insights | GET | 200 | 100 | 87 |

## Active recommendations

- 🟡 **Insights endpoint at 47% of cap.** If batch ad-by-ad pulls planned, batch into 5 calls instead of 10+. Consider switching to async insights for any pull over 30 ads.
- 9:31 rate-limit hit was recovered cleanly via 47-second backoff. No further action needed.

---

*Append-only quota log. Maintained by ccai-meta-api-throttle.*
