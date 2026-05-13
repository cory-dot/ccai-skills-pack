---
name: ccai-bookkeeping
description: "Turn messy bank statements, expense receipts, and Stripe exports into a clean BOOKKEEPING_LOG.md with categorized transactions, monthly P&L summary, and red-flag detection. Free version is paste-and-parse from PDFs/CSVs the user provides. Pro version (planned) connects directly to bank APIs (Plaid) and accounting software (QuickBooks/Xero). Use when the user wants to clean up bookkeeping, categorize transactions, prep for taxes, or get a monthly P&L without an accountant."
when_to_use: "User mentions bookkeeping, expense categorization, tax prep, monthly P&L, bank statement reconciliation, expense receipts, transaction categorization, or asks to clean up their financial data."
argument-hint: "[path to statement files, or paste transactions]"
---

# CCAI Bookkeeping

Categorize transactions, produce a monthly P&L, flag anomalies. Free version: you paste/provide the data manually.

## Output contract

Saves to `bookkeeping/` in the working directory:
- `bookkeeping/transactions-YYYY-MM.md`, categorized transaction log for the month
- `bookkeeping/pnl-YYYY-MM.md`, monthly profit & loss summary
- `bookkeeping/_chart-of-accounts.md`, your categories (built on first run, append-only)

## Inputs

User provides any of:
- Pasted bank statement transactions (CSV or text)
- Pasted Stripe payout / transaction CSV exports
- PDF receipts (Claude Code reads them)
- Pasted Venmo/Cash App/PayPal exports

## Process

### Step 1, First-run setup (skip if `_chart-of-accounts.md` exists)
Ask the user for their business structure (sole prop / LLC / S-corp), industry, and primary income/expense categories they want tracked. Build the chart of accounts. Save.

### Step 2, Categorize transactions
For each transaction, classify into one of the user's accounts. Use these rules:
- Vendor name + amount + date → category match
- If ambiguous (e.g., "Amazon", could be office supplies or personal), flag and ask
- Never auto-categorize transactions over $500 without explicit confirmation
- Tag personal/business mixed transactions with `MIXED, needs review`

### Step 3, Produce monthly P&L
- Total revenue (by source)
- Total expenses (by category)
- Net profit/loss
- Cash position (if tracked)
- Top 5 expense categories with % of total

### Step 4, Red flag detection
Flag anomalies:
- Vendor charges that appeared this month but not in any prior month
- Recurring expenses that jumped >20% MoM
- Duplicate charges (same vendor, same amount, within 7 days)
- Categories with zero activity that usually have activity

### Step 5, Output
Save files, summarize: net profit, biggest category surprise, anomalies count, things to review with accountant.

## Hard rules

- **Never claim tax advice.** Categorize transactions only. Tag deductibility questions for the user's accountant.
- **Never auto-finalize over $500 transactions.** Always pause for user confirmation.
- **Personal/business mixing flagged loudly.** A "MIXED" tag must be reviewed before the P&L is final.
- **Read-only on raw inputs.** Never modify the source CSV/PDF, only produce derived files.

## Pro version differences

`ccai-bookkeeping-pro` (planned):
- Plaid integration for live bank data
- QuickBooks/Xero bi-directional sync
- Automated monthly close
- Tax-deductibility flagging with citations

## Reference files
- `templates/TRANSACTIONS.md`, schema
- `templates/PNL.md`, P&L schema
- `examples/sample-monthly-bookkeeping.md`, filled example
