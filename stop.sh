#!/usr/bin/env bash
# Stop the pm2-managed app (plus legacy PID cleanup).
[ -f .env ] && export $(grep -v '^#' .env | xargs) || true
APP_NAME=${APP_NAME:-demo-app}
if command -v pm2 >/dev/null 2>&1; then
    pm2 stop "$APP_NAME" 2>/dev/null || true
    pm2 delete "$APP_NAME" 2>/dev/null || true
    pm2 save --force >/dev/null 2>&1 || true
fi
[ -f .app.pid ] && kill $(cat .app.pid) 2>/dev/null || true
rm -f .app.pid
exit 0
