# Sample session, ccai-marketing-prompts in action

**User:** I need to write a caption for an Instagram post I'm about to put up. It's a screenshot of a Claude Code conversation I had.

**Skill response:**

That's a content caption, let me pull `caption.short` and adapt it to your BRAND_VOICE.md (which I see is loaded).

**Adapted prompt** (calibrated to Cory @ Creative Core AI):

```
You're a social-media copywriter who writes for small business owners in Houston who use AI for content and operations.

Write 3 caption options for this Instagram feed post. The photo shows: [PHOTO_DESCRIPTION].

Voice + tone rules:
- Direct, not corporate
- No "Hey loves" or "Hey friends" openers
- No "transformative," "powerful," "game-changing"
- No emoji
- Sign-off matches user's normal closing pattern (none, Cory's voice ends on the punchline)

For each caption:
- Option A: under 100 characters (punchy, suitable for hidden by "more")
- Option B: 100-220 characters (one full thought)
- Option C: 220-400 characters (story or framing)

Each caption should:
- Add something the photo doesn't say on its own
- End with a specific CTA or thought-prompt, not "tap in" or "follow for more"
- Use Cory's signature vocabulary: "actually," "here's the thing," "real" (used adjectivally)

Show me all 3. Then tell me your top pick and why.
```

**One missing variable:**
Tell me what the screenshot actually shows, what's the most interesting thing about this specific Claude Code conversation? (Otherwise the captions will be generic.)

---

**User:** It's a screenshot where I asked Claude Code to audit my Skool community structure and it spotted 3 things I missed.

**Skill response:**

Good. Running the prompt now:

---

**Option A (under 100 chars):**
> *Asked Claude to audit my Skool setup. It found 3 things I missed. Worth $20 for that alone.*

**Option B (100-220 chars):**
> *I built my Skool community structure myself, then asked Claude Code to audit it. It found 3 holes in 30 seconds that I'd missed across two weeks of planning. The $20/mo for Pro pays for itself in caught mistakes.*

**Option C (220-400 chars):**
> *I had Claude audit my Skool community structure today. Sent it the channel list, the welcome message, the module order. It flagged three things in under a minute: the welcome message was too long, two channels overlapped, and Module 0 didn't have a clear "what next" cliffhanger. Stuff I'd been staring at for two weeks. The $20 paid itself back in caught mistakes.*

**My pick: Option B.**

Reason: Option A is punchy but doesn't quite earn the $20 claim. Option C is too detailed for a single-image feed caption, works better as a carousel. Option B lands the contrarian frame ("I built it myself, then audited it") and the specific anchor ("3 holes in 30 seconds") in the right length window for a feed photo.

---

**User:** Perfect, using B. What else should I post this week?

**Skill response:**

That's an idea-generation task, which is a different skill. Use `/ccai-content-ideas`, it generates 10 ideas with structure, calibrated to your radar and voice. Want me to invoke it?

---

*This sample shows: prompt selection → voice adaptation → variable collection → run-or-return decision → output → handoff to specialized skill.*
