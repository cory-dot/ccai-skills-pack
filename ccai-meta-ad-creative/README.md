# ccai-meta-ad-creative

> Quick Meta ad creative generator — 5 distinct concepts from a product URL or description. Companion to `ccai-meta-ads-autopilot` (full weekly batch).

**Slash command:** `/ccai-meta-ad-creative`
**Status:** v0.1 · Tier B (free version: image direction only) · works with Claude Code

---

## What it does

5 ad concepts, each using a different psychological pillar (pain mirror / contrarian / social proof / personal cost / curiosity gap), with full Meta-spec output: primary text (90 char max), headline (30 char), description (30 char), image direction, audience targeting, recommended budget.

Plus a launch-order recommendation: which concept to use for cold audience, which for retargeting, which is high-risk/high-reward.

## When to use this vs `ccai-meta-ads-autopilot`

- **This skill:** one-off creative test, new offer launch, quick concept generation
- **`ccai-meta-ads-autopilot`:** weekly creative refresh with full kill/promote/competitor analysis

## Install

```bash
git clone https://github.com/cory-dot/ccai-meta-ad-creative ~/.claude/skills/ccai-meta-ad-creative
```

## Usage

```
/ccai-meta-ad-creative
```

Or *"give me 5 Meta ad concepts for [offer]."*

## Pro version

`ccai-meta-ad-creative-pro` adds auto-image generation via Higgsfield MCP.

## License

MIT.
