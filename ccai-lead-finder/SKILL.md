---
name: ccai-lead-finder
description: "Structured lead research workflow, takes a target persona (industry, role, location, signals), produces a research plan + qualification scoring + personalized outreach angles for each lead. Free version: you provide leads from LinkedIn Sales Navigator / Apollo exports / manual research, the skill enriches and qualifies. Pro version adds Apify scraping. Use when the user wants to build a lead list, qualify inbound interest, or prep outreach research."
when_to_use: "User mentions lead generation, prospecting, cold outreach prep, ICP definition, sales pipeline, lead scoring, or asks \"who should I reach out to.\""
argument-hint: "[paste leads, or 'icp' to define ideal customer profile]"
---

# CCAI Lead Finder

Structured lead qualification + outreach research. You bring the names; the skill turns them into qualified prospects with personalized angles.

## Output contract

Saves to `leads/` in the working directory:
- `leads/ICP.md`, ideal customer profile (built on first run)
- `leads/leads-batch-YYYY-MM-DD.md`, qualified lead batch with scores + outreach angles
- `leads/_log.md`, running log of all batches + outcomes

## Inputs

Either:
- A list of leads pasted (CSV: name, company, role, LinkedIn URL, any signals)
- A LinkedIn Sales Navigator export
- An Apollo / Clay / Wiza export
- Just names + companies, the skill asks for more

## Process

### Step 1, ICP (first run only)
Build `ICP.md`: target industry, company size, role/title, geography, signals (recent funding / hiring / tech stack / triggers), disqualifiers.

### Step 2, Score each lead
For each lead, compute a 0-100 fit score:
- Industry match (0-25)
- Role/title match (0-20)
- Company size match (0-15)
- Recent signals (0-25): funding, hiring, leadership change, tech adoption
- Disqualifier check (-100 if any)

### Step 3, Personalized angle per lead
For each lead scoring 60+, produce:
- The single most relevant signal (with source if known)
- A 1-sentence personalized opener
- The "why now", what makes this week a good time to reach out
- Suggested first-touch channel (LinkedIn / email / DM)

### Step 4, Output
A sortable table: name, company, score, signal, angle, channel.
Summary: how many qualified, top 5 picks, leads to disqualify.

## Hard rules

- **No fabricated signals.** If a "recent funding" signal isn't verifiable, mark it as "unverified, needs check before outreach."
- **No outreach copy in this skill.** Angles only. Full outreach drafts are `ccai-cold-outreach`.
- **Respect ICP disqualifiers absolutely.** A high-scoring lead in a disqualified industry is still a no.
- **Score with calibration.** Most leads in any real batch should score 40-70. If everyone's scoring 85+, the ICP is too loose.

## Pro version differences

`ccai-lead-finder-pro` (planned):
- Apify scraping for LinkedIn search results
- Auto-enrichment from Clearbit / Apollo APIs
- Real-time signal monitoring (funding announcements, job changes)
- CRM sync (HubSpot, Salesforce)

## Reference files
- `templates/ICP.md`, schema for ideal customer profile
- `templates/LEAD_BATCH.md`, schema for qualified leads
- `examples/sample-leads-batch.md`, filled example
