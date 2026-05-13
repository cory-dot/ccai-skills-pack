---
id: weekly-review
job: End-of-week digest — what got done, what slipped, what's stuck, what's the top 3 for next week
inputs_needed: [pasted week notes OR weekly-notes/*.md files]
cadence: weekly (Friday afternoon or Sunday evening)
voice_matters: low — output is for the user
---

# Pattern 2 — Weekly Review

## The 5 parts

### Job
Produce a structured weekly review from messy week-notes — separating what got done from what slipped, naming what's stuck, and forcing a top-3 priority list for next week.

### Input
Either:
- **Pasted notes** — the user pastes whatever they have from the week (calendar dumps, task notes, journal entries, Slack messages, anything)
- **File-based** — read all `*.md` files in `weekly-notes/` directory (or whatever directory the user specifies). Sort by date if filenames are dated.

The user can also include short voice memo transcripts, meeting notes, or to-do dumps.

### Transformation
1. Read all input. Extract every distinct item mentioned.
2. Classify each item into one of 4 buckets:
   - **✅ Done** — completed this week
   - **⏸️ Slipped** — planned for this week, didn't happen
   - **🟡 Stuck** — started but blocked or stalled
   - **🔮 New / emergent** — came up this week, not originally planned
3. For Slipped: note the original deadline and why it slipped (if user mentioned)
4. For Stuck: note what's blocking and what'd unstick it
5. Identify the **top 3 priorities for next week** — using these rules:
   - Anything from Slipped that still matters
   - The most-blocking item from Stuck
   - One genuinely new thing that emerged this week and is now urgent
6. Identify **one habit/process observation** — a pattern you noticed across the week's notes

### Output

```markdown
# Week of [date range]

## ✅ Done
- [item with one-line context]
- [item]

## ⏸️ Slipped
- [item] — was due [date], slipped because [reason if known]
- [item]

## 🟡 Stuck
- [item] — blocked on [thing], would unstick if [what]
- [item]

## 🔮 New / emergent
- [item]
- [item]

## 🎯 Top 3 for next week
1. [most important] — because [reason]
2. [next] — because [reason]
3. [next] — because [reason]

## 📊 Process observation
[One pattern noticed across the week's notes — usually meta, e.g. "you started 6 things on Monday and finished 1 by Friday — consider 3-max starts per week"]

---

*Saved to weekly-reviews/YYYY-MM-DD.md*
```

### Voice
Low concern. The output is for the user, not customer-facing. Just direct, concrete, no filler.

---

## How to run this pattern

When the user invokes `/ccai-super-employee-prompts` and picks `weekly-review`:

1. Ask: *"Paste your week's notes, point me to a folder (e.g. `weekly-notes/`), or both."*
2. Optionally ask: *"What was the most frustrating thing about the week? Sometimes the answer reframes the priorities."* (Adds emotional context that surfaces stuck/slipped items.)
3. Run the transformation
4. Show the review
5. Save to `weekly-reviews/YYYY-MM-DD.md`
6. Offer to save the adapted prompt for re-running weekly

---

## Pro version differences

`ccai-super-employee-prompts-pro` adds:
- Cron trigger every Friday 5pm
- Auto-fill input from: Notion task database, calendar events, Stripe revenue summary
- Posts the review to a Slack channel or emails it to the user

Free version is manual. Same logic; you provide the notes.

---

## Common failure modes

- **User gives too little input.** "I had a busy week" → Claude has nothing to work with. Push for *items*: meetings, tasks attempted, decisions made.
- **Top 3 picks all from Slipped.** Sometimes valid, sometimes a sign of priority creep. If 3/3 are slipped items, the skill should flag: "Notice all 3 next-week priorities are slipped items. Is the issue with planning or with execution?"
- **No process observation.** If the skill can't find a pattern across the week's notes, it should say "no clear pattern this week" — not fabricate one. Pattern observation should be earned, not forced.

---

*Pattern definition for ccai-super-employee-prompts.*
