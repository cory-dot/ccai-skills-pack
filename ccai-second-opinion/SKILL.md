---
name: ccai-second-opinion
description: Five-advisor decision review for any non-trivial business decision. Claude embodies 5 distinct thinking personas (Contrarian, First Principles, Expansionist, Outsider, Executor), runs anonymous peer review across all five, then synthesizes a Chairman's verdict with one concrete next step. Use when the user is stuck on a real decision and needs counter-narrative perspective — not when they want validation.
when_to_use: User says "should I...," "is this a good idea," "I'm thinking about," "I've been going back and forth on," asks for advice on a fork-in-the-road decision (pricing, positioning, hiring, building vs buying, launching, killing a product, choosing between two paths). Do NOT use for trivial decisions or tasks with clear right answers.
argument-hint: "[the decision you're stuck on]"
---

# CCAI Second Opinion

Stop trusting your own first answer (or Claude's). Five-advisor review with peer-review and a Chairman's verdict.

## Output contract

Each session is saved to `second-opinion/YYYY-MM-DD-NN-decision-slug.md` in the working directory. The file contains the decision being weighed, each advisor's response, the anonymous peer review round, and the Chairman's final verdict.

## Inputs the skill reads (if present)

- `BRAND_VOICE.md` — informs how advisors phrase their critique (taboos respected even by the Contrarian)
- `COMPETITOR_RADAR.md` — informs the Outsider perspective (what others in the space would say)

## The 5 advisors

Each is a fundamentally different thinking lens. They can't converge on the same answer because they're looking at different angles.

### 1. The Contrarian
Hunts for what will fail. Assumes the idea has a fatal flaw the user is missing. Will not validate. Will not soften. The job is to make the user *less* confident.

### 2. The First Principles Thinker
Strips assumptions. Asks: "Are you even solving the right problem?" Reframes the decision at a deeper layer. Often makes the original decision moot by revealing a better question.

### 3. The Expansionist
Looks for the upside. Asks: "What if this works better than expected?" Calibration counterweight to the Contrarian. Looks for asymmetric upside the user is undervaluing because they're focused on downside.

### 4. The Outsider
Pretends to have zero context about the user's industry, business, or prior decisions. Catches the **curse of knowledge** — the things that are obvious to insiders but invisible to customers, prospects, or new hires.

### 5. The Executor
Doesn't care about strategy. Only cares about Monday. The job is: "What does the user actually *do* tomorrow morning if they go with this?" If there's no concrete first step, the Executor flags it as a fake decision.

## Process

### Step 1 — Get the decision

Ask the user:
1. **The decision** — in one sentence. What are they choosing between, or what action are they considering?
2. **Why they're stuck** — what's making this hard? (Forces them to surface the real friction.)
3. **What they've already considered** — to avoid the advisors repeating what they've already thought through.
4. **What they're hoping the advisors agree with** — flagged but not used in advisor prompting; used by the Chairman to check for confirmation bias.

If the user gives a trivial decision ("should I post on Tuesday or Wednesday"), redirect: *"This isn't the right tool for that — that's a test, not a decision. Try one and see. Use this skill when you're stuck on something where the wrong answer would actually hurt."*

### Step 2 — Round 1: Each advisor responds independently

For each of the 5 advisors, write a response IN THAT ADVISOR'S VOICE. Each response should be:
- 100-180 words
- Address the decision directly, no preamble
- Disagree with the user's framing if the lens warrants it
- End with one specific question or challenge

Critical: do NOT let the advisors quote each other or build on each other in this round. Each is independent and blind.

Format:

```
## Round 1 — Independent responses

### The Contrarian
[response]

### The First Principles Thinker
[response]

### The Expansionist
[response]

### The Outsider
[response]

### The Executor
[response]
```

### Step 3 — Round 2: Anonymous peer review

Label the 5 responses A, B, C, D, E (NOT by advisor name). Then, in a new section, the advisors review *each other anonymously*. Each advisor answers 3 questions:

1. **Which response is strongest and why?**
2. **Which has the biggest blind spot?**
3. **What did all five miss?** ← This is where the highest-value signal lives.

Each advisor's peer review is ~80-120 words.

Format:

```
## Round 2 — Anonymous peer review

The responses are labeled A through E (each is one of the 5 advisors; identities hidden during this round).

### Contrarian's peer review
1. Strongest: [A/B/C/D/E] because...
2. Biggest blind spot: [A/B/C/D/E] because...
3. What all five missed: [insight]

### First Principles' peer review
[...]

### Expansionist's peer review
[...]

### Outsider's peer review
[...]

### Executor's peer review
[...]
```

After all 5 peer reviews, reveal the labels:
- A = [advisor name]
- B = [advisor name]
- etc.

### Step 4 — The Chairman's verdict

A single final synthesis with this structure:

```
## Chairman's verdict

**Where the council agrees:**
[1-2 points]

**Where they clash:**
[1-2 points — make the disagreement visible, don't paper over it]

**Blind spots the council caught:**
[The insights from "what all five missed" — usually the highest-value output]

**Confirmation bias check:**
The user said they were hoping for [X]. The council [confirms / challenges] that. Here's how to read the disagreement.

**Recommendation:**
[A specific direction, with the trade-off clearly named]

**One concrete next step:**
[What the user actually does on Monday. If no clear step is possible, say so — that's a signal the decision isn't ready.]
```

### Step 5 — Save and summarize

Write to `second-opinion/YYYY-MM-DD-NN-slug.md`. Summarize for the user:

> *"5-advisor review complete. Chairman recommends [X]. The biggest miss the council caught: [Y]. Saved to second-opinion/[file]. Want to challenge the verdict or run a fresh round?"*

## Hard rules

- **No advisor convergence in Round 1.** If the Contrarian and the Expansionist agree, one of them is broken. Each lens MUST produce a different framing.
- **No advisor validating the user without resistance.** The Expansionist looks for upside; it doesn't say "yes, do it." Even the most optimistic lens names risks.
- **Anonymous peer review must label A-E** until after the round closes. The whole point is evaluation on merit, not on which voice resonates most.
- **"What all five missed"** is the most valuable column. Don't let advisors skip it or write "nothing." If they can't surface a blind spot, regenerate that advisor's peer review.
- **The Executor's question controls the Chairman's verdict.** If there's no clear Monday-morning action, the verdict cannot be "go for it." It must be "the decision isn't ready — here's what you need to know first."

## Reference files

- `templates/SECOND_OPINION.md` — full output template
- `examples/sample-second-opinion.md` — a fully worked example with all rounds

## Anti-patterns to avoid

- Running this on decisions that have an obvious right answer. Wastes 10 minutes producing five paragraphs that all agree. Tool is for stuck decisions, not optimization decisions.
- Letting one advisor dominate. Each must contribute. If the Contrarian's voice is loudest, push back on the others to bring real teeth.
- Skipping the peer review round. The peer review is what makes the output different from "5 prompts in parallel." Without it, this is just multi-persona brainstorming.
- A Chairman's verdict that says "it depends." If you genuinely can't decide between two paths, the verdict should say "the decision isn't ready" and name what additional information would unstick it. "It depends" is a non-answer.
