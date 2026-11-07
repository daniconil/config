#!/usr/bin/env bash
set -euo pipefail

ROOT=/home/daniel/Code/config-sync

# Copia los archivos desde su ubicación original al repo
cp /home/daniel/.pi/fallback-chains.json "$ROOT/.pi/"
cp /home/daniel/.pi/agent/autorouter.json "$ROOT/.pi/agent/"
cp /home/daniel/.zshrc "$ROOT/"

cd "$ROOT"

# Solo hace commit si hay cambios
if ! git diff --quiet || ! git diff --cached --quiet; then
    git add -A
    git commit -m "sync: $(date '+%Y-%m-%d %H:%M')"
    echo "Commit creado."
else
    echo "Sin cambios."
fi
