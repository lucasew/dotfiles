#!/usr/bin/env bash

# Centralized error reporting
# shellcheck source=src/lib/error_reporting.sh
source "$(dirname "${BASH_SOURCE[0]}")/error_reporting.sh" || return 1

# Core logic for bringing dotfiles
# Extracted to isolate core logic from execution list.
# Refactoring Pattern: Extract Method. Principle: Single Responsibility Principle.
# Reason: Separating the mechanism of copying files from the script that defines which files to copy
# makes both easier to maintain and understand.
bring_file() {
    local srcfile="$1"
    local project_root="$2"

    if [[ -z "$srcfile" ]]; then
        report_error "No source file provided to bring_file."
        return 1
    fi

    if [[ -z "$project_root" ]]; then
        report_error "No project root provided to bring_file."
        return 1
    fi

    # Strip leading slash if present to make path relative to project root correctly
    local relative_src="${srcfile#/}"
    local relative_srcdir
    relative_srcdir="$(dirname "$relative_src")"

    local destdir
    if [[ "$relative_srcdir" == "." ]]; then
        destdir="${project_root}"
    else
        destdir="${project_root}/${relative_srcdir}"
    fi

    mkdir -p "$destdir" || {
        report_error "Failed to create directory $destdir for $srcfile"
        return 1
    }

    # We use -r just in case the src is actually a directory (though bring script typically expects files)
    cp -r "$srcfile" "$destdir" || {
        report_error "Failed to copy $srcfile to $destdir"
        return 1
    }

    echo "Copiado $srcfile para $destdir"
}
