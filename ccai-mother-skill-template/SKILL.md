---
name: ccai-mother-skill-template
description: Teaches the "mother skill" pattern (one skill that chains multiple sub-skills with approval gates between steps) and provides a working template plus a fully worked example chaining 4 CCAI skills into a content sprint workflow. Use when the user wants to build a workflow that automates a multi-step business process, asks "what's a mother skill," or wants to chain CCAI skills together.
when_to_use: User mentions mother skill, chaining skills, workflow automation, multi-step process, "what if I wanted to do all of these in one command," or asks how to bundle skills.
argument-hint: "[name of the mother skill you want to scaffold — optional]"
---

# CCAI Mother Skill Template

A skill about skills. Teaches the mother-skill pattern and scaffolds new mother skills using existing CCAI skills as building blocks.

## What a mother skill is

A mother skill is a single `.md` file that:
1. Calls other skills in sequence
2. Passes data between them
3. Pauses for user approval at checkpoint gates
4. Produces a single coherent output that would otherwise take 5 separate sessions

Think of it like a project manager that delegates to specialists. Type one command, get a finished workflow.

## When to build a mother skill

Build one when:
- You do the same multi-step process every week (or more)
- The process touches 3+ separate sub-skills
- The steps have a clear sequence (output of step A feeds step B)
- You want at least one human-approval checkpoint mid-flow

Don't build one when:
- The process is one-off
- The steps don't have a clear sequence
- You'd rather just type the 5 commands manually

## The 7-part mother skill anatomy

Every mother skill has these parts. The template in `templates/MOTHER_SKILL.md` enforces this structure.

### 1. Frontmatter (the standard SKILL.md frontmatter, but with `disable-model-invocation: true`)
Mother skills are user-invoked, not Claude-invoked. You don't want Claude deciding to deploy a 5-step workflow on its own.

### 2. The mission (one sentence)
What the mother skill accomplishes end-to-end. Not the steps; the outcome.

Bad: "Runs ccai-content-ideas, then ccai-video-script, then ccai-reel-scorer."
Good: "Produces a publish-ready Reel script with a viral-readiness score, sourced from a brand-voice-calibrated content idea."

### 3. The orchestration plan
A numbered list of steps. Each step:
- Names which sub-skill is invoked
- Names the data being passed in
- Names the data coming out
- Notes if it's an approval gate

### 4. State / data passing
Mother skills pass data between steps using files in the working directory (not in-memory). Each sub-skill writes to a known path; the next step reads from it.

This is why CCAI skills all save to known filenames (`BRAND_VOICE.md`, `HOOK_LIBRARY.md`, etc.) — they're built to be chained.

### 5. Approval gates
Explicit pauses where Claude shows the user what was produced and waits for "approve" / "revise" / "stop."

Approval gates go after any step where: (a) the output is sent to other humans, (b) the next step is hard to reverse, (c) the user would normally double-check.

### 6. Failure handling
What happens if a sub-skill fails or the user says "stop" at a gate? The mother skill should:
- Save the work-in-progress so far
- Name what step it stopped at
- Tell the user how to resume

### 7. Final summary
At the end, the mother skill produces a summary of what it built, where each output lives, and what to do next.

## Process

### Step 1 — Mode selection

Ask the user:
*"Are you (a) learning the pattern by reading the template + example, or (b) building a new mother skill right now? If building, what's the workflow you want to chain?"*

### Step 2a — Learning mode

If learning: walk through `templates/MOTHER_SKILL.md` and `examples/sample-mother-skill.md`. The example chains `ccai-content-ideas` → `ccai-video-script` → `ccai-reel-scorer` → `ccai-content-repurpose` into a "content sprint" mother skill. Have the user read it; answer questions.

End learning mode with: *"When you're ready to build your own, re-invoke me with the workflow you want to chain."*

### Step 2b — Building mode

If building, ask:
1. **Mother skill name** — what to call it (e.g. `content-sprint`, `weekly-marketing-pipeline`)
2. **The mission in one sentence** — what does it accomplish end-to-end?
3. **Which sub-skills are involved** — list 2-6 CCAI skills (or external skills)
4. **The data flow** — what does each step pass to the next? Force the user to specify the file/format.
5. **Approval gates** — between which steps should the workflow pause?
6. **Failure modes** — what would they want to happen if step 3 fails?

### Step 3 — Scaffold the mother skill

Generate:
- A new `SKILL.md` file for their mother skill (using `templates/MOTHER_SKILL.md` as the basis)
- A folder structure: `<name>/SKILL.md`, plus example input/output files showing what data is expected at each step

Save to `~/.claude/skills/<name>/` if the user wants it active, or to the current working directory if they want to inspect it first.

### Step 4 — Walk-through test

Show the user the scaffolded mother skill. Ask them to read it. Then propose: *"Want to run it once now with real data to validate the flow? I'll pause at each approval gate so we can check the handoff."*

### Step 5 — Iterate

Run it. At any failure or weird handoff, pause. Update the mother skill's logic. Try again.

A mother skill that survives 2-3 real runs without modification is ready for production. Most need 1-2 iterations.

## Hard rules

- **Mother skills MUST use `disable-model-invocation: true`.** No exceptions. Auto-invocation of multi-step workflows is dangerous.
- **Every approval gate must be explicit.** "Pause for review" is vague — say what's being reviewed and what the user is approving.
- **Data passing through files, not chat.** Files persist across Claude Code session compaction; chat doesn't.
- **Single mission per mother skill.** If the user wants to chain 4 things AND 3 other things AND deploy, that's three mother skills, not one.
- **Don't auto-deploy without an approval gate.** Even if the user says "deploy automatically," put a gate. The cost of one extra "approve" click is nothing; the cost of one bad auto-deploy is large.

## Reference files

- `templates/MOTHER_SKILL.md` — the reusable mother skill scaffold
- `examples/sample-mother-skill.md` — fully worked content-sprint mother skill (chains 4 CCAI skills)

## Anti-patterns to avoid

- Building a mother skill before the sub-skills are stable. If `ccai-video-script` changes its output format, all mother skills that chain it break. Stabilize the sub-skills first.
- Skipping approval gates because "the user said do it all." Approval gates aren't a usability hurdle; they're the human-in-the-loop check that prevents bad auto-output.
- Mother skills that chain 10 sub-skills. Returns diminish past 5. Past 5, what you have is a script, not a workflow.
- Passing data through in-chat state instead of files. Lost on compaction. Use files.
