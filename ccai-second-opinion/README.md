# ccai-second-opinion

> Stop trusting your first answer (or Claude's). Five-advisor decision review with anonymous peer review and a Chairman's verdict.

**Slash command:** `/ccai-second-opinion`
**Status:** v0.1 · works with Claude Code

---

## What it does

Claude is agreeable. If you ask "should I launch this?" it'll find five reasons you should. If you ask "is this a bad idea?" it'll find five reasons it is. That's not advice — that's mirror-polishing.

This skill fixes it by simulating five thinking lenses, each with a different agenda, in a structured 2-round protocol:

**Round 1:** Each advisor responds *independently*, blind to the others, in their own voice:
- **The Contrarian** — hunts fatal flaws
- **The First Principles Thinker** — strips assumptions, reframes the question
- **The Expansionist** — looks for asymmetric upside
- **The Outsider** — zero context, catches curse of knowledge
- **The Executor** — only cares what you do Monday morning

**Round 2:** All 5 responses are anonymized (labeled A-E). Each advisor then peer-reviews the set: which is strongest? which has the biggest blind spot? *What did all five miss?* (← the highest-value question)

**The Chairman:** Synthesizes the rounds — points of agreement, points of clash, blind spots caught, a confirmation-bias check against what the user hoped to hear, and one concrete next step.

---

## Why it's different from "ask Claude for advice"

1. **Multi-persona by design, in one Claude session.** No API keys, no external tools, no parallel LLM calls. Claude inhabits each advisor cleanly because the personas are stipulated, anonymized, and forced to disagree by construction.
2. **The "what did all five miss" question is mandatory.** This is where the surprises live. Most advice tools never ask it. This skill makes it Step 3 of the peer review.
3. **The confirmation-bias check.** Users come in hoping the advisors agree with them. The Chairman's verdict explicitly checks and flags when the council is challenging the user's hope.
4. **Monday-morning action requirement.** The verdict cannot end with "it depends." If there's no concrete next step, the Chairman names what's missing — that's a signal the decision isn't ready, not a non-answer.
5. **Built on Karpathy's LLM Council pattern.** Andrej Karpathy popularized the multi-advisor anonymous-peer-review architecture for LLM decisions. This skill is the persona-based, single-LLM adaptation of that pattern.

---

## What you need

- Claude Code installed
- A real decision you're stuck on (not a task — a fork-in-the-road)
- 10-15 minutes to read the full output carefully
- **Optional:** `BRAND_VOICE.md` and `COMPETITOR_RADAR.md` — informs the Outsider's lens

No API keys, no other LLMs. Single Claude session does the whole protocol.

---

## When to use vs not use

**Use when:**
- You've been going back and forth on a real choice for days
- Pricing, positioning, hiring vs automation, build vs buy, launch vs delay
- Killing or sunsetting a product
- Strategic pivots with sticky consequences

**Don't use when:**
- The decision has an obvious right answer and you're just procrastinating
- It's a test you can just run ("should I post Tuesday or Wednesday" — pick one, see)
- The cost of being wrong is low
- You want validation, not perspective (the Contrarian will frustrate you)

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-second-opinion ~/.claude/skills/ccai-second-opinion
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-second-opinion
```

Or *"council this: [decision]"* / *"give me a second opinion on X."*

The skill will:
1. Get the decision, what's making it hard, what you've already considered, and what you're hoping to hear (used for bias check)
2. Run Round 1 — 5 independent advisor responses
3. Run Round 2 — anonymous peer review (each advisor evaluates the labeled A-E set)
4. Reveal the labels
5. Synthesize the Chairman's verdict with confirmation-bias check + recommendation + Monday-morning step
6. Save to `second-opinion/YYYY-MM-DD-NN-slug.md`

Expect ~10-15 min for the full session. Don't rush — the value is in reading what each advisor says.

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions |
| [`templates/SECOND_OPINION.md`](templates/SECOND_OPINION.md) | Output schema with full 2-round structure |
| [`examples/sample-second-opinion.md`](examples/sample-second-opinion.md) | A fully worked example: launching a Skool community |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**Why personas in one Claude vs actually calling 5 different LLMs?**
The free version uses persona prompting in one Claude session. The pro version (`ccai-second-opinion-pro`) calls actual different models (Claude, GPT, Gemini, etc.) in parallel for genuine model-diversity. The pattern is identical; the diversity source differs. Persona prompting is surprisingly good if the personas are forced to disagree by construction.

**The Contrarian was harsh. Is that intentional?**
Yes. If the Contrarian is gentle, the skill is broken. The other advisors balance the lens; you don't need the Contrarian to also be balanced.

**What if I disagree with the Chairman's verdict?**
Great — re-run with the challenge as the new decision frame. The skill is iterative. Sometimes the second pass surfaces something the first round missed.

**Can I add my own advisor?**
Not in the free version. Pro version supports custom advisor archetypes.

---

## Part of the Creative Core AI skills pack

This is one of ~33 skills in the [Creative Core AI skills pack](https://github.com/cory-dot/ccai-skills-pack). The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).

---

## License

MIT.
