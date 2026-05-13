---
name: ccai-shopify-ops
description: "Shopify store management workflow, product page audits, descriptions calibrated to brand voice, weekly inventory + sales review, customer message templates, and abandoned-cart sequence drafts. Free version is manual (you paste product data + orders). Pro version adds Shopify Storefront API + Admin API integration for live data. Use when the user runs a Shopify store and wants structured AI assistance for ops."
when_to_use: "User mentions Shopify, e-commerce, product descriptions, abandoned cart, customer messages for orders, inventory review, store audit, or asks for ecom help."
argument-hint: "[task: audit | product | weekly-review | message | abandoned-cart]"
---

# CCAI Shopify Ops

Structured workflow for Shopify store owners. 5 task modes.

## Output contract

Saves to `shopify/` in working directory:
- `shopify/product-audits/YYYY-MM-DD-product-slug.md`, per-product audits
- `shopify/weekly-reviews/YYYY-MM-DD.md`, weekly snapshots
- `shopify/messages/<order-id>-<type>.md`, customer messages
- `shopify/abandoned-cart-sequences/<segment>.md`, recovery sequences

## 5 task modes

### Mode 1, Product page audit
User pastes product page content (title, description, bullets, images list). Skill produces:
- Headline strength (0-10), does the title hook?
- Description specificity score
- Bullet point review
- Missing-trust-element flags (no reviews? no spec table? no shipping clarity?)
- Top 3 revisions in priority order

### Mode 2, Product description writer
User provides: product, audience, price, key benefit, 1 proof anchor.
Skill produces: title, description (3 paragraphs), 5 bullet benefits, FAQ section (5 Qs), trust elements checklist.
Calibrated to `BRAND_VOICE.md`.

### Mode 3, Weekly store review
User pastes (or skill reads from a CSV the user exports):
- Total revenue + AOV
- Top 5 products by units
- Bottom 5 products by views-to-purchase ratio
- Inventory alerts (low/out of stock)

Skill produces: 5-bullet "what mattered this week" + 3 action items.

### Mode 4, Customer message templates
User describes situation (order delayed, refund request, product question). Skill drafts on-brand response, never apologetic-defaulty, never over-promising.

### Mode 5, Abandoned cart sequence
User describes cart segment + product. Skill produces 3-email sequence (Hour 1, Hour 24, Day 3) calibrated to voice.

## Hard rules

- **Never fabricate product specs.** If user hasn't provided dimensions/materials/etc., flag rather than invent.
- **Customer messages: no over-apologies.** "We're so sorry for any inconvenience" is verboten. Direct + accountable beats grovelly.
- **No fake urgency in abandoned cart.** "Your cart will expire", only if true.
- **Respect BRAND_VOICE.md taboos.**

## Pro version differences

`ccai-shopify-ops-pro` (planned):
- Shopify Admin + Storefront API integration
- Auto-pull product data, orders, customers
- Bulk product description updates
- Live abandoned-cart trigger via webhook
- Slack alerts for low stock / negative reviews

## Reference files
- `templates/PRODUCT_AUDIT.md`, `templates/PRODUCT_DESC.md`, `templates/WEEKLY_REVIEW.md`, `templates/CUSTOMER_MESSAGE.md`, `templates/ABANDONED_CART.md`
- `examples/sample-product-audit.md`
