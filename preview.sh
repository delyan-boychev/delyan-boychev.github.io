#!/bin/sh
# Live-reloading Jekyll preview: http://127.0.0.1:4000
set -eu
cd "$(dirname "$0")"

# macOS ships an obsolete system Ruby. Prefer Homebrew's Bundler when present.
if [ -x /opt/homebrew/bin/bundle ]; then
  BUNDLE_CMD=/opt/homebrew/bin/bundle
elif [ -x /usr/local/bin/bundle ]; then
  BUNDLE_CMD=/usr/local/bin/bundle
else
  BUNDLE_CMD=$(command -v bundle || true)
fi

if [ -z "$BUNDLE_CMD" ]; then
  echo "Bundler was not found. Install Ruby and Bundler, then run: bundle install" >&2
  exit 1
fi

"$BUNDLE_CMD" exec jekyll serve --livereload --host 127.0.0.1
