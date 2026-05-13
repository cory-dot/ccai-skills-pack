---
id: inbox-triage
job: Triage a batch of emails into Urgent / Needs Reply / FYI / Junk, with draft replies for the top 3 priorities
inputs_needed: [email batch (pasted), user's normal email signoff, optional: existing label vocabulary]
cadence: daily or hourly
voice_matters: yes — replies go to customers
---

# Pattern 1 — Inbox Triage

## The 5 parts

### Job
Triage a batch of new emails into 4 priority buckets, then draft replies for the top 3 highest-priority ones — tone-matched to the user's voice.

### Input
The user pastes a batch of emails. Each email separated by `---`. Format per email:
```
FROM: name <email@domain>
SUBJECT: subject line
BODY:
[the email body, can be multi-line]
```

The user provides the batch as part of the same conversation. If the batch is huge (50+ emails), suggest splitting into multiple sessions.

### Transformation
For each email:
1. Classify into one bucket using these rules (in priority order — first match wins):
   - **🔴 URGENT** — sender is a known client/customer AND uses "ASAP" / "today" / "tomorrow" / explicit deadline in next 48h
   - **🟡 NEEDS REPLY** — sender expects a response, no immediate deadline, but ignoring it would cost relationship/revenue
   - **🟢 FYI** — informational; no action expected from user
   - **⚪ JUNK** — newsletters, automated notifications, cold pitches, anything user routinely deletes
2. For URGENT and NEEDS REPLY: extract the actual question being asked
3. Pick the top 3 highest-priority emails (all URGENT first, then NEEDS REPLY by relationship value)
4. Draft a reply for each of the top 3

### Output
A markdown table for ALL emails:

| Bucket | Sender | Subject | Question (if reply needed) |
|---|---|---|---|

Then a section "Drafted replies" with the top 3, each formatted as:

```
TO: sender
SUBJECT: Re: [original]
BODY:
[draft reply, matched to user's voice, ending with their signoff]
```

### Voice
Replies must match `BRAND_VOICE.md` if present. If not, apply these defaults:
- No "Hey!" / "Hi there!" greetings — open with the answer
- No "I hope this email finds you well"
- Max 4 sentences per reply unless the question explicitly requires more
- End with the user's normal signoff (asked at start of run if not in BRAND_VOICE.md)

---

## How to run this pattern

When the user invokes `/ccai-super-employee-prompts` and picks `inbox-triage`:

1. Ask: *"Paste the email batch. Use `---` to separate each email. Or just paste them one at a time."*
2. If `BRAND_VOICE.md` doesn't exist, ask: *"What's your normal email signoff? (e.g. 'Cory' / 'Best, Cory' / 'Talk soon, C')"*
3. Ask: *"Any of your existing Gmail labels you want me to map these into? List them if so, or skip."*
4. Run the transformation
5. Show the user the full triage table + 3 drafted replies
6. Ask: *"Send these as-is, or want me to tighten any of the drafts?"*
7. After approval, offer to save the adapted prompt to `super-employee/inbox-triage-adapted.md` so they can re-run weekly

---

## Pro version differences

`ccai-super-employee-prompts-pro` adds:
- Gmail MCP integration — auto-pulls new emails on cron (hourly)
- Auto-labels emails using their existing Gmail label vocabulary
- Saves drafts to Gmail's Drafts folder (user clicks Send themselves — never auto-sends)
- Slack notification for URGENT emails

The free version is manual paste-and-run. Same prompt logic; different trigger and delivery.

---

## Common failure modes

- **User pastes a 200-email batch.** Output becomes a wall. Suggest 10-30 emails per run.
- **No client/customer context.** Without knowing who's "important," Claude over-classifies as URGENT. Ask the user to flag 3-5 client domains/names that should always trigger Urgent.
- **Voice mismatch on drafts.** If replies sound corporate, the user needs to run `/ccai-brand-voice` first. The triage logic still works; the drafts need the voice doc to land right.

---

*Pattern definition for ccai-super-employee-prompts.*
