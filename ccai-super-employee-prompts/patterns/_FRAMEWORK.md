# The 5-Part Super-Employee Prompt Framework

Every recurring task you delegate to Claude needs these 5 parts. Skip one and the output becomes inconsistent. This is the framework `ccai-super-employee-prompts` enforces when adapting patterns, and when teaching you to build your own.

---

## 1. The job

One sentence. What is the recurring task?

Bad: "Help me with my emails."
Good: "Triage new emails into Urgent / Needs Reply / FYI / Junk."

A vague job statement leads to inconsistent output. The clearer the job, the more reliable the prompt over time.

---

## 2. The input

What data does the prompt receive each run? Be specific about format and source.

Bad: "Look at my inbox."
Good: "Read the email batch I'll paste below. Each email is separated by `---`. Subject line first, then body, then sender."

Without a defined input format, Claude has to guess the structure each time. Defining it makes the prompt reusable across runs.

---

## 3. The transformation

What does Claude do to the input? Be explicit about the steps and the decision criteria.

Bad: "Sort them."
Good: "For each email, classify into one of 4 buckets using these rules:
- Urgent = sender is a client + uses 'asap' / 'today' / 'tomorrow' / explicit deadline
- Needs Reply = sender expects a response within 48h
- FYI = informational, no action needed
- Junk = newsletters, automated notifications"

The transformation step is where most super-employee prompts go wrong. Vague transformations produce vague output. Spell out the decision criteria like you're writing instructions for a new hire.

---

## 4. The output

Exactly what comes back. Format, length, structure.

Bad: "Summarize what you found."
Good: "Return a markdown table with columns: Bucket | Sender | Subject | Reply draft (if Urgent). Sort by Bucket priority (Urgent first). Max 1 sentence per Reply draft."

Strict output formats let you (a) trust the result without re-reading every time, and (b) pipe the output into other tools or scripts.

---

## 5. The voice/tone constraint

If outputs go to other humans (replies, recaps, follow-ups), they need to sound like you. This is where `BRAND_VOICE.md` does the heavy lifting.

Bad: "Make it professional."
Good: "Reply drafts must match BRAND_VOICE.md: short sentences (avg 14 words), no 'Hey!' openers, no 'Looking forward to hearing from you' signoffs. End with the user's normal signoff: 'Cory'."

If `BRAND_VOICE.md` doesn't exist, give explicit rules. Voice matters most for tasks that have customer- or team-facing output.

---

## The shape of every super-employee prompt

```
JOB: [one sentence]

INPUT: I'll provide [data type] in [format]. [Pasted below / in /path/ / from MCP].

TRANSFORMATION:
1. [Step]
2. [Step]
3. [Step]
Decision criteria for [classification/judgment]:
- [Rule]
- [Rule]

OUTPUT:
[Exact format spec, markdown? JSON? Plain text? Table? Paragraph?]
[Length cap]
[Sort order]
[Where to save / where to return]

VOICE:
[Constraint, usually "match BRAND_VOICE.md" + any pattern-specific notes]
```

---

## How to build a pattern that isn't in the library

The 8 included patterns cover the most common recurring tasks. If your task isn't one of them:

1. Write out your task as the 5 parts above. Start with **job** in one sentence.
2. If you can't write **transformation** in 3-5 explicit steps, your task is too vague, break it into sub-tasks.
3. If your **output** format isn't defined, the prompt will be inconsistent. Force yourself to specify length, sort order, and structure.
4. Test it once with real data before committing to running it weekly.
5. After 2-3 runs, look at where the output drifted from what you wanted, that's your prompt's weakness. Tighten the transformation step.

A prompt that survives 4 runs without modification is a real super-employee. One that needs tweaking every time is just a template.

---

*Framework reference for ccai-super-employee-prompts. Use this to build patterns 9, 10, 11... once you've outgrown the included 8.*
