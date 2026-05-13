---
name: ccai-super-employee-prompts
description: "8 prompt patterns that turn Claude into a delegate-able teammate for recurring business tasks, inbox triage, weekly review, decision log, meeting recap, customer convo synthesis, content batch, vendor scoring, and money-moments digest. Pattern library + teaches the underlying \"delegation prompt\" framework so users can build their own. Use when the user wants to outsource a recurring task to Claude, says they're tired of doing X every week, or asks \"what should I automate first.\""
when_to_use: "User mentions wanting to delegate, automate a task, \"save 10 hours a week,\" \"Claude could handle this,\" recurring chores like inbox/reviews/recaps, or asks for prompt templates for ongoing work."
argument-hint: "[task name or pattern category]"
---

# CCAI Super-Employee Prompts

8 prompt patterns for delegating recurring business tasks to Claude. Free version, runs without external MCPs (you provide the input manually). Pro version (`-pro`) adds cron + MCP auto-execution.

## The "super-employee prompt" framework

Every super-employee prompt has 5 parts. Teach this first, pattern over template.

1. **The job**, one sentence describing the recurring task
2. **The input**, what data the prompt receives each run (file, paste, folder)
3. **The transformation**, what Claude does to the input
4. **The output**, exactly what comes back (format, length, destination)
5. **The voice/tone constraint**, calibrated to BRAND_VOICE.md if present

User-built prompts that miss any of these 5 produce inconsistent output. The skill enforces this template when adapting patterns.

## The 8 patterns

### 1. Inbox triage prompt
Triages a batch of pasted emails into URGENT / NEEDS REPLY / FYI / JUNK with optional draft replies for the top 3. Free version: user pastes the email batch. Pro: Gmail MCP auto-runs hourly.

### 2. Weekly review prompt
End-of-week digest from user-pasted data: what got done, what slipped, what's stuck, what's the top 3 for next week. Reads any `*-week-*.md` files in the directory if present.

### 3. Decision log prompt
User pastes a decision they're making (or about to make). Prompt produces a structured decision record: the question, options considered, what they chose, why, what would make them reconsider. Saves to `decisions/YYYY-MM-DD-slug.md`.

### 4. Meeting recap prompt
User pastes a meeting transcript (from their tool, Otter, Fathom, etc.). Prompt extracts decisions, action items with owners, and open questions. Drafts a Slack-style recap and individual follow-up emails to action-item owners. Tone-matched to BRAND_VOICE.md.

### 5. Customer convo synthesis prompt
User pastes a batch of customer conversations (DMs, support tickets, sales calls, reviews). Prompt extracts: top objections, language patterns, the words customers actually use, themes that recur, top 1-3 product/positioning takeaways.

### 6. Content batch prompt
"It's Friday, make me 5 posts for next week." User provides: topic, week's events/news, what they want to push (offer, launch, etc.). Prompt produces 5 different posts across formats (with mandatory pattern diversity). Reads CONTENT_IDEAS.md if present.

### 7. Vendor/tool scoring prompt
User has 3-5 tools they're evaluating. Prompt produces a structured comparison: features, cost, switching cost, learning curve, who else uses them, and a verdict with the trade-off explicit.

### 8. Money-moments digest prompt
User pastes weekly numbers (revenue, leads, churn, top 3 customer wins, top 3 customer losses). Prompt produces a 5-bullet "what matters most" summary, flags anything >15% movement, and asks one targeted question for next week's review.

## Process

### Step 1, Pick the pattern

Ask: *"Which task do you want to delegate first? Pick one: inbox / weekly review / decision log / meeting recap / customer convo / content batch / vendor scoring / money digest. Or describe your task and I'll match it."*

If their task doesn't fit one of the 8, walk them through building a 9th using the 5-part framework above.

### Step 2, Load the pattern

Read `patterns/<pattern-id>.md`. Each pattern is a full SKILL-md-style spec with the 5 parts filled in.

### Step 3, Adapt to context

For the selected pattern:
- Pull BRAND_VOICE.md taboos + signoff for tone-matched outputs
- Ask the user for the input data (whatever the pattern needs)
- Ask for any pattern-specific configuration (e.g. for inbox triage: which labels they use)

### Step 4, Run it once

Execute the prompt on the provided input. Produce the full output.

After delivering, ask: *"Did the output land? If yes, I'll save the adapted prompt as a reusable file you can run each week. If no, what's off?"*

### Step 5, Save reusable

If the user approves, save the adapted prompt to `super-employee/<pattern-id>-adapted.md`. They can then re-run it next week by pointing Claude at the file and pasting new input.

## Hard rules

- **Show the 5-part framework before the first pattern.** Pattern users without the framework can't build their own.
- **Free version is manual-input only.** If the user wants auto-execution (cron, MCPs), redirect to pro version: `ccai-super-employee-prompts-pro`.
- **Every output is tone-matched if BRAND_VOICE.md exists.** Especially important for the meeting recap and inbox triage patterns, these go to other humans.
- **Don't generate 8 patterns at once.** Surface 1-2 relevant ones based on the user's task. Library is for browsing in pattern docs, not dumping in chat.

## Reference files

- `patterns/_FRAMEWORK.md`, the 5-part super-employee prompt framework
- `patterns/inbox-triage.md`, pattern 1 fully specified
- `patterns/weekly-review.md`, pattern 2
- `patterns/_INDEX.md`, all 8 patterns indexed
- `examples/sample-weekly-review.md`, example output from pattern 2

## Anti-patterns to avoid

- Handing the user a flat list of 8 prompts. They'll save it, never use it. Match-and-adapt is the entire value.
- Skipping the 5-part framework on first invocation. Without it, every pattern looks like a one-off template.
- Implementing pattern 1 (inbox) with auto-execution in the free version. That's the pro path. Free version is manual input.
- Promising "saves 10 hours/week" without telling the user what their actual side of the task is (gathering the input data each run).
