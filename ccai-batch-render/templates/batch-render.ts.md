# Sample batch-render.ts

> Reference for the render script the skill generates. Customize the `id` (composition name) and any CSV column mapping to match your template.

```typescript
import { renderMedia, selectComposition } from '@remotion/renderer'
import { bundle } from '@remotion/bundler'
import { parse } from 'csv-parse/sync'
import { readFileSync, writeFileSync, existsSync, mkdirSync } from 'fs'
import path from 'path'

interface RenderLog {
  row: number
  slug: string
  status: 'success' | 'failed' | 'skipped'
  file: string
  durationMs?: number
  error?: string
}

const CSV_PATH = 'data/variants.csv'
const OUT_DIR = 'out'
const COMPOSITION_ID = 'AdVariant'  // change to match your template's composition

async function batchRender() {
  // Verify inputs
  if (!existsSync(CSV_PATH)) {
    console.error(`CSV not found at ${CSV_PATH}`)
    process.exit(1)
  }
  if (!existsSync(OUT_DIR)) {
    mkdirSync(OUT_DIR, { recursive: true })
  }

  const csvData = readFileSync(CSV_PATH, 'utf-8')
  const rows = parse(csvData, { columns: true, skip_empty_lines: true })

  console.log(`Parsed ${rows.length} variants from ${CSV_PATH}`)
  console.log(`Bundling Remotion project...`)

  const bundled = await bundle({ entryPoint: path.resolve('src/index.ts') })

  const log: RenderLog[] = []
  const startTime = Date.now()

  for (let i = 0; i < rows.length; i++) {
    const row = rows[i]
    const slug = sanitizeSlug(row.slug || row.id || `row-${i + 1}`)
    const filename = `video-${String(i + 1).padStart(3, '0')}-${slug}.mp4`
    const output = path.resolve(OUT_DIR, filename)

    // Skip if exists
    if (existsSync(output) && !process.argv.includes('--overwrite')) {
      console.log(`⏭  Row ${i + 1}/${rows.length} skipped (exists): ${filename}`)
      log.push({ row: i + 1, slug, status: 'skipped', file: output })
      continue
    }

    const rowStart = Date.now()
    try {
      const composition = await selectComposition({
        serveUrl: bundled,
        id: COMPOSITION_ID,
        inputProps: row,
      })
      await renderMedia({
        composition,
        serveUrl: bundled,
        codec: 'h264',
        crf: 23,
        outputLocation: output,
        inputProps: row,
      })
      const durationMs = Date.now() - rowStart
      log.push({ row: i + 1, slug, status: 'success', file: output, durationMs })
      console.log(`✓  Row ${i + 1}/${rows.length} → ${filename} (${(durationMs / 1000).toFixed(1)}s)`)
    } catch (err) {
      const errMsg = err instanceof Error ? err.message : String(err)
      log.push({ row: i + 1, slug, status: 'failed', file: output, error: errMsg })
      console.error(`✗  Row ${i + 1}/${rows.length} failed: ${errMsg}`)
    }
  }

  const totalSec = (Date.now() - startTime) / 1000

  // Write log
  writeFileSync(path.join(OUT_DIR, '_render-log.md'), generateLogMarkdown(log, totalSec))

  // Summary
  const succeeded = log.filter((l) => l.status === 'success').length
  const failed = log.filter((l) => l.status === 'failed').length
  const skipped = log.filter((l) => l.status === 'skipped').length

  console.log(`\n=== Done ===`)
  console.log(`Succeeded: ${succeeded}`)
  console.log(`Failed:    ${failed}`)
  console.log(`Skipped:   ${skipped}`)
  console.log(`Total time: ${(totalSec / 60).toFixed(1)} min`)
  console.log(`Log: ${OUT_DIR}/_render-log.md`)
}

function sanitizeSlug(input: string | number): string {
  return String(input)
    .toLowerCase()
    .replace(/[^a-z0-9-]/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '')
    .slice(0, 50)
}

function generateLogMarkdown(log: RenderLog[], totalSec: number): string {
  const succeeded = log.filter((l) => l.status === 'success').length
  const failed = log.filter((l) => l.status === 'failed').length
  const skipped = log.filter((l) => l.status === 'skipped').length

  let md = `# Batch Render Log\n\n`
  md += `> Generated: ${new Date().toISOString()}\n`
  md += `> Total time: ${(totalSec / 60).toFixed(1)} minutes\n`
  md += `> Succeeded: ${succeeded} · Failed: ${failed} · Skipped: ${skipped}\n\n`
  md += `## Per-row status\n\n`
  md += `| # | Slug | Status | Duration | File / Error |\n|---|---|---|---|---|\n`

  for (const entry of log) {
    const status = entry.status === 'success' ? '✓' : entry.status === 'failed' ? '✗' : '⏭'
    const detail = entry.error ? `❌ ${entry.error}` : `\`${path.basename(entry.file)}\``
    const dur = entry.durationMs ? `${(entry.durationMs / 1000).toFixed(1)}s` : '—'
    md += `| ${entry.row} | ${entry.slug} | ${status} ${entry.status} | ${dur} | ${detail} |\n`
  }

  return md
}

batchRender().catch((err) => {
  console.error('Fatal error:', err)
  process.exit(1)
})
```

## Run

```bash
npm run render-batch              # render all (skip already-rendered)
npm run render-batch -- --overwrite   # render all, overwriting existing
```

## Notes

- Renders are sequential by default (one at a time). For parallelization, see `ccai-batch-render-pro` (Remotion Lambda).
- Failed rows don't stop the batch — the log captures them for retry.
- `--overwrite` flag forces re-render of existing output files.
