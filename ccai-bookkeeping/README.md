# ccai-bookkeeping

> Turn messy bank statements, expense receipts, and Stripe exports into a clean monthly P&L with categorized transactions and red-flag detection. Free version: manual paste/upload. Pro version: bank API integration.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-bookkeeping`
**Status:** v0.1 · Tier B (no API needed in free version) · works with Claude Code

---

## What it does

For most small business owners, "do the bookkeeping" sits at the bottom of every week's list. By the time you do it (usually right before tax season), six months of receipts and statements are a disaster.

This skill turns 30+ minutes of monthly categorization into ~10 minutes of paste-and-review.

Inputs: PDF statements, CSV exports, receipt photos. Outputs: categorized transactions, monthly P&L vs. prior month, anomaly detection (first-time vendors, MoM jumps, duplicates), and a list of items to escalate to your accountant.

---

## Why it's different from QuickBooks/Xero

This isn't accounting software. It's a *cleanup layer* between your raw financial data and your accounting software (or your accountant).

You still need an accountant for taxes. This skill makes the data you hand to them clean and structured instead of "here's a folder of PDFs."

Three real differences:
1. **Anomaly detection.** First-time vendors, MoM jumps, duplicates, flagged automatically. Your accountant won't catch these unless you point at them.
2. **Mixed-transaction flagging.** That Amazon order with personal items mixed in? Tagged "MIXED" until you split it.
3. **Doesn't pretend to give tax advice.** Categories only. Deductibility questions go to your accountant.

---

## What you need

- Claude Code installed
- Bank statements (PDFs work)
- Stripe / payment processor exports (CSVs ideal)
- Photos of physical receipts (Claude reads images)
- An honest answer about whether you commingle personal/business (most do, that's fine, the skill handles it)

No Plaid, no API keys, no accounting software needed. Pro version adds those.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-bookkeeping ~/.claude/skills/ccai-bookkeeping
```

---

## Usage

```
/ccai-bookkeeping
```

The skill will:
1. (First run) ask about business structure, build chart of accounts
2. Take pasted/uploaded financial data
3. Categorize transactions, flagging ambiguous ones
4. Pause for confirmation on any $500+ items
5. Produce monthly P&L vs. prior month
6. Surface anomalies
7. Save to `bookkeeping/transactions-YYYY-MM.md` + `pnl-YYYY-MM.md`

---

## Files in this repo

| File | Purpose |
|---|---|
| `SKILL.md` | Instructions |
| `templates/TRANSACTIONS.md` | Transaction log schema |
| `templates/PNL.md` | P&L schema |
| `examples/sample-monthly-bookkeeping.md` | Filled May 2026 example |
| `LICENSE` | MIT |

---

## Pro version (planned)

`ccai-bookkeeping-pro`:
- Plaid for live bank pulls (no more paste/upload)
- QuickBooks / Xero bi-directional sync
- Tax-deductibility flagging with IRS citations (still not tax advice)
- Automated monthly close + accountant-ready handoff

---

## License

MIT. Not tax advice.
