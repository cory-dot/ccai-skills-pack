# install.ps1 — install one or all CCAI skills from this monorepo (Windows PowerShell)
# Usage:
#   .\install.ps1                    # install all 32 skills
#   .\install.ps1 ccai-brand-voice   # install just one
#   .\install.ps1 foundation         # install foundation set only
#   .\install.ps1 -List              # list available skills

param(
    [Parameter(Position=0)]
    [string]$Target = "all",
    [switch]$List,
    [switch]$Help
)

$SkillsDir = Join-Path $env:USERPROFILE ".claude\skills"
$ScriptDir = $PSScriptRoot

# Skill groups
$Foundation = @("ccai-brand-voice", "ccai-hook-research", "ccai-content-ideas", "ccai-competitor-research")
$Content = @("ccai-video-script", "ccai-content-repurpose", "ccai-sales-copy", "ccai-carousel-builder")
$Decisions = @("ccai-second-opinion", "ccai-reel-scorer")
$Workflow = @("ccai-marketing-prompts", "ccai-super-employee-prompts", "ccai-mother-skill-template")
$Ops = @("ccai-bookkeeping", "ccai-lead-finder", "ccai-cold-outreach", "ccai-meta-ads-autopilot", "ccai-meta-ad-creative", "ccai-meta-api-throttle", "ccai-ugc-video-ads", "ccai-obsidian-wiki", "ccai-command-center", "ccai-shopify-ops", "ccai-agent-monitor")
$Build = @("ccai-website-builder-setup", "ccai-landing-page", "ccai-ghl-page", "ccai-dashboard-builder", "ccai-3d-website", "ccai-video-editor", "ccai-batch-render", "ccai-3d-capture")
$All = $Foundation + $Content + $Decisions + $Workflow + $Ops + $Build

function Show-Help {
    @"
ccai-skills-pack installer (Windows PowerShell)

Usage:
  .\install.ps1 [target]

Targets:
  (none)         Install all 32 skills
  -List          List all available skills
  foundation     Install foundation set (4 skills) -- start here
  content        Install content production set (4)
  decisions      Install decisions + quality set (2)
  workflow       Install workflow + meta set (3)
  ops            Install operations set (11 -- Tier B)
  build          Install build set (8 -- Tier C)
  ccai-<name>    Install a single named skill
"@
}

function Install-Skill {
    param([string]$Skill)
    $src = Join-Path $ScriptDir $Skill
    $dst = Join-Path $SkillsDir $Skill
    if (-not (Test-Path $src)) {
        Write-Host "  X $Skill -- not found in pack" -ForegroundColor Red
        return
    }
    if (Test-Path $dst) {
        Write-Host "  ! $Skill -- already installed, skipping" -ForegroundColor Yellow
        return
    }
    if (-not (Test-Path $SkillsDir)) {
        New-Item -ItemType Directory -Path $SkillsDir -Force | Out-Null
    }
    Copy-Item -Path $src -Destination $dst -Recurse
    Write-Host "  + $Skill" -ForegroundColor Green
}

if ($Help) { Show-Help; exit 0 }
if ($List) {
    Write-Host "Available skills (32):"
    $All | ForEach-Object { Write-Host "  - $_" }
    exit 0
}

switch -Regex ($Target) {
    "^all$" {
        Write-Host "Installing all 32 skills to $SkillsDir..."
        $All | ForEach-Object { Install-Skill $_ }
        Write-Host "Done. Restart Claude Code or run /doctor to confirm."
    }
    "^foundation$" { Write-Host "Installing foundation set..."; $Foundation | ForEach-Object { Install-Skill $_ } }
    "^content$" { Write-Host "Installing content set..."; $Content | ForEach-Object { Install-Skill $_ } }
    "^decisions$" { Write-Host "Installing decisions set..."; $Decisions | ForEach-Object { Install-Skill $_ } }
    "^workflow$" { Write-Host "Installing workflow set..."; $Workflow | ForEach-Object { Install-Skill $_ } }
    "^ops$" { Write-Host "Installing ops set..."; $Ops | ForEach-Object { Install-Skill $_ } }
    "^build$" { Write-Host "Installing build set..."; $Build | ForEach-Object { Install-Skill $_ } }
    "^ccai-" { Install-Skill $Target }
    default { Write-Host "Unknown target: $Target"; Show-Help; exit 1 }
}
