#!/usr/bin/env bash
# Show pm2 status and recent logs for the app.
[ -f .env ] && export $(grep -v '^#' .env | xargs) || true
APP_NAME=${APP_NAME:-demo-app}
if command -v pm2 >/dev/null 2>&1 && pm2 describe "$APP_NAME" >/dev/null 2>&1; then
    pm2 status "$APP_NAME"
    echo "=== pm2 logs ($APP_NAME) ==="
    pm2 logs "$APP_NAME" --lines 25 --nostream 2>/dev/null || true
else
    echo "App Status: STOPPED ($APP_NAME not running under pm2)"
fi
[ -f app.log ] && echo "=== app.log (legacy) ===" && tail -n 25 app.log
exit 0
