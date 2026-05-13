# ccai-super-employee-prompts

> 8 prompt patterns for delegating recurring business tasks to Claude. Free version, manual input, no MCPs required.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-super-employee-prompts`
**Status:** v0.1 · works with Claude Code

---

## What it does

Most business owners do the same 5-10 tasks every week: triage inbox, write a recap, plan content, review numbers, make a decision. Each one is 20-60 minutes. By Friday, you've spent 8 hours on recurring tasks that don't compound.

This skill turns those recurring tasks into delegate-able prompts Claude runs for you. Free version: you provide the input manually (paste, file drop). Pro version: cron + MCPs auto-run them.

It also teaches the underlying **5-part framework** for building your own super-employee prompts, because the included 8 patterns won't cover everything you do, and you'll want to build pattern 9, 10, 11... yourself.

---

## The 8 patterns

| # | Pattern | What it does | Cadence |
|---|---|---|---|
| 1 | `inbox-triage` | Triages emails into Urgent/NeedsReply/FYI/Junk, drafts top 3 replies | Daily/hourly |
| 2 | `weekly-review` | End-of-week digest: done/slipped/stuck + top 3 for next week | Weekly |
| 3 | `decision-log` | Structures a decision: options, choice, why, what would unstick | Per-decision |
| 4 | `meeting-recap` | Decisions + action items + open questions from transcript | Per-meeting |
| 5 | `customer-convo-synthesis` | Themes + objections + language patterns from convo batch | Weekly/monthly |
| 6 | `content-batch` | 5 posts for next week across formats | Weekly |
| 7 | `vendor-scoring` | Structured comparison of 3-5 tools/vendors | Per-decision |
| 8 | `money-moments-digest` | 5-bullet "what matters most" + 15% movement flags | Weekly |

Patterns 1 (`inbox-triage`) and 2 (`weekly-review`) are fully written in v0.1. Remaining 6 are stubbed in `_INDEX.md` for v0.2 fill-in.

**Start with `weekly-review`**, lowest external dependency, highest visible value, the output is for you (so voice fit matters less while you're learning).

---

## The 5-part framework

Every super-employee prompt has 5 parts. Documented in [`patterns/_FRAMEWORK.md`](patterns/_FRAMEWORK.md):

1. **The job**, one sentence
2. **The input**, what data, what format
3. **The transformation**, exact steps + decision criteria
4. **The output**, exact format, length, sort order
5. **The voice/tone constraint**, usually "match BRAND_VOICE.md"

Skip any part → output gets inconsistent. The skill enforces this when adapting patterns.

---

## Why it's different from "give Claude a task"

1. **Patterns over templates.** Templates are fill-in-the-blank. Patterns teach the underlying logic so you can build your own when the included 8 don't cover your task.
2. **5-part framework is taught explicitly.** Not just "here's a prompt." The skill walks you through *why* each part matters.
3. **Tone-matched output where it matters.** Inbox triage and meeting recaps go to other humans, `BRAND_VOICE.md` calibration is mandatory.
4. **Saves the adapted prompt for re-running.** Every successful pattern run can be saved to `super-employee/<pattern>-adapted.md`, ready to re-run next week with new input.
5. **Free + pro split is honest.** Free version = manual input. Pro version = auto-execution via cron + MCPs. Same logic, different trigger.

---

## What you need

- Claude Code installed
- A recurring task you do every week or month
- **Strongly recommended:** `ccai-brand-voice` already run (matters most for customer-facing patterns like inbox triage and meeting recap)

No API keys. No external services. Manual input + persistent prompts.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-super-employee-prompts ~/.claude/skills/ccai-super-employee-prompts
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-super-employee-prompts
```

Or *"I want to automate my inbox"* / *"give me a weekly review prompt."*

The skill will:
1. Ask which task you want to delegate (or matches from your description)
2. Show the matching pattern with the 5 parts spelled out
3. Adapt to your `BRAND_VOICE.md`
4. Ask for the specific inputs the pattern needs
5. Run the pattern once on your real data
6. Offer to save the adapted prompt so you can re-run weekly

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`patterns/_FRAMEWORK.md`](patterns/_FRAMEWORK.md) | The 5-part super-employee prompt framework |
| [`patterns/_INDEX.md`](patterns/_INDEX.md) | All 8 patterns indexed |
| [`patterns/inbox-triage.md`](patterns/inbox-triage.md) | Pattern 1 fully written |
| [`patterns/weekly-review.md`](patterns/weekly-review.md) | Pattern 2 fully written |
| [`examples/sample-weekly-review.md`](examples/sample-weekly-review.md) | Real-world weekly review output |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Why doesn't the free version auto-run?**
Auto-running needs MCPs (Gmail, Stripe, Meta Ads), those require API keys and account setup. Pro version (`ccai-super-employee-prompts-pro`) adds the auto-run layer once the manual layer is reliable.

**Can I run these in non-Claude-Code (like Claude.ai)?**
Yes, the prompts work in any Claude interface. But Claude Code gives you file persistence (saving adapted prompts, weekly reviews to disk), which is the whole point of making these recurring.

**What about my own custom patterns?**
Use [`patterns/_FRAMEWORK.md`](patterns/_FRAMEWORK.md) to build them. The framework is the same; just add a new file to `patterns/` following the format.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-super-employee-prompts ~/.claude/skills/ccai-super-employee-prompts

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
