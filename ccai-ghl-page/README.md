# ccai-ghl-page

> GoHighLevel landing page builder, generates paste-ready section-by-section copy + form spec + workflow stub for GHL's drag-and-drop editor.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-ghl-page`
**Status:** v0.1 · Tier C · works with Claude Code

---

## Why this exists separately from `ccai-landing-page`

`ccai-landing-page` generates Next.js / React code. If your funnel lives in GoHighLevel, you can't paste React into GHL's editor.

This skill produces what GHL actually accepts: section copy, image specs, form field lists, and a structural plan mapped to GHL's row/column/block model.

## What it generates

For each funnel page:
- Section-by-section copy with GHL block-type labels (Headline / Text / Button / Form / Video)
- Settings spec (headline tag, alignment, background, padding)
- Form field list with custom-field name suggestions
- Tags + workflow trigger to fire on submit
- Post-submit workflow stub (you build the automation in GHL)

## Supported funnel types

- Lead-gen (2 pages)
- Webinar / appointment (3 pages)
- Product sale (3-4 pages)
- Cold lead nurture (1-page sales letter)

## Install

```bash
git clone https://github.com/cory-dot/ccai-ghl-page ~/.claude/skills/ccai-ghl-page
```

## Usage

```
/ccai-ghl-page
```

The skill walks you through funnel type + brief, generates the section-by-section spec, and saves to `ghl-pages/`.

## Pro version

`ccai-ghl-page-pro` adds:
- GHL API integration (auto-build funnel pages directly)
- Workflow JSON for paste-import
- Custom field auto-creation
- Multi-tenant snapshot for agencies

## License

MIT.
