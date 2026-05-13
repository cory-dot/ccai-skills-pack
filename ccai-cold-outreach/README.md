# ccai-cold-outreach

> Writes personalized cold outreach sequences, LinkedIn DMs, emails, follow-ups, calibrated to your brand voice and the specific lead's signals.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-cold-outreach`
**Status:** v0.1 · Tier B (free version is paste-and-send) · works with Claude Code

---

## What it does

Most cold outreach fails because it's generic. Either templated ("I hope this email finds you well, I noticed you're a founder...", yeah, of LinkedIn) or unfocused ("here are 8 things I do, want to chat?").

This skill writes 4-touch sequences that are:
- **Grounded in a verified signal** from the specific lead (pulled from `ccai-lead-finder`'s batch file)
- **One ask per email**, no combo-pitching
- **Calibrated to your `BRAND_VOICE.md`** so they sound like you, not like a sales template
- **Channel-appropriate**, LinkedIn DMs are short, emails can be longer, never the other way around

The 4 touches:
1. **Day 0**, the angle (signal-grounded opener, one question)
2. **Day 4**, the reframe (different angle or a resource share, no re-pitch)
3. **Day 9**, the breakup ("I'll stop unless you say to keep going")
4. **Day 14**, optional long-tail (only if engagement signal)

---

## Why it's different from generic cold-email tools

1. **Reads `ccai-lead-finder`'s batch files directly.** The angle is pre-researched. You skip the "what should I say" step entirely.
2. **Refuses to write certain phrases.** No "Hope this finds you well," no "circling back," no "wanted to touch base."
3. **One ask per email, enforced.** The skill won't let you stack "let's chat + subscribe + follow me."
4. **Subject lines 6-9 words.** Hard constraint. Longer subjects get truncated on mobile.
5. **Honest breakup at Touch 3.** Not aggressive, just clear. Often pulls more replies than the first three combined.

---

## What you need

- Claude Code installed
- A qualified lead list (from `ccai-lead-finder` ideally; or pasted with signals)
- `BRAND_VOICE.md` (strongly recommended, generic outreach hurts more than no outreach)

No Gmail API, no LinkedIn API, no warmup tools required. You send manually. Pro version adds auto-send with reply detection.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-cold-outreach ~/.claude/skills/ccai-cold-outreach
```

---

## Usage

```
/ccai-cold-outreach
```

The skill walks you through batch selection or paste input, then generates the full 4-touch sequence per lead.

---

## Files

| File | Purpose |
|---|---|
| `SKILL.md` | Instructions |
| `templates/SEQUENCE.md` | 4-touch schema |
| `examples/sample-sequence.md` | Full worked example with all 4 touches + send checklist |

---

## Pro version (planned)

`ccai-cold-outreach-pro`:
- Gmail / LinkedIn DM auto-send (with per-touch confirmation gate)
- Reply detection, auto-pause sequence on reply
- A/B testing across subject lines
- Open-rate / response-rate tracking
- Auto-warmup integration

---

## License

MIT.
