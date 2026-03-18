#!/usr/bin/env bash
source lib/error_reporting.sh || true

function bring() {
    srcdir="$(dirname "$1")"
    destdir=".$srcdir"
    srcfile="$1"
    mkdir -p "$destdir" || { report_error "Failed to create directory $destdir"; return 1; }
    cp "$srcfile" "$destdir" -r && echo "Copiado $srcfile para $destdir" || { report_error "Failed to copy $srcfile to $destdir"; return 1; }
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

pacman -Qe > pacman-explicit.txt || report_error "Failed to execute pacman -Qe"
