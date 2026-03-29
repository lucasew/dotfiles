#!/usr/bin/env bash

# Centralized error reporting function
report_error() {
	local error_msg="$1"
	local exit_code="${2:-1}"
	local line_num="${3:-unknown}"

	# Log to stderr
	echo "ERROR (line $line_num, code $exit_code): $error_msg" >&2

	# Optional Sentry integration or other tracking could be added here
	# e.g., if [[ -n "$SENTRY_DSN" ]]; then ... fi
}
