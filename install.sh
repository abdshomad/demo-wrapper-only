#!/usr/bin/env bash
# Install dependencies and ensure pm2 + uv are available.
if ! command -v pm2 >/dev/null 2>&1; then
    echo "pm2 not found, installing globally..."
    npm install -g pm2
fi
export PATH="$HOME/.local/bin:$PATH"
if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found, installing..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
fi
[ -f package.json ] && npm install
for sub in */; do
    [ -d "$sub" ] || continue
    [ -f "${sub}package.json" ] && (cd "$sub" && npm install)
    [ -f "${sub}pyproject.toml" ] && (cd "$sub" && uv sync)
done
exit 0
