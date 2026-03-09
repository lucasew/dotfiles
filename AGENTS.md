# Agent Guidelines

## Directory Layout
* `home/` -> User configuration files and dotfiles.
* `usr/` -> System-wide binaries and executable scripts.
* `lib/` -> Shared utilities, such as centralized error reporting.

## Error Handling
* **Centralized Error Reporting:** All errors must route through a single error-reporting function. Empty `catch` blocks or swallowed errors are strictly prohibited.
* For bash scripts, source `lib/error_reporting.sh` and use the `report_error` function on failure.

## Refactoring Philosophy
* Colocate files that change together.
* Avoid magic numbers; extract them to named constants.
* Extract repeated logic into loops or functions (Rule of Three).
* Explicitly cite Refactoring (Fowler) or Clean Code (Martin) when extracting classes/methods in PRs.

## Task Execution
* Tasks must exclusively depend on wildcards like `[task]:*` in `mise.toml`.
* `mise` is non-negotiable for task execution. Pin `mise` tools to specific versions.
