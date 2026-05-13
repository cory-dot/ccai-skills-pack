---
name: ccai-batch-render
description: "Renders hundreds of video variants from a spreadsheet/CSV using a ccai-video-editor Remotion template. Produces one MP4 per row. Use when the user has a CSV of variants (customer names, headlines, prices, etc.) and a Remotion template, generates the script that walks the CSV and renders each."
when_to_use: "User mentions batch render, render 100 videos, CSV-driven video, spreadsheet to videos, mass video production, scaled personalization, or asks \"how do I produce N videos from this data.\""
argument-hint: "[path to CSV + path to Remotion template]"
---

# CCAI Batch Render

Bridge between a CSV and a Remotion template. Produces one MP4 per row.

## What this is

Companion to `ccai-video-editor`. That skill generates the Remotion template. This skill is the script that:
1. Reads a CSV with N rows
2. For each row, maps columns → Remotion variant props
3. Renders one MP4 with that row's data
4. Saves to `out/` with a sensible filename
5. Reports progress, failures, and total render time

## Prerequisites

- `ccai-video-editor` already ran (Remotion project exists in working dir)
- A CSV file with one row per video variant
- CSV columns match the Remotion template's variant props

## Output contract

Generates:
- `scripts/batch-render.ts`, the orchestration script
- `data/variants.csv`, placement for the user's CSV (or accepts a path)
- `out/` directory, where rendered MP4s land

After running:
- `out/video-001-<slug>.mp4`, `out/video-002-<slug>.mp4`, ..., `out/video-NNN-<slug>.mp4`
- `out/_render-log.md`, per-row status (success / failed / skipped)

## Process

### Step 1, Verify Remotion project + CSV
- Check that a Remotion `package.json` exists
- Check the CSV file is readable
- Parse CSV header to confirm columns match the template's expected variant props
- If mismatch, show the user the diff and ask whether to map columns / add fields / abort

### Step 2, Generate `scripts/batch-render.ts`

```typescript
import { renderMedia, selectComposition } from '@remotion/renderer'
import { parse } from 'csv-parse/sync'
import { readFileSync, writeFileSync } from 'fs'
import { bundle } from '@remotion/bundler'
import path from 'path'

async function batchRender() {
  const csvData = readFileSync('data/variants.csv', 'utf-8')
  const rows = parse(csvData, { columns: true, skip_empty_lines: true })

  const bundled = await bundle({ entryPoint: path.resolve('src/index.ts') })

  const log: { row: number; status: string; file: string; error?: string }[] = []

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i]
    const slug = (row.slug || row.id || `row-${i + 1}`).toString().replace(/[^a-z0-9-]/gi, '-')
    const output = path.resolve('out', `video-${String(i + 1).padStart(3, '0')}-${slug}.mp4`)

    try {
      const composition = await selectComposition({
        serveUrl: bundled,
        id: 'AdVariant',          // composition ID, adapt per template
        inputProps: row,
      })
      await renderMedia({
        composition,
        serveUrl: bundled,
        codec: 'h264',
        outputLocation: output,
        inputProps: row,
      })
      log.push({ row: i + 1, status: 'success', file: output })
      console.log(`✓ Row ${i + 1}/${rows.length} → ${output}`)
    } catch (err) {
      log.push({ row: i + 1, status: 'failed', file: output, error: String(err) })
      console.error(`✗ Row ${i + 1}/${rows.length} failed:`, err)
    }
  }

  // Write log
  const md = generateLogMarkdown(log)
  writeFileSync('out/_render-log.md', md)
  console.log(`\nDone. Log saved to out/_render-log.md`)
}

function generateLogMarkdown(log: any[]): string {
  // ... format the log into a markdown table
}

batchRender()
```

### Step 3, Add the npm script
Edit user's `package.json` to add:
```json
"scripts": {
  "render-batch": "ts-node scripts/batch-render.ts"
}
```

### Step 4, Performance preview
Before running, estimate:
- Avg render time per video (from template duration + complexity)
- Total estimated wall time
- Total disk space needed
- Whether the user should split into smaller batches (>200 videos = consider Remotion Lambda)

### Step 5, Run + monitor
- `npm run render-batch`
- Live console output: progress bar + ETA
- On failure of any row: continue with the rest, log the failure
- Final summary: N succeeded, M failed, total time

### Step 6, Output verification
After completion:
- Open the `out/_render-log.md` file
- Spot-check 3-5 rendered videos
- If failures > 5%, surface to user for batch-fix

## Hard rules

- **Never overwrite existing output files.** If `out/video-001-X.mp4` exists, skip with a warning unless user passes `--overwrite`.
- **Continue past failures, don't crash the whole batch.** A failed row gets logged; the rest continue.
- **No silent codec changes.** If the template uses h264 + crf 23, the batch render uses the same. No "I'll optimize" hidden behavior.
- **Disk space check before starting.** Estimate total output size; warn if disk has less than 1.5× that available.
- **Filename safety.** Slugs derived from CSV must be filesystem-safe, strip special chars.

## Pro version differences

`ccai-batch-render-pro` (planned):
- Remotion Lambda integration (cloud rendering, runs 100s of videos in parallel)
- Direct CDN upload after each render (Cloudflare R2 / S3)
- Cost estimation per batch (Lambda billing)
- Failure auto-retry with exponential backoff
- Slack notification on batch completion

## Reference files
- `templates/batch-render.ts.md`, sample render script
- `examples/sample-batch-csv.md`, example CSV + render log
