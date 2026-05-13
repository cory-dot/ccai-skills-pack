# ccai-lead-finder

> Structured lead qualification + outreach research. You bring the names; the skill turns them into qualified prospects with personalized angles.

**Slash command:** `/ccai-lead-finder`
**Status:** v0.1 · Tier B (free version is manual paste) · works with Claude Code

---

## What it does

The hard part of cold outreach isn't writing the email. It's deciding which 10 of your 50 leads are actually worth reaching out to *this week* — and what to say to each one that isn't generic.

This skill:
1. Builds your `ICP.md` (ideal customer profile) once
2. Takes a batch of leads (CSV, paste, or LinkedIn Sales Navigator export)
3. Scores each 0-100 against your ICP
4. For the 60+ scores, produces a personalized angle, the strongest current signal, "why now," and the recommended channel

You walk away with a sortable table of qualified leads ready for outreach.

---

## Why it's different

1. **Verifiable signals only.** If a signal can't be verified, it's flagged "needs check" rather than fabricated.
2. **Disqualifies leads, not just scores them.** ICP disqualifiers auto-fail high-fit leads from wrong industries.
3. **Calibrated scoring.** If every lead scores 85+, the skill tells you your ICP is too loose.
4. **Doesn't write outreach copy.** That's `ccai-cold-outreach`. This skill is research only — clear boundary.

---

## What you need

- Claude Code installed
- An ICP (or willingness to define one — first run walks you through it)
- A batch of leads to qualify (from anywhere: Sales Navigator, Apollo, manual list, referrals)

No Apify, no Clearbit, no API keys. Pro version adds those.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-lead-finder ~/.claude/skills/ccai-lead-finder
```

---

## Usage

First run:
```
/ccai-lead-finder icp
```

Subsequent batches:
```
/ccai-lead-finder
```

---

## Files

| File | Purpose |
|---|---|
| `SKILL.md` | Instructions |
| `templates/ICP.md` | ICP schema |
| `templates/LEAD_BATCH.md` | Batch output schema |
| `examples/sample-leads-batch.md` | 9-lead worked example with 3 detailed top picks |

---

## Pro version (planned)

`ccai-lead-finder-pro`:
- Apify LinkedIn search scraping
- Clearbit/Apollo enrichment via API
- Real-time signal monitoring
- CRM sync (HubSpot, Salesforce)

---

## License

MIT.
