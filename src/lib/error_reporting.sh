#!/usr/bin/env bash

# Centralized error reporting function
report_error() {
    local exit_code=$?
    local msg="$1"

    # If explicitly passed an exit code as $2, use it
    if [[ -n "$2" ]]; then
        exit_code=$2
    elif [[ $exit_code -eq 0 ]]; then
        # Default to 1 if we were called when previous command succeeded
        # (e.g. from an if block)
        exit_code=1
    fi

    # If Sentry or another tool is added later, it should be hooked here.
    # For now, we log with context to stderr.
    echo "ERROR: $msg (exit code: $exit_code)" >&2

    # Optional: Log to a file if needed
    # echo "$(date -u +'%Y-%m-%dT%H:%M:%SZ') ERROR: $msg (exit code: $exit_code)" >> /tmp/dotfiles_error.log

    return "$exit_code"
}
