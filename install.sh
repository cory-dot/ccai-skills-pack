#!/usr/bin/env bash
# install.sh — install one or all CCAI skills from this monorepo
# Usage:
#   ./install.sh                    # install all 26 skills
#   ./install.sh ccai-brand-voice   # install just one
#   ./install.sh foundation         # install foundation set only
#   ./install.sh --list             # list available skills

set -euo pipefail

SKILLS_DIR="${HOME}/.claude/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Skill groups
FOUNDATION=(ccai-brand-voice ccai-hook-research ccai-content-ideas ccai-competitor-research)
CONTENT=(ccai-video-script ccai-content-repurpose ccai-sales-copy ccai-carousel-builder)
DECISIONS=(ccai-second-opinion ccai-reel-scorer)
WORKFLOW=(ccai-marketing-prompts ccai-super-employee-prompts ccai-mother-skill-template)
OPS=(ccai-bookkeeping ccai-lead-finder ccai-cold-outreach ccai-meta-ads-autopilot ccai-meta-ad-creative ccai-obsidian-wiki ccai-command-center ccai-shopify-ops ccai-agent-monitor)
BUILD=(ccai-website-builder-setup ccai-landing-page ccai-ghl-page ccai-dashboard-builder)

ALL=("${FOUNDATION[@]}" "${CONTENT[@]}" "${DECISIONS[@]}" "${WORKFLOW[@]}" "${OPS[@]}" "${BUILD[@]}")

show_help() {
  cat <<EOF
ccai-skills-pack installer

Usage:
  ./install.sh [target]

Targets:
  (none)         Install all 26 skills
  --list         List all available skills
  foundation     Install foundation set (4 skills) — start here
  content        Install content production set (4)
  decisions      Install decisions + quality set (2)
  workflow       Install workflow + meta set (3)
  ops            Install operations set (9 — Tier B)
  build          Install build set (4 — Tier C)
  ccai-<name>    Install a single named skill

Examples:
  ./install.sh foundation
  ./install.sh ccai-brand-voice
  ./install.sh
EOF
}

install_skill() {
  local skill="$1"
  if [ ! -d "$SCRIPT_DIR/$skill" ]; then
    echo "  ✗ $skill — not found in pack"
    return 1
  fi
  mkdir -p "$SKILLS_DIR"
  if [ -d "$SKILLS_DIR/$skill" ]; then
    echo "  ⚠ $skill — already installed, skipping (delete first to reinstall)"
    return 0
  fi
  cp -r "$SCRIPT_DIR/$skill" "$SKILLS_DIR/$skill"
  echo "  ✓ $skill"
}

case "${1:-all}" in
  --help|-h)
    show_help
    ;;
  --list)
    echo "Available skills (26):"
    for skill in "${ALL[@]}"; do
      echo "  - $skill"
    done
    ;;
  all)
    echo "Installing all 26 skills to $SKILLS_DIR..."
    for skill in "${ALL[@]}"; do
      install_skill "$skill"
    done
    echo "Done. Restart Claude Code or run /doctor to confirm."
    ;;
  foundation|content|decisions|workflow|ops|build)
    group_var=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    group_array_name="${group_var}[@]"
    skills=("${!group_array_name}")
    echo "Installing $1 set (${#skills[@]} skills) to $SKILLS_DIR..."
    for skill in "${skills[@]}"; do
      install_skill "$skill"
    done
    echo "Done. Restart Claude Code or run /doctor to confirm."
    ;;
  ccai-*)
    install_skill "$1"
    ;;
  *)
    echo "Unknown target: $1"
    show_help
    exit 1
    ;;
esac
