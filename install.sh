#!/usr/bin/env bash
# Install dependencies and ensure pm2 is available.
if ! command -v pm2 >/dev/null 2>&1; then
    echo "pm2 not found, installing globally..."
    npm install -g pm2
fi
[ -f package.json ] && npm install
for sub in */; do [ -d "$sub" ] && [ -f "${sub}package.json" ] && (cd "$sub" && npm install); done
exit 0
