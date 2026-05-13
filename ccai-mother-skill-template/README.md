# ccai-mother-skill-template

> A skill about skills. Teaches the mother-skill pattern (one workflow that chains multiple sub-skills with approval gates) and scaffolds new mother skills using existing CCAI skills as building blocks.


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)** — Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-mother-skill-template`
**Status:** v0.1 · works with Claude Code

---

## What it does

The most powerful Claude Code setups don't use one skill at a time — they chain skills together into workflows. Generate a content idea → draft a script → score it → repurpose it: four skills, one command, one cohesive output.

That's a **mother skill**: a single `.md` file that calls other skills in sequence, passes data between them through known-location files, and pauses at approval gates so a human stays in the loop.

This skill:

1. **Teaches the 7-part mother skill anatomy** — what every mother skill must include
2. **Provides a reusable scaffold** — `templates/MOTHER_SKILL.md` is the blank you fill in
3. **Includes a worked example** — `content-sprint` mother skill that chains 4 CCAI skills end-to-end
4. **Walks you through building your own** — interactive scaffolding when you have a workflow in mind

---

## When to build a mother skill

**Yes:**
- You run the same multi-step process every week (or more)
- The process touches 3+ separate sub-skills
- The steps have a clear sequence (output A → input B)
- You want at least one human-approval checkpoint mid-flow

**No:**
- The process is one-off
- Steps don't have a clear order
- You'd rather type 5 commands manually

---

## The 7-part anatomy

Every mother skill includes:

1. **Frontmatter** (with `disable-model-invocation: true` — no auto-running workflows)
2. **Mission** (one sentence: the end-state, not the steps)
3. **Orchestration plan** (numbered steps with sub-skill, input, output, gate flag)
4. **State / data passing** (file-based — survives compaction; chat doesn't)
5. **Approval gates** (explicit pauses with 3 options: approve / revise / stop)
6. **Failure handling** (save work-in-progress, name where it stopped, instruct on resume)
7. **Final summary** (what was built, where each output lives, next actions)

Full detail in [`SKILL.md`](SKILL.md).

---

## Why CCAI skills chain well

Every CCAI skill saves to a known filename in the working directory:
- `BRAND_VOICE.md` (from `ccai-brand-voice`)
- `HOOK_LIBRARY.md` (from `ccai-hook-research`)
- `CONTENT_IDEAS.md` (from `ccai-content-ideas`)
- `COMPETITOR_RADAR.md` (from `ccai-competitor-research`)
- `scripts/*` (from `ccai-video-script`)
- `reel-scores/*` (from `ccai-reel-scorer`)
- `copy/*` (from `ccai-sales-copy`)
- `carousels/*` (from `ccai-carousel-builder`)
- `repurposed/*` (from `ccai-content-repurpose`)
- `second-opinion/*` (from `ccai-second-opinion`)

This was deliberate. Known output locations = chainable skills.

---

## What you need

- Claude Code installed
- 2+ CCAI skills already installed (so you have something to chain)
- A workflow you do repeatedly

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-mother-skill-template ~/.claude/skills/ccai-mother-skill-template
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

```
/ccai-mother-skill-template
```

The skill will ask:
- Are you **learning the pattern** (read template + example), or
- Are you **building one right now** (interactive scaffolding)?

### Learning mode
Walks you through [`templates/MOTHER_SKILL.md`](templates/MOTHER_SKILL.md) and the [`examples/sample-mother-skill.md`](examples/sample-mother-skill.md) content-sprint example.

### Building mode
Asks you for the workflow specifics:
1. Mother skill name
2. Mission (one sentence)
3. Which sub-skills are involved
4. Data flow between steps
5. Where approval gates go
6. Failure modes

Then scaffolds the new mother skill file and walks you through a first test run.

---

## The included example: content-sprint

[`examples/sample-mother-skill.md`](examples/sample-mother-skill.md) chains 4 CCAI skills end-to-end:

```
1. ccai-content-ideas  → generates 10 ideas, user picks one      [APPROVAL]
2. ccai-video-script   → drafts the Reel script
3. ccai-reel-scorer    → scores the script before filming        [APPROVAL]
   ↳ if < 70/100, loop back to step 2 with revisions (max 3 loops)
4. ccai-content-repurpose → adapts approved script to 4 formats  [APPROVAL]
5. Final summary       → file paths + posting cadence
```

End state: one filmable Reel script + 4 cross-platform posts, all approved at 3 checkpoints.

Read it, then build your own version for your workflow.

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | The skill instructions — teaches the 7-part anatomy |
| [`templates/MOTHER_SKILL.md`](templates/MOTHER_SKILL.md) | Blank scaffold for building a mother skill |
| [`examples/sample-mother-skill.md`](examples/sample-mother-skill.md) | Worked example: content-sprint chaining 4 CCAI skills |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**How do I run a mother skill once it's built?**
Save it to `~/.claude/skills/<name>/SKILL.md`. Then type `/<name>` in Claude Code. Because mother skills use `disable-model-invocation: true`, you always invoke them explicitly.

**What if a sub-skill changes its output format?**
Your mother skill breaks. This is why stabilizing the foundation skills first (`ccai-brand-voice`, `ccai-hook-research`, etc.) matters before building mother skills that depend on them.

**Can a mother skill call another mother skill?**
Technically yes, but it's usually a sign your workflow should be one larger mother skill or two separate ones. Nested mother skills are hard to debug.

**Approval gates feel slow. Can I skip them?**
The free version: yes, you can edit the mother skill to remove gates after you trust the flow. The recommended pattern: keep gates for the first 5 runs, then loosen them as you build confidence.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack) — the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-mother-skill-template ~/.claude/skills/ccai-mother-skill-template

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai) — our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
