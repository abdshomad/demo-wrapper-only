#!/usr/bin/env bash
if [ -f .app.pid ] && kill -0 $(cat .app.pid) 2>/dev/null; then
    echo "App Status: RUNNING (PID: $(cat .app.pid))"
else
    echo "App Status: STOPPED"
fi
[ -f app.log ] && echo "=== app.log ===" && tail -n 25 app.log
exit 0
