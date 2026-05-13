---
name: ccai-brand-voice
description: "Analyzes the user's own writing or speaking samples and produces a structured BRAND_VOICE.md document that other CCAI skills (scripts, captions, sales copy, repurposing) read from. Use when the user asks to capture, define, build, or refine their brand voice, when they say their AI output \"sounds generic\" or \"doesn't sound like them,\" or when they're starting a new content project and want consistency across formats."
when_to_use: "User mentions brand voice, tone of voice, sounding like themselves, writing style, content consistency, or asks \"make this sound like me.\" Also use proactively the first time the user generates marketing content if no BRAND_VOICE.md exists in the working directory."
argument-hint: "[optional: path to samples folder]"
---

# CCAI Brand Voice

Capture the user's authentic writing/speaking voice into a structured document other skills can read.

## Output contract

Write the final result to `BRAND_VOICE.md` in the working directory. Other CCAI skills depend on this exact filename + location and on the section headings defined in `templates/BRAND_VOICE.md`. Do not rename sections.

If `BRAND_VOICE.md` already exists, ask whether to **refine** the existing one or **rebuild from scratch**. Default to refine.

## Process

### Step 1, Gather samples

Ask the user for at least 5 samples of their own content (more is better, aim for 8–15). Accept any of these:

- Pasted transcripts (video, podcast, voice memo)
- Pasted written content (emails, blog posts, captions, LinkedIn posts, newsletters)
- Paths to local `.md` / `.txt` files
- A folder path containing multiple sample files
- URLs to public content the user has *already transcribed* (don't try to fetch and transcribe arbitrary URLs, that's out of scope; tell the user to transcribe first via their tool of choice if they only have video URLs)

Variety matters more than volume. Push the user to include a mix of:
- At least one written sample (shows how they construct sentences)
- At least one spoken sample (shows their natural cadence and fillers)
- At least one piece where they're explaining something
- At least one piece where they're selling or persuading

If the user provides fewer than 5 samples, do the analysis anyway but flag in the output that the doc is **preliminary** and should be revisited once more samples exist.

### Step 2, Analyze across 7 dimensions

For each sample, extract observations. Then synthesize across all samples. Do not summarize sample-by-sample; the final doc captures the pattern.

The 7 dimensions:

1. **Identity**, How does the speaker refer to themselves and the reader? First-person singular, first-person plural ("we"), second-person ("you"), or impersonal? Any nicknames or signature self-references?
2. **Vocabulary**, Signature words (used noticeably more than baseline). Phrases they reuse. Industry terms they accept vs. reject. Words they appear to avoid. Profanity/slang frequency.
3. **Cadence**, Average sentence length. Use of fragments. Paragraph rhythm (short-short-long? all short?). Use of em-dashes, colons, parentheticals.
4. **Hook patterns**, How do they open content? Categorize the top 3–5 opener styles with one example each (e.g. *contrarian claim*, *question*, *personal story*, *stat/number*, *direct statement of payoff*).
5. **Energy register**, Where on a 1–10 scale of intensity do they normally sit? Do they ever go higher or lower deliberately? Calibration examples for "their normal," "their amped up," "their quiet/reflective."
6. **Structural tells**, Use of lists vs prose. Bolding/italics habits. Callouts. Emoji usage frequency and which ones. Signoffs and signature closing patterns. CTAs phrasing.
7. **Taboos**, Things they consciously *don't* do: corporate language, specific buzzwords, certain emoji, specific topics, sales-y closers, etc. Infer from absence and from explicit avoidance.

### Step 3, Generate the doc

Use `templates/BRAND_VOICE.md` as the structural template. Fill every section. **Quote real phrases from the user's samples** as evidence, never use generic stand-ins like "punchy and direct." Specifics beat adjectives.

Include a **Calibration Corpus** section at the bottom: 5 short excerpts from the user's actual samples, labeled with the dimension(s) they best demonstrate. This lets other skills (and future Claude sessions) calibrate against real examples, not the analysis prose.

See `examples/sample-brand-voice.md` for a filled-in example at the level of detail required.

### Step 4, Validate

After writing `BRAND_VOICE.md`, do NOT consider the task complete. Instead:

1. Write **3 short test samples** (each ~50 words) in the captured voice on topics the user actually writes about. Pick topics from the original samples (don't invent unrelated topics).
2. Show the user the 3 test samples and ask them to rate each: **✓ sounds like me**, **✗ doesn't sound like me**, or **△ close but tweak X**.
3. If any sample gets ✗ or △, ask the user what's off, update `BRAND_VOICE.md` to reflect the correction, and re-run the validation with 2 fresh test samples.

The skill is done only when the user signs off on the test samples.

### Step 5, Reference for other skills

After `BRAND_VOICE.md` is approved, remind the user that other CCAI skills (`ccai-video-script`, `ccai-content-repurpose`, `ccai-sales-copy`, `ccai-carousel-builder`) will read from this file automatically when they run in the same working directory. They should keep it in the project root.

## Hard rules

- **Never invent voice attributes the samples don't support.** If the user provides 5 samples that are all enthusiastic, don't say "occasionally uses dry humor" because it's a nice phrase. Only include what the samples evidence.
- **Direct quotes only as evidence.** When citing examples, copy the user's actual words verbatim. Don't paraphrase. Wrap quotes in markdown blockquotes with a citation: `> "their exact words", sample 3`
- **No corporate adjectives in the output.** "Authentic," "engaging," "compelling," "professional," "passionate" are banned from the analysis, they describe nothing. Use specific observations.
- **One BRAND_VOICE.md per working directory.** If the user works in multiple voices (e.g. their personal brand vs. a client brand), they should create separate directories.

## Anti-patterns to avoid

- Long lists of vague descriptors ("witty, smart, real, helpful"), useless to AI and humans alike. Replace with specific examples.
- Restating what the user said about themselves in pre-interview prep without checking the samples. If the user says "I'm casual" but their samples are formal, trust the samples.
- Skipping Step 4 validation because it feels redundant. Validation is the only thing that makes the doc *true* vs. *plausible-sounding*.
