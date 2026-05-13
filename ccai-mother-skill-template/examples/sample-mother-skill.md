---
name: content-sprint
description: End-to-end content sprint, generates a content idea, drafts a video script, scores it pre-film, and repurposes the final approved script into LinkedIn, Twitter, email, and carousel formats. One command, one approved deliverable, four repurposed assets.
disable-model-invocation: true
argument-hint: "[topic seed, optional]"
---

# Content Sprint Mother Skill

## Mission
Take a topic seed from the user, generate a content idea calibrated to their brand voice and hook library, draft a video script from that idea, score the script before filming, and (after user approval) repurpose the script into four cross-platform formats, all in one orchestrated session.

End state: one filmable Reel script + 4 platform-ready posts, with the user having approved at 3 checkpoints.

## Sub-skills used
- `ccai-content-ideas`, generates 10 content ideas; user picks one
- `ccai-video-script`, drafts the Reel script for the chosen idea
- `ccai-reel-scorer`, scores the script before user films
- `ccai-content-repurpose`, adapts the approved script into 4 formats

## State files (data passed between steps)
- `CONTENT_IDEAS.md`, generated/updated by step 1; the user picks idea #N
- `scripts/YYYY-MM-DD-NN-slug.md`, produced by step 2 from the chosen idea
- `reel-scores/YYYY-MM-DD-NN-slug.md`, produced by step 3 against the script
- `repurposed/YYYY-MM-DD-source-slug/`, final repurposed assets from step 5

## Orchestration plan

### Step 1, Generate content ideas
**Sub-skill invoked:** `ccai-content-ideas`
**Input:** topic seed (from user); reads BRAND_VOICE.md, HOOK_LIBRARY.md
**Output:** 10 fresh ideas appended to `CONTENT_IDEAS.md` under today's batch
**Approval gate:** yes, user picks which idea to develop (one of the 10)

### Step 2, Draft the script
**Sub-skill invoked:** `ccai-video-script`
**Input:** chosen idea (referenced as "today's batch #N" in CONTENT_IDEAS.md)
**Output:** full script saved to `scripts/YYYY-MM-DD-NN-slug.md`
**Approval gate:** no, user reviews after scoring (step 3)

### Step 3, Score the script
**Sub-skill invoked:** `ccai-reel-scorer`
**Input:** the script file from step 2
**Output:** scoring report at `reel-scores/YYYY-MM-DD-NN-slug.md`
**Approval gate:** yes, if score < 70, user decides: revise (loop back to step 2 with feedback) / keep as-is / kill

### Step 4, Loop back (conditional)
If user chose "revise" in step 3:
1. Pass the top-3 revisions from the score report back to `ccai-video-script` as input
2. Re-draft the script (overwrites scripts/YYYY-MM-DD-NN-slug.md, keeps old version as `-v1.md`)
3. Re-score (step 3 again)
4. Loop until user approves or kills

Max 3 revision loops. After 3, suggest: "This concept may not be the right one. Want to go back to step 1 and pick a different idea?"

### Step 5, Repurpose
**Sub-skill invoked:** `ccai-content-repurpose`
**Input:** the approved script file
**Output:** `repurposed/YYYY-MM-DD-source-slug/` folder with `linkedin.md`, `twitter-thread.md`, `email.md`, `carousel.md`
**Approval gate:** yes, user reviews the 4 repurposed assets and approves or asks for tightening

### Step 6, Final summary
**Sub-skill invoked:** none, Claude assembles the summary
**Output:**

```markdown
# Content Sprint Complete, YYYY-MM-DD

## What you have:
- 1 publish-ready Reel script: scripts/[file] (scored [N]/100)
- 4 repurposed assets:
  - LinkedIn: repurposed/[folder]/linkedin.md
  - Twitter thread: repurposed/[folder]/twitter-thread.md
  - Email: repurposed/[folder]/email.md
  - Carousel: repurposed/[folder]/carousel.md

## Recommended posting cadence:
- Mon: LinkedIn
- Tue: Reel (film + post)
- Wed: Email
- Thu: Twitter thread
- Fri: Carousel

## Updated state:
- CONTENT_IDEAS.md updated with idea #[N] status: posted
- Score history: reel-scores/[file]

## Next actions:
1. Film the Reel using the two-column script
2. Open the LinkedIn file Monday morning
3. Update idea #[N]'s result column after each post performs
```

## Approval gate protocol

When you hit an approval gate, show the user:
1. **What was just produced** (with a file path)
2. **What's next**
3. **3 options**: ✅ Approve and continue / ✏️ Revise and re-run this step / ⏹️ Stop here

For step 3 specifically (score gate), show the score and top 3 revisions. Don't proceed past 70/100 without explicit approval to "ship despite score."

## Failure handling

If `ccai-video-script` fails or produces unusable output:
- Save the original idea reference (from step 1)
- Tell user: "Step 2 failed. Idea #N is still in CONTENT_IDEAS.md if you want to retry or pick differently."

If `ccai-reel-scorer` flags below 30/100 (kill verdict):
- Show the report to the user
- Suggest: "Score is below 30. The concept likely needs a different angle. Want to go back to step 1, or just kill and call it a day?"

If user stops at any gate:
- Update `CONTENT_IDEAS.md` with the idea's new status (drafting / scored / abandoned)
- Tell the user where the work-in-progress lives

## Resume

To resume after a stop:
1. Check if `scripts/YYYY-MM-DD-NN-slug.md` exists → if yes, step 2 is done
2. Check if `reel-scores/YYYY-MM-DD-NN-slug.md` exists → if yes, step 3 is done
3. Check if `repurposed/YYYY-MM-DD-source-slug/` exists → if yes, step 5 is done
4. Resume at the first incomplete step
5. Confirm with the user: "Looks like we stopped after step [N]. Resume?"

---

*Sample mother skill. Chains: ccai-content-ideas → ccai-video-script → ccai-reel-scorer → ccai-content-repurpose. Built with ccai-mother-skill-template.*
