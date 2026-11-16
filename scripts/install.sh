#!/usr/bin/env bash
# Install presupuesto-ar into Cursor and/or Codex skill directories.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="${ROOT}/skills/presupuesto-ar"
NAME="presupuesto-ar"

usage() {
  cat <<'EOF'
Usage: ./scripts/install.sh [options]

Install the presupuesto-ar agent skill for Cursor and/or Codex.

Options:
  --cursor          Install for Cursor
  --codex           Install for Codex
  --project         Project scope (default): .cursor/skills or .codex/skills
  --user            User scope: ~/.cursor/skills or ~/.codex/skills
  --force           Replace an existing install
  -h, --help        Show this help

With no --cursor/--codex flags, installs both.
EOF
}

DO_CURSOR=0
DO_CODEX=0
SCOPE="project"
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --cursor) DO_CURSOR=1; shift ;;
    --codex) DO_CODEX=1; shift ;;
    --project) SCOPE="project"; shift ;;
    --user|--global) SCOPE="user"; shift ;;
    --force) FORCE=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [[ "$DO_CURSOR" -eq 0 && "$DO_CODEX" -eq 0 ]]; then
  DO_CURSOR=1
  DO_CODEX=1
fi

if [[ ! -f "${SRC}/SKILL.md" ]]; then
  echo "Missing skill source: ${SRC}/SKILL.md" >&2
  exit 1
fi

link_or_copy() {
  local dest="$1"
  mkdir -p "$(dirname "$dest")"
  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$FORCE" -eq 1 ]]; then
      rm -rf "$dest"
    else
      echo "Already installed: $dest (pass --force to replace)"
      return 0
    fi
  fi
  # Prefer a relative symlink so the repo stays portable.
  local rel
  rel="$(realpath --relative-to="$(dirname "$dest")" "$SRC" 2>/dev/null || true)"
  if [[ -n "$rel" ]] && ln -s "$rel" "$dest" 2>/dev/null; then
    echo "Linked  $dest -> $rel"
  elif ln -s "$SRC" "$dest" 2>/dev/null; then
    echo "Linked  $dest -> $SRC"
  else
    mkdir -p "$dest"
    cp -a "${SRC}/." "$dest/"
    echo "Copied  $dest"
  fi
}

install_cursor() {
  local dest
  if [[ "$SCOPE" == "user" ]]; then
    dest="${HOME}/.cursor/skills/${NAME}"
  else
    dest="${ROOT}/.cursor/skills/${NAME}"
  fi
  link_or_copy "$dest"
}

install_codex() {
  local dest
  if [[ "$SCOPE" == "user" ]]; then
    dest="${HOME}/.codex/skills/${NAME}"
  else
    dest="${ROOT}/.codex/skills/${NAME}"
  fi
  link_or_copy "$dest"
}

[[ "$DO_CURSOR" -eq 1 ]] && install_cursor
[[ "$DO_CODEX" -eq 1 ]] && install_codex

echo
echo "Done. Scope=${SCOPE}."
echo "Canonical skill: ${SRC}"
echo "In Cursor / Codex, ask for a presupuesto AR (3 URLs per item, LaTeX cobre)."
