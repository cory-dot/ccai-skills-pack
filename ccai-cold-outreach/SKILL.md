---
name: ccai-cold-outreach
description: Writes cold outreach sequences — LinkedIn DMs, cold emails, follow-up cadences — calibrated to BRAND_VOICE.md and the specific lead's signals from LEAD_BATCH.md. Free version produces send-ready copy (you send manually). Pro version adds Gmail/LinkedIn API automation. Use when the user has a qualified lead list and needs personalized outreach drafted, or wants a follow-up sequence for existing prospects.
when_to_use: User mentions cold email, cold DM, outreach sequence, follow-up, prospecting copy, sales sequence, or asks to write outreach to a specific lead or batch.
argument-hint: "[batch file path, or paste leads + angles]"
---

# CCAI Cold Outreach

Writes personalized cold outreach + follow-up sequences. Free version: you send manually.

## Output contract

Saves to `outreach/` in the working directory:
- `outreach/sequence-YYYY-MM-DD-batch-NN.md` — full sequence for a batch
- `outreach/_log.md` — running log with reply rates

## Inputs

Either:
- A `leads/leads-batch-YYYY-MM-DD.md` file from `ccai-lead-finder` (preferred — has angles already)
- A pasted list with names, companies, and one signal per lead

Reads:
- `BRAND_VOICE.md` for voice (non-negotiable)
- `ICP.md` for context on what you offer
- Past `outreach/_log.md` for reply-rate patterns

## Sequence structure

Each sequence is 4 touches over 14 days:

1. **Day 0 — Touch 1: The angle**
   Personalized opener using the lead's signal. Ends with one specific question (not a CTA).
2. **Day 4 — Touch 2: The reframe**
   If no reply: reframe with a different angle from the same signal. Or share a relevant resource.
3. **Day 9 — Touch 3: The breakup**
   "I'll stop here unless you say keep going" — sometimes pulls a reply.
4. **Day 14 — Touch 4 (optional): Long-tail**
   Only if there's been any engagement signal (opened, profile-viewed). Skip otherwise.

## Hard rules

- **One ask per email.** Never combine "let's chat" + "subscribe to my newsletter" + "follow me on LinkedIn."
- **Signal-grounded, not flattery.** Every touch must reference the specific signal. "I noticed you posted about X" → not "I love what you're doing."
- **No "Hope this finds you well."** Banned. Open with the angle.
- **No "circling back" language.** Skip the cliches.
- **Subject lines 6-9 words.** Curiosity gap or specific-detail.
- **Respect channel norms.** LinkedIn DMs shorter than emails. No long emails on LinkedIn.

## Pro version differences

`ccai-cold-outreach-pro` (planned):
- Auto-send via Gmail / LinkedIn DMs (with confirmation)
- Reply detection and sequence pausing
- A/B testing across batches
- Open-rate tracking
- Auto-warmup integration

## Reference files
- `templates/SEQUENCE.md` — 4-touch schema
- `examples/sample-sequence.md` — filled example with all 4 touches
