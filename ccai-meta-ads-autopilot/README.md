# ccai-meta-ads-autopilot

> Weekly Meta Ads workflow, sweep last week's data, plan next week's 10 ads using the 3-3-2-2 distribution, output upload-ready specs. Manual execution in Ads Manager (pro version adds API auto-deploy).


> **Part of [ccai-skills-pack](https://github.com/cory-dot/ccai-skills-pack)**, Creative Core AI's 26-skill library. Install this skill standalone (see below), or grab the full pack in one go.

**Slash command:** `/ccai-meta-ads-autopilot`
**Status:** v0.1 free tier · works with Claude Code

---

## What it does

Most "automate your Meta ads" tools either (a) need a paid API tier you don't have yet, or (b) make strategic decisions for you that you can't validate.

This skill is built for the in-between: **you make the decisions, the skill structures the weekly process**. Same logic as a media buyer's playbook, executed manually until you're ready to graduate to full automation.

Each weekly run produces:

1. **Last week's audit**, winners to promote, losers to kill, gray zone to let run, with explicit thresholds
2. **30-day rolling trends**, format winners, audience patterns (after a few weeks of history)
3. **Competitor inspiration**, patterns to steal this week (you provide the competitor data)
4. **10 new ad concepts**, using the proven **3-3-2-2 distribution**:
   - **3 winners doubled down** (variations of last week's top performers)
   - **3 competitor-inspired** (patterns from ads you've seen working)
   - **2 new psychology pillars** (testing an angle not yet attempted)
   - **2 wildcards** (concepts you wouldn't normally make)
5. **Upload-ready specs** for each, primary text, headline, description, audience, budget, image direction
6. **Recommended upload order** (paused → batch un-pause)
7. **Weekly log entry** for future trend analysis

You execute the actions manually in Meta Ads Manager. Takes ~30-60 minutes after the skill runs.

---

## Why manual execution (for now)

The hard part of weekly ad management isn't the API calls, it's the strategy. The skill runs the decision logic; you handle the upload.

If you're running fewer than ~$5K/month in ad spend, manual is the right tradeoff (the API tier costs money + setup time you don't yet need). Above that, the pro version pays for itself:

`ccai-meta-ads-autopilot-pro` (planned) adds:
- Meta Marketing API integration (auto-pull data, auto-create campaigns)
- Higgsfield MCP for auto-image generation
- Cron scheduling (runs every Monday automatically)
- Slack/SMS weekly digest
- Automated kill/promote actions

The strategic logic is identical. The difference is who clicks the buttons.

---

## Why it's different from "ChatGPT, write me 10 Facebook ads"

1. **Last week's data informs next week's batch.** It's a loop, not a one-shot. Pattern recognition compounds.
2. **The 3-3-2-2 distribution is enforced.** You can't accidentally generate 10 variations of the same winner. Diversity prevents over-fitting.
3. **Kill thresholds and win thresholds are explicit.** "Should I kill this ad?" gets answered by the math, not vibes.
4. **Reads your `BRAND_VOICE.md`.** Ad copy respects brand taboos even within Meta's 90-character primary-text limit.
5. **30-day rolling trends after 4+ weeks of history.** The log becomes a strategic asset over time.

---

## What you need

- A Meta ad account with at least one campaign already running
- Conversion tracking installed (pixel on your destination URL)
- Last week's performance data (you paste it into the skill)
- 3-10 competitor names/Page IDs (or screenshots of their recent ads)
- A weekly budget commitment
- **Strongly recommended:** `ccai-brand-voice` already run

No Meta API key. No paid third-party tools. The free version runs on manual paste + manual upload.

---

## Install

```bash
git clone https://github.com/cory-dot/ccai-meta-ads-autopilot ~/.claude/skills/ccai-meta-ads-autopilot
```

Restart Claude Code or run `/doctor` to confirm.

---

## Usage

### First-time setup
```
/ccai-meta-ads-autopilot setup
```

The skill walks you through:
- Setting your kill threshold and win threshold (defaults provided)
- Specifying competitor names
- Defining your target CPA and weekly budget
- Setting where the weekly batch files save

### Weekly run (Mondays recommended)
```
/ccai-meta-ads-autopilot
```

The skill will:
1. Ask you to paste last week's ad data (table)
2. Run the audit (winners/losers/gray)
3. Show you action list (kill/promote, you execute these in Ads Manager)
4. Ask for 3-5 competitor ads you've noticed
5. Generate 10 new concepts (3-3-2-2 distribution)
6. Save the weekly batch to `meta-ads/YYYY-MM-DD-week-NN.md`
7. Tell you the recommended upload order

---

## The 3-3-2-2 distribution explained

This is the most important strategic concept in the skill. Most ad creators over-index on what worked last week and stop discovering new winners.

| Bucket | Count | Purpose |
|---|---|---|
| Winners doubled-down | 3 | Exploit what's working, but with variation, not exact copies |
| Competitor-inspired | 3 | Borrow patterns proven in your space |
| New psychology pillars | 2 | Test angles you haven't tried yet |
| Wildcards | 2 | Concepts you wouldn't normally make, where the surprise winners live |

Result: 60% optimization, 40% discovery. That ratio prevents the "we found a winner and rode it into the ground" trap that kills most ad accounts.

---

## What the output looks like

See [`examples/sample-weekly-batch.md`](examples/sample-weekly-batch.md) for a fully filled-in weekly run with:
- Real-format performance audit table
- 4 winners to promote + 3 losers to kill + 3 in the gray zone
- 30-day trend summary
- 3 competitor patterns analyzed
- All 10 concepts with copy + image direction + audience + budget
- Budget reconciliation flag (when the batch exceeds the stated budget)

---

## Files in this repo

| File | Purpose |
|---|---|
| [`SKILL.md`](SKILL.md) | Skill instructions with 7-step loop |
| [`templates/WEEKLY_BATCH.md`](templates/WEEKLY_BATCH.md) | Output schema for each weekly run |
| [`examples/sample-weekly-batch.md`](examples/sample-weekly-batch.md) | A fully worked week 3 batch with real audit data |
| [`LICENSE`](LICENSE) | MIT |

---

## FAQ

**My ad data is in a Meta export CSV. Can I just upload it?**
For v0.1, paste it as a markdown table. v0.2 will add CSV parsing.

**What's the right starting budget?**
$300-700/week is the sweet spot for using this skill (enough data to make decisions, not so much that manual execution becomes painful). Below $300, the data is too sparse; above $1500, consider the pro version.

**My business doesn't have competitors I can copy from. Now what?**
Look outside your direct industry for the same audience or same psychology. Marie Forleo's ads work for entrepreneurial coaches even if you sell ergonomic chairs. Pattern-mining is broader than direct-competitor copying.

**Pro version is when?**
Roadmap: `-pro` ships once 100+ free users provide real-world weekly data so we can validate the strategic logic before automating it. Manual first; automation second.

---

## Part of the Creative Core AI skills pack

This skill is part of [`ccai-skills-pack`](https://github.com/cory-dot/ccai-skills-pack), the full Creative Core AI skill library (26 skills total). Two ways to install:

```bash
# Just this skill (ad-hoc)
git clone https://github.com/cory-dot/ccai-meta-ads-autopilot ~/.claude/skills/ccai-meta-ads-autopilot

# Or the entire pack
git clone https://github.com/cory-dot/ccai-skills-pack ~/ccai-skills-pack && cd ~/ccai-skills-pack && ./install.sh
```

The full pack is taught in [The AI Operator's Playbook](https://skool.com/creative-core-ai), our free Skool course for non-technical business owners.

Want someone to set this all up for you? [Book a diagnostic call](https://creativecore.ai/book).


---

## License

MIT.
