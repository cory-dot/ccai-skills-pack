# ccai-shopify-ops

> 5-mode Shopify ops skill, product audits, descriptions, weekly reviews, customer messages, abandoned-cart sequences. Calibrated to brand voice.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-shopify-ops`
**Status:** v0.1 · Tier B (free version: paste-and-run) · works with Claude Code

---

## What it does

Most Shopify owners cycle through the same 5 ops tasks every week. This skill structures all 5:

1. **Product page audit**, score across 6 dimensions, identify missing trust elements, top-3 revisions
2. **Product description writer**, full description + bullets + FAQ + trust checklist, calibrated to your brand voice
3. **Weekly store review**, what mattered this week, 3 action items, anomaly flags
4. **Customer message templates**, on-brand responses (no over-apology, no over-promising)
5. **Abandoned cart sequence**, 3-email recovery cadence (Hour 1, Hour 24, Day 3)

## Install

```bash
git clone https://github.com/cory-dot/ccai-shopify-ops ~/.claude/skills/ccai-shopify-ops
```

## Usage

```
/ccai-shopify-ops [mode]
```

Modes: `audit` / `product` / `weekly-review` / `message` / `abandoned-cart`

## Pro version

`ccai-shopify-ops-pro`:
- Shopify Admin + Storefront API integration
- Auto-pull product data, orders, customers
- Bulk product description updates
- Live abandoned-cart trigger via webhook
- Slack alerts (low stock, negative reviews)

## License

MIT.
