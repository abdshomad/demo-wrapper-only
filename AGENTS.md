# Demo Wrapper Agent — Guidelines

## First Steps

Before planning, specs, UI, or features:

1. Create repo-root stack scripts if missing (see table below).
2. Add `docker-compose.yml` and `.env` (e.g. `PORT=3000`).
3. Run `install` → `start` → `monitor` to verify the stack boots.

| Action | Linux / macOS | Windows |
|--------|---------------|---------|
| Install | `install.sh` | `install.bat` |
| Start | `start.sh` | `start.bat` |
| Stop | `stop.sh` | `stop.bat` |
| Monitor | `monitor.sh` | `monitor.bat` |

Scripts should be short one-liners; started processes run in the **background**. Optional: `restart.{sh,bat}` calls stop then start.

## Submodules

> [!IMPORTANT]
> **Never edit, update, delete, or commit changes inside Git submodules.** Update upstream or bump the tracked commit reference in this repo only.

## E2E Testing

Verify features with browser tools. Save screenshots to:

`screenshots/<module_number>_<module_name>/<function_number>_<function_name>/<step_number>_<before|after>_<action_name>.png`

## Issues

Record blocking issues in `/issues/` with numbered filenames.
