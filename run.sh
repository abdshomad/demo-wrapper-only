#!/usr/bin/env bash
# Start the app under pm2 (background, persisted via pm2 save).
[ -f .env ] && export $(grep -v '^#' .env | xargs)
[ -n "$PORT" ] && ln -sf run.sh "run-${PORT}.sh" 2>/dev/null || true
rm -f .app.pid
if ! command -v pm2 >/dev/null 2>&1; then
    echo "pm2 not found. Run ./install.sh first."
    exit 1
fi
# Pre-check: mirror ecosystem.config.js detection for a clean error.
has_app=0
[ -f package.json ] && has_app=1
if [ "$has_app" -eq 0 ]; then
    for sub in */; do
        [ -d "$sub" ] || continue
        case "$sub" in .*/|node_modules/|screenshots/|issues/) continue;; esac
        if [ -f "${sub}package.json" ] || [ -f "${sub}app.py" ]; then has_app=1; break; fi
    done
fi
if [ "$has_app" -eq 0 ]; then
    echo "No app found: add root package.json or a subfolder with package.json/app.py"
    exit 1
fi
APP_NAME=${APP_NAME:-demo-app}
if pm2 describe "$APP_NAME" >/dev/null 2>&1; then
    pm2 restart "$APP_NAME" --update-env || exit 1
else
    pm2 start ecosystem.config.js --update-env || exit 1
fi
pm2 save --force >/dev/null 2>&1 || true
exit 0
