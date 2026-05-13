# Pattern Index, ccai-super-employee-prompts

8 patterns for delegating recurring business tasks to Claude.

| # | ID | Job | Input | Cadence | Pro version adds |
|---|---|---|---|---|---|
| 1 | `inbox-triage` | Triage emails into Urgent/NeedsReply/FYI/Junk + draft replies | Pasted email batch | Daily or hourly | Gmail MCP auto-runs hourly |
| 2 | `weekly-review` | End-of-week digest of done/slipped/stuck + top 3 for next week | Pasted notes or `weekly-notes/*.md` | Weekly (Friday/Sunday) | Cron + auto-fill from Stripe/Notion/calendar |
| 3 | `decision-log` | Structure a decision: options, choice, why, what would unstick | Pasted decision context | Per-decision | Notion or Airtable persist |
| 4 | `meeting-recap` | Decisions + action items + open questions from transcript | Pasted meeting transcript | Per-meeting | Auto-run on file drop in `/meetings/` |
| 5 | `customer-convo-synthesis` | Themes + objections + language patterns from convo batch | Pasted DM/ticket/review batch | Weekly or monthly | CRM/Zendesk MCP auto-pull |
| 6 | `content-batch` | 5 posts for next week, across formats | Topic + events brief | Weekly | Auto-schedule via Buffer/Hypefury |
| 7 | `vendor-scoring` | Structured comparison of 3-5 tools/vendors | Tool names + use case | Per-decision | Auto-pull G2/Capterra data |
| 8 | `money-moments-digest` | 5-bullet "what matters most" + 15% movement flags | Pasted weekly metrics | Weekly (Monday) | Stripe + Meta + IG MCPs auto-pull, Twilio SMS delivery |

---

## Cadence recommendations

| Cadence | Patterns | Time per run |
|---|---|---|
| Daily | inbox-triage | 5-10 min |
| Weekly | weekly-review, content-batch, money-moments-digest, customer-convo-synthesis (monthly works too) | 15-30 min |
| Per-event | decision-log, meeting-recap, vendor-scoring | 5-15 min |

---

## Best starting pattern

If you've never delegated a recurring task to Claude before, start with **#2 weekly-review**. Lowest external dependency, highest "I see the value" moment in the first run, and the output is for you (not customer-facing) so voice fit matters less. Build the habit, then add others.

---

## Stub patterns (v0.1 has 2 fully written; remaining 6 are stubbed for v0.2)

In v0.1 of this skill, the following patterns are fully written:
- `inbox-triage.md`
- `weekly-review.md`

The remaining 6 are stubbed in this index but not yet detailed in their own files. v0.2 will fill them in.
