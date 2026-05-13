# ccai-landing-page

> Generates a complete 7-panel landing page (Next.js + Tailwind + Framer Motion) into your `ccai-website-builder-setup` project. Brand-voice calibrated.

**Slash command:** `/ccai-landing-page`
**Status:** v0.1 · Tier C · works with Claude Code

---

## What it does

Most "AI website" tools generate one big HTML file with hardcoded copy. This skill is different: it generates 7 separate, modular React section components in a real Next.js project — using your `BRAND_VOICE.md` and `STYLE_GUIDE.md` so output is on-brand without re-prompting.

The 7-panel structure:
1. **Hero** — headline + subhead + primary CTA
2. **Social proof** — logos + testimonials
3. **Problem agitation** — name the pain
4. **Offer** — what they get, specifics
5. **FAQ** — top 5-7 objections handled
6. **Risk reversal** — guarantee / refund / free trial
7. **Final CTA** — primary action + alternate path

Each section is a React component you own. Mobile-responsive. Framer Motion animations. Form wiring for Formspree / Resend / Cal.com.

## Prerequisites

- `ccai-website-builder-setup` already ran (Next.js project exists)
- `BRAND_VOICE.md` in project root
- `STYLE_GUIDE.md` (auto-created by website-builder-setup)
- An offer specific enough to build a landing page for

## Install

```bash
git clone https://github.com/cory-dot/ccai-landing-page ~/.claude/skills/ccai-landing-page
```

## Usage

```
/ccai-landing-page
```

The skill walks you through the brief, plans all 7 panels, gets your approval, then generates the components and the page route. Verifies `npm run dev` works before declaring done.

## What's NOT in this version (free)

- A/B test variant generation — pro
- Auto image generation (Higgsfield) — pro
- One-click Vercel deploy with conversion tracking — pro

## License

MIT.
