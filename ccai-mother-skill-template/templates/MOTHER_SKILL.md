---
name: [your-mother-skill-name]
description: [What this mother skill accomplishes end-to-end. Should mention the sub-skills it orchestrates and the final deliverable.]
disable-model-invocation: true
argument-hint: "[input the mother skill takes, e.g. 'topic']"
---

# [Mother Skill Display Name]

## Mission
[One sentence stating what this workflow accomplishes end-to-end.]

## Sub-skills used
- `[sub-skill-1]`, [what it does in this workflow]
- `[sub-skill-2]`, [what it does]
- `[sub-skill-3]`, [what it does]

## State files (data passed between steps)
- `[FILE_NAME.md]`, produced by step [N], consumed by step [N+1]
- `[FILE_NAME.md]`, produced by step [N], consumed by step [N+1]

## Orchestration plan

### Step 1, [Step name]
**Sub-skill invoked:** `[skill-name]`
**Input:** [what data comes in]
**Output:** [what file/data this step produces]
**Approval gate:** [yes/no, if yes, what the user is approving]

### Step 2, [Step name]
**Sub-skill invoked:** `[skill-name]`
**Input:** [from step 1's output: file path or data]
**Output:** [what this step produces]
**Approval gate:** [yes/no]

### Step 3, [Step name]
**Sub-skill invoked:** `[skill-name]`
**Input:**
**Output:**
**Approval gate:**

### Step 4, [Step name]
*(Add as many steps as needed; keep under 6 for sanity)*

### Step N, Final summary
**Sub-skill invoked:** none, Claude assembles the summary
**Input:** outputs from all previous steps
**Output:** a single summary at the end of the conversation listing what was produced + where each file lives + suggested next actions

## Approval gate protocol

When you hit an approval gate, show the user:
1. **What was just produced** (with a path to the file)
2. **What's next** (the next step's plan)
3. **3 options**: ✅ Approve and continue / ✏️ Revise and re-run this step / ⏹️ Stop here

Wait for the user's explicit response. Don't infer.

## Failure handling

If any sub-skill fails or the user stops at a gate:
1. Save all in-progress files (whatever's been produced so far)
2. Tell the user: "Stopped at step [N]. Files produced so far: [list]. To resume, [instruction]."
3. Don't try to "clean up" by deleting partial work. Partial work is often re-usable.

## Resume

To resume after a stop:
1. Read the state files that already exist
2. Identify which step the workflow stopped at
3. Skip completed steps; pick up at the first incomplete step
4. Confirm with the user before resuming: "Looks like we stopped at step [N]. Resume from there?"

---

*Scaffold for [your-mother-skill-name]. Built with ccai-mother-skill-template.*
