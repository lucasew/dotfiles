#!/usr/bin/env bash

# shellcheck source=src/lib/error_reporting.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/error_reporting.sh" || exit 1
# shellcheck source=src/lib/bring_core.sh
source "$(dirname "${BASH_SOURCE[0]}")/lib/bring_core.sh" || { report_error "Failed to source bring_core.sh"; exit 1; }

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

function bring() {
    bring_file "$1" "$PROJECT_ROOT/src" || report_error "Failed to bring $1"
}

# bring /etc/systemd/system/screenlock.service
# bring /media/dados/Lucas/BACKUP/borg_backup.sh
# bring /media/dados/Lucas/BACKUP/phone_backup.sh
# bring /media/dados/Lucas/BACKUP/update_script.sh
bring /usr/bin/projetor
bring /usr/bin/xlock
bring ~/.bashrc
bring ~/.config/betterlockscreenrc
bring ~/.config/compton.conf
bring ~/.config/i3/config
bring ~/.config/i3/wall.png
bring ~/.config/nvim/init.vim
bring ~/.config/polybar/config
bring ~/.config/rofi
bring ~/.tmux.conf
bring ~/.zshrc
bring ~/environment
bring ~/.PlayOnLinux/wineprefix/liberar_barra.sh

pacman -Qe > "$PROJECT_ROOT/pacman-explicit.txt" || report_error "Failed to generate pacman-explicit.txt"
