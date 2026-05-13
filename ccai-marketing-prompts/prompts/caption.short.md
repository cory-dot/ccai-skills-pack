---
id: caption.short
title: Instagram feed-photo caption
category: content
inputs_needed: [photo description, target audience, vibe]
reads_voice: yes
deliverable: 3 caption options at different lengths/angles
estimated_time: 90s
---

# Instagram feed-photo caption

## When to use
You have a photo or carousel cover ready and need a caption that doesn't sound like every other Instagram post. Use this for any feed (not story, not reel) where you want a caption that actually adds to the image.

## The prompt

```
You're a social-media copywriter who writes for [TARGET_AUDIENCE] in the [INDUSTRY] space.

Write 3 caption options for this Instagram feed post. The photo shows: [PHOTO_DESCRIPTION].

Voice + tone rules (from BRAND_VOICE.md if available, otherwise:
- Direct, not corporate
- No "Hey loves" or "Hey friends" openers
- No "transformative," "powerful," "game-changing"
- Sign-off matches user's normal closing pattern (if any)

For each caption:
- Option A: under 100 characters (punchy, suitable for hidden by "more")
- Option B: 100-220 characters (one full thought)
- Option C: 220-400 characters (story or framing)

Each caption should:
- Add something the photo doesn't say on its own
- End with a specific CTA or thought-prompt — not "tap in" or "follow for more"
- Use [SIGNATURE_VOCABULARY] naturally if it fits

Show me all 3. Then tell me your top pick and why.
```

## Variables to fill
- `[TARGET_AUDIENCE]` — who's the post for? (e.g. "small business owners in Houston")
- `[INDUSTRY]` — your industry/niche (e.g. "AI marketing operations")
- `[PHOTO_DESCRIPTION]` — describe what the photo shows (e.g. "screenshot of a Claude conversation where I asked for a 50-state audit")
- `[SIGNATURE_VOCABULARY]` — your signature words from BRAND_VOICE.md (auto-filled if present)

## Brand voice adaptation
If BRAND_VOICE.md exists, the skill automatically:
- Inserts the user's signature vocabulary as `[SIGNATURE_VOCABULARY]`
- Adds the user's taboos to the "no [X]" list
- Adjusts cadence guidance to match the voice doc's average sentence length

## Common failure mode
Users give a vague photo description ("a picture of me at my desk"). Claude can't write a useful caption without knowing what makes that photo *post-worthy*. Push the user for: what's interesting/different/timely about this specific photo right now?

## Related prompts
- `caption.story` — when it's a story post, not a feed post
- `caption.video` — when it's a reel
- `headline.batch` — when you need 10 variants for testing, not 3 length-tiered options

## Upgrade path
For carousels (more complex than a single-photo caption), use `/ccai-carousel-builder`.
