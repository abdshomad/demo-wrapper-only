# demo-wrapper-only

Parent repository for running demo applications via Docker Compose. Application code lives in Git submodules; this repo provides stack orchestration, configuration, and tooling.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and Docker Compose
- Git (with submodule support)

## Quick Start

1. Clone with submodules: `git submodule update --init --recursive`
2. Configure `.env` (e.g. `PORT=3000`) and ensure `docker-compose.yml` is present.
3. Run **install** → **start** → **monitor** to verify the stack boots.

| Action | Linux / macOS | Windows |
|--------|---------------|---------|
| Install | `./install.sh` | `install.bat` |
| Start | `./start.sh` | `start.bat` |
| Stop | `./stop.sh` | `stop.bat` |
| Monitor | `./monitor.sh` | `monitor.bat` |

Optional: `restart.{sh,bat}` calls stop then start. Started processes run in the background.

## Submodules

**Do not edit files inside submodule directories from this repo.** Update content upstream, then bump the tracked commit reference here.

## Testing & Issues

- **E2E screenshots**: `screenshots/<module_number>_<module_name>/<function_number>_<function_name>/<step_number>_<before|after>_<action_name>.png`
- **Blocking issues**: record in `issues/` with numbered filenames.

## AI Agents

See [AGENTS.md](AGENTS.md).
