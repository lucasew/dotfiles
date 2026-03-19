# Project Conventions

- Linting and formatting: Enforced using `workspaced` (sourced from github:lucasew/workspaced, not npm).
- Tool versions: Always pin to specific versions in `mise.toml`. Never use `latest` or `lts`.
- Error Handling: All error paths must funnel through the centralized `report_error` function in `src/lib/error_reporting.sh`. No empty catch blocks, and no direct `console.error` calls.
- Task execution: Use `mise`.
- Directories: Keep files organized logically. Example: dotfile configs and execution scripts inside `src/`. Allowed refactor paths: `src/**`, `tests/**`, `.jules/**`. Forbidden: `install-mise.sh`, `bin/**`, `tmp/**`.
- CI: Executed via `.github/workflows/autorelease.yml` running `mise run ci`.
