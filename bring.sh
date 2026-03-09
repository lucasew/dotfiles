#!/usr/bin/env bash

source "$(dirname "$0")/lib/error_reporting.sh" || {
    echo "Failed to load error_reporting.sh" >&2
    exit 1
}

function bring() {
    local source_file="$1"
    local source_directory
    source_directory="$(dirname "$source_file")"
    local destination_directory=".$source_directory"

    mkdir -p "$destination_directory"
    local mkdir_status=$?
    report_error $mkdir_status "Failed to create directory: $destination_directory" || return $mkdir_status

    cp -r "$source_file" "$destination_directory"
    local cp_status=$?
    report_error $cp_status "Failed to copy $source_file to $destination_directory" || return $cp_status

    echo "Copiado $source_file para $destination_directory"
}

TARGETS=(
    # "/etc/systemd/system/screenlock.service"
    # "/media/dados/Lucas/BACKUP/borg_backup.sh"
    # "/media/dados/Lucas/BACKUP/phone_backup.sh"
    # "/media/dados/Lucas/BACKUP/update_script.sh"
    "/usr/bin/projetor"
    "/usr/bin/xlock"
    ~/.bashrc
    ~/.config/betterlockscreenrc
    ~/.config/compton.conf
    ~/.config/i3/config
    ~/.config/i3/wall.png
    ~/.config/nvim/init.vim
    ~/.config/polybar/config
    ~/.config/rofi
    ~/.tmux.conf
    ~/.zshrc
    ~/environment
    ~/.PlayOnLinux/wineprefix/liberar_barra.sh
)

for target in "${TARGETS[@]}"; do
    bring "$target"
done

pacman -Qe > pacman-explicit.txt
pacman_status=$?
report_error "$pacman_status" "Failed to dump pacman packages"
