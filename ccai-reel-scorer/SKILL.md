---
name: ccai-reel-scorer
description: Pre-flight checklist for short-form video before you film or post it. Scores a reel/short/TikTok script or concept across 10 viral-predictive dimensions (hook strength, hold-rate risk, payoff clarity, etc.), assigns a 0-100 readiness score, and flags specific revisions before you waste shooting time. Use when the user has drafted a script or has a concept and wants a sanity-check, OR when they're about to film and want a last review.
when_to_use: User has a reel/short/TikTok script and asks "is this any good," "should I shoot this," "what's missing," "before I film this," "score this idea," or asks for pre-flight review.
argument-hint: "[path to script or paste the script directly]"
---

# CCAI Reel Scorer

Pre-flight checklist that catches the dead reels before you film them.

## What this is (and isn't)

This skill **does not** analyze video files, sound, vision, or completed footage. That's perceptual scoring — handled by tools like Higgsfield, and addressed in the pro version (`ccai-reel-scorer-pro` — Higgsfield MCP wrapper).

This skill scores the **script or concept** before filming. The vast majority of bad reels are bad at the script stage, not the editing stage. Catching them here saves hours of unnecessary filming.

## Output contract

Each scoring session writes a report to `reel-scores/YYYY-MM-DD-NN-slug.md` in the working directory. The report includes:
- Overall readiness score (0-100)
- Score breakdown across 10 dimensions
- Specific revisions flagged
- Decision recommendation (ship / revise / kill)

## Inputs the skill reads (if present)

- `BRAND_VOICE.md` — to weight voice/taboo violations heavier
- `HOOK_LIBRARY.md` — to compare hook quality vs the user's known-working patterns
- `CONTENT_IDEAS.md` — if the script came from an idea in the radar, cross-reference the original proof anchor

## The 10 scoring dimensions

Each dimension gets a 0-10 score, contributing to the overall 0-100 readiness.

### 1. Hook strength (0-10)
Does the first line stop the scroll?
- 10 = specific number, contrarian claim, or pattern interrupt in the first 6 words
- 7 = solid pattern from HOOK_PATTERNS, but a touch generic
- 4 = "Hey guys, today I want to talk about..." or anything that sounds like a podcast intro
- 0 = greeting + topic statement

### 2. Hold-rate risk (0-10)
Does the script give them a reason to keep watching past the hook?
- 10 = each beat ends with an implicit cliffhanger; reader cannot predict what's next
- 5 = one strong promise teased early, fulfilled too quickly
- 0 = the hook gives away the whole thing in 5 seconds

### 3. Payoff clarity (0-10)
Does the viewer get what was promised?
- 10 = the hook's promise is delivered with a tangible takeaway
- 5 = the script delivers something, but not quite what the hook promised
- 0 = bait-and-switch — hook implies X, video gives Y

### 4. Specificity (0-10)
Real numbers, names, dates, examples vs. abstract claims?
- 10 = every claim has at least one concrete anchor (number, name, story)
- 5 = mix of concrete and vague
- 0 = entirely abstract ("a lot of people," "many businesses," "tons of value")

### 5. Pacing (0-10)
For target length, is the word count and beat-distribution right?
- 10 = within 5% of target word count; beats evenly distributed
- 5 = okay pacing but one section drags
- 0 = will overshoot length by 30%+ or has a section that takes a third of total runtime

### 6. Visual filmability (0-10)
Is there clear visual direction beyond face-to-camera?
- 10 = B-roll, screenshots, on-screen text overlays specified with timing
- 5 = some visual cues but missing key moments
- 0 = wall of spoken text, no visual direction

### 7. Voice fit (0-10)
Does the script sound like the user (vs. generic AI)?
If BRAND_VOICE.md exists, weight against the calibration corpus. If not, use heuristics: no "let's dive in," no "game-changing," no "in today's video."
- 10 = sounds like the user; respects taboos; uses signature vocabulary
- 5 = mostly aligned but a few generic phrases slipped in
- 0 = could be any AI-generated script; voice taboos violated

### 8. CTA strength (0-10)
Is the last beat a specific action?
- 10 = one action, named and easy
- 5 = action present but generic ("follow for more")
- 0 = no CTA, or two competing CTAs

### 9. Saveability (0-10)
Is there a takeaway worth saving/screenshotting?
- 10 = a quotable line, a checklist, a framework, or a specific number worth bookmarking
- 5 = useful info but not particularly screenshot-worthy
- 0 = nothing the viewer will return to

### 10. Differentiation (0-10)
Could a competitor post this exact script?
- 10 = the script is anchored in the user's specific perspective/story/data — no one else could write it
- 5 = generic enough to be commoditized, with one or two original moves
- 0 = generic content that 50 other creators could (and probably have) posted

## The total readiness score

| Score range | Verdict |
|---|---|
| **85-100** | Ship it. Film and post as drafted. |
| **70-84** | Solid. Revise the 2-3 weakest dimensions, then film. |
| **50-69** | Promising concept, weak execution. Significant rewrite recommended before filming. |
| **30-49** | Structural problems. Either reframe the hook/angle or kill this concept and pick another from CONTENT_IDEAS.md. |
| **0-29** | Don't film. The concept doesn't work as drafted. |

## Process

### Step 1 — Get the input

Ask the user for either:
- A path to a script file (e.g. from `ccai-video-script`'s output: `scripts/YYYY-MM-DD-NN-slug.md`)
- Pasted script text
- A concept they haven't drafted yet — in which case score from the concept description directly (note in output: "scored from concept, not full script — re-score after drafting")

### Step 2 — Score each dimension

For each of the 10 dimensions, write:
- The score (0-10)
- A one-sentence justification with a specific reference (quote a line from the script)
- A specific revision suggestion if score < 8

### Step 3 — Compute the total

Sum the 10 scores. Convert to 0-100. Look up the verdict band.

### Step 4 — Flag the top 3 revisions

Of all the dimension-level revision suggestions, pick the 3 highest-leverage ones. These are the changes that, if made, would move the score the most. Present them in priority order.

### Step 5 — Write the report

Save to `reel-scores/YYYY-MM-DD-NN-slug.md` using `templates/REEL_SCORE.md`. Summarize for the user:

> *"Scored [N]/100 → [verdict]. Top 3 revisions to make: [list]. Want me to do those revisions now via `ccai-video-script`?"*

## Hard rules

- **Score everything, even dimensions you can't evaluate well.** If you can't tell visual filmability because the user pasted just spoken text, score what they gave you and note the missing data.
- **Justify every score with a quote.** No "feels weak" — quote the line that feels weak and say why.
- **The top-3 revisions should be different dimensions.** Don't flag 3 hook revisions when the script also has voice-fit issues. Diversity of revision targets.
- **A 10/10 in any dimension is rare.** If you find yourself giving multiple 10s, downgrade the borderline ones. Calibration matters.
- **Never recommend "ship it" with anything below 70 overall, even if the user is rushed.** The skill exists specifically to prevent that.

## Reference files

- `templates/REEL_SCORE.md` — output report template
- `examples/sample-reel-score.md` — a filled example showing the scoring rigor expected

## Anti-patterns to avoid

- Giving all 10 dimensions the same score (5/10, 6/10, ...). Lazy scoring. Force discrimination.
- Soft-scoring to be "encouraging." The user came here for honest feedback, not a hug.
- Skipping the top-3 revisions step. Without revision priorities, the score is information without action.
- Re-scoring without re-reading. If the user revises and re-runs, actually re-read the new version — don't compare to memory.
