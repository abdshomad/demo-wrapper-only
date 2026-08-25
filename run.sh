#!/usr/bin/env bash
[ -f .env ] && export $(grep -v '^#' .env | xargs)
[ -n "$PORT" ] && ln -sf run.sh "run-${PORT}.sh" 2>/dev/null || true
PID_FILE=".app.pid"
if [ -f package.json ]; then
    npm start > app.log 2>&1 & echo $! > "$PID_FILE"
else
    for sub in */; do
        [ -d "$sub" ] && [ -f "${sub}package.json" ] && (cd "$sub" && npm start > ../app.log 2>&1 & echo $! > "../${PID_FILE}") && break
        [ -d "$sub" ] && [ -f "${sub}app.py" ] && (cd "$sub" && python3 app.py > ../app.log 2>&1 & echo $! > "../${PID_FILE}") && break
    done
fi
exit 0
