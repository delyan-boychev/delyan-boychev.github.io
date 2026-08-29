#!/bin/sh
# Autocompiles CV/main.tex to CV/main.pdf whenever main.tex changes.
# No extra dependencies (latexmk/fswatch) required — plain polling.
set -eu
cd "$(dirname "$0")/CV"

if ! command -v pdflatex >/dev/null 2>&1; then
  echo "pdflatex was not found. Install a TeX distribution (e.g. MacTeX) first." >&2
  exit 1
fi

build() {
  if pdflatex -interaction=nonstopmode -halt-on-error main.tex >/tmp/cv-build.log 2>&1; then
    rm -f main.aux main.log main.out
    echo "[$(date '+%H:%M:%S')] Compiled CV/main.pdf"
  else
    echo "[$(date '+%H:%M:%S')] Build failed — see /tmp/cv-build.log" >&2
  fi
}

echo "Watching CV/main.tex — Ctrl+C to stop."
build
last=$(stat -f %m main.tex)
while true; do
  sleep 1
  current=$(stat -f %m main.tex)
  if [ "$current" != "$last" ]; then
    last=$current
    build
  fi
done
