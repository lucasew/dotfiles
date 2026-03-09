#!/usr/bin/env bash

# Centralized error reporting function
report_error() {
    local exit_code=$1
    local context=$2
    if [ "$exit_code" -ne 0 ]; then
        echo "[ERROR] $context (Exit code: $exit_code)" >&2
        # In the future, this could report to Sentry via curl
    fi
    return "$exit_code"
}
