#!/usr/bin/env bash

# Find repo root to source lib
SCRIPT_DIR="$(dirname "$(realpath "$0")")"
if [ -f "$SCRIPT_DIR/../../../../../lib/error_reporting.sh" ]; then
    source "$SCRIPT_DIR/../../../../../lib/error_reporting.sh"
else
    report_error() {
        local exit_code=$1
        local context=$2
        if [ "$exit_code" -ne 0 ]; then
            echo "[ERROR] $context (Exit code: $exit_code)" >&2
        fi
        return "$exit_code"
    }
fi

main() {
    local target_file="$1"

    if [ -z "$target_file" ]; then
        echo "Usage: $0 <filename>" >&2
        return 1
    fi

    local destination_directory="/media/dados/Jogos/WINE"

    mv -v "$target_file" "$destination_directory"
    local mv_status=$?
    report_error $mv_status "Failed to move $target_file to $destination_directory" || return $mv_status

    ln -s "$destination_directory/$target_file" "$target_file"
    local ln_status=$?
    report_error $ln_status "Failed to create symlink for $target_file to $destination_directory" || return $ln_status
}

main "$@"
