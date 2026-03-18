#!/usr/bin/env bash

# Centralized error reporting
function report_error() {
    local message="$1"
    echo "[ERROR] $message" >&2
}
