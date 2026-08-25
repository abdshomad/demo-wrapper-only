#!/usr/bin/env bash
[ -f .app.pid ] && kill $(cat .app.pid) 2>/dev/null || true
rm -f .app.pid
exit 0
