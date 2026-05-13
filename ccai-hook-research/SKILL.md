---
name: ccai-hook-research
description: "Builds and grows a structured HOOK_LIBRARY.md of proven content hooks the user has collected, classifying each by pattern, extracting reusable templates, and (in generate mode) producing new hooks for a specific topic in the user's brand voice. Use when the user asks to research hooks, build a hook library, classify hooks they've collected, brainstorm hooks for a piece of content, or fix a script that \"doesn't have a strong opener.\""
when_to_use: "User mentions hooks, openers, video intros, scroll-stoppers, the first three seconds, or asks \"what's a good hook for X.\" Also use proactively when starting any video/reel/short script if a HOOK_LIBRARY.md exists in the working directory."
argument-hint: "[research | generate <topic>]"
---

# CCAI Hook Research

Build and grow a structured library of proven hooks. Generate new hooks from that library calibrated to the user's brand voice.

## Output contract

This skill maintains `HOOK_LIBRARY.md` in the working directory. Other CCAI skills (`ccai-video-script`, `ccai-carousel-builder`, `ccai-content-ideas`) read from this file to pull hook patterns when generating openers.

**Schema is defined in `templates/HOOK_LIBRARY.md`, do not change section headings.**

If `BRAND_VOICE.md` exists in the working directory, read it before generating any new hooks. Match the user's vocabulary, cadence, and taboos.

## Two modes

The skill operates in one of two modes based on how it's invoked or what the user asks for.

### Mode A, Research (add hooks to the library)

Use when the user wants to *classify and save* hooks they've collected.

#### Step 1, Gather input

Ask the user to provide hooks in any of these forms:
- A list of pasted hook lines (1 per line)
- A folder of `.md` or `.txt` files containing hooks
- Screenshots they describe (Claude reads via vision)
- A spreadsheet/CSV with columns

If the user has performance data (views, baseline, engagement rate), ask them to include it, it enables outlier scoring (see Step 3). If they don't have data, that's fine, skip scoring.

#### Step 2, Classify

For each hook, classify into one of the 10 patterns in `templates/HOOK_PATTERNS.md`. If a hook doesn't fit cleanly, mark it `uncategorized` rather than forcing a fit. Better an honest "needs review" than a wrong label.

For each classified hook, extract:
- **Pattern type** (one of the 10)
- **Verbatim hook** (exact words)
- **Source** (creator, platform, URL if available)
- **Template** (the reusable shell, with `[VARIABLE]` placeholders)
- **Why it works** (one specific sentence, not "engaging," but *what* about it stops the scroll)

#### Step 3, Score (optional)

If the user provides baseline data, compute an **outlier score**:

```
outlier_score = post_views / creator_median_last_50_posts
```

- 5x or more = ⭐ outlier (worth studying closely)
- 2-5x = above baseline
- under 2x = baseline performer (still useful as template reference, but not "viral")

Hooks that *fail* (post performed BELOW the creator's baseline) are also worth saving in the library marked as `❌ underperformed`, they teach what NOT to copy.

#### Step 4, Append to HOOK_LIBRARY.md

Add each hook to the appropriate pattern section in `HOOK_LIBRARY.md`. Do not delete or rewrite existing entries, this is append-only. If the user has new evidence about an existing hook, add a note dated to today, don't overwrite.

Update the `last_updated` field at the top of the file.

### Mode B, Generate (write new hooks)

Use when the user asks for *new hooks* for a specific piece of content.

#### Step 1, Get the brief

Ask for:
1. **Topic**, what is the content about? (one sentence)
2. **Audience pain or curiosity**, what specifically does the viewer feel right before they tap? (the most-missed input, push for specificity)
3. **Format**, Reel/Short/TikTok/email subject/LinkedIn opener/headline?
4. **Optional: target pattern types**, if the user wants only "contrarian" hooks, or wants a mix

#### Step 2, Read the library + brand voice

- Read `HOOK_LIBRARY.md` if it exists in the working directory, use the user's saved templates as starting structures
- Read `BRAND_VOICE.md` if it exists, match vocabulary, cadence, taboos
- If neither exists, fall back to the 10 patterns in `templates/HOOK_PATTERNS.md`

#### Step 3, Generate 10 hooks

Produce exactly 10 hooks. Spread them across at least 5 different patterns. Format the output as:

```
1. [Pattern type], "Hook text here."
2. [Pattern type], "Hook text here."
...
```

After the 10, add a single line: **"My top 3 picks: #X, #Y, #Z, because [one sentence per pick]."**

#### Step 4, Tighten loop

Ask the user: "Which one is closest? I'll tighten or pivot from there."

Iterate based on their answer. Don't regenerate fresh batches, adjust the chosen one.

## Hard rules

- **Never invent hooks the user can't verify.** When in research mode, only classify what the user provides. Don't fabricate "examples from the internet."
- **Specific pain > vague benefit.** A hook like *"Get more views"* is dead. *"You'd think filming in 4K helps. It doesn't."* lives. Push for specificity in both research and generate modes.
- **Match length to format.** Reel/Short hook = 6–10 words max. Email subject line = 6–9 words. LinkedIn opener = 10–18 words. Don't hand the user a 30-word "hook."
- **Respect BRAND_VOICE taboos.** If the user's BRAND_VOICE.md says "no hype language" or "no emoji," do not output hooks that violate them. No exceptions.
- **One BRAND_VOICE.md, one HOOK_LIBRARY.md per directory.** If the user is doing multi-brand work, run in separate directories.

## Reference files

- `templates/HOOK_PATTERNS.md`, the 10 canonical hook patterns with definitions, formulas, examples, best-fit content types
- `templates/HOOK_LIBRARY.md`, the schema for the user's growing library
- `examples/sample-hook-library.md`, a filled-in example library

## Anti-patterns to avoid

- Generating 10 variations of the same pattern, defeats the purpose of having a taxonomy. Spread across patterns.
- Reaching for clever wordplay when the user's brand voice is plain. Match what they actually sound like, not what feels "creative" to AI.
- Skipping the brief (Step 1 of Generate mode) and rushing to output. The brief is where 80% of the quality lives.
- Treating "views" as the only signal. Saves and shares are usually more predictive of pattern strength.
