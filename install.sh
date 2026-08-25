#!/usr/bin/env bash
[ -f package.json ] && npm install
for sub in */; do [ -d "$sub" ] && [ -f "${sub}package.json" ] && (cd "$sub" && npm install); done
exit 0
