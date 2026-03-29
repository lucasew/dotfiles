#!/usr/bin/env bash

set -euo pipefail

# Determine script directory to source the error reporting script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=src/lib/error_reporting.sh
source "${SCRIPT_DIR}/lib/error_reporting.sh" || {
	echo "ERROR: Failed to source error_reporting.sh" >&2
	exit 1
}

bring() {
	local srcfile="${1:-}"

	if [[ -z "$srcfile" ]]; then
		report_error "bring() requires a file path argument" 1 "$LINENO"
		return 1
	fi

	local srcdir
	srcdir="$(dirname "$srcfile")"
	local destdir=".$srcdir"

	mkdir -p "$destdir" || {
		report_error "Failed to create directory $destdir" "$?" "$LINENO"
		return 1
	}
	cp -r "$srcfile" "$destdir" || {
		report_error "Failed to copy $srcfile to $destdir" "$?" "$LINENO"
		return 1
	}

	echo "Copiado $srcfile para $destdir"
}

main() {
	# bring /etc/systemd/system/screenlock.service
	# bring /media/dados/Lucas/BACKUP/borg_backup.sh
	# bring /media/dados/Lucas/BACKUP/phone_backup.sh
	# bring /media/dados/Lucas/BACKUP/update_script.sh
	bring /usr/bin/projetor || true
	bring /usr/bin/xlock || true
	bring ~/.bashrc || true
	bring ~/.config/betterlockscreenrc || true
	bring ~/.config/compton.conf || true
	bring ~/.config/i3/config || true
	bring ~/.config/i3/wall.png || true
	bring ~/.config/nvim/init.vim || true
	bring ~/.config/polybar/config || true
	bring ~/.config/rofi || true
	bring ~/.tmux.conf || true
	bring ~/.zshrc || true
	bring ~/environment || true
	bring ~/.PlayOnLinux/wineprefix/liberar_barra.sh || true

	pacman -Qe >pacman-explicit.txt || report_error "Failed to generate pacman-explicit.txt" "$?" "$LINENO"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	main "$@"
fi
